Return-Path: <linux-kernel+bounces-92885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D17872791
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE321C23356
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8A5675D;
	Tue,  5 Mar 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="EiuGmEpz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03018EA2;
	Tue,  5 Mar 2024 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667146; cv=none; b=a4H1cYoYXhE8czH8c/gHMDv2c+SITjh2L3UGbuI0QqGgV/fDBeXkgSRZv6YkingliFjBuTbtsGTPCusf8ZUUAhnZ1TP4XVr3J2zrWgWbGy4Dl0BKXGmaCb6LIpsS0iQ6xiRmhRj4CUuRswjXVf28seepiH198TxgZjMpk0nMgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667146; c=relaxed/simple;
	bh=u2DKcflytsRux5TNJAnmxRn49lOKyopAtNHMhPLq/uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=slQCN2vXhZNafScSin9WkLF2rQJkjyJD8dq28ENYN7ctMHkTDQKHOO5QdDBfp0+c0oEaR5uUERFnzk9YVvxh+c0ID0rv511VlOnnFDBEvthfZ0VegzpDB7cmfs7Z13Lfcz+rjBwl+9u/B+xSWhUqvz+bjfmVDAHYyIw6/rueGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=EiuGmEpz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc09556599so57400895ad.1;
        Tue, 05 Mar 2024 11:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667143; x=1710271943;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O79cUDhqn2Dgw5mPBHIhv+zmdKjLjBytS1FCvXojXE=;
        b=w/8ZJYtPtFt2mwkinHIn8J7ZNBOReb6wk47sQJqMggfCEOt9XgxxF6BY3V2h/+GOQ5
         HEGk5xG7WC8AughprWwg0IrpJOSY4kSUZYgG2w9WOn1UVzYQwqn/0gTVdn9D7sET0ZkE
         O2lwjklyF0UtYRcX0IlMM167DahLBmIQEA1SfcUvzSZOAGMYpsSUUeq7Ntc5aaOJWQP+
         WusjSyJUIqi7QZMX+pJIxF0mVVCDNoaxrf37JpMuJRbeM+mFzOoEwndZlKUegV/2UPCV
         kFeB6WEHE6EkB6ouCY6uilO0QDziT1qBhK88naRkNKS82S6Y3pHO/zjqRCHEyVzfxmx4
         bpbA==
X-Forwarded-Encrypted: i=1; AJvYcCWmes+U1RC7Oa/b1lHbVKBl9BXgdppk9GEudwcx8lAqrxGXi4qtXfRmbV7+hp6ZahBTpIWoGzkZDaVUfBZvWZhFF02/k43qXY+CW4wZ
X-Gm-Message-State: AOJu0YzC+nf9LeHIeItv+xQLLF/CizD26xlnWaKOb3r6KgdXlUqvpeeF
	lqcGGZS4yDS7nnlQKFrpqqwhmrCEoyR3/Qd7m6Aj4QEkO17PCCQc
X-Google-Smtp-Source: AGHT+IEe7qZzA17peJz8cqbKJxCAkIKIMmYBmvyj0jPleLVqgeajuTmAzBG47fIwm1VCkP63iL/A0w==
X-Received: by 2002:a17:903:48d:b0:1dc:211f:96d0 with SMTP id jj13-20020a170903048d00b001dc211f96d0mr2608922plb.3.1709667143157;
        Tue, 05 Mar 2024 11:32:23 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001db5753e8b8sm10907754pld.218.2024.03.05.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:32:22 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709667141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2O79cUDhqn2Dgw5mPBHIhv+zmdKjLjBytS1FCvXojXE=;
	b=EiuGmEpzTCtK+OGOj612IWcFakLiclepXIGeNSyyXK6CLQQrONaAhJk228FdZlwHlzH3O7
	36nfr8aJRXWu2I6X8s5M4MCs4KhyWHcepV80QsriCpSjJyU3oMbjXjshRDLmaueneqtlmM
	kYTSSgZdnYuDnf8cwax1MYgffbyYEyE0iZw9eV9jn5MYt3NMiacvob1LLrtCFCZQffcngz
	wy+iUwoZo1tUPSZ4sEVXE/GuMoxxLFgD5kzifNF8OuzYKd/uzbMEuvm2uaGM9uwvpT4dN4
	e1YIcR/Rqaw8n7pYnylZKZWVtLwkvZlbnJ4CtwDUM+6njSvqfKP9doGw13RLGQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:32:16 -0300
