Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD980B5C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjLIRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjLIRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:54:14 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDD10D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:54:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so4196814a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702144459; x=1702749259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvHND4P/HoZ0eN5ekFdH68Ldcd5nj6SfIoXhqMddDPY=;
        b=I4xr/Iv6SLgHHpwdkZtQCtK4UjSqyVe1HwfXmM7YRkjlRRrcSunBkhcVCzgj/gQt4c
         ZGxal6YgS+6Y8oPmPvGTSilrUfyQJgD1uHTQ5CtzxLYLH/iBLg77ny/zvSnjSC3XwdaS
         NqTJ1rphqOhZ8449ZshDQLWin1gOejFml1n7SQxBswVY7S145nrkI3hN9JVth6AF8dCh
         RIUzSByM+R2gyiQ473lGLr9AzPmrSLyH1879BpUvsYmWkWvDe33FIhrFi+rUUKQsLlpW
         3UMNvbtXi2Z9x9fmjv0YEzCNKNaw2sOul/2/+TahAdC6MAprQDidhE+hrtLDM/MXoogP
         +aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702144459; x=1702749259;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvHND4P/HoZ0eN5ekFdH68Ldcd5nj6SfIoXhqMddDPY=;
        b=G3VX4zdgVHdm0u4TwgGLZirMgJYIuMn9elBE6NCxv4tFlPJjYoSD73dewKn+yuqwC9
         UGpXfvjByJzjThlWu1f+R9SbjIp1hLKfsHNkAes41OSxj53IbRI8whxIvnJ9wYE90Sid
         9QKN4cBVdHE1DVl3toSJi4PS8GecT3+i9pZ1YltKvDBBLBl2SGBRsJSHWhEBr1ZCCE8y
         oTzc49iCTDGNC4eVOkBs8bMEYE22L2MqV5ovFCsF/reJIG9pXjZF+kMUxdcou4F5BFWt
         7dx7zoA3+nUz26jiuLZNtv++EKbS9S7lhkX9Wyr0sh7MRVH9dnl85LxBkrCqOaJwBA4I
         ZqNA==
X-Gm-Message-State: AOJu0YxNI3ptJA03f6SlOvwSYr1VmfPFFdW3FnBnvKr5aey0CJGhe9o+
        s9m8vTFuRtgRUF5m8vtFHxuI1g==
X-Google-Smtp-Source: AGHT+IFbUBIScunhp/10BaKOKvxkgMMwaF3LauB+6T2wH4SVYcWBBxfmq1CkdZ3cs0JM9TjOOGO9cQ==
X-Received: by 2002:a17:907:6190:b0:a1f:6761:c8dc with SMTP id mt16-20020a170907619000b00a1f6761c8dcmr796454ejc.124.1702144458937;
        Sat, 09 Dec 2023 09:54:18 -0800 (PST)
Received: from [192.168.36.128] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1bec12448csm2457107ejc.150.2023.12.09.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:54:18 -0800 (PST)
Message-ID: <3f921a53-8eac-48e6-be17-43c07a0313d0@linaro.org>
Date:   Sat, 9 Dec 2023 18:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider
 driver
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>
References: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
 <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.12.2023 15:35, Stephan Gerhold wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add driver for interconnect busses found in MSM8909 based platforms.
> The topology consists of three NoCs that are partially controlled by a
> RPM processor.
> 
> In the downstream/vendor kernel from Qualcomm there is an additional
> "mm-snoc". However, it doesn't have a separate RPM clock assigned. It
> looks like this is actually the same NoC in hardware and the "mm-snoc"
> was only defined to assign a different "qcom,util-fact". In mainline we
> can represent this by assigning the equivalent "ab_coeff" to all the
> nodes that are part of "mm-snoc" downstream.
Worth mentioning that snoc_mm used the same clock as snoc, which is not
obvious with some of these older designs:

static DEFINE_CLK_VOTER(snoc_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);
static DEFINE_CLK_VOTER(snoc_mm_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);

[...]

> +
> +static struct platform_driver msm8909_noc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-msm8909",
> +		.of_match_table = msm8909_noc_of_match,
> +		.sync_state = icc_sync_state,
> +	},
> +};
> +module_platform_driver(msm8909_noc_driver);
And you may want this to be a bit higher up in the food chain!

Otherwise I don't see anything obviously wrong, I assume you tested
this without clk/pd_ignore_unused, with rpmcc cleanup and can confirm
the QoS programming went through without angry resets.

Konrad
