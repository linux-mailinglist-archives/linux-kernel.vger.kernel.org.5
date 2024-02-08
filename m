Return-Path: <linux-kernel+bounces-58370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF084E55A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAB28C916
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9C128816;
	Thu,  8 Feb 2024 16:43:16 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9C1292C5;
	Thu,  8 Feb 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410596; cv=none; b=msSzqIZlzfL/Os2GTgmpAiTVEvQCvaLIg4YnK/b29ve+hZ75ISswnIC+z+y3RPOeZsMafj/YjUYu56ZQk7oUdTiU0Vjp6lCy5DqJSIOa6lOOTBvdGY3sGUUYrONOM+Iousdg2l9RdxMi/Yw19htE/uiOZT7t0XkATTiJXr2T55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410596; c=relaxed/simple;
	bh=0LqVglrwLAXR1KDqMvVxjaqOM4gYG4ayXmGLR+5JwUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cr/ws6iY8FmKGNJXrx54qs8WtVl9jAWIIf80ikmZxm1HH6D1kyDmDzk/U8Nw3t0pJmMgbm0SChYscqs8jcBpnkTZrX0GZucOiFqUAXXlZpBf4w9Kgh96mdF+oAb/LwHq0aSR5xIOznw8rkGBsQpH2CBDCSpYrF8uraxrRD2C+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so94901a12.2;
        Thu, 08 Feb 2024 08:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410593; x=1708015393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F+bRYPPFhjHPPQrYAPI0hogS7J1OqqBB/KqXfkxjvo=;
        b=G/bYnLM+spqCxxKVrBgmlOqPr8yXy4/asr7UmReb1uce8OjYhH9hCrjEFgKd4wiIp4
         UW5ehcUm620caERreULcf3oYbwVE3MXRuyBBaQC/mXSlw9agEfz1gRH8vD+RiXa4nPK6
         a2UNYmZ8pvZNYRruLXwNVad5DOI6M4iH4PQH9fyEnByOBydsKrrS8H5vUZpQMRAdYSN0
         ezaRv8SnuueVJrjZ6tGytUpkK3qGXp6ve5D8IWuitTCiyBQ7BGtxaPOekZHgFXMfYWGA
         chFxWI0kROCFZiF7MGG3VkoGqyvZNa7J27rV8IMI06jBf5QmugyEFqT7cMXE71hu3jVB
         awjQ==
X-Gm-Message-State: AOJu0Yw17Aq0YgwFaQB3TdutgjWYWPt85f1lB27Wqgkrt4TzSsNtTlbB
	IGl9XArIbyPnAjTUaaL1PGoP6V32Z6Ni5Y53DcHUotBSTxSyWwONvj/G4r5g
X-Google-Smtp-Source: AGHT+IFHx0GhI5HD0K49XzVEjIPiyjd8gdkZXd/zEmpRpxOgpA36m0ck8jS7H7ERvs01TeF7+ddtcg==
X-Received: by 2002:aa7:d885:0:b0:55f:1c0a:5c35 with SMTP id u5-20020aa7d885000000b0055f1c0a5c35mr4636588edq.4.1707410593168;
        Thu, 08 Feb 2024 08:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsqQtQ9YQSQZPGetsbJVFsjRTTth7AFDW5lzAuF9oZGI4Pox05D8SqzAdvLLTqsGuRp8yANccNwDGCvlvvKykfEjkIa/sd+Avc8hY9MwFP81VjNYkNNv+UH5acpsD2eT8SnR0GLGnpRdgTadycrI+4+YE32vlaQXqp5Vec0l59n+k23B9uAlvB0nMcaHE+Ph56XL//6PopgZmfX2y+vzdaK+arE26zC67oB08v3F/IbcNFVOqeo5q37E6ga6d/rooN7AUbgGuT3mjltuo13i5Xb7gPN0K3H548f0KEn0nCgMG6dmDPpQ==
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id eg8-20020a056402288800b00560fd0ab2e0sm968702edb.54.2024.02.08.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	jhs@mojatatu.com
Subject: [PATCH net v3 9/9] net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
Date: Thu,  8 Feb 2024 08:42:44 -0800
Message-Id: <20240208164244.3818498-10-leitao@debian.org>
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
Add descriptions to the DSA loopback fixed PHY module.

Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
index 237066d30704..14ca42491512 100644
--- a/drivers/net/dsa/dsa_loop_bdinfo.c
+++ b/drivers/net/dsa/dsa_loop_bdinfo.c
@@ -32,4 +32,5 @@ static int __init dsa_loop_bdinfo_init(void)
 }
 arch_initcall(dsa_loop_bdinfo_init)
 
+MODULE_DESCRIPTION("DSA mock-up switch driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


