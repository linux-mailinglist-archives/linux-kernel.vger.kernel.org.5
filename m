Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3A770EFB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjHEJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHEJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:11:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943E1720
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691226685;
        bh=tCVGwYmH50PWl+o20qdQhoi5gPRP2yF0Bm+CSmqYkuk=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=K7NtTZ/i+DLLtLhHPwAggxCJ4Oe5bWqFMfvNmzS00iyMh/JVqXj6D625tEZUZH7eL
         hplpMZKr9ufaJoVoghD30k3aou1Hbi4JrF5T/Lk6JMeVslu7TeDtFYJRsH9Y2yhaVg
         devBvR/woQqs2sTWnjKiQHvEvVaVhBUtrVWURV6g=
X-QQ-mid: bizesmtp91t1691226631teaq6ssf
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 17:10:22 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: WfQrrMZtGtFovJwejNLv8JZXlZ7C07o8Fu3mKjDmX6ousr2sTmky8+nbFxL/B
        sWl53XJvVYdP4PIFwo0dBszuNJpuY0ckthLst1uzH3TQ58fXHhPNkQhJRIRnTtsCeUBm9ZH
        yw6CqAABNt5j3La90Xj1AlOLT5h/R4JXa6SIMz/r00S+BqNDAfnQ2XuzFMtVg2awQRTaSrK
        rPhGVXbA8WRcJ18eImFtYY+G3GQzo8qKjkwQcsM5tX5cRQSwCPXKFg274n68Kn+mm2biOQs
        chp7Yx3e809ArUBzzVQtwRVMNhyDIRd/5dDA7hU98OsIyyXcppyE+s95rQURopC/DDkUr0C
        oUQem5M/nZrZ8yq4AHLkek3TRDdiU8D7hjdtRNHrzXaLu69RfhXVIPyzMhLRpPSKEqYE1PX
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3745282866020157789
Message-ID: <F5302321A81D0C37+344e333c-241a-8132-b1eb-748e35b58082@biqu3d.com>
Date:   Sat, 5 Aug 2023 11:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/4] Add BigTreeTech CB1 SoM & Boards
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <5EB3DB1D7F80A40F+20230805083636.788048-1-martin@biqu3d.com>
 <20230805-whenever-likely-f16d8b2424ac@spud>
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <20230805-whenever-likely-f16d8b2424ac@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/23 11:01 AM, Conor Dooley wrote:
> On Sat, Aug 05, 2023 at 10:36:03AM +0200, Martin Botka wrote:
>> Hello,
>> This series adds a vendor prefix for BigTreeTech and adds BigTreeTech CB1,
>> Manta board and BigTreeTech Pi.
>>
>> CB1 is just an SoM thats based on AllWinner H616.
>> BigTreeTech Manta boards are expander boards for CB1 and BigTreeTech Pi
>> is an CB1 in Rpi style with few additional things like IR receiver and fan port
>> on GPIO.
>>
>> This work started before I was hired by BigTreeTech and thus majority of the
>> patches are from SoMainline email and few are from my work email.
>>
>> This series depends on commit https://lkml.org/lkml/2023/8/2/801
>> "dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips".
> 
> I dunno what you are doing, but FYI the threading on your emails is not
> quite right, with the cover letter disconnected from the rest of the
> series. git send-email can send the covers alongside the patches and
> correctly set the threading. Your 1/4 has a in-reply-to header with a
> message-id that doesn't exist.

Heya. Yea we are currently trying to figure it out.

Before sending everything looks OK and when testing with somainline.org 
mail it does send it all properly so we are kinda betting on the SMTP
provider doing some funky stuff. Sadly not much i can do with that.

We will try to see if we cant force it via client to send it properly.
> 
>     1 ND  Aug 05 Martin Botka    (8.2K) ┌─>[PATCH v3 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi support
>     2 ND  Aug 05 Martin Botka    ( 12K) ├─>[PATCH v3 3/4] arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
>     3  D  Aug 05 Martin Botka    (  41) ├─>[PATCH v3 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
>     4  D  Aug 05 Martin Botka    (  34) ┴─>[PATCH v3 1/4] dt-bindings: vendor-prefixes: Add BigTreeTech
>     5     Aug 05 Martin Botka    (  38) [PATCH v3 0/4] Add BigTreeTech CB1 SoM & Boards
> 
> 

