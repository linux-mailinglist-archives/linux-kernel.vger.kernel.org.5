Return-Path: <linux-kernel+bounces-31030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1BD8327CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDED91C21027
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849B4C625;
	Fri, 19 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr5BHQUv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BE3C46A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661133; cv=none; b=h1GeXX+yp6Po8zZtWgMx4Wvhqy+TO2FID/Faarou3oYBpELZZFvpZ/OKIdcH2gF1+r2jenbsqo1cLdc1KV3Cu21+AfWMtwTMFm144k+E5D+XzrHSDS1VDabZWc7niA7jtc8x2DUknZ4pviRnRVlTy3pMJWm8MmMnNi/1PbZtkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661133; c=relaxed/simple;
	bh=Y7aeOp/gxG3jICTGUpmQmRYwTDiJcl8e8TBB5K8DFGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtzCJcbvGYaNyoTyKb4WSiacPQwdzuIgFG4kkI4wtZgg83vRtx9c5ogoAmowe9n3ZEJV3Ed5fE9zPJ2657EyMObpF7vAan8qWVHlkP9lDVYJGNmF1WIo0HgkC8nuXWhzjNVeg/GVzn174R5PZV0EkumCP43zxp1QPxKgUHFNL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yr5BHQUv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76626170so6696855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661129; x=1706265929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRxs0NWwWxBVnyJFL82XUAw/ceJBDe/nczpSFhzocgU=;
        b=Yr5BHQUver3h5+LRM44PSOFNRoVHuODqYLgmovtrz+7CchQHReSa4KHWkcIprDFM6B
         iaPppVy6ADa1o7n238j/R2h7Xe2SpZTjYjv0Dm50dhZeJSNwXNB6mv+/xgKO+nAPf+ln
         6r83Dp78DBjD1FHnTscjoIodjAfPlHDALzDoJ7Ry0BVsfEfb8G5TdZVh8ZNEcuydn1X/
         uJ2wRo8w/oa06ycgk6RzBBfAvet9zCkXrraX4Cb9qjwPT/t7QLoV3Ek134z4M2BpvkJw
         3A80ffQIBchFVrsGe8xIjUiGC9maBL0MWoCznr4y5Kz+w/JA6D7AvGAP5JlDYinVZc8c
         78KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661129; x=1706265929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRxs0NWwWxBVnyJFL82XUAw/ceJBDe/nczpSFhzocgU=;
        b=HnTwDcW12UJbhDrzZTI5Fq+bBj3ZNGxYkPTtO9mssk0xFgOkbN6Sne6FaPjQzePojS
         lqc7gDvZMZ9sYxX06uD21kEeg/bWzkMiWazUK4+W+vSHxgr0WRnM+Eu9F+SO6kjyUH/r
         ywCxFljp3UF3WOKCAALP05IDNBU+zxfry64SE88UnYQPQuwfeDhOatCoXkb2U8GA/0Ze
         D/mEUq+qVcwxqwTjD324ADTV1d7FqzxoWsTwwY+MiZzn8aUudCRlCAyGkwlc638aLlAM
         nfQn0aUS6/DhEnvlkybhNWVaHqqCKwRg0lCzDbHWtg2xyG6rk8Fxubg6Sm8YnyZxsRnr
         VRVQ==
X-Gm-Message-State: AOJu0Yyk3lFHsekGWyGesz1BHcuLCHgIGSTzz7+H2MkfrW9AuZesL9yl
	0ejwXFrNchiGGtrApDJtkki5DZLTRWfxxBt860/qCqECC60b6TLkoEplSNJ8aiY=
X-Google-Smtp-Source: AGHT+IFjSCHISAyQZXPRew6O4KYFv6iza6RGr4KnVm5escIqDFiLDADJBjJJc7J7sedhZIcv7t1OAg==
X-Received: by 2002:a7b:c8ce:0:b0:40e:956b:7447 with SMTP id f14-20020a7bc8ce000000b0040e956b7447mr1014191wml.131.1705661129567;
        Fri, 19 Jan 2024 02:45:29 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:29 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 00/19] serial: samsung: gs101 updates and winter cleanup
Date: Fri, 19 Jan 2024 10:45:07 +0000
Message-ID: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- put as first patch in the series the patch that fixes tx_empty()
  to return TIOCSER_TEMT. Did that so that it can be easily backported
  to the stable kernels without other dependencies. Add fixes tag for
  the same patch.
- follow with a dt-bindings patch that was missed in the initial submission.
  Krzysztof asked to be queued through the tty tree.
- split a 81 length line in 2 lines in patch
  ``tty: serial: samsung: don't compare with zero an if (bitwise expression)``
  Update the commit message.
- drop extra ``!!`` on methods already returning bool
- update commit message and be more verbose in the patch that shrinks
  the clock selection to 8 clocks.
- use bool for has_divslot instead of bitfield. We don't expect more
  flags soon that would bypass the first cacheline of
  ``struct s3c24xx_uart_info``. Bitfields operations incur performance
  penalty when set or read as compared to direct types, bool shall be
  fine for now.


Hi,

The patch set is intended for v6.9 and is expected to be queued through
Greg's tty tree.

The patch set includes updates for GS101 so that we infer the IO type
from the compatible. This is because the GS101 Peripheral Blocks, which
include the serial, only allow 32-bit register accesses. So instead of
specifying the reg-io-width = 4 property everywhere, deduce the iotype
from the compatible. The GS101 patches were previously proposed at:
Link: https://lore.kernel.org/linux-arm-kernel/20240109125814.3691033-1-tudor.ambarus@linaro.org/

The patch set includes some cleanup changes that started as a
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
	bool                       has_divslot;          /*    59     1 */

	/* size: 64, cachelines: 1, members: 17 */
	/* padding: 4 */
};

Also note that sorting the include files in alphabetic order in the
driver revealed some problems that were fixed with the following
patches:
Link: https://lore.kernel.org/linux-arm-kernel/20240110074007.4020016-1-tudor.ambarus@linaro.org/
Link: https://lore.kernel.org/linux-kernel/20240109141045.3704627-1-tudor.ambarus@linaro.org/

Cheers,
ta

Tudor Ambarus (19):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
  dt-bindings: serial: samsung: do not allow reg-io-width for gs101
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
  tty: serial: samsung: return bool for s3c24xx_serial_txempty_nofifo()
  tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
  tty: serial: samsung: change return type for
    s3c24xx_serial_rx_fifocnt()
  tty: serial: samsung: shrink the clock selection to 8 clocks
  tty: serial: samsung: change has_divslot type to bool
  tty: serial: samsung: shrink memory footprint of ``struct
    s3c24xx_uart_info``

 .../bindings/serial/samsung_uart.yaml         |   2 +
 drivers/tty/serial/samsung_tty.c              | 245 ++++++++++--------
 2 files changed, 141 insertions(+), 106 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


