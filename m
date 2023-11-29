Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4E7FE18A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjK2VH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjK2VH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:07:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB210C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:08:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3330fd19820so161967f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701292082; x=1701896882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9jFHV2GrUp0ps1JJpB9xoZzEO2eSz+0BnDBZmO9bUs=;
        b=bIWoXVpYSzInobRl43VhJAlIO8YRr73ZKFHAgmlKmt1c4cmNsBflJsAjGTq7q1Xtlr
         Q6j39YnZoIXl3SrOqQ1rgo+O37S3lWSqBLA7gedBE4VldroTVAaaFvIdj2WZaJ6Fb9Lr
         5Bc4qGWdg1N6Ww87GaxTSOg1Zzs7KA3mt7S/NWzCXBF9MCHMdhu1nbRGOZVunecVMLt7
         9fGZQ1Eg513HZ1V+cM5WcuQfYNQVnjevZRLNZaA7gu3yFNxMrx+NfiibVuQMfwQrQ2Do
         9I8oLP8mZ+k4y3nvpkLiXSGuEmhjUsRTB3M3ZnQSGkN8mTyxHwyVjADCpSucSBQpelbC
         psDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292082; x=1701896882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9jFHV2GrUp0ps1JJpB9xoZzEO2eSz+0BnDBZmO9bUs=;
        b=P3a9+MZD9DfZutgbnHtil0bAB1Yz4eE/WgX+wWV4JmmLaNAb78sY2D/PtKBhU6UI8n
         ghk6zv/m6B8zhfDYhWb8HO8Nmw/V4aziZjHZJA7rUcaNBA5/TjqeE3z+I+dKfvEGZg2F
         VpM07MEeYVSNL1TVuB9GZ9/lYkzWFehK49sI8U3B2fSBo3vLVASFioJsDfkY8wCg7Zll
         p7QPhGJFq0hAF5+NK+YZoAuswLroMy4wXQB9dCuRTigj3PQhd843lOqBo7jwYt9QhSpe
         DV/zm4/jsRsv1j3dp61QUEYPlTQSY9H20ydjRDOSVh/lCAgxDFxzciyMHYC8Qs3ZXDRo
         AD5A==
X-Gm-Message-State: AOJu0Yy4pVCvkM19sZiJACT9U2OOtTTLAI4d5HSLcqd8BhSntXISxdQH
        JS+a/jbju5ZR8iPVbgwVC2l4bw==
X-Google-Smtp-Source: AGHT+IEpKW5T6Mdf/X3bYFt6X7XSBnY76TN2RB3vLijvMEL2ZkKnEKMVbKRqdV8Xk1Wnk5wdvI3a2A==
X-Received: by 2002:a5d:6a42:0:b0:332:c585:400a with SMTP id t2-20020a5d6a42000000b00332c585400amr14557007wrw.44.1701292081556;
        Wed, 29 Nov 2023 13:08:01 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f2-20020adffcc2000000b0033315876d3esm3082637wrs.12.2023.11.29.13.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:08:01 -0800 (PST)
Message-ID: <9deb31e4-2e75-4db2-8a73-7c8b7f9ac03a@linaro.org>
Date:   Wed, 29 Nov 2023 21:08:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] clk: qcom: gcc-sm6375: Unregister critical
 clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-3-2a583460ef26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 18:59, Konrad Dybcio wrote:
> + qcom_branch_set_clk_en(regmap, 0x2b06c); /* GCC_SYS_NOC_CPUSS_AHB_CLK */

Shouldn't this be 0x79004.

Also the logic here is - since its currently marked as CRITICAL => its 
fine to just mark it as qcom_branch_set_clk_en() which I guess adds up..

hmm

---
bod
