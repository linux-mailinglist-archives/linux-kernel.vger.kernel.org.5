Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151575DB09
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGVIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:40:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C978199D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso437736766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015213; x=1690620013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDbxGBBa8HzdMTgp8+AGW1sIJ+nN/+KO59SLLlDp6qg=;
        b=XjQ0zDZWbGFbMNROZ9LxtaA/NTqhyZbwM62OQaBHsT1ez0iWPLPGW2xoQYDVRXw1eb
         ojV6FoMjtHc7FeugJDIZdX0P3q5tlzA74A/x+jwWEY5rDr2uprnWN/yHYhwAgGTdkUmB
         fXGlLx8k6PeNdxUs3X/VesAJj/uKJiyOuLEvQCr83Fo1i0bsM43CEyCw8saJHoHWg1x+
         jbeYK/amukmQ1CbCnI3IpmrTM9+NLcKcxDYz4VV+Yc0vdqSECkN8rpHmCnOfnj0RxLGR
         gqE/LWhGWeidbdx+SvYXaTWxTfDO8zgsWKoWI29UtyfYN12LU0jFPmz3XMKr/j979G7c
         4j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015213; x=1690620013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDbxGBBa8HzdMTgp8+AGW1sIJ+nN/+KO59SLLlDp6qg=;
        b=XByZe64+cXPWdYyJB9tOnz5l/GhI07cpPhXHIDiMq2Yw37wFXjUb24+T7ntQbVgYlG
         5/lH5n/rlnQoOvKgg57a7MjPNotKeNkHVnLbo0J2MHmsEwHqblv5MgMnYLl5SpgSfTTO
         b7E4kUx7Ky4GR1BFzauSUlT5ct4Il1gYr6Pf8x/LCHjEre/+Neme28otXgFkOXa4hMz3
         QOtWVm2H7jsrybpmfUt9VlGosW/tTG7mJNhxgq+WXQEGkKhG/tSUKWPwo5r2TrAJ+/n9
         4T6Qbsf+Tjgx5WAbBjpL7tRmgPFAfYMYYmI87QuKehBkuyNeDBWtDuIP2/cFoJ1/ABAD
         r2Qg==
X-Gm-Message-State: ABy/qLY6n5+biW0+2b2G7TWXefHFbaQgujunW8JR6jhjUrb0Y0q9OqcE
        Hb9qNl5fipDbOpuEM1blD6afTQ==
X-Google-Smtp-Source: APBJJlEqWoA0uVdEyLN/A+Z69+lmf3cZMmh7DhBEDSmoMbu1dJn2om86VqVXY+oHG0DXlt1He0NREQ==
X-Received: by 2002:a17:906:64d2:b0:993:d6a7:13b with SMTP id p18-20020a17090664d200b00993d6a7013bmr3972686ejn.22.1690015212827;
        Sat, 22 Jul 2023 01:40:12 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:09 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 00/11] mtd: spi-nor: spansion: Add support for Infineon S28HS02GT
Date:   Sat, 22 Jul 2023 11:39:55 +0300
Message-Id: <20230722084004.21857-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=tudor.ambarus@linaro.org; h=from:subject; bh=1H2nUh8+DtT2I4SlyapMiSVxwqMawXA1UY2QiNflkLY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5Xj3a4UjnbXGOAwpzYTCmJoLtQ4oOBgtXo86 mlFzvHNdbuJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6V0jCACADkPWEmB8IML4vMgl+L4XiES6DE7MPeGWFNkwp6YkmaZKuYHuHlkzNRnfg8HlKMQsFae UjUp56l1CUWHsoSDIl1TOq8yYiZRiz2j2Jzq1GEZBIwRtW9tunQxVSLyYvdjNHp1NUDIWrWQtav gR/6xJ1jsnLvOz2pTOSKcew68Nw3uf8D9Y13E/6Tpv3m48nLc6Z335JkgxrQ7ek8V71Jmt76Sjm jyIbQqiky3/nUiW2pFf4N4CQJLuhkdzePCag7r6ChDgKnEJsaAL18ZMfe0aZy7MQavAHgV3bdwM XqBsX9d0IQyB6W1FNAqZlbODCbKylg3Y5obmj+3jBGJx0sUN
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro, since you already have to test all these flashes, I took the
liberty and added some other changes that would be good to have. The
first one lets SFDP determine the flash size and sector size. Michael is
in the process of changing how INFO is handled, we'd like to get rid of
these params when SFDP tables are defined. The other 2 patches
consolidates a bit the spansion code with the idea that we should use
the same code paths for both single (SCP) and multi chip package (MCP)
flashes were possible. We avoid this way code duplication and have
better test coverage on the code. On your patches I modified how/where
"if (!params->n_dice || !params->vreg_offset)" is handled. Please review
all and if you agree with the changes, retest on all flashes. Everything
looks good to me, if the tests pass, I'll queue all.

Cheers,
ta

Takahiro Kuwano (8):
  mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR
  mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
  mtd: spi-nor: spansion: prepare octal dtr methods for multi chip
    support
  mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
  mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
  mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
  mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
  mtd: spi-nor: spansion: add support for S28HS02GT

Tudor Ambarus (3):
  mtd: spi-nor: spansion: let SFDP determine the flash and sector size
  mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for
    quad_enable()
  mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use
    vreg_offset

 drivers/mtd/spi-nor/atmel.c     |   8 +-
 drivers/mtd/spi-nor/core.c      |  23 ++-
 drivers/mtd/spi-nor/core.h      |   4 +-
 drivers/mtd/spi-nor/issi.c      |   4 +-
 drivers/mtd/spi-nor/macronix.c  |   4 +-
 drivers/mtd/spi-nor/micron-st.c |   4 +-
 drivers/mtd/spi-nor/spansion.c  | 294 +++++++++++++++++++++-----------
 drivers/mtd/spi-nor/sst.c       |   8 +-
 drivers/mtd/spi-nor/winbond.c   |   4 +-
 drivers/mtd/spi-nor/xilinx.c    |   4 +-
 10 files changed, 239 insertions(+), 118 deletions(-)

-- 
2.34.1

