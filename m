Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7177DBEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJ3R2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3R2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:28:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54CD93
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:28:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2800f7c8125so2175943a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686898; x=1699291698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBOyFmhp300ivVzEoJ9WI36qh/bXE0ad6fTBo+6DYnM=;
        b=Aw/A6K5ijrG1HKbcw+/Wkt5J8FQUyIBelHb5X9FImBZLnZb0N8zWS7XYjcV0ce6OI5
         7FaaBV4qTwjQ07208NLwiUHWFMKzvsJx8uQCThIZc3eol8MvfyWarIkR+x0MDGILTXG3
         2Vg8QAMx3oo5sDI14CBLN2HRqyMKyVt4s3t4SOmFY6tCbyLuCVo5hR3b+NHC3RJ3LVu1
         9bBxufK0aVyjtHTSQ9alnTjW6JavHdeDFMeO12qwGM6CQjoVcdpAl3cT2cbF9eEicAI1
         35uc2aaqxTgTdZIhqhxJWInyuvWPsuRsnSJmtscW3yjbrAg7G2qZ8jx7ii0MpYCeQ5AR
         WUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686898; x=1699291698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBOyFmhp300ivVzEoJ9WI36qh/bXE0ad6fTBo+6DYnM=;
        b=jOb4knirX+0HJ8jR1+2vKpB4qCUwOPHPMtF6aJLuszT6RoCY8UfdpK74VeHDHKwfzM
         eUxnsJwKWmJYmYToVuB6n8HVqNubknbZK3BiZ908FZANFufB6jsnj/ECSdUGvYAYdxri
         rbZIcFo6cmaiMT4Np2PMxrcQ5bTSDhBZLHoY2Fljo9ORfTl3MbABVYDdWT52zZf+NxKQ
         gQSge90GE+sF0j83RNE8/xyLa75NUmHPZT4Qag2uxxK65LA1M69CCbeXXbHgsgVj5S7K
         723IGofDTQ+Hfq++hocuyMLTJ1BPe+t4yO2N92Zw1zAGD1/U3nX3nVZQCz4hUULDdaoU
         h8TQ==
X-Gm-Message-State: AOJu0Yx7Y164SelEi7+mUk+AdG1E0CcdLPACt6guZmCaiJCkuayORrAD
        +1Gy+r8sjefzmwxPdNXwKfDjkkBOXCM=
X-Google-Smtp-Source: AGHT+IFWrAY2+AZs601O81Swu+KnxJ6nJY+e8rcRspD2RfCup2XsrG1zo/HiiD4oS9KB267UxRVtyA==
X-Received: by 2002:a17:90b:4b92:b0:280:982:aa9f with SMTP id lr18-20020a17090b4b9200b002800982aa9fmr338767pjb.7.1698686898260;
        Mon, 30 Oct 2023 10:28:18 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b002809074eb3esm427652pjb.21.2023.10.30.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:28:17 -0700 (PDT)
Date:   Mon, 30 Oct 2023 22:58:12 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] proc: test ProtectionKey in proc-empty-vm test
Message-ID: <ZT/nrNd2lwFQ3Sf6@swarup-virtual-machine>
References: <76f42cce-b1ab-45ec-b6b2-4c64f0dccb90@p183>
 <ac05efa7-d2a0-48ad-b704-ffdd5450582e@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac05efa7-d2a0-48ad-b704-ffdd5450582e@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esOn Fri, Oct 27, 2023 at 05:26:24PM +0300, Alexey Dobriyan wrote:
