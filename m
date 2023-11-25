Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38877F8ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjKYMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:35:37 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A919D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so33489081fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700915740; x=1701520540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IenxDwVtrvJhjRe1CZt0FogzHl3GObYK8Ov3yOrH4vM=;
        b=q1lXMvs28X1HtDqpDFa+k6nGJQVY6PW85urE9cXnriEhvYw84iRlX8IrEbUIGF6E0d
         xpBx/KPGPq5dlBI8ooTacdxvhwv0/me469gxkjbxK0Oi3hZj804gEEWoj4VXgt8OPfR/
         WCi81snSkvW/6frGqZxfF5tJCPG+9UXoQTsXUA2W2XZqxxUdfGLNpVXXSd1LvzWSwUk5
         sXxaPbcmOmrrCSD0vElfNujuOWQPWS5V/aUXm91B5fUyQH9kRalt62S5zGRIdNgGcmgB
         XYB39wQqr/F7d/jzJKTyTy1p2I4gkaqxfKLGYiZLJd9AWJrxam9W2EFIah9JcI/2IsZF
         uzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915740; x=1701520540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IenxDwVtrvJhjRe1CZt0FogzHl3GObYK8Ov3yOrH4vM=;
        b=QspyzxmWz/T/zfRv2NtWIR7Fs7OeZawgLl7/gCKuB5SVLjv9wjnAfpK8eXMIKHl4UV
         WJ+IUDUy0EIe7Pf89ZYuVCiUsbhNAG482yYh/bkZEKty7m9jWGkbGEEzpmr7eJgqp0l4
         J6Fq/DHjick9+i3y1QUeXqZ4XPfSEGWRXdgBdUxwgPFyYMXDRJb2bpiMOtpPPo0ZMvAh
         qhITfV7waOQFsZw9GgKvhBKhCWr20C6LbzrLmSpThUF5OOPg5omEAg6hqQhBA4MSsjaY
         U9tfMIwyvMVoz6PenXNhN5dveBvs6y/M95V8MSksK7bbSgPGGLzcb6bsUopGwKGU5Uq0
         pc6w==
X-Gm-Message-State: AOJu0YyiVyjNlJiXC7S1PJOjmYFhBgT71ukxyCOgz/Q43nyk+wjT5vqu
        3ebzaPfH/ENwpro34BdJKyUJZQ==
X-Google-Smtp-Source: AGHT+IHbDRK3mkmTMaNGNwc6n42l97rc56mrZFVJ2Zgg+VQJPnfN2soJxQEXezDgnPIOdB0rG9mDcg==
X-Received: by 2002:a2e:994b:0:b0:2c8:7421:f0b4 with SMTP id r11-20020a2e994b000000b002c87421f0b4mr4334225ljj.27.1700915740482;
        Sat, 25 Nov 2023 04:35:40 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm3390163ejb.209.2023.11.25.04.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 04:35:40 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, fastevam@denx.de
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
Date:   Sat, 25 Nov 2023 14:35:24 +0200
Message-Id: <20231125123529.55686-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=tudor.ambarus@linaro.org; h=from:subject; bh=ET4nej2fkYuJJH06/u65/dyHT3qeYqBPblhk2M6LCWI=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYeoQsHuuLgw++eZrR2gX5lRXMpqhMPjGC7Axs 3i2O3dC7DyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWHqEAAKCRBLVU9HpY0U 6b10B/9kyec2DqmHLyLcwnNX34fGbimfAQ4jI5UXnDPE/nJg9rxb1rcFQn9OicZcLu+Ti+Ps4H7 kOVjCp9aN48lmDbFgysb71OH1VZb482V8LBOalMJ1wgWL8uI+o4xhd1iL6yF93QEIsEdc7KYyKD K+6A4x6DilnL2afQqE3vaW76C+gvgXrAHnBmV25bV65tVZ0a5u/6tUsDMKRpxUO+HypG3Y6rp2h JGXx/8mY8M+BDcJi3j280BIDLN9C40cUstjP7dhku1QqiP0FPRxjlPI3HMjgtdfl6B8zdfR68iR 6w2xhY7lh+UezCV69t0HbURKKmPmIIM8S/tiB0kSCFAJZlFH
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
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

changes in v3:
- fix code, thanks to Fabio's testing
- found a n25q00 and tested on my side too
- fixed micron's die erase support

Add support for die erase.
JESD216 mentions die erase, but does not provide an opcode for it.
Check BFPT dword 11, bits 30:24, "Chip Erase, Typical time", it says:

"Typical time to erase one chip (die). User must poll device busy to
determine if the operation has completed. For a device consisting of
multiple dies, that are individually accessed, the time is for each die
to which a chip erase command is applied."

So when a flash consists of a single die, this is the erase time for the
full chip (die) erase, and when it consists of multiple dies, it's the
die erase time. Chip and die are the same thing.

For what concerns the Micron flashes, unfortunately Micron does not
provide a 4-byte opcode equivalent for the die erase. The SFDP 4BAIT
table fails to consider the die erase too, the standard can be improved.
Thus we're forced to enter in the 4 byte address mode in order to benefit
of the die erase. This comes with some changes into the core.
    
Tested on n25q00. This flash defines the 4BAIT SFDP table, thus it will
use the 4BAIT opcodes for reads, page programs or erases, with the
exception that it will use the die erase command in the 4 byte address
mode. 

Fabio Estevam (1):
  mtd: spi-nor: micron-st: Add support for mt25qu01g

Tudor Ambarus (4):
  mtd: spi-nor: add erase die (chip) capability
  mtd: spi-nor: spansion: enable die erase for multi die flashes
  mtd: spi-nor: micron-st: enable die erase for multi die flashes
  mtd: spi-nor: remove NO_CHIP_ERASE flag

 drivers/mtd/spi-nor/core.c      | 143 ++++++++++++++++++++------------
 drivers/mtd/spi-nor/core.h      |  16 ++--
 drivers/mtd/spi-nor/debugfs.c   |   2 +-
 drivers/mtd/spi-nor/micron-st.c |  59 ++++++++++++-
 drivers/mtd/spi-nor/spansion.c  |   4 +-
 5 files changed, 158 insertions(+), 66 deletions(-)

-- 
2.34.1

