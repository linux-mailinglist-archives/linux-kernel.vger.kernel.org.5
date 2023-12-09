Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD680B64E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjLIUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:40:25 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Dec 2023 12:40:31 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3589B7;
        Sat,  9 Dec 2023 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702153983;
        bh=kkHmtct/9jbgXATg00u9JVP5zqTGs2ziRj22G3LMjJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LD3bFORo55KUK6fObZnMQYcXqkeOsf7vwYr4A406XMTgEnIvvm6fjfk2rl/sDRdU0
         IG9Dwa6kncISK0M3MdNcY3N0DejJIXWC3cXjWcnCo7al12hCc/8C2EqwCnerjnU5LS
         iNqiAGs2jUhOviXTaONiGB0hukV5yLGGkOPJ32/RFHoaFx4cVR/soceOJv5xfVRm4Y
         RDbClsjju9ws0/rUHXPVkLAVQFVLmgJgwiGWXderuJj6vIRISmkKPjw9SZNAiHt9Kz
         OjrqoRUu/8KBfaPEgp5k2D4lQLxAg4DRPGtHuOlaota19dLQVp6z2DhQBKCfOMoe/J
         IazD667/HstLA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9862337813E0;
        Sat,  9 Dec 2023 20:33:03 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 5/5] ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common
Date:   Sat,  9 Dec 2023 22:32:23 +0200
Message-ID: <20231209203229.878730-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
References: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MODULE_DESCRIPTION() in the generic ACP machine driver to avoid
the following warning when building with W=1:

WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-mach.o

Fixes: d4c750f2c7d4 ("ASoC: amd: acp: Add generic machine driver support for ACP cards")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index f7bcf210f0fd..c90ec3419247 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1773,4 +1773,5 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_NS_GPL(acp_legacy_dai_links_create, SND_SOC_AMD_MACH);
 
+MODULE_DESCRIPTION("AMD ACP Common Machine driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

