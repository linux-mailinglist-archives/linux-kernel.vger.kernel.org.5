Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED111762D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjGZHY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjGZHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:24:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73776212F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:23:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso988417266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690356187; x=1690960987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psNiZywRuwsEhBcPK2P7fSk1gm5v6+Plq5WYmUtqhGI=;
        b=uO2Rg5sY0eV3ATcWWu8U29fSH7pHqcvqqelJZLxN6hAzE5QhkpBH/VvplWzpMPS+Zn
         muWYU+1ya7ja1oJa1FBVrckfaTRLKABUhMH8AZDt3WSeTzBRFnRHdc4uihjUd1vtI33o
         GzPSK005rh0JrURuPf6BhpNEZvWUWBgT0VSXkredst7zi2rfEWuYBuphRkgXP+ZpSXb1
         Ha1cuiCFksKY5vEoEp8yFXMzGjFKVwFfuq7/KyFGu/s2QpWFBS2JUUgg/uZGYpCjA13Z
         nBZtbHytrFuLtZAVsewKKydugPMfpSYSoxCIFzDl3Vo0ziX/IvzgCRluV27XqPPpHdcB
         MvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356187; x=1690960987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psNiZywRuwsEhBcPK2P7fSk1gm5v6+Plq5WYmUtqhGI=;
        b=RAmz/vKboAOcX5Ax2bxnCa95hznx3GO6SlbYcXg1zW9CfuuczK+UwF/fCYZ4V05uxI
         KKR4duW/HwhZkmln44dIkBUBZAYFbXYPQs1EDc33Lp7KwHPAWdkzHxvUB6AuGJF0RhZ4
         1PFb3UfhzSng8ZpOXFU93qyb9btIt+pnBgx4XZQSYuQan6jAdChDuTYt2J+cCeMbdrgd
         92I6q0qbRxZ1uSSHSa81+MxaYDVwz1Agb6OrsQGIqnev2yKb/PVIE3Dtd1jYvjY/mgdF
         t0FtQ7C8Zuv4dz/b23TzZOwsQJa0xQrGbEyd1UFE4uclr8B1vqo/WD13C93Od3kGzIrW
         sflQ==
X-Gm-Message-State: ABy/qLaCILp4VElk/a3EEyvtcYhg1rJKczlR4R1q1oaj/e8crKBqL3pt
        JOmTNu5Qutm4D5eXno98Mgn6Yg==
X-Google-Smtp-Source: APBJJlHxdheepEk7RhDXpUGoFmdJOcw7RX/66s0wEdZEKSQRGdJuvQKkTHbZGppyP7FDRint8diEBA==
X-Received: by 2002:a17:906:8478:b0:992:d013:1131 with SMTP id hx24-20020a170906847800b00992d0131131mr904451ejc.52.1690356186935;
        Wed, 26 Jul 2023 00:23:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709064b1900b00992e265495csm9240054eju.212.2023.07.26.00.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:23:06 -0700 (PDT)
Message-ID: <97ec26e7-fb3e-ed01-d6f5-563a6ba8b209@linaro.org>
Date:   Wed, 26 Jul 2023 09:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4412-midas: add USB connector
 and USB OTG
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Artur Weber <aweber.kernel@gmail.com>
References: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
 <ZMAfSIF0Rwc69nEv@grimlerstat.localdomain>
 <d04af4a2-a07b-66b7-47e1-5c90fb11fe54@linaro.org>
 <ZMA9AcfElvuYZTiV@grimlerstat.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZMA9AcfElvuYZTiV@grimlerstat.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 23:22, Henrik Grimler wrote:
>>> MHL works reliably if cable is attached before boot, but if cable is
>>> attached on already running device it sometimes work after detaching
>>> and attaching cable a few times.  On cable attach, when it does not
>>> work, we get:
>>>
>>>   [  252.831734] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
>>>   [  253.733916] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
>>>   [  253.735232] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
>>>   [  254.691877] i2c i2c-15: sendbytes: NAK bailout.
>>>   [  254.692150] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
>>>   [  255.984336] sii9234 15-0039: RGND is not 1k
>>>   [  256.068970] sii9234 15-0039: RSEN_HIGH without RGND_1K
>>>   [  256.104457] sii9234 15-0039: discovery failed, no power for MHL?
>>>   [  256.118272] i2c i2c-15: sendbytes: NAK bailout.
>>>   [  256.118539] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
>>>   [  256.375966] sii9234 15-0039: RSEN_HIGH without RGND_1K
>>>   [  256.411561] sii9234 15-0039: discovery failed, no power for MHL?
>>>
>>> while when it works:
>>>
>>>   [  175.348307] max77693-muic max77693-muic: external connector is detached(chg_type:0x1, prev_chg_type:0x0)
>>>   [  175.349576] max77693-muic max77693-muic: CONTROL1 : 0x00, CONTROL2 : 0x01, state : detached
>>>   [  179.304373] dwc2 12480000.usb: new device is full-speed
>>>   [  179.305920] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
>>>   [  180.205735] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
>>>   [  180.207211] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
>>>   [  180.309727] i2c i2c-15: sendbytes: NAK bailout.
>>>   [  180.309996] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
>>>
>>> Not sure if issue here is in muic driver or sii9234 driver.
>>>
>>> OTG still does not seem to work, the muic driver detects (only) a
>>> detach when OTG cable is attached:
>>>
>>>   max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
>>>
>>> Same happened when otg cable was attached before these hsotg changes
>>> as well. I suppose issue here is with max77693-muic driver.
>>>
>>
>> Thanks for testing. I miss here one important thing - did anything
>> regressed? Is MHL behaving not worse than before? OTG, as non-working,
>> matters less in such case.
> 
> No regressions as far as I can tell, only improvements.  We want the
> muic node and mhl_to_muic/muic_to_mhl ports so that muic can notify
> the mhl chip of cable attachment/detachment (with requires an
> additional patch to the sii9234 driver that I will send soon [1]).
> The alternative, having the mhl chip always on, has caused issues with
> some GUIs [2].

Awesome, thank you!

Best regards,
Krzysztof

