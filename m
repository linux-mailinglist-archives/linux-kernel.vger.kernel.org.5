Return-Path: <linux-kernel+bounces-21967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F53829749
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56391F280F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A70405C1;
	Wed, 10 Jan 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhZJ7IOS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748B3FE29
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so9989655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882067; x=1705486867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGwLRfnub8dBApg/XxzYvJOVSVtHxB8WxqDRuK8mr/U=;
        b=LhZJ7IOSwCP8ZfxaEPeFYVHqmYwVosuGXWr0k7YTHY4kIKLGsajoway9afbP2cTfaB
         eOgeWmgk39Cq5kWcQSEH9aes/SdXL5VSMOqRwlNVJoeqHtxY+/UfoTOoFG9hYBDM/MUD
         KbO+YkmBQ79MMko8ioRR669XdOsKK2zhoscJDI8wnzCEUS1QC0A/yXF6hYp0X0Sp8Cp6
         8Dnh4h7Mehm8ptte5EB+XnXPhGTYOXRcnBTxyuG9q4OHeJrZQtU/z4vQELaSVXOiLKA6
         JuOXFLEC6EfU4dTscekL/Osa404g3oxJwa0wu/pv9mluG5ssCq4MGj7TBzjsLGhDoTn4
         g0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882067; x=1705486867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGwLRfnub8dBApg/XxzYvJOVSVtHxB8WxqDRuK8mr/U=;
        b=st7kBJqZA6bjYBBnskeNSjFHrCYDTHPjr4T/Na780jvkd84tq89pkzjlbZmmnorYqg
         WSF6lHayMe1BRqLL896oAJ5jYFXlhhA+Bc/kp7U1fA3eByOc2+tFEa683HR5mUuoFm8k
         3DbPMSunpL+bAIxCH9pSDGtWIv0xoUPVQJ+Nzp4GdAIlppRIVs3a/9R6dSo+c+xPPbgQ
         p2p/c+HzdL+nPqoU/IOZymuMBqxrF3UMrrGjXTNxXJqC7O9cqGrAlx3EpxZvx5fmOG8P
         /SYC/lMn4Pb0pDH3RHJGUEamQ/G7qjIbuoqqAaqmiwprRKZcNLenkDBuJL/Wb9weEZUq
         V1kQ==
X-Gm-Message-State: AOJu0YyIe6rNm9C6xOg2uEtSDl/YaOywngt2/GDrjqdgii1E0s3DQq60
	UU21ymdbk7tOcHbhn0DJkkV/vsC3UebxTQ==
X-Google-Smtp-Source: AGHT+IEA2VFjnUEp2T4A6S/3sZBR/HF7hcmBKXShhvjGuqHQQ1485DLikAWJcE2CeJ4oVie5t/D82w==
X-Received: by 2002:a05:600c:a0a:b0:40e:52c1:116b with SMTP id z10-20020a05600c0a0a00b0040e52c1116bmr438067wmp.142.1704882067569;
        Wed, 10 Jan 2024 02:21:07 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:07 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 00/18] serial: samsung: gs101 updates and winter cleanup
Date: Wed, 10 Jan 2024 10:20:44 +0000
Message-ID: <20240110102102.61587-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The patch set is intended for v6.9 and is expected to be queued through
Greg's tty tree.

The patch set includes updates for GS101 so that we infer the IO type
from the compatible. This is because the GS101 Peripheral Blocks, which
include the serial, only allow 32-bit register accesses. So instead of
specifying the reg-io-width = 4 property everywhere, deduce the iotype
from the compatible. The GS101 patches were previously proposed at:
Link: https://lore.kernel.org/linux-arm-kernel/20240109125814.3691033-1-tudor.ambarus@linaro.org/

The patch set then includes some cleanup changes that started as a
consequence of trying to reduce the memory footprint of the
``struct s3c24xx_uart_info``. For arm32 the struct was not as bad
defined as for arm64, because all its members could fit in the same
cacheline. But for arm64 we started from:

