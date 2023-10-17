Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCB7CC915
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjJQQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:49:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492692;
        Tue, 17 Oct 2023 09:49:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3131812276.1;
        Tue, 17 Oct 2023 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697561360; x=1698166160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/IeJ1quEEo+PU8MAFfTtxQFJhzxtcsergsMnGbzvTg=;
        b=Us5vEgerjS6xaelSOwWygBbjABX0nzzodd/svgVy5Y++DN/yKpvgdMVmVJ6dOYU8fS
         n5Shk9xMZije6I5b+mDmrpsTKpBYH1/v4AzhOIhfR+ti2MoHA1kNVsYKiS7829yzZ/TL
         1xMk7jar27d0krQg3jUc3ApbLD7QiBB3qnPtBPKP5pdyMfD73UQMOyeTgem3YfW5wEGc
         1c34r+GZ1RUqmjNXG0LzPXIQ1CSH2fHoGd7uxY1gYKjqZnRcYXBmgGghLoTPp1SdRd5A
         9DaRzvqiXM02qkOv85o16GuN/4GaXx2OAe3wApyM4eZOM92KM5442RhIW+OTxhZAB2Kj
         r5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561360; x=1698166160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/IeJ1quEEo+PU8MAFfTtxQFJhzxtcsergsMnGbzvTg=;
        b=hGS811pl7YP1Z4ovsAfvDjShryTMrdE9lwVwEKg6gtGIUE6DgnoLiS3X/HbzCEurMI
         iSYGoOqWDQQd0qdvxFBuObjGxwoBjb6LFm2YQvrsCKkrWO9BbuLwExBxxtHIbJpDSmoJ
         gwkuen5BT3kz573jIYB6Ia70vyNG0oXSXSRuJAHvD3dHU/Ug4qdS1D/ch6BYGpQ1EaRS
         N2plIEtC5n/29AUmTbwQU26/i9H57L1KVuc8COI/IGOmakE516P3CrTU7dokkRFphRMQ
         EUpk7wzsO5d0tdOzfw7uwC3h2Rji3ItSa0nWeNwRAjz1XycjCjK4/i9WOUr7SMmX7fXd
         zagA==
X-Gm-Message-State: AOJu0YwRzcZDI+YTN/BUv7PXNSkns9Lf/+Eh+NqO341HXne0R/CH2hWn
        A6DMk/3mxhDBXisKi8h6c6zF2dauNaLBunM7X3o=
X-Google-Smtp-Source: AGHT+IEiQn/zbKdPMRTxURXz52F367KaaKK1aeWWkhuklEiJTzkYdLjtdrMAxfeCCrP7CSMs8e/5cfSwwFKz+OtxKZk=
X-Received: by 2002:a05:6902:528:b0:d9a:6374:532a with SMTP id
 y8-20020a056902052800b00d9a6374532amr2473855ybs.30.1697561360211; Tue, 17 Oct
 2023 09:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org> <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
In-Reply-To: <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Wed, 18 Oct 2023 01:49:08 +0900
Message-ID: <CADFiAcLvrpm+HGotr=UWiqyLGG-Bp1vf1E7bwKH_-MTCc84Jjw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not very proficient in English, so I'm worried whether I can
explain it well.
Therefore, I will try to briefly explain the flow and what kind of
cases these are in a straightforward manner.

> +#define GTPU_V4_FLOW 0x13 /* hash only /
> +#define GTPU_V6_FLOW 0x14 / hash only */

These are the cases for GTPv1-U IPv4 and v6. The format of the GTP
packets only includes elements like TEID and GTP version. They are
mainly expected to be used for UE data communication.

> +#define GTPC_V4_FLOW 0x15 /* hash only /
> +#define GTPC_V6_FLOW 0x16 / hash only */

These are the cases for GTPv2-C IPv4 and v6. The format of these GTP
packets does not include TEID. They are mainly expected to be used for
communication for generating sessions for UE data communication,
commonly referred to as CSR.

> +#define GTPC_TEID_V4_FLOW 0x17 /* hash only /
> +#define GTPC_TEID_V6_FLOW 0x18 / hash only */

These are the cases for GTPv2-C IPv4 and v6. Unlike before, the format
of these GTP packets includes TEID. After session creation, it becomes
this packet. It is mainly used for requests to achieve UE handovers.

> +#define GTPU_EH_V4_FLOW 0x19 /* hash only /
> +#define GTPU_EH_V6_FLOW 0x20 / hash only */

