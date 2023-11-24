Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021237F8061
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345801AbjKXStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjKXStH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:49:07 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36822689
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00cbb83c80so320302766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700851751; x=1701456551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPAeyz9k4F2/8+xxiqRu3IH03YG4sRfDz9C1iuGnbeY=;
        b=wDZn+F4CDd2SseUEweS2R7CqgIvICf5OAKseh1T9X6fER3u+zcUlvqWEBtmuOWkanB
         XpYmTMi5+eB4vpf7TJQFSE2TKfntgfJ5NtkBiV1F9ePW9FfkrhEz7yge6yhD7+XGV7AP
         P/8WHiz9djEWfIb3ceQ3ZPeC17M+IiIWKiD2xi5qfHcVM3gtnGBdJB64YuptzgoJ9dDF
         Fpol7rGpaBzXc8l78H2qJDyB+tsD56DYWxUdA6c+zO7L2z0ot+OeHD7gFAWQsPPtotxi
         NQP1OvikS7khXJEByYHnezgcrpcEzJgTWMAVzmJU54MxbZyK3vvB2ltZ6BWPnE08iJ2B
         ZcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851751; x=1701456551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPAeyz9k4F2/8+xxiqRu3IH03YG4sRfDz9C1iuGnbeY=;
        b=WarlUGH95ws8kCsePyliz8/txrDF2sgqNZ/8ATU3xSqkmETxfLbPeZJMWyBBbGl69e
         wpqJUw35WGQtYtZYdd6cth7bf06F2EiaRAltu2KPt3N4e2Ey6QJkdMICebEJXCcVM0zK
         CnBeqKk5pgXHaVCkqnBUfLUbwn4xREsxdnAycpB5ZRDDiT/BQHedrSVUf0/Q/+Of9KAQ
         35FMioHtMqC0hcu0JsYvbFw1n8+SjHASg7JwaHWCTEVEZY5R+yzyJV3rgtGy5LBe6U0/
         42flGaZuWxEjWvXMLpV0qF0/+5zWXFlAbl2liv9dZNEa0P0UpE3sF+h/EoIzQYAK1lfG
         0+UA==
X-Gm-Message-State: AOJu0YyqDUuxnOF5g4SKd+Y7ICNbB+Z22osna4dfuvCQQQrWyjOg3zrL
        gAdRbXyGDvwCMPtIXn4QdERoQw==
X-Google-Smtp-Source: AGHT+IHM+7N86XyFsu3v++O/aZeVJ5G1IpdWaOXQ5UwkoZDUjKVIe1Ss2x/1Glf7eJejPUH1iydAnw==
X-Received: by 2002:a17:906:20da:b0:a01:d2db:205d with SMTP id c26-20020a17090620da00b00a01d2db205dmr2821398ejc.4.1700851751197;
        Fri, 24 Nov 2023 10:49:11 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm2376405ejc.22.2023.11.24.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:49:10 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, bagasdotme@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 1/2] docs: mtd: spi-nor: add sections about flash additions and testing
Date:   Fri, 24 Nov 2023 20:49:01 +0200
Message-Id: <20231124184902.1194235-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
References: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7893; i=tudor.ambarus@linaro.org; h=from:subject; bh=IMDfx6DUmrHVQGoOR27uJ52FlgdVfWxW6AWpvtFW3uE=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYPAeFkBk6lSi0J/XBG9Kgi9Oc3VeHW+Ce8C9a iEHhLgg/AWJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWDwHgAKCRBLVU9HpY0U 6RuECACv5L3gI2Z0MRMAokMW0QbjkCs8+imsB+YgyG/wU4MGPI9elwEJ9GfU8nwidg6ir4EqNrH 3xGQ2ov0A0J75+GEJffb1ARtKMN9ViwWgf306Qg23ZpkC/R7i0+oUHt0/a0qR035nf9wKm9z6Ar 1xYsLaYzMg5CS4Q4w/yZV7HnJphXP73mQ0+LfWLCoeYASx2rKf+Vyyxg1wOEFPj7bxe1D+opGcu BJdoRGAexgyU/OY99rSaGdR2jl9IROjPWMt4XNiAv98EnbR2/+eLPC7BU4ByyeQdnbPJ/3o57ER p4qf892gp1FERWUcDVhoxqgNdoVY/9A+jut0QmSe6ACjhDUd
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sections about how to propose a new flash addition and about the
minimum testing requirements.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 Documentation/driver-api/mtd/spi-nor.rst | 187 +++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index c22f8c0f7950..3b2e1a6a88bf 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -63,3 +63,190 @@ The main API is spi_nor_scan(). Before you call the hook, a driver should
 initialize the necessary fields for spi_nor{}. Please see
 drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
 when you want to write a new driver for a SPI NOR controller.
