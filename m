Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B17B716F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbjJCTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbjJCTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:01:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CCAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:01:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso225638166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696359683; x=1696964483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48DqYMKFMFla9FW3+MHK47HFTEjCMKs7LX0nuOGaX44=;
        b=H/FQEnlgB7RzPX0GBUtDN2W2qP+5doLsoulIP0yLJ04/22gXkb0xoeDh/CA5WVHLiE
         NSwicvtERfWvPM3R/xJzwd7JAc5HskNI6JwSWL6uw+bCbHpFmeRU8QqwUnzGkqOiVhZB
         WEZDorkW7QBAGbySyNZ5c46nBxuGOoPqc/iDdvgwGinRyuuf4pcUouN8BvDprEfsvC77
         ieVwzzkFjGPostEIRDCpo10Rtck0uCz6KphoesaQXDqIH2YovB8a2iDsLNOP2Zv6ah8b
         rJrsLr89Y5lg0hFTiCKZbOjfOOO+tjHl1ODnw24C2cxsdY68i4UPUuEDalbWmnLupGJD
         N/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359683; x=1696964483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48DqYMKFMFla9FW3+MHK47HFTEjCMKs7LX0nuOGaX44=;
        b=NBBgGZqFdMTHDJLFdVHRzeL9CQDcCKgLtSysfXUKSbr1qm3ZT4nUupAHz8f+psG961
         cQFHUa4jdLPfvtTSHd5NpwYnHY6FkRSvdXAiPCD8AvlptGzIr648elRDbaz9j8C9DAO8
         t1c8Vv3eTAtQI9zSJpWqnaDQmGVU6tcn2uQkQH3ND1Jc6YI4USaaped0WEXOCxbSnSVb
         zfIs0uvqot6sw+C2+Nu+xgrNO21OOikyEqNjK6o6upX+63c5N5FLIUnGgS+Uyhn8Sf1g
         YXHQwT+p71tlnZxNHfXx/zzRGG9WicCpP/NOVzgfC96GHUQXA/lKG5QErBbnOrSyYcPe
         /jqQ==
X-Gm-Message-State: AOJu0YxIux4wjlYR6F1EEEycspoyk6NBWaoLk9BBzCFiyz1LWrzCjj2M
        L8FTmQat4VfO60+tM2UHHKE=
X-Google-Smtp-Source: AGHT+IGjizXyRcGiwYB5dxx7hhSxH6KKfgnroo+OyjQ46igauTOeDVREZBxarN9pYXFSb0t9y5qYaQ==
X-Received: by 2002:a17:907:2e01:b0:9ae:5a9f:6a9f with SMTP id ig1-20020a1709072e0100b009ae5a9f6a9fmr33614ejc.52.1696359682922;
        Tue, 03 Oct 2023 12:01:22 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906165000b009920e9a3a73sm1502989ejd.115.2023.10.03.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:01:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 21:01:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2] x86: test that userspace stack is in fact NX
Message-ID: <ZRxlAC0oPlThUgaA@gmail.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Here is how it works:
> 
> * fault and fill the stack from rsp with int3 down until rlimit allows,
> * fill upwards with int3 too, overwrite libc stuff, argv, envp,
> * try to exec int3 on each page and catch it in either SIGSEGV or
>   SIGTRAP handler.
> 
> Note: trying to execute _every_ int3 on a 8 MiB stack takes 30-40 seconds
> even on fast machine which is too much for kernel selftesting
> (not for LTP!) so only 1 int3 per page is tried.
> 
> Tested on F37 kernel and on a custom kernel which does
> 
> 	vm_flags |= VM_EXEC;
> 
> to stack VMA.
> 
> Report from the buggy kernel:
> 
> 	$ ./nx_stack_32
> 	stack min ff007000
> 	stack max ff807000
> 	FAIL    executable page on the stack: eip ff806001
> 
> 	$ ./nx_stack_64
> 	stack min 7ffe65bb0000
> 	stack max 7ffe663b0000
> 	FAIL    executable page on the stack: rip 7ffe663af001

Nice, thanks!

	Ingo
