Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B297F711F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjKXKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjKXKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95410FB;
        Fri, 24 Nov 2023 02:16:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00b01955acso250333766b.1;
        Fri, 24 Nov 2023 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820984; x=1701425784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcMLBYSAsdprviXMYBJT1guiAaPHdo15Q++eqKUBcSs=;
        b=H9oGC3/Dn98DTg3y5OxQQ/Z0liFVXxq36ApycQAZvr8+5baUjSGhfCVvjYM/2Wv6KP
         rAmFhUUr59CnqJ17CRMy/DgzRCO1G7DeW9GooNqTvjLdmDnd1Gck67QEDsdLi6d1RyBb
         QeGSVQFoAvYajHLreGo0WxRxhdoMe5aiP6Oi4MKE17nqO44bJwQjkgOZsEfWbY8GxMBY
         Cnd7QUN5XkJEZdAPlvYNil7jmrSv02sLidPgd36x8Zg8bPgYHuiqVp3rylZ4so5b8AsE
         X+k0cZlGpGUDD0WFUFKXpTXgnLeS8kjY2174iYzJ+L4S9Q8BC8eKALzrcBl5ztkguTJv
         KQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820984; x=1701425784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcMLBYSAsdprviXMYBJT1guiAaPHdo15Q++eqKUBcSs=;
        b=QgoITgtD3cyXPvFYWoiLeRP3rek5zCgWPuWBQ4KDMtqLvvXGsGuHjEb9heUghlLFpl
         PKtZ/9/G/E559QPQT+4KKdKtL5JGp7UTdpZmAI3t4sksDd5vvKueNOUYj/RTNze2qUY5
         KI71t2vy6ejtbVkO4eaKGB/YgpBh9e26xdm/wIvSOYeBZs0a4krF62cbZVmp+zKt74tF
         cJzteKcre6MiEDBpgFX7LpB8Sz4TYBTtaxHvVlDY8cRl3sas/1q39kn+JDqHBCZZq4CP
         qfP/qxIcvY7mBvFxMNZokHQ6iFdTfLQN/B/PuBLXIuAHQBWupnfO1sxJFYNB0IW7i0HA
         gqqQ==
X-Gm-Message-State: AOJu0YwvJVKG7aTbXblb2I/qi+d5hRgSSkjjkpr2G6BBDMGzrFM7ep8c
        Sq5M/M4PMwxA9IZ407rs3ek=
X-Google-Smtp-Source: AGHT+IHMyVQ9DHJdncIOviYJm5Op4owrfc9bHRGqIAVNz9Kh2xDLtmkrUG13pmyHarsniEeVN07dLw==
X-Received: by 2002:a17:906:2bd1:b0:a04:3571:e165 with SMTP id n17-20020a1709062bd100b00a043571e165mr1192100ejg.52.1700820983400;
        Fri, 24 Nov 2023 02:16:23 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-72cf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:72cf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b009fbf15cee7fsm1887801ejb.69.2023.11.24.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:16:22 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org
Subject: [PATCH v2 00/10] Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Fri, 24 Nov 2023 11:16:09 +0100
Message-ID: <20231124101619.6470-1-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

v2:
- fix style issue in patch 4
- add ack in patch 2
- set proper subject prefix for all patches

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---

 drivers/i2c/busses/i2c-ali1535.c                  |    2 +-
 drivers/i2c/busses/i2c-ali1563.c                  |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c                  |    2 +-
 drivers/i2c/busses/i2c-amd756.c                   |    2 +-
 drivers/i2c/busses/i2c-amd8111.c                  |    2 +-
 drivers/i2c/busses/i2c-elektor.c                  |    2 +-
 drivers/i2c/busses/i2c-gpio.c                     |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c                  |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 +-
 drivers/i2c/busses/i2c-isch.c                     |    2 +-
 drivers/i2c/busses/i2c-kempld.c                   |    3 +--
 drivers/i2c/busses/i2c-mlxcpld.c                  |    2 +-
 drivers/i2c/busses/i2c-nforce2.c                  |    2 +-
 drivers/i2c/busses/i2c-pasemi-pci.c               |    2 +-
 drivers/i2c/busses/i2c-piix4.c                    |    2 +-
 drivers/i2c/busses/i2c-scmi.c                     |    2 +-
 drivers/i2c/busses/i2c-sh7760.c                   |    2 +-
 drivers/i2c/busses/i2c-sibyte.c                   |    4 ++--
 drivers/i2c/busses/i2c-sis5595.c                  |    2 +-
 drivers/i2c/busses/i2c-sis630.c                   |    2 +-
 drivers/i2c/busses/i2c-sis96x.c                   |    2 +-
 drivers/i2c/busses/i2c-via.c                      |    2 +-
 drivers/i2c/busses/i2c-viapro.c                   |    2 +-
 drivers/i2c/busses/scx200_acb.c                   |    2 +-
 drivers/i2c/i2c-stub.c                            |    2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c |    2 +-
 drivers/staging/greybus/i2c.c                     |    2 +-
 27 files changed, 28 insertions(+), 29 deletions(-)
