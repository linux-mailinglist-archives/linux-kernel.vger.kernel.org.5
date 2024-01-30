Return-Path: <linux-kernel+bounces-45273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F14842DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D53282F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30984CE00;
	Tue, 30 Jan 2024 20:35:48 +0000 (UTC)
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501769D35
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646948; cv=none; b=A67Q5XY8yGI5cj5i2gxdA/4UNgpSgiihkeYJrqP9v0rf4cWDjhktNBTolj+SVOsa7EsWQUSIEihkMfipz5bNGAnIhaVu82z5YixTGDkY3a+bwZ65w5YcflA01XgdFOEnpIprYltbZN6vR/XiV7cXKRMRziucSyU9VDuBmDwqCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646948; c=relaxed/simple;
	bh=B2ppdC8u/QDeG8tThRyRJOXtZ0rOnmI2LRCGp0bMwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/LIa36vWWkmLUZ9lt5BJCzw/eq6m9TIGkwG8sfaSB+GdFPIGtrt2vdABflpiO3V5I5CqjPUAdBDZvwb8Lbb0iPaSY5DglumwazpZ5eHeRdRnG44Kvl/+gnuDGQcb6tEJRbeyGeK1Gub956Pbr6j+m3deZtEN/MQ36hClT25WJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director5.ghost.mail-out.ovh.net (unknown [10.108.17.1])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 79DD524588
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:25:52 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-ctjrb (unknown [10.110.113.129])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4D6741FDB8;
	Tue, 30 Jan 2024 20:25:50 +0000 (UTC)
Received: from etezian.org ([37.59.142.99])
	by ghost-submission-6684bf9d7b-ctjrb with ESMTPSA
	id +DAYJE5buWXh3AsAF6xv8A
	(envelope-from <andi@etezian.org>); Tue, 30 Jan 2024 20:25:50 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G0030724d115-007f-4b95-b9ff-1a0b342b8d03,
                    A55004731C2A18159FC94DBA16C28717FFA6C146) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.145.85
From: Andi Shyti <andi.shyti@kernel.org>
To: Peter Rosin <peda@axentia.se>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Naresh Solanki <naresh.solanki@9elements.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v5 1/2] dt-bindings: i2c: pca954x: Add custom properties for MAX7357
Date: Tue, 30 Jan 2024 21:24:55 +0100
Message-ID: <170664590836.3575391.9594221857532318871.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130121902.462619-1-naresh.solanki@9elements.com>
References: <20240130121902.462619-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6579759056189590235
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeevveeiffeifefgfeduvdetleffuefhleffjeetjeduvdevkeevhedvjeegfeetveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddvfedtrddugeehrdekhedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht


Hi Naresh,

On Tue, 30 Jan 2024 17:49:00 +0530, Naresh Solanki wrote:
> Maxim Max7357 has a configuration register to enable additional
> features. These features aren't enabled by default & its up to
> board designer to enable the same as it may have unexpected side effects.
> 
> These should be validated for proper functioning & detection of devices
> in secondary bus as sometimes it can cause secondary bus being disabled.
> 
> [...]

Applied to i2c/i2c-host on 

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/2] dt-bindings: i2c: pca954x: Add custom properties for MAX7357
      commit: 8e7d967f04df0fa2c2db00f47ac4cd5ea16ade91
[2/2] i2c: muxes: pca954x: Enable features on MAX7357
      commit: 6b572ea231236bb3be4b819d92119470ac121a9e

