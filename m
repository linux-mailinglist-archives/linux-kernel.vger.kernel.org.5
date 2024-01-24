Return-Path: <linux-kernel+bounces-37888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9B83B724
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6521C21301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E656127;
	Thu, 25 Jan 2024 02:29:56 +0000 (UTC)
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2E63AC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.79.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149795; cv=none; b=slHHDM4QjsrsyWYS8zffxorSyCh2jxapDnBMSlThgyQGsNaX2M1zaTgrZWNLujgfherU0LYFNv7PtpuyiTilBo5N1iS5kBaYfKS44DZGRuzXApToV+oRIMszvhOUmOVcUs17gneyoxYHDjW+r3IUfdvA4gzkQGuys3teks9y7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149795; c=relaxed/simple;
	bh=HGyNHMMKLOTJaC3+awYAmNT9tInVpb7Uuo75K5WBxn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+83EpefWhZ3CFAvYGTeWUA90iiRqJeEYykRVGm9Hd62MZTFDuxHaiWjS90NfJ8N63CioaLpaIRdc8Tcq4g2BDEL5bI3Rz9mXM8PItbtkEEdKEzeFSfWOBjQFbXaEgFDjvupUG5PHUz+KYfCP3QK+l83e1fITyo8Y0qpJoWiSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.79.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.9.77])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id E16C22709D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:50:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-hj5nj (unknown [10.110.113.182])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0FEBE1FE70;
	Wed, 24 Jan 2024 22:50:47 +0000 (UTC)
Received: from etezian.org ([37.59.142.102])
	by ghost-submission-6684bf9d7b-hj5nj with ESMTPSA
	id I82xOkeUsWVyhRkA3HD0yg
	(envelope-from <andi@etezian.org>); Wed, 24 Jan 2024 22:50:47 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R0047556fd25-d410-442e-97f9-46ad02d884c8,
                    45966BE1DD11163008BB7B2F56A64F52B223FDBD) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.145.39
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Rosin <peda@axentia.se>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] MAINTAINERS: Update i2c host drivers repository
Date: Wed, 24 Jan 2024 23:50:31 +0100
Message-ID: <20240124225031.3152667-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10684790117257185863
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelvddgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepudegkeetueefvdegkeevleekheevfeejfedtvefhveelgfeutddvhedvheefiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohiilhgrsghsrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddvfedtrddugeehrdefledpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth

The i2c host patches are now set to be merged into the following
repository:

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39219b144c239..ec0ffff6ded40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10091,7 +10091,7 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
 F:	Documentation/devicetree/bindings/i2c/
 F:	drivers/i2c/algos/
 F:	drivers/i2c/busses/
-- 
2.43.0


