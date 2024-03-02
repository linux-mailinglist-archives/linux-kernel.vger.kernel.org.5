Return-Path: <linux-kernel+bounces-89527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760286F195
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E69DB229B5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86D2C696;
	Sat,  2 Mar 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="YHcImU44"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98D2375F;
	Sat,  2 Mar 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399172; cv=none; b=ovkzdZGh/0nH3Rks8Cy7Bl6LS23zWbEkW+XbR7FAN98Fvn5aIyUAGAKV4r1pFZLdFKG/VqQfhofOOBIHAuuea9IAUJIMShYR8J7xvm+BmoSQKyQaEk53cDoDo9M2SauM+SV0vegC0Dz3r+knwuayEPumFxV82dKSmINvmNCdHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399172; c=relaxed/simple;
	bh=DVLONE6hA6DnIW62nPfbQNEd9ruSxfvRSwzoof3s5nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3XmelJuWWTmRQtdC1q23BBWNf0um7b32PZ0j2i0M9rBcIN38r0fTVbTvP7deuq9SIKiuUpppNBEM/riwBKliKvmYa2Zi8NcfVhfd2Ne7re0GwNCo2riiwFWRhDfKqC81PxcUEHn+p2Pl5pMpEtjvW3xh0dlbHXWfe27pJYWqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=YHcImU44; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso206984939f.1;
        Sat, 02 Mar 2024 09:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399169; x=1710003969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJqgoH62LO9fENR8x+qZ3sa/FE1S2fO1vPl+clynvjc=;
        b=lVJYIUtglLrEjJuff/gupvlOyRi7GVc1SbPR0qBn9tC64OLoYQUVYfPZUGMfHDAiU3
         WKRC2A1Vj44J0BE8c01hSLpao5Xx/20XDCShYPfT3swjU1QJanrXN9RE/VgcQDEE6XH6
         Sc2L30/k6iizBkf8JsVhFPQ4DcWcLgFL/L4AyjIi9WtHp8zxqmMi/TqhyhVQrXmUomXC
         WFavj8C65bdb1CQ0unUL7oL6xxO2FNcPAdxNuhd6XnKBPIjnAlDk50mTd2OHERSNkbcm
         PPToXpKYYl6cQPjtvheI0yPrHPd2bDXoMHm2njy6GpuiEkhoZwSbM4e2pSOnaPtki5kj
         Z60A==
X-Forwarded-Encrypted: i=1; AJvYcCVnld7VSG2r+tzFkCZC0j/5OuXzOgDfiguxeuv8Q2mcLvwRJIJ7i6Zaw5Bu0KrBlg+ICthHDWpBaf9ezBd+L7uUxQM63W//7l+tYf1Oeq0eSGS8f6QkA2lcvVUFGS8W7QQ+PgmfJERjdKk9wE42Ode4dBw7gdycbISAWeuauh8x
X-Gm-Message-State: AOJu0Yy7+ujv/BQOs+f0xhZ4Q7e3e0424XZfkeoVcF20RxlajdJ2XGLx
	k1N+3uF0i6/IhjZ35Y3kg55/CKmjrXNkfARJGtrPhGaNucaBb3QTz4Q/ZuRnYSDRhw==
X-Google-Smtp-Source: AGHT+IH05YwYl9Yb4xTua5+7CLgKehkQOZJUrg7FqFHW10gD1MBHPLvPZ1868UGnmmPXZYFrmmei0g==
X-Received: by 2002:a05:6e02:17cc:b0:365:2429:f60b with SMTP id z12-20020a056e0217cc00b003652429f60bmr5337904ilu.18.1709399169632;
        Sat, 02 Mar 2024 09:06:09 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a17-20020a92d591000000b00364ec1f92d9sm1577307iln.9.2024.03.02.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJqgoH62LO9fENR8x+qZ3sa/FE1S2fO1vPl+clynvjc=;
	b=YHcImU44wKwbvQ37GYFwG+SAA6m9VXEFIHFmaYur0rZ01XkO8uEgbOAZhiHVoaLQ3u75vz
	Xg0f5Lh0iuxB/xO/2UIAEWbX8qbhWsEZnK4LPtBurKUPYfb8semDPAb53lEzhVMM8pidig
	R4LHUH0GWolXhOhDd3bnHWi6g3kRNds3n2kleqkzI4K11L0Ebm3WKFmm6NS/R7uaN9NwGp
	aT0lvAMGfkCKtAy5oCGfW9HHn5ZweMzjVPMPcWNoWrxeiCqjBpVXH1gzeEsP+lUKciFg0+
	/b1XmuiEZs7QFfPRyoLYCXlD8rR7PvSdawlAMLjHmRQuwiHYZv0O6xlI3lWGkA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:05:57 -0300
