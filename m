Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF177D939
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbjHPDrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbjHPDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:46:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB012706
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:46:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565f24a24c4so335081a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692157593; x=1692762393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+vgvJ6TFAXdFkNnwX1pcyLIRLHR7+l39dpOnpYtuks=;
        b=Vjtos6vZ+Xbw2Tr0VGiU9Q7tOvlLA1Vlq4kJJ/ie4BZqPTb1qCXJSQswipWeok2idq
         4NuLeFnlgGUuMul/mGSpmMlEMJfNPY45WfX7hRSklPwgKbThUbDjfdC1WapaLrMN/Cjq
         23+95uYGNiAJ5VY4HAowQ8DGFX+XXrrwi9nlmcv3xSTsBsbZBRZKZrC9Ty/hGcuGTW+o
         yiy61y4/HpQnR1ZIUqnbWhutEXKAB/ofcorGqPRxjcJxB7sWMgjcS73P8jJDeNE/2JWA
         a/MLaNeEQFm7G/qvT/hVWS7HVjyF+feIGub8UsLYaeGbePz61n1gdWlGmXPcwnWZFOgw
         GZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692157593; x=1692762393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+vgvJ6TFAXdFkNnwX1pcyLIRLHR7+l39dpOnpYtuks=;
        b=NBa9CKzBIQjcobdaK+lppmb91fli6Q9WQDuWVkJxJd9lPoTXQhIHiiLXCERwAKGzUC
         Hlk/FRTvtAgiIhNdxRy9dgkxfcWL+m9TaDC9OwagC9APfICjEfHMlFZrfUYuAPEhiuY5
         DrbHKPjBD2A71rlld/5SyDn/pSXx1pzquhGlom+UABsOaRLT4xe0do24XTx0E9AGai1a
         HkERQAwkaZ0vVUfEioMwO0lMrxeuX2vA8Va+e6qsp2/r0y9HH7g1WWG/GQuczf+8tVZ3
         dL6hkrfHDTALr7DqlJaL0+LM+/lVHR9j7MiihwlePk79f2yZuxWC8yN2klbtq4rOYi2E
         4P2Q==
X-Gm-Message-State: AOJu0Yw2z7p7jaRpEf1pZD0iMfsaUiVY4GHHKXOVdC/3T1WZJ9MK10R4
        dQ0Nvp2Yt7gmwvtnQtMBY2R5cg==
X-Google-Smtp-Source: AGHT+IFAwO8zl5m4rxVLs37ZIAWJetQxo766SxNRFLdA2ZTNgvX1k8qTbU1IxGbgO+hleLKVDNNEWA==
X-Received: by 2002:a17:90a:fb4c:b0:267:ffcf:e9e3 with SMTP id iq12-20020a17090afb4c00b00267ffcfe9e3mr462676pjb.46.1692157593453;
        Tue, 15 Aug 2023 20:46:33 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id gf12-20020a17090ac7cc00b0026961746a8fsm4501171pjb.27.2023.08.15.20.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:46:32 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:16:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: Add missing error pointer check
Message-ID: <20230816034630.a4hvsj373q6aslk3@vireshk-i7>
References: <20230816030549.849824-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816030549.849824-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-23, 03:05, Liao Chang wrote:
> The function cppc_freq_invariance_init() may failed to create
> kworker_fie, make it more robust by checking the return value to prevent
> an invalid pointer dereference in kthread_destroy_worker(), which called
> from cppc_freq_invariance_exit().
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

I think why it was designed this way was to make the driver work,
without invariance support, in the worst case instead of just failing
completely. The invariance thing is a good to have feature, but not
really necessary and so failing probing the driver for that isn't
worth it. We should print all error messages though.

-- 
viresh
