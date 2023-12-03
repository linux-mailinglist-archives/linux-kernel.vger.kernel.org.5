Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9022802391
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 13:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjLCMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:00:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8678F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 04:00:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso3457705e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 04:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701604851; x=1702209651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gdIS2sfJZGp3+kJnAp+EBCCsp1zJXZRNGW17UzEhN8=;
        b=mah5niDTCH4sSScuc+XhP9rXh2WcB/DLe05ppca/QUWmSF+DOHe+M8SVIcD/PUbgc6
         UhoVmkhl4+4GOxEYA9C44CWvYSHBomgk5M3ONvpu7qISuqga5aWaFB0ii0YhvVzV6obL
         x5q/0Iw7ECPuKQT/yjMtKyzeSyRg8heLQRIuwFOWSvFGcAS8dJtzB5KAK00OzPBgRDOt
         8yMkg+2J/3DRvG3ShOz1EsUbUwwqizjPKq28Ugio0Equk8keEAZtoqdbbzyYlaosLcwZ
         pesUNqp4/7vtY4Eq4nSMIKJqnL+MqrGGey2Q/HbPKsVL6zpwp1EG64PSyHHpq+igr0rh
         USCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701604851; x=1702209651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gdIS2sfJZGp3+kJnAp+EBCCsp1zJXZRNGW17UzEhN8=;
        b=QBJwG/oWqZIGwzd/rjeWgiQxySI6V4+iAwaP2PeHuIMFPq6fx/1fUxyf7WaJqY3SW3
         +MtTAjj51qJn7rM0t47uXj0F9CgDwti2c+P8dSDkA8rIeE82Y49vbjhFRqDXX+EH8+SV
         7j+F1gzWlRXdDYt0+OCIdgiv7Yi8Vt3/BCKhAaiaqITwSoCE1pXIfVfFcxAIZJQB/kiP
         /ez6xwFB9nq0KKB4zxlkxe/sPjUcAFq/vclMTQ38dWF6YYQzhjLbrFhtl6+lt8FN73zd
         q4Zp4TFxMMse94/Ja7Hf06GgDsLcwKVr++gc7nmViEdje4dT3Ney7PftM9Xy6f9NJbqD
         vjQQ==
X-Gm-Message-State: AOJu0Ywao5rL+wxSrxELIfIJCymRg+uPNMGPWdbaljw5fDwu45mKHB7p
        JFxp/RCyQQOJvPYhmPhB4gwIJw81Kw==
X-Google-Smtp-Source: AGHT+IFFFmlyj/5orPKRIwXWvzzhZhVcGIPYSwQC4urrnv3E/eZ6EQ4h/sraK8O7Ynfbt3HpRzEI0w==
X-Received: by 2002:a05:600c:2a50:b0:40b:5e21:dd40 with SMTP id x16-20020a05600c2a5000b0040b5e21dd40mr1538414wme.110.1701604850894;
        Sun, 03 Dec 2023 04:00:50 -0800 (PST)
Received: from p183 ([46.53.252.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090607cc00b009ff783d892esm4110531ejc.146.2023.12.03.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:00:50 -0800 (PST)
Date:   Sun, 3 Dec 2023 15:00:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nolibc: optimise _start() on x86_64
Message-ID: <4d12b353-7417-4776-90de-0f04462cc221@p183>
References: <38183c29-9b7f-4960-8702-d71ce816cf80@p183>
 <20231202132359.GA15040@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202132359.GA15040@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 02:23:59PM +0100, Willy Tarreau wrote:
> Hi Alexey,
> 
> On Sat, Dec 02, 2023 at 03:45:13PM +0300, Alexey Dobriyan wrote:
> > Just jump into _start_c, it is not going to return anyway.
> 
> Thanks, but what's upper in the stack there ?

argc

(gdb) break _start
(gdb) run

(gdb) x/20gx $sp
0x7fffffffdae0: 0x0000000000000004      0x00007fffffffdf33
0x7fffffffdaf0: 0x00007fffffffdf49      0x00007fffffffdf4b
0x7fffffffdb00: 0x00007fffffffdf4d      0x0000000000000000
0x7fffffffdb10: 0x00007fffffffdf4f      0x00007fffffffdf70
0x7fffffffdb20: 0x00007fffffffdf80      0x00007fffffffdfce

(gdb) x/s 0x00007fffffffdf33
0x7fffffffdf33: "/home/ad/s-test/a.out"

> I'm trying to make sure
> that if _start_c returns we don't get a random behavior.

Yes, it should segfault executing from very small address.
I tested with

.intel_syntax noprefix
.globl _start
_start:
	ret
	mov	eax, 231
	xor	edi, edi
	syscall

> If we get a
> systematic crash (e.g. 0 always there) that's fine, what would be
> annoying would be random infinite loops etc. In the psABI description
> (table 3.9) I'm seeing "undefined" before argc, which I don't find
> much appealing.
> 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> > 	Also, kernel clears all registers before starting process,
> > 	I'm not sure why
> > 
> > 		xor ebp, ebp
> > 
> > 	was added.
> 
> Hmmm psABI says:
> 
>   Only the registers listed below have specied values at process entry:
> 
>   %rbp The content of this register is unspecied at process initialization
>        time, but the user code should mark the deepest stack frame by setting
>        the frame pointer to zero.
> 
>   %rsp The stack pointer holds the address of the byte with lowest address
> 	which is part of the stack. It is guaranteed to be 16-byte aligned at
>         process entry.
> 
>   %rdx a function pointer that the application should register with atexit (BA_OS).
> 
> Thus apparently it's documented as being our job to clear it :-/

I meant, ELF loader clears all registers except rsp and aligns the stack to 16 bytes.
There were problems with stack aligning, but registers, I think, were always zeroed.
