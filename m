Return-Path: <linux-kernel+bounces-34004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA68372AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE89DB2B235
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A45D74C;
	Mon, 22 Jan 2024 18:46:21 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B25D72E;
	Mon, 22 Jan 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949181; cv=none; b=n0BLXbZF+Een6evXgOuH/Y5oxNv69Wtfw87iVhAA4UHZ2sqlVErutJMVrfOi1dKt578FJ/HeuZySlO8Qo5yugIckdq1Y8sgB3EjsSGRJk6psDYR/7D/mCGue4yr/oeCQyswudoiEp8N3q4mcLv8xeLgPyjwBz6t6lBBs3rqcltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949181; c=relaxed/simple;
	bh=otC0oxYyfZVPzZX/zfwI8stSIJHDGA7ed6/sdnWLpD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyVauOseBfdn9OKRHlQC9pEBf6eIfUKrBLKfMR5LN6y/WvE225xKmARz2TvIv/UJKWkQvmxiY+3+Rrx4uh3hK3e5TRs+4e/z4rDp7wrAYzvCO2gJcK/v0NQ8CyddvcEJgyZBe7MJPexc8g1fnl0VMsziGV42l1G2Sty90aEmFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so3707128a12.3;
        Mon, 22 Jan 2024 10:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949178; x=1706553978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFgt0ozQbjnWYH5i2XF8dhHsvqD/EPeO+LGoxd7oSiw=;
        b=mXA+8qW+XW1ap4FlIngSn0f1UxAhYSgsRRr3VRXcSUnxjk58qElwGJLnIBZ6p9Znku
         RaI3lw5XyVsP9SQMdFbHszgpX6Nz5h+7p6GuBAvWNKvE7Iy7EdM20+El2kY7op6n1lm7
         aqYqo/ySalHQQyoHLHZOcf9AO2S98aZUxbL9GFi2UAIQ7WhemynzEAunIW0RGeX5XyhZ
         Wv7cWcNNoQjnKb/+rN950njAtVozu+inkJMwVX41SoFFE154uExiK6IhDLcKQICvcjg7
         KC/hkdh5jljSMypNY1hfGyn5ofQmpVrRG4EHXi2zGmGsoqU2TjwuzsznWpLmnk2rBC64
         /Udw==
X-Gm-Message-State: AOJu0YxLZ48uH2769yAcmKkwkyqJL7rh/tyzviUkf5MsPn+RQz5exQh6
	HcLggVy8eS1w9RHvAWxYe09EcoPg07Jc7WFx26xPQI4OxR+tUY+d
X-Google-Smtp-Source: AGHT+IGIkou9QnryPpz+vRPDO+hr3ow5esx20rM3txVr/gZq9i74UVDxo11A65nkzoncxt50dz3G5Q==
X-Received: by 2002:a17:906:33d1:b0:a30:9c4f:5008 with SMTP id w17-20020a17090633d100b00a309c4f5008mr281253eja.37.1705949178153;
        Mon, 22 Jan 2024 10:46:18 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090666da00b00a1df4387f16sm13673849ejp.95.2024.01.22.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:CAVIUM LIQUIDIO NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 05/22] net: fill in MODULE_DESCRIPTION()s for liquidio
Date: Mon, 22 Jan 2024 10:45:26 -0800
Message-Id: <20240122184543.2501493-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Cavium Liquidio.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 9cc6303c82ff..f38d31bfab1b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -27,6 +27,7 @@
 #include "octeon_network.h"
 
 MODULE_AUTHOR("Cavium Networks, <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium LiquidIO Intelligent Server Adapter Core");
 MODULE_LICENSE("GPL");
 
 /* OOM task polling interval */
-- 
2.39.3


