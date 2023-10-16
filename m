Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338787CA742
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjJPL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjJPL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:57:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43DDC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:57:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb673so43363325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457429; x=1698062229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXdBFwQTAnTXfPqbukqSELrQm+JStxTV2exIE2XDt18=;
        b=JBJZ2rqcp3R1FoWcbSgd+4XneP4HPcVFT+PMRA0YmagLMa11qVtYiR9rxJVGesdtFa
         BmNTCoZHjCA8/AWXRC6Gc4juiquhQCmhaMwJq5aDJLgCgLnoa+PfVi7ml8839znlGBS6
         bIy6ZFb4qMyruLr9ZZK8SnLTu/MGck+6wwh9whGVjap+l6ERWCTLZS677o/Y8S7CF4zs
         zI4sIV/5RU+cDSz0TzA28IK72OEtkQfYU85HK7w0ZrtJlY9ypUabcXuvuhofH9tG5fjb
         IvkzyRYWpkw0p2U0vtTuJu/9yvOcoeSAdt7uJvRPjSOCzuMk+AinNE5Hr9FQF98Ney+8
         1v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457429; x=1698062229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXdBFwQTAnTXfPqbukqSELrQm+JStxTV2exIE2XDt18=;
        b=ENPjpQl/LgNUTFzd11JD5Q2Y7lI24ZekRqP0YBOpXsZ/bQ1/mm55hS/QCXeeniCl/k
         BbdESQszGM+jSWKOrbqh3jIqokn1mtqpSBhcByuFMiYrRnqE+EN7sCGsoHeTrpr+RyzY
         lnarOrUmn+g57YVF0+cRMZTQuUchh+XIET3iFjFy+q5ZsnIS7dpAM8Zhq11HQJyY65Oj
         cTJ9b1BK1u1fl24CSx3diU7zvWp7JxCeKO83+bR1nXyErgktovsbFUblrpfY0dgCaK+x
         EDao2Z+8ybuHr0Be8CqdR4Gd4l9GhBgMjS3TjtDtmybA5RE3jJQPdyLu2vmc8kzV/Nkc
         G42w==
X-Gm-Message-State: AOJu0Yybs1JQ+Y7BUPLNSA/0BpA6xOkct4B/rsTDlDfKVqwTtjm7LwKM
        slM8cfdi3H5Q5jhxqn2bvSKyb/602pc=
X-Google-Smtp-Source: AGHT+IGgFYsZbQ6D8igJSkjgFwPYp2jlbaDMvTL9qz4sqX7IEuREqBBKqxbm073MZ5E1Zl9clyua3g==
X-Received: by 2002:a05:600c:2947:b0:401:c436:8999 with SMTP id n7-20020a05600c294700b00401c4368999mr28434170wmd.30.1697457429252;
        Mon, 16 Oct 2023 04:57:09 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004063977eccesm7023750wmb.42.2023.10.16.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:57:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 13:57:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH RFC 1/7] x86/head/64: Mark startup_gdt and
 startup_gdt_descr as __initdata
Message-ID: <ZS0lEmEpQOz4iQ4Q@gmail.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
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

> As startup_gdt and startup_gdt_descr are only used in booting, make them
> as __initdata to allow them to be freed after boot.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kernel/head64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 49f7629b17f7..dd357807ffb5 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -69,7 +69,7 @@ EXPORT_SYMBOL(vmemmap_base);
>  /*
>   * GDT used on the boot CPU before switching to virtual addresses.
>   */
> -static struct desc_struct startup_gdt[GDT_ENTRIES] = {
> +static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
>  	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
>  	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
>  	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
> @@ -79,7 +79,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
>   * Address needs to be set at runtime because it references the startup_gdt
>   * while the kernel still uses a direct mapping.
>   */
> -static struct desc_ptr startup_gdt_descr = {
> +static struct desc_ptr startup_gdt_descr __initdata = {
>  	.size = sizeof(startup_gdt),
>  	.address = 0,

Yeah, so I think this and patch #1 are independently useful of the PIE 
feature, and I merged them into tip:x86/boot for a v6.7 merge.

Mind re-sending any other patches for x86 that can be merged? For example 
patch #6 looks good too, but was mixed up a bit with a previous 
PIE-enablement patch. Moving the __head definition to a header should also 
probably done as a separate patch, followed by the widening of its use.

Thanks,

	Ingo