These are cases of GTPv1-U and Extension Header for the PDU Session
Container for IPv4 and v6. The format of these GTP packets includes
TEID and QFI. In 5G communication using UPF and others, data
communication using this extended header will be conducted.

> +#define GTPU_UL_V4_FLOW 0x21 /* hash only /
> +#define GTPU_UL_V6_FLOW 0x22 / hash only /
> +#define GTPU_DL_V4_FLOW 0x23 / hash only /
> +#define GTPU_DL_V6_FLOW 0x24 / hash only */

These packets are cases of GTPv1-U and Extension Header for the PDU
Session Container of IPv4 and v6. The difference from before is
distinguishing by looking at the PDU Session Container. There is also
a difference in the data contained based on DL/UL, which can be used
to distinguish packets.

All these functionalities explained up to this point are useful when
you want to process data communication from the mobile network at UPF,
PGW, etc.

Jakub-san might be concerned because there are many flows. If the
number of these flows seems too much, it might be good to reduce the
cases of EH_UL/DL and GTPC only.
I made this implementation to fully utilize the GTP features in Intel
ICE for RSS, so there are many flows.
The reason is that UL/DL can be substituted with EH (looking at the
implementation in Intel ICE, both UL/DL seem to be dont care), and for
GTPC without TEID, originally it should be hashed with IMSI etc. when
doing RSS, but it doesn=E2=80=99t seem to be done right now.

In other words, if it seems better to reduce them, it might be good to
only incorporate gtp4|6, gtpc4|6, gtpue4|6.

I would be happy to receive your feedback :)

2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 23:37 takeru hayasaka <hayat=
ake396@gmail.com>:

>
> Hi Harald-san
>
> Thanks for your review!
>
> > so if I'm guessing correctly, those would be hashing only on the V4/V6
> destination address?  Why would that be GTP specific?  The IPv4/v6
> header in front of the GTP header is a normal IP header.
>
> This is not correct. The TEID and the src port/dst port of the inner
> packet are also included.
>
> > Are there really deployments where the *very limited* GTP-C control
> I also think that it should not be limited to GTP-C. However, as I
> wrote in the email earlier, all the flows written are different in
> packet structure, including GTP-C. In the semantics of ethtool, I
> thought it was correct to pass a fixed packet structure and the
> controllable parameters for it. At least, the Intel ice driver that I
> modified is already like that.
>
> > IMHO that kind of explanation should be in the comment next to the
> > #define (for all of them) rather than "hash only".  That way it's
> > obvious to the reader what they do, rather than having to guess.
>
> Regarding what should be hashed, this is a complex case. It will also
> answer other questions, but for example, if you read this Intel ice
> driver, there are cases where you can manipulate the port of the Inter
> packet. I think this varies depending on the driver to be implemented.
>
> Note that these comments follow the existing code of ethtool.
>
> FYI: I think it will be helpful for you!
> https://www.intel.com/content/www/us/en/content-details/617015/intel-ethe=
rnet-controller-e810-dynamic-device-personalization-ddp-technology-guide.ht=
ml
> (cf. Table 8. Patterns and Input Sets for iavf RSS)
>
> 2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 23:18 takeru hayasaka <hay=
atake396@gmail.com>:
> >
> > Hi Jakub-san and Simon-san
> > Thank you for reviewing again!
> >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > Thanks;)
> >
> > > Adding Willem, Pablo, and Harald to CC (please CC them on future
> > versions).
> >
> > of course.  thanks!
> >
> > > nit: please note that these are hex numbers,
> >      next value after 0x19 is 0x1a, not 0x20.
> >
> > !!!!! I'm so embarrassed.... I will next version fix
> >
> > > What gives me pause here is the number of flow sub-types we define
> > > for GTP hashing.
> > >
> > > My understanding of GTP is limited to what I just read on Wikipedia.
> > >
> > > IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> > > which the protocol runs? Are the frames also different?
> > >
> > > I'm guessing UL/DL are uplink/downlink but what's EH?
> > >
> > > How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> > > GTPU_DL_V4_FLOW differ?
> > >
> > > Key question is - are there reasonable use cases that you can think o=
f
> > > for enabling GTP hashing for each one of those bits individually or c=
an
> > > we combine some of them?
> >
> > Firstly, what I want to convey is that the structure of each of these
> > packets is entirely different. Therefore, in terms of ethtool, since
> > packets with the same structure are considered a flow, I understand
> > that it is necessary to define such different things (I actually think
> > that the people at Intel are doing it that way).
> >
> > Let me first explain the difference between GTPC and GTPU.
> > The UDP ports are different in GTPC and GTPU.
> > What's further different is that in the case of GTPC, GTPv2-C is used,
> > and in the case of GTPU, GTPv1-U is used, which are mainstream in
> > current mobile communications.
> >
> > Especially the uniqueness of GTPC communication varies according to
> > the processing phase.
> > CSR (Create Session Request) starts processing from a state where TEID
> > is not included. Therefore, it is separated into cases where packets
> > have TEID and where they don=E2=80=99t.
> > Of course, there are cases where we want to specially process only the
> > communication without TEID, and just creating a session is one of the
> > more vulnerable parts of the mobile network.
> >
> > EH stands for Extension Header.
> > This is the case with GTPU packets compatible with 5G. If it=E2=80=99s =
the
> > Flow Director, it reads a parameter related to QoS called QFI.
> > Without this, it is impossible to process GTPv1 packets compatible with=
 5G.
