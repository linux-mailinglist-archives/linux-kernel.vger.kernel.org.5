Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A697774CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHJJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:42:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA8DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:42:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so3889595e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691660570; x=1692265370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPLh7fq/Fe4wDkfylhVKPKRu57n0aHzq3eL6f8DTdi8=;
        b=x3YkisRZJi8cG7KHbh8hFPZOL2XvVpY+i5tuJTpHfBML5g8MXHUHVGDoT+aOQ/10wo
         Cf1S6u/cejfUg+qEz9OV1dGWGuSRv8drvtd8YPmR3/fgIZP45RGhSKaX1pPSE5/Ztf0G
         Xre1hPjk8aoIIzhYfbbJaZaAnzkVesaecjxgg4g5X1B1ADI+NOXC4iEkPXFz3M9p86ih
         B6OZcjAO9gOKsRGGh+Tq/YNPCIjjoz9mU6z3odLraYgpabpn3/L1FEngzZXnOMtwXxuv
         vit2F8aB7xDAunrLeiM70R+igfVSM7yYi5E0SMwGfcBj986bSfGPz/9yvinnO75ceb+L
         AIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660570; x=1692265370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPLh7fq/Fe4wDkfylhVKPKRu57n0aHzq3eL6f8DTdi8=;
        b=he2ofSEIFABHFHpPFksMlGtPB0KVaPWVMg1eV6AIHZcorn6N7VbevjTaZZ+tMAk4q4
         hPkAo1JR9TVme8qn/5Q8i1cTsnhPAqiwAHm3vOfriN5fevCa/iEBy4b/RcD7vj2kZd8z
         lT+c7073PiL2SWfa6y96jXL79AanfijjA4zxEWtIGQo7I73rhtVWFU+QFoth5ueTAs3F
         EQPbzD4Wjv5rNZrUiQ2nu0flpwg+SF+ZCXqUlh8+0JP6sgGOMK6eAizwq/Wt4HGbaQU7
         +eLJ3C48e+iCcqNjMpOtWC6WI9rG+XhZ2GAkIuXkEDilMDOa9ncwsHWfe4qEY7wl1pZb
         K68w==
X-Gm-Message-State: AOJu0Yxog5NBvaphDwHhLMLwKyUC5KsQZjU+2CC8C7X6+G3cPP9Rfc9l
        5BWc6Ohhsyf5KN3ZHlESjJla/w==
X-Google-Smtp-Source: AGHT+IFa9H2lHH95pOGRIga29g+95td9OYyxeM/h02dnxY+xpKy/hZ4gRuWzadHYoTu43p/E6ukmpQ==
X-Received: by 2002:a05:600c:155:b0:3fe:1166:e33f with SMTP id w21-20020a05600c015500b003fe1166e33fmr1266530wmm.10.1691660570466;
        Thu, 10 Aug 2023 02:42:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm4487947wmd.19.2023.08.10.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:42:49 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:42:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Message-ID: <ba8becf4-786a-4923-92f7-b4ec3038295f@kadam.mountain>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-35-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:08AM +0200, Jiri Slaby (SUSE) wrote:
> Unify the type of tty_operations::write() counters with the 'count'
> parameter. I.e. use size_t for them.
> 
> This includes changing constants to UL to keep min() and avoid min_t().
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index b31f2afb0286..cbaaa8fa7474 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -17,9 +17,9 @@
>  #define GDM_TTY_MAJOR 0
>  #define GDM_TTY_MINOR 32
>  
> -#define WRITE_SIZE 2048
> +#define WRITE_SIZE 2048UL
>  
> -#define MUX_TX_MAX_SIZE 2048
> +#define MUX_TX_MAX_SIZE 2048UL
>  
>  static inline bool gdm_tty_ready(struct gdm *gdm)
>  {
> @@ -152,9 +152,8 @@ static void gdm_tty_send_complete(void *arg)
>  static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  {
>  	struct gdm *gdm = tty->driver_data;
> -	int remain = len;
> -	int sent_len = 0;
> -	int sending_len = 0;
> +	size_t remain = len;

We later check if remain <= 0.  It still works because remain could
never be negative, but now it's even less necessary to check for
negatives, I guess.

regards,
dan carpenter