Subject: [PATCH net-next 1/6] net: hns: make hnae_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-1-8fa378595b93@marliere.net>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
In-Reply-To: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DVLONE6hA6DnIW62nPfbQNEd9ruSxfvRSwzoof3s5nI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x6b+s4rceZcISXI4+wCrkuYovsuJqLCzXIG
 gk0MhwCfTmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcegAKCRDJC4p8Y4ZY
 pvLmD/4s9bqOGoGTH1ZUlZ3OwPrCqI5ELU0SagHcoxN2mHZOgQ6GJny+ldo2RjwMDLvaXS/vg6X
 zKf5qJ24QFb1o/KUdm1Sxn1NqdZzLlC4Hz4znlROmPsW/4rfr8LipsuvQILak7xPHNkm9+cYuB2
 /C7fU3OxReAbarm6Av7+U8bN3Dlboz7AGsA8cvyOkin0SAcgKbvXiqzIncIDvV41yaIJKFkXPu0
 7gYIkE13M2VzSjQbkRpykunJaCgj+HlZWmYTimMK4snuu1EpURf38FxZXDQI0uyoLEIQA2fkgeC
 F2XsQgpQfYeFvrK7XI1IbW2uhlUydaUFmhtrQJ0456ExH5eU1TxCTjt9y3sXuxVlVoGAF07wOR7
 6PIW3EOWXhl29qbkVXqjdtEB/Lw8XEotMEPOPd2yvrgAlwG9QU950mgFCJwogwgGFoTYp0DSUKS
 ZINVjWiwogd4PQ7rmNOTuI07BL/roxByZTCDWR6iDb7fUWMrvF0f6pB6LbRBASHDhMIxncb1jWQ
 UqBnzfqZ4dz67oYZcsnHYJgygppvbDXIgevqWhCjToN30xnqSE+uw6LIDZ7C9cStb1FJtybzaSR
 SORq+JL+xH942ASjwZ9bIPublxiJc7F2vveq8dfdsezY2ci/urjJMosgBfR9pZThBvvBeZlT7yX
 hRSLowMknijbH9w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the hnae_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/ethernet/hisilicon/hns/hnae.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index 8a1027ad340d..d4293f76d69d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -12,7 +12,9 @@
 
 #define cls_to_ae_dev(dev) container_of(dev, struct hnae_ae_dev, cls_dev)
 
-static struct class *hnae_class;
+static const struct class hnae_class = {
+	.name = "hnae",
+};
 
 static void
 hnae_list_add(spinlock_t *lock, struct list_head *node, struct list_head *head)
@@ -111,7 +113,7 @@ static struct hnae_ae_dev *find_ae(const struct fwnode_handle *fwnode)
 
 	WARN_ON(!fwnode);
 
-	dev = class_find_device(hnae_class, NULL, fwnode, __ae_match);
+	dev = class_find_device(&hnae_class, NULL, fwnode, __ae_match);
 
 	return dev ? cls_to_ae_dev(dev) : NULL;
 }
@@ -415,7 +417,7 @@ int hnae_ae_register(struct hnae_ae_dev *hdev, struct module *owner)
 	hdev->owner = owner;
 	hdev->id = (int)atomic_inc_return(&id);
 	hdev->cls_dev.parent = hdev->dev;
-	hdev->cls_dev.class = hnae_class;
+	hdev->cls_dev.class = &hnae_class;
 	hdev->cls_dev.release = hnae_release;
 	(void)dev_set_name(&hdev->cls_dev, "hnae%d", hdev->id);
 	ret = device_register(&hdev->cls_dev);
@@ -448,13 +450,12 @@ EXPORT_SYMBOL(hnae_ae_unregister);
 
 static int __init hnae_init(void)
 {
-	hnae_class = class_create("hnae");
-	return PTR_ERR_OR_ZERO(hnae_class);
+	return class_register(&hnae_class);
 }
 
 static void __exit hnae_exit(void)
 {
-	class_destroy(hnae_class);
+	class_unregister(&hnae_class);
 }
 
 subsys_initcall(hnae_init);

-- 
2.43.0


