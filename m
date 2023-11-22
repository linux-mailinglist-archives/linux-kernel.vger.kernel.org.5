Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED57F49C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbjKVPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjKVPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:06:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FAD41
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:06:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32d9effe314so4865527f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700665573; x=1701270373; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=qkwTVD62ajzdf7dlWnCdytqfMcFWREUSAZ60OZZcydw=;
        b=oy4FFEP/jGBir6ubPDxDt1USPwx15Rl/xj53lrNEZV0hEZ4RwZCiawHPzcmMz6OQ74
         OC656rcXKFjSOdINEKWfwks4H6/OU3M0Xi1TI4Et94bS6Vp47iripvAKz0KDNxTzcPWk
         K7Ih36BG8nFVizgMzEarqaAUDv/a/sE0DRIxtgaHeroAqno8XN2Olp57iQcI3FCEJrv4
         l3BzXBynlTBzBBZQTSkJ622XrJZhPhyU1koSYcra+zKEwZ/PEkZF7Ea0Z21r/+QUCURn
         wsRLye45IpksIXH1GEr+tmqK7d6Hi8sFfMuPOXVfQjRKoGiw1H16sv0dH1Cs7wFFEf3H
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665573; x=1701270373;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkwTVD62ajzdf7dlWnCdytqfMcFWREUSAZ60OZZcydw=;
        b=vuYQGUVkR+gQb7bk64fo1fNBpgcUxLr9elQjB//+XvtbORUZ4XScVG1AUg6ifmBgCX
         YlelVe1+FXraVtfmtPIZE+dGQSMycHUuiX6474iDBYDxt6gys9pU8IVQGWAWYK9mVYyK
         KXMGSJGZVQEo7NHE+Wpwci8VIpAPpQ00WDTqOCEobwk1DJxY83ky5r+r1xaPSPF8I5Pk
         7c1r2/w1QEOAFV769D79yqEHHp7nNHvLiyLF9SYEyuxGCe2d1S6ojCy+pktZ8iDlPMR1
         aKUaqP/QG4VpGObj3U3y+DNX44QFWgAinmUjU2i5o/D5beeh17KC2tWCZnF0YIllysPu
         WRag==
X-Gm-Message-State: AOJu0Ywrx/m4QgNoCa9OlvWTWDWFnTyCKkAbvuoThzYagns3OyzbfX/X
        hOkiO+8caHB1V0Y/dK6u96QPDA==
X-Google-Smtp-Source: AGHT+IH/8OTT5ueCIR2HxhS3WkKn80oKnhghSf0EXTQrMwFPELramnW4TqYdKKPh+xMmzND5JVWEQw==
X-Received: by 2002:adf:cc82:0:b0:331:6976:c8c7 with SMTP id p2-20020adfcc82000000b003316976c8c7mr1778855wrj.38.1700665573282;
        Wed, 22 Nov 2023 07:06:13 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d0a1:9a3c:4f4b:fa20])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b0032da87e32e2sm17459759wru.4.2023.11.22.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:06:12 -0800 (PST)
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-6-jbrunet@baylibre.com>
 <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v2 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2
 binding
Date:   Wed, 22 Nov 2023 15:52:56 +0100
In-reply-to: <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
Message-ID: <1jsf4xeskb.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 22 Nov 2023 at 09:39, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/11/2023 13:59, Jerome Brunet wrote:
>> Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible
>
> Why? Your commit msg must explain this. You break users of this DTS on
> older kernels and also this makes it impossible to apply via different
> branches in the same cycle. All this needs explanation and proper
> justification. Your message tells here nothing, because "what" is quite
> obvious.
>

I provided all the explanation possible through the different commits of
this series. I can re-state here if it helps

>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
>>  arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
>>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
>>  6 files changed, 28 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
>> index 8e3860d5d916..80cc004ad5fe 100644
>> --- a/arch/arm/boot/dts/amlogic/meson.dtsi
>> +++ b/arch/arm/boot/dts/amlogic/meson.dtsi
>> @@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
>>  			};
>>  
>>  			pwm_ab: pwm@8550 {
>> -				compatible = "amlogic,meson-pwm";
>> +				compatible = "amlogic,meson8-pwm-v2";
>
> That's breaking users of this DTS (old kernel, out of tree, other
> projects) for no real reasons without explanation.

"amlogic,meson-pwm" will continue to match, meaning of bindings is unchanged

How do you propose to fix badly designed bindings then ?

if we cant even introduce a new compatible to fix things up. It is supposed to
stay and broken till the end of time ?

>
> Best regards,
> Krzysztof

