Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3279D201
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjILNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjILNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:24:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5110D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:23:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500c37d479aso9138883e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525036; x=1695129836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ji5s4rY/qOWA8pBh6XFjmkTyUce8JjhErHwecttqKIc=;
        b=L1B9MugQheqo8LDcTKJNZCjr7CgBNpq1ot2KSnyWOJxAYplpx/k1tFBet4l5JCWw2a
         cHqtVqSNVwVSr0zxaxHT83K+OZJ+8mESHCbPS6xC7oSNFvNDzQwgQhkajytmOC6jVl2l
         aMwP2Ll9exL5j4Gce384K4j3M6lT+51M01kZzn489UZhPYEJyFdBVI4fTB38G8TP9whI
         8XmqMif74jE7/j1ckduQ3pRHo40dgaruIX7oqcbyMoa/Ft43YxLQyMOHtehw8FvDanCo
         R4DUgbFxa2etDnMeMe5uhO02J3sjPaWL2RjqZXVr1EcbpiDNTlCnCo+NQlkVEyi7NdOO
         EU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525036; x=1695129836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji5s4rY/qOWA8pBh6XFjmkTyUce8JjhErHwecttqKIc=;
        b=ZVS0JQNXKfsSSGkd77v31+mBLnxh4zyVB4mBDgTSTK5k+ucNxCUnA5VRU7lovQImhS
         eU0VVNbqY/xuVuWf2GWaL466WbLGir4aDZYUQw6nn3pxqBuKHUJ4HM/2eJKlUijHO0bD
         OZmMD1wdRFPpzeDYG+80HtmsSo5UKaywYUJx9mZKS1HZUO23VK295sEgtk9ly36x2dCw
         fsOCSvwlbq9dUe/QzEmPsYlpkguk5KopTOGSuqK/t7ckbJnOAS/LqOg6j80Y6k5KJAEg
         WdUj78alC2PyOWlg1QEcM6g8WKT024EE0o8lJOaIlAKl4ULH7glbnEY0qrqSzuRDo11o
         B2jg==
X-Gm-Message-State: AOJu0Yz0dxqYOInukhyYb+RycVHxF6kp2Ova0rschzd3REtq7SLgOwlX
        HnyrQQ2wh1d16e+W+W+twAbalA==
X-Google-Smtp-Source: AGHT+IEa6Sz35ObmVh1HWZMNF/J0B3zF+9+fj8aKuRprl8HwfRhfCZW84FmsV0uJKp2PRGQf8dg50g==
X-Received: by 2002:ac2:4ac7:0:b0:4fe:3364:6c20 with SMTP id m7-20020ac24ac7000000b004fe33646c20mr9809821lfp.16.1694525035844;
        Tue, 12 Sep 2023 06:23:55 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id x16-20020ac24890000000b004ffa451074dsm1749568lfc.50.2023.09.12.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:23:55 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:23:53 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH RFT 03/12] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20230912132353.GB4160483@rayden>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
 <20230803-ffa_v1-1_notif-v1-3-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803-ffa_v1-1_notif-v1-3-6613ff2b1f81@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 08:02:07PM +0100, Sudeep Holla wrote:
> A receiver endpoint must bind a notification to any sender endpoint
> before the latter can signal the notification to the former. The receiver
> assigns one or more doorbells to a specific sender. Only the sender can
> ring these doorbells.
> 
> A receiver uses the FFA_NOTIFICATION_BIND interface to bind one or more
> notifications to the sender. A receiver un-binds a notification from a
> sender endpoint to stop the notification from being signaled. It uses
> the FFA_NOTIFICATION_UNBIND interface to do this.
> 
> Allow the FF-A driver to be able to bind and unbind a given notification
> ID to a specific partition ID. This will be used to register and
> unregister notification callbacks from the FF-A client drivers.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 022c893c9e06..a76e5d3a2422 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -575,6 +575,35 @@ static int ffa_notification_bitmap_destroy(void)
>  	return 0;
>  }
>  
> +#define NOTIFICATION_LOW_MASK		GENMASK(31, 0)
> +#define NOTIFICATION_HIGH_MASK		GENMASK(63, 32)
> +#define NOTIFICATION_BITMAP_HIGH(x)	\
> +		((u32)(FIELD_GET(NOTIFICATION_HIGH_MASK, (x))))
> +#define NOTIFICATION_BITMAP_LOW(x)	\
> +		((u32)(FIELD_GET(NOTIFICATION_LOW_MASK, (x))))
> +
> +static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
> +					u32 flags, bool is_bind)
> +{
> +	ffa_value_t ret;
> +	u32 func, src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
dst_id and drv_info->vm_id should be swapped in the argument to
PACK_TARGET_INFO().

Thanks,
Jens

> +
> +	func = is_bind ? FFA_NOTIFICATION_BIND : FFA_NOTIFICATION_UNBIND;
> +
> +	invoke_ffa_fn((ffa_value_t){
> +		  .a0 = func, .a1 = src_dst_ids, .a2 = flags,
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
>  static void ffa_set_up_mem_ops_native_flag(void)
>  {
>  	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||
> 
> -- 
> 2.41.0
> 
