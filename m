Return-Path: <linux-kernel+bounces-106729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA687F2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D11F239D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177359B6A;
	Mon, 18 Mar 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TuuVIu/V"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14C5A780;
	Mon, 18 Mar 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799001; cv=none; b=ATn49NQYipb28XPX687hkEhQ2PO5D3/e08Jx2Bf82Wjx7aL8Wx8gaIfckzHbL7Y27d5YX96TybKkB5uV1/2QPuafc0EWr5cc27nraM5KyjYXQ20JAI5k6pj2XibeDzv3Qwo7ZBFaPad096gNkWdlTcFHacKDQmSzFU1sQ1J/xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799001; c=relaxed/simple;
	bh=LQlzSO4jZlu/R9+d49B7PtAsfF5y5LqIkz99iZPabwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxCvNyLL6igzRwQZHCZlUv+bYySePU/4+qh0K9bUnjmT3BTuSG920iSAnyEwlwQdOd9oI0ZAdJazFfgrXLHSg9MHoj0wRtAiCvbmXGAy2ttnJdvXohxr/fVzQULHRLzwcBmkBNk4mWLB0q+Qc7tL7Zm/Y7DR6HGRLndPta26s04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TuuVIu/V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC09B40E01A0;
	Mon, 18 Mar 2024 21:56:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id muw0ZI-tpOYL; Mon, 18 Mar 2024 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710798992; bh=jL6oALm6oz0AQpaMLGBefs2+N863KTZI8rUXH8fplhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuuVIu/VjejpM4svNOmmHKQdYto5WHI/9saJoUPQVqSfPoObky2M5V1s/hgeA7Vce
	 N40oqibOVXXCBYXlgvKlEFF/7t1qEWRo8un6fMp9q2NUYICIawYJJm9de3LBelD5K6
	 iR/TfxamB2mIo/c5kog7hsUZtAwpG0KeUvMpIJAfn5Xp9xxZGuDmTvI9qmDslrn+Tj
	 ELdkJ6IjanZdG9AZ7hojjE2fTCou7dkGvJUPPk4f5EvFLxJl9N/rZJwdKIbuFiYTfT
	 iUuqVTR84w2WGbEOTpra9GFQ7tei+Cm/gXKoPCEntv1OpLNS+tBZWp6Vt7i1fegy6t
	 I2JFq8m+AjNbxF1GJwRaYqTwsHk/myjw8RCmQl9G6qwNWsbjqQmWG7laHJSi9tALwt
	 Rnvb/LrvxpvmHCunisN8lPH0XdeVSzdvMAOTn8L6aR7XjgRasRkVRExvD3Ro8g0msC
	 JS5dTfJzMeK9l1jyunXa19eTaWz6M/MU8AlGSMH6VfA2aR+5KuKCPplO4sfzsiq0WS
	 U10qrhXw2DD1vtT8pGt1irPwvV3yq6ILy3BhdSE0OoTjgnigLQdnBElrZZHZ3Oqhlq
	 c2T2mwdCUO7QFcbqoeqR2tB+O1Ae4FYzwElEJQD8qidmY1iq/xQM0Kq5Uu5rPauewf
	 gLNSAB/d9+7fwjqHcENvVuPI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C41FC40E00B2;
	Mon, 18 Mar 2024 21:56:17 +0000 (UTC)
Date: Mon, 18 Mar 2024 22:56:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <keescook@chromium.org>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	gregkh@linuxfoundation.org, tony.luck@intel.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171079804927.224083.15609364452504732018.b4-ty@chromium.org>

On Mon, Mar 18, 2024 at 02:40:50PM -0700, Kees Cook wrote:
> Applied to for-next/hardening

Why?

This is a patch that should go through the tip tree, if at all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

