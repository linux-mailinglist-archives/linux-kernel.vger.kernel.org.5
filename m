Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BED7EEA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbjKPXlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKPXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:41:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C36CE;
        Thu, 16 Nov 2023 15:41:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-282ff1a97dcso1096291a91.1;
        Thu, 16 Nov 2023 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178089; x=1700782889; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLrQwETEaOulPz2L2pYAahy/wgJNSC/2QTiYG7KmzQ=;
        b=aFDsT7yiJH+PxhdlaU2dr0Q37h3dj1xCvy2Rse9X8i6beMcJ04r55tWtcZmMw1cVr8
         bb52MD2bqGHJPlR3iGQHVsoRSlUJw/VkmuclijyNEA/hh2QMx4ReVCFfo3Wyz70NZFFO
         isg7O15FlxDijWfYqU2bF7uHR0cjPCkm8ag/8DjQSH5VRUWuJn0jgNCEAJQz3FjDfWlq
         L90WLZKDmBkXdlm2ukZlB75DAifezefGBfvsDf/7VvOtQy8pCHoNMsl9HgYXrbPpxWuF
         wkGmne194AqHESxZ6aCDoTM2MN5Ps1fyX5UAFMZjSD1mlcDpnEZbVkkG+DYtFqzLKuVS
         osHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178089; x=1700782889;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiLrQwETEaOulPz2L2pYAahy/wgJNSC/2QTiYG7KmzQ=;
        b=q+dpf7KJScrZi0xGBJfG43/QAFfdDIZ9JudrhZcFhxeYnnopdDZRLWHodN3tjaYpoO
         52nsPDDOPpxO6GYQJhNrQupPFZdI956C2c7WcbquobY973I9uZ73E4Tul5O+qXKp9kyW
         uC0cDLodq+LT8bSThBn2IhjOUX6tT2pWoNqcufLoDqqChuspqAL5bePvaHrUT7WTC+Ua
         zE+oK7BrPtwCiilwiU4ZEsbF+nOO9jPfEarPOIFLBjV6bBx2Ynv4W43VJZmBzcn++9dB
         xJAy/O1m6+Q7lgDSti+CnF4lkghpaNXya1/8HGCTjaFnet/Mng3LjK1yFUX/Em9Rjesm
         mxYQ==
X-Gm-Message-State: AOJu0Yw6prWGLhQslIcVuDdv1oyEhQ4dDMrF47Ssu22fMgBql63bq0na
        bSPgVRlHSU6riVCCXJgnlg/BuAP7UFGWPA==
X-Google-Smtp-Source: AGHT+IF/a64jkEMjLvU5HrTYydVXWw+sBFD8ZEbwX83QC9cBKoP+WIECyaguB9gkqym/5mt8j0/wIg==
X-Received: by 2002:a17:90b:4c4d:b0:27f:f7e9:cad9 with SMTP id np13-20020a17090b4c4d00b0027ff7e9cad9mr14283876pjb.36.1700178088850;
        Thu, 16 Nov 2023 15:41:28 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b001c9cb2fb8d8sm220941plk.49.2023.11.16.15.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 15:41:28 -0800 (PST)
Message-ID: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
Date:   Fri, 17 Nov 2023 06:41:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Keyrings <keyrings@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dennis Clarke <dclarke@blastwave.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: =?UTF-8?Q?Fwd=3A_sign-file=2Ec=3A149=3A17=3A_warning=3A_implicit_de?=
 =?UTF-8?Q?claration_of_function_=E2=80=98ENGINE=5Fload=5Fbuiltin=5Fengines?=
 =?UTF-8?B?4oCZ?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> This feels like the linker is confused about where to find libssl.so.3
