Return-Path: <linux-kernel+bounces-89528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251F86F198
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4964C281116
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AE36B1A;
	Sat,  2 Mar 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="lgO/EBdK"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9A3611A;
	Sat,  2 Mar 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399175; cv=none; b=dtRvAbHf6AxWy6ModuNAAP5lNpZwvDZ+zQLMyICfa6to0oE8ZNI5DDs/Vv6ooNtOnGOElbDpXs465XbakRlfxuz47vMH7TzHXZAFGKp8E4qv4GAX6d0rW7MbsACn0PIBoih5Pj8Xkz7BQ787Vuw286HbIKyqvUwft+bhpP1/7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399175; c=relaxed/simple;
	bh=qXay6ldHY4MUDiGqJdsMIllcHV6D4WAZhf81UWPWDoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2OWiTLR38edOOJplfoeAOfTxpTufnL9Tc6fOtrFCdDXAf923ArU75UC4Zndq+h1WaSSm2mwcrZqn9S3KBD6NuNcBeVsLVa80qNCdfaHQ6dWWIcUimfERK5CiMA7ChYF6K3aiKeKliSVXvo953drKdLqSbujjS61kc1AxIVjxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=lgO/EBdK; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c83fb0fa01so7786839f.1;
        Sat, 02 Mar 2024 09:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399173; x=1710003973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkQknDhSkTPBEJcvBIbzf1xbfRszRdjUE62WGVlTBO4=;
        b=EBdA5e5FdUSkfCHHH8Fo/byQMSHNqSVGZTVrttFhAVBwRD8wusMtYpJ8QSo9y+TFPQ
         l3FUCB34c35jfld6Z+mj5l19SezhEKHfAT90TPRzFrkld9JPnexTUlcjrGU5wWTBxc1r
         rcWm9aT7sPqIG/5KrTPOulZd0egndXcKUEKNRetJlzAj7jogjPYoU//LPQ9ewKN1KZt8
         aBTDo6ajWER6jtKJe8fA+aSfHIDymHsTX5/vTBKzrgTvGzmyVNqqYKfpcGGi1Ape3MQg
         CNANUa6omnXAHLRlcjxQQKf3BmOueLf/UOCmWjJwJpuOtEOyjai/3TGQorD0ryQoXYqQ
         vnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTLNqr1LnBOv5lv4EnTan0SML5dRH7GGSHLqPgaVcsMni9p2oFj3eWq3Coe9U+66wuiYF2Gj2EkcySXYTdBBWuOSxVTx444NlbmGkueJ/5AiziVV4QYkGaN4GmkrpziMIV9hTitNthm7uV/Hxm1QIwkPoYxJ2bckd77LSZDWU5
X-Gm-Message-State: AOJu0Yx/eXi0sVpE0oq5uwrrBb42FMaJcbi/3WDmT9/VjDWAhvw+p4FQ
	SBQ24ZxSCVTQL9YFBG902HCb7Wtq5cEXGRZTySJy+khTRNp45Wxc
X-Google-Smtp-Source: AGHT+IFKF/0fnojS8dxwoFURRfUU/yhv9Uym47Vom3oagAguAiEImvIVR1Th+CGHFHqktJ9Igua+4Q==
X-Received: by 2002:a6b:c301:0:b0:7c8:289b:d52b with SMTP id t1-20020a6bc301000000b007c8289bd52bmr4340149iof.8.1709399172846;
        Sat, 02 Mar 2024 09:06:12 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h18-20020a02c732000000b00474e0f1bb62sm198211jao.147.2024.03.02.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:12 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkQknDhSkTPBEJcvBIbzf1xbfRszRdjUE62WGVlTBO4=;
	b=lgO/EBdKsFURB9BjvQggwYhV74BArdT6Bi/vX037My5uVUG/BXFzBS63RoaYO2HDAwozUo
	i4ZS/cmDWWyCFtkwHw8nh5S13ozzdXe9Izdro4kRR6nDKlkmIj5hyZo7dUkMkzkqHFejNK
	KxTwd6/Xv2UwKU7cLA8RfINnbhO5r5YmDkuH5TtOtiL2dWmW3SmhZmCGKkHhhf1ik095cB
	k6HvBfbQL2OFrxZZbzWzxyW8g69Dv0GG1PEE8gN425vb44HnDK/mNBDxRq7JAQnLAZAG33
	WQDLd1bUtfg0jclutPpMQVOiH782EAuax17TVjVDICFOWNzFOYQji3ojMkPlPg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:05:58 -0300
