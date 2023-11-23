Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCB7F658D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbjKWRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjKWRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:36:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2AC189;
        Thu, 23 Nov 2023 09:36:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507975d34e8so1479124e87.1;
        Thu, 23 Nov 2023 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761007; x=1701365807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi4hi51KbsBz/5lDxBPTRqeH0lvqU5t1ezozPUrmIy4=;
        b=mBovVy3vxq6Ng9q9qEEF95RHZ+zrvpCiEukPaykrJgIrADRfRi/fzo2ifaeEa0IS8D
         Ts9bfqI1Aer+rc/3awiPuOOJF7dSe1GjabPt+t8mBpUl4rphinKS30znSCgc6pyZ8cSV
         zrCM97xaCfQ35v36ltusF55qPNcjMD9uEAw2PtUm1IEwypmKmBjyms3/vzsXZbtKtVBB
         2jl+/updNdBcRNbgj2ADFvQQeimklZkKDzOsGk1+yBDUntPYDenV6pfFaPloGRiZNmNL
         /z2BQwbNkdSaijmlPrGlXaq4AIqKFJxkwS2Zg9R7aCnmEdUygsMGulUaGcQOLanVGKIe
         XaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761007; x=1701365807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi4hi51KbsBz/5lDxBPTRqeH0lvqU5t1ezozPUrmIy4=;
        b=a7E3VHXQexovC3BMBO9WkSlzt0FJ3IhWiIaDw2zQPZeaNGt/SHRDzkr5sedShZloT2
         Xn7F/kNyWnAbLnBJKXaNJYJa0SVnPhMNPibBa/bDf1qnX+tAJyyQrv+h4JWFP3EElPjb
         gxFf4uhlLXeFC496cseSiciUyExdlz1Dv1LUyehQW2pl/fJYWvLskgmOwQc+xhYXoXYT
         gA2/0E+GWwx+VQH9nykSFlHeZgVw9T4lvnf34fYImuHaT4grzK1RUxs9tENON2qZJbEq
         DcDp5tJqKmf55SJ3RtQfa1hOrxV6PbdvmCrmeAwGXnFD21qtnxgoc/hQ7vN77WA13XgM
         fkvg==
X-Gm-Message-State: AOJu0Yz2h5hTpO4SSQu/CBwPtrZ2HrwgsWNUYSGuNyvmBjhY5Z1nqiAm
        X/IGIkc2zgO3O5RLsISTx7ZHVmkvke+T3Ezu
X-Google-Smtp-Source: AGHT+IH4tSm1vlRf/XUPyolwDY+PNijuInx1oB/2b6/CRd5FzNqYU9rEnY6i6lwBXXKaGvGz7lAEyg==
X-Received: by 2002:a05:6512:2e2:b0:50a:a2da:33ad with SMTP id m2-20020a05651202e200b0050aa2da33admr4946627lfq.20.1700761006417;
        Thu, 23 Nov 2023 09:36:46 -0800 (PST)
Received: from localhost.localdomain (109-252-174-150.dynamic.spd-mgts.ru. [109.252.174.150])
        by smtp.gmail.com with ESMTPSA id u30-20020a056512041e00b0050a7572c9f6sm263643lfk.101.2023.11.23.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:36:46 -0800 (PST)
From:   Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
To:     Sunil Goutham <sgoutham@marvell.com>
Cc:     Elena Salomatkina <elena.salomatkina.cmc@gmail.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] octeontx2-af: Fix possible buffer overflow
Date:   Thu, 23 Nov 2023 20:36:30 +0300
Message-Id: <20231123173630.32919-1-elena.salomatkina.cmc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A loop in rvu_mbox_handler_nix_bandprof_free() contains
a break if (idx == MAX_BANDPROF_PER_PFFUNC),
but if idx may reach MAX_BANDPROF_PER_PFFUNC
buffer '(*req->prof_idx)[layer]' overflow happens before that check.

The patch moves the break to the
beginning of the loop.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 23c2f2ed2fb8..c112c71ff576 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5505,6 +5505,8 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 
 		ipolicer = &nix_hw->ipolicer[layer];
 		for (idx = 0; idx < req->prof_count[layer]; idx++) {
+			if (idx == MAX_BANDPROF_PER_PFFUNC)
+				break;
 			prof_idx = req->prof_idx[layer][idx];
 			if (prof_idx >= ipolicer->band_prof.max ||
 			    ipolicer->pfvf_map[prof_idx] != pcifunc)
@@ -5518,8 +5520,6 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 			ipolicer->pfvf_map[prof_idx] = 0x00;
 			ipolicer->match_id[prof_idx] = 0;
 			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
-			if (idx == MAX_BANDPROF_PER_PFFUNC)
-				break;
 		}
 	}
 	mutex_unlock(&rvu->rsrc_lock);
-- 
2.34.1

