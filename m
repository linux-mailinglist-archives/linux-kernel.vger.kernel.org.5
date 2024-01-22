Return-Path: <linux-kernel+bounces-34012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744448371E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A796D1C2A499
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D815FB82;
	Mon, 22 Jan 2024 18:46:41 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AA5F578;
	Mon, 22 Jan 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949201; cv=none; b=ORRUd7v27Xz7dqx9RElipI8WVz4OEiMvi9oNvxXyWScFHnCWxJj4t8apg0jmNB+FRkZl8XuQycmEeFAw0xyWb7H2dkJ+K9FjTCkyQsDbYVhHBDJ1bl4A0iycYdna6WruoJOIl1Sw4WDDQfhEuThu4SOdUDwR5iW1PDXrmlehi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949201; c=relaxed/simple;
	bh=atqq0jcXQT2lcsEadxM4os6jxHol0jtIEHXIZnxLtU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaK065Oleuiqm6F3gZ5fOS5MvIpbl8sz4nNo0U+zWJUeby28hS5aXesLE+vlrQ/J6KQTmuWIeWCf/2+P1L96v2UkShk+8BNh0Ktjq91jm4kGp7W2i+uBGSnWvgnS/Z8REN4jdIQBmfom+GgYlFX6DyZI2gBpgfohvu7+TdNsSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so370667866b.0;
        Mon, 22 Jan 2024 10:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949198; x=1706553998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJO1tmEeetjzc75SScsWZSP0VzkIx/i6WWUOPZCsvqA=;
        b=vcKNVHKdDM1yxHQeFebFhCAIREhjesW6ve2D7tSfoCxE5h855lswd8VtmB/54g8mqE
         LRZTCSi/mgmbgfmIGO8kAUORESsdE4Za4QwBtrQL2WFzuh1NvBbG4jHatoRSooIy4bkK
         8x2gnxDkVKy5ciyKeSBXQYu1vrPmvhTgDCHWvayqRelT+qufW1kp4HCQ4nK/nO62hXYD
         tffQ9GF2UYPavE40Kr/N3rC9g/rmjlSFJAJGD/Z0ct0XzjuGoIuZnFEWGhNIgJBAphMc
         wRAgWcIgxTcvePbxJiq4zuNxxwijw+IlavUURHFpqGZimldibz44a/Q8yqGPkuTjvssN
         FdyA==
X-Gm-Message-State: AOJu0Yznc6JHfput+JlunrbeqhK22HkuuNodkoUKJA2YSJfQAsP/d484
	JQl0MeDjRaAy+fUlubzxq8FBNCqpKUj4Csudtg1rFSgm6bm+smDl
X-Google-Smtp-Source: AGHT+IEiN8RzFRZwbPLpLt2aqaApLpBilfDgA7AsTUUO4uG5sS6Uc4FQvguSVjyUcDwo6tX6U/5cIw==
X-Received: by 2002:a17:906:4950:b0:a2e:9845:adcb with SMTP id f16-20020a170906495000b00a2e9845adcbmr2361850ejt.147.1705949197720;
        Mon, 22 Jan 2024 10:46:37 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id cw16-20020a170907161000b00a2ebd9e0de7sm6752001ejd.31.2024.01.22.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 13/22] net: fill in MODULE_DESCRIPTION()s for encx24j600
Date: Mon, 22 Jan 2024 10:45:34 -0800
Message-Id: <20240122184543.2501493-14-leitao@debian.org>
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
Add descriptions to the Microchip ENCX24J600 helpers driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index 5693784eec5b..2e0fe16a4082 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -513,4 +513,5 @@ int devm_regmap_init_encx24j600(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init_encx24j600);
 
+MODULE_DESCRIPTION("Microchip ENCX24J600 helpers");
 MODULE_LICENSE("GPL");
-- 
2.39.3


