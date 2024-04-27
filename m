Return-Path: <linux-kernel+bounces-160997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C08B4596
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B79A1C20E24
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3DD495CC;
	Sat, 27 Apr 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMkgosbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F07482C3;
	Sat, 27 Apr 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214591; cv=none; b=rseDYOZ7t6IceXcReIxXrgPC6rY4w4C85RCTrmRZt+zn0DN8Dy1hr9QElEG/1f2+Y1ArRNGhooGxZiXMZyMwsx7bEYGalehHLmVGJ5tMHwC/FIh0/J1ImPo0W9l1zyjq0gbD7yqjClTh5A3YWibdMToEuGp8dXJmE05R+0suHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214591; c=relaxed/simple;
	bh=4xV3pt6t6irH6gGp6kDGovWYinj4k8t7rn3N6XMulqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KigkTggwzYbGfAFLyC5/HOvMbk2OEYrRfiUEw9GbOPBlbXAHT1Ss6gZ77m/JG6WWArvo6CeySAZ+R+SYbqngmZvGq9DS+cWMelY5fHviy80cDronF79rN+xcewSqyw6w1RewdaRNhMj/inSNkKw4uV1OCt3rSW+pZUFmiiuajEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMkgosbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E47C116B1;
	Sat, 27 Apr 2024 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714214590;
	bh=4xV3pt6t6irH6gGp6kDGovWYinj4k8t7rn3N6XMulqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMkgosbRLjIEvgL0FjUgy+U4iSWw2q6/AovOgCAYmioJTuq2n9KxA/CjOSVIp/BXo
	 A2b9IVJnOSJxvt2rrUx+86pVzojp3D5BsUSDFlOnyHcJ3Jor8/i+YxLLnpQ1d8hWUF
	 qQ70Fq2aLppnoPTIKPT7jjVr/bkFXU5G42hmBb2InTMozhVHmneDVM6tfan+w8B9yk
	 eHfrd8Bve9s6CN3BBT8FsKXrq0+ZMBwQfdPef+GlWqO3ip6faC8SG8SSE53ObN6+HT
	 5eI+AgvO+zf45L2DKz8P99dqRV7kFeCzQW1+449VZKEBsO1Q2PHRK2SLlZ2qm1cWpD
	 /YmcXUYrlMtvw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] rapidio: specify the type for tristate choice explicitly
Date: Sat, 27 Apr 2024 19:42:30 +0900
Message-Id: <20240427104231.2728905-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240427104231.2728905-1-masahiroy@kernel.org>
References: <20240427104231.2728905-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the type of choice is not specified, it is implied by the first
entry within the choice block.

In this case, the first (and only) entry, RAPIDIO_ENUM_BASIC, is
tristate, hence this choice behaves as tristate.

Kconfig will stop this implication because it has a bug, and 99% of
choice use cases are bool. In fact, this is the only instance of
tristate choice in the kernel.

Before transitioning the default choice type to 'bool', specify the
type explicitly for this case.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/rapidio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index b9f8514909bf..72b5b02492a1 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -60,7 +60,7 @@ config RAPIDIO_DEBUG
 	  If you are unsure about this, say N here.
 
 choice
-	prompt "Enumeration method"
+	tristate "Enumeration method"
 	depends on RAPIDIO
 	default RAPIDIO_ENUM_BASIC
 	help
-- 
2.40.1


