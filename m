Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAC7CC3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjJQMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:52:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1C83
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:52:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso9986734a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697547170; x=1698151970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCGxqG8VmYbjs0JXGtPdRt/snYHKzop/79rP+5AdwKo=;
        b=dbiVVIi5vJmLcvv09rZ5ULVAbEVwKYhjT/e5qLDNT/uiN6H6ev8hH06B9rKTgFfEjp
         y2FFyKP34x32hpLHGtiN7PB7U3quJ3CTi5UTxzmyQgjgdpmoiGau6skRYonU9Kro1hgE
         6qOjtyhJG7Gklz8s7l77ikTSqZCfZ+GlY5uyxQiv8Q0wtKXmIardnqwEqbnF7/o9+3LG
         y7UoSDc/mYU8JiZL3oda+qOxfjdkExRGHB5+K2GLLgrzHEWrHnRsmRghPyJPSEiqsJUo
         7g3uimyt0xaCB0lrTCl8fiicfqOjFujmXTTu/w6QglSUsNa/5kj9sE9dlOCo1cKft8UW
         lHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547170; x=1698151970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCGxqG8VmYbjs0JXGtPdRt/snYHKzop/79rP+5AdwKo=;
        b=GgjOPMbfSVJOl0CojthsYa0J+6D3cepFehDN1exx3c8aQGK1eNRGwoNJ6yqgYZgEAw
         u5cofGt6OZD9mpDV2trOfFSiyJWc4FTGYL2StMiR23lKbcwaJaCqtwgftxSPoZsB5Ue1
         ttJ7Ebm/MQiUGrvYiiDKQ91mxxtKJu9oqAqUuz321mNTU/0cJoxLXC4msfTn37Kdt9Sm
         EmBLOz6hA/TBGXT4jd9BzSJB7yBY5enVmKOzWNQbzOUuoxBkvQmyo0RamIwdBiwW+tCZ
         0MjwgvS1pzNv7e6yv6MDJLRvxV81WvQ9QgmFjZStb0V1iPAmNWM0h4fjNgiersaA918s
         2+Hg==
X-Gm-Message-State: AOJu0Ywcd1TVdmWq4AD/OwypnopHY3wTlwGXfAh82Ub5ciVBSJ1QKRAI
        HwVgLqEN21z9+PUb21HAC0E=
X-Google-Smtp-Source: AGHT+IHkYtf25vmz7cefjp/lmj+3jYhloZVAF5wOnchkT4mF6HbLOONbOWKNctneh1z0xvGk1lrE2Q==
X-Received: by 2002:a50:ab51:0:b0:53e:5a90:e57 with SMTP id t17-20020a50ab51000000b0053e5a900e57mr1942467edc.37.1697547170095;
        Tue, 17 Oct 2023 05:52:50 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053e2a64b5f8sm1171886edi.14.2023.10.17.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:52:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 14:52:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Rutherford <srutherford@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] x86/sme: Mark the code as __head in
 mem_encrypt_identity.c
Message-ID: <ZS6DngTm9ILei4dM@gmail.com>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:

> The functions sme_enable() and sme_encrypt_kernel() are only called by
> the head code which runs in identity virtual address. Therefore, it's
> better to mark them as __head as well.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  8 ++++----
>  arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++++-------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..48469e22a75e 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
>  
>  void __init sme_early_init(void);
>  
> -void __init sme_encrypt_kernel(struct boot_params *bp);
> -void __init sme_enable(struct boot_params *bp);
> +void sme_encrypt_kernel(struct boot_params *bp);
> +void sme_enable(struct boot_params *bp);
>  
>  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
>  int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> @@ -75,8 +75,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>  
>  static inline void __init sme_early_init(void) { }
>  
> -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> -static inline void __init sme_enable(struct boot_params *bp) { }
> +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
> +static inline void sme_enable(struct boot_params *bp) { }

So I think we should preserve the previous convention of marking functions 
__init in the header-declaration and at the definition site as well, and do 
the same with __head as well?

Thanks,

	Ingo
