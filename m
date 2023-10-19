Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B67D02E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjJST6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJST6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:58:42 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742D7CA;
        Thu, 19 Oct 2023 12:58:40 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49d39f07066so24707e0c.0;
        Thu, 19 Oct 2023 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697745519; x=1698350319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvkRB+olAWmsGyPWRkTPV22lAdd6kaLG5H3LrhMq4VY=;
        b=KliUWx8j15vtxskywCwUpuCkRJlShQwtv5CH1MpVaK+uySy8kyilDZiSNuwIvR0RTG
         21mbdgdAD/ZVb7OHr6Fk90NvJfo4wZT9q8M93zaoyjG4dqYIoKNgeTam2oQ8LoBbQ2wD
         nGNh8/33+479dEeogu7apptA6TZt0rhohlpPV/svln211wyJ0VSHtlnn9dGl94fSqlQ+
         rZ1Je0ZbjyVAYKfIzfzgrctujzzlWtbtT6/VkFPnzfR+NREX5//xOUDN+5gyP5WCUQC4
         cRDc6B2Mi0xEVcvYupTk1f8P8RnWovFc2PxTdF4Yq1nWf5XMptnG+ByorXnMUkx03vJn
         JiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745519; x=1698350319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvkRB+olAWmsGyPWRkTPV22lAdd6kaLG5H3LrhMq4VY=;
        b=wrFBIB8jwe/PIYQnLiIe5GkYmbF2y1V4KlT8OCb2hLTHF3ECFzaLXQaiwiQ+Y7O6li
         F1Qeniw57amkbYiy9t8W5433Oq6bpE9SRveoiK+UOBsSNRs5VGZ+SJe/jlzCxFE7HOfx
         QV2iRobRF3Rp0RkqRCVxsmcNrgtDpj0VgjesivT+J/vgLZihFa9FDe6zxfEvmLVAHMBS
         pbAskNAO857vdukDRj0DKC3wt4MiLKsVVKseUKb1Pzky2wIoXp7JqbFg6NJCMV3vg09z
         YPMDx8Fe4Wx9LhYaGlPUQd2M1nnRol4VUCvUn7MUj+7d5pNrjYO3XcYG77HqRr7yIJZI
         zyjw==
X-Gm-Message-State: AOJu0Yw8b9T3d662AumQCcuahZ4ezXAsFhOiQqPM8Lw5aJDaTwl3ruT3
        WMWiKjqxoFNunE4tuAswGxk=
X-Google-Smtp-Source: AGHT+IEF2LkUso/N87vJU+7pzjGTriwnJvL37YO8xbkRA7it1JuGa2Gx6nBfJSVobPhZr+91+hmgZA==
X-Received: by 2002:a05:6102:23f7:b0:457:60df:a30a with SMTP id p23-20020a05610223f700b0045760dfa30amr3386394vsc.30.1697745519530;
        Thu, 19 Oct 2023 12:58:39 -0700 (PDT)
Received: from policorp.cardumecowork.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id d18-20020a056102041200b0045255981807sm46752vsq.0.2023.10.19.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:58:39 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, axboe@kernel.dk,
        victor.shih@genesyslogic.com.tw, f.fainelli@gmail.com,
        asuk4.q@gmail.com, yibin.ding@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] mmc: block: Use octal for file permissions
Date:   Thu, 19 Oct 2023 16:57:52 -0300
Message-Id: <20231019195752.62692-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Octal permissions are preferred as stated in
Documentation/dev-tools/checkpatch.rst. Replace symbolic permissions
with octal permissions when creating the files.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b5b414a71e0b..edb653d8fbfa 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2916,7 +2916,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 
 	if (mmc_card_mmc(card)) {
 		md->ext_csd_dentry =
-			debugfs_create_file("ext_csd", S_IRUSR, root, card,
+			debugfs_create_file("ext_csd", 0400, root, card,
 					    &mmc_dbg_ext_csd_fops);
 	}
 }
-- 
2.39.2

