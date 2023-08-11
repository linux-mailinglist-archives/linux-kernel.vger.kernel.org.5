Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E1778BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHKKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjHKKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:15:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC03A85;
        Fri, 11 Aug 2023 03:14:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-687ca37628eso1650632b3a.1;
        Fri, 11 Aug 2023 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691748880; x=1692353680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVi+mii7gitrKtpzMesmKYe+HovpMQt3SZaQ0whSTDk=;
        b=Tj6KKz3auEzGqe+kIqHqjiPerraxl3oUIbr0cdaqVAI0PGpnTaZz7tbxYZWN32SMNX
         J/YKzNZ8vwzIuZDHi8RGXgb1ERezfe9l/Z46zbBkMIeCreFga2lZiSzPsBDBHE73Okhi
         bF79vvx71Qvx1+Xfart6GdBioSSXfqZ4VxCgMZ1MkQCBcovZj2EP03gkG5XEVfyHeBnM
         AGUVxdgGRH0vJZ5W+o0LJUxNS/TW2zE9rKWBM3dhNTku3ZXwWvPnVAb3tZuuCMTyCTse
         h9oy5VPOAtA5sykKK/TyT2cWZkqx/vOUXlZiwkR95yuMkoD3QTaGKY25aN7bKotMmebu
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748880; x=1692353680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVi+mii7gitrKtpzMesmKYe+HovpMQt3SZaQ0whSTDk=;
        b=lVhof9qw8Q2jX1oMListsVzST//6AJBxLs/4QTd7knLVn9wtg7PvQnsgxKKk/rk0C0
         04I+INNwcfM74m5U1zvNx9igrV2AfrLD1UJPO7vEQx2UkJTsl2rkG2CB5jeVUci+mNHr
         u8ChC6DPrGH3TBV7APi5SxW+iYJgIXsoEbTggw3EI5hwJrOlo4AsCuRyT9xQic877qzb
         XVNh7uteLxAd43xnMkehugYEEC9TkEHL20Z818ndtLqqhMc1skqXfjPiuxxRkPOL1fZ9
         3Oxg3tOYAUuo98TIEABpbAYvhs7px9vFiZFCm7qFFuRR36Kbs2HPZRXdYGbAbduFyzJU
         CjVg==
X-Gm-Message-State: AOJu0Yx7qIlsir4gxuc76K2+JwIJmCZGXnjYeFBWYxcutk+AHBFtnBwU
        J30PvbkMMxzZx/51PA8/7/M=
X-Google-Smtp-Source: AGHT+IHo5Mc8EmkSGw2ajx+3oUjYwafaMBnYy704syHa5UsDQejCbAaWjAxvCm+XymY+2Um0RtuWwQ==
X-Received: by 2002:a05:6a00:b84:b0:67e:ca79:36f0 with SMTP id g4-20020a056a000b8400b0067eca7936f0mr1842577pfj.0.1691748879561;
        Fri, 11 Aug 2023 03:14:39 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e259-ffaa-4fa1-c440-e457-62f5.emome-ip6.hinet.net. [2001:b400:e259:ffaa:4fa1:c440:e457:62f5])
        by smtp.gmail.com with ESMTPSA id l2-20020a62be02000000b00653fe2d527esm3010554pff.32.2023.08.11.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 03:14:39 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: core: Cleanup mmc_sd_num_wr_blocks function
Date:   Fri, 11 Aug 2023 18:14:04 +0800
Message-Id: <20230811101404.4463-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Use mmc_app_cmd function to simplify code in
mmc_sd_num_wr_blocks function.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/block.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f701efb1fa78..c665b25bffc3 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -918,17 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 
 	struct scatterlist sg;
 
-	cmd.opcode = MMC_APP_CMD;
-	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
-	if (err)
-		return err;
-	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
-		return -EIO;
-
-	memset(&cmd, 0, sizeof(struct mmc_command));
+	err = mmc_app_cmd(card->host, card);
+		if (err)
+			return err;
 
 	cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
 	cmd.arg = 0;
-- 
2.25.1

