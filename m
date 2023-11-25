Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6877F8A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjKYMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjKYMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:11:38 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0894DD;
        Sat, 25 Nov 2023 04:11:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5AE540E0258;
        Sat, 25 Nov 2023 12:11:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EdH3TiqjZDCa; Sat, 25 Nov 2023 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700914299; bh=lXipk2MsKuURRyBeamrn5qlUVJSdVw3qeIkGplBQFJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVHMXdIMPncOpYh8vp/Gt8sIPjBAhGxxgzfTsGMtNrIzT8wggTgyMqTzF2sMopuvJ
         fFocbJt5u7vYk1KWv2aXXVIr+ZlGQdemphn2IjeEZlMNX0WFHnavg4TVFKJX+y18ez
         cGcKjNKw5uyFoU8GV4dxNJitJcyu6bHt4Q3NL7Ub0RAmIgtZQFowBZ+9vs4E3mRv63
         j3kQtwGnNTtSQpMx3YZ2kgU5qWkTJue3GIaK522+AR1akEkGhSjE/IzPx/J739Dov3
         GKP34gBAwkG8NZmyP8EMPhRuXxjo8bwsBko/EnPpLtDzKrN2PpSn+6sTb3Isz3k+dc
         xiBoseG1C8zdPMi12qMElb25fLR3LiwuhduajcqG07p77ecV2hpEf8/RMEKNQOSb+q
         Fh5sKrg5PzV6wG/L87hZX7wthXNkMnLuqxroMgEt0endDC1W3e7q9o8LAD41eFhoFX
         NrczcQWH9c/CVIRiuviiNVgBODS68QaH4Z2D3BbMdQNIjHrpTiFjwFXREF2dv3Vdf3
         6X8CQd6plNpIxOXVhOPK2VJQ7TmE5frF/KYBOFrXbiiWjNtxFbJC0KR+PRRTMTyMXB
         LQ2SG6apkA4OeV23g3JZke+5tCvHsC6UZOPft/wPnNk7lgN5nU9iO1om3rcaxCvA3l
         Rbb6RjLody3WRP8nJoG+7R/Q=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EDAB40E01A5;
        Sat, 25 Nov 2023 12:11:04 +0000 (UTC)
Date:   Sat, 25 Nov 2023 13:10:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task
 work with proper si_code
Message-ID: <20231125121059.GAZWHkU27odMLns7TZ@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
 <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
 <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
> - an AR error consumed by current process is deferred to handle in a
>   dedicated kernel thread, but memory_failure() assumes that it runs in the
>   current context

On x86? ARM?

Please point to the exact code flow.

> - another page fault is not unnecessary, we can send sigbus to current
>   process in the first Synchronous External Abort SEA on arm64 (analogy
>   Machine Check Exception on x86)

I have no clue what that means. What page fault?

> I just give an example that the user space process *really* relys on the
> si_code of signal to handle hardware errors

No, don't give examples.

Explain what the exact problem is you're seeing, in your use case, point
to the code and then state how you think it should be fixed and why.

Right now your text is "all over the place" and I have no clue what you
even want.

> The SIGBUS si_codes defined in include/uapi/asm-generic/siginfo.h says:
> 
>     /* hardware memory error consumed on a machine check: action required */
>     #define BUS_MCEERR_AR	4
>     /* hardware memory error detected in process but not consumed: action optional*/
>     #define BUS_MCEERR_AO	5
> 
> When a synchronous error is consumed by Guest, the kernel should send a
> signal with BUS_MCEERR_AR instead of BUS_MCEERR_AO.

Can you drop this "synchronous" bla and concentrate on the error
*severity*?

I think you want to say that there are some types of errors for which
error handling needs to happen immediately and for some reason that
doesn't happen.

Which errors are those? Types?

Why do you need them to be handled immediately?

> Exactly.

No, not exactly. Why is it ok to do that? What are the implications of
this?

Is immediate killing the right decision?

Is this ok for *every* possible kernel running out there - not only for
your use case?

And so on and so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
