Return-Path: <linux-kernel+bounces-155238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A678AE73D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1761289C22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC912D1FE;
	Tue, 23 Apr 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fqFCyc1o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJV4mjJA"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852B12C814;
	Tue, 23 Apr 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877208; cv=none; b=mQf4zgd9O3XIIuRQphK/mi7AqTxkaWQ91A7+/tLJ5e3B9KEZT7IVVTzkxmigH3E1pQ3nzn3kzvk1wtUMNiLTlZz6Tq2jYFGzba9K/0OkBD3YYgjAFoSXksBAVy0U5JSuT0cas7A1j4+lEdVaTbSB1S/1zTtnOcxPpLuWoheebhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877208; c=relaxed/simple;
	bh=96sOkJm4NWVH3kIPbR6s+LMnNin0blBdVvU3NTD2Rm0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jyzLg3GkRx6SbORUF9WgXkfUROnWy8TdXquQ/yxf4pSN3b0Z6g3msd34m1JQ4oy1/k144TSuPfsRSx5GEZW3iXDCQ8uUyAlcuhsBBaZ2AYU4gHgQJlX5vvwvEyFhz7jxacfGTSkd0xWdnz3aXFhKFDfCrrhPagLTykDGhRns16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fqFCyc1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJV4mjJA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 53AD913817CB;
	Tue, 23 Apr 2024 09:00:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 09:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713877206; x=1713963606; bh=96sOkJm4NW
	VH3kIPbR6s+LMnNin0blBdVvU3NTD2Rm0=; b=fqFCyc1oHE+6auJzo+hRbFwgM/
	oyV3kHrwOocGO6GwDHU83ixOOgB3AR3h8OGjiD1OOcN2Of/UGiHwcxWDGg7Q2kO9
	hZ8Yv593YADSLWfBqFhrQrRbctx+eFJefPAmpoGMFM1NH0aSQs1ukdmTqY3Q72Ao
	hij5dqno2g5LmhNHsTSo8/+Z/m57iCVwiK8b6pj6B/51ShQF4D8UCOJuexiE1h4Y
	cjtRI2eE7n6CpRdKAFUvLC7cZdEhViDW70miNgwJkjWU52UUYaK6+OjnMMcWkEEf
	G+nKBtedkghyG0Gjn0/agxzUfPOctWDzxLambqF/Eq10l0DJ/wGPA+M06vRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713877206; x=1713963606; bh=96sOkJm4NWVH3kIPbR6s+LMnNin0
	blBdVvU3NTD2Rm0=; b=kJV4mjJA11QzkGuGatb62twjQKbnAAgYOuFW/mX8ZDEY
	h56eNptRCeQ7jkB9yJYgr4EvvJYuaJeYzfkRi6U91T2g4coTl78qeu4Ah4CBYxXX
	j+npQgWGnF168Y6Oyr6Qdrg/jv+ygqwj81Q+YHvwO2ikX9WkHo/eAnFFofBp3frf
	SWyLLPc+svrQl22xkjGqWmuJVsG9BRpDs4HOi1cPLImKWfvNgDrRCdVZK8zt208G
	vYn+kQRK/vuMH+eXuOQvIwdwc0ciXnsD5CAT4VljJANLVwNxTxyOuRggssvFACQY
	PT2uwkybeRVDRADdP8n3rdbJGrQ0+KTT44cjeVKEsw==
X-ME-Sender: <xms:1bAnZtnJ7by_3iVQOR4Bs_c8Igo2pPXcRMPL3Mf3A25lQwCD39H2tQ>
    <xme:1bAnZo0Dmp5o603hjNlYPYYDSFM-_LLeUbGVEfmg_D_rbqv_EMPDlCwjGfc0zLbEa
    Y4gYhrbwECNuaMi5RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1bAnZjqJIGoZJGYvmN2m1Y0wmjgnhvfmGtckwD3x2SWNQ43vOWSsCA>
    <xmx:1bAnZtn1f320OiptasVGe0HQkFGo57T_qDEFVtiX4ao6u9xTN5EDPA>
    <xmx:1bAnZr1nrHRdqdTmtECoDnyXRaTdaBLMnTmSLt4S17qHVW2g_RJuaw>
    <xmx:1bAnZsuVvpv_MnlXM3DuGQlhvZURwmrtFpTmLsUbi9D2JKalpYlUaQ>
    <xmx:1rAnZtw-0sAb1sVjZXoQHf1StgQsEcl4I9ifaYfCnbO6Fmk6G3n7nY5k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CF625B6008F; Tue, 23 Apr 2024 09:00:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <081ae10b-0a64-48fc-9be9-540e67900527@app.fastmail.com>
In-Reply-To: <20240423102443.453261-1-masahiroy@kernel.org>
References: <20240423102443.453261-1-masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 14:57:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>, dri-devel@lists.freedesktop.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>
Subject: Re: [PATCH] drm: move DRM-related CONFIG options into DRM submenu
Content-Type: text/plain

On Tue, Apr 23, 2024, at 12:24, Masahiro Yamada wrote:
> When you create a submenu using the 'menu' syntax, there is no
> ambiguity about the end of the submenu because the code between
> 'menu' and 'endmenu' becomes the submenu.
>
..
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I think this is a useful cleanup.

Acked-by: Arnd Bergmann <arnd@arndb.de>

