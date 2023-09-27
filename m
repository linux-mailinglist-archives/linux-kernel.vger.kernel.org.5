Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672B7B0EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjI0WiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:38:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41292AF;
        Wed, 27 Sep 2023 15:38:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so12006318f8f.1;
        Wed, 27 Sep 2023 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695854302; x=1696459102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RqKnQ384vFzLQtfAR/lBEgRDbU9k5LVLEF+EOb6OZQ=;
        b=I6/YgFwUBVboKz5FiwgbP3gzm8Fe5iVNtk1hybQasMUaQ1YmgvE2dx3uW+cpvg4VzZ
         g5YrAvnJTSquwUsF2v8E2JNjsDl9kap1BeYdxSz8hFEn9sET+UlsG+GmBb+1vymkmWbJ
         ZVE1z1DA57GB5JQZFvozILspAs+6t+d+K1J6qtrcWZoJlgVAei+B/hGujJLCW1qvqnbk
         q3Y+wJeKjQ0E06gC+71Tq8AuOHVpGQox9n8fe5ORxpkeoyNoxT9YnmVN4D/5X5/PQHHb
         5Atci7bP+LVzQJ82+bxffe2DbXtAkQmi9xoqyhrJSqnzAoLoCeRVQfP05BKpeC2oIars
         TBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854302; x=1696459102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RqKnQ384vFzLQtfAR/lBEgRDbU9k5LVLEF+EOb6OZQ=;
        b=lAHksawo0Z9FXQMHQG8hbk2XHsHTTUkdfojOrdHSXt1lwClO1MevTX9Sl2tdldgJdk
         FVZpRF0WQd2qKxkfmeLzIdA6ggOqKyEQEJJ8XvBBBYvSdMcqDUg9OgvlfcsJNpzRdnIh
         st9WLi7DIOrpL2m5rOdV5hxFhYza5q/z66QYwgY8VdWyYrEt/ea+CLDkq4X3d6Etq9Rg
         w5UPyTqAXgtTjVqq2Rb0wSultl/nrHqHlhRn/n9JX5M6LBeM5auhSyO+cW8/iARSmmj5
         HqDFdwDv6EyiTgruu4QkOxRGp1Vg7UOgEf/a1DoFlByocH173rWiZzi05nRGAiW1pE9N
         ItOw==
X-Gm-Message-State: AOJu0YwBzfyG0DdOR+7RxEj0L/5KMyHhY8K2+PlaI2alf019+GfsH2RV
        3nRd70OZwq4LYfP+CHR/IBg=
X-Google-Smtp-Source: AGHT+IEtPyqOdvggdme1F7Zk7QQYP32qu1nZmurf+Vdr4qpg/HWLBeF4/Hp888VsCYml8AiGnn90Rw==
X-Received: by 2002:adf:e749:0:b0:320:bb1:5a73 with SMTP id c9-20020adfe749000000b003200bb15a73mr2917396wrn.22.1695854301359;
        Wed, 27 Sep 2023 15:38:21 -0700 (PDT)
Received: from yoga.fem.tu-ilmenau.de ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4642000000b00317e77106dbsm18013776wrs.48.2023.09.27.15.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 15:38:21 -0700 (PDT)
From:   Sven Frotscher <sven.frotscher@gmail.com>
To:     broonie@kernel.org
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev,
        Sven Frotscher <sven.frotscher@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Date:   Thu, 28 Sep 2023 00:36:07 +0200
Message-ID: <20230927223758.18870-1-sven.frotscher@gmail.com>
X-Mailer: git-send-email 2.42.0
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


Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
requires an entry in the quirk list to enable the internal microphone.
The latter two received similar fixes in commit 1263cc0f414d
("ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG").

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
---
v3->v4 changes:
* re-add blank line between commit message title and body
---
v2->v3 changes:
* add message title of referenced commit to commit message
* make whitespace consistent with surrounding code
* use a patch-friendly e-mail client
---
v1->v2 changes:
* add Fixes and Cc tags to commit message
* remove redundant LKML link from commit message
* fix mangled diff
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 94e9eb8e73f2..15a864dcd7bd 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -241,6 +241,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

