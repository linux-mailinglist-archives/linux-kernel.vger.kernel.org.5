Return-Path: <linux-kernel+bounces-89531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844586F1A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BA21F20FB4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCC39854;
	Sat,  2 Mar 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aDAOv14x"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E438DDA;
	Sat,  2 Mar 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399185; cv=none; b=jrIK1KGamv7KKLfiTERGkRvBvHUnE9H1YMRoBU0RDKyL/vkg5xnoHgFxYZntcAO2LRxYyqJ57E/oy7MRC3+kcnYfQBwTL1QPMl9om2bvAulezTEPA/HLZx57SspDtUsbZ3f/VkWW9ZY2ROtHx21IHZez01kYjE0vmJYhYjKOq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399185; c=relaxed/simple;
	bh=q6vp3+8mdT9ke18jOPZ8IaTV2bgo1pFOrhJ1Llyor6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW8tiflCBvrMaT3zQvy1GbqyxfVcVwTUCQsipGiyXHEeHe9TUaP4Cp9FqsfvoahWB6KOXX0MLdpWPd/4JSqjNLmL968BXf6Gny9E4pp8QHq22AsKWfeQa8ssCA9gwKJtFmPhEe58P7LSxpfTA1dta2KEDO0eBANpmJVp6ahrD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aDAOv14x; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c3e4290f5fso163376439f.2;
        Sat, 02 Mar 2024 09:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399182; x=1710003982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mLkfb6xqdDWlIC5cLbzUm8KpUhI1ndnLDADNoVaF9A=;
        b=M0fTRq9OM+rDLFSqKXFPHs/cH5JDYT2+KfjhpI60u5mQ3g/3KRlCiq8YMDMhwvbgoU
         GJcRzlEzgTTU3umU96BgqWYCiI4MwyCOYHHM2qWd1zqkNSCiZXs4HjYPzaG97swff/Su
         Y3Wyw4Re1zcCP1rYSsTLkX2lcrl4jmcyObht4ySaZbyKOmz/+o8zd/FXJZhSW+7eiZox
         n8eE6alEO+jM88hpmaKxhF908QagGVW+qXx9W5h+860AYUaJMKibzF+CUAaAKQty5uXj
         DHhzbzq2Otlb1UOnrX0LJfy7QITVXGJUPAog9U6vzZGY3rzbPNFCNP+L5KWzPU1FcNHF
         5kMA==
X-Forwarded-Encrypted: i=1; AJvYcCVbGLCyvdq5HDYhl2m5f8W45pmEjLo5o3pA6NjfrY26Yj1AUH8PKwuovCDWq2Pdy8uTehaBinnMIFGm+wf7fxd98lUaoN7f6wM8uXW2Wd1oyDWdGWepyjrt76LUbXzAC4ILWOuYz40gXOKq9cP6+htatotFn9akCQYCQ+SAzZl7
X-Gm-Message-State: AOJu0YyXIKTlbF6dRvFxTTC96FN2fC5JKTwN2av786Ad89J3YOeasj3f
	7LpsaFpo8IIE6jjN3ctI/R0YypC8GvWBg8iag9sfXYE+y2nKrBtHXzBqtWPB0fosvg==
X-Google-Smtp-Source: AGHT+IE7fooeYIZALUK0/kkpc3s4J/o5B74kIXovwl27v578kcY+B4eSsapjiou0IV3VjBQG9dorSg==
X-Received: by 2002:a5e:a907:0:b0:7c7:a0c8:1730 with SMTP id c7-20020a5ea907000000b007c7a0c81730mr4581815iod.20.1709399182535;
        Sat, 02 Mar 2024 09:06:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g16-20020a056638061000b0047483de6cd5sm1396756jar.112.2024.03.02.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:22 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mLkfb6xqdDWlIC5cLbzUm8KpUhI1ndnLDADNoVaF9A=;
	b=aDAOv14x5ldmESwgxyc7EO7SJhHTbh2dMxMz5UFZQxZNa8HYhEVmDNQhpnMgJ+G+t8N6ZC
	U5h+hI3lXs/fD1T+DfepLjjR52tmEa5Rr97fUXAnWNDwfXSUchSAzct2iXuR/WKnwN06yC
	j0rHtZHODPtQZ58foww1F6L8vGzmid/ttmIekOjXvuTRjbllNMktpBnwTmdRtTSlpaiFWZ
	8sTVepzi4c1mpvvRcp5Wc3RVZNwU9XGV85fB45q8SqEXqvZluCSVxw/VdG1/nLF9dZuIQ0
	osrvErQjyujq8b9rXTC2mRrcrIpBan9UXtczmiwNuvOhpUkj8aOUj3Yt9ID8Sg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:06:01 -0300
