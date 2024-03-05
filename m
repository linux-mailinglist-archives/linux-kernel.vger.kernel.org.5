Return-Path: <linux-kernel+bounces-92765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E38725AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F0228412A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABA179AB;
	Tue,  5 Mar 2024 17:30:14 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF91643A;
	Tue,  5 Mar 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659813; cv=none; b=lKaGiZv+JI8j1fWpm9jBVSWLMZts2F1GI6PMICfp0VZVgwfoVk4ptqHhMCGgP8bQG6rWnglInEBQ8eV1sskqyMqCkgQJu8/KRuk31zm5iPrA8LVSldAOt97aDYO7HozVFh9OVeTwbvBIVcTybfMFd+YrQaNw4q89a13Q7e/Ysn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659813; c=relaxed/simple;
	bh=ludxbi9ALL5K0z1E3t3o/BEQhQJGn/ohaY9vv2ZVk/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScLYFmALY3+secfvNqFHA1EeN2a2RJvW8L/NMPcHyoCmiknWL0lWQXYECKwrm43R19Qr8BqqQoyLrw9fQmjT3C7vrbzbGw1Ts81AKug9Zhh1rLL752ed4QQaZ4TMXL6stQerxXSt0YbY2QXHX3b9S0SXxLP/dxHymPIr5u54DO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso1294564866b.1;
        Tue, 05 Mar 2024 09:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659810; x=1710264610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5TkMqojTLZpA5UqkaoAVqcHhIBmGns3HqgAQY26vLc=;
        b=tDnuUhcUTKzUYr4n4ePy9ajhrAN4lT21m/cvFjzVPE71b0lGMhHr0CUAWWzGM26xpv
         42nL8dZeHCd0vCNSbr5q8Zrjg8U5l5X/aLjCT/B6XeJGNIdJGQ+HChUBGyNfqknn19ns
         xhJjwQH7zuASTAUzsJ14MJXdX/1SHYDdeRTtQP6yfO7KhxrA+gXPmobSmWThvjHNL/rD
         mX9/BqA7uA6f7W8Xg/GZEmp+12rFThiyxj5KFxkCWf81ugRKwt0a6q3/+RaQT29LYOoX
         myWcPeqxe5rxYH2CMVCgF4oBSBdwZSTW26W++CeTxNt6V0SDAoKaQOVLNmwLC4X8ve+Y
         4wPA==
X-Forwarded-Encrypted: i=1; AJvYcCXkTz8EDN2yYXsYNVQbJsbLHsYNHt/KIkSMV6Q0QedfiqEbzfKtdZwQ1KwUEh9DjUFwLE5bkjlOQ0/xefkeXr2XYkwe6rSxVNtQItHX
X-Gm-Message-State: AOJu0Yw1NtKCN4azrxw2UANTbgTJ31Py9Y+oFhX+eZjZ8sspfMn0ce16
	crgaAN9aRKDm+g2SlC3bvXaUTGUt9EeyLGGdxwUFY3SvfoZVpyPf
X-Google-Smtp-Source: AGHT+IG1Nnz+0eMzPKg51FULw5QqhNSE/Hvg2wjIjit4ehtBwKGdOJ+xLJVjAay11UktcF1a2kbRlw==
X-Received: by 2002:a17:906:2358:b0:a44:2cc3:2ba8 with SMTP id m24-20020a170906235800b00a442cc32ba8mr3705208eja.27.1709659810092;
        Tue, 05 Mar 2024 09:30:10 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ld13-20020a170906f94d00b00a451ab833c5sm3129280ejb.21.2024.03.05.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:30:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 2/2] net: geneve: Remove generic .ndo_get_stats64
Date: Tue,  5 Mar 2024 09:29:10 -0800
Message-ID: <20240305172911.502058-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305172911.502058-1-leitao@debian.org>
References: <20240305172911.502058-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/geneve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index dc88d5600e2d..ff0d7bdaa4ee 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1114,7 +1114,6 @@ static const struct net_device_ops geneve_netdev_ops = {
 	.ndo_open		= geneve_open,
 	.ndo_stop		= geneve_stop,
 	.ndo_start_xmit		= geneve_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_change_mtu		= geneve_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= eth_mac_addr,
-- 
2.43.0


