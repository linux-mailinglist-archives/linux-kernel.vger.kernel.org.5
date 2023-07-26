Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03B762F02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGZIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGZIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7EE1736
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso64401265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357983; x=1690962783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgxURezd7xMpovKkYbI4YVARAnRubfgjmfxqjMPofjs=;
        b=mCwxsEugZ2gi+GfhkMp1Rf0WSVBgVWptoYqELSfEOpfShmJlBgIkW8HkBwj/Hf6oYL
         EUzl3zlHpnBx+hkNPFe4X2jPEhjfKBIpqMaIycAy8vIq3F66Bh0pF/RGsUuMWoe+Yj4V
         lwffuXENYQuTAssxHsKsh8q4Gd7DOowl4uT+Qb0oPj6lnz1fZR440kmWMwQVd0ARme3T
         ZjPj2ZTV7fIFogPzTxbsvK1UbFq3S3e3ZBV5kGlyBJZLGPBrpH52G8/RBh0yzjqXl2nG
         cFo8KpGIU++aA1LF57bYJ5gGYsubWuY8yAQrOx7iloC3XxA3iQjXBTiKBZ92ghdi0/Os
         jteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357983; x=1690962783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgxURezd7xMpovKkYbI4YVARAnRubfgjmfxqjMPofjs=;
        b=lQHevveEMw/2SV1EPL+F37wzAiwtVoW0WySUMgPt3NeBk0HDfHvo5AfrsrbN2HNTrS
         p72IWWw7NIbBklHBsW/w+QDwZY2lzcXsK5nH/ztTLyzKQCE2vdRNWJCZPqDnx45UFYz6
         K5PP0V/XGNZIUqaj/ZHyWu5Xh3jaweYLOhD9BZ3wX/Jy08m4bSWuxfA1rGGi18ghZt1O
         appq1JmJh4WsfZYOoklqXQ2vrIELr4NxbXxemWST/WOy9inPHFLf7rjHf1+GjR9eYv1c
         2ScmrdEYUJPs8TGzYAm5xnYea1gcIOmto4Lp9XHnWSJ9qzw7MTv6uk+uTpGV0NWc4fFD
         r+yA==
X-Gm-Message-State: ABy/qLai72g9maT2GRvsgcd6vqiT35GifJM4uRjW5vq80d17dBUnr6/U
        eO+mCxGzyf4B3G3xHjosL8Lbmg==
X-Google-Smtp-Source: APBJJlG3IXSeYkqjgloD5M6PeUC36krV2b13mFZ5oQZcQJXiXIYN9wDPBgpkZnTZqk30LWC35BHCwg==
X-Received: by 2002:a05:600c:22d0:b0:3fb:40ff:1cbc with SMTP id 16-20020a05600c22d000b003fb40ff1cbcmr735273wmg.10.1690357983296;
        Wed, 26 Jul 2023 00:53:03 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:02 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 00/11] mtd: spi-nor: spansion: Add support for Infineon S28HS02GT
Date:   Wed, 26 Jul 2023 10:52:46 +0300
Message-Id: <20230726075257.12985-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3880; i=tudor.ambarus@linaro.org; h=from:subject; bh=/afqJeKLuNtYmKNVMU+5YdXP5HjD85fu5MdBIhF0KIQ=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDXyjz2ZW61Y78YBxsxTSQ7jMorODT6SViTC XymyVPTeKOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ1wAKCRBLVU9HpY0U 6az8B/9l9tM7+8Os/Fxqz+s0eKdlLTjhhVKYIuGr9JQ+UQ+lF4xQmZcW8v7FYJlV/1DncVP6sXH XKB9uAmdOqQAUkNa26kdtC02xfFeCO5CRGCRoW2yPH//vKCebNvsFRHfShD0+Aa9eOcVZCl9JtX e4n+SgvGIgdpiN3UDqXzi57gGBTj6owyTzaL/dueJH5fmn5hbhu6DEHENZz4PE6InM2K9SHrQm9 bv6V2c0m/0VwAGUnCcxxQXXV7lz4hKhkY+zgeNPAPOJL9GhioGoZ/rd3ZpHHrff4vDhID3vGXA3 WqVJMxrEtiVipDGGSIPvol0sX1oRUd0Uf4+TorjJfhvgKT2b
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- define vreg_offset for S25FS256T in the post_sfdp hook. The goal
is to use the same code base for both single and multi chip package
flashes.
- get rid of SPINOR_REG_CYPRESS_CFR{1,3,5}V as they are no longer used

---
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
s28hs02gt
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
345b1c
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
spansion
zynq> xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450080106fe00000114000100ff84000102500100ff050001055801
00ff8700011c6c0100ff88000106dc0100ff81000118040200ff0a000104
f40100ffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffff7218affffffff7f000000000000
0000eeffffffffff0000ffff00000c2100ff00ff12dc23faff8b82e7ffec
ec2319497ab07ab0f766805c000000fff910c0a0000000000000bc020000
0000ffff7e7e41120ffe21ffffdc00ee800b7171656500b0ff9600000000
0c551ca20000800000000000c0ccfffb88fbfffb00650090066500b10065
009600650095716503d0716503d0a46bfb0290a579a20040288e0000ff00
0000ff0071650690716506900000000000000000716506d1716506d17165
0691716506910000ff000000ff00716505d5716505d50000a01500008008
000000080000801000000010000080180000001800000601000000008000
710600030600fc65ff0804008000fc65ff0402008000fc65ff0804008008
fd65ff0402008008fe0202fff1ff0100f8ff0100f8fffb0ffe0902fff8ff
fb0ff8ff0100f1ff0100fe0104fff1ff0100f8ff0100f8fff70ff8ff0100
f1ff0100ff0a00fff8ffff0f                                    
zynq> md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
6193b9729008b80b9a2b4bb3ce06a91d  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
zynq> test_qspi.sh
6+0 records in
6+0 records out
6291456 bytes (6.0MB) copied, 0.234679 seconds, 25.6MB/s
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash
Erased 6291456 bytes from address 0x00000000 in flash
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0600000
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read
3020d73d4d0e570449faacfbadf134e074ced30e  qspi_test
3020d73d4d0e570449faacfbadf134e074ced30e  qspi_read

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
 drivers/mtd/spi-nor/spansion.c  | 306 +++++++++++++++++++++-----------
 drivers/mtd/spi-nor/sst.c       |   8 +-
 drivers/mtd/spi-nor/winbond.c   |   4 +-
 drivers/mtd/spi-nor/xilinx.c    |   4 +-
 10 files changed, 245 insertions(+), 124 deletions(-)

-- 
2.34.1

