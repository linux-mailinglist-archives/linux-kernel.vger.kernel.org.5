Return-Path: <linux-kernel+bounces-10125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D01D81D094
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CBA1C22449
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9E364A6;
	Fri, 22 Dec 2023 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNhBkytS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BF35EEA;
	Fri, 22 Dec 2023 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1786096a12.3;
        Fri, 22 Dec 2023 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703288643; x=1703893443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2FndYqF4JacU8fr/QFMFiLxqaWYLpyTNAQDkJcL8Ws=;
        b=TNhBkytSVr2RAqmpyLoK41pAC+VTdQ+7K3KYb32Y4wcJZrRRzLvl1mqCdovbZLK4yZ
         o7dX0YPkluypsYyVkZBDOZcJYCZaHG3jDAtSf/ajOdU9BFkrZkpuKvYnMbAz6efAkDke
         r6yMZdd2WDh18zCBPgbnZriwfZ+q3wtTFlbWVLwN+eq0FmwH+p49x1K+DtUZtrYNcvlY
         3rclld21S1+F6QPG2f2OHnZRan5yKKWi85npMbDlZ9RgnMCvgZREDhPSW7YweGcSUTYa
         Y2pi5wIJ6QGgPcJBIw//ozHniZ9eVgVXYxrFhGeFg+QmAZQ5ld20EZfBEwKefEbVsfh4
         LPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703288643; x=1703893443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2FndYqF4JacU8fr/QFMFiLxqaWYLpyTNAQDkJcL8Ws=;
        b=U/1If1hqJf1eqHaex0WsC3CRUC3gW8hz7S+yRQtlRlvq/u9/hGFKnmLU/ZpLVxX5Yf
         C1nfZCHF7TbslUkf6yC84bu7qojkPlCcW9ViUAYq7X987qkpN1GNu1Fv3feFbdwjRbJB
         hsTMnO/iePADBgBdbaHLRoziQdFroQFu9v/GjWv8M5Jqr8QdAUk91OLHZAtICqDfSOXv
         Cz305ihSiHkZkh1Eylahu9KwEefDddmKtnqmTrXqbMW9zcVZkmQwkYTIG6svEJcTIxo9
         VGy0c5el8lO9xz/eIy6lMkLpPbPcxPuMu/n6CfwRsUguWYH2zR8BlA/i/tzNoXddoyMa
         RLuQ==
X-Gm-Message-State: AOJu0YytMiK3z7VDv9a9T9JbELZ6IzaS6PnZUyeE9CJK/KR+wU3n9bk2
	onIwW0bL4XwxvgjTi621BdI=
X-Google-Smtp-Source: AGHT+IHeR2KoMp2csOplwLZQeHOaF3yN1rH3e6Rhb3xbBEnPD2hZ8nqLPPqguA64P4E77fLaMA9gFQ==
X-Received: by 2002:a05:6a20:8407:b0:18f:97c:8a2d with SMTP id c7-20020a056a20840700b0018f097c8a2dmr2161275pzd.88.1703288642952;
        Fri, 22 Dec 2023 15:44:02 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:b835:c8f0:af87:712f:cf12])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b006d98222b74esm2326427pfi.46.2023.12.22.15.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:44:02 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: dan@danm.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bagasdotme@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net] net: ipv6/addrconf: clamp temporary address's preferred lifetime to public address's
Date: Fri, 22 Dec 2023 16:42:28 -0700
Message-ID: <20231222234237.44823-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222234237.44823-1-alexhenrie24@gmail.com>
References: <20231221231115.12402-1-dan@danm.net>
 <20231222234237.44823-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 629df6701c8a ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
Reported-by: Dan Moulding <dan@danm.net>
Closes: https://lore.kernel.org/netdev/20231221231115.12402-1-dan@danm.net/
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2692a7b24c40..37141d3417fe 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1337,7 +1337,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	unsigned long tmp_tstamp, age;
 	unsigned long regen_advance;
 	unsigned long now = jiffies;
-	s32 cnf_temp_preferred_lft;
+	s32 cnf_temp_preferred_lft, if_public_preferred_lft;
 	struct inet6_ifaddr *ift;
 	struct ifa6_config cfg;
 	long max_desync_factor;
@@ -1394,11 +1394,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		}
 	}
 
+	if_public_preferred_lft = ifp->prefered_lft;
+
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
-	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
 	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
@@ -1414,20 +1416,34 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 *     particular, an implementation must not create a temporary address
 	 *     with a zero Preferred Lifetime.
 	 *
-	 * Clamp the preferred lifetime to a minimum of regen_advance, unless
-	 * that would exceed valid_lft.
+	 *     ...
+	 *
+	 *     When creating a temporary address, the lifetime values MUST be
+	 *     derived from the corresponding prefix as follows:
+	 *
+	 *     ...
+	 *
+	 *     *  Its Preferred Lifetime is the lower of the Preferred Lifetime
+	 *        of the public address or TEMP_PREFERRED_LIFETIME -
+	 *        DESYNC_FACTOR.
+	 *
+	 * To comply with the RFC's requirements, clamp the preferred lifetime
+	 * to a minimum of regen_advance, unless that would exceed valid_lft or
+	 * ifp->prefered_lft.
 	 *
 	 * Use age calculation as in addrconf_verify to avoid unnecessary
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
-	if (cfg.preferred_lft <= regen_advance + age)
+	if (cfg.preferred_lft <= regen_advance + age) {
 		cfg.preferred_lft = regen_advance + age + 1;
-	if (cfg.preferred_lft > cfg.valid_lft) {
-		in6_ifa_put(ifp);
-		in6_dev_put(idev);
-		ret = -1;
-		goto out;
+		if (cfg.preferred_lft > cfg.valid_lft ||
+		    cfg.preferred_lft > if_public_preferred_lft) {
+			in6_ifa_put(ifp);
+			in6_dev_put(idev);
+			ret = -1;
+			goto out;
+		}
 	}
 
 	cfg.ifa_flags = IFA_F_TEMPORARY;
-- 
2.43.0


