Return-Path: <linux-kernel+bounces-140041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6C8A0AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B97BB28E89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C913E8B2;
	Thu, 11 Apr 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d9+E4i57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbS33kss"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260E13E881;
	Thu, 11 Apr 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822189; cv=none; b=sMVn9MWKatbPM2d/1x5eQNu+ZIchiRaoczdzuoh+poIQnQIkrQ0aRNBr2tr62VG2Bh1AC7G5Lb1DgFZ9aQTeeX/UCNHFhr8ySgwWiM/JHlUSJj0fW+C3RBNEd5AOX8RradjRSKy9lg3btPod10gRYz9iT3LtP31KZqyiq/hA2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822189; c=relaxed/simple;
	bh=RJQKtEmJwVcsNtllrkaL2lkTy2Wshos7JfIJYQgewtw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gefOTfuCmARnltnRKFPJkvMHtHlcGDR/UOtNAoI/FrISY55CYHagpGDYb+L50Db0M2VcO28pefNW5DrkPbPnmEyicF/ZOQLSZazacDOwWCg19j7gMpSpOdO4Uza3AByPdf37hWd6GOc55Zo4hgXoFLDvp2u0O0hfBHoPU4Cgec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d9+E4i57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbS33kss; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4D79918000CC;
	Thu, 11 Apr 2024 03:56:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712822183;
	 x=1712908583; bh=zk6i+umTyqQ2sjjzFSCP6SVPCsrRTnkpJSOyeCle8go=; b=
	d9+E4i572HTs+ZUDv+4wxY7sIYZ6JBTwR3qKkLVn6u5ttwY+zMBU3l5EXcPjDpdy
	LSOJlDSzNO3hCPkycdRjOp715zZ4FBV4IZLw+m1cuWtZnIvnyqVKw4QjfY6uEVeL
	n0y6R6arw1xtFT6xFHvcS8LgUasXiYk8Hupp+T8EyYWKTqV/P/mUwFR2dYQlZFJr
	Z6bzVsuSsrX/SXHQP9WakT8nylj5/sHhIUI7uy2DCVtY2v0nASjXc6QYxCidhNo1
	kP1gcBAubl+eofj0hlNrumb2acTk/NsLGZAT8zq9dEgzAbPyt+zwqhwnXXKl+4Wr
	ZV1dSpZ3I73v5ZkdpYYmzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712822183; x=
	1712908583; bh=zk6i+umTyqQ2sjjzFSCP6SVPCsrRTnkpJSOyeCle8go=; b=R
	bS33kss5H2v9tE8PU1SY4Yy0me3uG8ts3LzHQ9/H4Xr0GyFbTwq34kuCLGjk1Vsv
	3uPyV6yZZZRAZCMvXrzbptzhMhrGaOA/WENhAAvbDwbTpTh49JkZQwgepBcHke9M
	DMOQy2WcJNBiTfgMYhTULYlKeJ+TFnIUgd2zzUCztyJwGCJXocCLSBAsMbN6Rm+b
	dKZdvf/NuP2lR5X2bH77WbxsdfQPb7cH3EPoZbwRCWsu9Sxhy3RTd7zPNHSsn/Qp
	jSvdTROGk/wJ4ZATiAEKCmKjXyv+LRNPipcQzMDq1BervYo7aVv5EZ2SL3sWe3hR
	p58EWUyz+x7E/VNiv6kgw==
X-ME-Sender: <xms:p5cXZlqHPTrWQ9F5RSEBvr_pxKfT4pMGVayVQzma-3V7vC63Ygn8-w>
    <xme:p5cXZnqZuy4NeXltjrqtvPmT1dus_EmOaF3ZQNWhOteNddDYQ_M5pvCMlkZBLMbjB
    UcAjb7sm5lkRd3v1Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepleefgfeuveeigfduudeufeeuffekleelieejleekgfdugfeuleeltddu
    udeigedvnecuffhomhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:p5cXZiNNnLE0VGKhhD5dGgpfULvxYTwzIfmhcqE3YcJ5Q-8BHetmzw>
    <xmx:p5cXZg62Aci5JJzRPu5csSwJWXf9qgjoIcergon-dCqdTJLxJkm-DQ>
    <xmx:p5cXZk7cdueQUYtBCJrrjji2BCrrTPFxuf3aagBRA1p94nXjmtimkQ>
    <xmx:p5cXZoh9WJR8Q56_soQLHhByORD7iZg1vTmafJ-Cy2vJBPVSS0-uVw>
    <xmx:p5cXZgN_wP2Tw_gAhDM2NCEATsygK7YANquA2EoNI3wZW2fbkYHAXDrq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4DA51B60093; Thu, 11 Apr 2024 03:56:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cac3f357-0dc2-46ba-9ea0-7b1f4278e8ff@app.fastmail.com>
In-Reply-To: <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
Date: Thu, 11 Apr 2024 09:56:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "John Stultz" <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-s390@vger.kernel.org, "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 x86@kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
 "Randy Dunlap" <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Sven Schnelle" <svens@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, at 09:16, Adrian Hunter wrote:
> On 11/04/24 10:04, Arnd Bergmann wrote:
>> On Wed, Apr 10, 2024, at 17:32, Adrian Hunter wrote:
>>> BUG() does not return, and arch implementations of BUG() use unreach=
able()
>>> or other non-returning code. However with !CONFIG_BUG, the default
>>> implementation is often used instead, and that does not do that. x86=
 always
>>> uses its own implementation, but powerpc with !CONFIG_BUG gives a bu=
ild
>>> error:
>>>
>>>   kernel/time/timekeeping.c: In function =E2=80=98timekeeping_debug_=
get_ns=E2=80=99:
>>>   kernel/time/timekeeping.c:286:1: error: no return statement in fun=
ction
>>>   returning non-void [-Werror=3Dreturn-type]
>>>
>>> Add unreachable() to default !CONFIG_BUG BUG() implementation.
>>=20
>> I'm a bit worried about this patch, since we have had problems
>> with unreachable() inside of BUG() in the past, and as far as I
>> can remember, the current version was the only one that
>> actually did the right thing on all compilers.
>>=20
>> One problem with an unreachable() annotation here is that if
>> a compiler misanalyses the endless loop, it can decide to
>> throw out the entire code path leading up to it and just
>> run into undefined behavior instead of printing a BUG()
>> message.
>>=20
>> Do you know which compiler version show the warning above?
>
> Original report has a list
>

It looks like it's all versions of gcc, though no versions
of clang show the warnings. I did a few more tests and could
not find any differences on actual code generation, but
I'd still feel more comfortable changing the caller than
the BUG() macro. It's trivial to add a 'return 0' there.

Another interesting observation is that clang-11 and earlier
versions end up skipping the endless loop, both with and
without the __builtin_unreachable, see
https://godbolt.org/z/aqa9zqz8x

clang-12 and above do work like gcc, so I guess that is good.

     Arnd

