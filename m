Return-Path: <linux-kernel+bounces-51012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BD84850C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622A91F266BC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28A5D496;
	Sat,  3 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JDJh9DcR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1434E1DE;
	Sat,  3 Feb 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706953022; cv=none; b=amNT0Km4cBKxmeeJgEKovQMoWEb47jjQ6hDmO9sKEy7kQ371ztNGjWTJORnog7vMb3tELUGXAcdISinHig1Iie8drlyE1voSmTUUBfUXRorohblsXg+T7wBMcDBmGUBChGSQE4EVC6zajV7HSwyhU+ld/OXKG1yOOhuTrWRDPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706953022; c=relaxed/simple;
	bh=UYktsagN0I+tahIyyhDGQC+H9O+kh0Mn7iVWGSiReqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE++HdMip/ITmJPSkf/WhJBedDT14Xwnon76gUzzrO97jKdrsIAa1pOUg7cNYISJa+MNqn1fWODTqV5CpzaTYM6bA9ebDJ3itND/pQHrfwi/8/JZevfUE/jmeSco8DHrzrHXxITHY1CgKCBn3E8pG8KvDJ1wIHBwQ9xQqhPQ3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JDJh9DcR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9BF6640E01B4;
	Sat,  3 Feb 2024 09:36:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HVfyqMLWBU5U; Sat,  3 Feb 2024 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706953013; bh=Sk/zbfeC4GIWeKUucZvXBLdXx9M3gCFaCaoZ1mMMTjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDJh9DcRa5/XGK7NcrUPU/TSqlRKqmFB0fegVQao429v9MzGe6S2Ux/iqIqpJkNB4
	 BgRGtlmew37YooudSQvIoMUseFqIXhfj5P7zawVPf73cn30Bs1ogMpmUWZNG5qXGTG
	 M+VhBdc7CZXGxbTq5PQQlss9bdS1xWrr31XOcya09AFmTSzivkGSONWNqFRrMgdviJ
	 rs47gF07V7ZC+JgUBoleYnLfEsFd61ieXbfGWT+9C8Xoay8RSPbvbdYPA+0b71oFDf
	 mUp4pUfIGao8bMzUSiO/sJVN7u+6CGE90UmkQMF8edUvUqJaKhOsO8YhaUCoUsqYar
	 /KeQF4qswXRryHLdwoA1CShEDOSMUCSnIjeofHoKe/eoXogVZKKyacxfPEshvUgJxX
	 inNwWZaeNm9i1sWZLWyq6ieemK/4YDZ16WKVpS0HDp5UPx4kGwCOyGNwB/6jIWYBLn
	 NTKNBEas0XDbeOh8xjhlK0hgbKJOYW8O9MtAcC1N1BD7QTiWFW2FXFxQjBNHwPRw6+
	 TtXxt/NbatQPm+Hf/WisS3TJM18OozMU+bukqcQgFgSAufNLz3Y+FSVzrbusyg1QD7
	 55jrgljv5a3LuJbCAVgOTmVUJrkbzjqXqPVCbkcikZ/N8+e+zltklxdt5XeiUxM/t0
	 TROrCD+dsVE6Fw/4QzlQ94FU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D5A640E01A9;
	Sat,  3 Feb 2024 09:36:42 +0000 (UTC)
Date: Sat, 3 Feb 2024 10:36:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 7/9] x86/cpufeatures: Add feature bit for HRESET
Message-ID: <20240203093622.GAZb4JFuKt9U6PRfBd@fat_crate.local>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-8-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203040515.23947-8-ricardo.neri-calderon@linux.intel.com>

On Fri, Feb 02, 2024 at 08:05:13PM -0800, Ricardo Neri wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 8104f4791abd..3b42479c049d 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -326,6 +326,7 @@
>  #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
>  #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
>  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
> +#define X86_FEATURE_HRESET		(12*32+22) /* Hardware history reset instruction */

  #define X86_FEATURE_HRESET		(12*32+22) /* "" Hardware history reset instruction */

unless this really needs to be visible in /proc/cpuinfo:

Documentation/arch/x86/cpuinfo.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

