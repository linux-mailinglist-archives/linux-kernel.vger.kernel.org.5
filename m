Return-Path: <linux-kernel+bounces-34020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B148371FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8E91C2AC40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D59E604D7;
	Mon, 22 Jan 2024 18:47:17 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274C3FB3D;
	Mon, 22 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949236; cv=none; b=qO229blyBcA8toQo8bgHsRtpPEeo3S6YHzqSanACdj1SBNbEJfYM4t2KAkCvU7hoGPhp4Uw31J9sY60061XKRUCsuP6c+SXOmghPR7L/ytaAESjCkmLnatNU1zGH0CEcu5Xbb2hVjs2yzLpexHJZF8TuktPemaeLMaKBNSLAYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949236; c=relaxed/simple;
	bh=uEWezJ7+I9VN7UklI0BBr4CzYeqHpEpxvxNv/N6nB7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSEM+AuogrvOVkYG0Qyjg/8Q00c9kyF1vK17hKKabUHHPuo+ezp5zmyAZKfI1s9W1bOzQnZ9j7MTgk+dINmy4qQDV5zFc2WUKbiJYN30BQ7UgzG84kq5hiA3UqDH28dUWSlJglsjhzUIRtBr8lYvbIrfCyxKjw4xIylYX9TPCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ff9bde634so1299649e87.2;
        Mon, 22 Jan 2024 10:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949233; x=1706554033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1hTTwkFp3JNpz3iSovxHTDDs4dMLc/6WOVM3FZbhyU=;
        b=sXTDJvondIPwBCybjSCyP8iauQBhN3g1VHh7jcRlCdnkjYsS92kDhcHZOmbqSjP/iP
         O87TL12hkC1k+j6CSzB3bgpO0NZS+luC/7NJ4GJ6HxGSa8MWxOnn8B8jXjk1AvNWK83X
         IU/Ql6d+S+GKHL7P3hJleRVhX0PTGzahu6lW5N8zOtbjUHNpU5NncB4yLPnHsT6+yHlp
         r7FsxvIPaoqGzMMkry/xe87naCD1kYn4BRmxal/Wd5Ll0fvQiUh8ahC91Z4QezD5GtT4
         rkPErEYhMwvIAAjQdpowPQwouWlgkanDpyTMSX0vuvaS7sCnIq7zYKeR1qCTLiRkFacM
         0VLA==
X-Gm-Message-State: AOJu0YyVZBEaaz2F6O2x0RPQh2OeIoiBk+fKmw9g6+Q0IIWJkmEnOtLn
	nZguem0QemqDkRFPdlKAa0B5UT6Z7AXp6xMWhtbjr7XKBJ3Z3oNI
X-Google-Smtp-Source: AGHT+IFL7hu7CUGvQC2EnxSJ7wwyl3FpRxZ6RdcGKTb72L6dHM0QCYvS8pBUVfbDZD0S47ho0lGH/A==
X-Received: by 2002:a05:6512:ea6:b0:50f:f9c4:4974 with SMTP id bi38-20020a0565120ea600b0050ff9c44974mr1438767lfb.26.1705949233285;
        Mon, 22 Jan 2024 10:47:13 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906541800b00a26f0f49dd2sm13826517ejo.11.2024.01.22.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:47:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	Rob Herring <robh@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Simon Horman <horms@kernel.org>,
	linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
	netdev@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 21/22] net: fill in MODULE_DESCRIPTION()s for cpsw-common
Date: Mon, 22 Jan 2024 10:45:42 -0800
Message-Id: <20240122184543.2501493-22-leitao@debian.org>
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
Add descriptions to the TI CPSW switch module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/ti/cpsw-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw-common.c b/drivers/net/ethernet/ti/cpsw-common.c
index 26dc906eae90..57fe936bb177 100644
--- a/drivers/net/ethernet/ti/cpsw-common.c
+++ b/drivers/net/ethernet/ti/cpsw-common.c
@@ -90,4 +90,5 @@ int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr)
 }
 EXPORT_SYMBOL_GPL(ti_cm_get_macid);
 
+MODULE_DESCRIPTION("TI CPSW Switch common module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


