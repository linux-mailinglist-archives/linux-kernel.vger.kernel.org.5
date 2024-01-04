Return-Path: <linux-kernel+bounces-16409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1F823E09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C9AB23298
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2D200CA;
	Thu,  4 Jan 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gtVej27l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C211EA95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8622C40E01A1;
	Thu,  4 Jan 2024 08:59:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gK9ccJe0EGyQ; Thu,  4 Jan 2024 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704358746; bh=RtrcR3Qo98X35zKZN99wfN8TVVrIa293mVZlo2XepOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtVej27lOwudhs/9JrgIn+QbgPA8TK+L7Oz1Z4y9PogKgOjyCeNt9RMpSbGdrUgSI
	 fhGQLFSndY7erp0jbVRTGc0YTth7REpJYsl676bhlCtRbCG2We9Yf72g1mLxpRsX4r
	 AqHSbAjpYjlRoKvlCbu2B9clcC6mFtVkL7ZPKb2UhVLI63LTLmoJbizVMDIqknlQDY
	 XEsrvHpq4kK/CSdaWIKti6icWRYe7l9pReIFqXljx650TysqIwzglUxe02xJATwpRw
	 UVFsE/rMNcDWPuYzT8me8S7d8CMbqZDdkmwyJhcdEwT46JP7hkpVufp+ZFw2XDReHl
	 UsUhxVi/P/FuNpRRHzjzNloGJaXw8pqtzvKUsYjxi0Vy5n3FaiRMyD0H+Pt5jfj0Ul
	 WmJ1Z+Yaar2bFl6YTpr/RYAUKa4Gn3E7+kp2qln7QQwLZBbwgWVjvoCUWxAWDgFcfg
	 aMQZeu4SS2DZXeXusDcTSgTlowluOceHCjjy2KCUPcvOtOnGfS/QUN6Dj9BMs4MTJq
	 uvqZE0BW7ZS/1Ek8+7li+QjYSBToEt4XI3+O/E2kwTRXxJg09EjN/KlzPHj8spmJy4
	 sPSW7kliB1kHBIt2rlSIeg+gMzv5PSREGO054dGy/hGwVariClPyxHOjqcuywbPiPP
	 gctpPu/CuMOb4huVMrRtxPOM=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5221A40E01F7;
	Thu,  4 Jan 2024 08:58:57 +0000 (UTC)
Date: Thu, 4 Jan 2024 09:58:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240104085851.GCZZZzS/QAtd9dfqWp@fat_crate.local>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
 <20240103181542.GA629234@dev-arch.thelio-3990X>
 <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>
 <20240103205506.GA152662@dev-arch.thelio-3990X>
 <20240103212616.GGZZXQ+IKGPb+EqVcu@fat_crate.local>
 <20240103214804.GA155391@dev-arch.thelio-3990X>
 <20240103215119.GB155391@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103215119.GB155391@dev-arch.thelio-3990X>

On Wed, Jan 03, 2024 at 02:51:19PM -0700, Nathan Chancellor wrote:
> For the record, this explanation really should have been in the commit
> message of 5225952d74d4 but I guess I was not thinking at the time.

That's fine - we have the Link tag. Lemme refer to that thread and we're
good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

