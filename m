Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F67A48FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbjIRL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbjIRL6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:58:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49CE7E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:54:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so70277501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695038069; x=1695642869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XTuYj+doNNU72YBaw1CaA5ZGAyKTkm1rkVWPnny88Q=;
        b=husEoK37/BjUPjxFHJwBJP6/Bx+o+1hbR+eXQmf2CzIupYDlJ3kZh/Clqye2WB2tZ1
         TBrkDT0NcFHjBBPMtEhA5pi/2H/BhAqlbFNED+WjTQ+xMqJpK1hD/XcV0/fLmRPCTPw5
         nprAjjHdPqjB1RDo3Emm2o7/ZsavqsqI6u7t6EHsYoerp39yIBC55kbpPggLcLiCfc4g
         aAzWqqTsiMveQQKquVx83VI1DLGn970hRsrZFO0rRv0rqxolr2mEXPScqkOipyAxG63E
         /1RJTblZzuTGtL/hbUnkhl5J+lXnnxZzzIvPICw29IL+q+lY/ak5b0SqR+exFLm8OpK3
         5EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038069; x=1695642869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XTuYj+doNNU72YBaw1CaA5ZGAyKTkm1rkVWPnny88Q=;
        b=Xp4A7TeqGYFMTDFt+txUYxVZWa9dGSnHNEB1tTRYk5uYrlS3DcBh0whJ5gA+Ea9TD2
         Zj6t5Od76RFh5KVdEg9r4jqjjmLixnicETvMt7bx0/WxQY/xGNTrwQIDuGgM8KyyMHTy
         8xja6ZMww0Y84qyu8r1pqKfH5IyZ87zf1wFWk4jfDWsJK7HlnA9SlnAazRFVdU4nNc3Y
         GRubaKj9ZBu2OXmsZZURxoo/iUcgYVwXgBBVzTHG7DO6K0r4GioA8gbkrzqgeabDKJHC
         WhTUBWd5rs5IBBM3lFsleW2GrtrumPGywZ6GGwosDInmQ234+uXrNUW7ENr+Z4CQr/TG
         LV/A==
X-Gm-Message-State: AOJu0YwM/ZH5c6FVVipFtyEPIxOsFkHVz8uNfqElltLDPXd3Pyr6/6vF
        Gz0TNxfTwYq+LhvWuL3zTa2OEg==
X-Google-Smtp-Source: AGHT+IFFJVzuNiojURIGIa0Y2S0/cv6X2tyb8l1Ch14n1dQLx1ebsX7rXJSwkNoFewVC8Flj1/YkLg==
X-Received: by 2002:a2e:95cb:0:b0:2b6:a3a0:5f7 with SMTP id y11-20020a2e95cb000000b002b6a3a005f7mr7882460ljh.9.1695038069338;
        Mon, 18 Sep 2023 04:54:29 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906198b00b009926928d486sm6324008ejd.35.2023.09.18.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:54:28 -0700 (PDT)
Message-ID: <b71c60f2-6781-02fa-ec31-13060af05c7a@linaro.org>
Date:   Mon, 18 Sep 2023 13:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock controller
To:     Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-8-quic_tengfan@quicinc.com>
 <c4e95307-3f09-5704-e5ea-cb42befb9921@linaro.org>
 <1a7fdafb-e75e-46a1-94be-36a9c3c94c15@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1a7fdafb-e75e-46a1-94be-36a9c3c94c15@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 12:34, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:22 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>>
>>> Add device node for RPMH and Global clock controller on Qualcomm
>>> SM4450 platform.
>>>
>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>
>> Warnings in your code:
>> sm4450-qrd.dtb: clock-controller@100000: clocks: [[28, 0], [29]] is too
>> short
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzyszrof,
> Want to know how did you find this warning?
> I cannot find this warning when I do dt check(make ARCH=arm64 
> DT_CHECKER_FLAGS=-m dtbs_check) or kernel compile(make -j8 ARCH=arm64 
> CROSS_COMPILE=aarch64-linux-gnu- Image.gz dtbs modules).
> 

I just applied dependencies and these patches, and run dtbs_check.

Best regards,
Krzysztof

