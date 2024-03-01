Return-Path: <linux-kernel+bounces-88187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181386DE51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BC52842AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C56A8A0;
	Fri,  1 Mar 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SRBqL6mX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB16A34D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285530; cv=none; b=q62OpprBCD7jHUw9JWu4cJKGKIveP4+rJSLYsvO6cuEio62BXBwjEty/AqVHu2JOPlIqzQ13oN1mSmJcWmxxcRVlvBSUMsFqAuDbGJZscs4GPlrxLVPbxJUVEWiBd7hPVMpRqLpyZPaw65Uv9x1EmhSzBMPfgk4VT4zrlQveWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285530; c=relaxed/simple;
	bh=DsLvThxyye5L9p+9g8PJUi8GdFQh8lzXSAENkivdX3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1gHzHKneqwGa4SPezCfISq2odRoyaiQ1KooZV5UePFAUmOl+WkBrwFLpRnWBpD7sOnlBnunfwg4sCd1dSxgyHDGZXVh8Ges7C0kSlkT02JngrSkrIkZys1Fs0buTNQM+L9cgnfob/kc0FNGpO7XE3/93vKbo3UABuwB+3klLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SRBqL6mX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709285528; x=1740821528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DsLvThxyye5L9p+9g8PJUi8GdFQh8lzXSAENkivdX3w=;
  b=SRBqL6mXw6yzI7irffYsJp5Px92I6VqC1HOzEJ1Aj1hirlFt81nDsLAf
   yKdg6YEeHaplwZgfl3wwVOFsNqUTVNB/RgTq8CFdl4EN6b9Yibo1A7Cfe
   rGqN/VkUISeyEk08Na2ZoVH/fheS0BlDhKLxTIHotcVCop076LcirtmiO
   tjV6H4YUo6U95phWtGHBwKeATbKNGLhxF5PyG0tLxIWK5uXRh5eZp/M2J
   /k2rD4VgGBiGF2h2gHpnlnFKOfyhPEnsgSdo9PuysLsw+qjB/6r/0HNRf
   H3li72JwtF/hCoQZvFz+vDYHMM3pqyntaoupg3FAmFL/fuo2nAaBlo7BP
   Q==;
X-CSE-ConnectionGUID: M/vfrS4FS22yqV9NCgJOCw==
X-CSE-MsgGUID: AaMFphW2QQqFpaO8uyVc3g==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="asc'?scan'208";a="18671665"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 02:32:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 02:31:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 02:31:47 -0700
Date: Fri, 1 Mar 2024 09:31:04 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, Yunhui Cui
	<cuiyunhui@bytedance.com>
Subject: Re: [PATCH v5 00/13] riscv: ASID-related and UP-related TLB flush
 enhancements
Message-ID: <20240301-dreadful-discourse-6f1bb453d9c6@wendy>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KuBrCPUMUGSkl7W1"
Content-Disposition: inline
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>

--KuBrCPUMUGSkl7W1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 03:21:41PM -0800, Samuel Holland wrote:
> Samuel Holland (13):
>   riscv: Flush the instruction cache during SMP bringup
>   riscv: Factor out page table TLB synchronization

=46rom here onwards, fails on 32-bit, bunch of
implicit-function-declaration stuff.

>   riscv: Use IPIs for remote cache/TLB flushes by default
>   riscv: mm: Broadcast kernel TLB flushes only when needed
>   riscv: Only send remote fences when some other CPU is online
>   riscv: mm: Combine the SMP and UP TLB flush code
>   riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
>   riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
>   riscv: mm: Introduce cntx2asid/cntx2version helper macros
>   riscv: mm: Use a fixed layout for the MM context ID
>   riscv: mm: Make asid_bits a local variable
>   riscv: mm: Preserve global TLB entries when switching contexts
>   riscv: mm: Always use an ASID to flush mm contexts

--KuBrCPUMUGSkl7W1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeGgWAAKCRB4tDGHoIJi
0j7VAQCqyB+uhdk++uoEdTRPw9kB9GZ2ogwRdC1lz8x5plLgMgD/Qgdj+Kj5he2G
JsKRaE3rZaO3XisZfINqKJi6qkDmZAc=
=5gaT
-----END PGP SIGNATURE-----

--KuBrCPUMUGSkl7W1--

