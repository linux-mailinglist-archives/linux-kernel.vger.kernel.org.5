Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44E878F46E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbjHaVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbjHaVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:19:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7491B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:19:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so9811015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516770; x=1694121570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgjZSn+XzRdQtk5CjJzK65S/oVJ5s5Kx/vC5PIMJxmI=;
        b=M0eNpFobsihEzRWz3U+4S9VOkP0cCJ6XNhfe5VLptD5trIJBGGt1oWF/eTEpF9xNR0
         bT99lKpmuT0iUGBgW7ZLsaE9h8xMH8wDg7sVetoLo73MLUX0ATtxoVceJZCoMm5ikmr9
         zSKrMwup3aFPga3mA6VB5o34BfSsDNZzC3Z/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516770; x=1694121570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgjZSn+XzRdQtk5CjJzK65S/oVJ5s5Kx/vC5PIMJxmI=;
        b=JCZCymBL0Kbv5cLoGCQygNXjqyi2ef9bAsvqD4mfXhte91h6uhPykjaTJ6BIVF+Gv0
         4BJf4uLOxgKRi1z7DV7Ib2yPcY/yVZ6Wdz5ZJXd2ar0yMxKc6sjvx3v8V9SqOdcMFmDQ
         k8hVWPKvTRE82XpCW1GKg82FBm+CxRXs24AKJ3/GNyIRgafgmGg2rAMsViTaJJA2LX54
         YF9wXXYcE9a8kc9z7QvJpi23D5xwzdnEdBc3rIgGAHmZfT2oMl6AdMA+n7RdHMspKi8T
         wlo97jlKJl6XnFAK4OJMZCHsxCGxh60tU4h4g4Zgni2hrSFlENr2TNZzzY78jmpieaVh
         FyEw==
X-Gm-Message-State: AOJu0YzSNULjuSBk9Q7zQRYqbiVRWPJuaNWqC2v8rvWK4a30lTVaCBZs
        U/ptbtfMJPgYWDZHPZG1Ziz9mFgagPG60KNRrMI=
X-Google-Smtp-Source: AGHT+IFcGroa+xsbzbiY6btCmK0qXmWudMPFzGB50zP3JbwjFaXDu0oQ03cZQvba4JfNwBFdPyD3zw==
X-Received: by 2002:a17:902:e752:b0:1c3:1316:ea85 with SMTP id p18-20020a170902e75200b001c31316ea85mr834108plf.47.1693516770230;
        Thu, 31 Aug 2023 14:19:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b9fef7f454sm1652953pll.73.2023.08.31.14.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:19:29 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:19:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC] init: fix -Wmissing-variable-declarations warning
Message-ID: <202308311411.B2B57B7441@keescook>
References: <20230829-missingvardecl-init-main-c-v1-1-ddf0f1a71215@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-missingvardecl-init-main-c-v1-1-ddf0f1a71215@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:38:31PM +0000, Justin Stitt wrote:
> Hi all,
> 
> I was looking to get some help on solving this -Wmissing-variable-declarations
> warning as there is some hope to turn it on for W=1 soon [1].
> 
> When building x86/defconfig with Clang-18 I encounter the following warning:
> | init/main.c:189:13: warning: no previous extern declaration for non-static variable 'envp_init' [-Wmissing-variable-declarations]
> |   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
> |       |             ^
> | init/main.c:189:7: note: declare 'static' if the variable is not intended to be used outside of this translation unit
> |   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
> |       |       ^
> 
> It seems like the obvious solution is to just add the `static` keyword
> and be done with it. I suspect, however, that it is not so simple for
> the following reasons:
> 
> Firstly, `envp_init` is surrounded by two other variables that have been
> explicitly marked as `static` which leads me to believe that this one
> was intentionally _not_ marked as static for some reason:
> | static const char *argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
> | static const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
> | static const char *panic_later, *panic_param;

I went looking to see the history here and it goes beyond git history.  :)

> 
> Secondly, there exists this `extern` declaration for `envp_init`:
> | init/do_mounts_initrd.c
> | 90:     extern char *envp_init[];

This is the only user of call_usermodehelper_setup() that doesn't make
its own envp. And there's a deprecation warning in that function too:

9acc17baf1fd6   (Christoph Hellwig      2020-07-08 18:18:54 +0200 93)     pr_warn("using deprecated initrd support, will be removed in 2021.\n");

> Any help here would be appreciated!

I recommend making it static and giving handle_initrd() its own copy:

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 425f4bcf4b77..154bd0de85a6 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -87,7 +87,7 @@ static void __init handle_initrd(char *root_device_name)
 {
 	struct subprocess_info *info;
 	static char *argv[] = { "linuxrc", NULL, };
-	extern char *envp_init[];
+	static char *envp[] = { "HOME=/", "TERM=linux", NULL, };
 	int error;
 
 	pr_warn("using deprecated initrd support, will be removed in 2021.\n");
@@ -100,7 +100,7 @@ static void __init handle_initrd(char *root_device_name)
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
+	info = call_usermodehelper_setup("/linuxrc", argv, envp,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
 	if (!info)
 		return;

-- 
Kees Cook
