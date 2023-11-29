Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5628F7FE2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjK2WIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjK2WIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:08:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A3A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso93989a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701295685; x=1701900485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czFcgcINYMlRcLlALz1qdLQDX7a+Nbpsu5OQjgSwil4=;
        b=ZfDiA35ewaoGivIccHAQy5WO76uwErQqY7DGflZJSZmhxmSL/7l5oKyh+s4oLzfq0R
         ouUkSo5zSpzzi8pgvtMrEfs/CL5tfr4nEW0/vcoNL9FNE03sE4LcassdQKS4mshH8kUi
         XtL4mUqAt/Qdx2A6O1ywxk8Nqmi17TWMbQsmSwdZ1lWRMcfdZ2GvWhKT6mgYJRMaljN4
         J2r9kgrvwS4emWtGToBws8WCTDWNOGUmUHGHd/KeB9xL+dtLe+upMOfMClW8xwpYKAmm
         u2SWxWgga++EV1hfRnsrKg1tTWuWMJLEIqi7eIPpkFvv5vjNgMdRWxtdGnM256vHySEA
         bFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295685; x=1701900485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czFcgcINYMlRcLlALz1qdLQDX7a+Nbpsu5OQjgSwil4=;
        b=vijFn50YE+D6CmnDGPuHI54t0MT8phW6XzxH8KJ/0920XwhZoAs3Tn3KkGiiahVa7Q
         glXEYtidulIsyOnadRMg0iggccD99npAf73SK+ExXZe/rl0fJKADt0imuTOf/yEAXgOO
         eMgiIAAFUD2i77dGHilKw0+Pnzh0UY2TKQbind6BgnrMc0B/FoJuPwXLwHM3F2HJ7Spf
         2soT0RYGItpPE7tAfwoSTb/ZGzhkr6Msk0fQqUWK1jvFZSRbAOQpjsF/7OQLxkP38ZPZ
         DLAJHnSNEIHisdPGXCjkDn6DjdSWYFnCamfAtQktTXvvTMHjg8iActRIqfWJsAWZMEgS
         +ZEA==
X-Gm-Message-State: AOJu0YzG4wNwO7K0xJ+QPJRmkSTApvc0J4EPoh0tFcEjUuCFWJKIu7O9
        PKeRn6URu+GSdkJpuAiGqtFIUg==
X-Google-Smtp-Source: AGHT+IF0wKBTBOQ2XRt7CEYjrQAXa3L33opCzbaaHe222xQdidkDVUFgbmVhxw6buTatWI8DLF3LvA==
X-Received: by 2002:aa7:d388:0:b0:54a:ee59:fdb9 with SMTP id x8-20020aa7d388000000b0054aee59fdb9mr13003367edq.41.1701295685052;
        Wed, 29 Nov 2023 14:08:05 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402268400b0054b2daa6654sm5165986edd.56.2023.11.29.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:08:04 -0800 (PST)
Message-ID: <74573830-627a-470b-ba31-1c2ce7e38b49@linaro.org>
Date:   Wed, 29 Nov 2023 23:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] clk: qcom: gcc-sm6375: Unregister critical
 clocks
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
 <20230717-topic-branch_aon_cleanup-v2-3-2a583460ef26@linaro.org>
 <9deb31e4-2e75-4db2-8a73-7c8b7f9ac03a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <9deb31e4-2e75-4db2-8a73-7c8b7f9ac03a@linaro.org>
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

On 29.11.2023 22:08, Bryan O'Donoghue wrote:
> On 29/11/2023 18:59, Konrad Dybcio wrote:
>> + qcom_branch_set_clk_en(regmap, 0x2b06c); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
> 
> Shouldn't this be 0x79004.
Oh hmm you're right!

This is a weird outlier.. all the other ones seem to have a 1-1
mapping between halt and enable reg

Interestingly enough, this doesn't seem to have kaboomd, but I'll
fix it (or maybe if there's no other mistakes in this series Bjorn
could prettyplease fix when applying?)

Konrad
