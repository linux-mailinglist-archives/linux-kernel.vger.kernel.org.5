Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA57D5EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbjJXXjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbjJXXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:39:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A7E10DB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:39:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5028371b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698190777; x=1698795577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0C3WrdgCxuejz0NFaILHBvkacIaw3n5f5P0gOFfM1Hs=;
        b=OsLhEsi3M96gvK2oeB/w7CRBJSy8o7bEcp0LqIZqEw6CC4UDzCgcqJXSUxLrFi9JMp
         dSZ8uyaZST+L4DwJ4ahuk2L6t4gDNbm5Mt5TXKS272zU2as4rbCH2BSGZyIXINtRZMQ8
         lL08T/rG++olCpz418yEJO1AFWutk+QB1n5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190777; x=1698795577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C3WrdgCxuejz0NFaILHBvkacIaw3n5f5P0gOFfM1Hs=;
        b=nozI0mDTPkQNDqqzC4wkucNplOxGfE+JPwK/oHzei9asBWDNYV5SQbTAxFs9ec0CNO
         fkLVjOR7Q24Xp3fOhOSL7BABpzQeLbCn9sVvZ4TxFwwaRuzuhjxBXcNg63R5cwIYVFLT
         ShdN1VnAMu4rCJ+FdjzpbaIgLBWEDPkmTNwtKx9rsI/g85y1e8l4s4VUbR6+rYg99zxn
         hr81OpE6bvWsiVnvHw65P0JwHDLm79fjYIxPile9FM2J74sDJ6E3PYyFYrfkLo2aShhx
         Uq+YdAEa2r9nnGf6MFzCFe1erGqPrQE+pyBj3iocrDL3btm+y0eDfu2OS8BAGayUMH4y
         iSVg==
X-Gm-Message-State: AOJu0YzMd1d6GBaR9WJVWwrPnaByJWxVsRk9nUPEERtGXtI4zwwGtIHw
        nmW5sjMlS0+47IV/BjdPKyn2zA==
X-Google-Smtp-Source: AGHT+IF5E0QJLpebVs4RdVAuB/USU/z4C1vdW4R6JPpH6owAFSc8vHSAZtHlk4IzGnWoQz4qd/1kcA==
X-Received: by 2002:aa7:8893:0:b0:6b5:a01f:f7fd with SMTP id z19-20020aa78893000000b006b5a01ff7fdmr16530335pfe.0.1698190777691;
        Tue, 24 Oct 2023 16:39:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b0068842ebfd10sm8110229pfl.160.2023.10.24.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:39:37 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:39:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <202310241629.0A4206316F@keescook>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
> the space that is remaining.
> The space for the ending NULL is also not taken into account.
> 
> in order to fix it:
>    - call decode_register() before the snprintf() calls
>    - use scnprintf() instead of snprintf() and compute, in the 'remaining'
>      variable, the space that is still available in the 'msg' buffer
>    - add a %s at the end of the format strings and append directly the
>      result of decode_register() stored in 'other'
>    - write directly at the right position in the 'msg' buffer when
>      appending some data in the for loop.
> 
> Doing so, all usages of strncat() are removed.
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is cross-compile tested only.
> Review with care.
> 
> v2: remove some other erroneous usage of strncat()
> ---
>  drivers/edac/thunderx_edac.c | 44 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index b9c5772da959..62e1e120178b 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1111,6 +1111,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>  
>  	unsigned long tail;
>  	struct ocx_com_err_ctx *ctx;
> +	size_t remaining;
>  	int lane;
>  	char *msg;
>  	char *other;
> @@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>  				ARRAY_SIZE(ocx->com_err_ctx));
>  		ctx = &ocx->com_err_ctx[tail];
>  
> -		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
> -			ocx->edac_dev->ctl_name, ctx->reg_com_int);
> -
>  		decode_register(other, OCX_OTHER_SIZE,
>  				ocx_com_errors, ctx->reg_com_int);
>  
> -		strncat(msg, other, OCX_MESSAGE_SIZE);
> +		remaining = OCX_MESSAGE_SIZE;
> +		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
> +				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
> +				       other);

As the replacements get longer, I would encourage you to use seq_buf
instead -- it does all the length math internally. For example:

	seq_buf s;

        msg = kmalloc(OCX_MESSAGE_SIZE, GFP_KERNEL);
	seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);


	seq_buf_printf(&s, "%s: OCX_COM_INT: %016llx%s",
		       ocx->edac_dev->ctl_name,
		       ctx->reg_com_int, other);

	...
  		for (lane = 0; lane < OCX_RX_LANES; lane++)
  			if (ctx->reg_com_int & BIT(lane)) {
				...

				seq_buf_printf(&s, "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx%s",
	                                       lane, ctx->reg_lane_int[lane],
	                                       lane, ctx->reg_lane_stat11[lane],
	                                       other);
		}

	...
	seq_buf_terminate(&s);


etc...

Though I think the seq_buf API could use some improvement: it should
always maintainer a %NUL-terminated string so the final
seq_buf_terminate() isn't needed...

-- 
Kees Cook
