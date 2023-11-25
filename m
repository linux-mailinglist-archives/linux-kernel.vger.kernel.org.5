Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3F7F8C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKYP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:28:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A24101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:28:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50baa2a278bso615561e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700926122; x=1701530922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+9qVNr/VUwknbnWPngJyNBv+EpK6pBAV+6jnHif/dw=;
        b=isccZI/osEFyX5nQzOrrtilKnjmM/b+9gCVzcHMmmtcSWDhB7YwlX1B3zow9Vd34cn
         v7Niy2+9Xs+Xdi+CaCZ0QJC95beWJ+OCB1b/f1mXyTzzNZGDxrfDgcSrpRIKxhk7YWq0
         6C3yTOzvbnXIAsH4xkL4NM90qS6pZbhahUhIDbC38I4NXawdpbevyUZIlpbv9C9VGzoE
         vJ1pup3MxLW7CxU+74CZdbFXJwTuvUoPpzcPyvR4kf97wJcK/+riCUhHiRcg4CB122rP
         MrgdOlncScbVnbqQZKsP4eziK12lNuCc5MfKc23a96zRnC61Mrjbv7S57ssJLXTVdS6F
         MT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700926122; x=1701530922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+9qVNr/VUwknbnWPngJyNBv+EpK6pBAV+6jnHif/dw=;
        b=qEaumbGfBpVpb8v8IMMbgmbDnU/xMWFUr9zkoWYUyL2R+5bSFkZF3EkhhMy3HB8xdL
         lisfrfz+7EUOpTFF6QLk50DoBU8PFE3TXLMtdyg7p3HBQ9IMoWlh2J/aTSR7rg8hP9VO
         ltSl22osrkZWymBSdpmSGWNxYFCREZcnDTx70ZYbqmvjOWTKgxulLEUXXDT2YQ5NDyWP
         UjQ6TX93tD6zVAcZG5hAbiHco5feUvFDzbSAz5GHPrWd2/XBjbz8t7RXaYuHHqKFhHOz
         x8/zjB188cFtC1rSsdpIRJMO56GWbObSwfspqWxJeVQehUBUK/sUMTMavj2ymHHPvMAZ
         ROqw==
X-Gm-Message-State: AOJu0Yz8BJJLoSEZnpluaguiHJkCkDwZP5//rIhVuJlSz9zx1z50RQgF
        EJIZFCu0AkZmfw89UrmYiCQkZapLXp5MS80xCXU=
X-Google-Smtp-Source: AGHT+IFPbgtWDAGY08ECUdPqlroywV9S07BWnQCqgomommRXM48zqKRNXDzARmhlR7L+2P8Diin2zA==
X-Received: by 2002:a2e:2e19:0:b0:2b9:ee3e:2412 with SMTP id u25-20020a2e2e19000000b002b9ee3e2412mr4828741lju.22.1700926122424;
        Sat, 25 Nov 2023 07:28:42 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id dk12-20020a170906f0cc00b00a0c8cc6fd75sm514133ejb.126.2023.11.25.07.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 07:28:42 -0800 (PST)
Message-ID: <36316a86-4ac9-4f4e-a01e-15792a8d71be@linaro.org>
Date:   Sat, 25 Nov 2023 16:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
 <20231120-topic-rb2_bt-v1-2-509db2e28e70@linaro.org>
 <d8cd02e7-7e85-4b75-b48c-e9544d03c197@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d8cd02e7-7e85-4b75-b48c-e9544d03c197@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2023 16:04, Bryan O'Donoghue wrote:
> On 25/11/2023 13:04, Konrad Dybcio wrote:
>> Enable the QCA bluetooth on RB2. It identifies like the following:
>>
>> Bluetooth: hci0: QCA Product ID   :0x0000000a
>> Bluetooth: hci0: QCA SOC Version  :0x40020150
>> Bluetooth: hci0: QCA ROM Version  :0x00000201
>> Bluetooth: hci0: QCA Patch Version:0x00000001
>> Bluetooth: hci0: QCA controller version 0x01500201
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>> +
>> +        rx-pins {
>> +            pins = "gpio11";
>> +            function = "gpio";
>> +            bias-pull-up;
>> +        };
>> +    };
>> +
> 
> My reading of downstream has all of these pins drive-strength = <2>.
Right, I'll fix it up.

> 
> 
>>       lt9611_rst_pin: lt9611-rst-state {
>>           pins = "gpio41";
>>           function = "gpio";
>> @@ -508,6 +567,26 @@ sdc2_card_det_n: sd-card-det-n-state {
>>       };
>>   };
>>   +&uart3 {
>> +    interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> +                  <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
>> +    pinctrl-0 = <&uart3_default>;
>> +    pinctrl-1 = <&uart3_sleep>;
>> +    pinctrl-names = "default", "sleep";
>> +    status = "okay";
>> +
>> +    bluetooth {
>> +        compatible = "qcom,wcn3988-bt";
>> +
>> +        vddio-supply = <&vreg_l9a_1p8>;
>> +        vddxo-supply = <&vreg_l16a_1p3>;
>> +        vddrf-supply = <&vreg_l17a_1p3>;
>> +        vddch0-supply = <&vreg_l23a_3p3>;
>> +        enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
>> +        max-speed = <3200000>;
>> +    };
>> +};
> 
> Does firmware name not matter here ?
The driver figures it out, see
drivers/bluetooth/btqca.c : qca_uart_setup()

Konrad
