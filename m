Return-Path: <linux-kernel+bounces-75130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9785E3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DADB25B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718484A45;
	Wed, 21 Feb 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNT/6yhp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B282D97;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=Z5w3ossWxLNDVIUpsAXMfIn0jwjkVD0hfUOfT6RBI/dsA78+GdJl1F/un+xm8YqNDELmyVQzdxMlv1BHz7NVhFhiJnbROZCd8+cMwbiFD6guwbxNoPBYES0DDgUubtspYaMBTgSYFUKH/ePd9k1JFCvAWwsEga7YRAwM82nCbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=w3+OCVOg6gitH+bg/hrW+YuNsjWKvSsvmr6SnY+BX9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sm+VMICrgKbmWa2g/QeOqEgJ75j+DMx4uOwhef/193LBOLyMxuV33CL+uFLiIaOtRRjCUfPOAN5Tut3A5aXMC2gFq6eb08mrG/A/K9veMh/aJya4CN+5nWd3LfSvPzcHYuWcGl9wNyWbr9sat2tl32NKnCfhUOC8zFEqEqU+jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNT/6yhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68F02C43143;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=w3+OCVOg6gitH+bg/hrW+YuNsjWKvSsvmr6SnY+BX9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kNT/6yhpWGoWq6Cx9lK7RefeIrrkmEj9i08v0tfkqGrq5dDEViLHsbXFm+wQl1fLJ
	 OiXCUEpxpJhpWMbwjrFElv6WjSdimCCWa44gi+HL/gzVMBfr94zzennQ/TtDLIg23Z
	 bXZ1HjTc2idcbMZlhT+T70giXWlp1Tptvf0zSaUq8PgWCBlIvkO8WTYABCiBmDoBYb
	 ZGWCGFHowPMAhZGUwrwVggONMUE5DyPfICbO2840CldtSbT1j3BZfbGLvwb6yU2QND
	 TrTruJWLNRjMNazwxtZFlgMBHS9xrDvCcDwvuD3D4J9KiJDm6wHO14yHxrzv24J3RZ
	 AZCgcSp4ciQIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50324C5478C;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 00:41:08 +0800
Subject: [PATCH v3 5/8] clk: hisilicon: fix include path for
 crg-hi3798cv200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-clk-mv200-v3-5-f30795b50318@outlook.com>
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
In-Reply-To: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=857;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=mym+b8HCE92ettwNUwgVrGSN23Zmo9f3k4P4EePsjQY=;
 b=HLw89V3skgYuIgXNObji690aUCG4vCg3pPngAlQUefQDRmWgy3nuR0CeMUiJFsI9E0pdBvCbv
 MAJ4hURdBW4CPWHSz+j7FQKY1CknWA3vYvXXyzz+IPsuxVfVLcABYoT
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


