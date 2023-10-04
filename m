Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C97B7B61
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbjJDJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbjJDJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:12:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBE98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:11:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso342112866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696410717; x=1697015517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdOdPPFMdcei2S7fb8cUUxol5V7FnF0pUPc0MzWLtwM=;
        b=eRTp74y3HaboucgV4WqVJfo7fRzQqVlA/OO0Am/guxhc5mToBw8/HgerSSLH/aVRsY
         AU6cV+chlewyM3dFPepu4mNHkugXFiLflpR4Pz5KqxC1PHAhiELapyGQNmRKB319NljH
         ltcYUxrZJMVFWENmHJCkeL6H5PDwsZK0n+wXHeFRztKNL83lXr/HUnn6DFvVHkPwEMld
         Xqa3WCcaca2UhzqgCxDbi8h9ylZp8+ngCyw0ov8a2aePbcN8SRxnHLfMr/LMqIhLRVAM
         w+AsU8rC0gMNJwouRDgEKcCPQDva0MsQ3RfPesBGqWxeIhNWBFPyIqb82SLAVwS0jR5+
         h7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410717; x=1697015517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdOdPPFMdcei2S7fb8cUUxol5V7FnF0pUPc0MzWLtwM=;
        b=HmL+kNNxFHaqfYETimm52BVFwHuy1nkV8iYF6/OXjTXg67vRlqAO27l7dDqIwvk3lq
         5sT8IPzrngkO5Taunw5Q0zq74EL9dDV02m6+A42c+5HxXyhIbHRHTQeLYptOVL/hY5Ss
         G28Yi9VRPsuTAdCPJmLhk4h0TmSOPRkU/2RIKOWHNSF901kpPflGT1pMn03Isxh/NuPR
         7fgZ8vrQ7nkWdKi4NgiLq4RrJMko1ghvgsb7h7hEymVgWMDUyCWamqEo0VSApcOZVgMW
         9CUIcbEzfymBSNh1Pn3EkSFnDTQgnzdu5ULiUG4I3z5YoIc3bxXM5vvsJJYpKmOjnaXv
         43YQ==
X-Gm-Message-State: AOJu0YxG3BwkVuuukVzJLyvronsU6SGUsghOP2mwhEPx58zDFX2Ugror
        B0cl9GxloYVPOptL0nQpkIbr4Q==
X-Google-Smtp-Source: AGHT+IFdCq/a3Ahhn3WZlqm5Nk2OC7djHwlYLFv5BofaQ2vxpeiJPbXJjIZWTFKJ9mcv05gaELflyg==
X-Received: by 2002:a17:906:13:b0:9ae:519f:8276 with SMTP id 19-20020a170906001300b009ae519f8276mr1423408eja.73.1696410717148;
        Wed, 04 Oct 2023 02:11:57 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id g12-20020a170906594c00b00997e99a662bsm2448324ejr.20.2023.10.04.02.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:11:56 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:11:54 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20231004091154.GB1091193@rayden>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:02:52PM +0100, Sudeep Holla wrote:
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
> index efa4e7fb15e3..26bf9c4e3b5f 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -587,6 +587,35 @@ static int ffa_notification_bitmap_destroy(void)
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

dst_id and drv_info->vm_id should be swapped.

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
> 2.42.0
> 
