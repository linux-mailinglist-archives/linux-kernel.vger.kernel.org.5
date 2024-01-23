Return-Path: <linux-kernel+bounces-34836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4765838822
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756181F222AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10152F77;
	Tue, 23 Jan 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ETPCV5Db";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X43E6IJx"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738B524C1;
	Tue, 23 Jan 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995738; cv=none; b=utRpUWO72Vo0LSog4nRPs6L4VNLRAS3YtjgXTeVUbRkGPawKvd7wlhyFZka6uC5mNynR7II5A14l2KVDAo/C9/nTpvn71qDXGA0BFiProDsVPBAcA6vJ74Hhwd88CxnjkvAeZagH1/DH+EQ4/JpLs9iTmDv+7E/hCy/FK+YCgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995738; c=relaxed/simple;
	bh=N3TW6zn4ZfdYvjpm3OAQvfUfaRC4b/dOkQACq0ilcGg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=m+cHmIWggsCrVPJPI5fMj4O/ejmCxvcgi4PmVJBdVOV221ARDwZSaqh179OHu91oA6qu+eh5L4tJK+TVz5SPPCWbA5nEnBlD7PDMYfjwJmO6HFr7DXq8IoijikDZPVTDiwjKUYxz6JuyvZjDreQJenmbYQ9HRYOEABpk5tQ6daE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ETPCV5Db; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X43E6IJx; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 22A333200A11;
	Tue, 23 Jan 2024 02:42:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 02:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705995733; x=1706082133; bh=RoP6Oowyfa
	kcL2hCR2YmRvMj2I53sJwl/XC2owMPac4=; b=ETPCV5Dbvaeiax1xIxSYocns3z
	Sv5dnbBStOh30fCXi9YTp6OhRR/8oQbH53ssci+0ajDOv9MpXl7Urx4TQ5z5WTP+
	7RfUhlBwgppuA6oMMYsbS8OCesggLNal0grGiVkyWrejPwemaQLZFklXHjSIdnnm
	UAEj/X48dLFJaTy+uS09RGys0Q9IqmZZaqR63qgrvmhwW5W2VWpTPilguU9+agfT
	lbGPoC7uOmS3Bjq4B29QBNpOTnaewG4mVb90MwOUWUh5En9OUdAWT+6gL3ya8AjY
	8BhQHivSTigUMPk6ER+BOi1klO7JuhCPUngfGx/KD1dr5H4z0MJ9dsLC9AOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705995733; x=1706082133; bh=RoP6OowyfakcL2hCR2YmRvMj2I53
	sJwl/XC2owMPac4=; b=X43E6IJxmuP7RoKL7P4ADximZCFFUKgVGHB9Ke1wYWfO
	v3rQcfUwcttBJP34M2pfj73EBOoSmq59lV7uW954tHxanXsAL3pqLMIEi68QrBr8
	sX5No5GAnnEjhDAtOAWk6XOZClCeZBr5lKmh8V9GqGNjjmWMiwNoUoO8IJW5oG7o
	C5fKXfaWFyh7k9R1MgTTp8ujfDmCvmEo2pTas4cudaWngXa2skpel6rIinLQd3o+
	Np7y6IgBN/x+nBKImgbHJ9oN5xqpE2Lu3DMxsxgmKDrffXlpG7oXTCIZPuAIf4gx
	S6z6TPX/IUTTIjrAahvJ5fqGDncICiGgpuiQDHr/+Q==
X-ME-Sender: <xms:1G2vZcRGCSzpE1Y4IqXgsIa5YItPYcO9LnUYmTq6AU1xbdyeUY_FDQ>
    <xme:1G2vZZxVLZJ_nYm4er2bEp7JwJBMya50VXPKoTalMakwVK_DDimYHO_yV5MRs6fK-
    njZkltXrh7tBEUIHBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1G2vZZ3zZyNWaat5GwzQwwZaPQ6Gm0FF6GDhTGAw0YWcNgXSsxss7g>
    <xmx:1G2vZQA0wXdtGG9httF2Uhdk6ulIyiVs6UTP7phZB-Kcx9B7KITgsw>
    <xmx:1G2vZVjoPr4Kw7Cq-p5Q_S-SXt1MKCo55A8G7WDe-yDyNXc6gOJVYw>
    <xmx:1W2vZeZgAhE6DwDrqYPlFJEBH85HlU1kpBIPF16VUyJLGlZFFKz4Ag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A1E39B6008F; Tue, 23 Jan 2024 02:42:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da24d929-408c-4ce9-9f84-4b2e73e3f107@app.fastmail.com>
In-Reply-To: <20240122225710.1952066-10-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-10-peter.griffin@linaro.org>
Date: Tue, 23 Jan 2024 08:41:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Griffin" <peter.griffin@linaro.org>,
 "Rob Herring" <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, jaewon02.kim@samsung.com,
 chanho61.park@samsung.com, "Sam Protsenko" <semen.protsenko@linaro.org>
Cc: kernel-team@android.com, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 saravanak@google.com, "William McVicker" <willmcvicker@google.com>,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 9/9] ARM: dts: exynos5250: remove deprecated samsung,syscon-phandle
Content-Type: text/plain

On Mon, Jan 22, 2024, at 23:57, Peter Griffin wrote:
> samsung,syscon-phandle is no longer used by the Samsung watchdog driver
> to access PMU registers.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Can you mention the driver commit that led to the property no
longer being required? Since this change would break compatibility
with older kernels, I would want to make sure that at least a
couple of years have passed since then to give users an upgrade
path.

      Arnd