Subject: [PATCH net-next 2/6] net: wan: framer: make framer_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-2-8fa378595b93@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=qXay6ldHY4MUDiGqJdsMIllcHV6D4WAZhf81UWPWDoI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x6FpvslPW3+Hnipoif8zG6NNz9vWUarnRZj
 Vh5HSjveB6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcegAKCRDJC4p8Y4ZY
 pj34D/48JcGskms2QqJ/QIvcNXC7rWmU2a6pGLoYtM0/eqQ3kUBSubHO/80oGkaXc7p5n8EcmLY
 gGvthKP5YMVqBj7FNl/DDH8R6GyjOHovYgveUAmc4y3B1i+ve4oLwB+4YUtQRU3nZFPPAPjfq1e
 rjR0899LBcfVlNnAdp6ZD+YdUmEyuXAHOzKwOvud3SlqaoeBC5V5L4RDBnl9aZ83Fa3AXuWIDPF
 Rrr4iEz8oPBlLOnZjJ5KVfpXTozms80A0yl6X0J3iOaFSb6LHj0keNNXUl0d1DWJmBYN6CoYObN
 dfrUMqFTbQDV9uV2DMifAZiFdFZeK6TNmRoyzHcc4jaJBzuEj4HNFsqeSFPR/Q8YA+EIFRf7gU8
 zYHAIkNiN9N18pvvQ1fRUkYUZEBPUsEh/oOxnc0Lws5z9qMvFnh45UP2bOoAnkX3H43+rng96Cr
 s9rJ91xHws11tSYD29NPBD+5uCtgO9sRWqrs2OPZb5Nsm0wCR6IQtUkdy11Bs0S54KorrKBzFb8
 NbQrO/oHCA2BtoEQXkRvfcQBMsA5YAZrGUWwWrEecHfoIMj70TYiLoAF+tdcVMnm8ZaxUfNH+69
 /r/egaQB6tSElV/w4fAzt+1b3+r2kJtnmmLMNJzZNVt5MrvjDqBFyAVcQ6eQ/xr5qaevdWw1A6k
 LzwYgBxJnLTc+5Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the framer_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/wan/framer/framer-core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index 33b358b99f70..f547c22e26ac 100644
--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -18,7 +18,12 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
-static struct class *framer_class;
+static void framer_release(struct device *dev);
+static const struct class framer_class = {
+	.name = "framer",
+	.dev_release = framer_release,
+};
+
 static DEFINE_MUTEX(framer_provider_mutex);
 static LIST_HEAD(framer_provider_list);
 static DEFINE_IDA(framer_ida);
@@ -627,7 +632,7 @@ struct framer *framer_create(struct device *dev, struct device_node *node,
 	INIT_DELAYED_WORK(&framer->polling_work, framer_polling_work);
 	BLOCKING_INIT_NOTIFIER_HEAD(&framer->notifier_list);
 
-	framer->dev.class = framer_class;
+	framer->dev.class = &framer_class;
 	framer->dev.parent = dev;
 	framer->dev.of_node = node ? node : dev->of_node;
 	framer->id = id;
@@ -741,7 +746,7 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
 	struct class_dev_iter iter;
 	struct framer *framer;
 
-	class_dev_iter_init(&iter, framer_class, NULL, NULL);
+	class_dev_iter_init(&iter, &framer_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
 		framer = dev_to_framer(dev);
 		if (args->np != framer->dev.of_node)
@@ -870,14 +875,6 @@ static void framer_release(struct device *dev)
 
 static int __init framer_core_init(void)
 {
-	framer_class = class_create("framer");
-	if (IS_ERR(framer_class)) {
-		pr_err("failed to create framer class (%pe)\n", framer_class);
-		return PTR_ERR(framer_class);
-	}
-
-	framer_class->dev_release = framer_release;
-
-	return 0;
+	return class_register(&framer_class);
 }
 device_initcall(framer_core_init);

-- 
2.43.0


