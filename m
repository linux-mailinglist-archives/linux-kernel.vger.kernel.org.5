Return-Path: <linux-kernel+bounces-78260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22B8610E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8CA1C2259E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5F7B3FA;
	Fri, 23 Feb 2024 11:58:53 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDD7A71B;
	Fri, 23 Feb 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689532; cv=none; b=hnutTX9iOA/Fr7uyxL805jjecvVvrPQvhnprFa1iirmxf4CJJV+2lIdhH5QNl/0+hH/ly7OnBFVPdiM0lD5cpmHsSeFO+3nqf9SUr6C21My08N6C8F/wBNvU+LNnQga5egBBS4oVHSpIqYNIjSMKD6rIHWBNv4aUy+7kioyhOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689532; c=relaxed/simple;
	bh=kgf5qzofg9XdjyRI2Okw+ogBrpfswPf+/CPSQfTyBj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiVfz9ife2ZbrUtyMCQq2r5KDWwp19p+wUeOz8nqADZmihzJtaKVqoeqHCuBXaNR8hI9lil64DkOANWOamSWTcBzb9EWmlNGrH/deA/yvzeRVHrifvMddqyUoLIWwBAdjl01/8jgN+Pqf2IWWToJ33iCbOOMz58CSYqpd5sPuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so542734a12.0;
        Fri, 23 Feb 2024 03:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689529; x=1709294329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv2F+CMwFgzgnky2Oblv6t762R5K7w7duNIZkmo8KDY=;
        b=oCX7jVTU+3VSihgcFDWBl3E8qSt7lI4RFGGEfBw3UKjBpcbWKL+sMP70zmbjG/IKJG
         rM9yZaJQFt+dL+7ajAFmtDEJ0t5HF20frhJgN4w5sIwtDnYzrr9qXNcZujyn4Ws1OTo2
         qBPHu/f0RRfkp/cfz3bWS1JB7RWjd1gTSsLiM3khwcSlMbJAAt5Va8vJGGl52tNgbYZ7
         D1Pw2UPXEIt+sjGgJik94Ts5gVHnHF0ORepvXtgAE8w/4aQlS9R3NPnr4I202E1BqV2T
         4kkNBe6WnjIvy+BPsCuKar+qTfxGNR9qAuDJV140VAoDvi/Hn2qWP4BBYQylYfx+L6jS
         bvew==
X-Forwarded-Encrypted: i=1; AJvYcCVqZZSxFdAt5ZWxpw1FOaCjWr41NUR6Kv5n1EyIEuhXW0Pb0z9RipgEG8W9CYSb/09I8BO2N1TmGg7NTAa/cXooOqknJgRB5qDWSMXS
X-Gm-Message-State: AOJu0YxE0oFiAUen9soGxkvtqF8Uz1RtaWWct6CchCCAgkkIVk8KuZrB
	R9TlsyQzOtrRVqjdBsLRWNjSy4XL3Dqae61kjyVQqZirQsS0J7Zd
X-Google-Smtp-Source: AGHT+IEwZE90ddruXHba1WENbP9lNcLlOKscuPh/LATd8ln0hCxmETUo80I+NSEbZD9hNAu4n8T9iw==
X-Received: by 2002:a17:906:6d49:b0:a3f:af43:5245 with SMTP id a9-20020a1709066d4900b00a3faf435245mr1702677ejt.0.1708689528908;
        Fri, 23 Feb 2024 03:58:48 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id fj14-20020a1709069c8e00b00a3f64663fe8sm1895858ejc.200.2024.02.23.03.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:58:48 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
Subject: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
Date: Fri, 23 Feb 2024 03:58:37 -0800
Message-Id: <20240223115839.3572852-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the vsockmon driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vsockmon.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index b1bb1b04b664..a0b4dca36baf 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -13,19 +13,6 @@
 #define DEFAULT_MTU (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + \
 		     sizeof(struct af_vsockmon_hdr))
 
-static int vsockmon_dev_init(struct net_device *dev)
-{
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
-	return 0;
-}
-
-static void vsockmon_dev_uninit(struct net_device *dev)
-{
-	free_percpu(dev->lstats);
-}
-
 struct vsockmon {
 	struct vsock_tap vt;
 };
@@ -79,8 +66,6 @@ static int vsockmon_change_mtu(struct net_device *dev, int new_mtu)
 }
 
 static const struct net_device_ops vsockmon_ops = {
-	.ndo_init = vsockmon_dev_init,
-	.ndo_uninit = vsockmon_dev_uninit,
 	.ndo_open = vsockmon_open,
 	.ndo_stop = vsockmon_close,
 	.ndo_start_xmit = vsockmon_xmit,
@@ -112,6 +97,7 @@ static void vsockmon_setup(struct net_device *dev)
 	dev->flags = IFF_NOARP;
 
 	dev->mtu = DEFAULT_MTU;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 }
 
 static struct rtnl_link_ops vsockmon_link_ops __read_mostly = {
-- 
2.39.3


