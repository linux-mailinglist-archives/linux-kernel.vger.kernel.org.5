Return-Path: <linux-kernel+bounces-112851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9567887F03
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A779B209AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0641CD10;
	Sun, 24 Mar 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="T/NM5Y/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX/aY3JH"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E108D53F;
	Sun, 24 Mar 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314519; cv=none; b=eKWLwop6CfklKfptP53m3hBibjTVfck7vgyXoGLhsq7mZ98sXSHTrqpMauOKLbyLC7wPcZUzE7WqTIlEWWoKmih7rFxmkBLRSu5fcjQoZbAmkwSTPACfbNgMU5A+P/rSPJWEg5QsrRhvK4dcTs+9LYoEb1HF4HX17awHg75CxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314519; c=relaxed/simple;
	bh=hpk6Wi6xibmLu2eA9kJTYleFHcU39R9mM9+aJN+WP8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLdqW5iXYpqtZtIk45yZVlYHcDyswyiERNWX556qNiyWPmoV1R2W7UvfMwz/sh8XhVszEpTBp0nz17YtehwxAWBh2qBg0baiHa03ZIL56IQMJAoZE6SDIaohu4bhlQ6wXrZMmhQ69Gnzbz9RFpUtS+bw3HqyHNxVDPVxsjF9oJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=T/NM5Y/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lX/aY3JH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 01C4611400BD;
	Sun, 24 Mar 2024 17:08:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 24 Mar 2024 17:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711314514; x=
	1711400914; bh=h31yFYMuvD8W4+jwFqiAM6h7FP1FGnBAkqLSOrHU3Lw=; b=T
	/NM5Y/xMwutq0VrqeHwqRc2r8ppPk9dY1B2IZL8uT9NpuLsalDAujHe0vKOxWN7D
	kDcR/gLhDd3GPsmlLdfo4AIe/6IdiX6V48z3zZtYtJBE4koHbE5Ykh6M9bnyaTU0
	xdNCFs9USPfsZL8AFFr1M09w5hBvCUlHaPV/LP/w37Ok86m+3iDg+DLdt8PtOmgu
	49EBR2KuMVi2c9d1MdofmkjFmvVDoDz/WWY/J8DzIyJFdQ427puh7bmIvNn6by3q
	J0/Std9DHJaKlaE28IgSAB6RlwaP/aTAUp6HdJeKfkWMYNsd01KbJxKh9sXWrXzN
	QZbxJaiZbdPsXsStBMFbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711314514; x=
	1711400914; bh=h31yFYMuvD8W4+jwFqiAM6h7FP1FGnBAkqLSOrHU3Lw=; b=l
	X/aY3JHbBgmpQojhGhfXeLCwqqnVCMFCSqjoavW14X6VPeYjSpLSLditBG3khcVo
	Wh4h+IgGHvptPU2/iCZj1S3I+344KNuPSLvOB6xAHUQfSDaua9F9kCJG7486xNPE
	Xuhv7WSucI+mCrPYwPa8Sq12Vq4S7yBvOvub0cF/Vz2chdvtiNi9LsSYdmlefgm/
	RYny9wAKEU+2Aw3NXsOcBFR2MitoimbyIyCf/UER+GjA6zYET0zlwzV0Ipd964HX
	fSUJ+TcAgWdso35kKxAEo+f8d69EBSL4oCDdb9adLIpJKeE0agR52MDErxcM2JNR
	JzAbE7kKPpt/cLkfkMjyw==
X-ME-Sender: <xms:UpYAZmi0k0huX4N1N70jkM2iLw3_yK4A05HIypRnLfoK83ZoqnIRhg>
    <xme:UpYAZnBcz2K8DLpkbYU-TO6rwx-zYoFSrA7rN4TpPezzEC8TgYyLZJzyayi9TOHY1
    p3asiCyIZ4HI6mGd-c>
X-ME-Received: <xmr:UpYAZuFT963srjrqy1__Ujkdiitn9JbOru9My5xUw_h1Gjo1US945jCWkb17>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:UpYAZvRI-v2pPnEQrqdStZ75-P448KxQavA-owbAUmMKEWUAwo2XoA>
    <xmx:UpYAZjwMUBZYv_m5Tz0zlrnbGOMReOToiZYPOIKm9Sa1B-Wz088CiA>
    <xmx:UpYAZt65STtAo-7V_NOXk7myip5IwXwktp3sxTXhhJzIvV8enaHn_A>
    <xmx:UpYAZgwpp8p0UAXfuqDD43W4wxsRlvE4_J5rpyBxTNcUHp5NV4TC1w>
    <xmx:UpYAZrgYPPLgGFH8f9mXXrHSzlAvXWNHfy1kPOMmqWohzzAVp8Qj9w>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 17:08:33 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	dmitry.torokhov@gmail.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com
Subject: [PATCH 0/4] platform/x86,input: Support for new events on
Date: Sun, 24 Mar 2024 17:07:57 -0400
Message-ID: <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support trackpoint doubletap and some new hotkey
functionality which is being added on Lenovo laptops.
 - FN+N - display system debug info. Used by customer support with
   Windows users.
 - FN+G - disable/enable trackpoint doubletap.

We combined these into a series because there was commonality between
what the different features were doing.
Please let us know if you would prefer to have them as separate commits.

Many thanks to Peter Hutterer and Benjamin Tissoires for the guidance on
what would be best for exporting the events from trackpoint doubletap to
userspace. Any mistakes are ours :)

Features have been tested on Z13 G2 (doubletap & FN+G) and X1 Carbon 
G12 (FN+N)

Mark Pearson (4):
  Input: Add trackpoint doubletap and system debug info keycodes
  platform/x86: thinkpad_acpi: Support for trackpoint doubletap
  platform/x86: thinkpad_acpi: Support for system debug info hotkey
  platform/x86: thinkpad_acpi: Support hotkey to disable trackpoint
    doubletap

 drivers/platform/x86/thinkpad_acpi.c   | 31 ++++++++++++++++++++++++++
 include/uapi/linux/input-event-codes.h |  2 ++
 2 files changed, 33 insertions(+)

-- 
2.44.0


