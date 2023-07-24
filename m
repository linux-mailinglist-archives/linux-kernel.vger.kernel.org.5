Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B975ED1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGXIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGXIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:12:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B35FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:12:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso5755398a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186372; x=1690791172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEs5Elkh8KpHX4dWi/5NcMKXtNIiPWiIvPxVVX95BAQ=;
        b=nOvmKLYP0kaVsyj8lS4lIY5vgn5bWtwbrF0QSJo4PRUNjx3YToIosKPNeq414bpgzr
         2kaCL8lnq81+KoSMs2hEx0Vja4utU20HtsCvNjeyNMbwpxHJ2cfQgvwi5L+UXM6kslnZ
         TQAWsOMeAcUU3vomfje/ZX53XA1I1hTb6FEoIhhC+94V+vjubTKRgmwUhmr5VnDcfWgk
         taFUXE3Kg8Nu6KdnmjGun3sbMeAEpUadroQR+/HCr8OdMOzLGSKzADz0EbDViiS5n4Ua
         pZj5I+/zVm8ipVylR8LXleDC5yyVyiik/JNBZy1NDgfhg9Qu+85S408bt5dS706BInbb
         MG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186372; x=1690791172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEs5Elkh8KpHX4dWi/5NcMKXtNIiPWiIvPxVVX95BAQ=;
        b=ISe7hZM1hdUz+5GUgpZJIdknrTsHwC0RFpx68LRVT7sZk3nHxnUO0fxEQmAJcgZqJs
         UuELbTcikNy9KU4Q0D1J/UJrOThaG+C2wtg2WMSASD9rTFbrng2g5CIMK0MLyKA/FbqS
         NgobJhYrN8T05d3PemEa1fhyc8+KDAumRPz4XUjWNiGrzd0t61H6Yvs7Rbdu74gxKVex
         /+KVoP0/JBm/v45jbUT9G6uvp0s14FlSTeS5bAzAWVCIk0MsaEc4LU+yDtaZvz16gnCJ
         cI5+uyxwNk1tJUjr2PJ0YuBkzad62YgKagCO3KWj4jEsUMKBiymQ/V1TLZtpvJj6/igZ
         LoAw==
X-Gm-Message-State: ABy/qLafc2gGhQmEbzpQPZPg1fsVVlz3N5+kdqnVzl2JuwoLVwoBXwNi
        ufeE/x2pWQzRet7RODZJZmaFLQ==
X-Google-Smtp-Source: APBJJlFZL+LwqhO7C1mU9zkXCbO4DjpMuSTtZXgNbxfXFy6h19T8Vc3fkWFVunZyrK+c/xqOtXmN4w==
X-Received: by 2002:a17:906:845a:b0:997:e8b8:8d6 with SMTP id e26-20020a170906845a00b00997e8b808d6mr8476075ejy.28.1690186372491;
        Mon, 24 Jul 2023 01:12:52 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:12:50 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v3 00/11] mtd: spi-nor: spansion: Add support for Infineon S28HS02GT
Date:   Mon, 24 Jul 2023 11:12:36 +0300
Message-Id: <20230724081247.4779-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=tudor.ambarus@linaro.org; h=from:subject; bh=r93ys5sJSroZh74RBaA09W0EcErJwZZs/A7P7LX6wWY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ9qSJlLJTV3bAHOKJsncEtPW8d1GXsYPEym lWHLYQ43gOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfQAKCRBLVU9HpY0U 6QlQCACD8isZbG9xaAN/jwvQ7ZFm2H4UzmUHONCMxReEBEF5fdyLxOgwq7dAyFHvQUrTG9ZyVsF /ldvxYieh4lE5zQLsscvvF+3oSGt41UBLlXj6Ht1CsQxmBKL0MRC8eHUoPF/J8vIaf3W/C3lkfF H6lsR/OVmjktcf6QhS1e4sg3yWrZzZtXxPM/pe6bITTVVnzQnAZvgvz3wequTkp8Lq1KvmoHZ79 JnMpvjsHedyOxR1CJ9GSh5e1AtvdRIfX6DI/wYysdSzNY2yhGcnTNuFEUCof868ahMb6RkjvxgV yDeioN9Zl2LCnjYDHDePZPOMxWxSTPQBWKv+Y4nIeEnxfjyj
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as patch 10/11 and 11/11 were not sent.

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