+
+How to propose a new flash addition
+-----------------------------------
+
+Most SPI NOR flashes comply with the JEDEC JESD216
+Serial Flash Discoverable Parameter (SFDP) standard. SFDP describes
+the functional and feature capabilities of serial flash devices in a
+standard set of internal read-only parameter tables.
+
+The SPI NOR driver queries the SFDP tables in order to determine the
+flash's parameters and settings. If the flash defines the SFDP tables
+it's likely that you won't need a flash entry at all, and instead
+rely on the generic flash driver which probes the flash solely based
+on its SFDP data. All one has to do is to specify the "jedec,spi-nor"
+compatible in the device tree.
+
+There are cases however where you need to define an explicit flash
+entry. This typically happens when the flash has settings or support
+that is not covered by the SFDP tables (e.g. Block Protection), or
+when the flash contains mangled SFDP data. If the later, one needs
+to implement the ``spi_nor_fixups`` hooks in order to amend the SFDP
+parameters with the correct values.
+
+Minimum testing requirements
+-----------------------------
+
+Do all the tests from below and paste them in the commit's comments
+section, after the ``---`` marker.
+
+1) Specify the controller that you used to test the flash and specify
+   the frequency at which the flash was operated, e.g.::
+
+    This flash is populated on the X board and was tested at Y
+    frequency using the Z (put compatible) SPI controller.
+
+2) Dump the sysfs entries and print the md5/sha1/sha256 SFDP checksum::
+
+    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
+    sst26vf064b
+    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
+    bf2643
+    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
+    sst
+    root@1:~# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
+    53464450060102ff00060110300000ff81000106000100ffbf0001180002
+    0001fffffffffffffffffffffffffffffffffd20f1ffffffff0344eb086b
+    083b80bbfeffffffffff00ffffff440b0c200dd80fd810d820914824806f
+    1d81ed0f773830b030b0f7ffffff29c25cfff030c080ffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffff0004fff37f0000f57f0000f9ff
+    7d00f57f0000f37f0000ffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+    ffffbf2643ffb95ffdff30f260f332ff0a122346ff0f19320f1919ffffff
+    ffffffff00669938ff05013506040232b03072428de89888a585c09faf5a
+    ffff06ec060c0003080bffffffffff07ffff0202ff060300fdfd040700fc
+    0300fefe0202070e
+    root@1:~# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
+    428f34d0461876f189ac97f93e68a05fa6428c6650b3b7baf736a921e5898ed1  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
+
+   Please dump the SFDP tables using ``xxd -p``. It enables us to do
+   the reverse operation and convert the hexdump to binary with
+   ``xxd -rp``. Dumping the SFDP data with ``hexdump -Cv`` is accepted,
+   but less desirable.
+
+3) Dump debugfs data::
+
+    root@1:~# cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
+    Supported read modes by the flash
+     1S-1S-1S
+      opcode		0x03
+      mode cycles	0
+      dummy cycles	0
+     1S-1S-1S (fast read)
+      opcode		0x0b
+      mode cycles	0
+      dummy cycles	8
+     1S-1S-2S
+      opcode		0x3b
+      mode cycles	0
+      dummy cycles	8
+     1S-2S-2S
+      opcode		0xbb
+      mode cycles	4
+      dummy cycles	0
+     1S-1S-4S
+      opcode		0x6b
+      mode cycles	0
+      dummy cycles	8
+     1S-4S-4S
+      opcode		0xeb
+      mode cycles	2
+      dummy cycles	4
+     4S-4S-4S
+      opcode		0x0b
+      mode cycles	2
+      dummy cycles	4
+
+    Supported page program modes by the flash
+     1S-1S-1S
+      opcode	0x02
+
+    root@1:~# cat /sys/kernel/debug/spi-nor/spi0.0/params
+    name		sst26vf064b
+    id			bf 26 43 bf 26 43
+    size		8.00 MiB
+    write size		1
+    page size		256
+    address nbytes	3
+    flags		HAS_LOCK | HAS_16BIT_SR | SOFT_RESET | SWP_IS_VOLATILE
+
+    opcodes
+     read		0xeb
+      dummy cycles	6
+     erase		0x20
+     program		0x02
+     8D extension	none
+
+    protocols
+     read		1S-4S-4S
+     write		1S-1S-1S
+     register		1S-1S-1S
+
+    erase commands
+     20 (4.00 KiB) [0]
+     d8 (8.00 KiB) [1]
+     d8 (32.0 KiB) [2]
+     d8 (64.0 KiB) [3]
+     c7 (8.00 MiB)
+
+    sector map
+     region (in hex)   | erase mask | flags
+     ------------------+------------+----------
+     00000000-00007fff |     [01  ] |
+     00008000-0000ffff |     [0 2 ] |
+     00010000-007effff |     [0  3] |
+     007f0000-007f7fff |     [0 2 ] |
+     007f8000-007fffff |     [01  ] |
+
+4) Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
+   and verify that erase, read and page program operations work fine::
+
+    root@1:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
+    2+0 records in
+    2+0 records out
+    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
+
+    root@1:~# mtd_debug erase /dev/mtd0 0 2097152
+    Erased 2097152 bytes from address 0x00000000 in flash
+
+    root@1:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
+    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
+
+    root@1:~# hexdump spi_read
+    0000000 ffff ffff ffff ffff ffff ffff ffff ffff
+    *
+    0200000
+
+    root@1:~# sha256sum spi_read
+    4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
+
+    root@1:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
+    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
+
+    root@1:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
+    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
+
+    root@1:~# sha256sum spi*
+    c444216a6ba2a4a66cccd60a0dd062bce4b865dd52b200ef5e21838c4b899ac8  spi_read
+    c444216a6ba2a4a66cccd60a0dd062bce4b865dd52b200ef5e21838c4b899ac8  spi_test
+
+    root@1:~# mtd_debug info /dev/mtd0
+    mtd.type = MTD_NORFLASH
+    mtd.flags = MTD_CAP_NORFLASH
+    mtd.size = 8388608 (8M)
+    mtd.erasesize = 4096 (4K)
+    mtd.writesize = 1
+    mtd.oobsize = 0
+    regions = 0
-- 
2.34.1

