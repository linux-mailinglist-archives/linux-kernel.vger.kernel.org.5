Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE77C453E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJJXJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJJXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:09:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EFB98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5ff5f858dso42957905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696979377; x=1697584177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9NRsBIuS7/t1xSzM4HVRP0dsTmAqJy+of1PCaXbcgM=;
        b=SRhYUedHEFcJqynHoSRhp9FvfE+588d7WSAI/0HLQv/vSfHjKUJzFZtWS6rFaX4K3P
         SREH1j8fR2cSdjNHbgSs3lEYC/efSJxmvxlD+kk+D7nU9Jwo6hjp2AZaCx7K3E9YTNUf
         o0KqFcXeRbX4mJRijg7jQy6SifEd7ZqAXRmdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696979377; x=1697584177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9NRsBIuS7/t1xSzM4HVRP0dsTmAqJy+of1PCaXbcgM=;
        b=ZrfL68zcVJmxDLlB4EZINemjfkJTmCKc/zKfZMlT66VHmj4buWEA5daTri9vsM+cNs
         B/adjUnrw038V3AN1Ar7Pz8aOO9AYKWDOluX6e+6yPjXGGuPSYe76Wlz/OhVVUWMTWbx
         8Lanc73swp4zYWIIdLXzcssM6DvScjsLr4LPZKP+BqmoFzmqMo98Lruvyk8eie7/TS1t
         gexPs33N1mPgzQW1ZLNPHwKLOFHtN/X+tu9e+3IxUDXqMO9m+RKCCYlKWChBeT16F2jP
         jGGyJyHwdDAK+6YTlNkjMKOax5V1VKX+EaL3hKFOmscdabT69IpQ+zBrKJ77eM/6fjQv
         xKEw==
X-Gm-Message-State: AOJu0YxXo9CPjxRwzMjsKMPPrasTgrJ9CWINz5QOYP7sXKLhRr0FY61q
        mI5VAPuJqtD+mPjdr3cw/6lclA==
X-Google-Smtp-Source: AGHT+IGgmzpC22sgiK9oMsgsREK3LFJzysUpnKl171CEVnXwEJGOya787Jhv0d5rIBgLPK6gEOlMUA==
X-Received: by 2002:a17:902:ab13:b0:1c3:eb95:2d27 with SMTP id ik19-20020a170902ab1300b001c3eb952d27mr17223508plb.48.1696979377307;
        Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b001c9c5a1b477sm728016pla.169.2023.10.10.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:09:36 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:09:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] atags_proc: Add __counted_by for struct buffer and
 use struct_size()
Message-ID: <202310101607.3D7ED0A@keescook>
References: <ZSVHurzo/4aFQcT3@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVHurzo/4aFQcT3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:46:50AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/arm/kernel/atags_proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
> index 3ec2afe78423..cd09f8ab93e3 100644
> --- a/arch/arm/kernel/atags_proc.c
> +++ b/arch/arm/kernel/atags_proc.c
> @@ -7,7 +7,7 @@
>  
>  struct buffer {
>  	size_t size;
> -	char data[];
> +	char data[] __counted_by(size);
>  };
>  
>  static ssize_t atags_read(struct file *file, char __user *buf,
> @@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
>  
>  	WARN_ON(tag->hdr.tag != ATAG_NONE);
>  
> -	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
> +	b = kmalloc(struct_size(b, data, size), GFP_KERNEL);
>  	if (!b)
>  		goto nomem;
>  

Yup, "size" is assigned before accessing "data".

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
