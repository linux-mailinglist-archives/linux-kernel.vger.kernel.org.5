Return-Path: <linux-kernel+bounces-34007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3268371D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752001F2BFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F175DF39;
	Mon, 22 Jan 2024 18:46:28 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040C5D919;
	Mon, 22 Jan 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949188; cv=none; b=uPubcoxdwJh0aqfG67ihekukv90pEp3e9GXTxy6VsuX+fiagSnCiIbIV3bj5PRubACMaJnMGoCm1nrNrCFKnihYSZh7xojdvwMQjKZpFRU4uvujl9Dr0QhQbtvJY7P9ncKfuFBrxd9dAlRAuEWGB9gQyrwxZj0DEIRcEQZDzXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949188; c=relaxed/simple;
	bh=+f0GABE2vYwLftBWVjTV99H9hCN+aUA+VFW1jTa4YvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KITuQgKDQ2ufNuJiHygjZeZ5m6K8hOOfasU6VPWijnYz+RsGc97PwOo/OTCbUW72YFTi8+8cd9kTeae2ptYmUyMmGC+Q8cKp+i915TejEy138v+f2dTzFeB6uvLr/2WEuO418TPh6v/P2vEltQi6PcxY0xjfxwzs+lRTu2aloRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so3773498a12.2;
        Mon, 22 Jan 2024 10:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949185; x=1706553985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyI7NPsyPL2bVyAR9zv80ihx/UAk8uVQYMV9FnhPAlg=;
        b=YVlFhv3IcA3+KlJnJ+tTVfEHxcuWoUiyG6x65HNX7UU/lA8p9+sWrd/gAb9sJi2KWW
         2TZENyvJHXnKz6i/NbdCMISJCh+MudOsV+emQRNdYlP/j4AO7s/rGvKNzInjJtpYRzR7
         6xKZj2s57AEVCCry9K+BMLlLNAtBCbMlHmpR90Nyrv83XdnsqWwOsrk/ZCPVc+LMevJg
         nDHHTRXN3+5cbwvsniVI1YMpAJwYqdFx1CSL1PHaoDBHhUn41nOEfqMqvD7V1AI9WJ9p
         GTfoquLr7/P54XZN3vg4S+rSOnHKq2ui5JQioYlo9C64pa/V4z7Wm7Qn1GnPqtUOcrOC
         gdKQ==
X-Gm-Message-State: AOJu0YyvWi+ckxo+vWdjOwWyCt5pWLfOdd3vXWiN3rG0rMGs14DRtdqw
	ls+5tG/vjJtGjJFOj3sVJnfk1nYaJ0I96TqFSvxLpNjS5LrabeQAQUBKaUoNqynrVA==
X-Google-Smtp-Source: AGHT+IFc07k+pn+R0zsuwKWlbTJ4Vc9/o3Zrg1YOiP/bQw3sEOsgoe6s1Ply2h8JwYE5JHZiLv7PDg==
X-Received: by 2002:a50:e610:0:b0:558:b0d7:6a1 with SMTP id y16-20020a50e610000000b00558b0d706a1mr169173edm.47.1705949185194;
        Mon, 22 Jan 2024 10:46:25 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id fj9-20020a0564022b8900b00559cb738c1bsm7552231edb.4.2024.01.22.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:FREESCALE ENETC ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 08/22] net: fill in MODULE_DESCRIPTION()s for enetc
Date: Mon, 22 Jan 2024 10:45:29 -0800
Message-Id: <20240122184543.2501493-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the NXP ENETC Ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index cffbf27c4656..bfdbdab443ae 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3216,4 +3216,5 @@ void enetc_pci_remove(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(enetc_pci_remove);
 
+MODULE_DESCRIPTION("NXP ENETC Ethernet driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.3


