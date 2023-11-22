Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E17F4BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjKVQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjKVQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:02:49 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C081BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:02:45 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso36180471fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700668964; x=1701273764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vr2sj29czR5v6hlCqTmdn2dM09cmk1PbJ4WRUrk7U7k=;
        b=l+bUqMyMU3Yrl+xQHlrNAnWTnkOny9MU11O/GtSryeR4qakdjciGn1xyhhqfqZ55sU
         qYEzrGLy0FC5lXd9sQ5YfnpXik/G+I4ntO7pmIAQE2i/lhTO2G/0NEueoJ2glM5mprvL
         XgbSkipkcQIWWBwir0aJ2907Hnm1z2eXwygmgGhEWVnX2on+e0qIZzeANOLB8pOQ1LsD
         LMC8bygv9P8+ZXvBCKAJleaMIBXDU+z5faHoDoOc7RLIExVkoqieQsYJcA4Yyn2MdMPP
         XtAOfZW8+pnknub6pRdWtILFKBBXcAS7bmC2uWGnD6RGs9EUa/U+rDRdxtY+/+zF4MhU
         qj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668964; x=1701273764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr2sj29czR5v6hlCqTmdn2dM09cmk1PbJ4WRUrk7U7k=;
        b=L1VSmz/s8Qq2BCsko9xS19wfanj9LVixp4kEi/kHFNkDCBugHqcyVwRLUOvtuH2AGa
         ukiL//wj2LAjOKohH8Wgvb58mQC1GqBj8YiPA/hcnnAu20Nq2lqlofiq53OzMuijSLVS
         sMdxAXtD/oK06HAfnyEFhsupCyZPZHy3Jih9GD2OhpycQU5a4RbXi53huaSs18MYQc0z
         n/OJxZTSzGxxjeyKf3wbPmMrQi3J46mXjn2yIMVdhFo4zwRkV8rbM557lgzdZ4GG8WGk
         5e4cskbxWTKTnQ3QXtorFU8V0PXo+IxA/k3sTtjMfM27IQjuhRZyy9ssv3BQfg7/Mf4s
         ivew==
X-Gm-Message-State: AOJu0YwWtNrQ4I1oRsstHMZR1tfY1vZqZp6lB7khUnECfrOD752EVDdj
        +V5ZeACMbFEMGYyaRivDw1iTDg==
X-Google-Smtp-Source: AGHT+IFBAFL84SqNmL1M5tuvjN7IgtJnctX+MYg6x+eGXmvT3bimGFiGLwQDQLi+kvh7pV8m+IGRpA==
X-Received: by 2002:a2e:5c43:0:b0:2c8:71f9:4ae8 with SMTP id q64-20020a2e5c43000000b002c871f94ae8mr1984517ljb.5.1700668963701;
        Wed, 22 Nov 2023 08:02:43 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651c119b00b002c8787b3ac3sm1091916ljo.103.2023.11.22.08.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:02:43 -0800 (PST)
Message-ID: <2b619607-1219-46db-a439-0f087b8b5d3b@linaro.org>
Date:   Wed, 22 Nov 2023 17:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
Content-Language: en-US
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 05:28, Satya Priya Kakitapalli wrote:
> Update the test_ctl_hi_val and test_ctl_hi1_val of gpu_cc_pll1
> as per latest HW recommendation.
IIRC there is SM8150 v2.1 that's there on most devices and v2.2
that was used on the Microsoft Duo (or v2.0 and v2.1 respectively,
not sure, don't have any device on hand to read it back), do these
settings apply to both? Are they different for mobile vs auto?

Konrad
