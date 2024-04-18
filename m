Return-Path: <linux-kernel+bounces-149940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F408A9816
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E767E1C2120B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8015E5A1;
	Thu, 18 Apr 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Zj8lifKr"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EDA15ADBB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438137; cv=none; b=jeTKeI2CVH6FrjCup85gd118Nc4qeuXdBSj2zcemJ2Je5Y7SkjKQrlSKPwmF4irUWskJqv4gLp/gf5n3NVgOBajndWhgxxWXfTI74sDVXL8pnEAoVgoeOcwvq0UGEBH0JbdRoN+u5E7PBB8nHD1HjjkqLXfQBCxu6cxpxq8tMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438137; c=relaxed/simple;
	bh=F/TmGD6P/eBNZve0CmXoI/nVfjo5Bnc9S/wABpwztCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lg3VIlOa2SCFOdv85LDrgSpgofvE6oxaN67Ukfd+4PTDmYH9IKypUbaXm7uIocY0BeVxMZHTZ4qpmSpy3sCUU1eJGiC6znlimZM6bw1vLRqgUlYmyYPNU68N/p32rvCZv+tkxmuBMn8Tl1KPESZ6CyJTgUGa8yEkj5YimFiK6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Zj8lifKr; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 335553F8E5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713438125;
	bh=AOGV+CBOV8eiaEz1GoNMtohBk1/aB8bFkBW7cPKL6oU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Zj8lifKroqtWPZeSBTFG4xaigDMSFk61lNN+TOQ0/qFH3z1Oj/URB1PrWQMhPXRtB
	 zcfP4aqo+MUK9qcRCaGsOATOPQq9Blkui7OGy0VZQjSHxFwyZlEADMaL7al0Vct/is
	 KWIdz2OAJdoXhagsJh8l9zto6OipzSxaUGE+eoHJFmufUaKprT9FHR5e33toSvOhE0
	 0k/ZXV8hBfBhyWMfl/ZkNI5yqxJ5Cor/c1swZI08G3Fpo77xeToW0f39Ea7TcJdfPS
	 8Z5oK0MKV5yfvSbKF5HGZ14U9TXhqEJAkITI2JkFNkml9QVs3uviNM+G7E+iqHl2Qv
	 HsEmItHmaeaOA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51c03c9b8bso25739266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438124; x=1714042924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOGV+CBOV8eiaEz1GoNMtohBk1/aB8bFkBW7cPKL6oU=;
        b=GTPvpZBTyrgXJZcXhJPiwhrCtHmQLvUrrlQm9691zesWAFyzygRsZlLwC7SHf3MZWw
         6ZzZTn7FMCfvnjiYd20IFEVh4C5SsH0TWavEU3k5r2C8iHBct3wmONPEbbBwh5PrFy3p
         w3ufjQGMlG1cFuU8y9ZVPScsJtEBjszx3Xfx+uNoPUVYgRVjwE9JdJR6xUmO8OHgR7wJ
         jldm3GEZ1j2YMuKnYoKCrFGJyZrG0b8DbMCrfIQAsvLadFX9WNSKHmshqr8rcB795dQ/
         BF0FDD73+NJT75XOAulcwGbOtwXv+YaasbarwpeSiYEtXFOdDeNf3QnjZqi64TH+hALQ
         9LBw==
X-Forwarded-Encrypted: i=1; AJvYcCXcdWppfmgIeiUNvvNBYGZANCHg1FCYeIVTqQjUq22YEiYQkIyYZU8Bm+ytEaxQP56hZJAQTMQXltsIb5liv/MKqCFVQVX3RsWvlYTb
X-Gm-Message-State: AOJu0YzLfttbZAbcGwZc6mh/1dz/JX1GvAF+ubDWO7zzetODfizHT559
	g8W6pwleC/nl9M4UxaMWug1huSONnX4MZg7R+jXlY/yDua37E1TYYzgD199/MfijbUuZ6JNufq2
	koMtzii+WmNQHvZTDNi5yh3DUxrIZELS3g/bhG2WWHWwPi8kQr+dt1YuzndfAm8N3p/yjXNp611
	pQWg==
X-Received: by 2002:a17:906:5a8c:b0:a52:5a02:2432 with SMTP id l12-20020a1709065a8c00b00a525a022432mr1500555ejq.50.1713438124766;
        Thu, 18 Apr 2024 04:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK0FFwqxygVS/MakVnyy4i3LBAXhMuv1GAxCYpN0cDVcZFrxU5v8w8WwAoL/TOLrTzl1iuHA==
X-Received: by 2002:a17:906:5a8c:b0:a52:5a02:2432 with SMTP id l12-20020a1709065a8c00b00a525a022432mr1500533ejq.50.1713438124401;
        Thu, 18 Apr 2024 04:02:04 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:320c:9c91:fb97:fbfc])
        by smtp.gmail.com with ESMTPSA id yk18-20020a17090770d200b00a51983e6190sm728594ejb.205.2024.04.18.04.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:02:04 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v2 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
Date: Thu, 18 Apr 2024 13:01:52 +0200
Message-Id: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..daa62b8b2dd1 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 {
 	struct sysinfo i;
 	int availmem;
+	int amemthresh;
 	int nomem;
 	int to_change = -1;
 
@@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	/* si_swapinfo(&i); */
 	/* availmem = availmem - (i.totalswap - i.freeswap); */
 
-	nomem = (availmem < ipvs->sysctl_amemthresh);
+	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
+	nomem = (availmem < amemthresh);
 
 	local_bh_disable();
 
@@ -146,8 +148,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	case 1:
 		if (nomem) {
 			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+				= amemthresh /
+				(amemthresh-availmem);
 			ipvs->sysctl_drop_packet = 2;
 		} else {
 			ipvs->drop_rate = 0;
@@ -156,8 +158,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	case 2:
 		if (nomem) {
 			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+				= amemthresh /
+				(amemthresh-availmem);
 		} else {
 			ipvs->drop_rate = 0;
 			ipvs->sysctl_drop_packet = 1;
-- 
2.34.1


