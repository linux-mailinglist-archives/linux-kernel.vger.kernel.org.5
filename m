Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2698756D77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGQTiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGQTiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:38:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74B0BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fc8049fd8bso7626381e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1689622699; x=1692214699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0jx6KDLfrX0Uj2uqeAAYsN7zB5TQ1Hj76wJYAksz0s=;
        b=SXlAzV3tbaSQ6pNe0nZHU/rEvYdEXgPHQJctTCRlEfb/0NE9pSyD9zDF/VkZJL2i4/
         eQ3sYSGI+4dqA4+g95uJuENy9nwxOOyokDFM58PvZ+4WAMNjIx5nolWcpO+F++L6sOEZ
         Y6iA3CgI4pl35+37ysCrwfiP6RkmtmKRolT2EaoATJHeT8r4YLbYmN1eIex3HwZqrm6T
         labJ3mUnxRTBqjczKBwHI3qoz6PdQhoYMKn+l2tWbuHuhj4Mkv3UK+cT7RHvi0Kh4p+u
         eXexdLt6OdcH1Iz3EB8R+4IVD0KU2GstELMILGAOUKzOwaLDJ4tUeT6alWHDl3IkvbMB
         w//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622699; x=1692214699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0jx6KDLfrX0Uj2uqeAAYsN7zB5TQ1Hj76wJYAksz0s=;
        b=Wb9xDTBqfitysDcGfOKiacK0BppTNbAz77Oof0uE9Nt7GWA51QfkyeviKjQ7ivxv9g
         pk9pFWMx+2tucg+d49yjK1qXzXJ9r2wZ+4rI8JxQ9snnimgoOrh4jYmLt67ko/ieuNCe
         ChKb7uo9bcRTb+mZuJtrq4yIX6zq1CwIdana9Zt5Kbc6yVDmoxE1u9cHooVtUlw2FNJm
         V/weMiM6rog2rUb3aim9on9Z/czV5CarpuJNzJusJIMxTUQww3cQj5pjXGqUvAYEG9mv
         DB99U7eQso+lFMd+OsyJ1WYNUq1k00ZYfKHVEIMQqKiJkj2NN9o1wCD8EhsX455O6z4x
         nadA==
X-Gm-Message-State: ABy/qLYurNFj4Ke6ngU1SYduHzCQ0VAuZ4QcS6nlRLZOYVUXl03PEemE
        gkkU5nXAsxF/ahU1jAKU+1ntTw==
X-Google-Smtp-Source: APBJJlEtjryDAdE+QG1MLzFBSi5+Jxhgb3m6oKz8AiiWmVh0moF12fgKoo9kSySXXvqOeme9Zu71zQ==
X-Received: by 2002:ac2:51ae:0:b0:4f9:607a:6508 with SMTP id f14-20020ac251ae000000b004f9607a6508mr8024325lfk.50.1689622698911;
        Mon, 17 Jul 2023 12:38:18 -0700 (PDT)
Received: from dmaluka.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b004fb75943ab3sm53124lfn.258.2023.07.17.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:38:18 -0700 (PDT)
From:   Dmytro Maluka <dmy@semihalf.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Dmytro Maluka <dmy@semihalf.com>
Subject: [PATCH 1/2] ASoC: da7219: Flush pending AAD IRQ when suspending
Date:   Mon, 17 Jul 2023 21:37:36 +0200
Message-ID: <20230717193737.161784-2-dmy@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230717193737.161784-1-dmy@semihalf.com>
References: <20230717193737.161784-1-dmy@semihalf.com>
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

da7219_aad_suspend() disables jack detection, which should prevent
generating new interrupts by DA7219 while suspended. However, there is a
theoretical possibility that there is a pending interrupt generated just
before suspending DA7219 and not handled yet, so the IRQ handler may
still run after DA7219 is suspended. To prevent that, wait until the
pending IRQ handling is done.

This patch arose as an attempt to fix the following I2C failure
occurring sometimes during system suspend or resume:

[  355.876211] i2c_designware i2c_designware.3: Transfer while suspended
[  355.876245] WARNING: CPU: 2 PID: 3576 at drivers/i2c/busses/i2c-designware-master.c:570 i2c_dw_xfer+0x411/0x440
...
[  355.876462] Call Trace:
[  355.876468]  <TASK>
[  355.876475]  ? update_load_avg+0x1b3/0x615
[  355.876484]  __i2c_transfer+0x101/0x1d8
[  355.876494]  i2c_transfer+0x74/0x10d
[  355.876504]  regmap_i2c_read+0x6a/0x9c
[  355.876513]  _regmap_raw_read+0x179/0x223
[  355.876521]  regmap_raw_read+0x1e1/0x28e
[  355.876527]  regmap_bulk_read+0x17d/0x1ba
[  355.876532]  ? __wake_up+0xed/0x1bb
[  355.876542]  da7219_aad_irq_thread+0x54/0x2c9 [snd_soc_da7219 5fb8ebb2179cf2fea29af090f3145d68ed8e2184]
[  355.876556]  irq_thread+0x13c/0x231
[  355.876563]  ? irq_forced_thread_fn+0x5f/0x5f
[  355.876570]  ? irq_thread_fn+0x4d/0x4d
[  355.876576]  kthread+0x13a/0x152
[  355.876581]  ? synchronize_irq+0xc3/0xc3
[  355.876587]  ? kthread_blkcg+0x31/0x31
[  355.876592]  ret_from_fork+0x1f/0x30
[  355.876601]  </TASK>

which indicates that the AAD IRQ handler is unexpectedly running when
DA7219 is suspended, and as a result, is trying to read data from DA7219
over I2C and is hitting the I2C driver "Transfer while suspended"
failure.

However, with this patch the above failure is still reproducible. So
this patch does not fix any real observed issue so far, but at least is
useful for confirming that the above issue is not caused by a pending
IRQ but rather looks like a DA7219 hardware issue with an IRQ
unexpectedly generated after jack detection is already disabled.

Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
---
 sound/soc/codecs/da7219-aad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index c65256bd526d..202715b7bbea 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -944,6 +944,8 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
+
+	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
-- 
2.41.0.255.g8b1d071c50-goog

