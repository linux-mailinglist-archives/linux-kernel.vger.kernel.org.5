Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021767CC8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjJQQ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:29:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E071102
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:29:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so61137601fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697560172; x=1698164972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwqQGMN0bypddmjCukp90urvyt3HMvtNQrPUO31Nj68=;
        b=tEDTo92LcVeFIYbGkXK/Ec7MwJ2Z+NPKM6SF0OFr1o9l4OCRWDFfvSXV0DspH07+K3
         kiJzrMHR3MPkAkf7/iflxjXdtF3Cb8M+4sl1UuVIyiH7M+fopRSO62r6PYjMJ/lHv78m
         oI6z81WGlpwPzWHqA01TkNpj2FMCrNVrlT/8sLmR25pcajlHCRM3nQU30GWJQJQBOI0u
         xOCoFoqHyfw5LSf0Zx4M2GvfEUD7/CT6b+Q7GJxpO4+oaw3NeDoXvO38H4hBpLCGlnFo
         JhlMnHbuXTXXJdX+HRmx9uUO7Lv3Qg4ajpeB+Z9qWRjeDHpE9ptgsEp4sriRo2w6LBfT
         s5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560172; x=1698164972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwqQGMN0bypddmjCukp90urvyt3HMvtNQrPUO31Nj68=;
        b=exElatu5XLJhBDMGckA5uwf+OLIenMgecrKmvrM6RPPeiCwQA2cNmOSWrHSASThbYf
         Hb8Gb72CYVAeLmjJtkz29BS4hkr1Vyqeoizj8XP1RDQ3g7SiK7U6jXMbDrtYRIp0M9jz
         4Mu8h4vhm3U6BIj9dSJabKGZEmyITzrnb1BUxHYgcsZWfl+oh2HUoSVoCsF+lqZ2Wyq5
         y9nYNGIrEeDXc3fJIaFWc3jCf/hTaxB1SKeasfM9vh+PS1x3XBXCe6gPdTU+53gGTF/f
         SJ/oqYYJ7NLQEqAHt4ZbvtGEmQiWf1gqCfY+wbzpBsWUPHFLdZRWnPNdEiFD/CkhKdQZ
         vQcw==
X-Gm-Message-State: AOJu0YxviJv/LUkdaGeePLBbtCz9Gzc1jYGSrEDs30OHoHsxVpJOJMt9
        pfdNU/+vwd/EDixV4HT2AQus9A==
X-Google-Smtp-Source: AGHT+IE6knn2uSQzDBY240t/lWRRIIzKQOj/ZXJZ5ZlJFnZ+aS5Zs+m/wIsdNKpb4NeemLWD+BdWdg==
X-Received: by 2002:a2e:9d42:0:b0:2c5:18ed:1802 with SMTP id y2-20020a2e9d42000000b002c518ed1802mr2054074ljj.34.1697560172301;
        Tue, 17 Oct 2023 09:29:32 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b004063d8b43e7sm10257184wmq.48.2023.10.17.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:29:31 -0700 (PDT)
Message-ID: <2a8e20d9-2e00-4d89-ae99-87e5b49bb220@linaro.org>
Date:   Tue, 17 Oct 2023 18:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Enable TRNG for SA8775P and SC7280
Content-Language: en-US
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
Cc:     neil.armstrong@linaro.org, agross@kernel.org, andersson@kernel.org,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org, vkoul@kernel.org
References: <20231015193901.2344590-1-quic_omprsing@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231015193901.2344590-1-quic_omprsing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/23 21:38, Om Prakash Singh wrote:
> Add device-tree nodes to enable TRNG for SA8775P and SC7280
> 
> *** BLURB HERE ***
Generally you want to delete this :)

Konrad
