Return-Path: <linux-kernel+bounces-58369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4F84E558
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D001C26718
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21C1292D0;
	Thu,  8 Feb 2024 16:43:15 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12B128816;
	Thu,  8 Feb 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410594; cv=none; b=KjLUuIJVFOXMum+o1G5d79livC9Lj2b+k6Yk84/6H6eRRhtTzk5rjQ9JCLpu4/eDWuNx72zSifo7gY0NjwHJXvcvXzjy6OMgUfsb3f1dLeahsr5fIDrytj1JPmITToGdeYXbVN5ryWSx5T1ZIKDmiUMtim3S1EFb+4rB4YZ6XJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410594; c=relaxed/simple;
	bh=8mP8astqtJqpia44RRtFzQYcQ6+L5QlylAqv3H0F9xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb9LOrPj7AZVWrXplxA+Lvw0VAX9/h8LDWLXu4O/tX9v5X3jT2+3B0hMLbMRN2MxXhNluQ7Yn7rkckZoOXvvZsqnUq/ygvUVsFvoppUXd/hl4XW7uVY1liA7huxwZ2qUk7I7FE5D+Y8ebXWP/5TXfuiQTHTSOGuQCL1Bza/ozds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a30f7c9574eso269760066b.0;
        Thu, 08 Feb 2024 08:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410591; x=1708015391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpk8jvs2rRVq1PenNhzwTtttLBg3zjDZdyaMLWTXsRI=;
        b=Tw7Shy7296hGXaNmWq/1+w4pSsAWLjMX9hZ04j9RLo0uYihLhRjinpNnvhpEkhcGN9
         Pp0IvDyXz6c0fwU5w93fIL7TUiJBz2bvPiFr3snCU21rrRP21AXLmX/rJJHeb+4oOaG6
         f9MimKipywMZ4GSlXYZxR2DDmTupR7wgCo9oFBiSZZhxiGql33qj0TVgTvsnwXn6u2Fz
         73kIPYO2Xj5svAloW0VzEmEoPuSA1p4toZh3mUzVWNaVT34lhEmL1CA7ziviI2grjTPA
         1TG1mexzLQ+O2avZPqmfObBjvDvBqANFJUGekpZzZChVCKvYUQp71IXUObDArCMUk8xO
         PcGg==
X-Gm-Message-State: AOJu0YzZsNC050TDjYO89OIYY3xH3fUJscivdBxQQ0Z35anxw5rb/cXb
	11BnCTySGw/g5+2rad4nVc54Nf9vu3YkvDvRkONFuOHAhB0J/5iC
X-Google-Smtp-Source: AGHT+IF222H3nS+NfyeT8KUj4OLcNe2RRAGThXVZkI4UMeB6nlgcVD7DGhO8DlMrOohCRXKNJtPELA==
X-Received: by 2002:a17:906:dfe8:b0:a3a:510f:97c0 with SMTP id lc8-20020a170906dfe800b00a3a510f97c0mr2110855ejc.61.1707410591544;
        Thu, 08 Feb 2024 08:43:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUyVtp2UylkPY9/c7AzgAuEkUPlBbM3r614XBYbF1guE79B5f+1YRxQNqFUVKzmzSQE0mTbag6h8Qx+HPpbq5A+um9R0MrZswVl3ErsIx0gD0gf1cv8Q7uXzxsR+9ZVfA5QusNmMBplhx1d84uMp63QkWYNsRSht+z7PrHyWnFtInHofYj90UYoR5qdWbeZUE6wvIFkggjL9maCOGdcsB8CxFOd72IjxZ67MXPp/tek+NvbxLM+wrz1BDFqudwL6ni2TOUM/f0zSagal2OAOkMaJu/KtBaokaP7TKD2L4HM0hEUsXxDrsfZtiAiHBpoA==
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id u14-20020a1709064ace00b00a34d0a865ecsm214517ejt.163.2024.02.08.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net v3 8/9] net: fill in MODULE_DESCRIPTION()s for ipvtap
Date: Thu,  8 Feb 2024 08:42:43 -0800
Message-Id: <20240208164244.3818498-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
References: <20240208164244.3818498-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IP-VLAN based tap driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ipvlan/ipvtap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 60944a4beada..1afc4c47be73 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -237,4 +237,5 @@ static void __exit ipvtap_exit(void)
 module_exit(ipvtap_exit);
 MODULE_ALIAS_RTNL_LINK("ipvtap");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
+MODULE_DESCRIPTION("IP-VLAN based tap driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


