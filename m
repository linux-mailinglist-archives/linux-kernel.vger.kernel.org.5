Return-Path: <linux-kernel+bounces-88508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F186E28B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8720FB221A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B67293F;
	Fri,  1 Mar 2024 13:42:28 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400296EB6A;
	Fri,  1 Mar 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300547; cv=none; b=sVMyC8EFXpLan7KxbWLF5qOd1H04xl8PPV2iARBwBL0Qp4DeMt2RkIHhYAQqiMCvDqKz5paH1IHfzz7M0yIV7CW/9iyqDvuK36gZoTyHENwQm9WwKr7bIBEm60Mn5ynx34blMMcZVVhuVmhZQLN9EObybH2WyNPsHmXd/5uXzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300547; c=relaxed/simple;
	bh=WPXkIQwvRLQBSZhlUEDaUobW7M6LNr8BRk9mM4f2BSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkaMxve4bheHau4yGT12nRw1gdRmNr2pwgShD/NfolngE47miP1h0Rf1m9sqoo323oPzgsJp01fQ52CDpCoF61EMMxLA+vN+9A2AvN7r+R0Vc86lHpn8zMACDFqvC/dNXf2UM5hsN2vTINZ4t6MIGYWXX4IYDPzxLv7zRWdp+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e12916565so1025153f8f.1;
        Fri, 01 Mar 2024 05:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300544; x=1709905344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9taPaBKehcb4ahcbhUFAwNa2TaUPUJg1amPsCfHtP5k=;
        b=MpIX4non/LMKiLaU66ydg4JilGV7bm5WE+ADT/H1K04Gz+8iuireYOihZvQoiC9iv0
         GxaedYG210leRlAm1KBqdw+k7lsqasyBH/gCOW/2MoyhzlvtRpP3eJyx2VwEsXLDSLDC
         6y1vRu3IMJ1Q8PPHYrg+58D/oooADk5wYImQqUKctB/PDaJv7WYW/STp+ILnf2HNPu7h
         X+katRJL6j8VmSnZ/4ogmbbOcDb5C/7u9daYKxWzzS5ffQZ++V7DSkFYRmygcd36nlvw
         NFCK1v6Gs0skSejy81LAvfegJoTK+wt7fHZgZmfIiJY8rtqM8spAWauHIwvqlNKpTZBk
         cyzg==
X-Forwarded-Encrypted: i=1; AJvYcCVo4gpZEPypHW7kyGSl43SSgxMWecYYXGKASXlEA7MW9MAWSzNRBq5nefyG5CONqfoeAwp/Uqf4JZzZBWa/2GnmmLuwWJlS4N5hA4xw
X-Gm-Message-State: AOJu0YyHS3RnB+dsQkK0t6VNqiKydWdonchVM5sS7obMgzpwhqCx58Ch
	AKpWDpxBzUsq/E3FXi70R3Rg3KZFJCL5QfXss0ZY5HloeeNc60iK
X-Google-Smtp-Source: AGHT+IHzIiy9v4vwPr6VmiqOFz7HYvjY/fmfmHEVTMCH9mgfJsbTDkShaFD2LVCoDT3cBw9Td0uqPA==
X-Received: by 2002:a5d:4152:0:b0:33d:d793:a20f with SMTP id c18-20020a5d4152000000b0033dd793a20fmr2027753wrq.27.1709300544344;
        Fri, 01 Mar 2024 05:42:24 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d59c6000000b0033d926bf7b5sm4772895wry.76.2024.03.01.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:42:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 2/2] net: nlmon: Simplify nlmon_get_stats64
Date: Fri,  1 Mar 2024 05:42:14 -0800
Message-ID: <20240301134215.1264416-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301134215.1264416-1-leitao@debian.org>
References: <20240301134215.1264416-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not set rtnl_link_stats64 fields to zero, since they are zeroed
before ops->ndo_get_stats64 is called in core dev_get_stats() function.

Also, simplify the data collection by removing the temporary variable.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/nlmon.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index e026bfc83757..e5a0987a263e 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -40,15 +40,7 @@ static int nlmon_close(struct net_device *dev)
 static void
 nlmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
-	u64 packets, bytes;
-
-	dev_lstats_read(dev, &packets, &bytes);
-
-	stats->rx_packets = packets;
-	stats->tx_packets = 0;
-
-	stats->rx_bytes = bytes;
-	stats->tx_bytes = 0;
+	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
 }
 
 static u32 always_on(struct net_device *dev)
-- 
2.43.0


