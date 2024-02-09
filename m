Return-Path: <linux-kernel+bounces-59920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0B84FD55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F86286BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF018613E;
	Fri,  9 Feb 2024 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O8MzgYqL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D1364DA;
	Fri,  9 Feb 2024 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509376; cv=none; b=MSnFBLIgWoko0bwZiauC76/pBSW/be1jn1oqxBETzURXzHWI9kvQeY4iS5TENmqIab+tMpzGBJWd29Tw2fe5iF+n2Q2Hwn6Qj4dZYGqXyNFV4TPHeDZcRACvzEWEAaB1GbwGmU1Zt/mo+OEUO9AXCGBcg6dbb2vCEQRv2ECxIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509376; c=relaxed/simple;
	bh=avRF5KuBWc3ma8rB/3veb7AOZ1g3jgcb+O6RW9gVQRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNLsWhypOBdgHCiuR1qgU4OKxcW3UmXoOsOi+ZDSG2tZ+vw7D3gvgtmFtaBgF6Rf3wDFlSNbeJkelqH+8d9KVZ0E1O3V7Y7TKBxOBMK8cC0UhhSptrJpL4i17yFd4vqfuYtFsVVbB0hsu7lw0rHouP7eqRHAtEsHkBQDGAouUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O8MzgYqL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0242A40E01A9;
	Fri,  9 Feb 2024 20:09:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lwmklwoJTMGe; Fri,  9 Feb 2024 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707509369; bh=wVv1Ryzvn+UsKu2wdcKEViTQeQ4mNlo6bgwO9G+cMD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8MzgYqLLK+u+My7C/3fSo2r2Xd86Q/yrubXDhvZO8u1b/iUBew83qfndl4VJH2Dq
	 nd0Gz472VVWfzX8T3+zvG97PeS5dIm7rkg/gpKqw8/f/VQVyMkNAgOwtWoP2wFv1/L
	 3oklS0/SuyXfht6YoZMEhJRC9hkGHGw91kzPi3FCqfalaj2PMK6Vg5wjVdfofaldCm
	 u0jfHVfeAU1FGDYz98zAlSiNAZqfYn1TwfLMwFL3esfKQqD8phwxItxzsT2ZacvJ4e
	 TdaP6oYjdNj/ikWJ74l0NS31d1Dk3yVVdtMFYRFWr8jQU2inan37Yh3cKrr+i3huJD
	 zyIxO85QgOj8M5/FqP58qaJKKR0nnBIlYRv2RSszuTpghyfHA5Azfq99WlObBLZ8e4
	 WE/xHubqaACHlZpxh3BVxv4Vg/vatHbOswu1jXzUyfGHYHWhma+ixdkfhcjUIqLEc/
	 5fuTvNRIM2n7BcfbWs6/+30xz/pP/tHJ+ugTK2qbE5P3FCPPY43IrJ8cPQL7nbUrQF
	 ZtKGwHeUl+SfTysM/g0FB+1ELbwzFnNiApS1dz7dzAsz2LIElaC6y2qt2XT+ZUMX8J
	 Qbg3Ne/w5kq3W5Qn70i2MmT3ozI3UI0lr2IJrb21qmoniTCPfsog0/R8Jo4W+yaKIO
	 ChjyjjjSJMqoMR6eX69RgKp4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC6CE40E0192;
	Fri,  9 Feb 2024 20:09:21 +0000 (UTC)
Date: Fri, 9 Feb 2024 21:09:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>

On Fri, Feb 09, 2024 at 02:02:49PM -0600, Naik, Avadhut wrote:
> Is it safe to assume that users will always want to increase the size
> of the pool and not decrease it?

Why don't you make the gen pool size a function of the number of CPUs on
the system and have it all work automagically?

Burdening the user with yet another cmdline switch is a bad idea. We
have way too many as it is.

This stuff should work out-of-the-box, without user intervention if
possible. And it is possible in this case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

