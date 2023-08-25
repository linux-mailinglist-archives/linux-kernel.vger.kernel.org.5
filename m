Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108F787C77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjHYANV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjHYANE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:13:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323E1BC8;
        Thu, 24 Aug 2023 17:13:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99df431d4bfso39197166b.1;
        Thu, 24 Aug 2023 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692922381; x=1693527181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FrPKp5AaTmiKjjCxOEGvUxfqxf1WlvTqn4IiXnA5UA=;
        b=gHlShRE+vf/JFJNmv/m3UW0JAsNq7WdSYYQn7gZ1R2pVRMgWRLlzJcWmHuNJ7XcI01
         wSjuXVlKLaW1tWeQB9CSEvkEhE/xwhJg8MJ0F7mGbgCV0oZD1zFRQ8ei5KnyNit2HdY4
         ck5JseeLky9WEPKhF5z1/t0O3FowCv3w2uOYci+p9o7j/Il4FoOdaeiW9jzaJq0gyiIB
         8e94EMuPHIK+DQxDJBkURwp/0GVg5JGQM0CXtS0WPCg4Jn3LOFQs6DdByN4wT5INb1Wu
         qFSw06wxlhgOdyd2A/dChZ5HIGzOdWgfiefmuO9L5RVGQeleZEFTtuEj5mKtOBJJueGX
         cwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692922381; x=1693527181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FrPKp5AaTmiKjjCxOEGvUxfqxf1WlvTqn4IiXnA5UA=;
        b=BASw7FvezZIV3zLmtgH4bFBuR5GuaUqIglczaBCu/bG8nR+48+KyxARC8TldCL4PPq
         NeXgo8riMc6r3Wvmta06+KIng7V2o6d/P2rJpgF6CY8139ArGxDHUd2sijJIGB2GDJLM
         8EuAQ2s8zcBVGlrig/Ks1dM05RxId7PIJuhMk0n9wXMfTKf/pBqtjkfM8g1atqkhckgb
         jLUnVnbJI1chSIEGxarTuFj5EFLG5lRSgQ0vbrVPHczvljppWeU7FCjeD16zI3IKWL13
         Upnc6qxOX0nhqkyqOv5tW6iFkuMRxPXVPUNabrkihT/VcD12ExjoMxh0bomOLX+60df2
         XjHQ==
X-Gm-Message-State: AOJu0Yzu47Hv5jWERVR7noaIzR/ptlLfnyrQubocAyntDYFCnQA0qftO
        jViWXKaBlc2z4QGBpMKvWxwoQFE5PmTv0Q==
X-Google-Smtp-Source: AGHT+IE+S/WEthctejPnFDCeMkdjAA78DrPaZ+phtcITFg8m7IMG3ZOR/PjRGDFFIVSy27iYo1i81w==
X-Received: by 2002:a17:906:150:b0:9a1:d79a:418e with SMTP id 16-20020a170906015000b009a1d79a418emr4746570ejh.40.1692922380506;
        Thu, 24 Aug 2023 17:13:00 -0700 (PDT)
Received: from f (cst-prg-6-172.cust.vodafone.cz. [46.135.6.172])
        by smtp.gmail.com with ESMTPSA id le18-20020a170906ae1200b00991d54db2acsm245528ejb.44.2023.08.24.17.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 17:13:00 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:12:57 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v13 04/11] LSM: syscalls for current process attributes
Message-ID: <20230825001257.qcckxswcrehs4uh2@f>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:44:27AM -0700, Casey Schaufler wrote:
> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @ctx: the user-space source for the information

Would be more idiomatic to name the user arg uctx.

> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> + * if the user buffer is inaccessible or an LSM specific failure.
> + */
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx *lctx;
> +	int rc = LSM_RET_DEFAULT(setselfattr);
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (size < sizeof(*ctx))
> +		return -EINVAL;
> +

I think it would be cleaner to check against lctx.

But the actual point is that you want an upper bound here.

> +	lctx = kmalloc(size, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(&lctx, ctx, size))
> +		return -EFAULT;
> +

One commenter over already mentioned this should be lctx, not &lctx.

> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(ctx) ||
> +	    lctx->len < lctx->ctx_len + sizeof(ctx))
> +		return -EINVAL;
> +

This leaks lctx.

> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx->id) {
> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);
> +			break;
> +		}
> +
> +	kfree(lctx);
> +	return rc;
> +}
> +
