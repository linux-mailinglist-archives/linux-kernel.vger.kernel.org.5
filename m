Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64517DEE64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjKBIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKBIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:53:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602D128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:53:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c320a821c4so535319b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698915190; x=1699519990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVE1366znDDdUGahkb02KC8IFZyefUqtJav8pg5Z4yU=;
        b=G1MXUbDy+LDtqyxAaxBBfz7WbAdz461XRQB3pTmO8zVJse2o1R4uB01S010s6FtqUR
         r7tJ2bA4ePXftcGLGT6JFYpUmljqCUcoIFWcsbizCWl7gvD8E7aEJFRlMejhwYqTjue2
         CoHHRRUjt0CQeEVsZVUXaHo8N9hup+u1eijiJb78WpRH+R9puRZWLFteBV+zr70HSDRB
         kZNt17EgeQ9FuRKOX2z7oU2vtjewyme1km5KqRGVJPsZmZxocI9U0Csq9LUQ6hIgGyq9
         gRY1DqziVSUyukscjQGwQAXEKcZoRxeemgzdu/fAmwBt8vg6BZtCyMcw4t6WdxFBWIEl
         Y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915190; x=1699519990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVE1366znDDdUGahkb02KC8IFZyefUqtJav8pg5Z4yU=;
        b=G+CPZE0wZGb0QVHJhNSSDSDAgnXjBb+uEO2fnyPR7ZgXyoHKd7/njxar24CIHa6YGr
         6J03lxMp+ysjFfphvKnUBdYwrTuEQ+OeyVgunaigCoRX1dHF/F46e35rb2q6w7V37LCf
         iuEz8xmyrVliG2dmB+F00npiPpgQJWNs5SkbEeCrnsjnbF/tUXAaVZ2eswfuh4bDr+lf
         Q0Cqjp4YGydwhaFuSz7jfn50KbPg0yKqOI2aJgOiuXMoUv/8ydH2Nkyd5Qu9uqhVvXJe
         OsPykuSnvlCXkwyu9GLiGAnh7mMPZRzq9za6buMQ93nEC0+jzeNaSQ8ncLd/lV/C3CTc
         h6+g==
X-Gm-Message-State: AOJu0Yx+Ji/T5yOSbthPyzDyBf4QDBmD4FX3za1Y/L41EmMjfNsHD+GV
        NlSxMoJI+rwuSNGBnyVsMesZo0H8Z71lu9O6J7Q=
X-Google-Smtp-Source: AGHT+IFmL1R/UF0nhz7aD3cuUs+n6jN2r82/CxAkFfbJ0Tsfkn0j6Ww7vsvhb400ENoxqbuA7fqhdg==
X-Received: by 2002:a05:6a21:99a2:b0:153:353e:5e39 with SMTP id ve34-20020a056a2199a200b00153353e5e39mr17559102pzb.51.1698915189954;
        Thu, 02 Nov 2023 01:53:09 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001cbf3824360sm2618011plg.95.2023.11.02.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:53:09 -0700 (PDT)
Message-ID: <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
Date:   Thu, 2 Nov 2023 16:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: mainline build failure due to 9c66dc94b62a ("bpf: Introduce css_task
 open-coded iterator kfuncs")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZUNiwMLBsL52X9wa@debian>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZUNiwMLBsL52X9wa@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/11/2 16:50, Sudip Mukherjee (Codethink) 写道:
> Hi All,
> 
> The latest mainline kernel branch fails to build mips decstation_64_defconfig,
> decstation_defconfig and decstation_r4k_defconfig with the error:
> 
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |              ^~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
> kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |                                    ^~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>    925 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>        |                                                            ^~~~~~
> kernel/bpf/task_iter.c:928:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>    928 |         css_task_iter_start(css, flags, kit->css_it);
>        |         ^~~~~~~~~~~~~~~~~~~
>        |         task_seq_start
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> kernel/bpf/task_iter.c:938:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>    938 |         return css_task_iter_next(kit->css_it);
>        |                ^~~~~~~~~~~~~~~~~~
>        |                class_dev_iter_next
> kernel/bpf/task_iter.c:938:16: warning: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Wint-conversion]
>    938 |         return css_task_iter_next(kit->css_it);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> kernel/bpf/task_iter.c:947:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>    947 |         css_task_iter_end(kit->css_it);
>        |         ^~~~~~~~~~~~~~~~~
> 
> git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> #regzbot introduced: 9c66dc94b62aef23300f05f63404afb8990920b4
> 

Thanks for the report! This issue has been solved by Jiri.[1]

[1]:https://lore.kernel.org/all/169890482505.9002.10852784674164703819.git-patchwork-notify@kernel.org/
