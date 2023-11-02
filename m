Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EBE7DE937
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjKBANA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:12:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291DA2;
        Wed,  1 Nov 2023 17:12:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2802a827723so84626a91.0;
        Wed, 01 Nov 2023 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698883976; x=1699488776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfBKuNksNHLjnR8vZzwlwmZccmO5T6c8vdS1D1icGUk=;
        b=EFAi7JHlZDozP2KtKFHlZDz7cazb1JNQBgQpYcS07kzqcSkA0aApLF2eOa+ARMHmGB
         unZf7ZKiUv53QyCIR2SDoFbOAcSCc1d2npIj4R3es0Efk3tp23BOsyeTTGyuVzPVE68e
         z49sDjubm1XFJpIuY9T/vClm1Kyg9+tNGrEWY8LS0ZvuibgQT35u3rNFz8FzLOPAP5f6
         3fCLwvnKU1q6HX2tyNQ+MRS7xC0byRG2iAjgrVbuyCObTBPqriPazCDVkUGLA6UOoVuI
         9d3Aum4lTflncdyGtHylqg1Ir+tYLgQUxZqG5g8RvaO6UPDJQPCc8L+Ss77/XSurXpkL
         WpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698883976; x=1699488776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfBKuNksNHLjnR8vZzwlwmZccmO5T6c8vdS1D1icGUk=;
        b=StkkCUqJTLH9Q35XVxM52MwACilmlF1m+9+L2EnYviNaOaG1HWxlZFiGBY6NvTiVQm
         M39CoemMh7wgowvBdDG3wqDE4deDG557amDMc+l6gc41Iod07XmSAuMk6p8v/bl3foIP
         mCwluG0ZdaFPtaLPnjVFTeULolgrhtnm4SIA/N+BS8YIdgfFmsioIkvIqmSPkC2Wp7nB
         f9znOXTJZpF7BImhjlF5kBI5UrpdnT4RVJFiHInn+GscIrcQpy4T8zK7c2Z9c0r4ancY
         YfUes108rNt9oDBOjhLcnnO4Jm5IutG5r3xKcMtVP4xE2Uha9Y8Tnh7cX5/Oaoug1u5O
         AQXA==
X-Gm-Message-State: AOJu0YxuZY+FgoMRtMxY607CP4Aocj1QuuRBY5pum66qfzIubDyzd8ky
        0IiwaL2fnOxMuwlMVuVNTos=
X-Google-Smtp-Source: AGHT+IHkD7k+c6YPwblb3i6N0f9xkmLGsdG5rq4EKNUCtW867USh7ZCQvEICIix5vISGjeaGGxzIKw==
X-Received: by 2002:a17:90b:812:b0:280:1d2a:acc9 with SMTP id bk18-20020a17090b081200b002801d2aacc9mr13917706pjb.4.1698883976450;
        Wed, 01 Nov 2023 17:12:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gg9-20020a17090b0a0900b0027d0c3507fcsm1342492pjb.9.2023.11.01.17.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:12:55 -0700 (PDT)
Date:   Wed, 1 Nov 2023 17:12:53 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZULphe-5N0M5x_Kk@hoboy.vegasvil.org>
References: <ZT65J4mvFe1yx5_3@hoboy.vegasvil.org>
 <tencent_24C96E7894D0EBA2EDD2CFB87BB66EC02D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_24C96E7894D0EBA2EDD2CFB87BB66EC02D0A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:07:08AM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption,

Really?  How?

> use mutex lock to avoid this 
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted together.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/ptp/ptp_chardev.c | 11 +++++++++--
>  drivers/ptp/ptp_clock.c   |  3 +++
>  drivers/ptp/ptp_private.h |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..e31551d2697d 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	struct timestamp_event_queue *queue;
>  	char debugfsname[32];
>  
> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +		return -ERESTARTSYS;
> +

This mutex is not needed.

Please don't ignore review comments.

Thanks,
Richard
