Return-Path: <linux-kernel+bounces-159790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3E8B3410
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA4DB233C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354814036B;
	Fri, 26 Apr 2024 09:32:10 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634B13F45D;
	Fri, 26 Apr 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123930; cv=none; b=BwswTP3G8o/H0kmNlx7F6kb6gxZha1gPb8H68ZRJs4XIMqPmRRUMC6w/lkDmPO9M7nTKhxo8Xke42pK6lrTlMhpLP6jte6kEsDazOq2YxAg9A4T/6NC9GKtlN/hQkk6fnpvSfbv5X5npCk1PblpMyhPOVstHm2IK856C3speCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123930; c=relaxed/simple;
	bh=lrNuWaHK5BdyB8pVP8kuJCm68c1uOozItiB7SfFwPIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0hLe9uZCPOZCJ2cNcknzQKmD6DBgFjpPSJfK/JcOUmvzlWx1Z0gL9/Ljt/la5Kc3gGbpb/bXYRohggcjkvrH5npheT9qsFb7C2HBARCcUmal9PhAIMi6G3JRz7G2q2jO4uwnZYSmLubqvydyYtM8y97/04JR3s20mE5/5Zasd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a55ab922260so262259266b.3;
        Fri, 26 Apr 2024 02:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123927; x=1714728727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB47YEskg0YsuvufIWkNOdLy1BfCNPRDkJhRY5gUXJc=;
        b=iPOnWxxuSlPgCS/PaJSkO8d6TJCc2emkhnJ3PfRlMJZfdmldfbjkIvoktQnT72lONP
         7cR3DV3wDXuGIczdYxkjallA+u4xPSJsdDtuf7XQ5kMRYXeJmN6RLwH1p1WiWcjufD5d
         uq9mpRtvi7ce7WY2fHDqo34CdkRmebDT0a2wF7dWxoA1xS4CFquEnWE9heqac7ncypbe
         84wmudoyhksFQ++tXSDpOIgB2iOkGTZGKfcKE6Y43Oft0xFysAtKqfgni9QDcnBR97nR
         DirHrj7R99hb0L8wAru+YVlMoU9+5jPs86HrN7tDUVF4ZSFQSirnBrhOk/DdGGYxs0a9
         qUkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9x43ccFexcW/+UoDTK5DrJYvcP1QftmtpjXosAIQyZjUXyueHHGj/9unduu2WFeOcyZlmZstCTEgXlX4t5Ns7xSaIs9SKrObxrfes
X-Gm-Message-State: AOJu0YzaFRLWs5QbiuoOgdZd5m6F3udSbYiZKFyQkqZlghvCDhXzKQyv
	lc6QUfgpsG38fidYCf5GPmgionG2NakUIGDI1wCJej9ix2M+Vidr
X-Google-Smtp-Source: AGHT+IFRY4i8ripmmRgmZcMA4dCbq+M0SBXKAURjKWqCOr/9ZZ0ocBXIuwONrHVrNX7KKn7K4WqV8A==
X-Received: by 2002:a17:906:c12:b0:a58:9e89:7d91 with SMTP id s18-20020a1709060c1200b00a589e897d91mr1406081ejf.42.1714123926789;
        Fri, 26 Apr 2024 02:32:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906270c00b00a55895c7f50sm8897398ejc.151.2024.04.26.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:32:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kvalo@kernel.org,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	kuba@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless 2/2] wifi: qtnfmac: Remove generic .ndo_get_stats64
Date: Fri, 26 Apr 2024 02:31:49 -0700
Message-ID: <20240426093156.2002258-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426093156.2002258-1-leitao@debian.org>
References: <20240426093156.2002258-1-leitao@debian.org>
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
 drivers/net/wireless/quantenna/qtnfmac/core.c | 1 -
 1 file changed, 1 deletion(-)

PS: This is compile-tested only due to lack of hardware.

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 0aa4b1d14809..825b05dd3271 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -202,7 +202,6 @@ const struct net_device_ops qtnf_netdev_ops = {
 	.ndo_stop = qtnf_netdev_close,
 	.ndo_start_xmit = qtnf_netdev_hard_start_xmit,
 	.ndo_tx_timeout = qtnf_netdev_tx_timeout,
-	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_set_mac_address = qtnf_netdev_set_mac_address,
 	.ndo_get_port_parent_id = qtnf_netdev_port_parent_id,
 };
-- 
2.43.0


