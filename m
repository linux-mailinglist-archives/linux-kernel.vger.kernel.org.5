Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB77AAF74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjIVK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIVK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:26:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153BA9;
        Fri, 22 Sep 2023 03:26:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb93bso15057605e9.3;
        Fri, 22 Sep 2023 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695378372; x=1695983172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/Yn3YU3xUZyWUWNBFaFLjez0LaX2XHNQTW5YI4iTAM=;
        b=R3rYn8BymfNcpPuFJ9/lOJxvrpsDZLp9iYrgv1vol8Og8wAbjgZ5ust5cTs/iiSsV3
         PpdSR/YRo++/PynlSRdtlQjmbwCinQ6PUSZxs0F2sPUhfaEcYkiMCHjMrC5ipmQg3AZa
         mcv3uPiAdMmFLeEQEINDQ+t9BALlRe5+4HhvlTEPFMwClCxKnNKB53C0rvmvkLanAhzM
         xl7kyFitNrDnGcz6h31XquOxYiK30TDl/pwMyzjuy2MXPKXi8BaRIlWrsDMA35LE/gox
         dlce0jumMN/iUISdFn13wIhL4g5l/sAgxAkhMwv/6tOCryCJ+JJKKv+myAaCc3taSO7L
         gkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695378372; x=1695983172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/Yn3YU3xUZyWUWNBFaFLjez0LaX2XHNQTW5YI4iTAM=;
        b=Vuf2TdRn5BpHWxANH0MUhy7kq8cUNGshX/UrUzxnCy6TifzkALdNAaNd3+IU0RVlYl
         v/+U/LrDyCpMFjGrFUHBXh9GLw15eliOhikGzS8U1bjyCAU7Gk/81sMkd9jTy+RPEeG0
         K4HjQ/bEzgFEuzNRSeyGN+1kRysEXe9QI2S5VlKJEk4Uj/Ny0o3JHgxhvC38ErNk8GuK
         IE7/6gJX4c+6MSo3W8/I6gVbOScm8myP841I+wsDA6aQhcdM9P8HmaT476qoyxnweA3g
         4WYH2WZEVAZqXbMZQxCHiIov0iSgTPs3Zi0KS4ZPcJXilkXzSv2S1gcMmah7+5Pwdeg0
         cBPA==
X-Gm-Message-State: AOJu0Yw9pDKKf+Y+FIglwh0LkQ02zFqB592ZoRfQAJRLgrvco3aIyDp+
        dVzAxQQMuj2yxHbjaeKXZ5aXkzZtMCQ=
X-Google-Smtp-Source: AGHT+IFr6IwDElU+t8cV3b4z/Qh4wnwXP2FNweVW0w74ZKltuI2oSSvyjxAK6xtm710AX693ep1ufw==
X-Received: by 2002:a05:600c:1da0:b0:405:3e92:76db with SMTP id p32-20020a05600c1da000b004053e9276dbmr1127667wms.5.1695378371800;
        Fri, 22 Sep 2023 03:26:11 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b00402c0a8a084sm7094849wmk.17.2023.09.22.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:26:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 12:26:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
Message-ID: <ZQ1rwSJsO7A4HR8O@gmail.com>
References: <20230921114940.957141-1-pbonzini@redhat.com>
 <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Paolo Bonzini <tip-bot2@linutronix.de> wrote:

> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1031,6 +1031,8 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
>  
>  static void init_amd(struct cpuinfo_x86 *c)
>  {
> +	u64 vm_cr;
> +
>  	early_init_amd(c);
>  
>  	/*
> @@ -1082,6 +1084,14 @@ static void init_amd(struct cpuinfo_x86 *c)
>  
>  	init_amd_cacheinfo(c);
>  
> +	if (cpu_has(c, X86_FEATURE_SVM)) {
> +		rdmsrl(MSR_VM_CR, vm_cr);
> +		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
> +			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
> +			clear_cpu_cap(c, X86_FEATURE_SVM);
> +		}
> +	}
> +
>  	if (!cpu_has(c, X86_FEATURE_LFENCE_RDTSC) && cpu_has(c, X86_FEATURE_XMM2)) {
>  		/*
>  		 * Use LFENCE for execution serialization.  On families which
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> index defdc59..16f3463 100644
> --- a/arch/x86/kernel/cpu/hygon.c
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -290,6 +290,8 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
>  
>  static void init_hygon(struct cpuinfo_x86 *c)
>  {
> +	u64 vm_cr;
> +
>  	early_init_hygon(c);
>  
>  	/*
> @@ -320,6 +322,14 @@ static void init_hygon(struct cpuinfo_x86 *c)
>  
>  	init_hygon_cacheinfo(c);
>  
> +	if (cpu_has(c, X86_FEATURE_SVM)) {
> +		rdmsrl(MSR_VM_CR, vm_cr);
> +		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
> +			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
> +			clear_cpu_cap(c, X86_FEATURE_SVM);
> +		}
> +	}
> +

1)

It's a bit sad that we are duplicating identical code.

2)

We are doing it in other cases as well: for example nearby_node() is 
duplicated between arch/x86/kernel/cpu/amd.c and 
arch/x86/kernel/cpu/hygon.c too.

3)

BTW., while look at this code I noticed that the 'Author' copyright
tag in arch/x86/kernel/cpu/hygon.c seems to be inaccurate:

 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Hygon Processor Support for Linux
  *
  * Copyright (C) 2018 Chengdu Haiguang IC Design Co., Ltd.
  *
  * Author: Pu Wen <puwen@hygon.cn>
  */     

... as for example the nearby_node() was clearly copied & derived from 
arch/x86/kernel/cpu/amd.c, which does not appear to be accurately reflected 
in this copyright notice?

Thanks,

	Ingo
