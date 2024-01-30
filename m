Return-Path: <linux-kernel+bounces-44002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1A841C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F376287C38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949C4C60E;
	Tue, 30 Jan 2024 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwq0NePn"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DC383B8;
	Tue, 30 Jan 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596806; cv=none; b=nYf7NuApL7MchPmNhA4yedrbqEzUeO1YhzY+5LI5j9+6HuVZA5wqYTZYAP0FpgoJ/EZwdo+OIo5H7K3YQvJW6JFCKrBDkntL8qfifKgMs5dvX+d/7PkVqjhISLNyJrVCI8wewRHrdxrmSb9nsvjHUQWRpJ3tcAQqK4lMi/8AkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596806; c=relaxed/simple;
	bh=716VcFCrc96zh/d9qQ+l7t+2hDugCfOleWriKkbgX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfNCHSEi9DkJuVrgQFC89+wzdgMsOWNlEzji/RFkyiOBxoaaX0a/HFqGS0fFRDH1dEFxii5gwX5XWul9hISSznJuZt57uCTDpcV7luPlAJcGLuQRFpozZ5lEMk6Zkka0ECVCDI8pSHLuQcZAe4NDQUDq7emPoJyi5SEepl2MeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwq0NePn; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc61fd6ba8cso2560780276.3;
        Mon, 29 Jan 2024 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706596803; x=1707201603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TiSgQVYl+6WeHdWJpsOrkNIjafm2UeYrW+RuoFAKWI=;
        b=hwq0NePno0Dd491YXdN5SLnVJWZ+YRvWcMZMdk9p4k1QdfaX926V3GiwON2EV/vVC2
         xrRvScUHN9qoqTDxuaydP13tUAJSGlTgWtzQ8q0pZiIl24Fxk6aeSR5PL/axiwJaVdh/
         gpXbLMHH9z3g04OuLNcmVvMS9yhHCMIlxAmofAn4Qni0JyDZvyeTcpxEwQwBUqHVspD5
         zK8ZLnPme07/H1CKfLq7z/YXPWrU8obv1a8yV+OYatB45gyyDnnBtIbSHTi1URxCQ5tP
         nwQXbsFEPm9e3t14PLZzxJ6GsdN84XMJWENx56Juxmz1bgLUkrTk876t+d1NPdq8swso
         aSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596803; x=1707201603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TiSgQVYl+6WeHdWJpsOrkNIjafm2UeYrW+RuoFAKWI=;
        b=E+bkd3cqEX66NMTOeKeci8n5G7CkxRXnToBHWjJWbyL4HhlwC9PcVUtwdxt+u/WpSP
         XFq9bBgkb3iYRGwXt+V73velyWYODvgeAuoOoa+SXLYRBHTkKhD4WRExwUfYAfpBgdPi
         ZXpfNyozLfJ1nTEu+0D1jsNXdztWw76wjZdcw1Mtha3CKQ7tjT4k5pYJq4gpMogz50sw
         FtPCAVUhVG7tpn7ZXpflvTHJ4r3/UC3y4r6c3wtGSrU1Qoe22OkKOr8XLkn3mS0n9djm
         uUaVJKvnGLXHQNHbk+1gTAWZ/ONAiF1yVn7DhtGNPj3nHvS31OrPZQ6sg2tiF9tw6x5g
         g1/Q==
X-Gm-Message-State: AOJu0YzWkbklHvs3PhgKeOO5tIt1zbdNCa37q8IeioR+z71LhAyzod/G
	gcRsQT9cV7kcRoW3CPY6Bqg6Zj91FjvGXlm2d4t5DB7zEIU7uApjAUmThSGu2VArSEIEi9sqSK3
	OxUni6nYzT9fDsHbuDzlO0cWq3G8=
X-Google-Smtp-Source: AGHT+IEVcY1bCYTaq7+cH14tX1P+pfYMIg/1xISU6SDKr7XpLFutk/qNcYcYORcWOMzNZ2KdvM8sHV9oQKrP/ZFfZFQ=
X-Received: by 2002:a25:e301:0:b0:dc2:53b0:6353 with SMTP id
 z1-20020a25e301000000b00dc253b06353mr3375393ybd.38.1706596803254; Mon, 29 Jan
 2024 22:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127140747.905552-1-hayatake396@gmail.com> <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
