Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B8806F96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378015AbjLFMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:21:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FF9A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:21:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf26b677dso3700780e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865317; x=1702470117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRL0Ao9tIX2xdAb4wLhDX52vA5hRbA+Mw6I9EfOJmcE=;
        b=WtQocJpdLVrigO/G13omNs/Os1g2g1S+iP0JIhiKcl98dJcgxm/HO6bwBvptvChKaN
         m58l0n8So6ECFFZHZqpImoASuE6QWcw5yoJKgiCYx+ThXv8/p0106XvyJXBBTnF6Ribf
         ZwOqrRagbXJ+g0tDZEJ7/j5sWx/ud3+4EjQAo6RR3PCtxGVrIBHPNU+UU1GnJ9MzM52S
         m8RXaAah/jqmMbl2qVSPQsVm7RTB9neanDiT9Eaub8XrFPBujOfAliXsybbdHTl1bqET
         uXgeYlagGO2HDz7g5u3Tb5EtXAhlP0zZaROQxnkOO8bJIw7QPfGpPH17Io8pKSCkm458
         aGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865317; x=1702470117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRL0Ao9tIX2xdAb4wLhDX52vA5hRbA+Mw6I9EfOJmcE=;
        b=X/NiTLPXb37WEiYo9nqmNsyQ/uRKkx3RFF30SMgX34OQtZW593vuC2qEwYbs8CVk+0
         25dvpLZrnEFcd5LKnD6nfdtMnut3g1cFo6ddb6mkhdVrtFhG64saj5iL2odZBOsqH6Ov
         0Ilzro8tN3gSvAjkWhJKaDcCnyc3Ws3rpDjEIkBjVlGKggnQE2GXNGIjx2JqBdUqYZl0
         3bjSti/K+eLgQr9Pnbw4v56zg0o060PF6LkpcXU/Ra3xlQTnz3Q/zPz5yxiO4WjykC0q
         zzoEulF/dkY5RXn9bx3xjp2xbZm9lsRkAz4F4g/D4qpZw2OiZSgur1RhE1dKJHCXzN7r
         CR1w==
X-Gm-Message-State: AOJu0Yz4iMRc6rsyigZxnAngajTa3t9hNHRJ2Q9EC+n1o9ac7dZUGD13
        lhOxn3hsFkQV2Wwy57SIX/0RiQ==
X-Google-Smtp-Source: AGHT+IE3pfFZZOuU8lGP2EAKE3UZF/LYWmm4X3XfFPC5NZ1C8IPxZPF5bLg7IqYGOHCvotUcQN99wQ==
X-Received: by 2002:ac2:46d1:0:b0:50b:ffd5:cd32 with SMTP id p17-20020ac246d1000000b0050bffd5cd32mr390466lfo.175.1701865317051;
        Wed, 06 Dec 2023 04:21:57 -0800 (PST)
Received: from [172.30.205.186] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512309300b0050bfc6dbb8asm755053lfd.302.2023.12.06.04.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:21:56 -0800 (PST)
Message-ID: <335ac19a-f341-4ab9-8ff0-6e25add21fd8@linaro.org>
Date:   Wed, 6 Dec 2023 13:21:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: stats: Fix division issue on 32-bit platforms
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
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



On 12/6/23 01:44, Bjorn Andersson wrote:
> commit 'e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")' made it
> in with a mult_frac() which causes link errors on Arm and PowerPC
> builds:
> 
>    ERROR: modpost: "__aeabi_uldivmod" [drivers/soc/qcom/qcom_stats.ko] undefined!
> 
> Expand the mult_frac() to avoid this problem.
> 
> Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Thanks, I keep believeing mult_frac is generic enough to work
on something else than arm64..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
