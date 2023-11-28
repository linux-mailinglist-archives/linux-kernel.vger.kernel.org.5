Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A37FC168
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjK1QJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjK1QJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:09:40 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DE127
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:09:45 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E25B4443D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701187784;
        bh=pEKPe8cq8iCO+hKEkwpNbBcU/bv+bYZjuOAiUbbFTmw=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GhasgKWyW7fhGu/IKEgFYSNL+npeH4JsKBaXgYMyhS5xtNAlmr4CGgcZRzugMpDI9
         vEtY4xkrwYvqVNalqMSaJ+kLFgtD3/v2+UZhGXn+tIIbab5kpMmljRg/N2SEQaDLyN
         Z7lr5v3AHdr19YpYCtqd1fGuLL5Uubdj12CLSc4wB3VjoB+GZp8RCWIfjHdBR5H4kS
         jtZk6IYFVnB5ZtSA3Xbowj1AOOxxQRrDH3CJPdgzFkhT6+mBuw95BeDrFiy7B2LABv
         Rr8KoUYcNf2rIMj6hZ1ZXPDPwH2YIREaCjmTjpWMC5YYnb5PIzi7KJ+nd9oOYxKV7e
         wImOHw7xLoC4w==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a238351b7so41950496d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187782; x=1701792582;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEKPe8cq8iCO+hKEkwpNbBcU/bv+bYZjuOAiUbbFTmw=;
        b=TIzCFpQT50yqeRHTkK6ri86P2YBeb0IUbrRq+NxzSv9t9wj0W00mRPPXDzoMk0w8RE
         aKr5zM2juUgkU7LcxECyYn+vXwZVqyGjftQJATPdRgR+QJlFAPb5f4gqdWWa06wdfqF7
         tqMezYti89Sgb9fNoXfLxRHHzUs4Oyqu4NiaOVP2wRxVp0BIi3rHy6fhlA6y2wujP91y
         2iUNjAVmib1NBoB/pM3Az9TGVRQloLI2ULLxL8IYoDmj6tV2npbgrBBjHmus112supxP
         TPos7SOneDGjdPEUEGXxMx7jJM7VHupqgE7gO2Euky1Ibs3gJ6hqX1E/iKN27ohCcGTS
         wNag==
X-Gm-Message-State: AOJu0YzAKH2VQLmos3IhIx9uiwGNdl32RbBeJukuWFDYSiB+OaepSB1/
        lUBNjNpSVp2vKYUIEdqCl2u5YLkzY7FopKm8s21USIg1sAsyOgaAxKgZmC9Q5fo2bZQ05w7nK62
        YLrBl5KYmf2geIb3I4O/VaCciu3YrZSxq7YkwtcmZRLyMtuy0IdXCJ0pi6A==
X-Received: by 2002:ad4:5144:0:b0:67a:3863:d126 with SMTP id g4-20020ad45144000000b0067a3863d126mr10046201qvq.44.1701187782197;
        Tue, 28 Nov 2023 08:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBKpSSFbtesM/25uZwKIDezsMT1jPt3i9azPNVI4N4TMfmDOkXhoCn8EiGeenreU73yagsK6uZPTXiBRU8kPg=
X-Received: by 2002:ad4:5144:0:b0:67a:3863:d126 with SMTP id
 g4-20020ad45144000000b0067a3863d126mr10046174qvq.44.1701187781933; Tue, 28
 Nov 2023 08:09:41 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 17:09:41 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <054bbf2a-e7ba-40bf-8f8b-f0e0e9b396c6@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
 <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com> <CAJM55Z8vkMbqXY5sS2o4cLi8ow-JQTcXU9=uYMBSykwd4ppExw@mail.gmail.com>
 <054bbf2a-e7ba-40bf-8f8b-f0e0e9b396c6@collabora.com>