struct s3c24xx_uart_info {
	const char  *              name;                 /*     0     8 */
	enum s3c24xx_port_type     type;                 /*     8     4 */
	unsigned int               port_type;            /*    12     4 */
	unsigned int               fifosize;             /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          rx_fifomask;          /*    24     8 */
	long unsigned int          rx_fifoshift;         /*    32     8 */
	long unsigned int          rx_fifofull;          /*    40     8 */
	long unsigned int          tx_fifomask;          /*    48     8 */
	long unsigned int          tx_fifoshift;         /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	long unsigned int          tx_fifofull;          /*    64     8 */
	unsigned int               def_clk_sel;          /*    72     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          num_clks;             /*    80     8 */
	long unsigned int          clksel_mask;          /*    88     8 */
	long unsigned int          clksel_shift;         /*    96     8 */
	long unsigned int          ucon_mask;            /*   104     8 */
	unsigned int               has_divslot:1;        /*   112: 0  4 */

	/* size: 120, cachelines: 2, members: 16 */
	/* sum members: 104, holes: 2, sum holes: 8 */
	/* sum bitfield members: 1 bits (0 bytes) */
	/* padding: 4 */
	/* bit_padding: 31 bits */
	/* last cacheline: 56 bytes */
};

and after the cleaning we get to:

    struct s3c24xx_uart_info {
            const char  *              name;                 /*     0     8 */
            enum s3c24xx_port_type     type;                 /*     8     4 */
            unsigned int               port_type;            /*    12     4 */
            unsigned int               fifosize;             /*    16     4 */
            u32                        rx_fifomask;          /*    20     4 */
            u32                        rx_fifoshift;         /*    24     4 */
            u32                        rx_fifofull;          /*    28     4 */
            u32                        tx_fifomask;          /*    32     4 */
            u32                        tx_fifoshift;         /*    36     4 */
            u32                        tx_fifofull;          /*    40     4 */
            u32                        clksel_mask;          /*    44     4 */
            u32                        clksel_shift;         /*    48     4 */
            u32                        ucon_mask;            /*    52     4 */
            u8                         def_clk_sel;          /*    56     1 */
            u8                         num_clks;             /*    57     1 */
            u8                         iotype;               /*    58     1 */
            u8                         has_divslot:1;        /*    59: 0  1 */
    
            /* size: 64, cachelines: 1, members: 17 */
            /* padding: 4 */
            /* bit_padding: 7 bits */
    };

Also note that sorting the include files in alphabetic order in the
driver revealed some problems that were fixed with the following
patches:
Link: https://lore.kernel.org/linux-arm-kernel/20240110074007.4020016-1-tudor.ambarus@linaro.org/
Link: https://lore.kernel.org/linux-kernel/20240109141045.3704627-1-tudor.ambarus@linaro.org/

Cheers,
ta

Tudor Ambarus (18):
  tty: serial: samsung: prepare for different IO types
  tty: serial: samsung: set UPIO_MEM32 iotype for gs101
  tty: serial: samsung: add gs101 earlycon support
  tty: serial: samsung: sort headers alphabetically
  tty: serial: samsung: explicitly include <linux/types.h>
  tty: serial: samsung: use u32 for register interactions
  tty: serial: samsung: remove braces on single statement block
  tty: serial: samsung: move open brace '{' on the next line
  tty: serial: samsung: drop superfluous comment
  tty: serial: samsung: make max_count unsigned int
  tty: serial: samsung: don't compare with zero an if (bitwise
    expression)
  tty: serial: samsung: use TIOCSER_TEMT for tx_empty()
  tty: serial: samsung: return bool for s3c24xx_serial_txempty_nofifo()
  tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
  tty: serial: samsung: change return type for
    s3c24xx_serial_rx_fifocnt()
  tty: serial: samsung: shrink the clock selection to 8 clocks
  tty: serial: samsung: shrink port feature flags to u8
  tty: serial: samsung: shrink memory footprint of ``struct
    s3c24xx_uart_info``

 drivers/tty/serial/samsung_tty.c | 239 ++++++++++++++++++-------------
 1 file changed, 136 insertions(+), 103 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


