Return-Path: <linux-kernel+bounces-161938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46B58B5394
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2061B21AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779591805A;
	Mon, 29 Apr 2024 08:56:11 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FD17BB4;
	Mon, 29 Apr 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380971; cv=none; b=pBR2XTcKVq3tJkTurkNhKMEjCuKF9tFboR+nfcwwxldZv3uzPTv5lEDquqOaLf+kTw/A48IlkJ3U2NZLhI8gUN3qcsmyQProU118hcdO2j2XfTOWGMroCz4GO61KcaRUV3C52w0eNA7IiKHE3oHsU0V9sTJSemwkoXH0bdAFnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380971; c=relaxed/simple;
	bh=n30UgSV1qzNHJ8b0nte2dL/KqEDeOoQVGhz9ly56ikw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJ7UfgoIGbShRe2RENKEdw8WCnKbPaogpKOLC1+Xl66ruF0CWthHfJnp6DyN+yO3AC1PXI8wEGNe8CNtgFzeQmB6lQCjrO6vPU61oE2e6rp8jsD0juvnZXs3KXQTx7KyVOjEt541oHSOUadz3+wMXv1THUzg59g4l7bp0HCbGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso6509750e87.2;
        Mon, 29 Apr 2024 01:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714380967; x=1714985767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42P8a0IUByEq2e/patLP18PTczZWOHTFsxOc5Y3WezM=;
        b=LMQ6bmnAJgc84QzxeyTmGzYJq+l4b/EHzd3ypdYYhaboPOe4FCgFlkiDYQXANxfeRr
         /rftTWUyxjHbH+fu8aF17M8KVNfR8n518ppXNo/6XgMyD6yo6X9IDXDr3Ep/RC0O7wF7
         YMP9SokdPMGto5Sg8uSIFnQQT+OXchAKXXVaLcAHcGq+bdtLbG1/P2THeOjd/3Xso/pd
         iiQBk+V0dxmOuyBly1KWqL6uCtMjytITvk/ktJ7n41uHV6YRtytiEKfciQHAmB1djfAd
         VQJr7secmFOTFi//gbskuHrjXXfNaWkpV34tkRSFmGokcV3fEGQofoVWtBNtO94nHzLI
         NG4A==
X-Forwarded-Encrypted: i=1; AJvYcCVu1RQYC0WNp82gqJunAhi68lSVhloyEGIn2l1aOioI6lhao6UIEUHkr/5YoEGOWfd7B9ip0TTFD7P4uuN3rHU5YRA2SgLSdqg84FtbTvEuOuCK0i6sY2WiO+0oWwq5CUfWSdyC
X-Gm-Message-State: AOJu0YxfycMva69u6Vru/eZgkSZxOrmMWCnH/oh5ait/gZQWpIn4ezQr
	JNfG9LdD3t9SX7cXkuD8fnEhSIhDMjB7xaxPE1Xl8ISGcFgior8T
X-Google-Smtp-Source: AGHT+IG3f/cLozETnEYH5jic5ZXorevBtIrIoPSpZIwUNaNbuJGlI7FdFyZTjt18QbaEx7EI3Hcelw==
X-Received: by 2002:a19:5517:0:b0:51d:4c8a:bbdb with SMTP id n23-20020a195517000000b0051d4c8abbdbmr3768447lfe.3.1714380967255;
        Mon, 29 Apr 2024 01:56:07 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm10995436ejx.107.2024.04.29.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 01:56:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: loopback: Do not allocate tstats explicitly
Date: Mon, 29 Apr 2024 01:55:58 -0700
Message-ID: <20240429085559.2841918-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the loopback driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/loopback.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f6eab66c2660..2b486e7c749c 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -141,9 +141,6 @@ static const struct ethtool_ops loopback_ethtool_ops = {
 
 static int loopback_dev_init(struct net_device *dev)
 {
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
 	netdev_lockdep_set_classes(dev);
 	return 0;
 }
@@ -151,7 +148,6 @@ static int loopback_dev_init(struct net_device *dev)
 static void loopback_dev_free(struct net_device *dev)
 {
 	dev_net(dev)->loopback_dev = NULL;
-	free_percpu(dev->lstats);
 }
 
 static const struct net_device_ops loopback_ops = {
@@ -191,6 +187,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->header_ops		= hdr_ops;
 	dev->netdev_ops		= dev_ops;
 	dev->needs_free_netdev	= true;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_LSTATS;
 	dev->priv_destructor	= dev_destructor;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
-- 
2.43.0


