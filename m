Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF147CC604
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjJQOiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:38:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98303B0;
        Tue, 17 Oct 2023 07:38:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7c7262d5eso72667637b3.1;
        Tue, 17 Oct 2023 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697553489; x=1698158289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75OfTF2wq/AyhsHzOu0gWS2g0ZYPjPU8/R+8KK4wR8g=;
        b=HdJNkb/KRnMJ5ocOFfUdlrhkdfcEObOXIyo10nenYzGevwna1EMHwktsohT8GgFgxy
         GkqwaU5eEIJHdva3SXgzNIClcxg35aCjjoP2riiCbYmgghpqZMoCt0L0UUfhidMWT/iV
         8NEuVToO2e3UO3fmPAVTP45jCUfOB9bO5qJJlys//2UThFW3/tSO518ZA5I+IYgZg1vX
         LrH3tAJSaLw39m58aOdf9fMI3rQy0xebomLA4JhJMOZfYisPBjCa8TmwKYg9AvlTQWcU
         kk8Wq1mQ6wKfF6f1nF22p7owZ3OKPTov5Xv6eJ1CCuWU+nsdbyrz4SBJDvaO1gcepib6
         peOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553489; x=1698158289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75OfTF2wq/AyhsHzOu0gWS2g0ZYPjPU8/R+8KK4wR8g=;
        b=FsjFJZxoRBuG6I/u6LoEOkOjZ4niUz9P3/keOZly4uaFP1qdvD8vyhu3O1hJFcRYUB
         G0JAXFniFcGhSVTQnMOwlu25MseamhE5AE/sYRr/D//bzOOv3E6B5QhomVWt4e/J9EV1
         M6QmT7ptsLjnCoEBklXpNiYdqKncdRq3vsyiU1deyHhCzK2LiOsFHv4uL0OqwH5wmaQP
         qZaVif2tKhtzMtTaJluUpvZ1Woc2F8zAoqOUNilZQTI0gyHRM5/xR2tWcJlN+x7ctyOR
         uwgzHHHTxhD+zrgQ61eAStpAyxVKmA8gtBK9u0RSHRFQX4qiucz94dHE62ATRcVk9Ksj
         Ap7w==
X-Gm-Message-State: AOJu0Yzte2qUnBF0t2j8/EdwrvSu+H0ONdjU8VRUNFW5QlrbSBFXFizD
        2tBZ4KuErJ1KlqlTZGPQxXtsH8nQbReeLcmnuDY=
X-Google-Smtp-Source: AGHT+IH7wE1X/ExHqh4Xq+zw0JindTailoWVgfKyCo8C2MNshEPC+omLh0FxBAhLQ3IAwYpYAcQJg6crfhXrVV//QTE=
X-Received: by 2002:a25:780a:0:b0:d9a:e224:1822 with SMTP id
 t10-20020a25780a000000b00d9ae2241822mr2412785ybc.11.1697553488460; Tue, 17
 Oct 2023 07:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org> <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
In-Reply-To: <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Tue, 17 Oct 2023 23:37:57 +0900
Message-ID: <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
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

Hi Harald-san

Thanks for your review!

> so if I'm guessing correctly, those would be hashing only on the V4/V6
destination address?  Why would that be GTP specific?  The IPv4/v6
header in front of the GTP header is a normal IP header.

This is not correct. The TEID and the src port/dst port of the inner
packet are also included.

> Are there really deployments where the *very limited* GTP-C control
I also think that it should not be limited to GTP-C. However, as I
wrote in the email earlier, all the flows written are different in
packet structure, including GTP-C. In the semantics of ethtool, I
thought it was correct to pass a fixed packet structure and the
controllable parameters for it. At least, the Intel ice driver that I
modified is already like that.

> IMHO that kind of explanation should be in the comment next to the
> #define (for all of them) rather than "hash only".  That way it's
> obvious to the reader what they do, rather than having to guess.

Regarding what should be hashed, this is a complex case. It will also
answer other questions, but for example, if you read this Intel ice
driver, there are cases where you can manipulate the port of the Inter
packet. I think this varies depending on the driver to be implemented.

Note that these comments follow the existing code of ethtool.

FYI: I think it will be helpful for you!
https://www.intel.com/content/www/us/en/content-details/617015/intel-ethern=
et-controller-e810-dynamic-device-personalization-ddp-technology-guide.html
(cf. Table 8. Patterns and Input Sets for iavf RSS)

