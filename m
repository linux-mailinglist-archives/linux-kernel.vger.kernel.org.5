Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F07FCD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376869AbjK2C7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376867AbjK2C7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:59:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55A19AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:59:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfb30ce241so34513575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701226798; x=1701831598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Ui2NwwGrhvccOt4uEhvW+bd99ZDt3pI3ujTBGkCJ0=;
        b=eYpPo+cBBpCGhOPWYfpWdW4bPqJ8uKfZjn+qv72B9Z7/VG+rRCXw/MEMdTxsXtyXeC
         +VJwZMMsLAsgpitCEa8+CkWbPKsd/FUy531jz4SHR0/3srUly+gBJN3dw+in6OZCAVYU
         fBdGZlIIAqzxdfyRv92TnpVPzOi5Qo/aUrqy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701226798; x=1701831598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Ui2NwwGrhvccOt4uEhvW+bd99ZDt3pI3ujTBGkCJ0=;
        b=YD2IzK2CR3WsTWrWvdYJyNRbrqWJkzxkB//QeW+GLZArSsyp/lfGDTmFlLa4iRKKwd
         vNez2tnJBSgJK88nzTTrHTiMkkaVe/VXsTRqpX2o0uk03eSkyssBrvaiOY9CkmECQwtx
         LtqG4kS2NQAyjXHayeo/K/a9ni5508z6mMbR5SMqwXZWArqD+ezb1pWtdP+LGviWuRIX
         CZda1ntXC6BRsm7bWjAtEfMG92Y7giRh+F9rSdomMjoMpQlV0HJeyn40aem0d/huk+bu
         R2WrKmnjsJl/C1O+UE6TqXUMRAc2ryWzyOI+7GmWRlYX1wy886zaUPkENHAu0ZsTwjG6
         TovQ==
X-Gm-Message-State: AOJu0YzFlm3lwFBrmlkUrF3krD0cGA/CcRByLHncMRtmBU3V772OXnS8
        cPFkN2hsjGfPPjfEPdnlirENPg==
X-Google-Smtp-Source: AGHT+IG6dFGqtk4fZYge5QsDOksX0ByB2i5897VnFENUeZrCkriv/jmF9N0rsBrUdnOw+cS3d0Ze4A==
X-Received: by 2002:a17:903:41d1:b0:1d0:5be:7816 with SMTP id u17-20020a17090341d100b001d005be7816mr3133476ple.10.1701226797568;
        Tue, 28 Nov 2023 18:59:57 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:db5a:6bdb:74af:e72a])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm4866623plb.77.2023.11.28.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:59:57 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ot_shunxi.zhang@mediatek.corp-partner.google.com,
        Chen-Yu Tsai <wenst@chromium.org>, linux-mmc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
Date:   Wed, 29 Nov 2023 10:59:18 +0800
Message-ID: <20231129025950.1579981-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This log message is necessary for debugging, so enable it by default to
debug issues that are hard to reproduce locally.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- Use dev_warn() instead of dev_err()

 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..907c13d746c1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1150,8 +1150,8 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
 	if (host->error)
-		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
-			__func__, cmd->opcode, cmd->arg, host->error);
+		dev_warn(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
+			 __func__, cmd->opcode, cmd->arg, host->error);
 }
 
 static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
-- 
2.43.0.rc1.413.gea7ed67945-goog

