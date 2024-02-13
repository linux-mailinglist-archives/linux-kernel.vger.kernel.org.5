Return-Path: <linux-kernel+bounces-63706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A285337B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60806B26D09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A857895;
	Tue, 13 Feb 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="GFjrFfIV"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498B1DFEF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835551; cv=none; b=g1hPh1H+A3r/mm1fLXqqRfDwRNivlMRRvFNIplUZTe+hyTMKr7Bd8NcLf69jJBrEA/Azixq/O+Pb2P0i0henRi0IVLUuQHmow2GBJ1+QNkuT5t+S1SBqqxN/M0XZR6DbF8/24jEAv7OLq4HfnnYS0QZ/PaX3PjSr+RBoFl1qLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835551; c=relaxed/simple;
	bh=/JVw6JUS7Qlkpf9PDVKxppJuv27t2j/1nfrrHYHsvoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YU+nd5HofH0dNfj5I9EsY0CdviYuMuRAHZRcE815XpO2HVYvB1RcXbqJEtkKS8Pcxy9buYr0wrXXJo0XEDtLM+4yS3ySu2Yfkl2F568OjiXQY1pjDijAgYYzGsx7KrEi2RbkB5DzY03bYgbrIes1xgfJOQZrNy1aiNkJajSuSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=GFjrFfIV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0a479a6cbso1622665b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835549; x=1708440349;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCwgMbwC7An3DNn4GGPR+ZW0r4hzwBM1GqjFa3Sruew=;
        b=HvPvG1wUTXxB1sdoBs3AeEuJ8f62DnVHB0R0KhAAxygEvqQ5SWYwZWgy+s/wsHp1OF
         7b43yHdUCkijcQCDCdtYM8ZJXYzMsQMC9m3PHXhjYQnL6SVFigT5Tm3t+ECE58uBSr/Q
         hsRHnxX76T5Qfnwvocdyv67Ou3pOnP/crHnVAWZ9IYcNSJkI2pj3Y7MTp3HQQvltLy0v
         RYK2LtItMS9ul/4mptolT4qz3AOOEgLG584UOCIPkzi91Q952R/m8CLbpC4HtCOr7RBq
         tx78YnD7QdM2H4IuBcHt+TPBInQz9QZOVqJqTHimzim1pU937mRvnOgdfHPtrNCK0MpG
         i/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWNC6KjIdqcKFII38d8dnGCP0VZBB48ecBwDK+LLRkj2W1G1RPJsdLDyJqd7wUqDHoZZnPpIX3T9LVbh+2ukKBfpal7xMix9rPUzdJe
X-Gm-Message-State: AOJu0Yy6/ix455cIpzWpB9BIIcrM3M6hfEQTgFOxaI3M1ruUL42wZg8U
	d/IsFLEK61JBA+WO3WyhgC8j9WBCxOHUrRgsED94gWjY8j6Qcn/oJmllNS2CB3e8Bw==
X-Google-Smtp-Source: AGHT+IHdMS/zz7eyofrJyTFol3uk6PD7CEhbj2N42d5cBaFZh5PQOz/Eq6MNFkW9CnlzMSQEKCHOHA==
X-Received: by 2002:a05:6a20:e614:b0:19e:3a9f:f925 with SMTP id my20-20020a056a20e61400b0019e3a9ff925mr8138159pzb.14.1707835549331;
        Tue, 13 Feb 2024 06:45:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtAjLGCjHI3cOozF0Sk8MS4dleiqvFOOVS7wzvZ2e4O4Mzn4qs+iQGBUmDQv9mWtn/qZUwJwl5+jgqgJmnJYqEHvq3gzvOs1CboO3vpt2RBT7U5V+PN+Lo/RaE5UKLfhiC0y+93xm6atCs2QuPj8nWmbRoGLOr89+Pxd3auD+j
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y20-20020a170903011400b001d9d4375149sm1280232plc.215.2024.02.13.06.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:45:48 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCwgMbwC7An3DNn4GGPR+ZW0r4hzwBM1GqjFa3Sruew=;
	b=GFjrFfIV5EBELI4zA8+4T4IAoxBjxoJI6zlwYm5jht5E1suU+I78mkZo9qhCxDYpd3jn3R
	dHov23cbkUklp+QKGKAOA8ukaFCnl3bv63CJBRyGcpA0byImRCLTTyQ5KQxrEbT6uLk+JL
	jf9dsz8DXmWtECbWJw4bFJfm+fr4dhRM0WxFPMbVFXe3gYO+oNrjkLYShyZ+lCKd1STVMc
	VsHR0bkL6E2D3HJd0tv3kNhRcsZ0h+6drl0dpwsGpyizXzxcac3+O1wGiBT66uiFbiZJTW
	Rpg5MdyCOnTZmSNbc/b83Mji8qDN5+mD4Fx2tpRem1kjeyQhs+EXy3VceG99+w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:46:25 -0300
