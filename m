Return-Path: <linux-kernel+bounces-54105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57084AADB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248951F2582D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61F4D12D;
	Mon,  5 Feb 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew4DZpcN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1148CC6;
	Mon,  5 Feb 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177239; cv=none; b=NwsQbbII/iHvjVRKdtwHBzSFNSsBRKg2QfLzYH4Pci0sSzjR4RQ7Z43lGLa5dvWRjtiiI8a62ZnKbYOt7heD3T/L0rAtaeUMkr4bMvcB6ZJZVqNpCFq3ltk8QdJ5Bf/WHnqU/1ronE+9R/l2uw/JaHHW1SeE+5k+coooeXlkHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177239; c=relaxed/simple;
	bh=nJanOS1hCRyVe/2LbmWg0rG9mmxI9LHxBGl/E28BohE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zdvon3xx/iibGtfuTojm0s41o32h0AHFZ8mjoGQf/ClgUa514pDiw7OgGN3JCAgUg42RTRybnFl3oJxgU4J4sxRKU0VMcQIRQFmQ3j+4BeeyU3zAXmNr+PPhilmj/wb6hgjqYe1blo0+hSDFzhEljGXC1ehZJCqZCrBI1DenheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew4DZpcN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93edfa76dso42811695ad.1;
        Mon, 05 Feb 2024 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707177236; x=1707782036; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kiLTCJmbmh0u3rY3NuQEZxUH1Em6FbOtZB1pzeq5xJ0=;
        b=Ew4DZpcNH6lFv7FnI2iVxfXeULUuVbpzAngP2eJYvGQcL2cC4wbg2kX9qke1z03V9U
         pkEzvuNN+F+itRciCJ0AsvWH9bK9Jf2hnVxa6A0XH7az3wglo+CTg1wTfXw3WjT+hjPN
         gkzYJNZ+hYxKiF9w0BdQ5SMImdSo6FIoYumaZ6Nvw1pqnZcyzM9Hc5z9Mj3qSodO4KCM
         DVoBjekELePbS8GA0p01UW7Q0L7wZ9xq+r7uoZyc7ApadENjCXtsNao/6NtkwVts8AED
         HniJ4KcodiVtMj1fCF9ipV6b13yuy/hyXl4OxvRbaMqhNAuMtf5wUy0AqMFDhuhCsvCG
         HS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177236; x=1707782036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiLTCJmbmh0u3rY3NuQEZxUH1Em6FbOtZB1pzeq5xJ0=;
        b=IaU425ZBw28zMGfBmLy8606jbBKodFe0LqbKO/Gy2QhC8RqqErCW1mi0ANy938V4d/
         1qLcNiBoPWuufAARQMl8lZeteMGj7bhcVtHwLil193yI2+xbMD804dvPutmMUI3oKgOV
         qvJBp/YgXzI8lwzO4u4BGhYfEsOMoM9TXMTUxpbRaavMsyTTRjhSEGHTidM9n/AouZmg
         ffdFmCYV8ZWJGTLhHMNzhVDiCougr40pVNhQWU8EsfDYnk24jAJy/K0eok9cWJdEGULe
         rIW+TBf/RXGuaacMSWAroCC3U+CZoPH4zX//rLCREgr1PQ1sQ8U3sgR0avDRBrDQmbVq
         N+8Q==
X-Gm-Message-State: AOJu0YypoRvPxaKm7a26esebjIzqPoanH+s3uTNBTY4c4QA6YphAcMOG
	nh0Beb7jntti/RAzOCFqjw5M/hF2uyLWDmbMG2Vo1MhvcGKJT3gIC0iL3WY/oSw=
X-Google-Smtp-Source: AGHT+IE0vpxwKhomBNhEmOVxBT9nKNhVmPDW9X2er55br7FsuGimIBDbtKLh28J/Mvu+QY7Qs3DZUg==
X-Received: by 2002:a17:903:2452:b0:1d9:aa2d:db6e with SMTP id l18-20020a170903245200b001d9aa2ddb6emr28683pls.26.1707177236032;
        Mon, 05 Feb 2024 15:53:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXEFoYMWX7FInwKTYhYD9FhL8+7D+jmaf8Of0hOOrY49OXMv5Y0tXifadC7tIpRJoemnDnaXo0ovfoXA2cYz1ZIEz/yunhCyncd4WT1aDRs9h5I2qhkUmT3uiAdt/3QPufNXisAF36UoX0mNo3+g5zrlVeHCoDpS89hgr7V9+R7IBpWe2SHm5atoV8SDcJNihROod9UyD/NpVonaX9EsN1T5UU7TsjFzEO8t9NkqWNb2YxcUMnO/JWqGczTHT8LUjCzDpofg/EiKLPYM6YFnZuMQFfeaRr2MChxaC+SaISYGxc4uX3e1mdk5Mjn8vr59eE1fBMpAR7sdgKh
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001d9630e3396sm453561plb.193.2024.02.05.15.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:53:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 13:53:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: ca8210: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <ZcF1El7fn5xkeoB1@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Workqueue is in the process of cleaning up the distinction between unbound
workqueues w/ @nr_active==1 and ordered workqueues. Explicit WQ_UNBOUND
isn't needed for alloc_ordered_workqueue() and will trigger a warning in the
future. Let's remove it. This doesn't cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/net/ieee802154/ca8210.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2857,19 +2857,13 @@ static int ca8210_interrupt_init(struct
  */
 static int ca8210_dev_com_init(struct ca8210_priv *priv)
 {
-	priv->mlme_workqueue = alloc_ordered_workqueue(
-		"MLME work queue",
-		WQ_UNBOUND
-	);
+	priv->mlme_workqueue = alloc_ordered_workqueue("MLME work queue", 0);
 	if (!priv->mlme_workqueue) {
 		dev_crit(&priv->spi->dev, "alloc of mlme_workqueue failed!\n");
 		return -ENOMEM;
 	}
 
-	priv->irq_workqueue = alloc_ordered_workqueue(
-		"ca8210 irq worker",
-		WQ_UNBOUND
-	);
+	priv->irq_workqueue = alloc_ordered_workqueue("ca8210 irq worker", 0);
 	if (!priv->irq_workqueue) {
 		dev_crit(&priv->spi->dev, "alloc of irq_workqueue failed!\n");
 		destroy_workqueue(priv->mlme_workqueue);