Mime-Version: 1.0
Date:   Tue, 28 Nov 2023 17:09:41 +0100
Message-ID: <CAJM55Z9+j6CmfjNkPLCk1DR3EBuEMspsRtNvygDbPWJDCytQpw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian Ciocaltea wrote:
> On 11/28/23 14:08, Emil Renner Berthing wrote:
> > Cristian Ciocaltea wrote:
> >> On 11/26/23 23:10, Emil Renner Berthing wrote:
> >>> Cristian Ciocaltea wrote:
> >>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >>>> RGMII-ID.
> >>>>
> >>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
> >>>> yes, add the mdio & phy sub-nodes.
> >>>
> >>> Sorry for being late here. I've tested that removing the mdio and phy nodes on
> >>> the the Starlight board works fine, but the rx-internal-delay-ps = <900>
> >>> property not needed on any of my VisionFive V1 boards either.
> >>
> >> No problem, thanks a lot for taking the time to help with the testing!
> >>
> >>> So I wonder why you need that on your board
> >>
> >> I noticed you have a patch 70ca054e82b5 ("net: phy: motorcomm: Disable
> >> rgmii rx delay") in your tree, hence I you please confirm the tests were
> >> done with that commit reverted?
> >>
> >>> Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
> >>> you still set it to "rgmii-id", so which is it?
> >>
> >> Please try with "rgmii-id" first. I added "rgmii-txid" to have a
> >> fallback solution in case the former cannot be used.
> >
> > Ah, I see. Sorry I should have read up on the whole thread. Yes, the Starlight
> > board with the Microchip phy works with "rgmii-id" as is. And you're right,
> > with "rgmii-id" my VF1 needs the rx-internal-delay-ps = <900> property too.
>
> That's great, we have now a pretty clear indication that this uncommon behavior
> stems from the Motorcomm PHY, and *not* from GMAC.
>
> >>
> >>> You've alse removed the phy reset gpio on the Starlight board:
> >>>
> >>>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
> >>>
> >>> Why?
> >>
> >> I missed this in v1 as the gmac handling was done exclusively in
> >> jh7100-common. Thanks for noticing!
> >>
> >>>>
> >>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >>>> ---
> >>>>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>> index 7cda3a89020a..d3f4c99d98da 100644
> >>>> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>> @@ -11,3 +11,8 @@ / {
> >>>>  	model = "BeagleV Starlight Beta";
> >>>>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
> >>>>  };
> >>>> +
> >>>> +&gmac {
> >>>> +	phy-mode = "rgmii-id";
> >>>> +	status = "okay";
> >>>> +};
> >>>
> >>> Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
> >>> so why can't these be set in the jh7100-common.dtsi?
> >>
> >> I wasn't sure "rgmii-id" can be used for both boards and I didn't want
> >> to unconditionally enable gmac on Starlight before getting a
> >> confirmation that this actually works.
> >>
> >> If there is no way to make it working with "rgmii-id" (w/ or w/o
> >> adjusting rx-internal-delay-ps), than we should switch to "rgmii-txid".
> >
> > Yeah, I don't exactly know the difference, but both boards seem to work fine
> > with "rgmii-id", so if that is somehow better and/or more correct let's just go
> > with that.
>
> As Andrew already pointed out, going with "rgmii-id" would be the recommended
> approach, as this passes the responsibility of adding both TX and RX delays to
> the PHY.  "rgmii-txid" requires the MAC to handle the RX delay, which might
> break the boards having a conformant (aka well-behaving) PHY.  For some reason
> the Microchip PHY seems to work fine in both cases, but that's most likely an
> exception, as other PHYs might expose a totally different and undesired
> behavior.
>
> I will prepare a v3 soon, and will drop the patches you have already submitted
> as part of [1].

Sounds good. Then what's missing for ethernet to work is just the clock patches:
https://github.com/esmil/linux/commit/b5abe1cb3815765739aff7949deed6f65b952c4a
https://github.com/esmil/linux/commit/3a7a423b15a9f796586cbbdc37010d2b83ff2367

You can either include those as part of your patch series enabling ethernet, or
they can be submitted separately with the audio clocks. Either way is
fine by me.

/Emil

>
> Thanks again for your support,
> Cristian
>
> [1]: https://lore.kernel.org/all/20231126232746.264302-1-emil.renner.berthing@canonical.com/
