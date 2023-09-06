Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578FC793C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjIFMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjIFMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:11:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8952E71;
        Wed,  6 Sep 2023 05:10:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so34617485e9.3;
        Wed, 06 Sep 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694002255; x=1694607055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN27Bg97nR8cwg/8zgt3sa8MoXJh4UkwGr5wouU/s0Q=;
        b=bXPiwUUzNXyBwXnxsxgsQsVsFvDRVWgEp0SXlGeYJuxUNx4T4IfZSeBg1kVNRp8P0e
         cKN5yLJKZ8/AzT+Pfq0Nndof98/3o+3o2DyKP2AIVqFd4ZD4KBPnucjU0XjVBptlBNq4
         32+kP4pbFrYlNx3K4Ts4C05jMCOJRZsf9KMsiUwKPCHNnNQ+fLzMmi7QU0flD/rJOCwe
         L5mJkLEXDGt8476DHnWEjlsAhMsd+tmoDsN5/XEbyHJwOw+Wg3jpTQZnO/Zewy7YTYrA
         87lON5I3rRIdkSeHfO4ao/TuizLKGkui7qRP1WNUa9YxUvjI9MiafraztffzeiPGHe9P
         9S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002255; x=1694607055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN27Bg97nR8cwg/8zgt3sa8MoXJh4UkwGr5wouU/s0Q=;
        b=You4i5HVeXkpMke92wayKGGyvKV7ZlYVol2apa2GossdT/ZvIMB7SZGlFXoBoHjdFv
         nS9IR7Jxql5ZUgcBK4XWEFmx/NJGZroP0cxBZ0fflbcQjBf9M6X93WsuTzNp4sOk7uS8
         1KfN9C8Lr+UWxoGZT/6ebXqF3gzob/M0QzgWngGIsKn6PyVQ1aqlM/GrHvnYrYoIc20p
         yiwVD/xWNorbGk17p8ba9wUiEKXtAA29aZBhLL8LzNcIW8KqJeWCe3Ft4WBw7iEDNx0T
         EEzU4houlcFCid9NIP2Xj6vOLSZpFNnMNxTO0q61hDgTXTaXGTQJm5uZe21ETA2OLKmo
         iqnQ==
X-Gm-Message-State: AOJu0Yx4r/8G/LHHsoP7Ekwgg+D2EARZWiZ6B3PG6JXZ422eUnCqD95Z
        kOS83B33RO4Op60IJE44zK8=
X-Google-Smtp-Source: AGHT+IG5C0lhFrctMwXr9Vg+5WMKgqS3JMG7vBWZCaKhkzljbpHE5oNPHkp0U+DO5Ew8yG4OdwvwBg==
X-Received: by 2002:adf:ee08:0:b0:317:5e73:7594 with SMTP id y8-20020adfee08000000b003175e737594mr2300292wrn.28.1694002254719;
        Wed, 06 Sep 2023 05:10:54 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id f4-20020adfdb44000000b0031984b370f2sm20261025wrj.47.2023.09.06.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:10:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 6 Sep 2023 14:10:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Message-ID: <ZPhsSzHG6YMViOSk@gmail.com>
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Justin Stitt <justinstitt@google.com> wrote:

> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> destination strings [1].
> 
> We can see that `arg` and `uv_nmi_action` are expected to be
> NUL-terminated strings due to their use within `strcmp()` and format
> strings respectively.
> 
> With this in mind, a suitable replacement is `strscpy` [2] due to the
> fact that it guarantees NUL-termination on its destination buffer
> argument which is _not_ the case for `strncpy` or `strcpy`!
> 
> In this case, we can drop both the forced NUL-termination and the `... -1` from:
> |       strncpy(arg, val, ACTION_LEN - 1);
> as `strscpy` implicitly has this behavior.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Note that this commit is already upstream:

  1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")

Below is the delta your v3 patch has compared to what is upstream - is it 
really necessary to open code it, instead of using strnchrnul() as your 
original patch did? Am I missing anything here?

Thanks,

	Ingo

--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -202,10 +202,13 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 {
 	int i;
 	int n = ARRAY_SIZE(valid_acts);
-	char arg[ACTION_LEN];
+	char arg[ACTION_LEN], *p;
 
 	/* (remove possible '\n') */
-	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
+	strscpy(arg, val, sizeof(arg));
+	p = strchr(arg, '\n');
+	if (p)
+		*p = '\0';
 
 	for (i = 0; i < n; i++)
 		if (!strcmp(arg, valid_acts[i].action))
