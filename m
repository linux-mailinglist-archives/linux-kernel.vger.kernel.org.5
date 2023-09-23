Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F147F7ABCDA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjIWAn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIWAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:43:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A1EB9;
        Fri, 22 Sep 2023 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KNRIdUf44g9Un/KxayezGTbM6ynKDPZExldCQORQEZg=; b=f4B+nslvLWKhLuYnfr8J5Ch7AW
        eYS9hKwG1Isa3JaeORvocaeLfcrBMBM6hMcuRUKO6cmeurWYjDdbWiIHd/iU4xdv52gwXW7y3l186
        sL4lkQteOiszPMt6SOAvamG8CDRZ2Cbi2qIuJ12OjisZwztvFXPSmjgDyRDmSNZeWu9Yjec2Ts9Ym
        BrmnfCFAiSBw9oymFpcLFvg34XBuQspLkLcbRLv2d9CTifZXjdjgj4LoQAmRzCQHtFTGpPpyTNJo9
        KDYrecMCUzvVhAooTnbT/tYEhHvznXfnAn6Ll+fobbIT9aT3VYVn95MUXZb3O8yNE9oUjvHMB4Qjj
        chhWT3Hg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjqjZ-00A3SI-1E;
        Sat, 23 Sep 2023 00:42:57 +0000
Message-ID: <d7fa3574-6686-4044-a808-c426be18ad9d@infradead.org>
Date:   Fri, 22 Sep 2023 17:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kgdb: Fix a kerneldoc issue when build with W=1
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aad659537c1d4ebd86912a6f0be458676c8e69af.1695401178.git.christophe.jaillet@wanadoo.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aad659537c1d4ebd86912a6f0be458676c8e69af.1695401178.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 09:46, Christophe JAILLET wrote:
> When compiled with W=1, the following warning is generated:
>   arch/x86/kernel/kgdb.c:698: warning: Cannot understand  *
>    on line 698 - I thought it was a doc line
> 
> Remove the corresponding empty comment line to fix the warning.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/kernel/kgdb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 3a43a2dee658..9c9faa1634fb 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -695,7 +695,6 @@ void kgdb_arch_exit(void)
>  }
>  
>  /**
> - *
>   *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
>   *	@exception: Exception vector number
>   *	@regs: Current &struct pt_regs.

-- 
~Randy
