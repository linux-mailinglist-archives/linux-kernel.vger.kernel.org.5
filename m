Return-Path: <linux-kernel+bounces-142244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F88A2972
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B6BB22040
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5902C6B3;
	Fri, 12 Apr 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gAimeoj9"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185F1B5A0;
	Fri, 12 Apr 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911094; cv=none; b=ogdLDPM2/gPhzOO1rVxRg/VEtMq0DQAGlB0/lVcSuMHEH5lLN5mLTKDOybHKJKw5+oU8RpvUOd5BW0+5AZr44dsmgJLCncROLTqohkq/Dhe9t/UWpmQuNzL14q9Jnqewot5wiWo2iWr2s6mCBEkKOef2ko1FfNrMiZ3aHvix0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911094; c=relaxed/simple;
	bh=KgVYfdLUzep0SkrpXvuq683Itn9YhVNpEO1dPfvTN+4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NPc9J81UQpg3w/0q+vwzZEAxdBpEQ5AdF30NiVKByXpDyRM143MZtUeLmMZ/SX3bXifS+Hdu4LpdWaR7WLuJx9sd7eU0Sr36TrpOSlXvK6INn3q3JA2n3EyuUQfsfQRcfQB1l3jlBPuaGApJahnH1YBCGNGxLqDGgVVVLfu1Z0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gAimeoj9; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712911082; bh=gE4UiwTwaZDj/y1D5EUtDgaY6Zh1vXQNUMpz2cuxwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gAimeoj9xNuspZwpchRMK2dt8vExrlS/TlTFXycoarwZLr+EuNePo142jy1qb9aNG
	 WhikFRSQRlYmLumVV4nLuVXuS7wk1ZoZQbezch1xwpz4u4ihQ9iRREmnf9iJ4HBd4D
	 vDf9PXBIIvHXThnibifwFmDHYWAfADtGhjVU8qI4=
Received: from Yangyus-MBP-2.lan ([219.141.235.82])
	by newxmesmtplogicsvrszb16-0.qq.com (NewEsmtp) with SMTP
	id EC914EF9; Fri, 12 Apr 2024 15:59:09 +0800
X-QQ-mid: xmsmtpt1712908749tdf3a543a
Message-ID: <tencent_C7B10C572AA62E84ABF1818F52904DFBCA05@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSkUDCWdovIJbdRXTBoHzZJsvwt/KXGLaYIhohNB5cj0rYEUis96
	 B4MM6TnQVwXI2teG/zqPf7QLeagvsUXP6EbnNy9qolyR9ELDaoSLqfDbvFRFcbJlB/iD5rMJ9VQL
	 BYIm9j6ZMzkEMYi2rBL+HNQTe14yvQDPCMP+M5dAmsER4GAnvbKQ6UbMmFn4GsCxq5tNswy0MQq3
	 Fg4+5yXSzL8spvZrhJ5Qp8uaUZ75dAZQbcoZUS14AeaGVZr3NhdV84/4kmLApm812Uot2P7Bn+62
	 ej9Efp6uCT6MYtcSmL0EFrypwsGhfdOWWRsajYsFm0PeuS4essy+9qmWx9daFEf+L65E+AeazfPb
	 fzWBwwfGwwBG0wi1f4/CsZycnu5pkpfOyQkhY+kcmRZfbu1Gkhl+FF7UcINAkL5YT/OJWNRtbloZ
	 ZHimNhLvPfkV4KcUoUdFOcsgIKH3QFrknB8eVQVzVni+fp/dt6m1A5s0CXmRH/u21PqGMpDD1v4t
	 Bb0nfLd2E4t/83uYzpsIPlC5ImX3Fa8l2d7vRlUY2R4+3qr7LHm2gmJ2SEC1HziZg3riTNqSxfWo
	 eCgpOk2Q+qdsnsqY+no26TbRo7wOtbXEJk+PCX/2/8k3q1QHM7MsCCteJ46cziMtCBqdXdSYOxo5
	 XWgAJdVR3VV+Uwrs9u8HZ3XfdATJM0Ra9Nm367Ufj9SndZt7QXpWNJIPgAhhM5ekM1/xbETn6VRA
	 xc06JjhXx65doC6pPQS2ZmLLC+K5FEjCzWVB+lNvToaB+Dk6ziIhMJ4QUCfsh3/JUhViB8+BxD+4
	 uuWNq+DTTx+/6D3rYvBavNdmvllhqNu5xx+TXgkFgwXwthGhGqCyI5yq37uuwnDJmcDV/EoZmKRq
	 mohN2+X8WTJWyG2yKqRito/2dPLFs5u7tr7pU14ee1Fa5+aK57UpPSZJ/etfgJfTUWHAfx4OMSHs
	 In2CnKWj+2S1VqQr9x7SM3++aLdp4ILAwjcw6ERWctsWMLIEImFt3I/hiHOB/G1yhgM2sj4VLkLS
	 PEMj6SRBBmnAu7lPOw
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yangyu Chen <cyy@cyyself.name>
To: ebiggers@kernel.org
Cc: andy.chiu@sifive.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	christoph.muellner@vrull.eu,
	heiko@sntech.de,
	hongrong.hsu@sifive.com,
	jerry.shih@sifive.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	phoebe.chen@sifive.com
Subject: Re: [PATCH v3 05/10] crypto: riscv - add vector crypto accelerated ChaCha20
Date: Fri, 12 Apr 2024 15:59:08 +0800
X-OQ-MSGID: <20240412075908.68485-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240122002024.27477-6-ebiggers@kernel.org>
References: <20240122002024.27477-6-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024/1/22 08:19, Eric Biggers wrote:> From: Jerry Shih <jerry.shih@sifive.com>
> 
> Add an implementation of ChaCha20 using the Zvkb extension.  The
> assembly code is derived from OpenSSL code (openssl/openssl#21923) that
> was dual-licensed so that it could be reused in the kernel.
> Nevertheless, the assembly has been significantly reworked for
> integration with the kernel, for example by using a regular .S file
> instead of the so-called perlasm, using the assembler instead of bare
> '.inst', and reducing code duplication.
> 
> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Hi, Jerry Shih and Eric Biggers,

Since this implementation is derived from OpenSSL, I have an issue on
OpenSSL about this chacha20 implementation using Zvkb [1] and see a fixes
PR by Jerry Shih [2].

I wonder will kernel need to port those fixes to handle the non-multiple
block length of the chacha20 cipher? If yes, we should port it immediately
to catch up with the v6.9 release if we can.

[1] https://github.com/openssl/openssl/issues/24070
[2] https://github.com/openssl/openssl/pull/24097

Thanks,
Yangyu Chen


