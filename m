Return-Path: <linux-kernel+bounces-22771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A286F82A2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF11F213DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA954BCE;
	Wed, 10 Jan 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QfuJRDsj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r//zchEx"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9196537FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D4BCC5C0186;
	Wed, 10 Jan 2024 15:41:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 15:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704919281;
	 x=1705005681; bh=eFODf4Agdpx7lXjTCz0ChZngiyTF6lfwBZodPbLs9O8=; b=
	QfuJRDsjgTWPUaX4VyOHvxcWV0NBJGHZTpQ9CHKysjhnJb2pFdQKJ9CUkgPUHu9B
	+3YljebfGjgaTS44P7S2FRTjJWe0WwOmhYwso3gdZ4E+h3oxQJnT+kijFpzHeYHe
	3M0yGeg2ivI6PG5RVxVk1tBTYSNf6pKD6bpUxArcYjGleU0zdcgNxviF5htTzBX4
	4NMZHrdMS6fJE6+PmWwIolb066RxyC13iPtBctmMrJ6aJlcWAn6ODg+2BC5fskWx
	DAaJyqNSUySXoyDzGfVTU/zzpfAzUS6/0PkzagU845zoFA8jZ1Q2G2wFm+aQGMX/
	ZgG6KE4ITX48Aq6/sRyDFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704919281; x=
	1705005681; bh=eFODf4Agdpx7lXjTCz0ChZngiyTF6lfwBZodPbLs9O8=; b=r
	//zchExsAsSp9UXHyVoFYqwHrtFViiH67HL5WMP36/IxR6WSQ9jZVFiDMsAhQrR6
	5D+bI4Nd/mWCJNPF769JzO0URLya832S3T0z/SbyGL9BUkdZWpdrtOOO2H0qvQby
	goFm6teCdaKPqxaQ4ILxrakfjL8SU68lUIx00vFOjdG3HK/myH2wDeDhtS+SPnmw
	gvPQ8T0w81Vc5Z5eX8sjnXigho2rO3rC8m0Q1A18i7KHMv3SWd2xZoictHSGP5Tu
	0rltAqmDKKuQsnb4XznYYuat+GgQDRG8xgTfXDthFroU84nxgF/lp3o+QjwSRP2d
	CSRU66X6BC5RPkVSQcBwQ==
X-ME-Sender: <xms:8QCfZQn8NKvqbcZt51jwUpF6rBdjMZf3SKH5XkWCHRP1FpESV1KKBQ>
    <xme:8QCfZf2BQe4VV2oebCLY5C43VlN8qdXV1xkfdehf8-Pqyf0KfHdKAtI5Y7x1NYY64
    E_-dfue2UnZ7nM2MW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejgefhuedtjeejheduveegheevudffjeekhfevfefgtedtheegieeludef
    uedvhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8QCfZer-SX90K6S_kkqjjsvGru2SH84o4L6thC9vgVmxbLens-EUoA>
    <xmx:8QCfZckxI94IJKEzZtrkC0GTiMOrLqO7MbVrmmUihxccThR3txOMlw>
    <xmx:8QCfZe2MRqNjNKxiQZQChDm83BakzSvuhvsHCoE4iN4GYudTkaVe4Q>
    <xmx:8QCfZXgXg8KB546WzOudEdtiYmPnjLLcD1xtxu14JNaAhwkdlzd2ng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7F993B6008D; Wed, 10 Jan 2024 15:41:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7cb5834-1cf9-48ae-968a-d2807b6b9467@app.fastmail.com>
In-Reply-To: <f8ed4fe9-edcc-1cdf-65cc-7cc9d4f913a4@lio96.de>
References: <f8ed4fe9-edcc-1cdf-65cc-7cc9d4f913a4@lio96.de>
Date: Wed, 10 Jan 2024 21:41:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Voegtle" <tv@lio96.de>, linux-kernel@vger.kernel.org
Subject: Re: Build error kernel/cgroup/rstat.c on v6.7-1959-gaffc5af36bbb
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024, at 20:50, Thomas Voegtle wrote:
> Hello,
>
> building v6.7-1959-gaffc5af36bbb I get this:
>
> ...
>    CALL    scripts/checksyscalls.sh
>    DESCEND objtool
>    INSTALL libsubcmd_headers
>    CC      kernel/cgroup/rstat.o
> kernel/cgroup/rstat.c:218:22: error: no previous prototype for
> =E2=80=98bpf_rstat_flush=E2=80=99 [-Werror=3Dmissing-prototypes]
>   __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>                        ^~~~~~~~~~~~~~~
>
>
> git bisects points to:
>
> commit 0fcb70851fbfea1776ae62f67c503fef8f0292b9 (refs/bisect/bad)
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Nov 23 12:05:06 2023 +0100
>
>      Makefile.extrawarn: turn on missing-prototypes globally
>
>
> My config is attached.
> openSUSE Leap 15.5 x86_64 with gcc 7.5.0
>
>
> Is this already known?

There is a workaround in linux-next, see commit
15fb6f2b6c4c ("bpf: Add __bpf_hook_{start,end} macros")

I assume this will be merged soon.

     Arnd

