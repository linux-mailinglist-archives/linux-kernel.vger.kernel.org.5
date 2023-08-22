Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CB783A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjHVG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjHVG61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:58:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5CD1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:58:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-997c4107d62so544323966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692687503; x=1693292303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpY3mT4gPNi0x9DNid0qCTIl8PLMjBEcgZhvabeaJIk=;
        b=JXY5GTuEfKoxugi8M+idvv/SwbgMv5U6RshJ1oDOx4sui9zwHf6mdSCtTYulfFQle2
         VXoqU0LMk3AjIZ9FToRFFjrUxYJveNMpQO30YvaWYnnc36rf63Wa5S1wCRjGoC6laPNk
         oNztAZ4HjnN6tg7tdVphmK0+lsG3pdWhGauVYenzmDq3jOyq5X0g7sxOTwbjaNvi+j7e
         Lxo4MgEiDbQPGRG++ivVOR4w9jOSiq2qAW72f85JaQEf5XkkQLqnmagR7phJX08Atoy5
         2oqHpxK/NW7hg0qikxE98OCJ9U/thYylEaHzGz2Iba93oUwJTr8SdCMNMw3KWKZ9/LNt
         iajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692687503; x=1693292303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpY3mT4gPNi0x9DNid0qCTIl8PLMjBEcgZhvabeaJIk=;
        b=lavoKeS1qRHmfBo/f6r7qR8gVz1i80gut2T5kfJTqti/E0lKB22u2WkeOvWfU8XyjX
         skCaYK/mEgaNHmn1omvh6SQUszUisLyK6BaeUEmL+QRhb+5BPMqrnXScnQKCMOEg7K51
         q7tgqcnxCsGd6knxnaY8eu67ZrODJPw1nY/YyrrHgcF5ZVEJ3ob2ycOoB6x9USNXmcji
         I3uksDJ8kzuZlRC5syIP4PyNlR05jotsRtkowIQHvqb9TX4zqu8UxO6ZeZetMmmTVlu1
         dbRz4g26zAET5VexAAcN4AtlfE/tr66NNQl4F9GAn+96lUGJIf6qHNy+Hg6ywLRhYfBC
         xJhQ==
X-Gm-Message-State: AOJu0Yz5AKejDzhvKon0t8dBnRJ4jPj4bw8g9IkdS6ncmC6V8syP4KRW
        Rr8mw0+hLQe9t3eceHpX0wV6X6ToWxAuKA==
X-Google-Smtp-Source: AGHT+IGuEOSIxJQs3JIm+Z0QYFbbU4kDBe0FAshlIOtYDUdaHm4IDyylH/LAC05Wexapi/zHuZqLvg==
X-Received: by 2002:a17:906:74cf:b0:992:9ea0:2317 with SMTP id z15-20020a17090674cf00b009929ea02317mr7370017ejl.61.1692687503159;
        Mon, 21 Aug 2023 23:58:23 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906430f00b0099bc8bd9066sm7680700ejm.150.2023.08.21.23.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 23:58:22 -0700 (PDT)
Date:   Tue, 22 Aug 2023 08:58:21 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix alignment of open parenthesis
Message-ID: <ZORcjUIrKYW/r0ne@nam-dell>
References: <20230822043426.1966-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822043426.1966-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:04:26AM +0530, Rohit Chavan wrote:
> Fixed all CHECK: Alignment should match open parenthesis
> as reported by checkpatch to adhere to the Linux kernel
> coding-style guidelines.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 727b956aa231..d0ca82a755e4 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -381,7 +381,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
>  			read_timeout);

This "read_timeout" should have the same indentation as the line above.

> 
>  		if (ret <= 0) {
> @@ -522,7 +522,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		 */
>  		mutex_lock(&fifo->write_lock);
>  		ret = wait_event_interruptible_timeout(fifo->write_queue,
> -			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> +						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>  				 >= words_to_write,
>  			write_timeout);

Also here, this looks very ugly after your change :(

Best regards,
Nam
