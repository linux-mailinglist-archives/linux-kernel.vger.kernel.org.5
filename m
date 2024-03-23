Return-Path: <linux-kernel+bounces-112294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD77887807
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510681F21CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BD210A24;
	Sat, 23 Mar 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L4VqmnLZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE9DDC5;
	Sat, 23 Mar 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190337; cv=none; b=N9/mcA30u+GTGya8aKhPSZTWNv1Ewen+djEDbT3fimw2x1Io1+J5Zqml+T8ivKXK7A3uA9/QKDpYl8CFYxyZXPjnBImtKDMX+rI1oJ/GgIGd3duZ9P5UreIqF6cVu4CtIwLE2pzFVkh8ZBoHfonmccvoNqtH6LEAeZhz/xMxAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190337; c=relaxed/simple;
	bh=418qgCaLlXO3MPU6Ka6LiclNSXYM4S3ZOWBDZXvKklI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYLqlSRUl5XkeCjOz8MZIhtcdPQshNyGsDNdZyK8AeL2UCPfGL53p323D1XgNcyTGE1hcKJ9Xlqs6GBVcbhhCVRGcD/mIaDcVzc+nPMJNUkwN3jJ55CSVCrmAGb/yAh1L1Qy7fcGfwyJu6K81dNmLVfnv9W2cBkW/zbpYone2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L4VqmnLZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7E99040E01A0;
	Sat, 23 Mar 2024 10:38:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fPnPB3Hhg2o7; Sat, 23 Mar 2024 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711190328; bh=4sdIsH0QNiHyOSUq6kRcc10Kjsh94zZ4I2nRDHEZGmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4VqmnLZZQqifJ3JvA4Su9QTQ77V+YKprG/yEukB4Xrd7hQWBbatbb+rwDYl8oZ/j
	 Q2xP2ugqGOjdmLlTwPmbUwDP7zF8ZHVWTW+bxbqwSydb/Ma3engeoIBNhbhmhnmVWk
	 CME+qb5JBIyPX1sUgNaKpZ9h0AxQTsSROOEJmoz0i3tIqhDkOLrmFDKB/cNPwhglZf
	 4OjxamkJEjCxy/5ZnAXUAwrcMj95ej7uwxQXxPmqi9ux0UHUEmbN8bcwIbDsrOqren
	 IpkheAdNIJGqdat5vMVazzS6GwdfCFgGONLMZx8Cw65m4n/UkaOz1Q7pAVZmfmMTui
	 uGvpXUx+No2PxkgCZeB7qS0ZtTdf+R5v8xckiW8CtV/TSe5Nim42PSrBTDoUIul32C
	 iEyVPKEo/WJj9epmMWtCqanvyXcJ4m+ME823hfoqf4OFON2Lay1ej7lD6ZWC+MZxfr
	 OIv6B3/+1oP+03zuSN5EInIX3Eu4BBFhysrzDHYkce1x1ljOwygWHBsmJpMAOC/dcC
	 oerTRO4C0r54XidaO6FiSe2rO7BBvDadjyfvWEmujdS+rMM4xTJZ6xexQjB94Y6i7n
	 As07goRTST1T3mqiWMLnFE4K/0Dpmid75kefFyU6AvG19UENOQ5BOZCBxI4H3uwCaa
	 Tz2wWWFR7JbRibHGltcNAxOY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C667140E0140;
	Sat, 23 Mar 2024 10:38:33 +0000 (UTC)
Date: Sat, 23 Mar 2024 11:38:27 +0100
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
Message-ID: <20240323103827.GAZf6xI94u8F9LGBIL@fat_crate.local>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
 <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
 <202403190955.25E5E03E6@keescook>
 <20240322194658.GCZf3gMphnWeR9upN6@fat_crate.local>
 <202403221622.6EA43547F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403221622.6EA43547F@keescook>

On Fri, Mar 22, 2024 at 04:40:11PM -0700, Kees Cook wrote:
> The earlier patch, commit aaa8736370db ("x86, relocs: Ignore relocations
> in .notes section"), landed via my tree. It was sent out on Feb 22nd
> (v1[1]) and got a suggestion from HPA and a Review from Juergen Gross.
> I sent v2 Feb 27th[2] and it sat ignored for two weeks.

s/ignored for two weeks/missed in the avalance of patches/

> Since it was a 10 year old kernel address exposure, I sent it to Linus
> on Mar 12th[3].

So is there some unwritten understanding somewhere which says that you
should take tip patches through your tree?

Maybe I've missed it.

If there isn't, should we agree on something?

Because there clearly is a need for clarification here...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

