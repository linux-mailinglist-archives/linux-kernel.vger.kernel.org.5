Return-Path: <linux-kernel+bounces-158636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E98B234A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090361C217E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDD14A0A9;
	Thu, 25 Apr 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="rY8+Hc8L"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC27149C52;
	Thu, 25 Apr 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053460; cv=none; b=TairpnsXZDS/1f7JVHvb8DQKPQNFBt0I41mp8hDnTnIHfCGcpeWchdrC3hsGU7jeVYDLNJvwHW84Tcnnp6eVO1/PF7TMxk5H1LupgF/PANrOsCpCoAXqViALq+CLg1ukuMRipxsxu5xSEkYyP7qC8U0jqYivZh7Jq1L1EzRwbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053460; c=relaxed/simple;
	bh=b7iRYarz0L9curo6TcKMEBGzkwuUKcQbSldR2fvyduQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fyv+AfMKodujNC5v/2b3SsvNj/gGOrG05EuZWsHTkDr3X1AwvZ9J3IGB+YzMZbLP0TsH1zR7QiaKvCBilxIH2Cp95RrQ2jv/vKKi+Lqw7fYZYnKu1/HsPc+0H1hiHKZbiA+kuxcpje6puSv5Sgn4KDKdnnxk2THq4FzqY7BCrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=rY8+Hc8L reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 3760a7682697599b; Thu, 25 Apr 2024 15:57:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5FBD166DF20;
	Thu, 25 Apr 2024 15:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053450;
	bh=b7iRYarz0L9curo6TcKMEBGzkwuUKcQbSldR2fvyduQ=;
	h=From:To:Cc:Subject:Date;
	b=rY8+Hc8LcWPI0UuDNsKLnlvLYOS80hA3dcUlx0cwIn2+sfe/BzCreWI2s9/a5DiLR
	 QuiyLWK+kxdSsJyxND0q8Rsc+DR44JcI+gE+6y7kXh2YM4hYm5uxjJ3zKK41hcV5Ha
	 aFuAg9jJD0uy44d2q7/KNvaMtT/t3qZ3kiqri3hUwh3mBPh5hf46DMLE3cBK3uf/zX
	 hD6N0IiimVomJhjLBbehOROG5NGe5xULMrTCvBADhNSWkSa9M6mun5PC+i2p2Rl9FF
	 SFEPc+xSIjnd81al5c8/EUZtowpohGEr0yi0X3t8006R30M62zPoMIU993Y4LG6W2z
	 9p1DdcsrECkCg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v1 0/3] thermal/debugfs: Fix a memory leak on removal and locking
Date: Thu, 25 Apr 2024 15:46:41 +0200
Message-ID: <12427744.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepieduhffgteetgfeuvdehudettdeuueeuhedvfffgjeehffevhfekheelvedvvdffnecuffhomhgrihhnpehgihhtrdhithenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This series fixes a memory leak on thermal zone removal caused by the
thermal debug code and two locking issues that may cause the kernel to
crash due to race conditions.

Please review urgently.

The series applies on top of the linux-next branch in linux-pm.git.

It is also present in the thermal-core-next branch in that tree.

Thanks!




