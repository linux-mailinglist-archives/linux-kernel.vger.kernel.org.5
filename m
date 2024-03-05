Return-Path: <linux-kernel+bounces-92347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD5C871EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1CEB24734
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0D5CDE0;
	Tue,  5 Mar 2024 12:15:39 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235B5A792;
	Tue,  5 Mar 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640938; cv=none; b=HRFPws1MFSPBUsMXiYg9sMPuuEsb9w15IgfekjV6OE+qe/eLP7OiZ5B3ss2E6ManfpGJM0gEnjqS4L7zRrFEmdrJnsEuLsfbub2yCZLy/ccbWenl+1kdX3bV+8skAm2+aQBEJqB1FM5qQ8WLPfj1NIxnNYBgYLHG9u7ylmv3mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640938; c=relaxed/simple;
	bh=woWMYc5OgL+cBIbSw0Bp6OpF6hwqiIc1KvuQj/MhjT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6b/hXtIl+bObCZBkOap+fd9dMnb7MQfsHCvxtu+m/hy36DQ+frr8pfSoox9mGe1cWnF5b3IcZHrBLu2g+EbD4VM8rwFCM8O2LD2YDVkZ6gqpuJod0h4lmA12b4znDwI9njCtIyWLed+X72MF+s01V111sj4EaEqrKFVyIYane8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso7247506a12.2;
        Tue, 05 Mar 2024 04:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640935; x=1710245735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73oxC7fiTEx14ckkL7VJ6pLMLA9f6p7sprpT+joqmVc=;
        b=u97pXZfNqdZrVQzEVJKffvkxO3Gxyzq/50yTZThXDDI1gi7V9I0fB4klsXT19aqt2N
         vOaQIoKq5PwaCfoz+WRqkOG7nOwwVkUq8zMcdU+O0v2eboUqaRXmHarOlRI9WJGjHaKc
         2ukCDuhNyDhdJvA23Zv7tDHJM+vpRQQ6GzT6CkP/MrGbE/IRHdTBq6hr78uQtDxFSDWU
         BZySVFPHUPAAMD5NJyyjg54l8KsOmK+EaHlI7RhGYz0Y7BfSMZ5gGF5a4MiBIuTJKltm
         nSb1gHRtFSSHat0sBQSvcNNdGGweo9DwbtuTsFIcr3UIa+qqRVv+Uqi3SELMQzzw5zUY
         +eiA==
X-Forwarded-Encrypted: i=1; AJvYcCUzQpjz+HLm9sio43N2+MIwx4fpyBEcaBUkBFnDe2tzXQUv4dU8Ya/WvYDBHBrEr301PJ75Me3BgHkF9gxa9n6pPgafhqK4wczRO3og
X-Gm-Message-State: AOJu0Yxt9/ROvuEC1Wz0cSq2WQEUv0owieXdsrD14xAPrV/0YEI7bcfB
	O6dNpzusVdItNifOtKnSiDXlKqNlMvx6YuDG78h0z2iK4HmBWGKw
X-Google-Smtp-Source: AGHT+IEgZP/25f03fXOd6Z9uDpCifrB6YeqYPf/fSwLvjFuOevo4KNmPHtiLcHQMRiGqrIZxE03Bmw==
X-Received: by 2002:a50:954c:0:b0:565:8339:5753 with SMTP id v12-20020a50954c000000b0056583395753mr6511550eda.40.1709640935115;
        Tue, 05 Mar 2024 04:15:35 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d9c3000000b0056629f5de88sm5707578eds.61.2024.03.05.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:15:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	osmocom-net-gprs@lists.osmocom.org (open list:GTP (GPRS Tunneling Protocol))
Subject: [PATCH net-next 2/3] net: gtp: Remove generic .ndo_get_stats64
Date: Tue,  5 Mar 2024 04:15:22 -0800
Message-ID: <20240305121524.2254533-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305121524.2254533-1-leitao@debian.org>
References: <20240305121524.2254533-1-leitao@debian.org>
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
 drivers/net/gtp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index facbfba5d77f..a279f0cd1b4d 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -940,7 +940,6 @@ static const struct net_device_ops gtp_netdev_ops = {
 	.ndo_init		= gtp_dev_init,
 	.ndo_uninit		= gtp_dev_uninit,
 	.ndo_start_xmit		= gtp_dev_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 };
 
 static const struct device_type gtp_type = {
-- 
2.43.0


