Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804679F379
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjIMVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjIMVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:09:29 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A81BC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:09:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id E356316C0049;
        Thu, 14 Sep 2023 00:09:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T9D-cYVpJG9L; Thu, 14 Sep 2023 00:09:20 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1694639360; bh=L8N0HqldEtg+TknyLAjAl8KOiPrMzht7YVn02VivLw8=;
        h=From:To:Cc:Subject:Date:From;
        b=mRbRv5RkV9QRrbUNKr4mfV52PzbLhsNjaMMNqZUseAx7GpeyTfoTaFWjk5ShDCJ9H
         fofDkLZhsgBPZDMxPrx3lu1RrM0XkzEkX9BIxhXn5OpNdogLoQMrixL8IiqdN0Ypny
         rZfIef5vIWXSgTHNDUaZ4+kTIwbSkLshH/wp2V+A=
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: amd: acp: Fix -Wmissing-prototypes warning
Date:   Thu, 14 Sep 2023 00:09:16 +0300
Message-ID: <20230913210916.2523-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix prototype missing warning for acp3x_es83xx_init_ops() by
including the header acp3x-es83xx.h

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309111220.g63yHDfH-lkp@intel.com/
Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
index 47ce2f6c74bb..7ce15216c3f0 100644
--- a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
@@ -20,6 +20,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include "../acp-mach.h"
+#include "acp3x-es83xx.h"
 
 #define get_mach_priv(card) ((struct acp3x_es83xx_private *)((acp_get_drvdata(card))->mach_priv))
 
-- 
2.41.0

