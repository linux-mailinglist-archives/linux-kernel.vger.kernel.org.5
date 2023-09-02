Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2879085B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjIBPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjIBPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:08:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11F130
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:08:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso95965ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693667308; x=1694272108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oihOd2gBCa1RX2c3YMiv0m+sHANy7GfRsmex7Iu3Xq4=;
        b=N1OPnZV3r4Y2Moq6HH8UJ5zGhnbRCQCEd2mlTo49Ie8iZCUEKZmWxVxcZPoq5XR752
         SEFdiEdqGEp7Nqe/wOt4LQ23lVnD3E8HlgyJU7Hsngc8vDj4m+EgfOamnhpqFTdh7NzD
         Udti6oAfQy/lofGdcnGHnFcv/ok5QWel0vOZ/lInglIMsqhhrff24KhHNaAh0j6hwP73
         +u8BGz+ibe8X+UgclmG3eOW6IBEJT1XgmImwIcrRRISPiipGj7bSgKJqhCfvSvlzphqV
         MyefKHirEDFRbI0nIazeoORkUVtUpeInhtsjXNe5At2UkO/tShAEVbbSHMjluydRNFcL
         pXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693667308; x=1694272108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oihOd2gBCa1RX2c3YMiv0m+sHANy7GfRsmex7Iu3Xq4=;
        b=DrDHhzNGxO2FZSg5Q7IHT8mY7YmNW6qAjpDqWzebg1zfz5UX7ubnCGA9NkFT/N6O2N
         NSCtkISS46s/GE5q5zpgnN9u4cmbkWnOEDOcjGxuQhWXBRyTOxk/auAaoC/9eSRvfXTS
         R0rBmn/dxAuszQTMXBdv59O/LO7+XkYDTxu7o7OE9VeY/GiRg4L341l0IU91T8YHjI+r
         nv604hESfmX5yP8NQqhcv6vuvMs7Y9XiPieg0WVkiWoTuymUncoWqdyRQX1XGWXJnZd2
         0dC/74ha42I6huuxZfzqdcTvaNdkMC7CmC1WcAub1/q3/CLoIR6SWGZcmj6gJOkGRS+O
         FhBg==
X-Gm-Message-State: AOJu0Yx2HTMO4uj/jFfyiC+JRUUpfFR1X3CBYDJGvAKnSm75WAHOxDHq
        kFCnyfnvAGWULBHjlPz2N9gvFpAOuP3S2kzL
X-Google-Smtp-Source: AGHT+IERQ00WE8oz6cvfQd3k8l6X70FT5h5iZzzmJDyy+VwqH7eZ3w1ho05x2raTeACzPZsJP84nng==
X-Received: by 2002:a17:902:da86:b0:1c0:c7ae:a8a2 with SMTP id j6-20020a170902da8600b001c0c7aea8a2mr701251plx.35.1693667307788;
        Sat, 02 Sep 2023 08:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a40d:5ac2:6bab:c627:af57:9218])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001b53c8659fesm4755896plx.30.2023.09.02.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:08:27 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shubh <shubhisroking@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP Gaming Laptop 15-fb0xxx (8A3E)
Date:   Sat,  2 Sep 2023 20:38:07 +0530
Message-ID: <20230902150807.133523-1-shubhisroking@gmail.com>
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

This model requires an additional detection quirk to
enable the internal microphone.

Signed-off-by: Shubh <shubhisroking@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b304b3562..f7ee792bd 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -325,6 +325,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