2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 23:18 takeru hayasaka <hayat=
ake396@gmail.com>:
>
> Hi Jakub-san and Simon-san
> Thank you for reviewing again!
>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> Thanks;)
>
> > Adding Willem, Pablo, and Harald to CC (please CC them on future
> versions).
>
> of course.  thanks!
>
> > nit: please note that these are hex numbers,
>      next value after 0x19 is 0x1a, not 0x20.
>
> !!!!! I'm so embarrassed.... I will next version fix
>
> > What gives me pause here is the number of flow sub-types we define
> > for GTP hashing.
> >
> > My understanding of GTP is limited to what I just read on Wikipedia.
> >
> > IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> > which the protocol runs? Are the frames also different?
> >
> > I'm guessing UL/DL are uplink/downlink but what's EH?
> >
> > How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> > GTPU_DL_V4_FLOW differ?
> >
> > Key question is - are there reasonable use cases that you can think of
> > for enabling GTP hashing for each one of those bits individually or can
> > we combine some of them?
>
> Firstly, what I want to convey is that the structure of each of these
> packets is entirely different. Therefore, in terms of ethtool, since
> packets with the same structure are considered a flow, I understand
> that it is necessary to define such different things (I actually think
> that the people at Intel are doing it that way).
>
> Let me first explain the difference between GTPC and GTPU.
> The UDP ports are different in GTPC and GTPU.
> What's further different is that in the case of GTPC, GTPv2-C is used,
> and in the case of GTPU, GTPv1-U is used, which are mainstream in
> current mobile communications.
>
> Especially the uniqueness of GTPC communication varies according to
> the processing phase.
> CSR (Create Session Request) starts processing from a state where TEID
> is not included. Therefore, it is separated into cases where packets
> have TEID and where they don=E2=80=99t.
> Of course, there are cases where we want to specially process only the
> communication without TEID, and just creating a session is one of the
> more vulnerable parts of the mobile network.
>
> EH stands for Extension Header.
> This is the case with GTPU packets compatible with 5G. If it=E2=80=99s th=
e
> Flow Director, it reads a parameter related to QoS called QFI.
> Without this, it is impossible to process GTPv1 packets compatible with 5=
G.
> Furthermore, this Extension Header has parts where the shape differs
> depending on UL/DL, which is called the PDU Session Container.
>
> Specific use cases basically apply to services that terminate GTP itself.
>
> The structure of processing in RSS with ethtool until now was to
> select a fixed shape of packets and parameters of those packets to
> perform RSS.
> Conforming to this format is why it becomes so numerous.
>
>
> 2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 7:23 Jakub Kicinski <kuba@=
kernel.org>:
>
> >
> > Thanks for the v2!
> >
> > Adding Willem, Pablo, and Harald to CC (please CC them on future
> > versions).
> >
> > On Thu, 12 Oct 2023 06:01:15 +0000 Takeru Hayasaka wrote:
> > > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtoo=
l.h
> > > index f7fba0dc87e5..a2d4f2081cf3 100644
> > > --- a/include/uapi/linux/ethtool.h
> > > +++ b/include/uapi/linux/ethtool.h
> > > @@ -2011,6 +2011,18 @@ static inline int ethtool_validate_duplex(__u8=
 duplex)
> > >  #define      IPV4_FLOW       0x10    /* hash only */
> > >  #define      IPV6_FLOW       0x11    /* hash only */
> > >  #define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > > +#define GTPU_V4_FLOW 0x13    /* hash only */
> > > +#define GTPU_V6_FLOW 0x14    /* hash only */
> > > +#define GTPC_V4_FLOW 0x15    /* hash only */
> > > +#define GTPC_V6_FLOW 0x16    /* hash only */
> > > +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> > > +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */
> > > +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> > > +#define GTPU_EH_V6_FLOW 0x20 /* hash only */
> >
> > nit: please note that these are hex numbers,
> >      next value after 0x19 is 0x1a, not 0x20.
> >
> > > +#define GTPU_UL_V4_FLOW 0x21 /* hash only */
> > > +#define GTPU_UL_V6_FLOW 0x22 /* hash only */
> > > +#define GTPU_DL_V4_FLOW 0x23 /* hash only */
> > > +#define GTPU_DL_V6_FLOW 0x24 /* hash only */
> > >  /* Flag to enable additional fields in struct ethtool_rx_flow_spec *=
/
> > >  #define      FLOW_EXT        0x80000000
> > >  #define      FLOW_MAC_EXT    0x40000000
> >
> > What gives me pause here is the number of flow sub-types we define
> > for GTP hashing.
> >
> > My understanding of GTP is limited to what I just read on Wikipedia.
> >
> > IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> > which the protocol runs? Are the frames also different?
> >
> > I'm guessing UL/DL are uplink/downlink but what's EH?
> >
> > How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> > GTPU_DL_V4_FLOW differ?
> >
> > Key question is - are there reasonable use cases that you can think of
> > for enabling GTP hashing for each one of those bits individually or can
> > we combine some of them?
> >
> > > @@ -2025,6 +2037,7 @@ static inline int ethtool_validate_duplex(__u8 =
duplex)
> > >  #define      RXH_IP_DST      (1 << 5)
> > >  #define      RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP=
/SCTP */
> > >  #define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP=
/SCTP */
> > > +#define      RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
> > >  #define      RXH_DISCARD     (1 << 31)
