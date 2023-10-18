Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237077CE606
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjJRSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjJRSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:14:26 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53631111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:14:24 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5832ea25c7eso203589eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697652863; x=1698257663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5ifuSh3pAXhwmN6aI2xPo6Qr4r8ZyUW95PzWHa09WA=;
        b=ZCiACGeQoi4k9Uczo7sPdo5KrSXFyTY/eKKYP/9yyDJHLOgwgs5M0Dj7+t9a/k2sGl
         3GYP5PAWFfBheXCANJwQ7L2mqNvQuT3CzfFE8hF6KSks3b85N2++rfuzK0LWd1cMh7lN
         U0H2wrhwvUw5yVZ0Pls8y3UBf3MGAWwMh228g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652863; x=1698257663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5ifuSh3pAXhwmN6aI2xPo6Qr4r8ZyUW95PzWHa09WA=;
        b=XsMD8XP9TYF38XYMa9VX2K8gwLszAUViyK9MEWEjYNOUT5j9AHAxunzgr/Hvlnr4WF
         qDIjWMMxnKqvNWbOx5QN909oFVQUM7ot6MJT2eJVLSICn4U/v4fAwlSTEmTIzyubM+La
         J3IC27YuiNgizRnaNKcy81ohL+VAmDkYDfubXT/1p3BSbHylaYn9ky2VhTxsVAEiOMG3
         MVzo0m9m+gWow9JXhYiRqDHYIAjeDNcz3cUjE9+h0Y8AiDolRyiV6G/wmjjosfhP01j3
         W4pM3tq0NAPWpurj5o9xFcuHALhWJot4b264lA2hzxtflZnsMhmX4L6rRCh0egQTayKY
         i7Zg==
X-Gm-Message-State: AOJu0YzKmfRNOV9RlVAvQutY479oqQjTvE2PNuBxyTUR39i42NOcQ2nG
        C5ZvutT0AWoiRXZTU3q7ep0vUw==
X-Google-Smtp-Source: AGHT+IF8xi8GFiUQY06uOeWqByr5z7EFVgeVDoRSw3v4/DxmzcbtqXvuu1i8IZohOlGRjH61x3+iMg==
X-Received: by 2002:a05:6358:3a0f:b0:166:f348:a8b3 with SMTP id g15-20020a0563583a0f00b00166f348a8b3mr2010476rwe.28.1697652863564;
        Wed, 18 Oct 2023 11:14:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b006bae6eea9d0sm3657643pfq.49.2023.10.18.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:14:23 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:14:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] eventfs: Use ERR_CAST() in eventfs_create_events_dir()
Message-ID: <202310181114.55457CFE@keescook>
References: <20231018-ftrace-fix-clang-randstruct-v1-1-338cb214abfb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-ftrace-fix-clang-randstruct-v1-1-338cb214abfb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:10:31AM -0700, Nathan Chancellor wrote:
> When building with clang and CONFIG_RANDSTRUCT_FULL=y, there is an error
> due to a cast in eventfs_create_events_dir():
> 
>   fs/tracefs/event_inode.c:734:10: error: casting from randomized structure pointer type 'struct dentry *' to 'struct eventfs_inode *'
>     734 |                 return (struct eventfs_inode *)dentry;
>         |                        ^
>   1 error generated.
> 
> Use the ERR_CAST() function to resolve the error, as it was designed for
> this exact situation (casting an error pointer to another type).
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1947
> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Yes, please. That's the correct method to do such casts. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
