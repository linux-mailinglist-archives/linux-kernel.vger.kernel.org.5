Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B607DEDE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjKBIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjKBIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:06:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9C196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:05:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f831087c6so135395f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698912353; x=1699517153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5u7kuNoJrAu2EVmfe1219Wj2xWmPQbCojtUwQF8rigM=;
        b=ECBKKqXfbJRuPr9m/yZMl6xAzQVIQrOhRtd5i4oerpRJuHlLDP4w/5I9usoKGiL1qy
         WqOWZ/SAWuDCkbhQ2zpBhdMn3gsOXJb6lvaFgaqOBqCYKrp1O4kgLeTsOW1Ek9QJ751z
         HqIsyWPWdePD83G4FevC/5S7invAPsCyHd6/k8bo8v3K51IW/j+gF2byGOeVLcnb1knF
         7r7b/7rycK8MX+B7uBU5FY3pi7nerPGXf5PX/5zC2GiIUwIDlnGLt2lCqfNU/64RnigH
         T1e1DeiwR8E28DDo25gh92LlFHHEL3Ewk3CPE6Bpg6DdCINdWHo1p3MOZ+A3CSZZGQXi
         imDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912353; x=1699517153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5u7kuNoJrAu2EVmfe1219Wj2xWmPQbCojtUwQF8rigM=;
        b=Fs57fsqyaTi5ZzOuWy2ck5KBTIh571F0TCDWPRoqpasXBSdXlNc8IMoyRvVfAyb+d6
         zfdm+eLC8J2hsMh1BepJGQ8PHLBJG765OIV6PJxAYtv6hILAxj0EWQNaY4Pa+YS2mKPn
         XKO51mpQ1Kc886rJ44RxS9cBzQm7pCKwxv76SF5vA+Htkd2ulvnOEXNs1zxeH0tNKcmd
         gv82ppspXJ23Fmx7+tAoBVjpqcSu+B9yhrfVyW2bk4/kMMQ0K/uw39l5KHiYYaoAbwP6
         RKiddL7J919VF8aRUQEMDTRqYJs8I2c3+TJPUK2zVyOt0vYAXkelepNxK3/BXPccxApk
         3wpQ==
X-Gm-Message-State: AOJu0YxTAaMWFfIAH/hxSq8Yyga00T7wLwrVHo5ttKjw6CuqI8sdF5Y5
        kmmlRxsbVE8Act2bYLapknryng==
X-Google-Smtp-Source: AGHT+IHKn/cvwc6rfVTyb8t7O+dXQFjuiCp1dYnS6tjXQ6nKP9P+b9sC0nRPqWePM/Gtp5u+00bCAw==
X-Received: by 2002:a5d:598f:0:b0:32d:d932:5848 with SMTP id n15-20020a5d598f000000b0032dd9325848mr14694670wri.2.1698912352980;
        Thu, 02 Nov 2023 01:05:52 -0700 (PDT)
Received: from ?IPV6:2a02:8428:26ad:c501:7f88:8dba:8ba:1175? ([2a02:8428:26ad:c501:7f88:8dba:8ba:1175])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d4528000000b0032db8cccd3asm1683344wra.114.2023.11.02.01.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:05:52 -0700 (PDT)
Message-ID: <c3beb693-5592-4a21-88c1-c7f03f8ec75d@rivosinc.com>
Date:   Thu, 2 Nov 2023 09:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when
 CONFIG_MODULES=n
To:     Daniel Gomez <da.gomez@samsung.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "kbingham@kernel.org" <kbingham@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <CGME20231031134906eucas1p10b45c65d43bc0643116808c916c12c95@eucas1p1.samsung.com>
 <20231031134848.119391-1-da.gomez@samsung.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231031134848.119391-1-da.gomez@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2023 14:49, Daniel Gomez wrote:
> From: Clément Léger <cleger@rivosinc.com>
> 
> MOD_TEXT is only defined if CONFIG_MODULES=y which lead to loading failure
> of the gdb scripts when kernel is built without CONFIG_MODULES=y:
> 
> Reading symbols from vmlinux...
> Traceback (most recent call last):
>   File "/foo/vmlinux-gdb.py", line 25, in <module>
>     import linux.constants
>   File "/foo/scripts/gdb/linux/constants.py", line 14, in <module>
>     LX_MOD_TEXT = gdb.parse_and_eval("MOD_TEXT")
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> gdb.error: No symbol "MOD_TEXT" in current context.
> 
> Add a conditional check on CONFIG_MODULES to fix this error.
> 
> Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get the module address")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> Hi,
> 
> I'm resending the patch [1] from Clement Leger with required changes to
> make it work with latest linux-next.
> 
> [1] https://lore.kernel.org/all/20230801125715.139721-1-cleger@rivosinc.com/
> 
> I hope it's acceptable that I've included my own Signed-of-by in
> addition to the Tested-by due to the (minor) changes.

Hi Daniel,

And thanks for re-submitting it ! Totally ok for me that you added your SoB.

Clément

> 
> Daniel
> 
>  scripts/gdb/linux/constants.py.in | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> index e3517d4ab8ec..04c87b570aab 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -66,10 +66,11 @@ LX_GDBPARSED(IRQD_LEVEL)
>  LX_GDBPARSED(IRQ_HIDDEN)
> 
>  /* linux/module.h */
> -LX_GDBPARSED(MOD_TEXT)
> -LX_GDBPARSED(MOD_DATA)
> -LX_GDBPARSED(MOD_RODATA)
> -LX_GDBPARSED(MOD_RO_AFTER_INIT)
> +if IS_BUILTIN(CONFIG_MODULES):
> +    LX_GDBPARSED(MOD_TEXT)
> +    LX_GDBPARSED(MOD_DATA)
> +    LX_GDBPARSED(MOD_RODATA)
> +    LX_GDBPARSED(MOD_RO_AFTER_INIT)
> 
>  /* linux/mount.h */
>  LX_VALUE(MNT_NOSUID)
> --
> 2.39.2
