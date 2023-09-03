Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A10790D48
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjICRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjICRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:33:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABAE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:33:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3433548a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693762405; x=1694367205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnbIqa3QLa9uMxTPmoPwXfavhfYZLupOpY21IJJuDrE=;
        b=smEw1RozG8Fh6qlFDJwaE656nkKjcqlZDa/aXxhbD137rQ2JjOF6bSNSfGF1dV3qOc
         61QBt29LXyL1CuIzyGhhWJcVShWN0LkdiP2lqXAVmNQodFgd6OLo5eKLCdCJHLGVizct
         0Q+tOBDE/+p1p8BSmrz7Di6am07A9pKsNgOuv3fAqXfUUMiRFBe5B1Xsb1vSPpCN6FJh
         lO+8PYQ+7mi1/5oqQUC34AwuDFj4Um0oPeYOV+QVkt8G/DPqghuaA28umxNY2Vl0vA23
         cHzksLam5QMUqCed77S3oRO6v7JVIiXAW57tBuDr2QmEJs66xhfkhQsdLQosW11BK5jK
         gwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693762405; x=1694367205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnbIqa3QLa9uMxTPmoPwXfavhfYZLupOpY21IJJuDrE=;
        b=h7ah3BEj7Cp9oZ/jJ8+zE21Gx+1tW+/g9MtmGKBG43LHRYtoIqWpX5q3XvsOLg3tEF
         ZrjTg04aiOk+UQljvszVVrHyJjIlIB+jr/tZ/Me8k1Vmv6CazsoPecOc/sDeXLdCOksb
         DTyYAd69BJJR71vWSuG0+gqN0OS0ba51Tia/RQyPViUxZ7SvA6aQVT9wG7YICgwsb31X
         7rv85oGD/KwRt7l/qhLzgdiy+OY4G5TUd0/d82YQ8fIeNrstmlR09/C4oB+l9RxZ1YO9
         tWWUMBkBQ51qgiC0trx2uXj2uy76JzxiFju4iBFWkwItE4gONeKKsucxo/qOJZb0Apig
         TAgg==
X-Gm-Message-State: AOJu0Yz6dbjP02s6EjzxcQhp6hgu6hWtg0+0MkhnEnxRNdIZg5GUNI/B
        SptR+inX7K20oYMsudgV0/LNPA==
X-Google-Smtp-Source: AGHT+IFGB/BXefKvYXzHo/yhCqX2O412qIh3xyABISAk69aKJTwnVi8a9Uu/LOHlUTLSJPmKVOvD4Q==
X-Received: by 2002:a05:6402:396:b0:521:d2ab:e4df with SMTP id o22-20020a056402039600b00521d2abe4dfmr8939077edv.19.1693762404933;
        Sun, 03 Sep 2023 10:33:24 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id t3-20020aa7d4c3000000b0051bed21a635sm4730574edr.74.2023.09.03.10.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:33:24 -0700 (PDT)
Message-ID: <100bc802-b706-e923-463a-705522650ecb@linaro.org>
Date:   Sun, 3 Sep 2023 19:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/7] crypto: qcom-rng - Add support for trng
Content-Language: en-US
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org>
 <29fb1e51-1e18-4e45-be64-190df52e1156@quicinc.com>
 <3d09f47f-b0b8-4429-944a-df3de19c7a6c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d09f47f-b0b8-4429-944a-df3de19c7a6c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 14:56, Om Prakash Singh wrote:
> I missed to notice. Please correct "-" to ":" in subject line

Hm? What do you want to correct? The subject prefix is correct, why do
you ask to change it?

Best regards,
Krzysztof