> and/or libcrypto.so.3 for scripts/sign-file.c : 
> 
>   HOSTCC  scripts/sign-file
> scripts/sign-file.c: In function ‘read_private_key’:
> scripts/sign-file.c:149:17: warning: implicit declaration of function ‘ENGINE_load_builtin_engines’ [-Wimplicit-function-declaration]
>   149 |                 ENGINE_load_builtin_engines();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:151:21: warning: implicit declaration of function ‘ENGINE_by_id’ [-Wimplicit-function-declaration]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                     ^~~~~~~~~~~~
> scripts/sign-file.c:151:19: warning: assignment to ‘ENGINE *’ {aka ‘struct engine_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                   ^
> scripts/sign-file.c:153:21: warning: implicit declaration of function ‘ENGINE_init’ [-Wimplicit-function-declaration]
>   153 |                 if (ENGINE_init(e))
>       |                     ^~~~~~~~~~~
> scripts/sign-file.c:158:30: warning: implicit declaration of function ‘ENGINE_ctrl_cmd_string’ [-Wimplicit-function-declaration]
>   158 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:114:32: note: in definition of macro ‘ERR’
>   114 |                 bool __cond = (cond);                   \
>       |                                ^~~~
> scripts/sign-file.c:160:31: warning: implicit declaration of function ‘ENGINE_load_private_key’ [-Wimplicit-function-declaration]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:160:29: warning: assignment to ‘EVP_PKEY *’ {aka ‘struct evp_pkey_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                             ^
> /usr/local/bin/ld: /var/tmp/root/ccqqhtVK.o: in function `main':
> sign-file.c:(.text.startup+0x346): undefined reference to `ENGINE_load_builtin_engines'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x357): undefined reference to `ENGINE_by_id'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x37e): undefined reference to `ENGINE_init'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x3a8): undefined reference to `ENGINE_ctrl_cmd_string'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x3d3): undefined reference to `ENGINE_load_private_key'
> collect2: error: ld returned 1 exit status
> make[1]: *** [scripts/Makefile.host:111: scripts/sign-file] Error 1
> make: *** [Makefile:1273: scripts] Error 2
> 
> 
> If I try to just deal with the sign-file.c by itself I see that I can compile
> and link fine with OpenSSL 3.1.4 : 
> 
> e# 
> e# which openssl 
> /usr/local/bin/openssl
> e# 
> e# ldd /usr/local/bin/openssl
>         linux-vdso.so.1 (0x00007ffcfb3f7000)
>         libssl.so.3 => /usr/local/lib/libssl.so.3 (0x00007f6f3b2fb000)
>         libcrypto.so.3 => /usr/local/lib/libcrypto.so.3 (0x00007f6f3ac00000)
>         libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f6f3b2d3000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6f3aa1f000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f6f3b3e5000)
> e# 
> e# openssl version 
> OpenSSL 3.1.4 24 Oct 2023 (Library: OpenSSL 3.1.4 24 Oct 2023)
> e# 
> 
> I can compile the source fine ( with strange warnings ) with the
>  latest OpenSSL bits : 
> 
> 
> e# /usr/local/gcc13/bin/gcc -c -g -O0 -m64 -I/usr/local/include  -I/usr/local/include/openssl -o scripts/sign-file.o scripts/sign-file.c  
> scripts/sign-file.c: In function ‘read_private_key’:
> scripts/sign-file.c:149:17: warning: implicit declaration of function ‘ENGINE_load_builtin_engines’ [-Wimplicit-function-declaration]
>   149 |                 ENGINE_load_builtin_engines();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:151:21: warning: implicit declaration of function ‘ENGINE_by_id’ [-Wimplicit-function-declaration]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                     ^~~~~~~~~~~~
> scripts/sign-file.c:151:19: warning: assignment to ‘ENGINE *’ {aka ‘struct engine_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                   ^
> scripts/sign-file.c:117:25: warning: implicit declaration of function ‘errx’ [-Wimplicit-function-declaration]
>   117 |                         errx(1, fmt, ## __VA_ARGS__);   \
>       |                         ^~~~
> scripts/sign-file.c:152:17: note: in expansion of macro ‘ERR’
>   152 |                 ERR(!e, "Load PKCS#11 ENGINE");
>       |                 ^~~
> scripts/sign-file.c:153:21: warning: implicit declaration of function ‘ENGINE_init’ [-Wimplicit-function-declaration]
>   153 |                 if (ENGINE_init(e))
>       |                     ^~~~~~~~~~~
> scripts/sign-file.c:158:30: warning: implicit declaration of function ‘ENGINE_ctrl_cmd_string’ [-Wimplicit-function-declaration]
>   158 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:114:32: note: in definition of macro ‘ERR’
>   114 |                 bool __cond = (cond);                   \
>       |                                ^~~~
> scripts/sign-file.c:160:31: warning: implicit declaration of function ‘ENGINE_load_private_key’ [-Wimplicit-function-declaration]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:160:29: warning: assignment to ‘EVP_PKEY *’ {aka ‘struct evp_pkey_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                             ^
> e# 
> 
> Then we link gently : 
> 
> e# /usr/local/gcc13/bin/gcc -g -O0 -m64 -L/usr/local/include  -L/usr/local/include/openssl -Wl,-rpath=/usr/local/lib,-enable-new-dtags -o scripts/sign-file scripts/sign-file.o -lssl -lcrypto
> e# 
> 
> e# ls -l scripts/sign-file
> -rwxr-xr-x 1 root root 37800 Nov 16 16:22 scripts/sign-file
> e# 
> e# readelf -delV scripts/sign-file  | grep -E 'NEED|NAME|PATH' 
>   [10] .gnu.version_r    VERNEED          0000000000400be8  00000be8
>  0x0000000000000001 (NEEDED)             Shared library: [libssl.so.3]
>  0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.3]
>  0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>  0x000000000000001d (RUNPATH)            Library runpath: [/usr/local/lib]
>  0x000000006ffffffe (VERNEED)            0x400be8
>  0x000000006fffffff (VERNEEDNUM)         2
> e# 
> e# ldd scripts/sign-file
>         linux-vdso.so.1 (0x00007ffed8579000)
>         libssl.so.3 => /usr/local/lib/libssl.so.3 (0x00007fde99d2e000)
>         libcrypto.so.3 => /usr/local/lib/libcrypto.so.3 (0x00007fde99800000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fde9961f000)
>         libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fde99600000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007fde99e18000)
> e# 
> e# scripts/sign-file -foo
> scripts/sign-file: invalid option -- 'f'
> Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]
>        scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]
> e# 
> 
>  * * *  T H E R E F O R E     I T    C O M P I L E S    F I N E    * * *
> 
> However my Linux kernel compile fails on that : 
> 
> e# /usr/bin/time -p /usr/bin/nice -n +18 make 2>&1 | tee ../linux-6.1.62.make_j1.log
>   HOSTCC  scripts/sign-file
> scripts/sign-file.c: In function ‘read_private_key’:
> scripts/sign-file.c:149:17: warning: implicit declaration of function ‘ENGINE_load_builtin_engines’ [-Wimplicit-function-declaration]
>   149 |                 ENGINE_load_builtin_engines();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:151:21: warning: implicit declaration of function ‘ENGINE_by_id’ [-Wimplicit-function-declaration]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                     ^~~~~~~~~~~~
> scripts/sign-file.c:151:19: warning: assignment to ‘ENGINE *’ {aka ‘struct engine_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   151 |                 e = ENGINE_by_id("pkcs11");
>       |                   ^
> scripts/sign-file.c:153:21: warning: implicit declaration of function ‘ENGINE_init’ [-Wimplicit-function-declaration]
>   153 |                 if (ENGINE_init(e))
>       |                     ^~~~~~~~~~~
> scripts/sign-file.c:158:30: warning: implicit declaration of function ‘ENGINE_ctrl_cmd_string’ [-Wimplicit-function-declaration]
>   158 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:114:32: note: in definition of macro ‘ERR’
>   114 |                 bool __cond = (cond);                   \
>       |                                ^~~~
> scripts/sign-file.c:160:31: warning: implicit declaration of function ‘ENGINE_load_private_key’ [-Wimplicit-function-declaration]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~
> scripts/sign-file.c:160:29: warning: assignment to ‘EVP_PKEY *’ {aka ‘struct evp_pkey_st *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   160 |                 private_key = ENGINE_load_private_key(e, private_key_name,
>       |                             ^
> /usr/local/bin/ld: /var/tmp/root/ccqqhtVK.o: in function `main':
> sign-file.c:(.text.startup+0x346): undefined reference to `ENGINE_load_builtin_engines'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x357): undefined reference to `ENGINE_by_id'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x37e): undefined reference to `ENGINE_init'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x3a8): undefined reference to `ENGINE_ctrl_cmd_string'
> /usr/local/bin/ld: sign-file.c:(.text.startup+0x3d3): undefined reference to `ENGINE_load_private_key'
> collect2: error: ld returned 1 exit status
> make[1]: *** [scripts/Makefile.host:111: scripts/sign-file] Error 1
> make: *** [Makefile:1273: scripts] Error 2
> real 0.92
> user 0.74
> sys 0.18
> e#
> 
> Looks like some confusion with the linker ? 
> 
> Setting LDFLAGS=-rpath=/usr/local/openssl/lib -enable-new-dtag seems to mean
> nothing.
> 
> Not related to https://bugzilla.kernel.org/show_bug.cgi?id=215750 but I *feel* that
> this code needs a hug.

See Bugzilla for the full thread.

AFAIK, this looks like a bug when the kernel is compiled against custom
(non-system) version of OpenSSL library.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218154

-- 
An old man doll... just what I always wanted! - Clara
