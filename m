Return-Path: <linux-kernel+bounces-129377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3C8969B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14541C24853
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219626EB6E;
	Wed,  3 Apr 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DutANyus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcKXuE5i"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C46E2BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134704; cv=none; b=TxAXypwtW8WKteDd6ATaROysSXGouuXGcEOVlv7svEJ3gyvkUH8SMc0Yk53Ihk0yIzXvGCYuIDBr157/4chi47YTaXoSLcZ9LEfZxnTG0aAwzIatEiOTEuyll6nYxJ1jOz6QUT7h65/t1l8xICbgijLns8gSemj2+FOFZDH+7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134704; c=relaxed/simple;
	bh=WfmsbRUW97Ckf20AJKx4XzGD3PzrHVAJfU97EobaptE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=E3BH3F6rM33pFnv/YGYXxA3V906Kwn/UCfW4ozIOg/SEDXvrUG9xBT3KmWINdKrxkmfsHBSK7RdRlzo4jwCoMA6Uao9ibD9mdGwIMkRxMjKF9d2VE/LLt3wdPaaDThdKPpbt3fyp+4Y0E2y4jgrIh5uanzAbu+KEQr+xym9ZJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DutANyus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcKXuE5i; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E1B3113800FB;
	Wed,  3 Apr 2024 04:58:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712134701;
	 x=1712221101; bh=gGCGGpz42+ijw45uO6Rv6ds+pPypoT31rsDVQN08Em4=; b=
	DutANyushqcHwQUgotcWxzGKLfWFFGo5DWC+nZ77BzdwhfT4HhHblcn2J0WIQEQK
	1Dy/DsmI0PtrqSNFPeER6e+6F3B9H9y+7YeAG2YkfTXvtCXu8hEb21yn1esUnqP/
	tK0Payp8fVvcKg8SGERZFzCc6oEFW1WntCvWCfPziRzvv6JT31Yum25X7dFx7xL2
	Ot+0wk92/mLDAJS1zO9c8O3s5wmHKmKW8oCUiPMkZ49jKTSAponTBepkB8NJwQsv
	mhlj5GTk2x+lxifpG8fIbUqrWZVGq6W/2NdBDSkunHm8SnnTlKKRs57mp3pL9GgZ
	3jJQ77xhrM+Y/lsXSUH3Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712134701; x=
	1712221101; bh=gGCGGpz42+ijw45uO6Rv6ds+pPypoT31rsDVQN08Em4=; b=Z
	cKXuE5ipL1LluEOml4Q5akRLLRewHdL4lBEFc5NMHwPO2M9/FMaS4jPxtZTsOZKj
	wRHuRxUJ2vp/THeVGif1g59uvmk9TbwXGc+zJz6vahWKnUN9iDtvNF+K1RAIF2hC
	sUSEvHcp+KsYIQvkmVDD16rlx/Ecrd+bPrys+OWLylKCubk+sNaIkH3Xh4ZHFzZz
	m/XpJ56+J1lhFjeOR5MVFbay6SofM46IOAfpdgZaoPaKrofEdScmdlq1o7MBgaAn
	sXm9YJYs/h1kF2v8d0A8NexqYCxjYpTLI8MBwEP9u4r9sbbde+ktEoYttwmiIj8K
	fDOd2WJs909lH7vQ4HAww==
X-ME-Sender: <xms:LRoNZiqY05bYhd8b1Hb6lgSdQGdvYja6H8eqe_0ho81r0yfyktNi0Q>
    <xme:LRoNZgqie001yYOAqfJdyqHGlyw9MDIXBbBvnWXNwZFtQQcz7OQVIDeBFYR-22o19
    U5i3ghGBijxJgAGTYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LRoNZnNS0RXo3S9dkNE7Zp6tAMsAEL9uW9Kf-Y9sIRs9DfdU8VbRSg>
    <xmx:LRoNZh7ZGlt1VkMCbWb8NMVSF8Zs4l4hx9i69iUQaULunRlpd6Bwzw>
    <xmx:LRoNZh4qa1GnYEu-6X6BxUiHErNDeZyQnbDC8MgUnx8mRECEnLTLBg>
    <xmx:LRoNZhh_BkvHkRh7qhli_hitKG3bzEbNIP3Xyj9tc_aYVOF8m7l4Pg>
    <xmx:LRoNZru9leC9EZ5eTDFCmoOJ8V28YYI69EB5__NJ8b2_nFqAgeCaFuSY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 58C76B6008D; Wed,  3 Apr 2024 04:58:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bdcabb75-f9a5-4905-90b4-2c9c2cf0588a@app.fastmail.com>
In-Reply-To: <66a1d5f1-d9b2-402c-826d-955370288037@csgroup.eu>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-19-arnd@kernel.org>
 <66a1d5f1-d9b2-402c-826d-955370288037@csgroup.eu>
Date: Wed, 03 Apr 2024 10:58:00 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Palmer Dabbelt" <palmer@rivosinc.com>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Noah Goldstein" <goldstein.w.n@gmail.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>
Subject: Re: [PATCH 18/34] lib: checksum: hide unused expected_csum_ipv6_magic[]
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024, at 10:41, Christophe Leroy wrote:
> Le 03/04/2024 =C3=A0 10:06, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> When CONFIG_NET is disabled, an extra warning shows up for this
>> unused variable:
>>=20
>> lib/checksum_kunit.c:218:18: error: 'expected_csum_ipv6_magic' define=
d but not used [-Werror=3Dunused-const-variable=3D]
>>=20
>> Hide it under the same #ifdef as the reference to it.
>>=20
>> Fixes: f24a70106dc1 ("lib: checksum: Fix build with CONFIG_NET=3Dn")
>
> I think that commit introduced unjustified #ifdef in a C file.

> Refer=20
> https://docs.kernel.org/process/coding-style.html#conditional-compilat=
ion
>
> The fix should be:
>
> +	if (!IS_ENABLED(CONFIG_NET))
> +		return;
> +
>   	for (int i =3D 0; i < NUM_IPv6_TESTS; i++) {
>   		saddr =3D (const struct in6_addr *)(random_buf + i);
>   		daddr =3D (const struct in6_addr *)(random_buf + i +
> @@ -618,7 +620,6 @@ static void test_csum_ipv6_magic(struct kunit *tes=
t)
>   		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
>   			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
>   	}
> -#endif /* !CONFIG_NET */

Yes, I usually prefer that approach, and I think I tried it first
but ran into compile-time problems because csum_ipv6_magic()
is declared conditionally. Let me try again, maybe I misremember
what I did or I can remove some more #ifdef checks for this.

       Arnd

