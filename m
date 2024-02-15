Return-Path: <linux-kernel+bounces-66439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC04855CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CEF1F21645
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2713AD1;
	Thu, 15 Feb 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PocHuK2V"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91213FE2;
	Thu, 15 Feb 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986678; cv=none; b=oHn1Fe2eOUAeNY9Gf8Vj6upH+OylzO/Ai0PfYEKDfFs5XtuKsUiNajpQwagy9QQOdoVcBwD0zks+ybS00/YeuJD8WnZ+vDsIFWj7ZlVq8njHdxkQRWqu95KFDcpgqRbGi0JgyRYBp7piVrP2cmPqdAHZwpUEuXY6aoTeVN602CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986678; c=relaxed/simple;
	bh=t7mzthGHbyt1OVv3A4X+IagMYD4/PQfkYEzh2Facv+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAX+bBCW1PcsTzjLQRTVSpaHQAFhM9YQ56h1DQAX5JV1I3rKJuqD8hpYW6eAh51LcWr0qLKf5GCqT8cfoQtMVeuWYJM97/shnBGVOyn8XZ1RE+OakjNLiYzasVQsojCI8uDxQyM2cU9njG0S4IvmrZ+7FhX6tJxL0M2VNi0JAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PocHuK2V; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1228650276.1;
        Thu, 15 Feb 2024 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707986676; x=1708591476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5r7xNJzxDUVOsbXK9XgQNpV+8ENxUZtBQk8JzTa8JU=;
        b=PocHuK2VoAYP6LJLb6SjC6m5vwxo2IXWqGYTaShvwycEeAga5S+GMKSLLxK8ReQZWf
         uy0uUt4SuZA5CqREdVNkRm2rTq5dF25g10anUp1UNKrpXZ5CWWcqINORUTfpRx0OXBXE
         yRud9csy4aAlttEM0/Ycp6eTt5T5waJqCsuLu119dM516Ew48sbhuEFlv712zE1XDG4D
         LCagCW2Lgdi3LBKWQgJonEfHvxlUkhokCArIixVyIgP7a1D1S1pJeolPajVXTszIptDj
         +vwcIjYymig7XsyJaRPbKHqHa48npekI85YMIdI7i+s+rqs2kEgNGkdUB1X0laOzXngy
         n22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986676; x=1708591476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5r7xNJzxDUVOsbXK9XgQNpV+8ENxUZtBQk8JzTa8JU=;
        b=qb4tyL6/e1u//t00g1Bz6ywYblvqWVTZ7qKqSxaJXqZ4DRe8sqQF9RgINYPkX+jA1C
         EWMRIVAtKN/6ASqYdAw80N5Y1LWTI10dYPo0vZa3LF5wGm70CrWvlHTzGznLWQGdtnSK
         sVr4iBJJwdL2KpOG3mY2xIFSVe6sSMpufXV4Wxn2o8E6C9DZoqbNPpU5zBVvFeufH+aG
         aT7laXUv0Ax/vQcSrrF7En5hpzim5oDiWGiyqOR3vjmU+u0uYI0Zo4BUjiKvtKrBApvW
         21wlmQ0KEnYz6rwHGrMUlMWImOflB5mwr7dE75iHh6xzoFu1zb06WypWHJnAG+ogg+Or
         vwxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHuEzGBH8wTYGy9hwHI3GZKadhhgZmyhh1ew3p4P+iRHWwQsYgeY0LeS+0iT2VxZAqh3rQL20D18oDRIqx3bJ9gK+GeHoXlm788hxdZxONr20RiknKb+7PorOC6iHppinCawB2VmmX22wsY5fQM8hPOk+ONyV7G0bF/xhYd6Vk
X-Gm-Message-State: AOJu0YyFI6GOP9RTgz7QAbLOFK1LnqSUkCr/QuRyNzgMvCYJIXzBNVbq
	cJlRfNtamsB6TFthgeLZe3VRbeRJW8cBuAi9sDR/85Qf24/v6HoV28uWhJrH/0m5J9LB8SGpH33
	Fvp/u8rB+ljNpwtKzrXvk0YQKEr4=
X-Google-Smtp-Source: AGHT+IEtm0sD8Sa0+addF9hJdQbBx2EE5vGepBc/VO3KXvtQBeHYOLXKqAZz27lWtICIkz3g/nrddVB2TlYbAM11kPk=
X-Received: by 2002:a25:2983:0:b0:dc6:d1a9:d858 with SMTP id
 p125-20020a252983000000b00dc6d1a9d858mr826027ybp.8.1707986676022; Thu, 15 Feb
 2024 00:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212020403.1639030-1-hayatake396@gmail.com>
In-Reply-To: <20240212020403.1639030-1-hayatake396@gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Thu, 15 Feb 2024 17:44:25 +0900
Message-ID: <CADFiAcL+2vVUHWcWS_o3Oxk67tuZeNk8+8ygjGGKK3smop595A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] ethtool: Add GTP RSS hash options to ethtool.h
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, vladimir.oltean@nxp.com, laforge@gnumonks.org, 
	Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub-san

