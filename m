Return-Path: <linux-kernel+bounces-111506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE27886D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E2CB25B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B9605BE;
	Fri, 22 Mar 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hcAuZfdn"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C560BA8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114023; cv=none; b=W2Ukg4pJ0CMbMHh3XFoMXdx4vjWMmHxH4zAeVBah8NW5hjvjj3mYcJIlbKMUxrJot+GD2V9kPV2D//5wad6/RqGXIXk/LdkAUgB6TfPk+JFjcT6C9PXWlsty1T1EUeSntkOklJ0xdlj74cKgS2nRfymbMeXSc2ZXa/5URoT14pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114023; c=relaxed/simple;
	bh=RtFoAyLcCQAVrIeloyED9nr4JSNfmYnMtLZOqpvL+II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SILJ9Z3XL9gcGsQL7nPyif7cFx7/9ECcOwRAEYwM0Z+sVzcMJw4fd3dO6+VPi1S9dHJ6qA6dc0r1qyLsCAYl7Ltw4LbIArWTLQWtdV2nJx4TzsxDn6mzV50IuHrqfo5jO9k+yHoeWglqFGOZT4AqVZYx/F3aT9R5Bd5K9ypbKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hcAuZfdn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Ei3VpnwDSCVWbsA8vB5GPAX0gbkybV134bZz1zMqk2o=; b=hcAuZf
	dnkvEJXt3fmeoraiD8cctR5nkr84Zdp+C62+V3Uub2c/pVyz1V9RcGhs63wQ5Uch
	CkeNnTjT0heKbLUNIgPHszaivDWUi+/W2pU4/lUPaTBNoP0pvhyPnMCXPHL1pIgG
	kl/vOZcSQCkEL2TvWBhCrVUsdsUelf3c3cCbJSiXbMWHVClA/9j8kJ06HfX6Q8JL
	kWI1JQh9+Poq0X5RYiD8kz2EJQ0ikRu8mda3NxCE7khD3BsV35EeYsEGzSUugTJO
	dL17Gm4YvZd6ekWqss/98A6Gdox7hbQe6fPR3R2v0GUzE2q0S/8LPHaMsuRHp9z6
	Ln05B0WOT7edNceg==
Received: (qmail 3870921 invoked from network); 22 Mar 2024 14:26:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:45 +0100
X-UD-Smtp-Session: l3s3148p1@/mZuxj8UzJRehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Seth Heasley <seth.heasley@intel.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/64] i2c: ismt: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:22 +0100
Message-ID: <20240322132619.6389-30-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index c74985d77b0e..67c9d9768edd 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -54,7 +54,7 @@
  *  Hardware PEC                     yes
  *  Block buffer                     yes
  *  Block process call transaction   yes
- *  Slave mode                       no
+ *  Target mode                      no
  */
 
 #include <linux/module.h>
-- 
2.43.0


