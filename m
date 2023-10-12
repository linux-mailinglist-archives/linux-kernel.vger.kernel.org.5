Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0031C7C7254
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379501AbjJLQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379127AbjJLQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:20:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF7CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:20:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2029096a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697127599; x=1697732399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNdRrL2lHxhThNPZvRkFJ+lJM4hbLTuDXZgSRjthoBY=;
        b=B2OHq24zxx8Olto6B2dwKCCzRdpmaN5nNb/IEk3tLgr2Txrue1/hW6YF2NCxcJ/Bgj
         luMVGKXFrcai6fsEAte+146gG0XMJi7OeslXmULS2ZG07mODWE1VtLfGvjWK2om4LOzr
         ZRXO6rhxMdgNqOSxlqUmKce7cW2oMo/jEs+dSLKOqQpu9LDCs8l6zEslV7e2BXDRH/qL
         UuydfZI10G3kE/w9z6lBfi8AJMgzeUCGyj27QM2GovSrwxwQZyPixIxZ5AHGXEsNBMtJ
         YnFqogxGJoUggxqBkoJ8OhpmZg2h8ZW4Bjl67HmmLGL/m3b2FlpHQnEkdzhwTZfavCOn
         bwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127599; x=1697732399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNdRrL2lHxhThNPZvRkFJ+lJM4hbLTuDXZgSRjthoBY=;
        b=JIB3D/h1DFVlQrbkZIBDBrLnFIxXVm/cGdgCr9yL8z+xHBTFkaAYZnYDOVrLEU0EHx
         LW9yEDftsHKx4AxR6iZiHPFvPrLnTByeVpdmh02InnNrWW4zUB4v7UWXbwoRAe44NBV7
         DmVAM7Hs4/RiQf0jTQV/BBshNckZyFSKDx04HDcBR0VEgoXuxAmQLnSIyZX1PnOFsdVZ
         8A+LtZ/dPrfzPv1QlFkGzsMDNfdOhQXLRkfGXcW6X+5ptnzzJRjPKF4UQYBalvpXE3AN
         Kyb5F5wv1G+yzgZHj3As1dik7GaZSLK9pNw44LgSO1OlAr04zmWVHXUryIzrrz4MnrW9
         2hWQ==
X-Gm-Message-State: AOJu0YwmR4l39XcSDkSfBEhZ1LAvljaZl/y0Bqiu3k4EJZBHcuM1+DQC
        Vz3hOn/UKGhIbJziN78wXaH4gQ==
X-Google-Smtp-Source: AGHT+IEfXg5su3hHbXAWyooXL7T1iT+D3jNRN7LrMIHRp8JCYhHv8XeV+kJhWtbwYXUcGRPcklBIbw==
X-Received: by 2002:a05:6402:25ca:b0:53d:be55:602 with SMTP id x10-20020a05640225ca00b0053dbe550602mr5583110edb.3.1697127599660;
        Thu, 12 Oct 2023 09:19:59 -0700 (PDT)
Received: from [172.30.204.175] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7d3d2000000b0053420e55616sm10457118edr.75.2023.10.12.09.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:19:59 -0700 (PDT)
Message-ID: <30f2aba3-7ce3-4d1a-9ca0-08391cd57c73@linaro.org>
Date:   Thu, 12 Oct 2023 18:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] PM: domains: Drop pm_genpd_opp_to_performance_state()
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012152108.101270-1-ulf.hansson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 17:21, Ulf Hansson wrote:
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-> level
> dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API, while a few genpd providers are still
> assigning the redundant ->opp_to_performance_state() callback.
> 
> Let's clean this up so we can drop pm_genpd_opp_to_performance_state() and the
> callback too.
> 
> Rafael, I would like to take this through my pmdomain tree, unless you see a
> problem with it ofcourse, hence I need your ack on the last patch in the series.
> 
> Kind regards
> Uffe
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
