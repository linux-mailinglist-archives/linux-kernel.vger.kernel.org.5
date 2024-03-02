Return-Path: <linux-kernel+bounces-89530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084F86F19E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FD81F22260
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0E383AD;
	Sat,  2 Mar 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZWWsmq+c"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07D2BAF6;
	Sat,  2 Mar 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399181; cv=none; b=QUl8WFkujw3xHLiw/zZ44vbueTX2+8mD1JvWVL8Ndy6Egix7SDd56yfaq8WWZc3dDjjXpJ6vpsrsxU/gIrksJ6eSA+sS8FUYYVW072dyAkjk7fAlAQIo0CLinItPUt07VJ2dYTZPwpmYD+nqrB6Jl7i58hag614Swfo5kuZuEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399181; c=relaxed/simple;
	bh=S0SNqxhR+Qde3qiIJKcqBx5TILtF21c2fHB6D4dCT7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQSbzagBbl6gAKhrog99kAdMuJgSZVTevQspai+KwaKD8654jHb3GvnNRG8Ed3xMaWJ53LTlBxzMdyAoutAYC0+F6uvJgqXBUChF3w3gj6GA7MrHdQy5Qrdsxh6hUgKw+edTyj6ayXYaAGiahytzsf1H5A8kN6PxB0xTr9QWO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZWWsmq+c; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8357ec478so24007639f.2;
        Sat, 02 Mar 2024 09:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399179; x=1710003979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f42hWAkceI9x+ucGKynLa/O9HVdUbJVbey5+2rTsSyI=;
        b=ScwJzZdRSpJk2pOcv9oGH7tG4uetNZO9ujhh1+jyJdCrXm0DFebKRtZuwlBXvHDlrZ
         GXMEuMZgE6jsco/B3aBRyYQVwRyvqf1hJkHScpziiRyyaH9hkFviMinR3SximFxKjVL5
         liabChzMy6MjHYc5SvNppcX7yToHomCbGLpTQ2c+miZcHi9CghhVeNuPfOGxmXJDzXAP
         xC6dfN9rJo+UOOiCg1X7j1v82IdLK3XbN1fBTkCmm5sgABibru/d+K0BG4Rl4z5nWjuc
         ZGDvQ6NXs8T3KJjBePKofIz9/mshjeXOGcq/MkMhu8kmVsvWv2baesvBumRafvik7GEw
         qZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfS0RfKj6invCc7TDKWkcE2wapIvb5lh/uh3JA+Zj5HHIBUthrcG4VFf2/8wC/vHnA/kOy/lsROxuIJp0ValDLePOW11lI2NPf11dsDMOUnxMDfoWFJ5dKOzNdEgIPadftC3bl6w5Djgfz5EONRn6sMKIQACE2oGlgiGAPXySY
X-Gm-Message-State: AOJu0YzkuUfp5EBKKUCKgUZ4i6RYW1h6nDn54s/FmGfE/foq/BsYhun7
	R3flwXqIFI0rc0mYI7Pb44XRdt1wgTP8lriqYjhKkDmsFWdYSxHz
X-Google-Smtp-Source: AGHT+IH6DiLAG+yoxNyadLBjdMZLlZWW/rQdF0n+2lzz76Z/yD77v+WTgmwEaBRLE45cHVaFqfAiwg==
X-Received: by 2002:a05:6602:4f98:b0:7c8:3eac:2e22 with SMTP id gr24-20020a0566024f9800b007c83eac2e22mr1138664iob.17.1709399179416;
        Sat, 02 Mar 2024 09:06:19 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p13-20020a02b38d000000b004747b3a095bsm1398226jan.72.2024.03.02.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:19 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f42hWAkceI9x+ucGKynLa/O9HVdUbJVbey5+2rTsSyI=;
	b=ZWWsmq+c1nnTfC4U9vrH0zk9vxnWsQmeVQbM6MLmkzDnrW75RrwgelLEak9xberCI6nXsd
	T+uhrG6UDFMaeAWY3ly0qh9IR2dLaCq+ftYtaqp3UFEJejofdk83VwJVb8lUYMkZ+9A/UF
	TJS5ae5XvVX78L8HwThhGYI/iHlzG4+NVONW91xIiTjZgzPSJv1Aad0C8dLdbEkyCpoXtW
	9gEXrdH0QsPrN+/NjD6O+HA1iUg88D3yyo/7IvpdOGXruAQtdT2lvEjK9ImIm6U8nAXxOq
	KlLT++RZqbRSVSI8w27gtTk+Vyd80KjoVwf7U5OesunWUq3uTFsWuBDtljv2qA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:06:00 -0300