As previously advised, the patch has been divided.
I apologize for the inconvenience, but I would appreciate it if you
could take the time to review the patch.
I understand you may be busy, but your confirmation would be greatly
appreciated.

Thanks
Takeru

2024=E5=B9=B42=E6=9C=8812=E6=97=A5(=E6=9C=88) 11:04 Takeru Hayasaka <hayata=
ke396@gmail.com>:
>
> This is a patch that enables RSS functionality for GTP packets using etht=
ool.
>
> A user can include TEID and make RSS work for GTP-U over IPv4 by doing th=
e
> following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
>
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
>
> gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format d=
oes
> not include a TEID.
> gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format tha=
t
> includes a TEID.
> gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extend=
ed
> header includes Uplink, applicable to both IPv4 and IPv6.
> gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downl=
ink,
> for both IPv4 and IPv6.
>
> GTP generates a flow that includes an ID called TEID to identify the tunn=
el.
> This tunnel is created for each UE (User Equipment).By performing RSS bas=
ed on
> this flow, it is possible to apply RSS for each communication unit from t=
he UE.
> Without this, RSS would only be effective within the range of IP addresse=
s. For
> instance, the PGW can only perform RSS within the IP range of the SGW.
> Problematic from a load distribution perspective, especially if there's a=
 bias
> in the terminals connected to a particular base station.This case can be
> solved by using this patch.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2->v3: Based on Harald-san's review, I added documentation and comments =
to
> ethtool.h and ice.rst.
> v3->v4: Based on Marcin-san's review, I added the missing code for GTPC a=
nd
> GTPC_TEID, and revised the documentation and comments.
> v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regar=
ding
> GTPC
> v5->v6: Based on Marcin-san's review, Undoing the addition of unnecessary
> blank lines.Minor fixes.
> v6->v7 Based on Jakub-san's review, Split the patch.
> v7->v8: There are no code changes. I've resent the patch, including Marci=
n-san's
> patch, because PatchWork did not interpret the patch correctly.Simon-san =
told
> me. Thanks.
>  include/uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 06ef6b78b7de..11fc18988bc2 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2023,6 +2023,53 @@ static inline int ethtool_validate_duplex(__u8 dup=
lex)
>  #define        IPV4_FLOW       0x10    /* hash only */
>  #define        IPV6_FLOW       0x11    /* hash only */
>  #define        ETHER_FLOW      0x12    /* spec only (ether_spec) */
> +
> +/* Used for GTP-U IPv4 and IPv6.
> + * The format of GTP packets only includes
> + * elements such as TEID and GTP version.
> + * It is primarily intended for data communication of the UE.
> + */
> +#define GTPU_V4_FLOW 0x13      /* hash only */
> +#define GTPU_V6_FLOW 0x14      /* hash only */
> +
> +/* Use for GTP-C IPv4 and v6.
> + * The format of these GTP packets does not include TEID.
> + * Primarily expected to be used for communication
> + * to create sessions for UE data communication,
> + * commonly referred to as CSR (Create Session Request).
> + */
> +#define GTPC_V4_FLOW 0x15      /* hash only */
> +#define GTPC_V6_FLOW 0x16      /* hash only */
> +
> +/* Use for GTP-C IPv4 and v6.
> + * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> + * After session creation, it becomes this packet.
> + * This is mainly used for requests to realize UE handover.
> + */
> +#define GTPC_TEID_V4_FLOW 0x17 /* hash only */
> +#define GTPC_TEID_V6_FLOW 0x18 /* hash only */
> +
> +/* Use for GTP-U and extended headers for the PSC (PDU Session Container=
).
> + * The format of these GTP packets includes TEID and QFI.
> + * In 5G communication using UPF (User Plane Function),
> + * data communication with this extended header is performed.
> + */
> +#define GTPU_EH_V4_FLOW 0x19   /* hash only */
> +#define GTPU_EH_V6_FLOW 0x1a   /* hash only */
> +
> +/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended header=
s.
> + * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
> + * UL/DL included in the PSC.
> + * There are differences in the data included based on Downlink/Uplink,
> + * and can be used to distinguish packets.
> + * The functions described so far are useful when you want to
> + * handle communication from the mobile network in UPF, PGW, etc.
> + */
> +#define GTPU_UL_V4_FLOW 0x1b   /* hash only */
> +#define GTPU_UL_V6_FLOW 0x1c   /* hash only */
> +#define GTPU_DL_V4_FLOW 0x1d   /* hash only */
> +#define GTPU_DL_V6_FLOW 0x1e   /* hash only */
> +
>  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
>  #define        FLOW_EXT        0x80000000
>  #define        FLOW_MAC_EXT    0x40000000
> @@ -2037,6 +2084,7 @@ static inline int ethtool_validate_duplex(__u8 dupl=
ex)
>  #define        RXH_IP_DST      (1 << 5)
>  #define        RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
>  #define        RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> +#define        RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
>  #define        RXH_DISCARD     (1 << 31)
>
>  #define        RX_CLS_FLOW_DISC        0xffffffffffffffffULL
> --
> 2.34.1
>

