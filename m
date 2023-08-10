Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55B778398
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjHJWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:24:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA56F2724
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:24:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40fda01c8beso6993841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691706268; x=1692311068;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLWNnusBQnURb+xt4DXlBk9kVPWvxt5Ijw2JQ29Fx8Y=;
        b=PBDelp9ylnd1p2zMIhh8FOdARsKvJDy8PLP1C3HivQIoVhjSR67cE5WxfIaI6Q/ZFz
         DEkN1mgdlvZTuViYovzDLhJyNP63ciyHtcSsOFP35Y2r3nfvchju03Lm1py3hn0YK13B
         Tf033gd+fiSAz+zAyU1P7vdthhxKsqo7+UHR0SG9nY0b9bFpiMDg3P/p/pfY1q/HRl9H
         oDuuwG/e0xmgnELlV/MVDjuss+NpV2Zg7lyplBP0JrPT788bpif3a08YQaePW5Mobn6z
         orNqyhVtqc51s8BUq2eKc9Qx52+JGXPrxI41MnZZN+lH4fgMXwoDJX0bBz3M4TNMuZfa
         rrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706268; x=1692311068;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLWNnusBQnURb+xt4DXlBk9kVPWvxt5Ijw2JQ29Fx8Y=;
        b=j+FYkha5RgFY5QE7uY0976yi74SMdUAKWO3MtEoHdazN0/BRtvPdScgFgm7s6EG91t
         b31L/edtoU6CQM/fxPusTjS8TdNH5F41r0cvEeGbVLDvuBBVa8zGMSjDMl1Q3hWiNrzK
         3Zre95s74irr8FxpgaRpXbx7hJT98pqK+yeQsIxN1P0nWq+zz7V7ZxY6Qxiqn8p4V0O3
         SponZ9zDppR9W58o/giYLbBCvAHdex2Ess6apVZLfSVBcd0DvooVuktZP364Ob0ZBbWR
         F5Kl+LvOBkW0aoNuj5ZlX1rM/sbCTrv3JObKBl4HNaOqc/Tyejohn1pWgw3T+1GN/v+b
         myQA==
X-Gm-Message-State: AOJu0Yy0i3Uml+ccSFC0TRtQuv/khJWh5GHyxGssTzBMY4Fxla5oT5dc
        L3Nmi6AQXmQssyrxx5oBhNUU
X-Google-Smtp-Source: AGHT+IEqhheF+cXXqXhsi4mrHMlBChr9PecL3CPsD6reX5pruGhIm1HrgtXPC/T91Y/HTSCU4vriDQ==
X-Received: by 2002:a05:622a:4ca:b0:40e:f7cb:8c44 with SMTP id q10-20020a05622a04ca00b0040ef7cb8c44mr4507471qtx.23.1691706267776;
        Thu, 10 Aug 2023 15:24:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q9-20020ac84509000000b00401217aa51dsm778611qtn.76.2023.08.10.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:24:27 -0700 (PDT)
Date:   Thu, 10 Aug 2023 18:24:26 -0400
Message-ID: <1088bd209427626090f6a062a2ad1486.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: Re: [PATCH v13 10/11] SELinux: Add selfattr hooks
References: <20230802174435.11928-11-casey@schaufler-ca.com>
In-Reply-To: <20230802174435.11928-11-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  2, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 136 +++++++++++++++++++++++++++++++--------
>  1 file changed, 109 insertions(+), 27 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c900813fc8f7..f66a28f672b2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

...

> @@ -6449,6 +6466,69 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	return error;
>  }
>  
> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			       size_t *size, u32 flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> +
> +	if (total_len > *size)
> +		rc = -E2BIG;
> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +	else
> +		rc = 1;

I'd probably either set rc to zero when at declaration time and drop
this final else, or explicitly set rc to one here to better fit what
lsm_fill_user_ctx() does on success.  However, the end result is the
same so we can just fix that with a follow-up patch once this is
merged into the lsm/next branch.

> +	kfree(value);
> +	*size = total_len;
> +	if (rc < 0)
> +		return rc;
> +	return 1;
> +}

--
paul-moore.com