> > Furthermore, this Extension Header has parts where the shape differs
> > depending on UL/DL, which is called the PDU Session Container.
> >
> > Specific use cases basically apply to services that terminate GTP itsel=
f.
> >
> > The structure of processing in RSS with ethtool until now was to
> > select a fixed shape of packets and parameters of those packets to
> > perform RSS.
> > Conforming to this format is why it becomes so numerous.
> >
> >
> > 2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 7:23 Jakub Kicinski <kub=
a@kernel.org>:
> >
> > >
> > > Thanks for the v2!
> > >
> > > Adding Willem, Pablo, and Harald to CC (please CC them on future
> > > versions).
> > >
> > > On Thu, 12 Oct 2023 06:01:15 +0000 Takeru Hayasaka wrote:
> > > > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/etht=
ool.h
> > > > index f7fba0dc87e5..a2d4f2081cf3 100644
> > > > --- a/include/uapi/linux/ethtool.h
> > > > +++ b/include/uapi/linux/ethtool.h
> > > > @@ -2011,6 +2011,18 @@ static inline int ethtool_validate_duplex(__=
u8 duplex)
> > > >  #define      IPV4_FLOW       0x10    /* hash only */
> > > >  #define      IPV6_FLOW       0x11    /* hash only */
> > > >  #define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > > > +#define GTPU_V4_FLOW 0x13    /* hash only */
> > > > +#define GTPU_V6_FLOW 0x14    /* hash only */
> > > > +#define GTPC_V4_FLOW 0x15    /* hash only */
> > > > +#define GTPC_V6_FLOW 0x16    /* hash only */
> > > > +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> > > > +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */
> > > > +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> > > > +#define GTPU_EH_V6_FLOW 0x20 /* hash only */
> > >
> > > nit: please note that these are hex numbers,
> > >      next value after 0x19 is 0x1a, not 0x20.
> > >
> > > > +#define GTPU_UL_V4_FLOW 0x21 /* hash only */
> > > > +#define GTPU_UL_V6_FLOW 0x22 /* hash only */
> > > > +#define GTPU_DL_V4_FLOW 0x23 /* hash only */
> > > > +#define GTPU_DL_V6_FLOW 0x24 /* hash only */
> > > >  /* Flag to enable additional fields in struct ethtool_rx_flow_spec=
 */
> > > >  #define      FLOW_EXT        0x80000000
> > > >  #define      FLOW_MAC_EXT    0x40000000
> > >
> > > What gives me pause here is the number of flow sub-types we define
> > > for GTP hashing.
> > >
> > > My understanding of GTP is limited to what I just read on Wikipedia.
> > >
> > > IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> > > which the protocol runs? Are the frames also different?
> > >
> > > I'm guessing UL/DL are uplink/downlink but what's EH?
> > >
> > > How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> > > GTPU_DL_V4_FLOW differ?
> > >
> > > Key question is - are there reasonable use cases that you can think o=
f
> > > for enabling GTP hashing for each one of those bits individually or c=
an
> > > we combine some of them?
> > >
> > > > @@ -2025,6 +2037,7 @@ static inline int ethtool_validate_duplex(__u=
8 duplex)
> > > >  #define      RXH_IP_DST      (1 << 5)
> > > >  #define      RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/U=
DP/SCTP */
> > > >  #define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/U=
DP/SCTP */
> > > > +#define      RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
> > > >  #define      RXH_DISCARD     (1 << 31)
