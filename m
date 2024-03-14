Return-Path: <linux-kernel+bounces-103576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C387C151
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DFF283424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191A7351E;
	Thu, 14 Mar 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JSAM8cgc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A802C9E;
	Thu, 14 Mar 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434051; cv=none; b=Q+/xA+rfHPafY5atwuUetMjXlxqnW5WMj72ufs7RvMvkeppc16IAWw7+kFXWnUu5BBdWSV6Mqay3obY1mDxK39c+HeZ1p2qQnyiQ/G+3q5L32gQSlenqGTEYnBSuxwj6dc3T7aarGGgPrZNgfU/Rb58HX4g453CVUoZHBqh3YTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434051; c=relaxed/simple;
	bh=kibFCeQMtEz5xXusvehuh0Ajm4crimAZT3g/L1kygAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxVNYmM+6srP8Su4exDTsj6sayGCk0SZc2SLgDYxkdLOSOc53uIZSiWXHhvi+Ie53P9HK7bTQO/cujhbRa95E25JVyrWN6TN6pvorrJmid9Pv2Dwoz5p/YN4+OIoGDCH6a8GmQrHa7TnjsdChcjWtTPHyTKX2kvC1XwVWbTKYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JSAM8cgc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E10940E0196;
	Thu, 14 Mar 2024 16:34:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8u331dPGBT4t; Thu, 14 Mar 2024 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710434044; bh=GGF0W7br1YH0ZUlowMCaPMKKH8Q1iNP76Vr0o+a0Qno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSAM8cgcbWNcgxL5xkU6azEPrkz//J+mlQKFJ/7VqRuZZv+Uwu2dVlcW7GpSsD8K1
	 jGurAjPDQXcf0lNcGO20/AXzsa+stfPbYHuY6Zr47bNGeYgqfq8LjQHc+hQqwMV5NT
	 P8ilKqJBqq+JAxMMIY/54tgtojeeOlTXp/u4t2simmbbg/zsJlmxfcxCXf9f1GJhvx
	 y4n6MLLdHSNcYzkQ49D/xrkolApNRt9UIh8a5MwLKKUxS8gETCwWi2NFhGuSjz42uK
	 xJ+M3I4YiPyVe8gvYa8ghAYu9gv9PiTIk+KoyNx3I6UTev0DBFJJuUT9waQKrv9T+K
	 Z4hasRC9L8UjFNa7tyKaj+EDdUJnEBTlWB1RnIO3pQNWIhy50KKlW8sUFZc71xMva0
	 gdg6livm0X7k1KxPJjo2droDcfx7XCayZX1JIE5OLjYYC5AVd4uAbXMqBfeDoB6qJk
	 EFZQAzxSV+rxEU4h+RkxuerWIwJIXdVJi0Z2MNIIOhz8YwnOzlo73fN05fsNk0pGj6
	 yGGOlMYUFxWB8gtuBxXnc4uLS4uWZkLTgmNEvcrcPRcC9mR9PR/Wby5EXFWNEugTfi
	 fkQqkSSMFAV3KW/SqtHEEVg2mircpzHLR/bcvrRK7nb9q1Acu2ttVHZpHjYC2glhrd
	 nIXWKv4LaCeAHb3Mzt/TL/ak=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C91240E016B;
	Thu, 14 Mar 2024 16:33:46 +0000 (UTC)
Date: Thu, 14 Mar 2024 17:33:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Willgerodt, Felix" <felix.willgerodt@intel.com>
Cc: Vignesh Balasubramanian <vigbalas@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"jinisusan.george@amd.com" <jinisusan.george@amd.com>,
	"matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	"jhb@FreeBSD.org" <jhb@freebsd.org>
Subject: Re: [PATCH 0/1] Add XSAVE layout description to Core files for
 debuggers to support varying XSAVE layouts
Message-ID: <20240314163345.GBZfMm6Ve5QMY_xPjl@fat_crate.local>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <MN2PR11MB4566BF54DEFF9B7627B096B78E292@MN2PR11MB4566.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR11MB4566BF54DEFF9B7627B096B78E292@MN2PR11MB4566.namprd11.prod.outlook.com>

On Thu, Mar 14, 2024 at 04:25:44PM +0000, Willgerodt, Felix wrote:
> I am wondering if it wouldn't be easier for everyone if corefiles would just
> contain space for all possible XSAVE components?

You mean we should shuffle out from the kernel 8K of AMX state even if
nothing uses it or the machine doesn't even support it?

That's silly.

Please have a look at this:

+struct xfeat_component {
+       u32 xfeat_type;
+       u32 xfeat_sz;
+       u32 xfeat_off;
+       u32 xfeat_flags;
+} __packed;

What is wrong with having a blob of such xfeat_component things
describing the XSTATE buffer and parsing it in gdb?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

