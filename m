Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B557A3378
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 02:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjIQAWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 20:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjIQAWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 20:22:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4CF1B5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 17:22:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso3196608f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 17:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694910149; x=1695514949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/mSGd0lQiQIs0ky3gsayu99HBJSZ/MEeeFtzu3vHGM=;
        b=O08KXq1StnZ0mi6ZFrkdQPpCsqRzSl2k5pgdo6ZvS3klDp8F1pkNuthmNssgEyU7s+
         SLKfBuaYk3hZUJ2dKiptJdCOnifj80kFUbnYyePY/MQYtEdJI8w3qujfbfqFRFjQvP1T
         U6FaLkv6A3FwwwiijCpXbAg8u963z9uOEKnyGgJSNtwb44j4O4FdILCdv6HuOl4HyHkb
         uZnIWYyxUpMIJjMgJF3e4+jsL0JY0KVCl+ogEZXzwohWGSoEzDtOVT6n5W2rlnJ8gyqx
         zMibd2KhoTXL8l9uUIWVCNF6Vk+8WnKrwYAz4LswNHurfdnaaHnCUBRQhRV2Vz52jpjs
         62gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694910149; x=1695514949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/mSGd0lQiQIs0ky3gsayu99HBJSZ/MEeeFtzu3vHGM=;
        b=JoqHgtfvoGinoApWxDbUsF+rXEdeBSTzFyAQSe9u38thdCUXnOkDLD8SNA+C+Vn9VJ
         OsJiqK/uksOrrJnZNIQ6lcsyRrthynrEuREmdq7VTtEIKWjaMccNM4CKVG9kvqB1C1BL
         bZW4spraqNdnIb2fGgdS5qLAIkoSGKCBsuJAkL7qFq3UImtfS/GPKITxS3ES6PLi2STr
         pEaGCCelhQqEqW7IpQvwaAHOOAS8041Ypx0KsgUl6BPDfZv07OWCkeAZS0GXpqYEfZpW
         RiBTj78vIxyz4yB/cUctLsxLAGj1ifpp0U3IdPNcboWq+5xKvdrRZQMvoE5vsdIzoD0Q
         Tm7w==
X-Gm-Message-State: AOJu0YwyOdxxHqYDF3JdYP/hILw5UrvdOSnH1XLWKXCSf9b+V1HJVfaZ
        4zkoj/qOif4S/kVb7ee0r4F6aQ==
X-Google-Smtp-Source: AGHT+IF0WUtsBTjNiyn9tDsi9lSymZ3pEuoj5cUAFdJtxACwTRWECoejR/S3RU8WWwYVNbkSljXqEg==
X-Received: by 2002:adf:e78d:0:b0:314:17cc:31d0 with SMTP id n13-20020adfe78d000000b0031417cc31d0mr4482762wrm.34.1694910148573;
        Sat, 16 Sep 2023 17:22:28 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm8412372wrs.95.2023.09.16.17.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 17:22:28 -0700 (PDT)
Message-ID: <3a66a198-5817-4c74-9047-c49e5bcc84c2@linaro.org>
Date:   Sun, 17 Sep 2023 01:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial
 device tree
Content-Language: en-US
To:     Lukas Walter <lukas.walter@aceart.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Raymond Hackley <raymondhackley@protonmail.com>
References: <20230916134147.163764-1-lukas.walter@aceart.de>
 <20230916134147.163764-2-lukas.walter@aceart.de>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230916134147.163764-2-lukas.walter@aceart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 14:41, Lukas Walter wrote:
> + +&wcnss_iris { + compatible = "qcom,wcn3620"; +}; +

Are you sure this is 3620, have you tried wcn3660 and/or wcn3680 ?

---
bod
