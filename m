Return-Path: <linux-kernel+bounces-71905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF185AC53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F397D1F2330D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D2535DE;
	Mon, 19 Feb 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="UeeWPQe8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D7535B5;
	Mon, 19 Feb 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371981; cv=none; b=ahIGsntzlS9KZb1MuIwZmz/z2hgOLpJofY+iFuq0XEcnV/gHlddg8PsnpjJEA4TYoeZfDd6RofQDsW0l0m1eaRTR9/AsLPQKQyn7oDH1LpemAL2h6EVOw/p/7+C2vQSYa+O0S2MDJUu0etpxPqWLAh/4hscN1X4CpiyCGrntdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371981; c=relaxed/simple;
	bh=qkNCX/evOVyVcsQQXkga5V8mXV5VQFEJOLdKmEkioZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MyFNsXdhJ5F6JHnb4q8KxIZPGisWQuIt2OfYqkjG5lKMic3nqdZWGBnW91NcAyh4OCx1DbMDrAlKG1L3vPPABQdWBVOghQSeUiVN76XuQvF5ib1vyeFbBSSbZW4QtOAUlhESXZy87DELxYo4bWq3zdTsl0oHZ0UqEjfv4U7Bm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=UeeWPQe8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbb47852cdso20085175ad.1;
        Mon, 19 Feb 2024 11:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708371979; x=1708976779;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwRCLhHz23aV/zozDITJb0YDvXJTzc2EO/w3xANaOLQ=;
        b=a9omP0KFedUSS5EPWXjLWk00YwJ3CP8YV4DhTjkNEaEcStgKK4nCheISG5XCR8z7Gz
         K6Ms63VyNn2SgE7IIYsQMuJ/lEiXWy+lg57laWDZO+176/AscwJtKJS01gZtsgn8pFzA
         Tat+4n6s9HwkByRwU6vgvz9zIDjdB/T77yPjtsZV0hjXYETxwGCYWpXbzr3O+mDbDMqH
         KysK+qLqHWaYz3LXHrS6HtTSjWCavD6BNHETS3Y0QNMiVt8CBdFsrgM/eRilqBm5oOoP
         Isd6t1vMulEyw3a/W5FlTgReoibBPg/2cdZWp1Ipf/H6jN1p5eGzkLHNuxa6kEUwm10q
         mW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbFgNi/GqkuCRTO9LZU3cMcgYVaLG+xT+Pl2L2qzrNDo4NojBDdV4QIr4NR6oLLKOF6XpbuPT70dWrC1Vt3UEGw6VOwXz6LH0noA685LwJN2y3EA7P5vHmSvNIcMx3N6O/9Zfx
X-Gm-Message-State: AOJu0YwRg6jJqru1j1cgVRvUE/l6Xls9YVVl1h2bgh+gUVAYpSUTXsz6
	QZumOzMPSbbWusRmAmVYnRGnJM3YrJz86bxXx7p3xsYd/+XwlOCn
X-Google-Smtp-Source: AGHT+IEKAiG3a3CMkgCplA5Qh4PQ5N5JQQgN++WfYfMHwbLAwQarQeJr0+DY9GpUBLZ5F85B83fFng==
X-Received: by 2002:a17:902:a3ce:b0:1db:a94f:903d with SMTP id q14-20020a170902a3ce00b001dba94f903dmr8295308plb.36.1708371978816;
        Mon, 19 Feb 2024 11:46:18 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001db9fa23407sm4753658plb.195.2024.02.19.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:46:18 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708371976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwRCLhHz23aV/zozDITJb0YDvXJTzc2EO/w3xANaOLQ=;
	b=UeeWPQe82l1RQbVnsDf77Nh8VbkC43M9SjfnDIxjvtKsinuJdi6ZhS0NHu7m8FPAIfIKxt
	Q0hPsFb/pETo/emEdV1Acbc+EdkYzhxucmWRywziyx0aVVhs7A18V8hC9N+vYaDaX9ItwT
	UEByd/k4q5ANyL/M2PiNShJj/LjecsmoELs5VMA6NiaOiN+zWo3jsDob2g+UWe5L00ftvO
	GNO2Bw6F0BNib23Sqj9Xm4AP0jswKwRy5S1s2Ro8vcycwvKE8hMuLF+nfpafcQEBV8Tc1a
	Xu5IbiqdrLbgAna47F27eyrEkkUfPYjbmoiDgw9eoJfeAPk7zkG4YkwsS/gtMQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:46:57 -0300
