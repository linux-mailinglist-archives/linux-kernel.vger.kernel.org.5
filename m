Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D47F0D62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKTIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:18:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF17B9;
        Mon, 20 Nov 2023 00:18:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso549611566b.1;
        Mon, 20 Nov 2023 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700468332; x=1701073132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAFgiTdwpGDvtNPEo9+dnVRad4u3rIMlxH/kmiggZYk=;
        b=HUxMvAgJd++mue9ANixlYmInO8YdXDy9RYZynzrLoLn1gdq+lqEocE4Woz4TAd/5+2
         RlwXIndH8qj1uAPoN63N3BbtppNDBdVzBWI3K4zV6decyqK/TbeT+6E05rtk6zs0sdwa
         qbWC/7SJqozde2VDMhLHKJQhg3EYwA3G2RyYnDmtDRJDnSMMjubwbpXbEK/qT2RvjlZl
         VDVrrglskMCJsfhLUwjGgi0+VPiArto2A5gS4ac1IWJmKFAZLekmw2ruZFPAS9Zxv55c
         yClkPaStUVHtJvqIsSb35JmrZTxtPkgpqRQ74VF9BpPcBsCtkTCOyIgqpuI8UA6zyC5+
         dm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468332; x=1701073132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAFgiTdwpGDvtNPEo9+dnVRad4u3rIMlxH/kmiggZYk=;
        b=jg8fIm/sfm9Tgj8hRVbLfcZ9l2mXIAx1deAMjYUyg5QzFidgLrBGYT/jiT/vlq6jM/
         8zU6cg6ePRXOvV0DHvX16DBzLSWyouzIq3vmN7dwOUeYaSfe6cc0E67OPXZwJWPJN5nB
         828bTLauV488cjNeXu4ZEB7frpbVAqmMs2DNxN2GXfiOEzfypzeYLkrXuYO2XWqnQqPK
         UuO1ltE0QS5lz52B74YbRE1Itvuwqg/MsVDJM7/qLIWPyhDfzYObTQoenRhKS1SsKZhd
         dMxo7nGKkA63r5Ict+Wd9AexaPvI5GOdJs7mMWEsXDch7d5Cyoio3FDNG9bn7Gfoh2dB
         Zu4A==
X-Gm-Message-State: AOJu0Yze91gUMzQFrTj860Z/sBY1BLkYQc3BTQbthcUGClmUzN33iX1k
        D/ZSO1kCr3PIh1jrmwik1/g=
X-Google-Smtp-Source: AGHT+IGiIKcBWwRL/o09TJmoMPMNMyfT63u4veXE5630FRGEbdy6Jh0jHuro+96Puv48MGhGeKgRzQ==
X-Received: by 2002:a17:906:5357:b0:9bf:30e8:5bf9 with SMTP id j23-20020a170906535700b009bf30e85bf9mr4603272ejo.4.1700468331949;
        Mon, 20 Nov 2023 00:18:51 -0800 (PST)
Received: from t14s.fritz.box (p200300d38f2bca00f021423dbbbc0b9b.dip0.t-ipconnect.de. [2003:d3:8f2b:ca00:f021:423d:bbbc:b9b])
        by smtp.googlemail.com with ESMTPSA id k18-20020a1709065fd200b009ff8be60791sm355806ejv.210.2023.11.20.00.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:18:51 -0800 (PST)
From:   Oliver Sieber <ollisieber@gmail.com>
To:     bagasdotme@gmail.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, ollisieber@gmail.com, perex@perex.cz,
        tiwai@suse.com, tiwai@suse.de
Subject: [PATCH] Subject: ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad T14s Gen 2
Date:   Mon, 20 Nov 2023 09:18:34 +0100
Message-Id: <20231120081834.125555-1-ollisieber@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZVoS13B2Br9U8mvu@archie.me>
References: <ZVoS13B2Br9U8mvu@archie.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ThinkPad T14s Gen 2 latop does not have the internal digital
microphone connected to the AMD's ACP bridge, but it's advertised
via BIOS. The internal microphone is connected to the HDA codec.

Use DMI to block the microphone PCM device for this platform.

Signed-off-by: Oliver Sieber <ollisieber@gmail.com>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index b3812b70f5f9..754e24d55e6f 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id rn_acp_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20NLCTO1WW"),
 		}
 	},
+	{
+		/* Lenovo ThinkPad T14s Gen 2 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20XGS1KT02"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

