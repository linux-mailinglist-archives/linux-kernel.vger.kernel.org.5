Return-Path: <linux-kernel+bounces-91746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B98715FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC231C21BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E34595D;
	Tue,  5 Mar 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fLlxPlmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeV8QCKO"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16181EA6F;
	Tue,  5 Mar 2024 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621084; cv=none; b=ERk0+kIryrlADO5NO4O0mU0UbQH/QAdJ2Hx7rxqfcyysgouCJM7zihTrX3t0ZRG9uPJLDBj1rf4iEk0f+Ssz+cBIVA2IBOal4GfeTydJYrkJsmrwkHy2FrB6hqQnuycNAGWkBnfoAVNa4UqJk3FhyuLVB6Q/oQb4Pq3osLf6vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621084; c=relaxed/simple;
	bh=BQYrf8kkpFf9Mx7Yqkd/Qt02w8PFBYhVvY2ShxAcjow=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BP0DNfOkjDKYnwG4QnCVQFX6Zkn2iy1Bnp77ie8PxMuPRH5nchI47PmCEzoCiMh1iP0HjiMp1Q23l65M1zpwAXCYzvas3MK6JWxFfzj7TRufk7GQe33OC6b6rimsfbLzWHtZ91DofYUvzt4auZBLQuSV8D62G4bKZczIs425CXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fLlxPlmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeV8QCKO; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 26DC31800093;
	Tue,  5 Mar 2024 01:44:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 01:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709621079; x=1709707479; bh=DkjNI/n0NM
	N4vMnPf/sZnByd9yD95rJt/42AZEeZmBo=; b=fLlxPlmJk1kCr1Z8F8ckzSoJo3
	9mSBn/+2AKbRrJgVi1EgzIvaYosnVXMihJ7tid5oqt4vm6sNYB9AmH93vbAirf/o
	mRZkvlnirx4IKla1B5H/Bz0l1dOj9VYFF8oDPFzFmsnjCtY/p0K2ayKZOpLY5zDf
	jNQ75ryUDC7jhB2jxZvAPOF+Pm0bzckjlKxpM4STgqlTPlWGUL8Q2bsgzxjwVU1Q
	hG4EendbER0M9yBuaX/Hc5fdxwIjNoBk8hd6luzx1DkKD/dqGmEetCrbBLNwOKFU
	NIrj8uQZ33hGL0mX7iQJzWRm59Ak3QNTZo0pzu8JcILusfUDGVCL5p8KB9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709621079; x=1709707479; bh=DkjNI/n0NMN4vMnPf/sZnByd9yD9
	5rJt/42AZEeZmBo=; b=LeV8QCKOVGODV7nNbbzVxSG45l+g4q9BWxY984xYweIB
	pO8S5xicp+aDBLwna6RLyhQn108/trSp8GwG/pqyQBo2htknDZL2gXa0OvcdLIhP
	6VoXcgGveOtdetc+0ZS/DCQ43VNqX35kuI+Qo78M9doanfZzVYyOxvfHMjBe1r1Z
	qcRvHe95rV9IudP181ZiqQUhcv2wY176iwMaK0RrsYUIm7tvi6RHZYBTKDBgHJfK
	nLb3DCYypcT1++MfeVSNbsRp3qRRkt9vTW5ViShRZbfDwY8qjJnysGvTuDmNbUsC
	XmrKeYnb1oyX+f54IAJ8P3TaPbOAbde6ILifTQroIg==
X-ME-Sender: <xms:V7_mZWW2fS9t_YRQZn-olW-7fq_nYSiXVeHg7xf9UpFX7qDK4N0ntA>
    <xme:V7_mZSmDdy2kqebOqGZCFGvo4DnCOU4lRzbe7BekUkXL2kZoM3qHtWgqbBZQcsCG8
    KEWP9Q9MuEmoKrtQws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:V7_mZaYG5irQVK68_wnZ7UrRShzstLCuodyKyNEk-FeT4AuAseyU-Q>
    <xmx:V7_mZdVk1UcQ3caTQIP25JvQE4gkkmdBTnLvsyAiYOFioCoj0CvCPA>
    <xmx:V7_mZQkREzV6Cf5zEInqUfjbJiY38cuF_oVGrT3Ujhbwua3RqIiBig>
    <xmx:V7_mZfvN9MHfdRvp4niy8wiw9mRcYsGxJsAeaoY4xKvbbHaL2odC7PyKRd8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F0755B6008D; Tue,  5 Mar 2024 01:44:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <154d19f0-1ed8-415c-8c3a-e15b9e7cd4a4@app.fastmail.com>
In-Reply-To: <20240305100727.004a6dcc@canb.auug.org.au>
References: <20240305100727.004a6dcc@canb.auug.org.au>
Date: Tue, 05 Mar 2024 07:44:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Jens Wiklander" <jens.wiklander@linaro.org>,
 "Olof Johansson" <olof@lixom.net>
Cc: ARM <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tee tree
Content-Type: text/plain

On Tue, Mar 5, 2024, at 00:07, Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
>
>   1d044941d538 ("tee: make tee_bus_type const")

Thanks, this was intentional as I ended up cherry-picking the commit
instead of merging. I expect that Jens will drop this branch now.

     Arnd

