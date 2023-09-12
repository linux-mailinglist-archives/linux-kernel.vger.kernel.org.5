Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5D79D1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjILNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjILNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:23:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC810CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:23:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so71026051fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694524997; x=1695129797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rdjcDFmrM63pX6o+x+Wwy98XUc20ZcXO5zPneEUmMY=;
        b=U9RQIh5QnvbKPmByoTyux/ejeifr9g/YrATm14qHpYG/fY2PFUDdkIoA4OCTyeCg3R
         J43GSSx/QU3vO+Ew9iGm9ABYYD0HcTQZypsPNUeUJK1RDD/XnpMeD9oiwoK0xqNZsr14
         L2K170AmjLU0svcdwhV04UTmhNdqw5ETc0XjABV/J5IFgedJHbychtz8U4jxxrc0edDa
         CG+bMe8RrqzXJaBmre1jZ690v711j7oPKgNENHiBSpbuJ5LJORh3mW13y3fRbDK9ko05
         CgKSvZDli0Cp1PazcLQ5zah8d87Niwhq2zMUikOHBD+1KITpAa/XuLfSTstrS7wwDEzr
         wHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524997; x=1695129797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rdjcDFmrM63pX6o+x+Wwy98XUc20ZcXO5zPneEUmMY=;
        b=Avf8sfFI2tZnesWS+v2o9BDywspwu7VyTpeZDbr26Ajta+izBHCk3yBapr+IlXCz+X
         5XF7rAL/YgFZeNPR5loMFLggys0tUSijDew0HTeWscGypDYqzB0ZVB2rPPKLDc7VJsQl
         0dyV+TAvuyN9uz51csGc2ShlfiJoZIk6Ms+VI7bZ7I2nuy8kycmpXuwpkwvVBtJryIKN
         sTCnUDjeWGCPXtRU/7tzZf4jbZaP30HYcurdMSRP10TS5I99znW2LxqAXFxtiGIbJGqF
         E5O+YK2Ow2MjFzkQBeESFToYFiFdYUDYvEtor/94CoUUz1KXsnhz4gg3LirYi3oETUtM
         9Pjg==
X-Gm-Message-State: AOJu0YyiSyHw44z4BIF7xYGC+JWqFszLOYL0grKu4J7caOGDgEYWAYSI
        7Hpt75kjzK+jNReXPFAn4nVc5w==
X-Google-Smtp-Source: AGHT+IHip61uATl8A4os+5TIhcQA0bDFe3GF4eFWFFDcQjJvR8/iudTHyjqeXDEJuZT1P8RSLA1COw==
X-Received: by 2002:a2e:3316:0:b0:2bc:d6a8:1ef2 with SMTP id d22-20020a2e3316000000b002bcd6a81ef2mr10876126ljc.12.1694524997477;
        Tue, 12 Sep 2023 06:23:17 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id b1-20020a2e8941000000b002b6db0ed72fsm2007167ljk.48.2023.09.12.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:23:16 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:23:14 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH RFT 05/12] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_SET interface
Message-ID: <20230912132314.GA4160483@rayden>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
 <20230803-ffa_v1-1_notif-v1-5-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803-ffa_v1-1_notif-v1-5-6613ff2b1f81@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 08:02:09PM +0100, Sudeep Holla wrote:
> The framework provides an interface to the sender to specify the
> notification to signal to the receiver. A sender signals a notification
> by requesting its partition manager to set the corresponding bit in the
> notifications bitmap of the receiver invoking FFA_NOTIFICATION_SET.
> 
> Implement the FFA_NOTIFICATION_SET to enable the caller(sender) to send
> the notifications for any other partitions in the system.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 41171ae7f63a..492f5bfa3751 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -604,6 +604,26 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
>  	return 0;
>  }
>  
> +static
> +int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
> +{
> +	ffa_value_t ret;
> +	u32 src_dst_ids = PACK_TARGET_INFO(dst_id, src_id);

dst_id and src_id should be swapped in the argument to PACK_TARGET_INFO().

Thanks,
Jens

> +
> +	invoke_ffa_fn((ffa_value_t) {
> +		  .a0 = FFA_NOTIFICATION_SET, .a1 = src_dst_ids, .a2 = flags,
> +		  .a3 = NOTIFICATION_BITMAP_LOW(bitmap),
> +		  .a4 = NOTIFICATION_BITMAP_HIGH(bitmap),
> +		  }, &ret);
> +
> +	if (ret.a0 == FFA_ERROR)
> +		return ffa_to_linux_errno((int)ret.a2);
> +	else if (ret.a0 != FFA_SUCCESS)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int ffa_run(struct ffa_device *dev, u16 vcpu)
>  {
>  	ffa_value_t ret;
> 
> -- 
> 2.41.0
> 
