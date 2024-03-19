Return-Path: <linux-kernel+bounces-107212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577F987F94E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8938D1C21AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77653E05;
	Tue, 19 Mar 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WBIvI8xE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A81D540;
	Tue, 19 Mar 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836230; cv=none; b=nUlLMa/0Ra9zHLPwMrq+JmzQOB14qJdMQHqOafthO462BWVFTKYKE0xX/Ff4Dx7eDNDVHPRzHhOuowDYN7cZQRgXSrpyCDwRVtDqFn7skHHgryCnVssZGiOljwSX4SI8hThMa1upB/MNyCUhwPNDRnz219ixGcCz0h5E9YB6xGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836230; c=relaxed/simple;
	bh=JX3TriMRwDRg/XX7TCeoNIZ9bpm+iVQCqeDjayF+/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msyYHuZ9nfCVWQDUWo6QZu3qD/kEQeF42CdsHXhustRuI2GjOAVdvrPtiRuWQFv3gXW5Fx6RgJa3NJSHvyrCQV39y8pjelMabl8TqKJEkh7ePkKgxpZpbaO9+I3YP7h75lvYzgvUlqsy3ULmjipLVNZfOiY4I0I1zCQ8B0250nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WBIvI8xE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6227740E0140;
	Tue, 19 Mar 2024 08:17:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y4YoWliEx1cB; Tue, 19 Mar 2024 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710836220; bh=TlIidKXcofu8c4qhUsOCY438rBz+o9WrRYuZUIXu0+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBIvI8xE9xXpGjNkgg3pL631YJcDaHfif+Ior2ssGtclusabrdKjm1+E9mxujNlyR
	 L86PYRwCsETYPQ3ZAgYWOAo/KdXlHbltax60TVCMeMeDPb+t9R4iZFGAzIf+hnt+KC
	 Lvy11KY2B9lLo9z0urPMXOM2l6+kMwGgH9bYVItXLiTuw3p8fYUDKXboju+Gn46wpI
	 iHF1O3bQLjcFwzouWBNBAW10hxoLRH5Ol7o8FQplGx+G/JWpGy9ReBj1Sjj5o7SwRR
	 CBx4/luprWk6o265foQa4D6RyMPUIiS/ztadCZlEVLAfFOfjZauyBHVXe4kRPAw5SR
	 JOk9/H2yCYM8IQwvbnsiWJkRXjLQ78XTqLSy4+7nDsdbEexGMXlFcDpqM5RE7IK1QD
	 4GeNc2mUTFOPh0TkAgQmmdxalCcF1aKAN5ZOAfdn4XuFKt81vUi7rFHlrCvJvg6/LX
	 6qGSPeKkoFa2muEL0PE0d6xGvjrknvG04v4XJedkuOgblhChTz7r9JULtlw4LWi45O
	 fn0zFQUMOJTuhtsDscqx+iERrlif9Wubq3ML7OZpZu1hH9eubiwLsckfOdnteg0d45
	 CLUzhRlDo/9x4bxs7GZg1tdkOy6mCXzy8c5KCW8Yqo+1h/hhDSnLVJWfOQYteylhXg
	 CyDGdzngsLcXUn+qoLSk/Mr8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 755FC40E016B;
	Tue, 19 Mar 2024 08:16:46 +0000 (UTC)
Date: Tue, 19 Mar 2024 09:16:40 +0100
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
Message-ID: <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403181644.690285D3@keescook>

On Mon, Mar 18, 2024 at 04:45:45PM -0700, Kees Cook wrote:
> The commit it refs to landed via -hardening,

Yap, saw that. It should've gone through tip too as it is clearly a tip
tree patch.

> responsibility of landing this fix too. But it's fine to go via -tip
> if you prefer?

Yes, please. Just send a Reviewed-by and it'll get picked up.

Btw, while looking at that second patch, why does it have *three* Fixes:
tags? I think it wants to fix only your

aaa8736370db ("x86, relocs: Ignore relocations in .notes section")

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

