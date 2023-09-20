Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F797A7DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjITMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjITMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:12:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC0B4;
        Wed, 20 Sep 2023 05:12:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dca134c83so6669281f8f.3;
        Wed, 20 Sep 2023 05:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695211962; x=1695816762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoTCcIJ6irx30M2vhW+lG8oTwIdTkWyEb+BI/OR7VyU=;
        b=lwuLcpNaEVL/NeUfx8ixOC/p1zdTHaDbRzwUOYh2M/UsQwH04mpTJqzRqJakDOG9Qf
         A/ysJxi7T9YkmXTujAZ1dk4kuy69KCSwzQ8Dd0+BUcAGon1qhk7tjX7ZlPckq5+Qh/C1
         LAE2egDcY8tNzDKqE5+GaWloh0M8SUVeEB7h8B5LU143c91Mie6oYmGLiNAXVohXWQDm
         uDL2vOY+SliFEap+oOpYDai+izmO+xuDJC4CYWFw738i1iPowg4OxZ84fUB3LONiHol5
         XlWLqwbFC/KYakeIqllokpZOYiamk8UQG3g6zkV13fIY2+OPlcVyACdVzUcO8Wna25Jq
         4E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211962; x=1695816762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoTCcIJ6irx30M2vhW+lG8oTwIdTkWyEb+BI/OR7VyU=;
        b=Xg2mj2ktorxsjefEIJtXtM3vuSwxKxTcXZMhcQ5lHtP2z2F/sLCXyfpieKCMw+M4RG
         IS5F8xBQC1xfbdklQiSquJc1Q/qeyKb5GRtsCBiGiB8/Y7TZ3k2ECqmQL2LqRlhJFJwr
         0l1kfE7BATvOmpNfEJ/qbkc2CiNNgd6nsbGvQL/fK+NC9hyqmfwzYyd2K9KcsVB0Iu6w
         gayn+NwiwcVAYKjQ4p8VfaIrvWPa2sdNHIYZzPHXL3NELQoq6SDRwCrJxuRk2kfCEFuT
         rfxRFZ0ahitkc8gUJfvT/KxAcjtubsURCAx8wWRudeaDh1WiY/ufsKcltbZdFgRRVtRo
         wBYA==
X-Gm-Message-State: AOJu0YxYY8hR2PrpeFS/T+FQy+dD26RPUHZdK1xYvKgMJumNWJ+HN9gh
        2feSNAJgP5gmPouxLItFYQ4=
X-Google-Smtp-Source: AGHT+IEcKSJQUFSjV/2RX02FU3pzQ1+p/LBWfStRRjLwUK3vKCLPkbfffJEKnecFE7zHLH7xGqRQuw==
X-Received: by 2002:a05:6000:118d:b0:321:6936:c217 with SMTP id g13-20020a056000118d00b003216936c217mr2267388wrx.14.1695211961876;
        Wed, 20 Sep 2023 05:12:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm18539018wrs.95.2023.09.20.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:12:41 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rt2x00: remove redundant check if u8 array element is less than zero
Date:   Wed, 20 Sep 2023 13:12:40 +0100
Message-Id: <20230920121240.120455-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The check on vga_gain[ch_idx] being less than zero is always false since
vga_gain is a u8 array. Clean up the code by removing the check and the
following assignment. Cleans up clang scan build warning:

drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9704:26: warning:
result of comparison of unsigned expression < 0 is always
false [-Wtautological-unsigned-zero-compare]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e65cc00fa17c..fe11fa4917ac 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -9700,9 +9700,6 @@ static void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
 
 				rt2x00_dbg(rt2x00dev, "Used VGA %d %x\n", vga_gain[ch_idx],
 					   rfvga_gain_table[vga_gain[ch_idx]]);
-
-				if (vga_gain[ch_idx] < 0)
-					vga_gain[ch_idx] = 0;
 			}
 
 			rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
-- 
2.39.2

