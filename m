Return-Path: <linux-kernel+bounces-33090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798D83645D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6957AB28165
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B63CF5A;
	Mon, 22 Jan 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k7wJFUTn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B02629F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929672; cv=none; b=j0bb2546M6BmMY8veY8RCBBD0yxEtthnRRM9bhSywGBWS/cic3llH6UyGgcRwsur1OynSqbTAYIugyt9hleAN0TGKh6XxQt19QOOiMF1XrEFxrpgPCoQ4+YF6jBQww3kO4oHItgLNwcGBvtXpfGTNTZoQiE02smlhrLjXeGS6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929672; c=relaxed/simple;
	bh=HnNJBC8+2y7p4meMSHy5WF4C+de8lEpVqAL1/oy+eYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVgB+d8xzSYKrANPQJoCE6S3UfpWqeNOwCg9otHNo0QjgR1fEg6lU4xblSFC2S53aLD3fAp1cSSxoC54OO1uyTxfBjsSueGEvaCv8LI3WbbPbyVi4f1akHKHocSH4ng6kYDdLTo1eSm/cvgjQgdqJDaLIDz9WZU5gItV4DpgEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k7wJFUTn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD32540E01B2;
	Mon, 22 Jan 2024 13:21:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qnWR47hUZ0la; Mon, 22 Jan 2024 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705929666; bh=919c1xhHphTCX2RhMAAOfW7c17gtK4ZxzQCfEYVwwaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7wJFUTnPp3OfFjuCUl8t9miRfn9pkhct9BTNH7P1tRh5cFvJDmOfMASuNI2xDJEx
	 b7SodbdHOBdBGw19SxqndTF8OOtillwfjfFNC6gBx6xwGq5HxcoPqQ77QMaOCOVQ+N
	 YdWzP+KcnhqGawYtIjNFsPb2jHngrZM0RQt9dc/9JZOPDnulZ4MHyh0Dj4Kmzoh6kX
	 mfDNsdXXEQxOeFUVHu+E/fHQ8Oqpq+zhUQyjyoUn7HQFbp2VpO1Uk4b0oELHjd+L7X
	 N4orjFkYaFJGRqe7Ms6wvPAbPNmYkvGh7+Dg+uz1lZXJKJyzjXkOY0IRzQbYXrSDwb
	 5x+PZOcriexSOSIHQALzqNTT9Ya6f2tdcP7vbpP9UNpq14JS5eNmts8uoJRwnXntLp
	 05s3vxWKwkpvs/3gB86fGVhjZlZpbwAEbTUI6bOyI3yGiHnyKFHxriY+Z4vZ/pBvD1
	 kAuhmFUvqJSrqn23oQEmUtPAkqkdJ1zHSlculyzhKPYM1xopfjIcG46gFeTvu/ImK8
	 fZpCCdTzu8s2k/wWn5xTHSthj2MbeDkLdcilxYkFFc+gYBuKVSU/nKbFeELyI4Vi1q
	 Tnh7h7Q12o9Bxd0WVCXV1vYjHKUCGmDtifnD+yq6cPj3IHLhI119ftO7ubNa2JNQN0
	 PaSKgAiy0r42WjNX8QXcjPDA=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14BFA40E0177;
	Mon, 22 Jan 2024 13:20:58 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:20:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pranav Athreya <pranavsubbu@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pranav Athreya <pranavsubbugmail.com@pop-os.smtp.subspace.kernel.org>
Subject: Re: [PATCH] x86/alternatives: Fix switch block in apply_reloc()
Message-ID: <20240122132057.GAZa5ruRCBJzuuVKC9@fat_crate.local>
References: <Za5qb8livKA4XTeG@pop-os>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Za5qb8livKA4XTeG@pop-os>

On Mon, Jan 22, 2024 at 06:45:27PM +0530, Pranav Athreya wrote:
> -	case 1: apply_reloc_n(8, ptr, diff); break;
> -	case 2: apply_reloc_n(16, ptr, diff); break;
> -	case 4: apply_reloc_n(32, ptr, diff); break;
> -	default: BUG();

It is more compact and faster readable this way. Do not always take what
checkpatch tells you to the letter.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

