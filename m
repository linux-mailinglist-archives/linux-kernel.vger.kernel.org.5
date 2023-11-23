Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393417F5DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbjKWLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjKWLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:37:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9099F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:37:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507b9408c61so1014000e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700739457; x=1701344257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm0hbEIAX6bA2MYwiGpkCXzOiz2e3i3AxzXDyzNcE4Q=;
        b=RquwW1Ye3p1aVNFGsir4oDfm3BgrCV8QmxTC8hJ1RH3pT1kGkQIA5tz0WbYMvLcUAu
         TaaVgbysVT7zCe4i3Xp16pwNQk/BwdjWBeHz/jRQswjTlU8YDbzrjs7P83tBiW2JO2Qv
         dF8BC/q4sLVB1lQlbf5teKrUnUU+8hZ2s+kgCBcCy7Y9PNASAF0YC9+eh3XiyRdyvCzR
         qEH1ncyKsD/u/eXS9mO05PLVxAcp763+iC/e2pOQbdb9ZSMYKLohkvWkhGp2tlKHUpJg
         vih/ZNjVW2ATJuGPCup1pXii+/Eo0G6+SgloAYzwXJ8rDF/Saa9hkhZhBHs1pZSyvt+m
         U7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739457; x=1701344257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm0hbEIAX6bA2MYwiGpkCXzOiz2e3i3AxzXDyzNcE4Q=;
        b=bI1Vro7Mr1bXrSUJNuokSyuE341dd1m0938V3hi3jVaHosfwyxRBZ9Czp8ty9E/eWn
         fLcG+QshpChbSu7HWssJHyvPSCrA9MOSFEtkbMxZO7M+SpsVa6ibRitc8M1XhN8QqGJS
         I1c6ld2CER0Ujk2aOpDbbnY10th0Hc0obnWDbMVSl+0hAWu+9FVzwmWwcluuMR/WXXc5
         jFkNtkcHJeamoyv9rNiSGgiETh4ICF4i+1YizwtjN5nRwdDrDsoR4AgN23EIdsmefsHG
         X32AgzLzTvbgTeiZhC+g2ZUIR5alFyTrp9TH8Sl/g6T7Vjj/TAVc/dfUX8Y+Z9v7xPpL
         6+Qw==
X-Gm-Message-State: AOJu0YxxNLFHSCj9MVe/8aGqRkKZ68/YWoPYSh0Wr18d+yYYX/Li9MNZ
        S9ybKui7b49gYEtOS85SnCfngg==
X-Google-Smtp-Source: AGHT+IGVn/cRKB4SR5kspsiZK5lcGwtL1/UJAwGrszDITZYjaYkgwg7kZEfFdYmBBnxpyjbBVu+e8A==
X-Received: by 2002:ac2:43a5:0:b0:500:daec:2817 with SMTP id t5-20020ac243a5000000b00500daec2817mr3796344lfl.54.1700739457263;
        Thu, 23 Nov 2023 03:37:37 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x15-20020a056512078f00b00507a96d17b3sm167232lfr.237.2023.11.23.03.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:37:36 -0800 (PST)
Message-ID: <70836806-5228-4b32-be97-f00a476bbe47@linaro.org>
Date:   Thu, 23 Nov 2023 12:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/gpu: Fix null-pointer dereference in
 zap_shader_load_mdt
To:     Kunwu Chan <chentao@kylinos.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        daniel@ffwll.ch, jordan@cosmicpenguin.net
Cc:     kunwu.chan@hotmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231123033329.27477-1-chentao@kylinos.cn>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231123033329.27477-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 04:33, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Fixes: a9e2559c931d ("drm/msm/gpu: Move zap shader loading to adreno")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
