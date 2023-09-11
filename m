Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6279B27C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjIKUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbjIKQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:59:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E922110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:59:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7faso55038045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694451572; x=1695056372; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=b6zpEfFwTnyi86KDgClkEQHR3xaNBEnZrwWpoCsbQ28=;
        b=RARINvHL11MYZnNct4IXAzzWSq8gUqr9PhVeMGIkPC3R9BqpRgy0BsxcLRXruAOMSt
         VVtucy2AqLK49jwMQCcARNFoVK/Dyy35W+kF/TMM+56izSlT4j8nJYzkLO8d7yQweIWx
         f984INLuJXGu02LZnlxi/2+yHK1HsNaD16CdZYJ1vlRK7j8xZkM5qCFjW/uefXuVJlVf
         e1bmkZzCpXuvEwyJuOroR4/l4zspB7PPYWjQ+QmcBwP2QY9uHrLylr3Ro4DD7cAmU2+y
         MIB2mKPw17L1pwb2mfenuvkxz4yZ4xeqskM8+JwmsQCG+oX7++J9KLLmegjBgnldJEKI
         tQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451572; x=1695056372;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6zpEfFwTnyi86KDgClkEQHR3xaNBEnZrwWpoCsbQ28=;
        b=g20ELJDf4rKUkmhFW/HtC3AKYLgYAjtzuKv8r5aCzxPeITP32diyKpBMl0Mb5x5eat
         rN/oQ8p66V2ev10A/CiWeyUAei98J+kaZmnCxFiTJ8mETOPwZ31G6BzQwCvEfFHLCAUS
         Rz0REKOYamCmJ1470iY1ik8Ed4kbrhPgxjvEax7I+nD1F7BJBHCLZqavPA2lVt+/y7xo
         02EY2t8Hz1757lUfIFlHa8uzPiK4dfWCcZSRalLKy1SCZfeeETbRduW5P3rXBCD2ojY6
         tfHpj0IXBrt2CrhTQ9nDIQtBCM4gP+KmKgawfknQ6/nROgfTscpGTm9COBfxkqVLkyPC
         nEoQ==
X-Gm-Message-State: AOJu0YwjtlEQC/zBXnluDtV5ZZlrkzKRPW4d30d78Kf/L53SIF9oyHrH
        vhl4nRFRTEG/E6MnbbErWepHvQ==
X-Google-Smtp-Source: AGHT+IEd7G9QslE1ZtHxoDPCKdw54RbxizV0I6HFmOXEbzd4jr7xHnnQtJ22ouuYqItKPr+D/yJB6A==
X-Received: by 2002:a7b:cc95:0:b0:401:2fab:43e8 with SMTP id p21-20020a7bcc95000000b004012fab43e8mr9096813wma.15.1694451572036;
        Mon, 11 Sep 2023 09:59:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.gmail.com with ESMTPSA id r18-20020a5d6952000000b003141a3c4353sm10655684wrw.30.2023.09.11.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:59:31 -0700 (PDT)
References: <20230911154541.471484-1-jbrunet@baylibre.com>
 <20230911154541.471484-6-jbrunet@baylibre.com>
 <eedc9787-06b7-bac5-a1f5-ba07d23f4ac7@linaro.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 5/5] arm64: dts: meson: u200: add onboard devices
Date:   Mon, 11 Sep 2023 18:52:44 +0200
In-reply-to: <eedc9787-06b7-bac5-a1f5-ba07d23f4ac7@linaro.org>
Message-ID: <1j5y4g4pe4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 11 Sep 2023 at 17:56, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/09/2023 17:45, Jerome Brunet wrote:
>> Add missing audio devices found on the u200 PCB. This includes
>> * Lineout connected to the internal DAC
>> * SPDIF input connected to a coaxial socket
>> * TDM input decoders allowing output loopback
>> * TDM A and B output encoders and interfaces
>> 
>> TDM A and B link format is set by the related external codec.
>> Internal audio DAC can hook to any TDM output.
>> 
>> This change does not include support necessary the optional the speaker and
>> PDM Mic headers
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-u200.dts      | 228 +++++++++++++++++-
>>  1 file changed, 218 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> index da66e2e1dffb..9abe37b5b227 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>>  
>>  / {
>>  	compatible = "amlogic,u200", "amlogic,g12a";
>> @@ -19,6 +20,22 @@ aliases {
>>  		ethernet0 = &ethmac;
>>  	};
>>  
>> +	dioo2133: audio-amplifier-0 {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "simple-audio-amplifier";
>
> compatible is by convention first property. Do you have different style
> in Amlogic/Meson?
>
>> +		status = "okay";
>
> status is by default.
>

It look odd to me too but this was be consistent with the other codec
introduced by the change being fixed by this patchset.

>
> Best regards,
> Krzysztof