In-Reply-To: <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Tue, 30 Jan 2024 15:39:52 +0900
Message-ID: <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, laforge@gnumonks.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcin-san
Thanks for your review!

> Do I understand correctly that all gtpu* include TEID? Maybe write it her=
e.
Yes, that's correct.

> It would be nice to see a link to the patch that added GTP and 'e' flag s=
upport
to ethtool itself ("ethtool: add support for rx-flow-hash gtp").
I will send you the link.
The one I sent earlier was outdated, so I've updated it to match this patch=
.
https://lore.kernel.org/netdev/20240130053742.946517-1-hayatake396@gmail.co=
m/

> gtpc(4|6) doesn't include TEID, so what is its purpose?
In GTPC communication, there is no TEID in the CSR (Create Session Request)=
.
Therefore, there are cases of GTPC that do not include TEID.

> s/TEID(4byte)/TEID (4bytes)/
> Also, I think two newlines should remain here.
I will correct the TEID notation in the next patch!

> I'm a bit confused... I thought GTPC_V4_FLOW doesn't have TEID, and
> GTPC_TEID_V4_FLOW does. So why do we set ICE_FLOW_SEG_HDR_GTPC_TEID here,=
 and
> why is GTPC_TEID_V4_FLOW missing from this switch case? It also seems to =
be
> missing from ice_parse_hash_flds().
Oh, sorry about that! It seems I accidentally included the wrong thing
during the rebase process.
I will correct it in the next patch.

> What do you mean by "from before"? The GTP* defines above?
I apologize for the unclear writing.
By "the difference from before," I specifically meant the difference
from GTPU_EH_V(4|6)_FLOW.
The PSC included in the Extension Header distinguishes between UL/DL.
By using this option, it becomes possible to process including UL/DL.

Marcin-san, thank you very much for your feedback! I will reflect your
comments in the next patch.

Takeru

2024=E5=B9=B41=E6=9C=8829=E6=97=A5(=E6=9C=88) 23:23 Marcin Szycik <marcin.s=
zycik@linux.intel.com>:

