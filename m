Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA17BA565
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbjJEQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbjJEQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758023530
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:57:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso702505b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696503469; x=1697108269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cDRtKnd/4diHbjlhPc0Xt/Y0fuLcZWAs7MWCmgie4k=;
        b=buXhQQ3idmiv7NOcQMJ1dMF4CYjdrkMg8EyCZX4Yn2X5iPf2ixPllq1z3LM1o3RATe
         v0pPAc9G4vOvXSe+YGCQ8XfZK5HDbkP0Qmujl5mwTNF7e7aymM88K9qtxYn+BXptC90h
         ArkS6dkQ7rdgZjEYnzSN7HC+4dVLR5cAbdUT5rfyZqOxVJwM9zFgLAsrxdupMJojkfL1
         fNg5nxIjgohW/y9xvXt+MS2/YenX6b6/4TxhNPehHCYpeaEZmYK7UpWfAXUVSAW4vb9L
         57nYQjDzukmlTzsv/pYtVItmbWgaYAEaK8AKbk3WqTvh4AkrTnWYw/h8NrJCP2LtkyRx
         s4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503469; x=1697108269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cDRtKnd/4diHbjlhPc0Xt/Y0fuLcZWAs7MWCmgie4k=;
        b=CLIkbIjqd24+XxtrVgMegEMM0oKNRodl9smnj6nVtY0JO2e5kBAsEyckG7YhDdRwbt
         TQMG0nm6Fj4IHU//AnGr0w1ErYrMcqxPkJ5BTNpCQIZAZOQuml6Z6CrKqFiXmAgK7umy
         i9TWR1yqWcYAmQ+6iI4rF0C7U/sd5oedRIpY73UDzIwlXJ1skwx0XHMKOzy1D9a5q7lB
         F+txPwLTVcecfhP04KtQ6IVK29i+qjMUzWW7yWN2S6BFa1JCWf1SCk6lYlpAZ6N4GQ5q
         cyH7W1BelwRjPspOuGtePsQ23oz0nuKEY8DDG+V2OgnLl6bULW/Qb8lz8fO/d0ptMQrp
         dahA==
X-Gm-Message-State: AOJu0Yy64S5vVB9oBR2jquT6I5L4nXF2JHZ146QoVsYos6mpbT3ACtIk
        Ao0FfDHTPgdrRfd9RXpp3Gtxiw==
X-Google-Smtp-Source: AGHT+IFIoveqW8638epw2bxKQUXtW3HEDC9HlLThX3FOfrwhD2GggsQd21dYCdaH96/Y6Gff6NLFuA==
X-Received: by 2002:a05:6a21:4982:b0:160:7679:90 with SMTP id ax2-20020a056a21498200b0016076790090mr4019045pzc.56.1696503469704;
        Thu, 05 Oct 2023 03:57:49 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79397000000b0069348918cfcsm1081690pfe.193.2023.10.05.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:57:49 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:27:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Ensure requested_freq is greater
 than min frequency
Message-ID: <20231005105746.ikezg2buza2qwvig@vireshk-i7>
References: <20230912060957.2516790-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912060957.2516790-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-23, 06:09, Liao Chang wrote:
> The governor ensures that the requested frequency is greater than the
> minimum frequency when the condition for decreasing frequency is
> satisfied. This is done by either reducing the frequency step from the
> current frequency if the current frequency is greater than the sum of
> the frequency step and the minimum frequency, or setting the frequency
> to the minimum one otherwise.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 56500b25d77c..54e09242b2e2 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -130,7 +130,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  		if (requested_freq == policy->min)
>  			goto out;
>  
> -		if (requested_freq > freq_step)
> +		if (requested_freq > policy->min + freq_step)
>  			requested_freq -= freq_step;
>  		else
>  			requested_freq = policy->min;

I think all we want to ensure here is that we don't end up getting a
negative number (since requested_freq is unsigned int, it will end up
being a very large freq). __cpufreq_driver_target() will eventually
set the freq to policy->min only as we are using CPUFREQ_RELATION_LE
here.

-- 
viresh
