Return-Path: <linux-kernel+bounces-145745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A322A8A5A52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37481C2208B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8631156256;
	Mon, 15 Apr 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ocKxjcJ/"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF1155758;
	Mon, 15 Apr 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207804; cv=none; b=smxF4EC9EsXFfbOVYvW1+atXv+hUTmGfukH5Bzm+qgZSMU2zWtEXjfgeEa5L9PprIhDwjjyb9vfWevs1I5ars/p0dLEwVGfeUub14mYVF5riF4IQ8kCnywTN71g/2ZCRIpy3IF/6B6/cd4SifcsmFdhFDBHACW5mOsmftBH+Nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207804; c=relaxed/simple;
	bh=yMyWWDX+NmE2RkGm53ay1MoR/ZaUY1UdD0G7/h0vpUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hib42s82ccfMPK1DN+PzoFSDLoVhm7CsSpUzg0N2v++VpSpj1HwFjf93gUQDNvzwJ2IVW4yw5VRe2B7MaOpxxyYxAgYOxmTqaHWBL2wrkvN6xzjR+nHgQx0tWjU0CWr/XsftVdLwBUj2jnqixutkwD+v0CfR8/z4GkYg7HT/Vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ocKxjcJ/ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 1fc5b6f31edae6a3; Mon, 15 Apr 2024 21:03:13 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 36BF766CF48;
	Mon, 15 Apr 2024 21:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713207793;
	bh=yMyWWDX+NmE2RkGm53ay1MoR/ZaUY1UdD0G7/h0vpUo=;
	h=From:To:Cc:Subject:Date;
	b=ocKxjcJ/XzYHW6Aw7vl5kMSZqvMRvvaNWtsUV7KZ94owiBqn5KSGZzXy6fFObPicw
	 tY8qhaArE03CDtxFLYU0MbwPGPa93Y0W1H7NcfybQZCgNuJ50uJas2dm9bCApVsvuM
	 MzYvCpb1xT3776zm0lj6XMjQytpyMHzHA7cjY0N8eKnDWM8jRu1TAPKbUMkNQbQI+n
	 6zSVTIRedWl/ipc004LJNyr2ZAB7GN4SIfS0PpQObLCbkrhCXO8PPpzfvNzjsWuCmY
	 G/rvK4ue4Zs9kZJwnV2YaVxPBsJI3t8V2ygUhhMLuz5YQRG3Mp2Ppe4nnD4eyrKtb8
	 lYA79gYMtXMKQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 0/2] thermal/debufs: Fix and clean up trip statistics collection
Date: Mon, 15 Apr 2024 20:59:54 +0200
Message-ID: <12418263.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

This series fixes a possible kernel crash in thermal_debug_tz_trip_up()
and reduces some code duplication between this function and
thermal_debug_update_temp().

The plan is to push the fix (patch [1/2]) for 6.9-rc and apply the cleanup
for 6.10 when the fix reaches the mainline.

Thanks!




