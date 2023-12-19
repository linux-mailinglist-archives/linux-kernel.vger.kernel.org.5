Return-Path: <linux-kernel+bounces-5867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259AE8190B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C141C1F25DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEB38FAA;
	Tue, 19 Dec 2023 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LOcGV4LE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L43Z7KQC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213A38F8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EB9365C0219;
	Tue, 19 Dec 2023 14:27:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 14:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703014058; x=1703100458; bh=IdOE+EaEoU
	TDvjLvPvfWoPNhB/MSd5EUvGvJTZndkLA=; b=LOcGV4LEVtP3K1ZgNxq/a46BSP
	XVukd5aNabEwdaaW01jK5FTKd+CVrB3E/rRe+t89I3OY95w62z52Y5oldIs0dMNd
	hy15NCWNHO3aSWgeGjO4H5K20/KmeUw47oXHJyGH9hyam2IP8vii3ZpBEIgLVrqz
	M3csy5AZEO5KIb0cRYOItirsuijnnG5yvfdxWNhlohnCDRVkRK8Txpn3ETwjQAY5
	1gxO/ZZUHT1wmNwedCqkNdYZvi/l0+dn2rhvA3fma5QLqpkFD4YIPtCBh+i6yFYm
	lsmqfrE5QiANc03cSpTO6YWhem4cFvQos9M+Oko3S/18NYC6vpOKhgcV5VEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703014058; x=1703100458; bh=IdOE+EaEoUTDvjLvPvfWoPNhB/MS
	d5EUvGvJTZndkLA=; b=L43Z7KQCRL42aC7LVIdjdmKMjiVVQe+VSsnKY+pUndhQ
	lD0W7Ph6iqxwAwiSpC6lw1a1AL1NjwJCo7bKODTcH2XNjXlTp5KnSaFsi6l1Vl7i
	ERQhSxPQwpKHKWck7cNJTzSi+TRWUuiI8MWvbs2D8Hhd5WLuEhP7LsPH0OBphWrL
	eh6KfMerxUK+fLUfVuQ+vEC8QuQK5Di1tnVNNszgQkwQFUYYU25Pqwq6a09qZFod
	oR4mx92kHWJOqRM3QAMjhyZ/jjjwa9K6SU5BCUg+2OvSRltR9/VwP+Ukv128glRj
	PNwAryM7IyrnsXVi7pXGCbmSjVUMHoQJP6krycfo7A==
X-ME-Sender: <xms:qe6BZQ0gxp0c-tiLjLZfMdUNunwyr-6TcNMx6eKNLYx20uXcgmPvKA>
    <xme:qe6BZbFvGUiLgmqTAdPlweK5nnjsDk_C2M_QZNls4I88aWXpMIn8XPvbHirgKUyDj
    MwTt86-gmcaTsqm66c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qe6BZY7sufljCKge57Luql-CtqGcKNwhwz5gz5gBddRx9KJF8HjeeA>
    <xmx:qe6BZZ24fNpB0gZgqZjNiWleQxnthD2VkhLtPQR4m_DbKthzwdo4fQ>
    <xmx:qe6BZTFt96fBykzGKhpz3a4ivSYS8PNpQqReqln9jzIi_pTBVF4NtQ>
    <xmx:qu6BZbC8upTg0VPz6-mPPuLfINplb4Jbq6vGRgScizx0RljRSiw_zA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C5121B6008D; Tue, 19 Dec 2023 14:27:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5926d65-5fc9-4ab6-8b04-fdb6ba618a51@app.fastmail.com>
In-Reply-To: <2023121905-idiom-opossum-1ba3@gregkh>
References: <2023121905-idiom-opossum-1ba3@gregkh>
Date: Tue, 19 Dec 2023 19:27:19 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH] [ARM] locomo: make locomo_bus_type constant and static
Content-Type: text/plain

On Tue, Dec 19, 2023, at 18:33, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the locomo_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> It's also never used outside of arch/arm/common/locomo.c so make it
> static and don't export it as no one is using it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

