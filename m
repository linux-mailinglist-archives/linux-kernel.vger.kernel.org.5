Return-Path: <linux-kernel+bounces-140333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B058A12E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BBC1F22C85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB73148855;
	Thu, 11 Apr 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k16UMDS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPqmVCml"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D81482E9;
	Thu, 11 Apr 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834840; cv=none; b=jHevurR1JQ2mw1KThSHYCpr5X2ESGhr9NNyjWHwx0tM3QqWFtfMB8qkBePAKalZL/PJrcvxmtcHH3qIQ0whS1hUPzDmMbmZAcCpVvkxllWbwDkshrera3covDX1TB4LQmgM+qcQ5DaqzCHY7nHBXU+03noKvADciZLUKP9TOkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834840; c=relaxed/simple;
	bh=yvmhDCALkIthMGM5UYLP3R3ULZ4LHD9/7osM8YAdgLA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YeVfLTE1uSx6aR9XWKLy+aRFoJzpWMjbYfaXiCTVaAUScah3EXuQH2NahCc7+fAueZNFHrJCeNdrTfPZvf1MUMOYH7Yy/gNMju7/sbltH3ArdagZoFBetZWJoB2fYv+MPhNZVrfVNfxp5pbGkxofSLF9GD/OKv/j+OEEguCK1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k16UMDS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPqmVCml; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id ADBF71C00137;
	Thu, 11 Apr 2024 07:27:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 07:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712834834;
	 x=1712921234; bh=HHmF8u/Kgp0w2MiOBXchBKlXBDAOLG0zhFsdn3Q3LKU=; b=
	k16UMDS3YHupSnmwEP0/HA0z1W0kHE8mUnFxzHkqIsGKnqejihmaLKS+ydgZZHPZ
	4k/nfA6B8mGj6p0fe3q7vkhgn+Ft5kLluwBHTZbpzdSU+wi9oe2OfZfgF6nR1Q9w
	NUjaGTPYqJkI69McIYxvmOwMD2F0ZLmG8S/FwlNusmpA66o0fKNa0t574OQ+BNdb
	lmL7X2Qxx84toenW4EYPEQ7Gx6MHJfJBf/CxcVIavumaMnmIXMmgymZPtk2Q0p41
	DjITQCF+YdPpOoU9hHdWEilPrOwsBPfcblfDrRfoEKMVdmIuxootB8arnUUdGlKo
	AiSoKEveNjbKxJ04sRyWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712834834; x=
	1712921234; bh=HHmF8u/Kgp0w2MiOBXchBKlXBDAOLG0zhFsdn3Q3LKU=; b=N
	PqmVCmlO8qu+ao6PmlZfi7Y24d44/jfZRx5qxQcAoXLlkiCUOasykG+E2JdPz3AZ
	nl5qHdIkvbM8XMASmY5PwAcjKoWD574XPtl7j2flIWHqTMOucjHbASYq9+JaNTXT
	V1t29oYeUFnYMkhjJPZoysmKH4tIkX24d/ciI2xBu6dUAfycWkl2gQD5vhP9jJzH
	BjZQtLLGTw6xJTY+IdtxafZ396fVFhLcz/cb2KCCGploBDTbAXH5WNtk/GXoGgTf
	UgfpTOJkURzvrYBdRLlN4pEl059sxLKC0h1YBsNYbYc5cic0wIeAfGw4rxjyST3t
	HQ1WLOIhvcuLROPRf/xhA==
X-ME-Sender: <xms:EckXZp_JMGVr04CcPO7Zi8vlSysZ4dGB6jHuu9Jmk78K0zYGeoRx-Q>
    <xme:EckXZtvOdPNfmi5oNB1_mZPSAusDzHoHjx5Qvf_oivfbtPfPFNBGAx-qxjaH_0SAX
    iLemeul88EkI1JrL38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EckXZnAt2S3P-B4UONMSL2sxDqEy28T02-OW3kU-0CtPKbnzG3Xzww>
    <xmx:EckXZtdkbuyl5tUZneukUa8ax4-H1O5f2yb3bjfdoHgsoQ2ofnTbqA>
    <xmx:EckXZuPdEX4JvNTAFe0W1u82Yp87aPaFB5jg8pNCdf7OKL_4LSvvsg>
    <xmx:EckXZvkHIKP5vqZVZF1sC-kRvHGTGAIQa3365tAcLRW-xAhSp0JmQw>
    <xmx:EskXZj-lCmKV2uVI2uldem5i9qYjtVjQscgpTn-bkl5DAOWQsRzSqHyn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 05606B60092; Thu, 11 Apr 2024 07:27:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd6653b2-3a88-4b95-af13-c6fda5b27b39@app.fastmail.com>
