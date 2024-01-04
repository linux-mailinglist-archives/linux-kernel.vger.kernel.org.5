Return-Path: <linux-kernel+bounces-16754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746082435F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210641C21DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79300224EA;
	Thu,  4 Jan 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VlA8CZgE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF22304
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso516382f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1704377598; x=1704982398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IisSOi1IhKaF5rBKbPxKm8c6DbGMBvt8EnvrHA2VnKU=;
        b=VlA8CZgE29NnLdqA+aVG5OO9LbumJzjH3gP3nNulHUusebuQNvWJcEwVXDV9qL+xFv
         RCAoIaTbMK5LnZxjcQwwHqbymfq7VMJrVhxHqpJ0fsyNM+61A5HohILOLSd892BfLQw7
         9m72ntY3mBibTRYX54l6wgCkhaBL0VBu4fkyuHi0GtgsDk/HSCyPmAV4Ybh7moc5b43l
         +7gU3GCfrh9M5q49Vx8QyhK4J1wyvineZqAXAOnWTQRokc69M1gpLt9LGvt4xzNC8K7e
         wbuMGkEPUxaZsXFrXsyZixB/elMwLZ4SxBIwwPp/fAbD9g+UuVRCaQt1tGi0izs8ORQJ
         SM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377598; x=1704982398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IisSOi1IhKaF5rBKbPxKm8c6DbGMBvt8EnvrHA2VnKU=;
        b=bjDwk4J8MQlvojpUf5GzWcoidmIlyIjz7RXOJyGMI+OvlJ/Y6QugjFfHAHOayVOFv8
         yZC5TSFt+BmLuUx4Rd9s42Ioa/pc5dkfGbHIPriIYMh7yjD608aVkbYyWrurvBNUy1Wu
         r90GaoFP7ujBvkFLeKohqTwhMgVsWhM+DeppMoTbEC5c9Nzll7QZKc4n5DZ6RdV37m2P
         +RAorF5Sj9ZP56lpBisSkSnQJgLf6rHbaJOHRNHnl+Qa79l5M/XcQoe/HqAju0seo9Yt
         xjA/HxSdiZpzHeFFlRIEKCIE+UAE4J2kZ1BQEw1ocIo7qGFjvZ6yvR7T1h5HH+AvwrNF
         FTCg==
X-Gm-Message-State: AOJu0YyK6icplEzv8sJuG2+vUBI7ah4Iv+rHjQ5qmKicLsFNV+2xTJIF
	G7lpMp2Y3tbT0rG6D8QwXTn3hB59iNGzHg==
X-Google-Smtp-Source: AGHT+IEm4tz6gdfug2cOjsuG3IzEij3flQEhgPvs+mzFp4W0xKI6+Ij+cEszgnjAkOWpomV3E6jeRw==
X-Received: by 2002:a05:600c:354b:b0:40d:91f8:a663 with SMTP id i11-20020a05600c354b00b0040d91f8a663mr401331wmq.23.1704377597700;
        Thu, 04 Jan 2024 06:13:17 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b00336f05840c4sm20324420wrr.100.2024.01.04.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:13:16 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: broonie@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: event: Ensure atomicity for sequence number
Date: Thu,  4 Jan 2024 19:43:13 +0530
Message-ID: <20240104141314.3337037-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the sequence number in the regulator event subsystem was
updated without atomic operations, potentially leading to race
conditions. This commit addresses the issue by making the sequence
number atomic.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
index 0ec58f306b38..ea3bd49544e8 100644
--- a/drivers/regulator/event.c
+++ b/drivers/regulator/event.c
@@ -8,10 +8,11 @@
 #include <regulator/regulator.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
+#include <linux/atomic.h>
 
 #include "regnl.h"
 
-static unsigned int reg_event_seqnum;
+static atomic_t reg_event_seqnum = ATOMIC_INIT(0);
 
 static const struct genl_multicast_group reg_event_mcgrps[] = {
 	{ .name = REG_GENL_MCAST_GROUP_NAME, },
@@ -43,9 +44,8 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
 		return -ENOMEM;
 
 	/* add the genetlink message header */
-	msg_header = genlmsg_put(skb, 0, reg_event_seqnum++,
-				 &reg_event_genl_family, 0,
-				 REG_GENL_CMD_EVENT);
+	msg_header = genlmsg_put(skb, 0, atomic_inc_return(&reg_event_seqnum),
+				 &reg_event_genl_family, 0, REG_GENL_CMD_EVENT);
 	if (!msg_header) {
 		nlmsg_free(skb);
 		return -ENOMEM;

base-commit: 67ba055dd7758c34f6e64c9d35132362c1e1f0b5
-- 
2.41.0


