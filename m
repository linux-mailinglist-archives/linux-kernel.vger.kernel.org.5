Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFE7F855E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKXVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKXVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:10:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD911990;
        Fri, 24 Nov 2023 13:10:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a98517f3so3070122e87.0;
        Fri, 24 Nov 2023 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700860205; x=1701465005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVO89DxZvW04y67tvwrlTV9VwiUMtZyXH6adWuhrdRo=;
        b=HEn9glMa/xrQbKtV9vu9UChqzLaX7oEu+6Py2skf8l02wiNu+ZbBqyzTD2fZEXih/4
         zfRCy5KoM7+eQpJDRKbnQzeAsqic2ld6ypTRXlkw1NPkxOuo0Lq69GmUzPsqPHUYdE1b
         aJkT3isN55J7exBkF6pXYUur4QFkQhDM6650X0IVX0Co4TUdwRIZYfjQCedPhUoKQlGY
         hcQoHV1alB7fhXyAtSLtS3Z6AnOiwlWYdEpeaq7zyFvOV4SYjqBrpM5WOU6usMIMC83B
         sgZvgAQYJlYe3v3ar3VS3nDdkBIbWzkzlOmL/2+qQf12KgjuzeZGrrHTfR7UKSG5zVIS
         9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860205; x=1701465005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVO89DxZvW04y67tvwrlTV9VwiUMtZyXH6adWuhrdRo=;
        b=ZN/kOwwj5Nyzxy+JIvbB3/b8wEpyWEBv89hdC+xXvZDK+pnua08VqbJcJU/EynuLMC
         beKZXG6VcDRHiO5vr/+t/VXEMw7TYSL70OQLyezphNznhfBnwWoM70wrPXnEhjHe14J3
         Fd7NoZDxJrRT1LucwT8j5jgDfa4cW16n9wXSlX150NwZAF6SHygTOM1Sezc1pfuaOtVv
         iVuLq1LEg94Pjik2DbP6MZBWrMHGmQoRtEuArrtn+r7cT/VAq3LXWSgVSsnm0xfa2ymZ
         gySSqGhRi2tge9HRulU/Xnt77cHVGmA5/rqLtq8A/5TweCiPYsuKjmt3QcMrUnVf17AC
         bX9w==
X-Gm-Message-State: AOJu0YyDGJKNXZ3L4YA8D8N+546drilvjb+I/uBBO+hRazQHBGfaf9iP
        Ne9utuDTraqP74b1o10vLTs=
X-Google-Smtp-Source: AGHT+IH3nqShraHW1QykxqsIbDujWXOJ/I+HVxV6vLUEpulinhiUthzPAgbnooun2fEsW0kJTzdWXA==
X-Received: by 2002:a05:6512:3b87:b0:508:264e:2ded with SMTP id g7-20020a0565123b8700b00508264e2dedmr3889979lfv.38.1700860205071;
        Fri, 24 Nov 2023 13:10:05 -0800 (PST)
Received: from localhost.localdomain (109-252-174-150.dynamic.spd-mgts.ru. [109.252.174.150])
        by smtp.gmail.com with ESMTPSA id e15-20020a19690f000000b0050919538b00sm619326lfc.79.2023.11.24.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:10:04 -0800 (PST)
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
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Simon Horman <horms@kernel.org>
Subject: [PATCH net] octeontx2-af: Fix possible buffer overflow
Date:   Sat, 25 Nov 2023 00:08:02 +0300
Message-Id: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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

