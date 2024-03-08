Return-Path: <linux-kernel+bounces-96840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB887620F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3762832E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50A55C3D;
	Fri,  8 Mar 2024 10:34:36 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEE55763;
	Fri,  8 Mar 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894075; cv=none; b=GotWKK4JFqwE6AIHQT5G7t7UBZMzBdwJlTt+fhOhlCNuMBMUJTHsqw0Fi3PFHkwdxvthkBCyl4//XkIdw7pInCkdjYfMnXy5JAMcD4GAsx8GuPHvbCZbZn1ek3l+a3KzjjT+yHSadP0a9Jwf1BW+0MNK865Rce0+LjWeET+d6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894075; c=relaxed/simple;
	bh=L8Si9CnBE7auR3o9dfsZriAtTIYD0Jv4aUOcF2/X0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROfMMrtmSUl3aMoQ873eZY/LuX/X78PWgRTuy72YPZSNtuTysHvZRPm2mAvQJIMyeSGyT+ISYcZSt6OAsKqDZSdwpFF73BG3mtaBqkaJrjMidkxFIZujIYyePAhDoDsXWoL0aIfcJMnh/aqOrfxOi+AZYjE8VuhYqlmSDJ2I+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5683247fd0fso327288a12.3;
        Fri, 08 Mar 2024 02:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894072; x=1710498872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XagB2LkBSV5q8D6u6Fwx7UufMS0bw8vTRFIb2KLQwug=;
        b=YtsfScbC4yDafWCM51YUAcrcGuP8YB0AyHCo4+Q3R0U5dWfXoQdUL1SG5Y0byulks7
         uGypgjakUZoLh7wlH7519KVhmaVuU5dbIeYSYcTRJmt9SJq39BaGlzZGC7P/daH/dc92
         ERCsyh062DfVno8zff5yeh/1caOX+Qlx7VU/FDQJloaBeqb+kkvPPSbtEdOAcS+pO8CI
         XwUwRJZBLxaD7eJ8EIySn/hFxyjeotrJVuNMfN52gxsc8ykMWQaQ4nd+/QYN2o54DPoS
         16rIgAtP+H/zkiwJIfXduAsb1KqvJnhKE/iAuUerAG+GaraJKR+qMHi8hpMYDphP41oS
         nLlg==
X-Forwarded-Encrypted: i=1; AJvYcCVK9I7enObfkytyccw3oot6ZZpOCKfs5dLIzb7YuZdno5kVjKZOZ9adI8BhX8nZHOcdNCeDcJOJat14PGRuyikt+mYdmio4Yjy0Eytj
X-Gm-Message-State: AOJu0Yx+wa4z1mqQFKB50l0QThbCf7A5E9hsEl0ehXtf7lwkopE6z0m6
	KIFr70AIVKn2UCjsqDcf+hDB3MBcQ+2OECeDQTO8sB/W+KoJXTmW
X-Google-Smtp-Source: AGHT+IGyNSLodNc0h4ktHrVIEYbbfZTb0oilAJIHPaJ7ue0mB7a++vK8N5tq65PuSeYnwlaBf4byHQ==
X-Received: by 2002:a17:906:c7c3:b0:a3e:34e8:626f with SMTP id dc3-20020a170906c7c300b00a3e34e8626fmr14919878ejb.66.1709894072325;
        Fri, 08 Mar 2024 02:34:32 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906229000b00a442979e5e5sm9133311eja.220.2024.03.08.02.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:34:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	wireguard@lists.zx2c4.com (open list:WIREGUARD SECURE NETWORK TUNNEL)
Subject: [PATCH net-next 2/2] wireguard: Remove generic .ndo_get_stats64
Date: Fri,  8 Mar 2024 02:34:18 -0800
Message-ID: <20240308103419.1771177-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308103419.1771177-1-leitao@debian.org>
References: <20240308103419.1771177-1-leitao@debian.org>
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
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index cb025ba8f60d..0f7ed274fdf7 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -237,7 +237,6 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_open		= wg_open,
 	.ndo_stop		= wg_stop,
 	.ndo_start_xmit		= wg_xmit,
-	.ndo_get_stats64	= dev_get_tstats64
 };
 
 static void wg_destruct(struct net_device *dev)
-- 
2.43.0


