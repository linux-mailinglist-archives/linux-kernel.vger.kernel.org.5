Return-Path: <linux-kernel+bounces-164324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77B8B7C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F5E1C22687
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6017BB35;
	Tue, 30 Apr 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ep2VdKO2"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C93178CE7;
	Tue, 30 Apr 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492394; cv=none; b=ouFposvFP/iMAZt76y7Fh4CpNNgjbPtCugAsgKeE933IoQQxCIN4L5Fh+wFm1szGzGrg1HcIyLX4VIm92R4/VSlKVLb1LWVSCfYEzRrQrZENVVmt46vjuTndu5mGSz2B6j4i54vI++9e2Nblxzxb3AhaGElw4HA0+z+ZDvBOOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492394; c=relaxed/simple;
	bh=LLvqpbQxLf9opv/rdgPbavEmuwba7+h6W+1Q7QMyk5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hgPy7HWf6a9UTXU9c+td//DYl9NieJ3p9TeQpUw7n+PAyBRp5iyv7zKtAUfttUxDpaP6aCqhoFeS3yCaa4ihBNCfdGQNynNkCd3ObbbJcq2yhwn34gDKKpw6tJYmX0wiHLmLPi66pRVVgREGa/XznQdd8Q/If0Q8S8K3vn3E6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ep2VdKO2 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 570180c77b8bc57f; Tue, 30 Apr 2024 17:53:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2EF9D66E643;
	Tue, 30 Apr 2024 17:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714492384;
	bh=LLvqpbQxLf9opv/rdgPbavEmuwba7+h6W+1Q7QMyk5M=;
	h=From:To:Cc:Subject:Date;
	b=ep2VdKO2v99+ne3JbqSfboDtbheG0YpgUfVdgYCT71vgyXt3NuGVnufHX3/CSr6Dv
	 m9M8DnpBBrVYWRfGiIsgylr/q1BNtqCmt+KLgwly7RHlZQEzz94DGPnIBgELRxdMG6
	 26ICIIbxmOn8Y8mxai4pM5f6xeRKqHvlXWXbnCJVCaMnaoV4zIXLk94YVXdG8ixIBn
	 HeJU9A9+tp3tIlZJRPCd8wJb80hr9Op9ZEDJWKSXVwjvspvsrwi69CgZGtgv5QHvqQ
	 CX67bMK95xadrxJNlwn9h1ODAgaQKR5ydEmW7db9l7rru/yA766p5MkPV0gZnvYHg8
	 wAb7bIiXEeWLw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v2 0/2] thermal: core: Fix  thermal zone initialization and move
 passive polling management to the core
Date: Tue, 30 Apr 2024 17:44:06 +0200
Message-ID: <5790995.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This a v2 of the patch at

https://lore.kernel.org/linux-pm/5938055.MhkbZ0Pkbq@kreacher/

with one fix patch added and a couple of changes more in the main patch.

Patch [1/2] fixes the thermal zone initialization in the cases when getting the
first zone temperature from the sensor is delayed and patch [2/2] is an update
of the patch above.

Thanks!




