Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCA7AC680
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIXDg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:36:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11C10A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:36:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso3355884b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526581; x=1696131381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fGfR3WXyetGC3RWgS0QiIbSubluI7C3Y7hWAwtVYmU=;
        b=X4Ju7pffVaUCH4vkcnwSCv722cNt87Gh9znwdVM2Mk2xM4OcBwFxl8BvYW0S/357Bf
         MhQBwmUdzc+VYZVvcDKJYMCfnaeDMVTtmC7fkegMWJk2DWnyYohZuq0/zFKcUggBzCYg
         WGKQEIEEaMq02LcmBrLNBDxVF1j6HJ2s2l9oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526581; x=1696131381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fGfR3WXyetGC3RWgS0QiIbSubluI7C3Y7hWAwtVYmU=;
        b=Z/QIAWnouSB/qcrIEW1Gbvnijg2M0SuX9yIFl1Ao6CPhIsLcCYpi7nxPk25IO0NzOU
         1JjXgGcVPnL8tW5e2WtArNMjvPRHxcyVf3ClZhnvwl6Lrq1SQ1i9TGefDh3R3Ib+DPwz
         yksxrRrNQQn+s1RraG0W1P2DpAcgd/YkFpSBi/TzxHHb2es3OLsiiQqqRuAhYaX2mQmZ
         Gp7qOiZ0XzDUZ8+x0G4TamFYjXWHw40whTD1CG07vJVAz1qqn3b+cOVANdtm8p54hBr9
         2kdzppACFLrsl/iEY+NeRPqAKpJBxkMwt1PkkKd1mgp9YRRNa7SRBJhxf4NP1MHZghLk
         TWHw==
X-Gm-Message-State: AOJu0YzbzN7D5TijvJq+NhUJIfH6Rpskw4FAJQAc94UAkMMxWod2Dt8J
        VZ1/R2RJKCccw+0vPP6u3PWCZA==
X-Google-Smtp-Source: AGHT+IEsbLZieOx6ZuiBto71jxQJ7MtE+cyB6NLqstbtzH888P2IAZTbf1cZ3AJUH+QeLrVqshZScQ==
X-Received: by 2002:a05:6a20:8e08:b0:13e:90aa:8c8b with SMTP id y8-20020a056a208e0800b0013e90aa8c8bmr5556857pzj.4.1695526580785;
        Sat, 23 Sep 2023 20:36:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0069023d80e63sm5545887pfh.25.2023.09.23.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:36:20 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:36:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: kcapi: replace deprecated strncpy with strscpy_pad
Message-ID: <202309232034.38BC5E1C3@keescook>
References: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:49:14AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `buf` is used in this context as a data buffer with 64 bytes of memory
> to be occupied by capi_manufakturer.
> 
> We see the caller capi20_get_manufacturer() passes data.manufacturer as
> its `buf` argument which is then later passed over to user space. Due to
> this, let's keep the NUL-padding that strncpy provided by using
> strscpy_pad so as to not leak any stack data.
> | 	cdev->errcode = capi20_get_manufacturer(data.contr, data.manufacturer);
> | 	if (cdev->errcode)
> | 		return -EIO;
> |
> | 	if (copy_to_user(argp, data.manufacturer,
> | 			 sizeof(data.manufacturer)))
> | 		return -EFAULT;

Yup, strongly agreed: this needs the padding. I actually wonder if a
follow-up patch might be a good idea here, just for robustness:

 capi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
         struct capidev *cdev = file->private_data;
-       capi_ioctl_struct data;
+       capi_ioctl_struct data = { };


> 
> Perhaps this would also be a good instance to use `strtomem_pad` for but
> in my testing the compiler was not able to determine the size of `buf`
> -- even with all the hints.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