Subject: [PATCH] block: make block_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-block-v1-1-130bb27b9c72@marliere.net>
X-B4-Tracking: v=1; b=H4sIAD9z52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3eScxOLi+OSc1MS80gLdpJz85Gxdc4uUJEvD5FQDo5QUJaDOgqL
 UtMwKsKnRsbW1AI+vq5NlAAAA
To: Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=u2DKcflytsRux5TNJAnmxRn49lOKyopAtNHMhPLq/uI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53NC9xyOk2rI+vmSqndt1UJwrMA+lhr8Sdg2I
 Wk5VCdrXDuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedzQgAKCRDJC4p8Y4ZY
 pvycEACxKJ8L4vQpmSp7j3jI6vG8qr94KLJh9gjImNx60eYcLeIXrUxPGMmEVjOd2FKnhG3RA34
 g3YIiN4hpKUrSTlYa2nsCAKd8VxCwD3I+ZMSSVbkQyx2p/uAACwW6EYNDtR47mgOJQ6ygCZbZap
 xxsbau9q38Y229qbcVUkYVdJ8QKqo+S9/6GMPdkE4I9bjUSQHxKsR5J1yiuEuMIfTm53eMggKnN
 NWt78vDWU3N9cs2rWjq38OTJBvemiloR+NSG/eJuXOc3j3qJMML4pbM9n6gFiQPJlHb8pJW0GU7
 qU/Do1qy0v99EcUBUsPgZmDGjJ490J55mggoZcdAqDiEgKx0Jbq2TlwQW3ZyxdmiOOeusPUKWEM
 aBn8ONtmav47E9sVZI+fGNYiXma6zmHLLFSn+NPcJZfEtzxKwnYe7TkDqFsk5ICSxpzi7Xks5dy
 sy9qdMN7RGQ+kPnEFRyHw/SjKBBaBqutBvgWTQ4rOkypkLmIp6kYQi/O4e+hxsv3XDsfqvoiiii
 XbZf/6YqFRR3v95h+pIXP5Ll84BcxqF7eRuldORtj4ddk1vpm0hKLaLXyUzVx+fsHfPm7Gz8+vy
 XE4fUbMqhnaZEqYV9tb0bQlmbPOdfvnykp3HpP7gzBbixkd5FiTg82oLmBtjBb8uM702GFEIyUX
 kcOp9WGiMfGWeig==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the block_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 block/genhd.c          | 2 +-
 drivers/base/base.h    | 2 +-
 include/linux/blkdev.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 84c822d989da..a214f9cf3a35 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1201,7 +1201,7 @@ static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "DISKSEQ=%llu", disk->diskseq);
 }
 
-struct class block_class = {
+const struct class block_class = {
 	.name		= "block",
 	.dev_uevent	= block_uevent,
 };
diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..0738ccad08b2 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -207,7 +207,7 @@ static inline int devtmpfs_init(void) { return 0; }
 #endif
 
 #ifdef CONFIG_BLOCK
-extern struct class block_class;
+extern const struct class block_class;
 static inline bool is_blockdev(struct device *dev)
 {
 	return dev->class == &block_class;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 285e82723d64..19c7596f4ebf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -42,7 +42,7 @@ struct blk_crypto_profile;
 
 extern const struct device_type disk_type;
 extern const struct device_type part_type;
-extern struct class block_class;
+extern const struct class block_class;
 
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.

---
base-commit: 8b4ecbe5270032cf73b464b3a25c5eb25c7be71c
change-id: 20240305-class_cleanup-block-78db91ce02dd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


