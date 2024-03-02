Return-Path: <linux-kernel+bounces-89532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B711D86F1A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716772817AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69B39FC4;
	Sat,  2 Mar 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="A5izTxCP"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71839875;
	Sat,  2 Mar 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399188; cv=none; b=qZhwICAWIPu7XT+y2pbA94CKL2KzbZhpsNr4r/bJmg9cR3Uf1agi42sZ775/fjgX4nHPGYXmwIrFBl4jJo7mH1nyIvkm+umVTIkAPplFJ+dG3Gl5ew/OvsXbdkyY4eeY7i0Q6r3UCVnXqYN24RGGRN3XRPEf4Ch0rEgrx1E0NqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399188; c=relaxed/simple;
	bh=RjXjt1NVx4j7b9346cDcfgKuL3rftAXS2K6j8XwIzlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJVtXlQGtrkuPsw+RyMiFGxel8ab6wZLeX8TacK9CZ8MbB+TB7kwBgDGSz30ghI+S3mJMvsazsLEwdr6wa+SHQzXrEiDZddj4uHt9VnLGDi70ngIq67ERVC5wr7Zb+0wCKz4Xg3RynbLTDpuGRf2208I6Afwmp13PthIyWILHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=A5izTxCP; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365124888a5so13393275ab.1;
        Sat, 02 Mar 2024 09:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399186; x=1710003986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgdVXHvgkvHw4/0cMMKmouN9K55qBEYKyHuKSXuZy3E=;
        b=uZqhM6BBlahp6p3dPtN4fHxWoGYQthDwr4rm3v0H28vk0yEAH6KcpFPz4ZSsrHqi9c
         1hpK0PYJb06FNkyRqNzkOvVqWyrh0GMta1qQe8PeTgoty6uq8cWzfDfHo3TEhqyinVXV
         MdLihk36E4nF4j7+Uis5nOkkZSHkitGpk1z57I4AFlRhG5GqZuYU8WEWAHHfMQ7Tfhsy
         beaNIM6DW34lu6rN9FuRJw9Hms+dJVWng14esbGOhDi5MlTzq7EPQHWGPedkGDrDn7Uo
         dwoutWqh7QgNdhzK7pljA4dvXOkR4P2ZVf9a0X2FZqU3u/UMeDr2JP8N/Iv/57r/Gzt5
         JtYg==
X-Forwarded-Encrypted: i=1; AJvYcCVFShziKS3AHiuCO3UHoPKUlTU5UknxgVXbJ1cowVeSIVkh2GDc75qOuq+Ju9olZru7aAjq2l2N9sOjUKP0pM0z7dEZPKMVXG1B7/WkdIaw/uWupRlUX3U2T95oM9QBIr5aosj9m3UvqwmpW55ATwseIgEmDUT+shMHuYMqtpWG
X-Gm-Message-State: AOJu0YzDfTY/B1fIQcB2bBAbTltpoyBqSpgWHj5uUPYGJ6BTvtdF0PrY
	EvjXPYNe+lPWcHnE9gxj4ff7JcNZEmeNiQDQSqP0Qu1fdjosdc2v
X-Google-Smtp-Source: AGHT+IGqScopIYaWExKYSKE+wXbOE4ju4s01FIFYrrZLOie5j2BAoAnFAHi0FszEsa42Zmj/K5hOVQ==
X-Received: by 2002:a05:6e02:1446:b0:363:eb84:6510 with SMTP id p6-20020a056e02144600b00363eb846510mr7038861ilo.15.1709399185723;
        Sat, 02 Mar 2024 09:06:25 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b00365c96b8afesm1484366ilm.46.2024.03.02.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgdVXHvgkvHw4/0cMMKmouN9K55qBEYKyHuKSXuZy3E=;
	b=A5izTxCPQUMOvxjWUkAaRvAXXdEIIwB5dxIlFcQ6YN2UE2KhQWVZMVXVKlZ0xhTu84ab4t
	/NoqiWNJdJS1/y5uRbifqYZpzXaw8ovURpp4HUAiMFEYhNPEMWSC9cA6NEqxAOC2TLETi3
	jtgsOCA20I6nDSV/GFYWd2coCI/dedQTsvX0r2rweqDAQhDWS2RZ12LEilRnNFXkQhs91a
	fd2nbRe6O9ghqWSe0rIOZ6A6Hu7r3iP1sM7zm1jCdvIV+JVN4rtLFz4ck8RlL7+4kYyVTX
	e8MDL8kA4O3+c2f8N7+kZVzHniT5oXKThcR3jUc21Xed1S0YF+3uOSZnZZTVYw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:06:02 -0300
Subject: [PATCH net-next 6/6] nfc: core: make nfc_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-6-8fa378595b93@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=RjXjt1NVx4j7b9346cDcfgKuL3rftAXS2K6j8XwIzlA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x7UljchVXqzzeheliAXHiwmVVPomgpjJ81B
 Qvxil2AGHyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcewAKCRDJC4p8Y4ZY
 psBiEACloaR3I+KlMlQP6bdgs2Omb7gHKuCP7TLGBlE/H4h4c6nHlEl9tT4Wml40Texp3s2iIka
 wn9DNbFCqwCnSJbJyYaTttyw9udThAsNKjZcc2cR3n8oFi91dx4curJ3qAuMIx6UoIt5+bsqPV9
 0cuBde+UueKdiHUGxZ2QepqLDY2EEloTTo0Hlc5GdPFi3ldnGdfpvnwB0XITNmqbV7lDshKLosf
 C5g11XgnlRvilsUW24l7UC2EJ2tmga1El/rjkA9L6I7rCE55i/H1dw7pismAsRiBMQQjqSoS2pw
 NzzWRMeSuQTUFktWLJsyH4ZyUoAtvnONmp15OM75dvba8DlhrCmbTZzkHxX7lr2MW1qRK/icanQ
 C6+yVM8Awrk2LG++Y1Rnj1vo+31ekHHCjSHHEqn8oIUCv9bSNWb20RPeutQYowXiu6O+jGIT8Rg
 /kgZ7SL0rvJD3xkqeHfUdPe/1Mpwy2gANfpHkPq0lALgSZ46ldc4rtDuGiUxQMH/XJKMEDrEErN
 jLOAzfT0pQcnLrFmHIHnfn012qKCDbc84X5zzC6VBqOtcTFtuhfTqilUSGhDTUGpsRJe5bUu+5x
 ds6p9uIE1kefmgHvz1k2MJz4BV+BhE9ih1X2DdXn/n+BcoiYyCxK1o6ntztJ4I2Jwvix05qCfRI
 wp3B4QTHeK0XJYw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the nfc_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 include/net/nfc/nfc.h | 2 +-
 net/nfc/core.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 5dee575fbe86..3d07abacf08b 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -196,7 +196,7 @@ struct nfc_dev {
 };
 #define to_nfc_dev(_dev) container_of(_dev, struct nfc_dev, dev)
 
-extern struct class nfc_class;
+extern const struct class nfc_class;
 
 struct nfc_dev *nfc_allocate_device(const struct nfc_ops *ops,
 				    u32 supported_protocols,
diff --git a/net/nfc/core.c b/net/nfc/core.c
index eb2c0959e5b6..e58dc6405054 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1015,7 +1015,7 @@ static void nfc_check_pres_timeout(struct timer_list *t)
 	schedule_work(&dev->check_pres_work);
 }
 
-struct class nfc_class = {
+const struct class nfc_class = {
 	.name = "nfc",
 	.dev_release = nfc_release,
 };

-- 
2.43.0


