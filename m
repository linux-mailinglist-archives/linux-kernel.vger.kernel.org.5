Return-Path: <linux-kernel+bounces-128645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970F895D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FFE1C23946
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AE15E1E4;
	Tue,  2 Apr 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHsVQlGg"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D115D5A5;
	Tue,  2 Apr 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088706; cv=none; b=q3O9vJrA2cM2knybP5XofjxckMI/o+cS+c+dRKO6MYJU3stqdbtaNeX01yiSLuaWdYYLqdBjlwDZTyUor5VkFNAezPGyhqnJRvQpjGvQvXTOaOsuVYXK9dA1hm7pTYLRYLkIySx6TjSacLB7vhCDHCuo+Lx1ozsU59VZ3ZIz7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088706; c=relaxed/simple;
	bh=njDoahP8wBLxSZqQxHLlfZVnZGM9S/TED+Bw5MCaVWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVdqS1gw+VJj32N1CRUYXkfg+dlPUb+XWP2cMK+dFyHPK2vvVycHtSoK3+pkLj/ph1sTGxPMJhbN5ah5zn6cmTV5k/b1D74ATd/87wF4CSipbXmEsYmMzHjd3C9z+cw59hoD42F1FwuZ10GUvU0cd5/LpDznHcm3GXCcGRy4VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHsVQlGg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso749385866b.1;
        Tue, 02 Apr 2024 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712088703; x=1712693503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0KS6ydofhsScnfht3viLl5Uv55eEwrxAUcJ+wfOLjw=;
        b=QHsVQlGgXjYH1HcEy7X8gXcmyIQgsoQ3mySf8qn2JVzxApNaj2l7bwlu/g62f0FPFA
         I5NIqQzCSA1c8jiscmcmYh5g+ehaU3rCeIMEdcXFWMQi87W/syVahN19kcGSKkOfN9AB
         JzdGPzj9HWFO8TjaOUXUT94GZK23mhHqu25oMB9bPgrbvVgG+6We2ODNYdJD5zlcv3a1
         1wyBOXsZE9oQTnuVEmpl1vo6swgUw8tm3p+tp/HR6sc7ISjaU8mdz736WKP6RA3Qy6AU
         MLTDUYHEkPqTOaLBzIomu5OvK91Eiv97t8Fk+jqnwPZhU6XlAvmuVHa/3ELyPaDcrvnV
         rrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088703; x=1712693503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0KS6ydofhsScnfht3viLl5Uv55eEwrxAUcJ+wfOLjw=;
        b=H7X1TTh9eZgGnMcpNLBo9K4qHKxRJoeYQpK50AY9H7w96aclLCppuVa1/GdvY+PZ0j
         JGvfIz/3thK+5/UNsIMkCg0r1mDkqhEWeTZDiE/cPtcyrSY+gMNaqZl/oTOJyu7bktjs
         v72hl6WAQWoxS3LhWPSrNjriGNEqQN20OEleBLxPzzPz4KnrYRCGflKrED7rkTo45Bbw
         k349GvbGSiFHiDeJreukmmH/uZfjBoX4vlS+0gGx1D/mnB4aDXvGBCVZyzocX2GiJyFo
         eJRlw5JsG/7LpRYKFhnsmcGgjdT/v+hPpOi1n4GTOTInccaWJm6MhsGdXbnqZ7Pga2SB
         FdAA==
X-Forwarded-Encrypted: i=1; AJvYcCWGev/Wg1oiFUBaenLIKEnpEBZ9dFQZR2XuHFRIjvNC29kfhvi6a4t7cdyr6Ib9nUdSbbLR8Q9c7EgNYUuc9LAHRBJ7AILXuzzYg6EP
X-Gm-Message-State: AOJu0YwZnaPz5fZydQltVcYURCBtL0e5VXkHOIx6C3b7tqeNiNOS10iz
	G4U/TuG2Qkfj7uCiEAgJD2RG4gbsD94bD5fYbgpDi3BtfCdFvl99A7NNimj7vxo=
X-Google-Smtp-Source: AGHT+IHIkEd1n2mtdP7XMIFcy9A8tKM9WltxSInWy9wLMa3WBtkrIOMIO7p5bOPeHywamRq0Gl6MfQ==
X-Received: by 2002:a17:906:2b5b:b0:a4e:60c0:6a98 with SMTP id b27-20020a1709062b5b00b00a4e60c06a98mr521371ejg.55.1712088702973;
        Tue, 02 Apr 2024 13:11:42 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id re26-20020a170906d8da00b00a474ef94fddsm6903829ejb.70.2024.04.02.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:11:42 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: ethtool: Add impedance mismatch result code to cable test
Date: Tue,  2 Apr 2024 22:11:19 +0200
Message-Id: <20240402201123.2961909-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402201123.2961909-1-paweldembicki@gmail.com>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHYs can recognize during a cable test if the impedance in the cable
is okay. They can detect reflections caused by impedance discontinuity
between a regular 100 Ohm cable and an abnormal part with a higher or
lower impedance.

This commit introduces a new result code:
ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
which represents the results of a cable test indicating issues with
impedance integrity.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - added enum description
  - improve commit message
v2:
  - introduce patch

 include/uapi/linux/ethtool_netlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..accbb1a231df 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -515,6 +515,10 @@ enum {
 	ETHTOOL_A_CABLE_RESULT_CODE_OPEN,
 	ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT,
 	ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT,
+	/* detected reflection caused by the impedance discontinuity between
+	 * a regular 100 Ohm cable and a part with the abnormal impedance value
+	 */
+	ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
 };
 
 enum {
-- 
2.25.1


