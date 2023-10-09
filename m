Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071587BDA30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjJILli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346268AbjJILlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:41:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1567CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:41:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406609df1a6so42447915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696851692; x=1697456492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=at5Qaj9hVaVRx3LSfPPmHnEYoodzE54HJnIMINcZ6QI=;
        b=Ex4OyTi/kz4NUelDpPV0jTcXGN0aSiycHOotEh1r5k5raoa+IlZTfN9Q8Y7BrYn9M7
         17vcf2a8qPR8GTzH1zbE+PZtpehL2OjdLAFFmurJNbZVGS9ie1qTMk4z9BZijffAIfwB
         5YN7NDRYYPfvdfKa/Q7L0L75TVDt2ENE3SuqHEtglWIkZqSpBsvkqNHl+3QyudoRxUVP
         PF2Tk7yewsJNMc4ZPLB97yiUAl1ZTv8i1gar1zh4rpOAsT/hQU2GqTeSgB2fPA1QhhYq
         JG56C3GbVAW4ElAs99vlCUzzMzRElmWkKj9O5xsxdVB44Hkt3RSztM0mYP1Qt6hsOHia
         4bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696851692; x=1697456492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at5Qaj9hVaVRx3LSfPPmHnEYoodzE54HJnIMINcZ6QI=;
        b=TyGHe7EdMCIm6epm66Q1plwJrSZc1SPyIvy44s3XP/kMYwIhrb39MxT2wAURf81RvB
         5oCACpn24Ktlk4OSNBbnU+78gJ2RD1DtvboVV0EwngKbVOG08JBD3wq2olYqfOYuB19Y
         AYmYZcw3TbeEFeRQEwUtcQpKaJ6GGodLYA9wjNOxCS2cVKtyrbimERXHeNaLrqj76H1z
         NlyS9lYTKHTKq2ApqT2wfXnbMgCRC62/AwcPKKn/iFsiuo8Ys1sJl4akHnxOa3QexFT/
         L1LpZUeLRYroAYcxsr3nOPPltBh42F5zud3xHgbMv3uRd7AVfgehmYnRupC9Q+pB3u/U
         qgbQ==
X-Gm-Message-State: AOJu0YwUzAKnO3/y3vbbg4g907rqVh824Pft38n8VjP/5G5+S9A/75Ry
        qVub3hVXdwfGMh/YQZmyF6E=
X-Google-Smtp-Source: AGHT+IGywA2HBz0gSPuVo0gqn4U6M1z0A9mhr5WSsVNxgzKddWybHTKF//GGOPNCZfR6yd7ZqYQ1EA==
X-Received: by 2002:adf:ed11:0:b0:317:6653:60b8 with SMTP id a17-20020adfed11000000b00317665360b8mr12479308wro.50.1696851692281;
        Mon, 09 Oct 2023 04:41:32 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d6345000000b0032326908972sm9350665wrw.17.2023.10.09.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:41:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:41:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZSPm6Z/lTK1ZlO8m@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
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

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ecb256954351..1edf4a5b93ca 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
>  
>  config USE_X86_SEG_SUPPORT
>  	def_bool y
> -	depends on CC_HAS_NAMED_AS && SMP
> +	depends on CC_HAS_NAMED_AS && SMP && !KASAN
> +	depends on CC_HAS_NAMED_AS && SMP && !KASAN

So I'd rather express this as a Kconfig quirk line, and explain each quirk.

Something like:

	depends on CC_HAS_NAMED_AS
	depends on SMP
	#
	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
	# with named address spaces - see GCC bug #12345.
	#
	depends on !KASAN

... or so.

BTW., please also document the reason why !SMP is excluded.

Thanks,

	Ingo
