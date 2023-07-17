Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A323A756D76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGQTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGQTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:38:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF1B132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so7763799e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1689622696; x=1692214696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPjGa2gVly2nkBzUKiQge11g2a89IAwqmPmDHU14Mk0=;
        b=Wg3Y4IfdQPSIExSHgXxXdxlyE672ZA8B/KPe7TShBB7Ws8yniOaByJb9Fjbrth7Orv
         tBW3DPWjFS5zGWvza1YCnjaHbpHQ3F9PcOGM5PdDZ2bbIUqpPQqF73a4N5B0st8dUV9P
         AGldt+FdqHC5/bgc2IH1WUsnGjAHwO4P3d+adq4F95nQuDVdl1gvcz3iaWTnZUJ/nBtJ
         tnTWd7VXcwrwKYKGv63ovyfxfojMlO9Xa2m8IcFo0wTQvLYlBj0jaHAu/dl9yJ0ONpgA
         NAgpkh6w0k11/sxIVsdSVAMkUlYXz92yDVtyjUnEbAlIE0lC/Y/XyrQPQ7b4SL33pGyO
         bBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622696; x=1692214696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPjGa2gVly2nkBzUKiQge11g2a89IAwqmPmDHU14Mk0=;
        b=Am9o3jnb8LTrzfUvPSGtkzlmBwH4clMbBl0Wnmb6Rzt3Fwg9PzlxpsgV8gim1JkVfY
         5dG8BJFnQ3nv0tf08CqK3cCIwjLIKkZiaaORc7OD06hY3/czTp0ztC5AfRGZJkAS7mEK
         nRzuaUKmnsu5iDYUQXdbw0aGfk/J/Ex/keAFoqqS0dZ2Yp1ZQoFNY1pECK6hNzWlwp+v
         Qz2e13jk2HEsqoSfdBhIZoBoSGBDZTsT/y5f6cj4Dz6tT8N1fsFOFdL1TdtXBDPTr2bb
         ORa9f2HCWN0NrboWm1eQm22HgOq964zjpojArA/j98Op1z1MCxiSWUvZuLQEV9kYODza
         DbTA==
X-Gm-Message-State: ABy/qLZWFOrcGHWEkmM4QQe/rng8ne5IUtgu+vxwopKgkxddiloPXMOm
        BfyDgGEIHT0uAGdGWVLZXPNEui6qXYnEkpnm2VE=
X-Google-Smtp-Source: APBJJlEgbFznuYvooVVZcUGY1DNIvZC+77QEU5cwW/3zydBC+6zt83fsgT826hjxohNcIwNAkSzK9Q==
X-Received: by 2002:a05:6512:28c:b0:4f8:714e:27a8 with SMTP id j12-20020a056512028c00b004f8714e27a8mr8300437lfp.0.1689622696220;
        Mon, 17 Jul 2023 12:38:16 -0700 (PDT)
Received: from dmaluka.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b004fb75943ab3sm53124lfn.258.2023.07.17.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:38:15 -0700 (PDT)
From:   Dmytro Maluka <dmy@semihalf.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Dmytro Maluka <dmy@semihalf.com>
Subject: [PATCH 0/2] ASoC: da7219: Patches related to a spurious AAD IRQ issue
Date:   Mon, 17 Jul 2023 21:37:35 +0200
Message-ID: <20230717193737.161784-1-dmy@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

This series includes 2 patches related to (but not fixing) the following
I2C failure which occurs sometimes during system suspend or resume and
indicates a problem with a spurious DA7219 interrupt:

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

This log shows that DA7219 AAD interrupt handler da7219_aad_irq_thread()
is unexpectedly running when DA7219 is suspended and should not generate
interrupts. As a result, the IRQ handler is trying to read AAD IRQ event
status over I2C and is hitting the I2C driver "Transfer while suspended"
failure.

Patch #1 adds synchronize_irq() when suspending DA7219, to prevent the
IRQ handler from running after suspending if there is a pending IRQ
generated before suspending. With this patch the above failure is still
reproducible, so this patch does not fix any real observed issue so far,
but at least is useful for confirming that the above issue is not caused
by a pending IRQ but rather looks like a DA7219 hardware issue with an
unexpectedly generated IRQ.

Patch #2 does not fix the above issue either, but it prevents its
potentially harmful side effects. With the existing code, if the issue
occurs and the IRQ handler fails to read the AAD IRQ events status over
I2C, it does not check that and tries to use the garbage uninitialized
value of the events status, potentially reporting bogus events. This
patch fixes that by adding missing error checking.

In fact I'm sending these patches not only to submit them for review but
also to ask Renesas folks for any hints on a possible cause of the
described DA7219 issue (AAD interrupts spuriously firing after jack
detection is already disabled) or how to debug it further.

Dmytro Maluka (2):
  ASoC: da7219: Flush pending AAD IRQ when suspending
  ASoC: da7219: Check for failure reading AAD IRQ events

 sound/soc/codecs/da7219-aad.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.255.g8b1d071c50-goog

