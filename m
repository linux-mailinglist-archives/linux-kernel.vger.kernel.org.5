Return-Path: <linux-kernel+bounces-133776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D750689A87C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F01F21E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984314273;
	Sat,  6 Apr 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUHAg9fp"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDB748A;
	Sat,  6 Apr 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712371785; cv=none; b=t0yEgt0O7m+s8SK4coxrzSQKT6h1DTnDHDeSMqJs2yMRrHQXuhtw2P4crsrjH3X1Xmm3SbXbfgZPtrNuzAwOcENg2Yj+guQF8icJ6X3T5yCY9P1knAO5xgssA7tJF7nt1xR4bxknw9HAHNPZ5zGbM157Sf5IwvouYRctewFbP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712371785; c=relaxed/simple;
	bh=A09mONBJ+iQN0Aw24fomMHxPe22XFN2PHAOTkXu0xuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWZMRO57klBGf4JcpyWzB3QytctuVdoeRoys3amzOkPcvx5oVtIrrVXDYmZOgZi6mI5jgyvzZsgU3e5IEmsVvU9k4xKLUwx+xKPapkhph7hFvRYMq01pfXqxqeNAJJRwUxCCmWCvzgqDEkGlRjLujKF6SSFR/hTk3M+IZEbPnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUHAg9fp; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4f608432bso1752776eaf.2;
        Fri, 05 Apr 2024 19:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712371783; x=1712976583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5ujRaHA5VATDiuhfq590DYcU4neBIRjVwQ6U7oUACQ=;
        b=jUHAg9fphvR8vmetdtUtK6jfxjVV72C1oYpDn8xVKCDik3YBJ9PR8Gk9Ms1yQcVLPE
         AV0y9C7QlH2+KsUX4U/9Hl5PGu+q9ZFRszpB+9QCeCc4aZtBXxW22d3ER5Icr9lb4k7P
         8w0WWWZm18Fod6ZZApT3/7B40LBakHXivs6TZmwwIJAVfg1GhN0d3AwOzKVpfChlzbWA
         Lnkcvad2Ijs2w0r2GhfImsz1S+bqCo3EWk7pWE1X/O7NZgbfUHMafRWQSFhxPBn3T16A
         PkH1vRjQQTCHfot9F6hUQvZC1FG6e9fZUOgwK9ukO8M39F8vtCxrycvGrlt68xwjoyIR
         4aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712371783; x=1712976583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5ujRaHA5VATDiuhfq590DYcU4neBIRjVwQ6U7oUACQ=;
        b=TMSgBc+0o5EVfs5oRWgFJyovDz84R0GAkbUxaNW4Ib/Ged9juVeXBQqTEQJA8DNT2Q
         IxygGDNBTwQ6izP7rjS8EajrQZRs8p3JRBpUlMZRZdpiQdMZVWfAKTlnCjWh9S8/Is5u
         3PWUPLIjdz846rlbS2q1FH3pUZ2o5iFYj95XaDZn4jMy+GJMdW0Q2JjH2biIF2Y7aazi
         tHH6LZ/RryGFkmW5i1B/DD0H5GDW5AAbcPE55YIbm/qn2z4JSnvwNqpLlkX693LEoOw0
         Bh4yuuf8m6ITicdx1sjE303wO/VKb9Y+S1MXVhyWVNe/ywiapIEN6lXQ2xws224dH+Is
         53Aw==
X-Gm-Message-State: AOJu0YzKBW1u7tybHjtT7ZAFyP4DL62Gnf6N6sbRvmBHWZXapLXeor3p
	6ig3l5kxcnYar9W9LI+E+yeW+dAR1tbeUUMkd/hzeVZJbzuCWdQSBXxKgdT1NuY=
X-Google-Smtp-Source: AGHT+IFNc5kXWtQj21j6h2K8CVznxdxDTZr8pXjwemXOTlUDxdX/pqmIrubXfyGlL7YJWZe7/1R0Eg==
X-Received: by 2002:a05:6808:16a4:b0:3c3:9b96:9f3f with SMTP id bb36-20020a05680816a400b003c39b969f3fmr3465835oib.58.1712371782961;
        Fri, 05 Apr 2024 19:49:42 -0700 (PDT)
Received: from my-computer.uh.edu ([129.7.0.144])
        by smtp.googlemail.com with ESMTPSA id i20-20020aca2b14000000b003c3d1b47532sm467321oik.49.2024.04.05.19.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 19:49:42 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Thinh.Nguyen@synopsys.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] usb/dwc3: replace of_node_put with __free
Date: Fri,  5 Apr 2024 21:48:38 -0500
Message-ID: <20240406024838.537630-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this relaces instances of of_node_put with __free(device_node)
in drivers/usb/dwc3/core.c

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 drivers/usb/dwc3/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 31684cdaaae3..795a572d46cf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1762,7 +1762,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
+	struct device_node *np_phy __free(device_node);
 	struct extcon_dev *edev = NULL;
 	const char *name;
 
@@ -1797,14 +1797,12 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	 */
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
 	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
+		struct device_node *np_conn __free(device_node);
 
 		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
 		if (np_conn)
 			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
 	}
-	of_node_put(np_phy);
 
 	return edev;
 }
@@ -1915,14 +1913,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
 	if (dev->of_node) {
-		struct device_node *parent = of_get_parent(dev->of_node);
+		struct device_node *parent __free(device_node) = of_get_parent(dev->of_node);
 
 		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
 			dwc_res.start -= DWC3_GLOBALS_REGS_START;
 			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
 		}
 
-		of_node_put(parent);
 	}
 
 	regs = devm_ioremap_resource(dev, &dwc_res);
-- 
2.44.0


