Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E837E1EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKFKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:43:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605F94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:43:21 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507962561adso5615485e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699267400; x=1699872200; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=EK4l5HF7xxlWSQTYmo3dGoTvrbNSR6x1ONnxE49iyKE=;
        b=LaxnwP3Stjbr1ttqDmeGvf0CQPQFab6UjmuCtHQ4jX9fv97NRLMDfARo0x9uxBaHI4
         U31CfcuOA58TQHBuIqyefgUxdamyNojG1BpWe4wGovoVBKWajnTgJ6jAZ6zDXYZddO5f
         rmfeSt4ZYdIpcjJjHgnKm/LuhLZV83dKctbJKA7BCPjoyISCCn4QrQJ5a+AKc02TVtvc
         AtmgzTSj4dwcysiu8F/3x+MqTN0YF1wO22V0NwUsDWDFtI0DC2q0Wnte2+4k3Auyzg+u
         e6xycFZRci6OPb+pT6CsVJ2RrcO97vYc/NcaigDqQ/dANNWNXdBcW1SYtw4TkDCPhMNZ
         U+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267400; x=1699872200;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK4l5HF7xxlWSQTYmo3dGoTvrbNSR6x1ONnxE49iyKE=;
        b=vsAvP1AA5GYW4vpdPjJ4Tc8fl0DzzIPYdhEKMC7ZEG6tdmsDR9xLsPuXU/WiS9pY2w
         DAHex4agXHlV9JwVXXeysx6OMbY2AMAbaOekpb9YDolvL6nDyzhzUifIf1BIlCkx4zUr
         6KgL7rOMozfRpwnvjPYjVoATCD0Wi/Vdw1KnuqVibr85OYwQY/IslcqqL7oaGM60NDFJ
         xL7p2ZPgt1YZ0qrSXsf9iLPIgi9d+tC1MaR5QYVJkRYUz56kFBzACacd9DPqmaet9dOP
         s1l6+9iz6rkdwovZ/blMl4Am0vy45ex56sFnlKbVet5G6PHLM3RuH+Hs8ibEacO7FNkM
         r3ww==
X-Gm-Message-State: AOJu0YxpBFArHW0WVgjjI6FmQuVHHfqDQPzU5eyb/z4P04JU4jvRiJ5n
        hSXV0YxK3WG5iz1yTOauiJpXGg==
X-Google-Smtp-Source: AGHT+IEuY4dAFuRUFbRqk9ROoWkyBZI0vf/LOEPY67+q6fLgjVF2+PrZtaJdiEfkQaX2csVRK5qlZg==
X-Received: by 2002:ac2:414b:0:b0:4fe:1681:9377 with SMTP id c11-20020ac2414b000000b004fe16819377mr20084251lfi.44.1699267399986;
        Mon, 06 Nov 2023 02:43:19 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b00327bf4f2f14sm9113326wrd.88.2023.11.06.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:43:19 -0800 (PST)
References: <20231106092202.11127-1-tomeu@tomeuvizoso.net>
 <569e39a0-b91c-46f1-b55d-c9324d66339b@linaro.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH RESEND] arm64: dts: VIM3: Set the rates of the clocks
 for the NPU
Date:   Mon, 06 Nov 2023 11:41:48 +0100
In-reply-to: <569e39a0-b91c-46f1-b55d-c9324d66339b@linaro.org>
Message-ID: <1jy1fb9n7d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Nov 2023 at 10:26, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 06/11/2023 10:22, Tomeu Vizoso wrote:

patch title is misleading. It does not target the vim3 only but all g12
and sm1 HWs.

It should start with "arm64: dts: amlogic: g12: " instead

>> Otherwise they are left at 24MHz and the NPU runs very slowly.
>> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
>> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index ff68b911b729..9d5eab6595d0 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -2502,6 +2502,9 @@ npu: npu@ff100000 {
>>   		clocks = <&clkc CLKID_NNA_CORE_CLK>,
>>   			 <&clkc CLKID_NNA_AXI_CLK>;
>>   		clock-names = "core", "bus";
>> +		assigned-clocks = <&clkc CLKID_NNA_CORE_CLK>,
>> +				  <&clkc CLKID_NNA_AXI_CLK>;
>> +		assigned-clock-rates = <800000000>, <800000000>;
>>   		resets = <&reset RESET_NNA>;
>>   		status = "disabled";
>>   	};
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

