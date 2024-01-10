Return-Path: <linux-kernel+bounces-22873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F682A4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7731F23F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58C4F89C;
	Wed, 10 Jan 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fdwSgVp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkfiQ5ya"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494108F7A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 175775C0189;
	Wed, 10 Jan 2024 18:10:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 18:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704928246;
	 x=1705014646; bh=ovf0s2d6+GTqU+vkkvAyFRsImnKKPAFaGoU85FR8fi8=; b=
	fdwSgVp4gwu91ZW6ByyLl1x46s5XjdI3iKaSW0GV/QzSxPcUl5+L5OKkeS3Aa76Q
	9KfMDjgmkR4B0WMPVoBH2pxzFl71iEDf1m8023gyocGmVJbqRQIHQo03D/yUBASP
	0F9xcDUB51a6JF+jmFUq8SytEWGVOYSqzvwGHz1r2fuwuxg09mN4+I5pMoLNjZCi
	+CkS46rMLXpI6OLHZzyhV7b9irZn3XSPYurvl0FP8vcOm6NhxuG4rCVr2YM3rQNg
	a+kyT2baF2D1ko+rLRdLY9frOCAJBSCq65hjfss9/nEElzsrbAJBVRoLhRJ4a9Rg
	2x5V9KFYOdBfWB1+SwQplg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704928246; x=
	1705014646; bh=ovf0s2d6+GTqU+vkkvAyFRsImnKKPAFaGoU85FR8fi8=; b=G
	kfiQ5yaSr+yhKcRQ12oMInqvi1BOf1ff+n6/cmQ7V4FvEu9oXUkcxPiLwqfH92Dp
	0qt5Q+DTaBo/0czQ4tfhyC1XyUThqPvVy4j/IDUmT3tXBn6IZCSNIOrQu2573eyg
	zQ7NFJDveHgwHMGRzU+Fm2KFpKrIph3UKDBrObUNu6jRDhKqHlU/yt1gcziUDrFL
	SyyuVKl5Om5JP2I/47qDPYV2uW/uq0ijmg4kWhu6/b+XtVjZ34dKeDigOMuEhZ+l
	0ovlntqOtMvcqXWdRnZYDwxccTf3927ssBCJpdaLo5c+uprCgNzMGQkV38qBTJN1
	n/UtabHHHyfaBoEhwV4aA==
X-ME-Sender: <xms:9SOfZe1aIOJoNhOeEYJQiQZdyIw4t2SWCr9EghJOEXLP97XjZYORjg>
    <xme:9SOfZRHB6fltiHZRPL9Iah1l1BEbA_HTphGAjiyLLyfqtcl4HvU-Zf2mBDKBqSPxH
    aVrx5zoDEY0ZXUmP0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9SOfZW7SCB1GivoS2NSAAfXLYKV8_SPHgliyw5sXPYwlNodvJLwK0A>
    <xmx:9SOfZf3YG_Bk5-G0mxg_Uh1oa3c8e2SlAOy3NjmoE102Le9lw9nH0A>
    <xmx:9SOfZRF2Tuwih0GiNuAwikJSV2s0NRjK-Ng4Kz5IICm9TPatwmEy8Q>
    <xmx:9iOfZQylREzeBgmm9fAJz-idD2DFLoqjci9l2Mj3z3j_VRaS8UTiUg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 89B89B6008D; Wed, 10 Jan 2024 18:10:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91fe3dea-ca35-4dc9-ac13-e4eb0df30951@app.fastmail.com>
In-Reply-To: <c6c5fe88-c024-40db-ad1c-4e6681e3d7af@lio96.de>
References: <f8ed4fe9-edcc-1cdf-65cc-7cc9d4f913a4@lio96.de>
 <c7cb5834-1cf9-48ae-968a-d2807b6b9467@app.fastmail.com>
 <c6c5fe88-c024-40db-ad1c-4e6681e3d7af@lio96.de>
Date: Thu, 11 Jan 2024 00:10:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Voegtle" <tv@lio96.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build error kernel/cgroup/rstat.c on v6.7-1959-gaffc5af36bbb
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024, at 22:18, Thomas Voegtle wrote:
> On Wed, 10 Jan 2024, Arnd Bergmann wrote:
>
>> On Wed, Jan 10, 2024, at 20:50, Thomas Voegtle wrote:
>>> Hello,
>>>
>>> building v6.7-1959-gaffc5af36bbb I get this:
>>>
>>> ...
>>>    CALL    scripts/checksyscalls.sh
>>>    DESCEND objtool
>>>    INSTALL libsubcmd_headers
>>>    CC      kernel/cgroup/rstat.o
>>> kernel/cgroup/rstat.c:218:22: error: no previous prototype for
>>> =E2=80=98bpf_rstat_flush=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>   __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>>>                        ^~~~~~~~~~~~~~~
>>>
>>>
>>> git bisects points to:
>>>
>>> commit 0fcb70851fbfea1776ae62f67c503fef8f0292b9 (refs/bisect/bad)
>>> Author: Arnd Bergmann <arnd@arndb.de>
>>> Date:   Thu Nov 23 12:05:06 2023 +0100
>>>
>>>      Makefile.extrawarn: turn on missing-prototypes globally
>>>
>>>
>>> My config is attached.
>>> openSUSE Leap 15.5 x86_64 with gcc 7.5.0
>>>
>>>
>>> Is this already known?
>>
>> There is a workaround in linux-next, see commit
>> 15fb6f2b6c4c ("bpf: Add __bpf_hook_{start,end} macros")
>>
>> I assume this will be merged soon.
>
> That commit is already merged?

It's probably missing this one then:

689b097a06ba ("compiler-gcc: Suppress -Wmissing-prototypes warning for a=
ll supported GCC")

    Arnd