Subject: [PATCH net-next 4/6] net: wwan: hwsim: make wwan_hwsim_class
 constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-4-8fa378595b93@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=S0SNqxhR+Qde3qiIJKcqBx5TILtF21c2fHB6D4dCT7s=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x7PIn9h6DiIn4p0ZhBbaWhSshotQp6jbG0k
 zCYQwu7CheJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcewAKCRDJC4p8Y4ZY
 pssED/9/BSsDoMJUMcQTtRddN3E0h5+/iGPBIJI9CMiHKRv12vxJsVPkGCrD9QOXyQIhHl7krpp
 /Op8uKVMD9U+Gf+y/8qsB3MMYuHznJJ5UTdXsklJECEM/oQvpok3oEWlPrwb9yZZkzPySI15rc4
 BmUNQpvOIySiCSk1hixiAB9bepsZnQzi50xzgfsODG3y8Bo+tjaiGVkMD66C+pbWcs+Ri4L6khq
 IZaK5J/7cB/1ZlFuB8IguXJ2g8NJrt13sxIO7v3iwn2J2hlms/UMW0Ja0FJTaoTaJk8IXP6tnDu
 dOkXJZPU0AzV7qigCi3HhhaAVEPKd+d7/Zhq6pTfqA8YpcSAynURsEDFSqGDVeiOAg+VFp9LnUL
 Qqj+G+bHy4eIXcrT5NA4fHQ52/cNbopm9+UyKZa6Hcq/RKgLWU/nhzlB/8eRtIZl557KIagOFX7
 +VE+OtdCDj/+y7gh749z8DsnRlzIHfRj0RLuInMPzVmxhjqQ4J2PEtwOuv1HJSfkLB/duNyoC5b
 9OT+xSF28Uvs/4pMphSKVaa3hVIvu0C+k1YPA+ImWdgl2eZa3RtAHg+rourMcLbdkknnPvxY7bV
 AnpALrO5c+AL8h9ZUF1FXUEJ0jQ+einKLFa4wF80si47OFxp+M4droDg1F1k4myc1Fsp7jzgzyu
 HaPBHeSkdAqEpeA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the wwan_hwsim_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/wwan/wwan_hwsim.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index ff3dd24ddb33..b02befd1b6fb 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -25,7 +25,9 @@ static int wwan_hwsim_devsnum = 2;
 module_param_named(devices, wwan_hwsim_devsnum, int, 0444);
 MODULE_PARM_DESC(devices, "Number of simulated devices");
 
-static struct class *wwan_hwsim_class;
+static const struct class wwan_hwsim_class = {
+	.name = "wwan_hwsim",
+};
 
 static struct dentry *wwan_hwsim_debugfs_topdir;
 static struct dentry *wwan_hwsim_debugfs_devcreate;
@@ -277,7 +279,7 @@ static struct wwan_hwsim_dev *wwan_hwsim_dev_new(void)
 	spin_unlock(&wwan_hwsim_devs_lock);
 
 	dev->dev.release = wwan_hwsim_dev_release;
-	dev->dev.class = wwan_hwsim_class;
+	dev->dev.class = &wwan_hwsim_class;
 	dev_set_name(&dev->dev, "hwsim%u", dev->id);
 
 	spin_lock_init(&dev->ports_lock);
@@ -511,11 +513,9 @@ static int __init wwan_hwsim_init(void)
 	if (!wwan_wq)
 		return -ENOMEM;
 
-	wwan_hwsim_class = class_create("wwan_hwsim");
-	if (IS_ERR(wwan_hwsim_class)) {
-		err = PTR_ERR(wwan_hwsim_class);
+	err = class_register(&wwan_hwsim_class);
+	if (err)
 		goto err_wq_destroy;
-	}
 
 	wwan_hwsim_debugfs_topdir = debugfs_create_dir("wwan_hwsim", NULL);
 	wwan_hwsim_debugfs_devcreate =
@@ -534,7 +534,7 @@ static int __init wwan_hwsim_init(void)
 	wwan_hwsim_free_devs();
 	flush_workqueue(wwan_wq);	/* Wait deletion works completion */
 	debugfs_remove(wwan_hwsim_debugfs_topdir);
-	class_destroy(wwan_hwsim_class);
+	class_unregister(&wwan_hwsim_class);
 err_wq_destroy:
 	destroy_workqueue(wwan_wq);
 
@@ -547,7 +547,7 @@ static void __exit wwan_hwsim_exit(void)
 	wwan_hwsim_free_devs();
 	flush_workqueue(wwan_wq);	/* Wait deletion works completion */
 	debugfs_remove(wwan_hwsim_debugfs_topdir);
-	class_destroy(wwan_hwsim_class);
+	class_unregister(&wwan_hwsim_class);
 	destroy_workqueue(wwan_wq);
 }
 

-- 
2.43.0


