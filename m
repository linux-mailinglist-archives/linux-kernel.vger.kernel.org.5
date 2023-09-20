Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F157A888E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjITPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjITPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:38:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6199
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3bd829b86so52909135ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224292; x=1695829092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=grIImtQWNBz4O3VZ8lBD2vfKB4PkQhfq/SxGc4hh3b9cS059J/+CIL/SfhGDckO18j
         vUKBsiJHfHzbhNnjP5GedhmDEYVqVNdloYwGyBEAUxs1HCe5WXekkWk/adPF7kijc7TK
         bN3/duva0WtrtsjRijft6xB4S44bSthUrbxco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224292; x=1695829092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=E5zUs4q/ZCJaFtz5QdLnKQMX3Ach3YRmg1ioUpcHRYa13aDJ/uPlOYRL+oYRrPjCbo
         jp2kZ0CSajbl3F9QGCgZMQgS9sfbrxj6bYaDuexERhzX8c2ipSwwTHU9rXutu8CHoOkp
         pR8a2q0vVIcNEURkOeDfR1go6HpP6Kk1I/xuYys4S7zVTEMpGeXzEZAW+bbntjxHHZqC
         z1jgftj0kbPWtlTTG6bUY5YyaplyvOfybV0tDRvw4yzpO1NIFGETVtejLNoOiEs3SAeG
         sH8Q89BKaVBfbz/hec9HRe+O/4iPlyKUp1g9RycLWeIBGojdW66M5dOUJ3FXdkudp6l4
         7vaQ==
X-Gm-Message-State: AOJu0YzTRHuOOQVQSUiPwbgaG7XQmc6birEy8nzCvCN8bzsaI/EFfNx3
        yrD0rZZuZNkbjg995866Q/uylQ==
X-Google-Smtp-Source: AGHT+IE1DOyr9yY663BmjzKsqSYI/feK+DfQZwVOtqnpy/SKQBvmI6yXpFyHjBuRMaZeq4tzMyk7/A==
X-Received: by 2002:a17:902:9344:b0:1bc:5924:2da2 with SMTP id g4-20020a170902934400b001bc59242da2mr2463874plp.56.1695224292381;
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm8993425plg.124.2023.09.20.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:38:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-ID: <202309200837.FAE2C061FB@keescook>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:30:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> It seems like NUL-padding may be required due to __assign_disk_name()
> utilizing a memcpy as opposed to a `str*cpy` api.
> | static inline void __assign_disk_name(char *name, struct gendisk *disk)
> | {
> | 	if (disk)
> | 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
> | 	else
> | 		memset(name, 0, DISK_NAME_LEN);
> | }
> 
> Then we go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
> | #define __print_disk_name(name) nullb_trace_disk_name(p, name)
> 
> This function obviously expects a NUL-terminated string.
> | const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
> | {
> | 	const char *ret = trace_seq_buffer_ptr(p);
> |
> | 	if (name && *name)
> | 		trace_seq_printf(p, "disk=%s, ", name);
> | 	trace_seq_putc(p, 0);
> |
> | 	return ret;
> | }
> 
> From the above, we need both 1) a NUL-terminated string and 2) a
> NUL-padded string. So, let's use strscpy_pad() as per Kees' suggestion
> from v1.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the analysis in the commit log, and yeah, this looks right to
me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
