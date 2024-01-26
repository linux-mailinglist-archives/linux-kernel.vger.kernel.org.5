Return-Path: <linux-kernel+bounces-39660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18F83D481
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A91C24406
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F713FE4;
	Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cyUYfSAf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mb027GcG"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70541C2FE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250467; cv=none; b=kgMkaOoo41BPFkh+jlvSls5+oj1AAMunDqDFVH8BDxtGHwfTW5GT13JftPu5/TZoCOrz7IuiXWDet7Bm075oWSZ4vxoNt36weNOSb5UO+Ngkv2wgwGDZrBfI5HzQJn5IllC4FOnDmZ5AMxLQwXqbkNjiPcw1HHUd39vQKYi/P7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250467; c=relaxed/simple;
	bh=FBL7hTT/AQ8zcejU8o0lB8qQ7Lub365PDThqd6QKVIE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=f/jOoI4/zRoan1l6nw19YLnZEjKpwFdXIzKvBI7t9/QLo7qExITDzUpdeqXPtAgWotyAvBMpAJgqJJoX1FWpArmLy3Z/vDgXXW3o0TkSZtz/0a64A0wbE9bB1bfOjm1q3Io7ykMxeh9/iB+iwKpTX9+xhF3BCyrAloJesycNypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cyUYfSAf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mb027GcG; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5CE0B5C00E6;
	Fri, 26 Jan 2024 01:27:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 01:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706250464; x=1706336864; bh=7RrmUgGenu
	Qn/HaNj6HFZoaaojIW34eE1x1H/iTMOvE=; b=cyUYfSAfcE+s3rk93DNCSvy3r0
	ngicuukkvqN5cjrIZZcQXUOsxXM2j/KX1jQ/XTFHSnKbhB3ONeiTmgGsLSCfjal3
	1kjVwTVQ+uAAeKnUsKOVYB3hQ43lHg5hphvt+YL7Ym2OD8Odz4e5eN3g3CnTVDL4
	+RJStzgxZgTM2c1QRXkWAFLz3Jmqhtn/zG8cPah6bxHpw88Pqw3JadIwuz4llNae
	av84nC+D+VEiNeyjHtyGqxjJW/T2jvwkdVoj/Hb7WNDmMr/h2ta1mWta2Iyf2qxS
	23on7SqdafRa+52DJ20R7IvT9x6lRb/T+n3E2xP4YMxwi08a9xLIxyzR93gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706250464; x=1706336864; bh=7RrmUgGenuQn/HaNj6HFZoaaojIW
	34eE1x1H/iTMOvE=; b=mb027GcGfOmjbjYfuilqqkpJFkedsZFFwMivRD71Bf1X
	UhQ4AhRNXOBTLJU3ySqEQdSo7c2oP+9EP4j/dYMfsRwFHXizD9/E0Gld442pO+Q7
	9TNCoCUMaKiorN66Hrwueyc7abWyOITPz73pIZ87IuWlLaB4iRrrWTrVfIrrnd3I
	BgBB9rQyGAP7SfQlznwPfGZv1x+TU3HaGw+eJ3xdJBljfE5e13yN8gUfDRpUa+Vj
	rpwrsFVUS91Z6WDByOMNnPbhZiBX+Sdnk9vP5ooS0Scj1IP1H/gzpQFlFoPO1+pq
	ut6eiAVp7F9kOKRGODd4ZpvazB0fvCgInteggLTpQg==
X-ME-Sender: <xms:31CzZadCyA9bjOx7J0bHRtIcq06G171pSxL_kKHi5Y0WikW4bWCZwQ>
    <xme:31CzZUOHEDBO9Nr-i2_7LTOObn7qaqxRs-8pSDrdX_3An964CujcHHjkouIGrTXvC
    MLlWHGSmjyJ7gXqgso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:31CzZbghtBPd7iRpeihXGFnW8pg_KAm-YPY4qivD8ADvkHktdddm7g>
    <xmx:31CzZX8XgSQU09D8Ax7CyVrAYdhr6X5KxVsBoCXY9fIZYa3dS4oyZw>
    <xmx:31CzZWvfao0K_pThCotYkdM-sbqTNEGxxBmO2aUF2Mw8LSNjUAjN8A>
    <xmx:4FCzZaifdxHRQpJOdU_vlPdB9Wd_Neu04B9Thbzv9dWlzrXeKPWbVg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 89F82B6008D; Fri, 26 Jan 2024 01:27:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbae8c8e-6788-4749-b7e0-b64c9fffe85a@app.fastmail.com>
In-Reply-To: <20240126021258.574916-1-chentao@kylinos.cn>
References: <20240126021258.574916-1-chentao@kylinos.cn>
Date: Fri, 26 Jan 2024 07:27:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kunwu Chan" <chentao@kylinos.cn>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, aneesh.kumar@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/cell: Code cleanup for spufs_mfc_flush
Content-Type: text/plain

On Fri, Jan 26, 2024, at 03:12, Kunwu Chan wrote:
> This part was commented from commit a33a7d7309d7
> ("[PATCH] spufs: implement mfc access for PPE-side DMA")
> in about 18 years before.
>
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Nobody is actively working on this code, so it clearly won't
be needed in the future.

Acked-by: Arnd Bergmann <arnd@arndb.de>

On the other hand there is probably little use in removing
the dead code either. It looks you sent a lot of these
patches with identical changelog texts to remove blocks
of dead code, which does not seem productive to me as
these were clearly all left in the code to document
something.

      Arnd

