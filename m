Return-Path: <linux-kernel+bounces-56962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F984D1D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A88B262BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247727FBD2;
	Wed,  7 Feb 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eHFEvxRN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CA8405F;
	Wed,  7 Feb 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332031; cv=none; b=XUNCxVnEKuLd05P3aBBoOpY1PrKWvDafB+WAkMfmlxOlMrSO1JoP7e2V3d8313tRmYP55TwEut+9pFX7ifzZBtUfJgTfCpAZVy4J2n7RYg6CGbfJ3PRdm5SdZ7by8hhzm2gyN213B6u/z7yU5L40XOgyCeDiVqnhDIJye0C7Q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332031; c=relaxed/simple;
	bh=kIifLWZA6GB6Ap8YcVsA4bwR69kWKRSPPt5Xg/4Yjfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdNQ50WMetiqkaCCYAQE0RDh4By0cD+wWOuCBAhDyMtVY5OdEeJ31A9YJUemTRfid4IAVbG/ROaTW3eLCYFVBE47P8zNu/JmP/rXaqHMkx3r2rBKPYQt2nU65WPBRaILFtmhRH+RaFwEbaJZ48sbCmTAIoJOXWhD5ZlEzj54TE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eHFEvxRN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2099B40E00B2;
	Wed,  7 Feb 2024 18:53:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0W04lBkSEDeF; Wed,  7 Feb 2024 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707332021; bh=bQtVQeq/bovWEz/qa9RcaBKDWxWNyGWpuE8/90BtrUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHFEvxRNIGiKyIntH2WMgTGrLy4nJeWuYHE7xnw+cJQqyMkQJwYclKb+Or6Q0NZEu
	 GML7IUheRadiDS4BWAEqtyekN3U8SJVOd9QRTydXruP6M5dD+03NUeYQxIxJmWjbQ1
	 4WQsjPRDekYevyurSk3fx0syjuR285BGu6RcGYLdJiDWMD2CNvP/pHdQA/pOlP8/y2
	 EWJ5eHjuIyR6OjoU+MwBl6z/gC89rOFHpgsDphtAA1kqeahMv/tfUfumt+hWsuSUjQ
	 jeIFXfmP0PVWOWDFMmzAQIvjQjVX56we0eGPdI4nib0jBb4jbi8cTj0ngLWvEGDkeS
	 Qz3a5hYOaH3/76D2PZNyeN51OIRAjasAk7sV7HGycOJA9WGI9E2d9pdawLn/DxPGNv
	 L+68twrtX6vTW3isudtQORAPZsuOnXN5CzlgFoZqxoRIwEF4NfNBj3W19yihTunPCY
	 czmVdsDwkKt5rVKroI9tPXQnGqB5Fr2MDvkZ19f9y49JZyHYB+SjykoON53+SDRFBO
	 TnS8/MIqdkcO22eNhHQ6XxG7EL3JtgrnPfjSth/MxiQqn1igIeFR2F4Gp2ivQcujdP
	 DMinZGRDxWISYNx/Ngd3pswoLVD9ICfhPBufr/EPQ+uzO4+ibT/yjaE8MgyEupvJNs
	 hSB2I5VSF1VytbV++Fy3m1UE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DA6140E01BB;
	Wed,  7 Feb 2024 18:53:33 +0000 (UTC)
Date: Wed, 7 Feb 2024 19:53:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
References: <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207175010.nrr34b2pp3ewe3ga@treble>

On Wed, Feb 07, 2024 at 09:50:10AM -0800, Josh Poimboeuf wrote:
> And as you say, there are many frankenkernels out there and upstream
> doesn't want to be in the business of debugging them.

Ok, all valid points. Diff ontop.

I'll queue it now so that it has ample time of cooking in linux-next.

Thx.

---

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 612c9ec456ae..5a300a7bad04 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2853,16 +2853,5 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 
 void __warn_thunk(void)
 {
-	pr_warn_once("\n");
-	pr_warn_once("**********************************************************\n");
-	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn_once("**                                                      **\n");
-	pr_warn_once("**   Unpatched return thunk in use. This should not     **\n");
-	pr_warn_once("**   happen on a production kernel. Please report this  **\n");
-	pr_warn_once("**   to x86@kernel.org.                                 **\n");
-	pr_warn_once("**                                                      **\n");
-	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn_once("**********************************************************\n");
-
-	dump_stack();
+	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