Subject: [PATCH] tee: make tee_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMCAy2UC/x3MQQqAIBBA0avErBNyKqKuEhFqUw2EhWYE4t2Tl
 m/xfwRPjsnDUERw9LDn02bIsgCzK7uR4CUbsMKmQlkLHfxsDlI2XOImEgbbDnutzdKtkKvL0cr
 vfxynlD6MhzL1YQAAAA==
To: Jens Wiklander <jens.wiklander@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=/JVw6JUS7Qlkpf9PDVKxppJuv27t2j/1nfrrHYHsvoY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4DDQ9wKZ20oNtPX+2IiSw52LstvRyeEqj0c/
 cxZ5DctXOWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuAwwAKCRDJC4p8Y4ZY
 ptimEACUJ9WmQFcj7VNoXIXx49IP+fPFbNgZhh2OL2TlibLbBoMImQQgUM+/DpMfhUzisPLbxAk
 4RYldBiJUSeBOZylG9vGlkcHiA+XIAYZklbern3w2HgO93gfoBGIyBZty2d0C2/23dUGN5aKqnd
 HC4ueJUfGgGeJYBxp2+W1HvkaPVoR7zJvJhTGiL3/TOTAJTLeo+DP3TEoCaeyCFLXyGPEIr7Rf9
 1htOaH2Jv/Yg+LAw9nXs0+IfR8rVUKAKOSZBj/YBf8Fe9/syfLN9lE2ln4bVNrxMffCji2udQvk
 Aonm36uyIj7n/QHL0xjCnFDb/ETcs/XZyHLQqQiHt4G7KI+028dnI5e7sO2IV0MFXWx3Qas5bpB
 5ytXokwwcW0WPIxcLXJxDWKh9/iio7eBtbIe8nMe3RttGxiIbjobYkr1GvHYGmNrN55yy1EwE0g
 UmxZEwG20fw2lLqi6cUUHewoKM+zfmYjEYNaQfKFba7sieYVjiRAC4k604QAvblcZKUVpLQEQzn
 Sx5AsA49SWPrm3s90vjHXRtOan1UvLGAfKeCxerTv4W+C2hXvVQ/mw++iDJ/CgtK4rI81XVhqBa
 83fuK5+W9YR5XfQJc7/IbrJ+uFDO922hgphXtwIUbzt7J0ucD9DN+L2d+cari5UxhBMXI4W8UT0
 qP2YR4lM6D3bZ/w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the tee_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/tee/tee_core.c  | 2 +-
 include/linux/tee_drv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 792d6fae4354..e59c20d74b36 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1226,7 +1226,7 @@ static int tee_client_device_uevent(const struct device *dev,
 	return add_uevent_var(env, "MODALIAS=tee:%pUb", dev_id);
 }
 
-struct bus_type tee_bus_type = {
+const struct bus_type tee_bus_type = {
 	.name		= "tee",
 	.match		= tee_client_device_match,
 	.uevent		= tee_client_device_uevent,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911ddf92dcee..71632e3c5f18 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -482,7 +482,7 @@ static inline bool tee_param_is_memref(struct tee_param *param)
 	}
 }
 
-extern struct bus_type tee_bus_type;
+extern const struct bus_type tee_bus_type;
 
 /**
  * struct tee_client_device - tee based device

---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240213-bus_cleanup-tee-c25729bbcd7f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


