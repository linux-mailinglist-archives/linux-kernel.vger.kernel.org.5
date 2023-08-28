Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28178A632
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjH1HAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjH1HAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:00:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F44113
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso697854b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206030; x=1693810830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vfwMSV3M2jVbk57Zy8xKYqiE3TDHtOD5X6Ij0rVlz4=;
        b=h3S+R/9Im/IaY5T4tnUUvIylcaCQt9xIwY/XtdTDjr4Uujrd8DMitpC1yaiESDeGli
         OUnZxlte0WvufMtvDDLvBKD2CykaFSkhNF7a+uAOTG9mzjA/d5OI2PG8uW9NfrEgqxlZ
         sP9BjxRjgtiO+Q55FJIZrmdMom1GHJLDDa/kJbWGkQFoDM56FBZtTcdReCmx0wgvnvbR
         HR1P3I+2dC0/yolitRVzN2cwN+yid/JMKyZmUTxvkv/hgkFWLG5F3kp9fTheGQMC/mqt
         CZOytqA0mByNjP0V0Ht4eBdWP25bKGDvB5ClHsHIvM1/MAPYZt3XPCysVcZ7LAE+eL8O
         0PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206030; x=1693810830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vfwMSV3M2jVbk57Zy8xKYqiE3TDHtOD5X6Ij0rVlz4=;
        b=kLiXqPs3zV4YqbQ1j/7AWFv87LbGmvQecxMip2VQbSZ3UfE+2I4RlFshyLXBrsM93A
         8ja3nBZHc1UGw9iktgrLAHoWZZ2b/Qn+Dc8kbfqX1q7PU1a0YlLg/wBufyAhMjBzC1Zi
         CRDywEv+psyP8LIi1sis9lM3u6pjEFTnfxHznxMFx/rsEeMGXI33QaEyWCI1ytqa9E1O
         7kdf2vinssdkw65p0TbP3LS6PiE9Yr7FOGbQei2onbmRfSbXzENg9xJ67GkCHUC4oAXn
         F7G3ZFrotLyilv1Tkllwn0NWr1un92ENQvKTDiOKkMhoXVN13IJDueyEx/oC0WsXk0Bp
         lmJA==
X-Gm-Message-State: AOJu0Yx3mB9A/sKmPZTBx+H4XlF2cpnD+bHazIa+r5FIvketqu51Sh2b
        lQyyYORrPW4Jk+FAksMlzjNe/Q==
X-Google-Smtp-Source: AGHT+IEEaP5llFOm07McErokY8RFd//IKiWyQYQBKZY1sMSZVBeIDKDlLK45RfsBdYpqtxyNJrYQMA==
X-Received: by 2002:a05:6a00:1a8c:b0:68c:3f2:5ff8 with SMTP id e12-20020a056a001a8c00b0068c03f25ff8mr7980842pfv.1.1693206029915;
        Mon, 28 Aug 2023 00:00:29 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b0068a3dd6c1dasm6077525pff.142.2023.08.28.00.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:00:29 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:30:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix typo in the comment of
 CPUFREQ_NEED_UPDATE_LIMITS
Message-ID: <20230828070027.gdinkbswbnn3jg3e@vireshk-i7>
References: <20230826095455.1137604-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095455.1137604-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-23, 09:54, Liao Chang wrote:
> Replace 'diver' with 'driver'.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  include/linux/cpufreq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 43b363a99215..43c771e502d4 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -407,7 +407,7 @@ struct cpufreq_driver {
>  /*
>   * Set by drivers that need to update internal upper and lower boundaries along
>   * with the target frequency and so the core and governors should also invoke
> - * the diver if the target frequency does not change, but the policy min or max
> + * the driver if the target frequency does not change, but the policy min or max
>   * may have changed.
>   */
>  #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)

Applied. Thanks.

-- 
viresh
