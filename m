Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11507ADE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjIYSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIYSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:20:27 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9078E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c49f781855so4175859a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695666019; x=1696270819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NO8m8eKRK6gw6Fe8TwUzngktRHamqnnDsDwwzDNH28M=;
        b=O/nD1cQaazGdhOue2jahkm1+yeWeoKqu1M4ITJ0EcOBorhKIpyziT1/lSG+8Npva//
         X9uMhsvJvYJxAfqbGmp6fdFoOv1VSXr8/XoHF5Bf5yBTkM07ZYceMSWkswbfovSD0sLL
         GIsX5bkCmA1rQ80+S3H5OE9sqUqPIYZqgWJzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666019; x=1696270819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO8m8eKRK6gw6Fe8TwUzngktRHamqnnDsDwwzDNH28M=;
        b=gYVj6EShqOrv+9ePmOXL505irByW/5MvAGDFRAk04d2NeYEpZoOiDNzHce2uC65oA+
         r2B+yLHdNxqKNr2HIEVLzfLPBxTwIsCd53e1t+OiKHX3gBMl7+1x+2RJT5q7P1v8432v
         xs+igiCUrB3sUEdQGALOHoDlDg+Ns2RJoEzGg0Iazyavesxjuu0L2MEFiGoZS+oU/utp
         Y0pluRTsl9dpKhMo9jS4Omb4dgG11E62LfbNpAroMOTIgMKxdeDXqNtIfBrnHO9v1z4f
         7128w2WEk9wtbmH/Gc8A54Y+2Wm1AZYOVJl7yxhoCu2BBx/pewYbJ4Ukn9qb/E+GjwUx
         x+NQ==
X-Gm-Message-State: AOJu0YzfEVljMM2qJzP+cvaOSOibLoV24qy4NnwsNzZixOwB6vnyfddG
        LPSjJKVrb2aVxHxvybYa3d3edA==
X-Google-Smtp-Source: AGHT+IHKSOY+zwApZkbmmnPtFl0loyWLQ/uN8QUCjcTuZ0xU2ovE+l4Elr00aAvn1WMqw7C2F4wggA==
X-Received: by 2002:a05:6830:115a:b0:6bc:b8d9:476e with SMTP id x26-20020a056830115a00b006bcb8d9476emr9039803otq.16.1695666019073;
        Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k7-20020aa790c7000000b006875df4773fsm8310724pfk.163.2023.09.25.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:20:18 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:20:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
Message-ID: <202309251119.69C15DC@keescook>
References: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 07:06:03AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `lc` is already zero-allocated:
> |       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
> ... as such, any future NUL-padding is superfluous.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Let's also go with the more idiomatic `dest, src, sizeof(dest)` pattern
> for destination buffers that the compiler can calculate the size for.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good to me. Thanks for the sizeof() replacement. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> ---
>  drivers/md/dm-log-userspace-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-log-userspace-base.c b/drivers/md/dm-log-userspace-base.c
> index 5aace6ee6d47..7e4f27e86150 100644
> --- a/drivers/md/dm-log-userspace-base.c
> +++ b/drivers/md/dm-log-userspace-base.c
> @@ -224,7 +224,7 @@ static int userspace_ctr(struct dm_dirty_log *log, struct dm_target *ti,
>  
>  	lc->usr_argc = argc;
>  
> -	strncpy(lc->uuid, argv[0], DM_UUID_LEN);
> +	strscpy(lc->uuid, argv[0], sizeof(lc->uuid));
>  	argc--;
>  	argv++;
>  	spin_lock_init(&lc->flush_lock);
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230925-strncpy-drivers-md-dm-log-userspace-base-c-857579d9834f
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
