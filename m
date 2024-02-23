Return-Path: <linux-kernel+bounces-78804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA986190E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBBC1C23B26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F813B7B9;
	Fri, 23 Feb 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB3WU5Az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1512D1F4;
	Fri, 23 Feb 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708355; cv=none; b=NH/IXhGrIlgkqxa8ppjaEAOg9Kn8SKkHkLdFxkIJ2M2UBNGqLDCnw4/NtRogll1fw8as443kC8fk70zDggtW4X8OkGUCQh3mdv2ahKqmWKF9M2DPQ9EJbH2GtgkOfg4VYElCuNwx+AxogQ37o818D+YVDEZnEHQqPhh/pnvQMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708355; c=relaxed/simple;
	bh=w3+OCVOg6gitH+bg/hrW+YuNsjWKvSsvmr6SnY+BX9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKzeEa4uVxRM8YTiK2oNLSmIfp9b+v/MTOw76PZFsa+9novhcXC/Jln+KK96wgMZAFDrFiDI5fVTLRoGMPhdITrtfGAg/8Ah5Jl0FCohFXf5WGBiHy31slmKGVK0f/0sIXjBVzcnnkM3Lu6nmmS7gpdl5yfJfDVqrvtfvfKwvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB3WU5Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF1E1C4166C;
	Fri, 23 Feb 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708354;
	bh=w3+OCVOg6gitH+bg/hrW+YuNsjWKvSsvmr6SnY+BX9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GB3WU5Az0K4Mu/1ZZdwGLczB2C3iUV8XoXgn2kqihAKVdNLbE8FkGd8Bw0axBPZZ8
	 AL36ESF4CaW7jy4XETCXTZ9wyW+vo1P4Beich/uZfuSF28Cjvj6B/9b/RjhiaKDQGa
	 HDTA2lfseGS4yaDPu/GWVpr1wi/8lQa4Uxt+ZtcAmXxG74tLjGx0rThGfyeIRhW65/
	 ZC71DgRacwxtz4Vo6yu3M6KJB/LSvmBeIgw1856J2k+7ADpP4/f8DHpqj6rGK7l/TF
	 Xetz31sdnuLk/CvmvyLF9GP7nCLY8VCKkbx5fkUK8ZDdSQcHoKQ7HxuStCTFJNkn81
	 Hw5M1F3RM7vHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D100C54E4C;
	Fri, 23 Feb 2024 17:12:34 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 01:12:31 +0800
Subject: [PATCH v5 4/6] clk: hisilicon: fix include path for
 crg-hi3798cv200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-clk-mv200-v5-4-79f586d6e1a2@outlook.com>
References: <20240224-clk-mv200-v5-0-79f586d6e1a2@outlook.com>
In-Reply-To: <20240224-clk-mv200-v5-0-79f586d6e1a2@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708708351; l=857;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=mym+b8HCE92ettwNUwgVrGSN23Zmo9f3k4P4EePsjQY=;
 b=Ijlgt5DIGlHWiJNxY66yKpfuYc9QYswFsYlU6WdtswiwIQJDvNrwjB4uOZf1RF7ddL3oqQYER
 JwhD6O+P7sjB+6xeQkTFf4BPJnZxU/5gblqSnm7mmEcxB/UKPLZhbtE
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

histb-clock.h is now deprecated. Include hisilicon,hi3798cv200-crg.h and
hisilicon-sysctrl.h directly instead.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/hisilicon/crg-hi3798cv200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index f651b197e45a..3e26a8f6df36 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -5,7 +5,8 @@
  * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
  */
 
-#include <dt-bindings/clock/histb-clock.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-crg.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>

-- 
2.43.0


