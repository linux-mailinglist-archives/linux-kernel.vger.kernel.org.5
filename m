Return-Path: <linux-kernel+bounces-83320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D254B86921E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830771F24BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F841448FE;
	Tue, 27 Feb 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iLSOAyvK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E01420D2;
	Tue, 27 Feb 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040705; cv=none; b=oF5Lfv6eJOgSnBE8EHzRGm+UI0WAw/YWdXvXxXRCKetajiiySq3UA+waSnN2gfRy9PBErnHW8nD3zpegrxuHO4XnDSVhA++I9ZYjvj6rZVlLEbnvcCnOF6TXss/6WP7tVhQkRT4R+1v8mPqxFIkbFH9mcwwTD0IBPObDHnLa4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040705; c=relaxed/simple;
	bh=Ki82SoGWmWX3Ugj8uBKuzuI2IE1hzceZHBRrq0QZbE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to98xe72+kuYcLgIGdh+s45m9Ts08Izihjh38wHB0miCCuoUZJ1T2NmBjOTzo144/Rh82+96EkUfTVj2qfRu7X+G2+WomTsAUpRxP8xvm12usCrEXhlw98zbHHQV8cZFp51gHK9mgWxRJNntRIvzQ4qcHRHpxdzcE7NlrItJ61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iLSOAyvK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709040703; x=1740576703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ki82SoGWmWX3Ugj8uBKuzuI2IE1hzceZHBRrq0QZbE4=;
  b=iLSOAyvKamz3G/D6WUlmaq1RobHx9/KxZ9NGnp0gN8/8mQB/VjdKzzTG
   wRes47z+RIfL93Buc+LhxZDqji7OKbzKqiownBYLF7JZcugMTNmt/frpv
   Zw3fZSdcQ3jWZgqR7RipIP221EXSl9wjScc4QRrjH1KTP9BmY93C9z55m
   hef0iP2RTdH6Hbu/yyleKHCzWhXQoQSGW/GkbF7r5NK/GsgaASxirUAOk
   LEIFHtbShKrVAZYaYEibq3gP6HQHLE95f8s6HtTTlM8TTMl2uDF0+AYJQ
   fMt66rFmMfMotAGlJZjpxcaXGh+I3LqzijWO5DMUL/GjTVcVdVKPMiGEC
   w==;
X-CSE-ConnectionGUID: yz8g29ITRhSf6O9VOhbtEQ==
X-CSE-MsgGUID: OaQoEJFJSXqnfheKzxcBOA==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="18458098"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 06:31:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:31:16 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 06:31:11 -0700
Date: Tue, 27 Feb 2024 13:30:28 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, <linux-riscv@lists.infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
	<rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<stable@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Ramon de C
 Valle <rcvalle@google.com>
Subject: Re: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
Message-ID: <20240227-nutrient-uncorrupt-202767671f78@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-perjury-preshow-fc2cf73d552e@spud>
 <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com>
 <20240227-uncertain-amaze-6197e627ad95@wendy>
 <CANiq72=geBobqM0Dc2yv=NjAc3MWXhOrDHfuJ84TgQ+XVxBo0w@mail.gmail.com>
 <20240227-unwind-canteen-3da9b07af10c@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5yJmoa5fGQ0bLaA"
Content-Disposition: inline
In-Reply-To: <20240227-unwind-canteen-3da9b07af10c@wendy>

--r5yJmoa5fGQ0bLaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:02:17PM +0000, Conor Dooley wrote:

> I'll give testing another try.

Yah, it is (as expected) broken on arm64 too:

 CFI failure at do_one_initcall+0xec/0x26c (target: __rust_minimal_init+0x0=
/0x64; expected type: 0x36b1c5a6)
 Internal error: Oops - CFI: 00000000f2008233 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc3-00002-g724a75ac9542 #10
 Hardware name: linux,dummy-virt (DT)
 pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : do_one_initcall+0xec/0x26c
 lr : do_initcall_level+0x8c/0xb0
 sp : ffff80008000bab0
 x29: ffff80008000bda0 x28: 0000000000000000 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
 x23: 0000000000000000 x22: 0000000000000000 x21: ffff18d941cb0000
 x20: ffffb8f6d6d9f000 x19: ffffb8f6d63e8b18 x18: 0000000000000002
 x17: 0000000036b1c5a6 x16: 00000000d65f03c0 x15: 0000000000000000
 x14: ffff18d9420280b1 x13: 0000000065dde380 x12: 0000000000000017
 x11: 0000000000000000 x10: 0000000000000000 x9 : d4db8c0058e7e300
 x8 : 0000000000000000 x7 : 0000000001f4c18b x6 : 0000000001f4c18b
 x5 : ffffb8f6d6d300a0 x4 : ffff80008000ba78 x3 : ffff18d942019860
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffb8f6d63e8b18
 Call trace:
  do_one_initcall+0xec/0x26c
  do_initcall_level+0x8c/0xb0
  do_initcalls+0x54/0x94
  do_basic_setup+0x68/0x78
  kernel_init_freeable+0x100/0x16c
  kernel_init+0x20/0x1a0
  ret_from_fork+0x10/0x20
 Code: 7298b4d1 72a6d631 6b11021f 54000040 (d4304660)=20
 ---[ end trace 0000000000000000 ]---
 note: swapper/0[1] exited with irqs disabled
 note: swapper/0[1] exited with preempt_count 1
 Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
 Kernel Offset: 0x38f655800000 from 0xffff800080000000
 PHYS_OFFSET: 0xffffe72700000000
 CPU features: 0x0,88000203,3c020000,0100421b
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x=
0000000b ]---

Cheers,
Conor.

--r5yJmoa5fGQ0bLaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3j9AAKCRB4tDGHoIJi
0u2PAQC5/4jfWMdylFg+y63pffgtxRDgGSmDgaHdyDygKV9j9QD+PNFWt0vl/a+D
X2nh2w6BJGQiRtf9I1HY/qbOMamdlQE=
=4HMF
-----END PGP SIGNATURE-----

--r5yJmoa5fGQ0bLaA--

