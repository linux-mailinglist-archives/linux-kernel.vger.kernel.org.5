Return-Path: <linux-kernel+bounces-138399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72689F0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0751C224F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93915ECD3;
	Wed, 10 Apr 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LndvGka0"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52115D5D5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748319; cv=none; b=UG7g6qaehJbdaJdeu49VNf+r08oDoEMdHvkssAlRiYCbP1B2XF3NsQPuzNueuxjzTgXH12AIe6aZ9OGmx+4DoytFuTaLfcPsNyvfpTtPoTJpTgojQTFCGboyeZ9dJoinci2F31INpcE+SFMoMBAmRJgyhM+nKLkQwVR1VLMgYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748319; c=relaxed/simple;
	bh=xQvUs1HAINisoxCUqYyynmQYCCX1o0BOa+VKS52/pn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACBz1ebSQ3y8ojxoH6A2zb7mYsI5RhHY1v698wetkJ1Uv5Ef890tjqF8mKjfVLITuGI5WlvBmwLcY8kOhwAe4tUBixZrx3h7rFYqoyqCLvVRJVtJskQqbcX6QdrrtrJ6/VgfvVBGrwMHdX8wOAp8r4qjZXIWqfMxkC4llj4BrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LndvGka0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=NWNvhOQ1P1l2OPQ/ikbk/yVi9ub/Dsp7Etl7kO7Xtms=; b=LndvGk
	a09V581tPWlWHw0Nn3N/rn2lMHLvDSseKEe/RL8R3wS7xyMWuNxZ+yfs/0pfsSny
	rTNWkdh//T9P7OK1KhPmr9NOTz2tPhCStjoqeldajfBIgwHMoBz2CWDzyOpmsSDB
	9kUKl/aTVwj3bTzsTx5b6igiXvJ06zjliEa8JhkuVxo/fs+Ct664NUFbikR6OVGh
	CN/NKSAMRgAm+9KSZuPBvJJVHaYxIH3vf4jsYdN6HvRV8DEIEhtefH6JhWUux8Ko
	RqwaET2H0+KEV9xPKTAjTkpNXgygoit4zgL/md4dN6SJndDlAUPCyIAcX37DFPzw
	dQPg4Z31mECCwYxA==
Received: (qmail 521623 invoked from network); 10 Apr 2024 13:25:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Apr 2024 13:25:09 +0200
X-UD-Smtp-Session: l3s3148p1@ndCNSrwVqwhtKPEL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tony Lindgren <tony@atomide.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] i2c: omap: remove printout on handled timeouts
Date: Wed, 10 Apr 2024 13:24:24 +0200
Message-ID: <20240410112418.6400-30-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
References: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C and SMBus timeouts are not something the user needs to be informed
about on controller level. The client driver may know if that really is
a problem and give more detailed information to the user. The controller
should just pass this information upwards. Remove the printout.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 42165ef57946..36bebef36740 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -752,7 +752,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	}
 
 	if (timeout == 0) {
-		dev_err(omap->dev, "controller timed out\n");
 		omap_i2c_reset(omap);
 		__omap_i2c_init(omap);
 		return -ETIMEDOUT;
-- 
2.43.0


