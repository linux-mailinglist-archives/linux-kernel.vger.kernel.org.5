Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBFB7C98D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJOL2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjJOL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:28:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FECDE5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579de633419so43424727b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369296; x=1697974096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjh0qCOrrcuPUUg/LTlZhlSoQ/vN3kjSgUmu28e+nbA=;
        b=Qou3u2v5c5KsCglWbdxCSO4Dz+Vj0pCMqyK/91pcreqY0oPWw7DohOIJvKQbpiOihJ
         fb5/xNoSRUQY52SQNzYVxyKmJz4R9TC2NcwNvOh19EYzZXde8+pq3TCvul6cITsLjenM
         D2bbbdmZGbSPtSe/bLQ0uFElpDOWph1NHit6IDgkZ+sAxjN78if/hbCfGF371cqZWzyu
         4tC12lArCUuZgWBzd2RrY6LlA5ffQ+SYinRC86p9WfAqHtaH5MtN3lMxUZnMo+UYSw+r
         pH7zhzA8H0rHwJLJ0SO1ZTuuqn/VZg+BqauBFwKr/TFV0+GjwSwRk4Ug0kc9IqG95cLx
         hrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369296; x=1697974096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjh0qCOrrcuPUUg/LTlZhlSoQ/vN3kjSgUmu28e+nbA=;
        b=whc77Ebj4SjaPXJ2/oUhwuInW7/mVh/iPgZhKpS7u+Nhj+1qXo9XGamvvvG/ll3FpF
         yeI8HHTSs2OJPVuwTrvcAu5y3vY/lM5nhwkIgkwDFyNWp08EhTMbTaJhNJM84QH8vxAU
         nCv5GBRIbiw/BAS0pKS9++nENets76D00wYVL1nwO+1BhJ+qy5uUfzNTgoLE/RlNZle6
         Hxs6/IrT9yQdYy2+kFWKwpEQ9QF5qWLAcYcbx/0TM2ULdrPzUVYKTH8S26oGJXrK5dWO
         XuT4MZ1POlLaGlOaKlx9d/krevqm4ctLQs5c70f0YueRdPCTbNTKaRuulY5/odAPQZoj
         cLPA==
X-Gm-Message-State: AOJu0Yzd1W9nlPpg03i2TKF3Z+6Ykst6V8vO3h61GOP0nmZBm57wDdYe
        iCwCJqhP/WDkRDcOpZxdoEQ=
X-Google-Smtp-Source: AGHT+IGZ6WSqaLcBz9n7SzfzqDi2qFfwFrm8HUYdy9HRxF3sjk7BPZrjK8nDnYTPCSiahIad4QHGsw==
X-Received: by 2002:a0d:fc03:0:b0:59b:2be2:3560 with SMTP id m3-20020a0dfc03000000b0059b2be23560mr30244289ywf.48.1697369296557;
        Sun, 15 Oct 2023 04:28:16 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id b70-20020a0dd949000000b005a23fc389d8sm1293215ywe.103.2023.10.15.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:28:15 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 6/6] staging: rtl8192u: Align descendant arguments
Date:   Sun, 15 Oct 2023 12:24:52 +0100
Message-Id: <4b237c15c5bb5a8d6ee6a19a85a2413b8cca1357.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index e6836eacc7aa..c61a29976e9a 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -875,7 +875,7 @@ void rtl8192_phy_getTxPower(struct net_device *dev)
 	read_nic_byte(dev, rOFDM0_RxDetector2, &tmp);
 	priv->framesyncC34 = tmp;
 	RT_TRACE(COMP_INIT, "Default framesync (0x%x) = 0x%x\n",
-		rOFDM0_RxDetector3, priv->framesync);
+		 rOFDM0_RxDetector3, priv->framesync);
 
 	/* Read SIFS (save the value read fome MACPHY_REG.txt) */
 	read_nic_word(dev, SIFS, &priv->SifsTime);
-- 
2.34.1

