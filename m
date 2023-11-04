Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2F7E0D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKDCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKDCHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:07:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F4D52;
        Fri,  3 Nov 2023 19:07:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc41afd376so5226245ad.1;
        Fri, 03 Nov 2023 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699063627; x=1699668427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxi0Gs7OIv7LWO/6I2/nImKNusdC/LABFouqVtsbWJs=;
        b=DdnHURhl8/4vtHrSPZVBJ+EatZDhBg21q5eJV4EtHcaTLzrTHoCIWruT1xSk/qlMPl
         z8hMld8+J5c8udJo0Ct4xvMKqJOBR8ba9+dIXJWJH8l1px7kbKL8KTni0aE1zWIJdyDs
         8fgZMA4IaQ77V3lYL1GLP61F2uS9K357Wz9G0SlOcWxCxqnZuRM9tAoso7qbg3t1JTyF
         eMenA1awprbqcampnyyHMYmbmDCTn2SDaHeflEQwuT4nZgdnUv1yLQZDLq8KWII5n0zi
         ZS3n8k6Dza0LjGeAeF899J1PitrhJmByali39hmcGwXRNcf3e43E1rLn+XM0/RrtlDpU
         oFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699063627; x=1699668427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxi0Gs7OIv7LWO/6I2/nImKNusdC/LABFouqVtsbWJs=;
        b=jvqsSLKPoMulpV0gwAIr4hWot0sFE0gNwA0JozAXc4yS1MZp3AKx7xOCSBn0c6q+Kf
         zd8MqsIBNF+J4zHm5n3eq9BWGyOi+8C5tyJTpUOwTdgHndg4BIYiLHhoqA3EFWyHuNRR
         PPu4DxivYS/TUmYKrKhhs8d9XqtzEjKeM+jntZFG+5aARi9+ZRf5jc+se/XWGFKioALW
         UmSUrcM7Vx3Z4o7pe4Egel+4zA6Uff7Vs3QdPZ8699HaIi7meAW6LR4HX93E2P2tlLkk
         9P2aFExAQmxinBuleFO/MaGHi5DEesSn/UMXEjaIh8h7meZOZEszrwrZ4vS7m6Mu62Xa
         Cqjg==
X-Gm-Message-State: AOJu0Yxf3/ii+eeekZzxT/VwzFtLJUYw2mGdsBMIBk/jXUZhksBPCopD
        8AtvynbelR0bhwhfeBJcsUE=
X-Google-Smtp-Source: AGHT+IFu3fzxmNsOBhQSVlJMq1kvan238IDuAh0e/CzmAlXHWQ5w2y+805jtSjbeDjPS0xtFxp13Zg==
X-Received: by 2002:a05:6a20:5483:b0:17a:d292:25d1 with SMTP id i3-20020a056a20548300b0017ad29225d1mr29991031pzk.6.1699063626928;
        Fri, 03 Nov 2023 19:07:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a0cca00b0026b46ad94c9sm2105077pjt.24.2023.11.03.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 19:07:05 -0700 (PDT)
Date:   Fri, 3 Nov 2023 19:07:03 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWnR6T6RZfc6LeF@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 09:15:03PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption, use mutex lock to avoid this
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted together.

Oh, now I see what you are fixing...

> @@ -138,14 +143,19 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  int ptp_release(struct posix_clock_context *pccontext)
>  {
>  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
> +	struct ptp_clock *ptp =
> +		container_of(pccontext->clk, struct ptp_clock, clock);
>  	unsigned long flags;
>  
>  	if (queue) {
> +		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +			return -ERESTARTSYS;

I don't think it is a good idea to return ERESTARTSYS on signal here.
The release method needs to succeed.

>  		debugfs_remove(queue->debugfs_instance);
>  		pccontext->private_clkdata = NULL;
>  		spin_lock_irqsave(&queue->lock, flags);

This spin lock is wrong.  The spin lock protects the queue, not the
list of queues.

The spin lock/unlock needs to be replaced with mutex lock/unlock.

>  		list_del(&queue->qlist);
>  		spin_unlock_irqrestore(&queue->lock, flags);
> +		mutex_unlock(&ptp->tsevq_mux);
>  		bitmap_free(queue->mask);
>  		kfree(queue);
>  	}

> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 52f87e394aa6..1525bd2059ba 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -44,6 +44,7 @@ struct ptp_clock {
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
>  	struct list_head tsevqs; /* timestamp fifo list */
> +	struct mutex tsevq_mux; /* one process at a time reading the fifo */

This comment is very misleading.  The mutex does not protect the
fifo.  It protects 'tsevqs' from concurrent access.

Thanks,
Richard