> From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> 
> Check ProtectionKey field in /proc/*/smaps output, if system supports
> protection keys feature.
> 
> [test support in the beginning of the program,
>  use syscall, not glibc pkey_alloc(3) which may not compile,
>  --adobriyan]
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  tools/testing/selftests/proc/proc-empty-vm.c |   79 ++++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 18 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -23,6 +23,9 @@
>   *	/proc/${pid}/smaps
>   *	/proc/${pid}/smaps_rollup
>   */
> +#undef _GNU_SOURCE
> +#define _GNU_SOURCE
> +
>  #undef NDEBUG
>  #include <assert.h>
>  #include <errno.h>
> @@ -34,6 +37,7 @@
>  #include <sys/mman.h>
>  #include <sys/ptrace.h>
>  #include <sys/resource.h>
> +#include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> @@ -42,6 +46,43 @@
>  #define TEST_VSYSCALL
>  #endif
>  
> +#if defined __amd64__
> +	#ifndef SYS_pkey_alloc
> +		#define SYS_pkey_alloc 330
> +	#endif
> +	#ifndef SYS_pkey_free
> +		#define SYS_pkey_free 331
> +	#endif
> +#elif defined __i386__
> +	#ifndef SYS_pkey_alloc
> +		#define SYS_pkey_alloc 381
> +	#endif
> +	#ifndef SYS_pkey_free
> +		#define SYS_pkey_free 382
> +	#endif
> +#else
> +	#error "SYS_pkey_alloc"
> +#endif
> +
> +static int g_protection_key_support;
> +
> +static int protection_key_support(void)
> +{
> +	long rv = syscall(SYS_pkey_alloc, 0, 0);
> +	if (rv > 0) {
> +		syscall(SYS_pkey_free, (int)rv);
> +		return 1;
> +	} else if (rv == -1 && errno == ENOSYS) {
> +		return 0;
> +	} else if (rv == -1 && errno == EINVAL) {
> +		// ospke=n
> +		return 0;
> +	} else {
> +		fprintf(stderr, "%s: error: rv %ld, errno %d\n", __func__, rv, errno);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
>  /*
>   * 0: vsyscall VMA doesn't exist	vsyscall=none
>   * 1: vsyscall VMA is --xp		vsyscall=xonly
> @@ -84,10 +125,6 @@ static const char proc_pid_smaps_vsyscall_1[] =
>  "SwapPss:               0 kB\n"
>  "Locked:                0 kB\n"
>  "THPeligible:           0\n"
> -/*
> - * "ProtectionKey:" field is conditional. It is possible to check it as well,
> - * but I don't have such machine.
> - */
>  ;
>  
>  static const char proc_pid_smaps_vsyscall_2[] =
> @@ -115,10 +152,6 @@ static const char proc_pid_smaps_vsyscall_2[] =
>  "SwapPss:               0 kB\n"
>  "Locked:                0 kB\n"
>  "THPeligible:           0\n"
> -/*
> - * "ProtectionKey:" field is conditional. It is possible to check it as well,
> - * but I'm too tired.
> - */
>  ;
>  
>  static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
> @@ -240,19 +273,27 @@ static int test_proc_pid_smaps(pid_t pid)
>  		}
>  		perror("open /proc/${pid}/smaps");
>  		return EXIT_FAILURE;
> +	}
> +	ssize_t rv = read(fd, buf, sizeof(buf));
> +	close(fd);
> +
> +	assert(0 <= rv);
> +	assert(rv <= sizeof(buf));
> +
> +	if (g_vsyscall == 0) {
> +		assert(rv == 0);
>  	} else {
> -		ssize_t rv = read(fd, buf, sizeof(buf));
> -		close(fd);
> -		if (g_vsyscall == 0) {
> -			assert(rv == 0);
> -		} else {
> -			size_t len = strlen(g_proc_pid_smaps_vsyscall);
> -			/* TODO "ProtectionKey:" */
> -			assert(rv > len);
> -			assert(memcmp(buf, g_proc_pid_smaps_vsyscall, len) == 0);
> +		size_t len = strlen(g_proc_pid_smaps_vsyscall);
> +		assert(rv > len);
> +		assert(memcmp(buf, g_proc_pid_smaps_vsyscall, len) == 0);
> +
> +		if (g_protection_key_support) {
> +#define PROTECTION_KEY "ProtectionKey:         0\n"
> +			assert(memmem(buf, rv, PROTECTION_KEY, strlen(PROTECTION_KEY)));
>  		}
> -		return EXIT_SUCCESS;
>  	}
> +
> +	return EXIT_SUCCESS;
>  }
>  
>  static const char g_smaps_rollup[] =
> @@ -419,6 +460,8 @@ int main(void)
>  		abort();
>  	}
>  
> +	g_protection_key_support = protection_key_support();
> +
>  	pid_t pid = fork();
>  	if (pid == -1) {
>  		perror("fork");

Reviewed-by: Swarup Laxman Kotikalapudi<swarupkotikalapudi@gmail.com>
Tested-by: Swarup Laxman Kotikalapudi<swarupkotikalapudi@gmail.com>

Hi Alexey,
Thanks a lot for correcting the fix.
Thanks,
Swarup
