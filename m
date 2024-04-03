Return-Path: <linux-kernel+bounces-129358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E841B8969A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C95DB2A849
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654F71737;
	Wed,  3 Apr 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y3TEof7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RN+/7xAa"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D266CDBD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133969; cv=none; b=lt84pdbZZXJNO67HZGDHFoL8bXJ39HJRk0iYdwAltetYd42Ok1RGNKFGF1muL46SPKpX7B1CAEgw1qDMPLQU5/A46B8JTa8EFOHYS6BFlZOw6UdYwx5GnMBAO88PCP68k0kTEF3tzfoHzx/EiNiDU7DHaFk+59pa1ARWlEK13bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133969; c=relaxed/simple;
	bh=+S2O1GFt8qjMUrM23cyYAgm/pmRLL3owMuc0LTyf644=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bixG3PX7cnEKsmSG2oC/pKa/nBjhlSXNTE6CCBRiXOnIzndNZls9vMG3Jkw/NMSo3hWeUfTfh3cYHqmOFxNH8QWpEVcZRRcpQGn8tZNFqdo5/zmdQyMU6at0/LyKGhwbQNsbIAZlUdzlKHP6ZVwcBxwFO062U5+p4n8zgdyF7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y3TEof7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RN+/7xAa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8465C13800C9;
	Wed,  3 Apr 2024 04:46:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 04:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712133963;
	 x=1712220363; bh=1RZn0oM8m1GPiYmL1YCObPZ+6sAGKW8OKj+b4oKvzPI=; b=
	Y3TEof7RVUdF+jqdcs+14jebAXyfqAfC4LJ/bLpL/ItC7h9c+O+rGV7fy0hKDLZz
	1wr3ucOJNDE7i0O9QSu+wj/pqrW2hvhUUURgki4vJIlsktFALiSq43oiDXKzs1H3
	Fpg92F1QI8xlrsIZi/IbviFig4Zk+CxLVn8zCQGsUpCYUcgdSshAX0DpXq2QwSo8
	aPWi1qDiJstbTU3Hm1bHH8iIxv4dgOASGO8JcidgfOOv4Efg3aSYHeOF8w2tTYhJ
	p+sqm0vC37EoT6ntcWA2ShnCYxn1+R67L34GQzXjajVXMOPQa1RTPYVpOw5Nv2R8
	E7tlWWMhlepyYZOHyIChoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712133963; x=
	1712220363; bh=1RZn0oM8m1GPiYmL1YCObPZ+6sAGKW8OKj+b4oKvzPI=; b=R
	N+/7xAaXMCa/EUYS5g/twnoo48wxABoaj3vDVbJRH+8/HFdihcSb6UofMNwegFfV
	yD41JjKPd11OVNMb+FwrShitYKMMXQmOiNmfpIHdPC42C8jOYlsfUmcc/nmISBA9
	vgxL83qcQwaW7EEAO4QtMTG8ByE1rLlpR9E2FmWx3jGQ3aW4ZJ6JAikJEAqSx0vi
	GxTbUYAG6aqDeLRkBDy2TDeoIyxCspp/bHQXM5l+H0lfDbRJaseQ4qQQRE8fvEXx
	+stxLQ6KmoNCdAC7YSrCBVq+ykVaa15NtKAXI5lOV+CwUc2GqZx9pUlE57uUc1CU
	162q+eOIoztml2J1JSAFg==
X-ME-Sender: <xms:ShcNZnAZyLm9XHd-kHPDBTAa05x8FVQjByZqNNVNsnv0CQvb_K8UuA>
    <xme:ShcNZtiQQ7wL9b2prKFgzwBthuVm9Z0lu8tf87mfOGWqOqmt5e7wp3Hvnn5TQmov3
    0phvys8atXgITbuoyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ShcNZikUZ6uVcU5hyjM93JxHlsFt20g5gL_9ZHffgFMKg34sDzaHFg>
    <xmx:ShcNZpzXr_8MtgDzJ1r_t7vFS-qxmxPrsCF4SScOqmhEKTZMcIFRUA>
    <xmx:ShcNZsS5qCHQPvBJlt6Xx18zYp0Csp-GcJELWR0AfKQbJdXVgf69KQ>
    <xmx:ShcNZsbMU6X-uK0waRSjIad6i9a1HHhRrhBWjD8sgzZF6jGNs6yIEg>
    <xmx:SxcNZorngdJunJJo9PgIKLOSr0B-OaaCHu3Kgx_JRta-azWTBkIBsb4h>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CB4B1B6008F; Wed,  3 Apr 2024 04:46:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com>
In-Reply-To: 
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
References: 
 <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
Date: Wed, 03 Apr 2024 10:45:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anton Protopopov" <aspsk@isovalent.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "David Ahern" <dsahern@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed: "struct
 bpf_fib_lookup size check"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024, at 10:10, Anton Protopopov wrote:
> On Wed, Apr 3, 2024 at 10:03=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>>
>> The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux ne=
xt
>> starting from next-20240328..next-20240402.
>>
>> arm:
>>   build:
>>     * gcc-8-footbridge_defconfig - Failed
>>     * gcc-13-footbridge_defconfig - Failed
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> In file included from include/linux/bitfield.h:10,
>>                  from arch/arm/include/asm/ptrace.h:13,
>>                  from arch/arm/include/asm/processor.h:14,
>>                  from include/linux/prefetch.h:15,
>>                  from arch/arm/include/asm/atomic.h:12,
>>                  from include/linux/atomic.h:7,
>>                  from net/core/filter.c:20:
>> include/linux/build_bug.h:78:41: error: static assertion failed:
>> "struct bpf_fib_lookup size check"
>>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, =
msg)
>>       |                                         ^~~~~~~~~~~~~~
>
> Thanks, I will take a look today

The problem is CONFIG_AEABI=3Dn, which changes the alignment
of sub-word struct members. I had assumed that AEABI is enabled
by default for everything already, but it looks like footbridge
and a couple of other defconfigs still have it turned off:

$ git grep -l  CONFIG_ARCH_MULTI_V7.is.not arch/arm/configs/* | xargs gi=
t grep -L AEABI
arch/arm/configs/assabet_defconfig
arch/arm/configs/collie_defconfig
arch/arm/configs/footbridge_defconfig
arch/arm/configs/h3600_defconfig
arch/arm/configs/jornada720_defconfig
arch/arm/configs/neponset_defconfig
arch/arm/configs/netwinder_defconfig
arch/arm/configs/rpc_defconfig
arch/arm/configs/spear3xx_defconfig
arch/arm/configs/spear6xx_defconfig
arch/arm/configs/spitz_defconfig

Russell still has machines with an OABI toolchain, but I'm not
aware of anyone else relying on it. It does cause other
problems as well, so I already turned it off a long time ago
for my randconfig testing.

We should probably make it the default for everything, except
whichever defconfig Russell uses:

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1159,7 +1159,7 @@ config ARM_PATCH_IDIV
 config AEABI
        bool "Use the ARM EABI to compile the kernel" if !CPU_V7 && \
                !CPU_V7M && !CPU_V6 && !CPU_V6K && !CC_IS_CLANG && !COMP=
ILE_TEST
-       default CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K || CC_IS_CLANG ||=
 COMPILE_TEST
+       default y
        help
          This option allows for the kernel to be compiled using the lat=
est
          ARM ABI (aka EABI).  This is only useful if you are using a us=
er

Or we could go one step further and make it 'depends on
EXPERT', short of removing it entirely.

     Arnd

