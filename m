Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA27C4E66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjJKJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjJKJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:03:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEDAF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:03:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3247cefa13aso5979800f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697015029; x=1697619829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBdHg52RbcScFIWBis5JPCbs4EFwutNb74y5hFI3muk=;
        b=XguleccvBkRPE/5miciF2rgnAiYT24fQPpEtPCtkcV2Bo7JQEWBbUM90f5SIO4VluE
         KN2feLXk1DDVz0Kmgz5ESr1OjXb3mfLQFAWYqvRMt4YtW8vMi3R4BtZwUloPoox++Jd9
         3e/xxaAkNpH0ue/0V+k6y2XS7LlxPkBADqN0WiO4dFrUh9Nbhac2A/k5p4ejI1CT9bB4
         gp1I5sKIMLuPL94bx0nvUn5H/Ft7CSj/mPNFQzkMRoonZHclG3/UB7rUCxrZN6w5Yt+K
         H9lMMEBPfivrf8g3XYho6IaqemAzn8VSbJVm3esah0AL69JotQyl2u20b0Wjz1hVhFNQ
         SSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015029; x=1697619829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBdHg52RbcScFIWBis5JPCbs4EFwutNb74y5hFI3muk=;
        b=Ewt3AWWG8uAJrLqaBpM1TBX2yFMk54GTzgv6vsbWsVn4FiFCSCJpYAVAjvRRuxB1+P
         iVQJaH/fNXsL4mUw/ytxLluzmc00bZHYJyMfZP8c5cjWdRxKdyxn3K3mvnSloba+REAr
         0so4bM7ygwLDd1WC4rdzpkQ0j/CSg5xtv6YGAIulQBZ6rk1EmZvcqd0Q6Tn/8aDQbQwr
         y9D9lEbzvfGo/Zcyh58gJqO72obYImA9hyCmMRGNQ+8sG8H+y26kkdXKam6v/5q2BpS0
         8wy9u7cxBLPpk/woHxqyIaDh+qaFaLMtwGla1ZeTelyx/J72I38I84OJ8aP2qZ04rZo+
         +1jA==
X-Gm-Message-State: AOJu0YyqYOLMlctn3D5wwOkp9HyN1hYbjoJvrjXZumfXVewv5MsMZJ5I
        FI/gKtdfy8GY+cf/n1tIy0tDypPghro8e2wTec0=
X-Google-Smtp-Source: AGHT+IHhC+dSe6ZgkjkRRcDm2jaYQvv0w9SRi0lllA0IR+H8hw0N/vi7sDbjg6OeQmo/Z+HXKoyvuA==
X-Received: by 2002:adf:cf0a:0:b0:321:6bed:1646 with SMTP id o10-20020adfcf0a000000b003216bed1646mr17841695wrj.14.1697015028906;
        Wed, 11 Oct 2023 02:03:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5d5392000000b00326f5d0ce0asm14827181wrv.21.2023.10.11.02.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:03:48 -0700 (PDT)
Message-ID: <96da3e12-7d40-458e-9f65-05606dca201f@linaro.org>
Date:   Wed, 11 Oct 2023 11:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] clocksource/drivers/sun5i: Remove surplus dev_err()
 when using platform_get_irq()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 06:14, Yang Li wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/clocksource/timer-sun5i.c:260:2-9: line 260 is redundant because platform_get_irq() already prints an error
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

