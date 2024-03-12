Return-Path: <linux-kernel+bounces-100869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181E879E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62057283A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EE143C7D;
	Tue, 12 Mar 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZNoxHi"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3E143753
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282220; cv=none; b=sNfUN2Zc9nawp5V98hWWrIB4qGAvGHRYsIg5jq+Z6ru04FBNXzkjKYxmCI0BXPt7HJkvhSnMOot70QDScaRGhv07QwiZLRTZvryET1GwT9TJXTLJK0Jyml3iI4YZISgNZWdUaf6Gm8svT/9kReJnDpE5+SN4R/Yhr+LmX6cSV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282220; c=relaxed/simple;
	bh=3QJUbKPYoLLNc605hL0BJ/qf2P/9N9SWxty0Nc7MT7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JV3xqqMuPIEHhowlOiqKSbr5nbLhRe8kjQiYtiNBqb9jj24BMrQ5pVGe8AlLQmDWhykvx8DXFhx9RxFQgN2VIVEDfaRDLjdwVpNeYctDp560LuhvqFGBbwvZTAM7ppTTi/LVGl1faSCoZ+xbxBnZVxF6wab9W//ZMX/rBhiz7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZNoxHi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a5628ad97so2221787b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710282218; x=1710887018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Roz6YXY7q/cHu3hKunIou2yZQi2VxJ3WQ8k5L6AoZJY=;
        b=LnZNoxHiUp/pN68F5HCJ300sd60ai+o4mN5jo7jhEjE3+tHZIBFc1F6LWE9vIPbrL6
         jn2BSIxIFWpbu9/IRSWZjOI4PvUo1LDVRlafp1Y33uIYsUOFSdS/fz3kOmHomqp6G1DA
         B8KeLpnAugjBCTWTckZ8fhPpZ2Xbe+wR6K5r3/D6Ab7f7Z2NxR7Zi7h6zewbAAyaII8l
         g2fO9QG0pXIiiEb0owS5TxDrpeU2/Uevp2TXVPulTwSu0JSMlKueSL+HiHBDF6gGabgH
         4wnY8o19aoF/R7/LUyGbYsXkPCjujQ1xmjmptqM/mBYcBILj/Ds/nhFwZXQFz3Xe95jQ
         qvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282218; x=1710887018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Roz6YXY7q/cHu3hKunIou2yZQi2VxJ3WQ8k5L6AoZJY=;
        b=Aeov2IJlQIRZP7NyY8G2sM5/Iwtb7sEjCiLZ3MLnC8JjGg8PTROUK2JY7rX04JwOGi
         qigImYAKuOhWhGi4r0/3WzAwBLI7MWz9WMlN6k7Bt7PGwSeWMvpFXyfTwp97VnOIJwoZ
         d/PBTQU/Scm6wYNroltns8tsX1J5egRAOEmy41k8jpnW7la0J24OSs20ZEODcMhgqi80
         DNDyCIhRKJ3dzeFGFifuCWP/zFWeduke484/oUGAz4Xo6uGRuuGxi4d87BoE9/n4jovf
         hqMF4T13J28tR8tIfw3ZhD0Durzq/c6TwTLT+xmgYDomx4koiPDu+uiqDtysmWSmTv2P
         2w9A==
X-Gm-Message-State: AOJu0YxQgD6mJ944f035zKHsPJo+2TnMT23TjwRfdcLXXXMTs/lT7kRZ
	1sadxcpEawpMo/6GTASQmO1msT3B75LioHxBC5Hd4JVEvmva5prZSjOS0l81
X-Google-Smtp-Source: AGHT+IFEiFkZvamdw7/DOpuGpGE441TQZm/UMUlJhDN8IDPHUq0MYAq2cl82GDWcCdYmOsTmFEpL/w==
X-Received: by 2002:a81:8483:0:b0:60a:1f36:d148 with SMTP id u125-20020a818483000000b0060a1f36d148mr541596ywf.18.1710282217941;
        Tue, 12 Mar 2024 15:23:37 -0700 (PDT)
Received: from localhost.localdomain ([64.234.79.138])
        by smtp.gmail.com with ESMTPSA id p205-20020a815bd6000000b006040f198d3esm2125017ywb.142.2024.03.12.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:23:37 -0700 (PDT)
From: Kendra Moore <kendra.j.moore3443@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] doc: Fix typo in drivers/net/ethernet/samsung/sxgbe/sxgbe_main
Date: Tue, 12 Mar 2024 18:23:34 -0400
Message-Id: <20240312222334.28302-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects an error in a comment. "Supports" is
misspelled as "suppors".

No functional changes are made by this patch; it only improves
the accuracy and readability of the comment.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 71439825ea4e..8d8a733042ab 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -555,7 +555,7 @@ static void free_tx_ring(struct device *dev, struct sxgbe_tx_queue *tx_ring,
  * init_dma_desc_rings - init the RX/TX descriptor rings
  * @netd: net device structure
  * Description:  this function initializes the DMA RX/TX descriptors
- * and allocates the socket buffers. It suppors the chained and ring
+ * and allocates the socket buffers. It supports the chained and ring
  * modes.
  */
 static int init_dma_desc_rings(struct net_device *netd)
-- 
2.34.1


