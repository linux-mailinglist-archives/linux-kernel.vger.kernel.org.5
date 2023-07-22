Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC775DB05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGVIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:20:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3606B2D58;
        Sat, 22 Jul 2023 01:20:39 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D205B1EC0913;
        Sat, 22 Jul 2023 10:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690014037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XR3UNX8RgzZpo1YGjhXiWPaIQ73v+HtsnelzEa3LMFg=;
        b=gFvgpWt7fGFgCBuarzhUn+E0dIpslGa4P8R5RdHo6A2rosE3SeL3uKvyc1WheeU3Sj5ZL/
        0Z8z2Orz/n14psiioUOr3rUmGNlb1ggtpZyIEmDkoBtrmqJuUcmvw3E7LnkNj9sngrVGdN
        IE6p2EYqkhmJDy0QENCyz1e5tjy/9n0=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZWfNUrTO_JGa; Sat, 22 Jul 2023 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690014035; bh=XR3UNX8RgzZpo1YGjhXiWPaIQ73v+HtsnelzEa3LMFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhytrHnTW1/oavjK/NBDv5koRvZArNFgfXvRAfLtu5e/d0VfbjI/TkLJiLNjgxlpD
         MS4X5NEz8yYZ2FDDFwDPBLSoxxiqB8FkXtPF7Euui8HNGY/E4HTXXIE1452fEATZSo
         nZ6XwdYXSXmP03ksmQ0rV231l7Azb3Z7L2CrlIx/As83ECHWj1naawYDymYyH9Nhob
         b8Aei0UXA4IQZ/8m+MplCNghK6ck/m+qwS7h3Kje7AvhcyHeB9CRM4NT3S5hegk9AA
         7R2haXyGtdKvp4NJVLYkeH750q/wEUy7MMZxTxAk7HcFqgnvnB3zaTeB77z6FfuBmH
         1+wGGqCEbIO1jfYz+KTaO9H85/X7hQpa4rZFGPbjUg22KHMXWbOm1Mg8NW28Gm5VI8
         eeCSs4l1BHmhDZMn1/vLAXSKVjlkPHWL3VsDPXLOKfyGGWEU3kMCdwETUn9tyRbq5k
         bt6Ur8H5OaO6LeuGHp5Bs4GGUqVCcjh/BFRi3TVC1F58Ms8UZVIROTEjc+2IwNhYfs
         AkGaVM0V9nJ8+LSoCSxpruOblSCuon6QWJklJ/FU+lF676+hf94Oxml1Kul1PhTpJR
         Qp3E+x/DKlN8hMTC54bH3TL/DnLalNfH0PTs6AwPuaP0BCOyOLXrm2CHbBQGEN7WUS
         C2UaD5Pk6GJQCCcvgQgIBf4M=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 477AF40E0184;
        Sat, 22 Jul 2023 08:20:26 +0000 (UTC)
Date:   Sat, 22 Jul 2023 10:20:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 3/7] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank
 types
Message-ID: <20230722082020.GAZLuRRHolh+6KacI8@fat_crate.local>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-4-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720125425.3735538-4-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:54:21PM +0000, Muralidhara M K wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 5e74610b39e7..cf8b4616fd31 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -107,6 +107,7 @@ static struct smca_bank_name smca_names[] = {
>  	/* UMC v2 is separate because both of them can exist in a single system. */
>  	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
>  	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
> +	[SMCA_MA_LLC]			= { "mall",		"Memory Attached Last Level Cache" },

"ma_llc" - not a mall. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
