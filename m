Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE87D1DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjJUPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjJUPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:00:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC14106
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:00:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so2693729a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697900428; x=1698505228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H+QIOzBpqRz/Cq2J1hXoj5VRjQg+Qv+W9rMCWTVyZY=;
        b=TI3zZ5xZiwUQfsM6LGeUmCqNrQ+g4Vo/EhqMa52k5F+gST4F7ymcPvJvLIYK/DXNPs
         NrHHIP0RHKJ7JZwAnMXV+Ha31ZUK9LRm9boqQELhd8z+S3knin3k4x+8qIB5s/Hz6spO
         t+uyD17ys8LyJqoi1yAVgq6Dz4M097T7Rv+TB78lg5PsazOtm4Ehbt3CHlAOl+NruJEx
         c3ZOEMYXygv/JpqT1CpeRaxgPX00EHJGtQe+HanWw9enkCklGTbfDU5zMH+oaFp/AkRC
         cB++nktpRvD4iTSR2VNwycU0Yf3CMLQja6hM1kpWVDSTdb1mdqCLOn2PuPyHUHEe9VWg
         UqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900428; x=1698505228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H+QIOzBpqRz/Cq2J1hXoj5VRjQg+Qv+W9rMCWTVyZY=;
        b=Dgg4e+H58jJEgjsAzwINuLEjbTt6Eh4VMqSx8HdXWVgBGsd7OM92EOq6vBoi+L/Lum
         V2FrIzRg21PyqnTVF19NCyDsu903MvdZVCCUd76QEVbGEbX7XAxsyJmSDpnOQyJs+gFm
         vifIW/PxaoBuZw51N13HQePsVPc4qMQvzeaDrcBNBlc6YgBUodlEjbSvo1T52O5lJa3d
         wyzXZWTVCvfwBkkQ0oCNeTO51wC4eWcSgGTShRjp7ln4GUhk1O30iqLDBub+EMUT5sVD
         HkThy8C+Ow6bFN0hSA64FoP++X7QBLQ99A66vVN57E6ZVlz0I5fI0BLfpao0ZPqC+7GT
         ab6g==
X-Gm-Message-State: AOJu0YwJTig/CXPAdfjpvS+ADHvt2AV8I7+0NifwmIy7gflZMTThoJfG
        ZzCZWWMt7xckixfcgbSKh4k=
X-Google-Smtp-Source: AGHT+IEUrJX8omdLWjRWoVhG4K8W6esLzaH5Euk+Z/6iWQzevJQbZdoiXbzgZ2QFPLGRuB9oqdQstw==
X-Received: by 2002:a50:d795:0:b0:53e:817e:488 with SMTP id w21-20020a50d795000000b0053e817e0488mr3872857edi.11.1697900428258;
        Sat, 21 Oct 2023 08:00:28 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id eg3-20020a056402288300b0053fa2f11836sm3482683edb.93.2023.10.21.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 08:00:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 21 Oct 2023 17:00:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH -tip v2] x86/percpu: Introduce const-qualified
 const_pcpu_hot
Message-ID: <ZTPniJs9/ep11F2I@gmail.com>
References: <20231021143739.843941-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021143739.843941-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

>  arch/x86/include/asm/current.h   | 7 +++++++
>  arch/x86/include/asm/percpu.h    | 6 +++---
>  arch/x86/include/asm/processor.h | 3 +++
>  arch/x86/kernel/cpu/common.c     | 1 +
>  arch/x86/kernel/vmlinux.lds.S    | 1 +
>  include/linux/compiler.h         | 2 +-
>  6 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
> index a1168e7b69e5..0538d2436673 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -36,8 +36,15 @@ static_assert(sizeof(struct pcpu_hot) == 64);
>  
>  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
>  
> +/* const-qualified alias to pcpu_hot, aliased by linker. */
> +DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> +			const_pcpu_hot);

The aliasing makes me a bit nervous. Could we at least prefix it a bit more 
prominently, like const__pcpu_hot? That way it's immediately obvious at all 
usage sites that it's "special".

Thanks,

	Ingo
