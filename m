Return-Path: <linux-kernel+bounces-122510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51688F8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFA2B248B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF650276;
	Thu, 28 Mar 2024 07:36:52 +0000 (UTC)
Received: from 2.mo576.mail-out.ovh.net (2.mo576.mail-out.ovh.net [178.33.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405F537FA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611411; cv=none; b=C0xxQPbQ3PTbRAD4V29muhF7rARqwn1HzK8AX1OSfNDtMMhcGk3BBolANrzftT1rqa3aWBC3HFU5MCDInZl5+bq0NP8pWcnCpLlZIXqlNZf6cexPZCSpYWD8Q88Av8NJ7c2e7nHWXCVbx8Eaq1TxkZMQT/x13ah26CqPDBP+Ogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611411; c=relaxed/simple;
	bh=5jdL0NZakDKqF9gplUSDQhdeYmYZL6yIF2/zBxh1+kM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kyyk47J8zrHZCzKg4U1WES5u9HTveASTIAD7hF8t4hY7pdDnOjUWYbfcyW3Um9m90jCcTVPIjiyLfyYBmC349ROjTou2HWl+t8dGk0bL6KlCzWZcBNzokjr9mR2ku+ZWAss0BO9reX64cMSYdRucGeWQfIaPC+3tEgY02s2Hq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.148.79])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4V4wMs1RNTz1WF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:36:41 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-t7l5r (unknown [10.108.42.33])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 665B41FEC4;
	Thu, 28 Mar 2024 07:36:40 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
	by ghost-submission-6684bf9d7b-t7l5r with ESMTPSA
	id 5CxFEAgeBWYTJAAAWKMMFQ
	(envelope-from <andi@etezian.org>); Thu, 28 Mar 2024 07:36:40 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002260416bf-d1f0-4904-9a61-cd2b2c3983f5,
                    6D693167F0AB1D8A9C15294DA3267AC24BED3ACC) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240327174705.519535-1-krzysztof.kozlowski@linaro.org>
References: <20240327174705.519535-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] i2c: viperboard: drop driver owner assignment
Message-Id: <171161139848.2698925.1593259780081719609.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 08:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 2164261096738392600
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfgjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeelkefhieeljeejffdtvddthfffleffueekkefgieelveejjedtudettdeghfdutdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

Hi

On Wed, 27 Mar 2024 18:47:05 +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> 

Applied to i2c/i2c-host-next on

git://git.kernel.org/pub/scm/linux/kernel/git/local tree

Thank you,
Andi

Patches applied
===============
[1/1] i2c: viperboard: drop driver owner assignment
      commit: bfced8e642d8e221a765b4d97ce7705cfa63b9a6


