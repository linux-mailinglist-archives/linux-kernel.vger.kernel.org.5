Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938967F01CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjKRSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKRSFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:14 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D32AA;
        Sat, 18 Nov 2023 10:05:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c87acba73bso1553431fa.1;
        Sat, 18 Nov 2023 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330709; x=1700935509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mu6uKqetedFX6br/8gaH2MKtwUbnJweRqllZD/aw3RQ=;
        b=UnP9jCsUWC29/s+NC+cz1N6kqRrEKoCIbfW2YrVFq4910JkmHcTTOOBnxSpwHAgKdQ
         UFF6c9yTh81IOFqjWKjbi1YJfVJrITvHyU+KgVmJT7od5Nxv2hbosw/xmuodtju8oT7p
         ktS4hnOaG1UfvcAfjGGv76GY4Ll8SV7Cl82OjoQSgUAB72kmsjwSeJ/R4sa9ncOWMfHs
         4+do9HZwRudipRKWzT+0f1VVQSkzR0NqFlqbornppcB6tKG3g6rLxLvOee2JivucQa0x
         wgUgGip/NvDz6cUB2VCE5cSX2VgfIpYogcS91p9NcgtXSkvwTAblKZoOqmDypMlOJXMa
         bKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330709; x=1700935509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu6uKqetedFX6br/8gaH2MKtwUbnJweRqllZD/aw3RQ=;
        b=lldtx2DrQfWRDCE3PRO+QHz3bs8xkItkXOtykQPwnH2RWjFZCCIhcFDnlAlQKMgMAW
         ZpkZjDO/FWS2YAivNewrE3sEsrn3RGKHJFAFC1ohHAxZKevBKp3LxAKRabDYAt/3rrqO
         d4uVDAsJPr4LXgfBGzlEVWlPlq7L5ogew6eswkf6cAmSGpEdAxa+sJVmQs/VHtMm4Tnw
         Sk/xtKa5tlIbZ0UqYLb3FuRFPK3hZXipvNGIaXgF0gEsOwk+HTlfdsENsftp4ceWxirD
         N/HjBrQGIlSP135bAr0HWHMab/Qy22ae8T5bvWsPbMCVwsoOzTPorIGeidkgUKuOwl3E
         taOg==
X-Gm-Message-State: AOJu0Ywl8YGOsZ1YGRQTs0YIRaoVP3TkkYCQRRr/Rdl59zg7vjnaoIVQ
        SSCaIsetJoAg3cy5vcwd+m0ZlvNin2rNng==
X-Google-Smtp-Source: AGHT+IHyeiAuLwBQ6RhMnfmUjm6ZpWN6lhi+Qcl6w/VI4MWj6Kf1RrN8easfjONwVJiPd/NUafO3dQ==
X-Received: by 2002:a2e:9c84:0:b0:2c5:1ea4:4e99 with SMTP id x4-20020a2e9c84000000b002c51ea44e99mr2049253lji.48.1700330708944;
        Sat, 18 Nov 2023 10:05:08 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:08 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org
Subject: [PATCH 00/10] Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:04:54 +0100
Message-ID: <20231118180504.1785-1-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 drivers/i2c/busses/i2c-kempld.c                   |    4 ++--
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
 27 files changed, 29 insertions(+), 29 deletions(-)
