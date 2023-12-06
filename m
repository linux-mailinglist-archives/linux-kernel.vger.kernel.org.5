Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C5807BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjLFW6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjLFW6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:58:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3C8D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:58:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so41117b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701903504; x=1702508304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlRwxrjO/fwpJbdnxlIZRwQlN6+I20Mp4XVwBmKHsZs=;
        b=XEycvlSLVhHjwQQEo0A3dAfC92LbsY7kCx9Yy2e90+kQlFXZ1JjVu7inbpKPDiwit0
         +MBeV+wBPzjfsV25hGxHD4lLfFb5nd6uWvebbMmUDwFvTs0HgeybJTL/L5bfGF2wkYdn
         Fm00IYR7WcyXKpm9C8iLzqq9b4RUPFkfN17Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903504; x=1702508304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlRwxrjO/fwpJbdnxlIZRwQlN6+I20Mp4XVwBmKHsZs=;
        b=TIJbJrJi1zoXXyrC/hBSxoegHHvllPAJfw9utNnsRxfMJwgbNMR0uObQLbfQhSmBXy
         8537W4PKO9j4kfdwfqZ5yRZ5r4FoKq1Q2KuCJqTRwYa03BexaWyl/FKre2jyXn/NObvg
         MgEgtBeltdV3l15eMT4R0xMwolxFh9qExQL0q2ILju275nGL5MqH66dwKGxB3QQGRgiT
         t2//2u0w+lGMAI8tXNUzgD74Mmu49r/6Vb88iqqhmueJ+Xao7Ra8B+rV2j2zqzGl2pSZ
         /HysW47H9tfxNKKggWLp8XyP450vjkfeugZXGUMjUa1L+MXphCxLvTaWvG1Cxp8nMz8d
         egqQ==
X-Gm-Message-State: AOJu0YysuqMO2lQfQSQAu6o/wGlaSHh1OPURjqZvzl/euq/z9trKMy8e
        Nx4igoYk8nQxfTo2Ag/6PluBYQ==
X-Google-Smtp-Source: AGHT+IF21TEfSUWNryCsppjMZp7UZtzSTndkR8MeQxDsRI0Vo9gwMzOLX3f62R0JkmE2aAtvmNiKUw==
X-Received: by 2002:a05:6a21:6d9d:b0:18a:b5c3:55c1 with SMTP id wl29-20020a056a216d9d00b0018ab5c355c1mr1334523pzb.57.1701903504112;
        Wed, 06 Dec 2023 14:58:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090ad51800b00286d44e0c59sm336823pju.36.2023.12.06.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:58:23 -0800 (PST)
Date:   Wed, 6 Dec 2023 14:58:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3] ELF: document some de-facto PT_* ABI quirks
Message-ID: <202312061456.2103DA1@keescook>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
 <87edp7jyu4.fsf@meer.lwn.net>
 <88d3f1bb-f4e0-4c40-9304-3843513a1262@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d3f1bb-f4e0-4c40-9304-3843513a1262@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread necromancy* Question below...

On Sat, Apr 15, 2023 at 08:37:29PM +0300, Alexey Dobriyan wrote:
> Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
> program headers are slightly different.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> 	v3: move to Documentation/userspace-api/
> 	v2: integrate into documentation build system
> 
>  Documentation/userspace-api/ELF.rst   |   34 ++++++++++++++++++++++++++++++++++
>  Documentation/userspace-api/index.rst |    1 +
>  2 files changed, 35 insertions(+)
> 
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/userspace-api/ELF.rst
> @@ -0,0 +1,34 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================
> +Linux-specific ELF idiosyncrasies
> +=================================
> +
> +Definitions
> +===========
> +
> +"First" program header is the one with the smallest offset in the file:
> +e_phoff.
> +
> +"Last" program header is the one with the biggest offset in the file:
> +e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
> +
> +PT_INTERP
> +=========
> +
> +First PT_INTERP program header is used to locate the filename of ELF
> +interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
> +
> +PT_GNU_STACK
> +============
> +
> +Last PT_GNU_STACK program header defines userspace stack executability
> +(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
> +
> +PT_GNU_PROPERTY
> +===============
> +
> +ELF interpreter's last PT_GNU_PROPERTY program header is used (since
> +Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
> +program header of an executable is used. Other PT_GNU_PROPERTY headers
> +are ignored.

Should we perhaps solve some of these in some way? What would folks
prefer the behaviors be? (I like to have things been "as expected", but
it's not very obvious here for redundant headers...)

-- 
Kees Cook
