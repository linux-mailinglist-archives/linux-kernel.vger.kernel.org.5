Return-Path: <linux-kernel+bounces-53988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB984A8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B69B1F301E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC05D733;
	Mon,  5 Feb 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDz762u1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC7487AB;
	Mon,  5 Feb 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170135; cv=none; b=jY/PDqMwmqqHwNq2P7ZRO0ZV16LyP7UB2y+AL+n9QGJCcDWNrAdV3ztA7jzhFr6T5ZTDylh3bN6s9ESdV97Xe9X2pIwRoLe8LUiCM4k/PpuNNB/WDeLdE2MYzZnJBRt9JsUr5xe0b2p+f8nCo/OsopQl1FAVlMYDhr7ltkfG3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170135; c=relaxed/simple;
	bh=H0fLTAzZF9M+Hdp0/173Ijbr/B0GoqE0ZGzVwCP9LRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oh9nwuoUh5rzBxwvI9XzkGE7KuZ5n2TT6KocaTrctpgl5a/s7CKDn15ghpk5AFWNhr+EeP0BDAUATH+cpOdYuUN+wT2+t5Q5udWdTssSuy+Fz8qh3cjt6ERC2I0QoOGs+743hQSH1foAIBin2Mf5Efs7Asx0qh/TkK5vJByXC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDz762u1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40efcb37373so1622515e9.2;
        Mon, 05 Feb 2024 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170132; x=1707774932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANHA4FLKX0KPJT+zhyykPfhWKQ9mfjg93YYvGw4tTjA=;
        b=EDz762u1hchvT2pYPBQ/lgHzpfXw8SVpmUxdQd1nUn+gkZX0y7HdQVN1PC1SY4K6bc
         jtaCH19gVx/PnP3x84iSPaz5M6Rf2VN75kWgPn8MUQuWXED8EDWGdQIPNq6nd6CZCQzt
         QnGakYCAU250N9PnsgeXyphBm6AL2iZtz2rG6L1CvVBGwuBeK/UnzxOzKFvlj8SF/1DZ
         MDec3zklA6xAjGl2B8+vDtMDaxvc4Z+68hwwynI/O/3P6jd2IWApY7W1j4bH9R1EZd5t
         gbQvPUCkExRtpy1R2VesKf36Dv4dQt1vRHgETbsLMYfgWvdbY8sEtMdYzdhP7r/h/ATm
         BcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170132; x=1707774932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANHA4FLKX0KPJT+zhyykPfhWKQ9mfjg93YYvGw4tTjA=;
        b=Zk7N5kMsym7o+UPYQOpisX8WMugF/mxPlJToOHeV/LM+CD/IRvywx0oSCim7efU/fb
         6+BNIjc0ctmNIJWU9TamJyZPMKIN5bJ2SVH/IOeJa0sOEk5RL3hBqcJkYWzEu92gGDLa
         bvPt7ErNg2QaGLNGwKLycFRRBGOyRXbpPmlzy1YFE+Dd4j1hHGNbTKXp+u2J9U9pvSyx
         Zlm8oC6gDTiL+aoRjqLda4jVjSRz2U4E45UoNvr78UQG0rOoMpRixxBm4si/7mjyhHkg
         zT5OpQ2XB+1D4Pr1IbVTXjR9nqp/PKYG4azOohoctONUPZo2WUF6EfRyKc2z7TCX/V3d
         mnWg==
X-Gm-Message-State: AOJu0YxmxdH73cpvVnoJugdrvGslcd/0414du24od2z7RBvJbELqJfDZ
	+XK1JbQAaH6MGquXcUwUnGsRG2NP8AteicdAXnKKYK+eeRoW0suw
X-Google-Smtp-Source: AGHT+IFSxYu+ZgDtBPP82E2MrK1rskAr9VPt+hoRkCFHBqM5WHdZ7rlG/9AC1JSSjBboHdGd+Njk/Q==
X-Received: by 2002:a5d:4c81:0:b0:33b:3d28:ef22 with SMTP id z1-20020a5d4c81000000b0033b3d28ef22mr703885wrs.49.1707170131584;
        Mon, 05 Feb 2024 13:55:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCAmPKnQXjGh4euXZrhV4VT8/ijih7Zdk5hW0W3uPscwlWviKbV7lOlGMpF5XW0bCZf1nZIxuM+CEQSThWP169A+8EZJuRBwbGB01txfNOEdVizMMe5jZ8uYoDLqx3wrjYWzYQx4OhZO2EwvqbRCFce7DBBFvZVEcLc+qMM/dVTuri5avHKvGrh+fmvsb8Ksl82b3FgmdyEDikRCCL/LsOq4zr9FXxV7AsfERkbXRBg7enWBcZZTxUAtltfn9ggz2dWfEiJEhnm7ZCEDy2trWrRwjHlwFeeNLbENVTonLs
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5486000000b0033b421e651csm524355wrv.37.2024.02.05.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:55:31 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qed: remove duplicated assignment to variable opaque_fid
Date: Mon,  5 Feb 2024 21:55:30 +0000
Message-Id: <20240205215530.1851115-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable opaque_fid is being assigned twice with the same value
in two identical statements. Remove the redundant first assignment.

Cleans up clang scan build warnin:
drivers/net/ethernet/qlogic/qed/qed_rdma.c:1796:2: warning: Value
stored to 'opaque_fid' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 5a5dbbb8d8aa..9a1660a12c57 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1793,8 +1793,6 @@ qed_rdma_create_srq(void *rdma_cxt,
 	if (rc)
 		goto err;
 
-	opaque_fid = p_hwfn->hw_info.opaque_fid;
-
 	opaque_fid = p_hwfn->hw_info.opaque_fid;
 	init_data.opaque_fid = opaque_fid;
 	init_data.comp_mode = QED_SPQ_MODE_EBLOCK;
-- 
2.39.2


