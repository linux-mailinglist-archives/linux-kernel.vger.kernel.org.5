Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFC7DC221
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjJ3VvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjJ3VvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:51:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7BFF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:51:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso7581127e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698702668; x=1699307468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+i0ZPrNW1oXlJv0V43Xxb3tYdTNJ/c4Q2gcMWYRfwq4=;
        b=EcTJxrAoJopW9AmKYK+IlnIRlIdG+0emgd2KkWh36ZOgnYy+K5Ts/+VGRhJ6l+o7ih
         Cro7XeKXZJNSWu/wm6n9fz5EhfVsQ9RfbBFGf9kLdMIHvdmXBoQCpAn+G2VJC/HrAeSd
         XfR6/wtfZi3PoSxEli8uvDWM3yXhrHwVXc9Xl9UeuTQ+kG+JJs7G/tPtRs29g/l8fzTG
         Cw/A05ouMYaz2YJMz8rOGi6ZFocD4AihIsh2VoDW2ocuMOxHjlVYy9QLko7Aj3OlFjp6
         7HpCHgzb8qVaqwwgklv9HfJO/JA3lgROwtC638L5N5Q696+oKKAEhDX9XAiBaUZQIHiy
         vPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702668; x=1699307468;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i0ZPrNW1oXlJv0V43Xxb3tYdTNJ/c4Q2gcMWYRfwq4=;
        b=IxyhVW26w/O7PHShXLPdIN4CoCKL9PFwKRMFXHj0zyeNs/cVb6WK3GYSq7DaIWIuUS
         mmBH39jLCKfIcHjeLFzxq52vYiBUVGF6bCpxvFt+mqJrv8ahnhnN3j0W+10JQJSaG7wu
         wvSC0qKmsikURMmhRU5GhwbxBzbErw/PFlpXDivJ46tiQPOn1TvezRUyrYWVpf8q8qT9
         D5D9VGnDXcyVpuDcLoQ/eQS4blQdquKNC7ulVmu+VRGAgKKdQy06fxgsiJwOEw0HFsNy
         Pjb/VVbbMhrANk8OmkGzVQ4tjzsZihle7DPKRNtHIuXQwFdKu8+nPdfIcd8+HGLCkTHl
         HlJw==
X-Gm-Message-State: AOJu0YwRJjAwxDhOYbhDj8Px6jB2wRZlUZP2ATl0oJPwi4fVI/dvW0Eb
        QDavsVZc2Hg9KiEJrobToxxuOA==
X-Google-Smtp-Source: AGHT+IFmE6ztU2Q6zdkf1gJY8NFYriow0ELTB1pszbg8s2vqp3M0zhuSbTLIyoyXRVcM1bqTSGcHzQ==
X-Received: by 2002:a19:6746:0:b0:509:dd0:941a with SMTP id e6-20020a196746000000b005090dd0941amr5060062lfj.11.1698702668031;
        Mon, 30 Oct 2023 14:51:08 -0700 (PDT)
Received: from [192.168.133.160] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id s2-20020a19ad42000000b0050794b05c8asm1560841lfd.42.2023.10.30.14.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:51:07 -0700 (PDT)
Message-ID: <db624c01-a48c-4a8f-b9ea-548b25aa3091@linaro.org>
Date:   Mon, 30 Oct 2023 22:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add sound
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Nikita Travkin <nikita@trvn.ru>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-3-5ff3cf8b5701@trvn.ru>
 <c2ad06fd-805f-44b9-bf4d-806ef20f272a@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <c2ad06fd-805f-44b9-bf4d-806ef20f272a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2023 22:50, Konrad Dybcio wrote:
> On 27.10.2023 16:42, Nikita Travkin wrote:
>> This laptop has two i2s speakers; an i2s audio codec for the headset
>> jack; two DMIC microphones in the lid and the displayport audio channel.
>>
>> This commit adds the audio node that describes all of the above with the
>> exception of the DMICs that require in-SoC digital codec to be brought
>> up, which will be done later.
>>
>> Note that the displayport channel is connected here for completeness,
>> but the displayport can't be used yet since the HPD signal is created by
>> the embedded controller, which will be added later.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> [...]
> 
> 
>> +		primary-tx-dai-link {
>> +			link-name = "Primary MI2S Capture";
>> +
>> +			cpu {
>> +				sound-dai = <&q6afedai PRIMARY_MI2S_TX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6routing>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&alc5682 0>;
> Both RX and TX going to 5862 interface?
interface1*
> 
> Konrad