Subject: [PATCH net-next 5/6] net: wwan: core: make wwan_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-5-8fa378595b93@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4775; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=q6vp3+8mdT9ke18jOPZ8IaTV2bgo1pFOrhJ1Llyor6I=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x7MzsX/wA9I0357Es+CRJdK5xDsj4ES4Bh6
 g+gaAOs/bmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcewAKCRDJC4p8Y4ZY
 pgMsD/9kOsyQD5q2v4UbGn6nyAJ/LT0AnVADF2uBv7N4SW6lDlbgN44QlXYoHBgvuR8rg2eQNj+
 /WME4E/6OGpY30mmAGt8dAv5UcesLokex8pWYi43wgwEwg23nvV8U5hJmf6pJZ8GOUofVcv5GdN
 ZOpgGz1XLl45Hij0XNbNXMbFOcGqRJkCo/jXUDlE8SAOUOEnvr1UZh46Wo8RQtu8QBWRT9ASTA/
 hw6SY1wuoPu4tUJ9BaQKU/OtXZIOcoGwSMmtvST3fEsD2AKNVZ5pMC17eg6EBtFoILED/7Min3A
 T0rhmDzmCjh1PK8MytJKZZWEVb2mCfh2OQTaEZZfDjtjTE34X3T9onoz5P+ii7VItvDxs11L+oY
 VgMuLdPbe6xK4nqY8b2Ef3t16znmSzvVEThE+l+6iBMjvjtMUBBL9lnoKjFdoarPEJoNFXq4TVV
 Yr5BlukkS0pmXWwa/eKQpl/k5npg6Y/mjBTlIBrCp15/YxxM2RxhKzTRP93DB4wmpLdZiuXgp1n
 c9tAsWal73m+MgwsAhOwd4s6B4UIc7xZGRVSg7x5JeDrpXU1o3o5kPgMi67mYp58hV8SICK9AgJ
 gj0U09N9Mg25zHHTAMhhZydx1oni7CSLvpqmQWRcLkP6BSUduSVffjeq81NH8hRycMmqLKxyJX/
 ui18cJ/50YCASPA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the wwan_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/wwan/wwan_core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index b0030f3ed0f0..17431f1b1a0c 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -26,7 +26,9 @@
 static DEFINE_MUTEX(wwan_register_lock); /* WWAN device create|remove lock */
 static DEFINE_IDA(minors); /* minors for WWAN port chardevs */
 static DEFINE_IDA(wwan_dev_ids); /* for unique WWAN device IDs */
-static struct class *wwan_class;
+static const struct class wwan_class = {
+	.name = "wwan",
+};
 static int wwan_major;
 static struct dentry *wwan_debugfs_dir;
 
@@ -130,7 +132,7 @@ static struct wwan_device *wwan_dev_get_by_parent(struct device *parent)
 {
 	struct device *dev;
 
-	dev = class_find_device(wwan_class, NULL, parent, wwan_dev_parent_match);
+	dev = class_find_device(&wwan_class, NULL, parent, wwan_dev_parent_match);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -147,7 +149,7 @@ static struct wwan_device *wwan_dev_get_by_name(const char *name)
 {
 	struct device *dev;
 
-	dev = class_find_device(wwan_class, NULL, name, wwan_dev_name_match);
+	dev = class_find_device(&wwan_class, NULL, name, wwan_dev_name_match);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -183,7 +185,7 @@ static struct wwan_device *wwan_dev_get_by_debugfs(struct dentry *dir)
 {
 	struct device *dev;
 
-	dev = class_find_device(wwan_class, NULL, dir, wwan_dev_debugfs_match);
+	dev = class_find_device(&wwan_class, NULL, dir, wwan_dev_debugfs_match);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -239,7 +241,7 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 	}
 
 	wwandev->dev.parent = parent;
-	wwandev->dev.class = wwan_class;
+	wwandev->dev.class = &wwan_class;
 	wwandev->dev.type = &wwan_dev_type;
 	wwandev->id = id;
 	dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
@@ -265,7 +267,7 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 
 static int is_wwan_child(struct device *dev, void *data)
 {
-	return dev->class == wwan_class;
+	return dev->class == &wwan_class;
 }
 
 static void wwan_remove_dev(struct wwan_device *wwandev)
@@ -375,7 +377,7 @@ static struct wwan_port *wwan_port_get_by_minor(unsigned int minor)
 {
 	struct device *dev;
 
-	dev = class_find_device(wwan_class, NULL, &minor, wwan_port_minor_match);
+	dev = class_find_device(&wwan_class, NULL, &minor, wwan_port_minor_match);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -405,7 +407,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 		return -ENOMEM;
 
 	/* Collect ids of same name format ports */
-	class_dev_iter_init(&iter, wwan_class, NULL, &wwan_port_dev_type);
+	class_dev_iter_init(&iter, &wwan_class, NULL, &wwan_port_dev_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		if (dev->parent != &wwandev->dev)
 			continue;
@@ -477,7 +479,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	mutex_init(&port->data_lock);
 
 	port->dev.parent = &wwandev->dev;
-	port->dev.class = wwan_class;
+	port->dev.class = &wwan_class;
 	port->dev.type = &wwan_port_dev_type;
 	port->dev.devt = MKDEV(wwan_major, minor);
 	dev_set_drvdata(&port->dev, drvdata);
@@ -1212,11 +1214,9 @@ static int __init wwan_init(void)
 	if (err)
 		return err;
 
-	wwan_class = class_create("wwan");
-	if (IS_ERR(wwan_class)) {
-		err = PTR_ERR(wwan_class);
+	err = class_register(&wwan_class);
+	if (err)
 		goto unregister;
-	}
 
 	/* chrdev used for wwan ports */
 	wwan_major = __register_chrdev(0, 0, WWAN_MAX_MINORS, "wwan_port",
@@ -1233,7 +1233,7 @@ static int __init wwan_init(void)
 	return 0;
 
 destroy:
-	class_destroy(wwan_class);
+	class_unregister(&wwan_class);
 unregister:
 	rtnl_link_unregister(&wwan_rtnl_link_ops);
 	return err;
@@ -1244,7 +1244,7 @@ static void __exit wwan_exit(void)
 	debugfs_remove_recursive(wwan_debugfs_dir);
 	__unregister_chrdev(wwan_major, 0, WWAN_MAX_MINORS, "wwan_port");
 	rtnl_link_unregister(&wwan_rtnl_link_ops);
-	class_destroy(wwan_class);
+	class_unregister(&wwan_class);
 }
 
 module_init(wwan_init);

-- 
2.43.0