In-Reply-To: <4d429a10-eb45-4262-8e74-69af810ef1ac@intel.com>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
 <a434248a-1e9f-4f4f-8f90-d36d8e979f53@csgroup.eu>
 <ff9d7032-a3b6-4ecd-ac26-d7d4a06a5c7f@csgroup.eu>
 <4d429a10-eb45-4262-8e74-69af810ef1ac@intel.com>
Date: Thu, 11 Apr 2024 13:26:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Adrian Hunter" <adrian.hunter@intel.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "John Stultz" <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Borislav Petkov" <bp@alien8.de>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, at 11:27, Adrian Hunter wrote:
> On 11/04/24 11:22, Christophe Leroy wrote:
>> Le 11/04/2024 =C3=A0 10:12, Christophe Leroy a =C3=A9crit=C2=A0:
>>>
>>> Looking at the report, I think the correct fix should be to use=20
>>> BUILD_BUG() instead of BUG()
>>=20
>> I confirm the error goes away with the following change to next-20240=
411=20
>> on powerpc tinyconfig with gcc 13.2
>>=20
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 4e18db1819f8..3d5ac0cdd721 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -282,7 +282,7 @@ static inline void timekeeping_check_update(struc=
t=20
>> timekeeper *tk, u64 offset)
>>   }
>>   static inline u64 timekeeping_debug_get_ns(const struct tk_read_bas=
e *tkr)
>>   {
>> -	BUG();
>> +	BUILD_BUG();
>>   }
>>   #endif
>>=20
>
> That is fragile because it depends on defined(__OPTIMIZE__),
> so it should still be:

If there is a function that is defined but that must never be
called, I think we are doing something wrong. Before
e8e9d21a5df6 ("timekeeping: Refactor timekeeping helpers"),
the #ifdef made some sense, but now the #else is not really
that useful.

Ideally we would make timekeeping_debug_get_delta() and
timekeeping_check_update() just return in case of
!IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING), but unfortunately
the code uses some struct members that are undefined then.

The patch below moves the #ifdef check into these functions,
which is not great, but it avoids defining useless
functions. Maybe there is a better way here. How about
just removing the BUG()?

     Arnd

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e18db1819f8..16c6dba64dd6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -195,12 +195,11 @@ static inline u64 tk_clock_read(const struct tk_re=
ad_base *tkr)
        return clock->read(clock);
 }
=20
-#ifdef CONFIG_DEBUG_TIMEKEEPING
 #define WARNING_FREQ (HZ*300) /* 5 minute rate-limiting */
=20
 static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
-
+#ifdef CONFIG_DEBUG_TIMEKEEPING
        u64 max_cycles =3D tk->tkr_mono.clock->max_cycles;
        const char *name =3D tk->tkr_mono.clock->name;
=20
@@ -235,12 +234,19 @@ static void timekeeping_check_update(struct timeke=
eper *tk, u64 offset)
                }
                tk->overflow_seen =3D 0;
        }
+#endif
 }
=20
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *t=
kr, u64 cycles);
=20
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *t=
kr)
+static u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
+{
+       return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
+}
+
+static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
+#ifdef CONFIG_DEBUG_TIMEKEEPING
        struct timekeeper *tk =3D &tk_core.timekeeper;
        u64 now, last, mask, max, delta;
        unsigned int seq;
@@ -275,16 +281,10 @@ static inline u64 timekeeping_debug_get_ns(const s=
truct tk_read_base *tkr)
=20
        /* timekeeping_cycles_to_ns() handles both under and overflow */
        return timekeeping_cycles_to_ns(tkr, now);
-}
 #else
-static inline void timekeeping_check_update(struct timekeeper *tk, u64 =
offset)
-{
-}
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *t=
kr)
-{
-       BUG();
-}
+       return __timekeeping_get_ns(tkr);
 #endif
+}
=20
 /**
  * tk_setup_internals - Set up internals to use clocksource clock.
@@ -390,19 +390,6 @@ static inline u64 timekeeping_cycles_to_ns(const st=
ruct tk_read_base *tkr, u64 c
        return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
=20
-static __always_inline u64 __timekeeping_get_ns(const struct tk_read_ba=
se *tkr)
-{
-       return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
-}
-
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-{
-       if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-               return timekeeping_debug_get_ns(tkr);
-
-       return __timekeeping_get_ns(tkr);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic time=
keeper.
  * @tkr: Timekeeping readout base from which we take the update