Subject: [PATCH] Bluetooth: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-bluetooth-v1-1-dd81ba00c95e@marliere.net>
X-B4-Tracking: v=1; b=H4sIADCw02UC/x2MWwqAIBAAryL7naDSg7pKRGy21UJoqEUQ3T3pc
 2BmHogUmCJ04oFAF0f2LoMuBNgN3UqS58xglCmV0a2cs2RptDuhOw857Scl79MmFSq91BbLpjK
 Q8yPQwve/7of3/QAyte8RagAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=qkNCX/evOVyVcsQQXkga5V8mXV5VQFEJOLdKmEkioZw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07AxGJrWiNXtnXNhSeiX52AHCHXjkF3XyhmeO
 cOr2GGQuKqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOwMQAKCRDJC4p8Y4ZY
 ps1zD/9dgzh7mROaeNsTJHEFlvzG+3pU5cdy7vyulxNhZRdlDMs8bDJYIp2dJ+J1WPRtkDszqRG
 0xs8w+Iv/kNBcLruG7F34LhiqwPUtvDMO4H1Q5QwQBQ45lpzZBbEczSm4TXD5aBp4VpgOR+6GnY
 TW8UzqU6OQmzVR4Pcdilu+YXrzqfN2Id4znBgFuGSNy8c+36MpDzgQKMkAcUvikZM7jdtO6SuIy
 fQtN2FHMXY+d8lDwc6VdFPfRoF3QHK7aEKjocdynYtF2GN5p158FIuiYmJJhiKHTLl/mFjv7whG
 S37dLkmmFL+yLW9+4uIxAD5CUr1I3zdNPiQ8js/DMtq+uabOElAPdjm21g1PUryqvPtFSGZuGR0
 rYJ3LJMRVeP9ENlgGF+9zn1FP2LDctPQwTxfkGvZEAIktdQgfquAdpkgAbpFYe2XhXI9ccOP3OI
 I9GsaM6mApzKcLMQE8z1Dgm42K5oQbYhboo8YysHJjVs3riTybdnUFqmqkWREz0XzX8IN0LwYxL
 6dwkhxnbCh04CA4yget61jAaKCEl/PNaLDoPfZB/Du9iEogLlRBnLx94ltfGaDEHeNPVQKXiF79
 RTt6NtgftUgfYWuZ/THJXtmFgyhCdyzgSNNPn/tRXC97dpq15OszlCPBos4Jg3cDwxOZG5/VDVN
 3g9GZeGe1su/lrQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the bt_type and
bnep_type variables to be constant structures as well, placing it into
read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/bluetooth/6lowpan.c   | 2 +-
 net/bluetooth/bnep/core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 215af9b3b589..5c1b8b5bfe71 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -572,7 +572,7 @@ static void netdev_setup(struct net_device *dev)
 	dev->needs_free_netdev	= true;
 }
 
-static struct device_type bt_type = {
+static const struct device_type bt_type = {
 	.name	= "bluetooth",
 };
 
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..8c3f8d0c0358 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -549,7 +549,7 @@ static struct device *bnep_get_device(struct bnep_session *session)
 	return &conn->hcon->dev;
 }
 
-static struct device_type bnep_type = {
+static const struct device_type bnep_type = {
 	.name	= "bluetooth",
 };
 

---
base-commit: 64b5c4c8e79c131fe8f135bab5e5dfaa245c5776
change-id: 20240219-device_cleanup-bluetooth-0a01f6ca4752

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


