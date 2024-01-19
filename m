Return-Path: <linux-kernel+bounces-31182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28277832A32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49D028462A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F57524D5;
	Fri, 19 Jan 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrMcIBaj"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AD4CE13;
	Fri, 19 Jan 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670233; cv=none; b=UihKuHiMs/MhGKX11OgaArIIpMj1UqPHn6mJwINU1Ii93pj+DRy/gbb9NnjyhcplyjBYL9vWbCJ8OSyjbbk1QINrCWSmf4+0JK8yWhswLlx66XUYb6tLeKowC/1NvdDg6YxyTXgwQWeHmlxaL5xcS1HBdo6oMX10QUNEO9wy9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670233; c=relaxed/simple;
	bh=4A8KGDG1QCCiYzpepfJ6zgGdEq66v8Pn9EM71Wi8SWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzlQpF2/FQJbkpe7j8PeFGlJ+DcqE7rii0c1pAo4yqEszOMSfVujgN7YAGmHSbioyJ1HxJVf8S6qpVFARdzgeaH4aB0By3yAo4yG73w3/wJajPnGYNUB6Up2/XQEmyWdFWjs3LOaxtREC8n6xtfpXxBk0vLXlO2eADuchwcdcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrMcIBaj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bf0f3bf331so28830039f.3;
        Fri, 19 Jan 2024 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705670231; x=1706275031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+R0RsDZSnfmoC203MVbI0UM8DaIKySut/O5wSq6tGBI=;
        b=ZrMcIBaj8Y3nh9GA6qq92Em1ILBgnqRbRjCWjBuhw5nRJcGe9KSu290j4BrHQ7cER4
         WblS9Ks5NJTLInRSLwOFoCi2yhTIKyKMs5AH16hmZnOtR7wKeNAA1K8EXgl46Ok5kx2/
         yJ3M2DPx9SWKGuN5sz12FYIYMriOGwmaorrHt2nXD/IwPVpThKf7d56G/BnMHhtCA+Df
         /Kh9x7TB3GrNla0yxtGZAJhv5F7Vxe5xZ49EkIitEP7TIwOBu06uEmRvvOSXaFqP3toI
         P1pFEhkEwZtOumYR3AElxwkAu4JLDzHfrWNwpb3Yf5zGu76sg5bc8pd9hB3vSSLD2cUt
         8TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670231; x=1706275031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R0RsDZSnfmoC203MVbI0UM8DaIKySut/O5wSq6tGBI=;
        b=hcFiaojKIwujVw3XWOxHxQqpoby3QFYO0Nj3zRCZxf4fbpV2r6ymi+rmHFnNK30SoG
         SvFO+VK8vupWePW982WQy1pvzN9BvWFIYvpfwlV8J91U/KPSZ6LqLpKLzZI1GgFnLuSN
         g3J4CrZoi24e5oBe9ncTAvZOcYJdBcqC227UvfXz+9RSRdaK/DUHL1mJwfvBdqpFMGZh
         T9N6HJ43jmVSL1hoFd6wCqOi3XNq5SgvAlA+M7iCtDuwiWnje6IjS7OUumQjGJR6LfIt
         UXITq0RmjXa95KbhjBZzRpfxrhfrI7Wp0In5hPiq+1JFU8Qc/YCUPNJDanP0GodEruNp
         3v2g==
X-Gm-Message-State: AOJu0YxMDpTomVceao01uxFeNrs4hlQU1eBih8WUBe5Vnll4qwdCW2xl
	5w1mG57nAQQaWxFHyz+EcIauR4jx+TdDE6KiE1LDUGxuI8mkdX81
X-Google-Smtp-Source: AGHT+IF9ROGv7kTV+3XlHqLllyaOPt9wKeBA7Z45AQ19n+eX6sTpxEc1tatK5J2JpmjjbdkTXidQLA==
X-Received: by 2002:a92:da51:0:b0:361:ae73:2c0 with SMTP id p17-20020a92da51000000b00361ae7302c0mr335091ilq.21.1705670231055;
        Fri, 19 Jan 2024 05:17:11 -0800 (PST)
Received: from fedora.. ([2402:e280:3e0d:606:d0c9:2a06:9cc6:18a3])
        by smtp.gmail.com with ESMTPSA id 77-20020a630150000000b005cd8bf50c13sm3373442pgb.58.2024.01.19.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 05:17:10 -0800 (PST)
From: Suresh Kumar <suresh2514@gmail.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Suresh Kumar <suresh2514@gmail.com>
Subject: [PATCH] i40e: print correct hw max rss count in kernel ring buffer
Date: Fri, 19 Jan 2024 18:46:52 +0530
Message-ID: <20240119131652.8050-1-suresh2514@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value printed for  "HW max RSS count" is wrong in kernel dmesg for i40e
NICs:

  ... i40e 0000:63:00.0: User requested queue count/HW max RSS count: 48/64

whereas  ethtool reports the correct value from "vsi->num_queue_pairs"

Channel parameters for eno33:
Pre-set maximums:
RX:     n/a
TX:     n/a
Other:      1
Combined:   96
Current hardware settings:
RX:     n/a
TX:     n/a
Other:      1
Combined:   96  <-------

and is misleading.

This value is printed from 'pf->rss_size_max' which seems hardcoded.

Below commit also removed this 64 limit:

Commit e56afa599609d3afe8b0ce24b553ab95e9782502
Author: Amritha Nambiar <amritha.nambiar@intel.com>
Date:   Wed Nov 8 16:38:43 2017 -0800

    i40e: Remove limit of 64 max queues per channel

Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5519af34657..f5c1ec190f7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12524,7 +12524,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 		i40e_pf_config_rss(pf);
 	}
 	dev_info(&pf->pdev->dev, "User requested queue count/HW max RSS count:  %d/%d\n",
-		 vsi->req_queue_pairs, pf->rss_size_max);
+		 vsi->req_queue_pairs, vsi->num_queue_pairs);
 	return pf->alloc_rss_size;
 }
 
-- 
2.43.0


