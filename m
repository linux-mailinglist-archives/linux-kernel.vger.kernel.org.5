Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B852F7F4698
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbjKVMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKVMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:49:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9910C;
        Wed, 22 Nov 2023 04:48:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so9276094a12.2;
        Wed, 22 Nov 2023 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700657338; x=1701262138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9YdyaqidxNHgQu3f+/04CWCZm/l6aMN9d1kNzF3ISg=;
        b=SCiIhqLdJWDVB8vNZVi7LtmjKLlIiu+KbWWlDQwNFgKl2fHi0kTJi344MKdQ4JKFaq
         h7Jn1GdtcpWG+iQOBJAWtvTRDR7uh+bKjantjiDMV7yhJH1+s5U7HPgvBakmc/Ii3/Ef
         CbQICJHJXkylb/oCKlNsTAcNOpmpL18oPKFvC/5Wn73WZXz0bOF4Nt3LsSr8Ulm8S8Ux
         nFZL2zJDuW6txUmMgWE0GRKkSIP/eWbDCy6Fko3g+vOjMZZd7jTRqUoDXPEtaP4EFG9b
         dABQUa+t0O73A6L6yy4GTsehOzfSLOUH6Gh8R5qEchn3OzKvocWgBd4lBy80/xZ+wchv
         2sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657338; x=1701262138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9YdyaqidxNHgQu3f+/04CWCZm/l6aMN9d1kNzF3ISg=;
        b=uSHMTOi8sjk9FGnkac4maskfZn/BsiIOwTDExIyUz8LD4C9+iae8cRmV+Bo1H1yJwX
         YezEaaO4RdJHutu//Wd3T80TSy7vt/cc7Dv94q0h34LD2H099UlK5HprcSURGkYrNLuD
         HZmNSK6RUKqrDOP6c15900EXoDb/PvHoSxHzW17vfOtWnWv5PfE+X+ZHl/5T/GEWpnSX
         l6R8IYsOxT9wToQkNnk74JoPyzBrlh7vj7RMnkgDzYdSliOFaZke1nUjXk9EQea+/ZH6
         cYaMShyl88ZD3WgOXTqGqSmust1waM78S2RcNm3Rex5sZ4HQA8r8n/kOW0Dr1/4+arW2
         x8qg==
X-Gm-Message-State: AOJu0YxsHGJ8TQhdMqMWW2uJV12M2yhmyx7PZKG6zu9NGbw934J8vJTO
        rkvH9AajJ3R8+10vxBG7PMY=
X-Google-Smtp-Source: AGHT+IFqjD/KCU7ZngsnrhPKksmdkk+WRbkSvFaBR+8abwH25FrPa5R5r8Qr38fG6A7zDpSEeYeCXg==
X-Received: by 2002:a05:6402:150f:b0:54a:8e8c:80ac with SMTP id f15-20020a056402150f00b0054a8e8c80acmr461955edw.30.1700657338019;
        Wed, 22 Nov 2023 04:48:58 -0800 (PST)
Received: from [10.10.53.143] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id j19-20020aa7ca53000000b005488ae52752sm4424561edt.18.2023.11.22.04.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 04:48:57 -0800 (PST)
Message-ID: <c8661c01-94b1-4b10-840b-2fd7c1f0c95d@gmail.com>
Date:   Wed, 22 Nov 2023 13:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: bcm5974 - check endpoint type before starting
 traffic
Content-Language: en-US
To:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
References: <20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.23 12:20, Javier Carrasco wrote:
> syzbot has found a type mismatch between a USB pipe and the transfer
> endpoint, which is triggered by the bcm5974 driver[1].
> 
> This driver expects the device to provide input interrupt endpoints and
> if that is not the case, the driver registration should terminate.
> 
> Repros are available to reproduce this issue with a certain setup for
> the dummy_hcd, leading to an interrupt/bulk mismatch which is caught in
> the USB core after calling usb_submit_urb() with the following message:
> "BOGUS urb xfer, pipe 1 != type 3"
> 
> Some other device drivers (like the appletouch driver bcm5974 is mainly
> based on) provide some checking mechanism to make sure that an IN
> interrupt endpoint is available. In this particular case the endpoint
> addresses are provided by a config table, so the checking can be
> targeted to the provided endpoints.
> 
> Add some basic checking to guarantee that the endpoints available match
> the expected type for both the trackpad and button endpoints.
> 
> This issue was only found for the trackpad endpoint, but the checking
> has been added to the button endpoint as well for the same reasons.
> 
> Given that there was never a check for the endpoint type, this bug has
> been there since the first implementation of the driver (f89bd95c5c94).
> 
> [1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
> 
> Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
> ---
> Changes in v3:
> - Use usb_check_int_endpoints() to validate the endpoints.
> - Link to v2: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com
> 
> Changes in v2:
> - Keep error = -ENOMEM for the rest of the probe and return -ENODEV if
>   the endpoint check fails.
> - Check function returns now bool and was renamed (_is_ for
>   bool-returning functions).
> - Link to v1: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v1-1-355be9f8ad80@gmail.com
> ---
>  drivers/input/mouse/bcm5974.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index ca150618d32f..953992b458e9 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -19,6 +19,7 @@
>   * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
>   */
>  
> +#include "linux/usb.h"
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> @@ -193,6 +194,8 @@ enum tp_type {
>  
>  /* list of device capability bits */
>  #define HAS_INTEGRATED_BUTTON	1
> +/* maximum number of supported endpoints (currently trackpad and button) */
> +#define MAX_ENDPOINTS	2
>  
>  /* trackpad finger data block size */
>  #define FSIZE_TYPE1		(14 * sizeof(__le16))
> @@ -891,6 +894,18 @@ static int bcm5974_resume(struct usb_interface *iface)
>  	return error;
>  }
>  
> +static bool bcm5974_check_endpoints(struct usb_interface *iface,
> +				    const struct bcm5974_config *cfg)
> +{
> +	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
> +
> +	ep_addr[0] = cfg->tp_ep;
> +	if (cfg->tp_type == TYPE1)
> +		ep_addr[1] = cfg->bt_ep;
> +
> +	return usb_check_int_endpoints(iface, ep_addr);
> +}
> +
>  static int bcm5974_probe(struct usb_interface *iface,
>  			 const struct usb_device_id *id)
>  {
> @@ -903,6 +918,11 @@ static int bcm5974_probe(struct usb_interface *iface,
>  	/* find the product index */
>  	cfg = bcm5974_get_config(udev);
>  
> +	if (!bcm5974_check_endpoints(iface, cfg)) {
> +		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
> +		return -ENODEV;
> +	}
> +
>  	/* allocate memory for our device state and initialize it */
>  	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
>  	input_dev = input_allocate_device();
> 
> ---
> base-commit: 401644852d0b2a278811de38081be23f74b5bb04
> change-id: 20231007-topic-bcm5974_bulk-c66b743ba7ba
> 
> Best regards,

Gentle ping, syzbot keeps on reporting this bug (last report 7 days ago).

Thanks and best regards,
Javier Carrasco
