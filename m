Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156527FE2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjK2WF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjK2WF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:05:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11507B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:05:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00c200782dso34242166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701295529; x=1701900329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8E9IL2rTxndKeeYdbk/Y9ijp2mjFLxuDcVfuc0PDkA=;
        b=LPt0dBlKTevtKSW51sKJS4ObsJ3Y3vdw2pRZa/9sVpBSo3P3rn8ObBHf7e5FtLLTWF
         mir8+WNBcd8cgCez3qdcLcbPGkX/y/pB8buIp1aYlPnTZgb0g0DqCNxVADZ7wEJFV1w0
         nBUiFmMyzQveIF1F2QJil4FIfkUGCtKQLh40a5ZCTroedwZgFJx8VEV5GgJrZh8tHEWL
         7cJlhQEuS8U6iGLNxzkhblA1/tFCrPZaGncokweAH3IRI0Ii7d3PhXZ9ghqoEUd90hGS
         c8nuDR7fxehTopKgqQ1hE4OTk++HlghB6txkSlED7YExyUHDkdZelG0vh+S5A3JCT5J1
         mHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295529; x=1701900329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8E9IL2rTxndKeeYdbk/Y9ijp2mjFLxuDcVfuc0PDkA=;
        b=b80si7NE2qhESf5tYFn3hJE/jcTJ27eUrVlqp1LOsGIKO1cVUl7fS+Z5oSjQXArH+C
         RMOwp5Zr1bbhydy5zu4AWjNcbnetpf9K7vpXxnqf+0NsCguFBM8YBeIrsHGyO0HScU3f
         cLrgHTzi1jycAhZgk8u55wa10g+yCsUk5jLwIYnkeb6jbXzEueU7Pbn9T0Q7PPN84dmd
         /Tl4x5MUVaEJdEkFrnIKdKnAJB42BLIPKDIbWqsmbUb3SD5WEP0GmKhFgKRDZK5i7b5d
         PX0f/NLHseDS7me5A4Sk4MK4Hx0By4gjIjVeqZxBXj+/69aqgUmAr6vioK3Gt98U429y
         X96g==
X-Gm-Message-State: AOJu0YzvPK4kYBdXR14efAej28tynCXvdiubykdNf2uhAZ7tQ42lIZF/
        k+CV3DgqOmZMsPat16GCs12tWw==
X-Google-Smtp-Source: AGHT+IHp1xHIT3Z6mxSnIcv5khsVGARx/xfav8jOsoXU0wm8E9P2e7iKmJBS6C+khsrmnCdwgWaxzg==
X-Received: by 2002:a17:906:51dd:b0:a18:7e19:5347 with SMTP id v29-20020a17090651dd00b00a187e195347mr11591ejk.47.1701295529518;
        Wed, 29 Nov 2023 14:05:29 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709063e9400b00a0369e232bfsm8274504ejj.75.2023.11.29.14.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:05:28 -0800 (PST)
Message-ID: <27380394-093e-4b8e-94f8-a1eefc72a020@linaro.org>
Date:   Wed, 29 Nov 2023 23:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] clk: qcom: Use qcom_branch_set_clk_en()
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
 <20230717-topic-branch_aon_cleanup-v2-2-2a583460ef26@linaro.org>
 <d65653d1-e7f6-45c6-ba2c-0ef973866ffb@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d65653d1-e7f6-45c6-ba2c-0ef973866ffb@linaro.org>
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

On 29.11.2023 21:59, Bryan O'Donoghue wrote:
> On 29/11/2023 18:59, Konrad Dybcio wrote:
>> Instead of magically poking at the bit0 of branch clocks' CBCR, use
>> the newly introduced helper.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
>> -    /*
>> -     * Keep clocks always enabled:
>> -     *    cam_cc_gdsc_clk
>> -     *    cam_cc_sleep_clk
>> -     */
>> -    regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
>> -    regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
>> +    qcom_branch_set_clk_en(regmap, 0x1419c); /* CAM_CC_GDSC_CLK */
>> +    qcom_branch_set_clk_en(regmap, 0x142cc); /* CAM_CC_SLEEP_CLK */
> 
> This all looks functionally correct to me, wondering what your motivation for changing the comment is though.
Perhaps I could have included this in the commit message, but:

- it makes sure ARRAY_SIZE(clocks_in_comment) == ARRAY_SIZE(clocks)
- gets rid of different capitalization and wording between files
  that triggers my OCD
- also makes it easier to see which register corresponds to which
  clock, which is especially helpful if you wanna validate the
  guy before you

Konrad