>
>
>
> On 27.01.2024 15:07, Takeru Hayasaka wrote:
> > This is a patch that enables RSS functionality for GTP packets using et=
htool.
> >
> > A user can include her TEID and make RSS work for GTP-U over IPv4 by do=
ing the following:
> > `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> >
> > In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)=
e,gtpu(4|6)u, and gtpu(4|6)d.
> >
> > gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format=
 does not include a TEID.
> > gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format t=
hat includes a TEID.
> > gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> > gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> > gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U exte=
nded header includes Uplink, applicable to both IPv4 and IPv6.
> > gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Dow=
nlink, for both IPv4 and IPv6.
>
> Do I understand correctly that all gtpu* include TEID? Maybe write it her=
e.
>
> > GTP generates a flow that includes an ID called TEID to identify the tu=
nnel. This tunnel is created for each UE (User Equipment).By performing RSS=
 based on this flow, it is possible to apply RSS for each communication uni=
t from the UE.Without this, RSS would only be effective within the range of=
 IP addresses.
> > For instance, the PGW can only perform RSS within the IP range of the S=
GW.Problematic from a load distribution perspective, especially if there's =
a bias in the terminals connected to a particular base station.This case ca=
n be solved by using this patch.
>
> It would be nice to see a link to the patch that added GTP and 'e' flag s=
upport
> to ethtool itself ("ethtool: add support for rx-flow-hash gtp").
>
> > Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> > ---
> > (I have resent the submission after making revisions based on Paul's ad=
vice.)
> > Sorry for the delay.
> > I've been swamped with other work and fell behind.
> > Since Harald has been supportive of the basic structure in the previous=
 patch review, I've kept it largely unchanged but added some comments and d=
ocumentation.
> > I would appreciate it if you could review it again.
>
> Please wrap all text to 80 columns and add missing spaces after ',' and '=
'.
>
> >  .../device_drivers/ethernet/intel/ice.rst     | 23 ++++--
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 74 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_flow.h     | 22 ++++++
> >  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 ++++++++++
> >  include/uapi/linux/ethtool.h                  | 41 ++++++++++
> >  5 files changed, 192 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice=
rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > index 5038e54586af..6bc1c6f10617 100644
> > --- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > +++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > @@ -368,16 +368,29 @@ more options for Receive Side Scaling (RSS) hash =
byte configuration.
> >    # ethtool -N <ethX> rx-flow-hash <type> <option>
> >
> >    Where <type> is:
> > -    tcp4  signifying TCP over IPv4
> > -    udp4  signifying UDP over IPv4
> > -    tcp6  signifying TCP over IPv6
> > -    udp6  signifying UDP over IPv6
> > +    tcp4    signifying TCP over IPv4
> > +    udp4    signifying UDP over IPv4
> > +    gtpc4   signifying GTP-C over IPv4
> > +    gtpc4t  signifying GTP-C (include TEID) over IPv4
> > +    gtpu4   signifying GTP-U over IPV4
> > +    gtpu4e  signifying GTP-U and Extension Header over IPV4
> > +    gtpu4u  signifying GTP-U PSC Uplink over IPV4
> > +    gtpu4d  signifying GTP-U PSC Downlink over IPV4
> > +    tcp6    signifying TCP over IPv6
> > +    udp6    signifying UDP over IPv6
> > +    gtpc6   signifying GTP-C over IPv6
> > +    gtpc6t  signifying GTP-C (include TEID) over IPv6
> > +    gtpu6   signifying GTP-U over IPV6
> > +    gtpu6e  signifying GTP-U and Extension Header over IPV6
> > +    gtpu6u  signifying GTP-U PSC Uplink over IPV6
> > +    gtpu6d  signifying GTP-U PSC Downlink over IPV6
> > +
> >    And <option> is one or more of:
> >      s     Hash on the IP source address of the Rx packet.
> >      d     Hash on the IP destination address of the Rx packet.
> >      f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet=
.
> >      n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet=
.
> > -
> > +    e     Hash on GTP Packet on TEID(4byte) of the Rx packet.
>
> gtpc(4|6) doesn't include TEID, so what is its purpose?
> s/TEID(4byte)/TEID (4bytes)/
> Also, I think two newlines should remain here.
>
> >  Accelerated Receive Flow Steering (aRFS)
> >  ----------------------------------------
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net=
/ethernet/intel/ice/ice_ethtool.c
> > index a19b06f18e40..eb5f490c6127 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -2486,6 +2486,21 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *=
nfc)
> >       case SCTP_V4_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4;
> >               break;
> > +     case GTPU_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPC_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV4;
>
> I'm a bit confused... I thought GTPC_V4_FLOW doesn't have TEID, and
> GTPC_TEID_V4_FLOW does. So why do we set ICE_FLOW_SEG_HDR_GTPC_TEID here,=
 and
> why is GTPC_TEID_V4_FLOW missing from this switch case? It also seems to =
be
> missing from ice_parse_hash_flds().
>
> > +             break;
> > +     case GTPU_EH_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPU_UL_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPU_DL_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V4;
> > +             break;
> >       case TCP_V6_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6;
> >               break;
> > @@ -2495,6 +2510,21 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *=
nfc)
> >       case SCTP_V6_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV6;
> >               break;
> > +     case GTPU_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPC_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV6;
>
> (same question for v6)
>
> > +             break;
> > +     case GTPU_EH_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPU_UL_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPU_DL_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V6;
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -2518,6 +2548,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               case TCP_V4_FLOW:
> >               case UDP_V4_FLOW:
> >               case SCTP_V4_FLOW:
> > +             case GTPU_V4_FLOW:
> > +             case GTPC_V4_FLOW:
> > +             case GTPU_EH_V4_FLOW:
> > +             case GTPU_UL_V4_FLOW:
> > +             case GTPU_DL_V4_FLOW:
> >                       if (nfc->data & RXH_IP_SRC)
> >                               hfld |=3D ICE_FLOW_HASH_FLD_IPV4_SA;
> >                       if (nfc->data & RXH_IP_DST)
> > @@ -2526,6 +2561,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               case TCP_V6_FLOW:
> >               case UDP_V6_FLOW:
> >               case SCTP_V6_FLOW:
> > +             case GTPU_V6_FLOW:
> > +             case GTPC_V6_FLOW:
> > +             case GTPU_EH_V6_FLOW:
> > +             case GTPU_UL_V6_FLOW:
> > +             case GTPU_DL_V6_FLOW:
> >                       if (nfc->data & RXH_IP_SRC)
> >                               hfld |=3D ICE_FLOW_HASH_FLD_IPV6_SA;
> >                       if (nfc->data & RXH_IP_DST)
> > @@ -2564,6 +2604,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               }
> >       }
> >
> > +     if (nfc->data & RXH_GTP_TEID) {
> > +             switch (nfc->flow_type) {
> > +             case GTPC_TEID_V4_FLOW:
> > +             case GTPC_TEID_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPC_TEID;
> > +                     break;
> > +             case GTPU_V4_FLOW:
> > +             case GTPU_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_IP_TEID;
> > +                     break;
> > +             case GTPU_EH_V4_FLOW:
> > +             case GTPU_EH_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_EH_TEID;
> > +                     break;
> > +             case GTPU_UL_V4_FLOW:
> > +             case GTPU_UL_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_UP_TEID;
> > +                     break;
> > +             case GTPU_DL_V4_FLOW:
> > +             case GTPU_DL_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_DWN_TEID;
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> > +
> >       return hfld;
> >  }
> >
> > @@ -2676,6 +2743,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct=
 ethtool_rxnfc *nfc)
> >           hash_flds & ICE_FLOW_HASH_FLD_UDP_DST_PORT ||
> >           hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT)
> >               nfc->data |=3D (u64)RXH_L4_B_2_3;
> > +
> > +     if (hash_flds & ICE_FLOW_HASH_FLD_GTPC_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
> > +             nfc->data |=3D (u64)RXH_GTP_TEID;
> >  }
> >
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/et=
hernet/intel/ice/ice_flow.h
> > index ff82915ab497..9d6803d68a45 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.h
> > @@ -66,6 +66,20 @@
> >       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_EH_TEID | \
> >        ICE_FLOW_HASH_GTP_U_EH_QFI)
> >
> > +#define ICE_FLOW_HASH_GTP_U_UP \
> > +     (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID))
> > +#define ICE_FLOW_HASH_GTP_U_DWN \
> > +     (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID))
> > +
> > +#define ICE_FLOW_HASH_GTP_U_IPV4_UP \
> > +     (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_UP)
> > +#define ICE_FLOW_HASH_GTP_U_IPV6_UP \
> > +     (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_UP)
> > +#define ICE_FLOW_HASH_GTP_U_IPV4_DWN \
> > +     (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_DWN)
> > +#define ICE_FLOW_HASH_GTP_U_IPV6_DWN \
> > +     (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_DWN)
> > +
> >  #define ICE_FLOW_HASH_PPPOE_SESS_ID \
> >       (BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID))
> >
> > @@ -242,6 +256,14 @@ enum ice_flow_field {
> >  #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT      \
> >       BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
> >
> > +#define ICE_FLOW_HASH_FLD_GTPC_TEID  BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_T=
EID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_IP_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_EH_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_EH_QFI BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_=
EH_QFI)
> > +#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_UP_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID \
> > +     BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
> > +
> >  /* Flow headers and fields for AVF support */
> >  enum ice_flow_avf_hdr_field {
> >       /* Values 0 - 28 are reserved for future use */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/eth=
ernet/intel/ice/ice_lib.c
> > index 9be724291ef8..72f737c6c9ba 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1618,6 +1618,25 @@ static const struct ice_rss_hash_cfg default_rss=
_cfgs[] =3D {
> >        */
> >       {ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4,
> >               ICE_HASH_SCTP_IPV4, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc4 with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_IPV4, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc4t with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> > +     /* configure RSS for gtpu4 with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu4e with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_EH, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu4u with input set IPv4 src/dst */
> > +     { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_UP, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu4d with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
> > +
> >       /* configure RSS for tcp6 with input set IPv6 src/dst, TCP src/ds=
t */
> >       {ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6,
> >                               ICE_HASH_TCP_IPV6,  ICE_RSS_ANY_HEADERS, =
false},
> > @@ -1632,6 +1651,24 @@ static const struct ice_rss_hash_cfg default_rss=
_cfgs[] =3D {
> >       /* configure RSS for IPSEC ESP SPI with input set MAC_IPV4_SPI */
> >       {ICE_FLOW_SEG_HDR_ESP,
> >               ICE_FLOW_HASH_ESP_SPI, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc6 with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_IPV6, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc6t with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> > +     /* configure RSS for gtpu6 with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu6e with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_EH, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu6u with input set IPv6 src/dst */
> > +     { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_UP, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu6d with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.=
h
> > index 06ef6b78b7de..b3d67f3aa948 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -2023,6 +2023,46 @@ static inline int ethtool_validate_duplex(__u8 d=
uplex)
> >  #define      IPV4_FLOW       0x10    /* hash only */
> >  #define      IPV6_FLOW       0x11    /* hash only */
> >  #define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > +/* Used for GTP-U IPv4 and IPv6.
> > + * The format of GTP packets only includes
> > + * elements such as TEID and GTP version.
> > + * It is primarily intended for data communication of the UE.
> > + */
>
> Maybe add newlines before these comment blocks for better readability.
>
> > +#define GTPU_V4_FLOW 0x13    /* hash only */
> > +#define GTPU_V6_FLOW 0x14    /* hash only */
> > +/* Use for GTP-C IPv4 and v6.
> > + * The format of these GTP packets does not include TEID.
> > + * Primarily expected to be used for communication
> > + * to create sessions for UE data communication,
> > + * commonly referred to as CSR (Create Session Request).
> > + */
> > +#define GTPC_V4_FLOW 0x15    /* hash only */
> > +#define GTPC_V6_FLOW 0x16    /* hash only */
> > +/* Use for GTP-C IPv4 and v6.
> > + * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> > + * After session creation, it becomes this packet.
> > + * This is mainly used for requests to realize UE handover.
> > + */
> > +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> > +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */
> > +/* Use for GTP-U and extended headers for the PDU session container(PS=
C).
>
> Missing space before (
>
> > + * The format of these GTP packets includes TEID and QFI.
> > + * In 5G communication using UPF (User Plane Function),
> > + * data communication with this extended header is performed.
> > + */
> > +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> > +#define GTPU_EH_V6_FLOW 0x1a /* hash only */
> > +/* Use for GTP-U IPv4 and v6 PDU session container(PSC) extended heade=
rs.
>
> Missing space before (
>
> > + * The difference from before is distinguishing based on the PSC.
>
> What do you mean by "from before"? The GTP* defines above?
>
> > + * There are differences in the data included based on Downlink/Uplink=
,
> > + * and can be used to distinguish packets.
> > + * The functions described so far are useful when you want to
> > + * handle communication from the mobile network in UPF, PGW, etc.
> > + */
> > +#define GTPU_UL_V4_FLOW 0x1b /* hash only */
> > +#define GTPU_UL_V6_FLOW 0x1c /* hash only */
> > +#define GTPU_DL_V4_FLOW 0x1d /* hash only */
> > +#define GTPU_DL_V6_FLOW 0x1e /* hash only */
> >  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> >  #define      FLOW_EXT        0x80000000
> >  #define      FLOW_MAC_EXT    0x40000000
> > @@ -2037,6 +2077,7 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
> >  #define      RXH_IP_DST      (1 << 5)
> >  #define      RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> >  #define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> > +#define      RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
> >  #define      RXH_DISCARD     (1 << 31)
> >
> >  #define      RX_CLS_FLOW_DISC        0xffffffffffffffffULL
>
> Thanks,
> Marcin

