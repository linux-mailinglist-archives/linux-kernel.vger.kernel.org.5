Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634577BA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjHNNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjHNNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:52:10 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22E10D5;
        Mon, 14 Aug 2023 06:52:04 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34977c2dc27so20784585ab.2;
        Mon, 14 Aug 2023 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692021123; x=1692625923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NtwI3YlsklSoYLB5EKJ6oRdPMN5Klg8xng3e1ay8vY=;
        b=acRQvDqHS787ZuPT/mQ8I87VIkW3n6TxCfuxonkcuFsu4kQjz5N2XHrqmUWtr8iWLF
         ggBMPq/Rqu3AXC61HR5BRnLRz7gTqS4cgps0a/7+909IsAhBFwaMDmAxlTrmS4Oym+Z1
         pz4JxkDAILE3vW8HJ11fizZnVMnEhznRHdqTMQQ7jVXYI+SWEiPAorR9QJxzQCjzF6Ct
         GxqIZ5caOr/fUKqebHzXPvHoSAuOUbvwqtyCCjdCP5Ax2DqBD/l4o0HCryxHgYxmn50D
         upT0nj8VWbrrTA72aIT5Iecwd9wxy633uuFExhnC1I3dlCVhqqxcC/+hRnJfZ3gXW8ie
         7Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692021123; x=1692625923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NtwI3YlsklSoYLB5EKJ6oRdPMN5Klg8xng3e1ay8vY=;
        b=bx8v8l9Vc9bvdhISTf1GVg9wJbmIrzBYWt/lqGfvhU1mjrsMhuCsEjlpcrDTcJeYiD
         t69qO5iZAfIn1wneAcAipPOPwm9ZRhSal3rXDHFZ2D/62NfDiHBAJxgOqv+3bWDfUpUs
         Pi2YS0OcMgS4o/BVMVlrkP73KtS4Nc0RHoFVBP/l3HIunIsrYq9aBbGacegxTFHKhP6s
         1w+Dd5OqoIV4rjPDSbpNN8aM6JjqB3OiORfSiLocSjclhlo9ZVxK5nRq/oks4+5VsPZo
         SeJwl7Xlmon6w+Zz0DhDz7RchjsR3pvbrPsTdFxtngOnjK7vvU1XrOnRmX7I9S2CspZa
         eUTg==
X-Gm-Message-State: AOJu0YxogfyY1JLgu0F1nqGpezRenhQ3w9sivdOBDBubhF7FvwEEvXGI
        K7tJaxARws5CjlHiT+pNJuBx+XmC4Iw=
X-Google-Smtp-Source: AGHT+IHSnWu1px0AK37yZsZ/LuGZrARFRKYy7T7jBDf28y69TWrmRitrNBguHGhEyLKHIlUHDu5LdA==
X-Received: by 2002:a05:6e02:1bee:b0:348:cc2d:7eec with SMTP id y14-20020a056e021bee00b00348cc2d7eecmr15539492ilv.0.1692021122863;
        Mon, 14 Aug 2023 06:52:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a92d608000000b0034632ab31c9sm3229479ilm.21.2023.08.14.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:52:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 06:52:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2][PATCH] watchdog: core: stop watchdog when executing
 poweroff command
Message-ID: <ac5d44be-0f87-4f13-ba07-fe274ed773fd@roeck-us.net>
References: <20230814090616.1853263-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814090616.1853263-1-Meng.Li@windriver.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:06:16PM +0800, Meng Li wrote:
> From: Meng Li <meng.li@windriver.com>
> 
> On some platforms, for example, Intel SoC FPGA platform, the watchdog
> is started in u-boot, and so kernel will create a timer and work to
> keep watchdog alive. But when user executes commands "poweroff" or
> "shutdown -h", the system is reset when watchdog triggers timeout even
> if WDOG_STOP_ON_REBOOT is set in watchdog driver. The root cause is
> that the watchdog is not stopped properly because the SYS_POWER_OFF case
> is not supported in notify callback function. So, add this case to stop
> watchdog when executing poweroff command.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> 
> v2:
>  - fix typos in commit log
> 
> ---
>  drivers/watchdog/watchdog_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index d4c5a736fdcb..5b55ccae06d4 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -161,7 +161,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
>  	struct watchdog_device *wdd;
>  
>  	wdd = container_of(nb, struct watchdog_device, reboot_nb);
> -	if (code == SYS_DOWN || code == SYS_HALT) {
> +	if (code == SYS_DOWN || code == SYS_HALT || code == SYS_POWER_OFF) {
>  		if (watchdog_hw_running(wdd)) {
>  			int ret;
>  
> -- 
> 2.17.1
> 
