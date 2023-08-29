Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1178BE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjH2GBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjH2GBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:01:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F86810E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:01:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so3168242b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693288892; x=1693893692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F83pIdbIfqyxlSVPoVkO61UOkBdPPX/hhdITQlFLZs8=;
        b=bAQ78oRAZxxKygOoQmtftYeRQ/uJT72QE8yPzPbPlj24rb601ykQUwR/9HKE+EKQqY
         d/1wp9MbuTHXh1Jr1/9Uf3IZR5Bo2NSjfvf7xXJQ0w5X9gvD/q/5rRsNgAoPZ8c2Jb8z
         kR5v+K/HTItbRbY6oo9LEpX6OcAiQQ5UpS1X2dFqbKDQEff9xc3SeDHiynD8v4JlAgPO
         1yMf63amwOb33ty6xvbbKzLL4Vu4KR58obCzuDazF6o3V0ZgZT9syQkn5R23w9yk0SI6
         AbpPWN4+LT5w5csGzWknGypc7d5H1pVFhVLQgvzoVbrFVXCosMm64cH7fOMxECf6/J7W
         Wkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288892; x=1693893692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F83pIdbIfqyxlSVPoVkO61UOkBdPPX/hhdITQlFLZs8=;
        b=IAO1BRgwrKgylQmN4xVuWAWDVp1TuA3NAinzKR3BhqO7OiKcd7PpL3W16Eusr3Max/
         EyVJGDGnHMhBVkmq1uslIuCwe7FXBSruoQq3bE96Tt+6fbkrK9b39dzl1+/jwYMZESn8
         +5pfsgs7U+FyWHV3L/3/1Dypd7Rim8Gkjp2+sNKdqzkRvU6/JON48K1V4MCzxyNJW7a+
         MfRJiKMmicTtFRYIEVrkPQ0osfOiqSiuCPiupXcj/ka6Rry0oaRiNiGnJZyIjbVNfdrR
         8oZ5E2vDWtuXwk0cyyCI6HIXdlhJlotLobNftQfDlmmKSMbxyJr3D2YIfk8T98pHI0kD
         Eg8A==
X-Gm-Message-State: AOJu0YxFuRYMDzbpttQXwx2Bt8K9dsho1RECFNTIAbYjPGeGiPXdprIk
        X025iw9r01NBnfJuPDXEt6xE5w==
X-Google-Smtp-Source: AGHT+IFxjLdXPnUcO5T0rb6t84j5UnABMyWEr+XFgNfQDPDVdv1RMkyRUyDpVLfZeHjBqlxIxWGNHw==
X-Received: by 2002:a05:6a20:8f09:b0:11d:8a8f:655d with SMTP id b9-20020a056a208f0900b0011d8a8f655dmr39206626pzk.4.1693288892062;
        Mon, 28 Aug 2023 23:01:32 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x12-20020a63b34c000000b00565a0e66c79sm7597409pgt.72.2023.08.28.23.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 23:01:31 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:31:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Liao, Chang" <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix inconsistency in error messages of
 cpufreq_resume/suspend()
Message-ID: <20230829060129.ux7lbf22t225necx@vireshk-i7>
References: <20230826095201.1137288-1-liaochang1@huawei.com>
 <20230828070000.ooymfbw3qhs5xl5y@vireshk-i7>
 <b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-23, 20:31, Liao, Chang wrote:
> What about printing message like this below when cpufreq_start_governor() fails.
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..b78b509429a6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1943,16 +1943,16 @@ void cpufreq_resume(void)
> 
>                         if (ret)
> -                               pr_err("%s: Failed to start governor for policy: %p\n",
> -                                      __func__, policy);
> +                               pr_err("%s: Failed to start governor for policy%u\n",

s/policy/CPU%u's policy/ ?

> +                                      __func__, policy->cpu);

Sounds good.

-- 
viresh
