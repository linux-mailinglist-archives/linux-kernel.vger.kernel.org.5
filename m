Return-Path: <linux-kernel+bounces-39161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A828A83CBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E0429AF76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7513474C;
	Thu, 25 Jan 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M0s5GG82"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1751339B7;
	Thu, 25 Jan 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209118; cv=none; b=dCRREwfKzXXSBdZc/i+pcVH+qbKvKSob1krNpQ3EnsmfhwU+DlJXiHPo8LYIJLHl9ga2axo2aVVIWYdF1OTWWKPwoS9zCOlQpk9JS7heZZRwOfbVW8Rhnqh/8uqwm2T+uu9LHmvbRAVFYdXM0DjWnzjADy8qi3AFFy8arWCQtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209118; c=relaxed/simple;
	bh=EImR6eH2ja7Zr/g7LqjFSZRPMwchCKt+u7hbgiSybTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtmV2pDAFMAE7fZVmF69sNjK11ZJ2XGBU72q8+ZNEBkreIfsLJG29DAOAP+oz1AYUf99cFolGnUXxXe1nTCt3J1oaqQh9+V8lsgThlfczLeVk7Xj83DvygXvkHtB8FjMB0tPe5LQwnDPXPeW29nNw4sdrJc6TS35QCeYhfuPZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M0s5GG82; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BA2640E00C5;
	Thu, 25 Jan 2024 18:58:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xlGWIMdcDzcG; Thu, 25 Jan 2024 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706209111; bh=kNuXA3RXePTFCr5Ltq6ndzcIjKS21Y39k7fo+YpxiYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0s5GG82eNdtZFziw+sS0s/gKa1NbOTcirHKDbJ+4cl1lU/prG7sYEzX0xlohKgB2
	 ioq2MbxeaUuOS4Ncf1YMoBjFiesPhZvSaX8aFlOelhTAo39ciHYPEcD+Wxy/nbOVlt
	 HaYHEhwRE9NiBlS8pThDPRr/gPd6yubwnWPGiq7kQferxYc619m3jqo4NsvKeRnpV3
	 GsKUwJIGnDXS+9+ZK7oj2UcqO/ubvc4ompMJwILtbvxvgJ9h9ENZ63Kga0NHSeUckV
	 IKbpsGAaZqz7/AmldzUIN1rVeexh2gxOiTwHpIQ9tMcy9FGCasivjMe3ifeCxDqXMY
	 c6RdxFyO6MJotuCHD8aMgGtqMgt1vKyDBXUD+ShsaECR/kTyoQ5hf4iTAVJa5MT7zF
	 g7OTeOjvz9cqbzWUTpGYWp3HziUGHf6HsEBgHDfIj9WlKP6ee5EqU5dI+16s08gTfA
	 V36y9Lf0PoY0Zm1W3mR4xTp0rDMTU7s8c/QjE/DskB5SkYATo2VQcLye8oe/6mLcOv
	 C61FjgIowgPbKFJoWMRa6XdqUOppJjRZq5NvBI3p6AqK1+d1sSYQH7OWVFmGvg+PKy
	 ziYAQaNGEvr+9qfcXpLoCLIUTcfH3FMlnA95Mhorwu+8w92J2RNWdgQXatQY0Br4f/
	 /l8M/PyiGH8ihVj4mt4Q4QdM=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 659FC40E016C;
	Thu, 25 Jan 2024 18:58:22 +0000 (UTC)
Date: Thu, 25 Jan 2024 19:58:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	rostedt@goodmis.org, tony.luck@intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	avadnaik@amd.com
Subject: Re: [PATCH v2 0/2] Update mce_record tracepoint
Message-ID: <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125184857.851355-1-avadhut.naik@amd.com>

On Thu, Jan 25, 2024 at 12:48:55PM -0600, Avadhut Naik wrote:
> This patchset updates the mce_record tracepoint so that the recently added
> fields of struct mce are exported through it to userspace.
> 
> The first patch adds PPIN (Protected Processor Inventory Number) field to
> the tracepoint.
> 
> The second patch adds the microcode field (Microcode Revision) to the
> tracepoint.

This is a lot of static information to add to *every* MCE.

And where does it end? Stick full dmesg in the tracepoint too?

What is the real-life use case here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

