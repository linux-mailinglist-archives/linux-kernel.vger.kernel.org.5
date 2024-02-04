Return-Path: <linux-kernel+bounces-51868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BD849042
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E731F21EC0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451028DC4;
	Sun,  4 Feb 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="ec0O4p5Z"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E228695
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076964; cv=none; b=EWf4ERKlL0IzPkhvGiXzOcq6DO9I/zsrRMtcHeosUBj5d1lZrzUgZ1QDvpWa56L5TMaxu20F/0wIrJtT7Ml+m0WuVylUc9ZUCMUOzAIV6bCks6iSl1aprB/zDfAG0UCLw+0kSvw888jmb+IlVy674D0z5e+Yjq0sOwV2Xi8AjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076964; c=relaxed/simple;
	bh=h5wa1peYT9Kl9v4lgKkr84GgccLobvl8mvxpbVMbv8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fGlL7B7jgisfXvDVHVXlmQ2+vxighxJ6j0uMo98aGxv0mNNCnl9ls0DFk1l+gfND2iHmXhewPdyy5BA7d9JNhdc+ZAyixcRnGD2cWfbroTpdmy8zQcPhYGsTABtdDR82iHlL6prcNBJFiWH1Jlbu+Zo7HJqD3QBctBNlfdapu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=ec0O4p5Z reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6de3141f041so2555966b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076962; x=1707681762;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E9X4tew3NaFU2JPshrjw1Wh1+QHGp0+NjSfhj+R6tE=;
        b=OhQWfHtAmCnq9OG5CFaD8OdrBbGj6/DRlzAuZ4Hag8ym0vnOPp39ytJUcL4BVKYdCo
         t+cyDss8jhRDWg7DbJpX97nMNzhybCwmz+mdEaLT+XdrHWgIWqBcfHICH9uNrg2Ss71D
         IPodI/vLZWce4y6sg+PkF/pI9vhdGics/P9DmCSvmWJC0xCFg3YZOyM9EHBy9K1cYVGS
         MNKYmDqMGyoZbD/UFEAcAXzQ5yorBA2m/uxju0INUGjoBRYGj/BSb3lmvmSlAjivvKWG
         ph4UpqTB2UBnsYBkGTWcuUuigDCr1UDtQWEB+Pr4Nd2CKOyBVOs16T7ZdLQZSYT3dBnV
         uckw==
X-Gm-Message-State: AOJu0YwYkcBZZ3qYflCiMJLMGQ8RhB9zDB9QwZzvHh8h5+kq4/4b7D0q
	HmlKUSNk97W5l6kHKd7ANJ1RXqLu+cEdu1FACaAew94dUftgvccc
X-Google-Smtp-Source: AGHT+IGHhqLIc5pG1rl6CK7Y1OEsQ3am0Qs+Ybit6cFgmJGL8aYClPeQDhQbws2s83DKTKFsJ60sng==
X-Received: by 2002:a05:6a00:b34:b0:6e0:2f37:ed0a with SMTP id f52-20020a056a000b3400b006e02f37ed0amr2137260pfu.31.1707076962150;
        Sun, 04 Feb 2024 12:02:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXyOJ3t0vY6hggWSx9o/89QoYHA+lnB060C4vxPOFjws+g9cEItthnXh02pGwiUQG5p4JiSe1dq32ZQyer1nWqAeHT6rFLNai2BRg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ka15-20020a056a00938f00b006e043d3e5c2sm514531pfb.162.2024.02.04.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:02:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707076960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1E9X4tew3NaFU2JPshrjw1Wh1+QHGp0+NjSfhj+R6tE=;
	b=ec0O4p5ZlJq7l601VjMM0OBfRsRnu/vfqLs7/jxeShPFFxLamTgVdZlgMMYzq/YXTTeAmL
	/IvAEWw/SwwA8n4AeD4hTh/3UN+L+1iY52Qe0DDnRbL0RoT6UmQQPsyIWGpAMZtljWgwUG
	pP24JGRRg5RSE390ZlOyZ5XDW4Z/R6nhGXivAgTxjWl/46yfj4z2g3l7gV0QKY4vixE7Xb
	v/QqDNLlvZAgKmCCy32NLDL/QgNSp9vMUFRJbVIF5YM/4cH39sHYkMheMZJKRXPSRXXI3I
	Ak2SfPw2fIO0T0vEQqbyzxbnUQD3ASd8OXcvStMVFU03cIbG7flUr3kYxDHhJw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:03:10 -0300
Subject: [PATCH] mcb: make mcb_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
X-B4-Tracking: v=1; b=H4sIAH7tv2UC/x3MQQqAIBBA0avErBNsCISuEhE6TTVQFooRiHdPW
 r7F/xkiB+EIQ5Mh8CNRLl/RtQ3Qbv3GSpZqQI29Rt0rl+JMB1ufbnWSU50x7JCQNDqo1R14lfc
 /jlMpH68v1aNhAAAA
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=h5wa1peYT9Kl9v4lgKkr84GgccLobvl8mvxpbVMbv8U=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+1/GeIQajedyJyXOYaLCU4AzchvurgYjprhT
 Lk/S8Lc926JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/tfwAKCRDJC4p8Y4ZY
 puHAEACXgI1f2UQWjUa5WMGoRmjQxdnw203KyFImMup70GXmr9SdsoczIlqXGk0s7SSIgba22js
 ffRXvxqTSuocKQqFZb87vruqudOKardNcx8Qg8ouYkIx5AaGNgveNLmEXKVDPAEaAB7QgPpUxDJ
 f+DanaVFIGYtBWgmOPDWj/BSWkRqbbDyWyekHkKM5z6n5dUYkKYWcECJLUwnG3t9yzpaxxk2ntL
 L+//2WPjo4ok4ZpniAkNYLhnWlCF2VjINRvhwDfoytRRz491zky2Ia3uDOR57IB6CLz1tie9ccc
 Vj/AL0M1iXymbbcuDzrgPh4c7mRR1lih410nOw6CYEtXaJb/iAaiNGh40C3i0yIFiPnf1K8RfhH
 bK1sOoNhh2GslGiOdfXwye+XZXgx4DxcAicbmpLR5qMNpq4hF8frPLQj0XKZ0ohEwTwLUDasQGD
 vins9qc/3g96kmyWReEMzuUC0DIre2gAILnC+1qYAexznKzBxH5n2w4nECsO4/ZEHI1XE5loWw6
 hx9/BJ5XQCC4No3zt5+/HbvaCED0QLyIZyEDkyjnv8sRBxKhRzdUZIKUSNih0dtMbtzooh1jgx2
 Iabput7Gv+3hI49KEzLV5bvovl+d1TJgt12BoY4mrO3TXcoFzQqbRgrOFCZ1TajlBDtL317sE9U
 e3A3TQb7Kh1KyAA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mcb_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 61994da7bad0..0c939f867f0d 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -156,7 +156,7 @@ static const struct attribute_group *mcb_carrier_groups[] = {
 };
 
 
-static struct bus_type mcb_bus_type = {
+static const struct bus_type mcb_bus_type = {
 	.name = "mcb",
 	.match = mcb_match,
 	.uevent = mcb_uevent,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-mcb-177eb2c2c02b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


