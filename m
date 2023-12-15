Return-Path: <linux-kernel+bounces-846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F908146FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ED01C22C70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C36250E2;
	Fri, 15 Dec 2023 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+ZXhjL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GF1NLFQu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5024B3F;
	Fri, 15 Dec 2023 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702640029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ2Ngc3wsnlRfSK7mFFAglX+P/sSFPL3+hcutCCWdBQ=;
	b=s+ZXhjL7IjzLhJF5PcwaWMkcmlSp+Cw9UFtRU6lmBhMqlz20K7F45eq3EokACPanNk4q3t
	cTsX1ojxWuay1IRId0nTLHIfOir0Nao5Kbpz8wzEpLO+C+CCTD0ApiWZtOopTF7rrgMWI4
	NKQ7t+C0d3a3jYV5ZGRdUveyjawIjxIny0TmOBybEtgC00AIWVKd/MTfLcRZdeVlfRZ9Ow
	nUtknrOIO/i9CqM6mElVHesPYmqvMM13NPiIiv5DxShykiNV8flzPmlM6/xrJ/r6kpMQJF
	aBg0orjM3/sx2E7X4lKS6lmBgI2BIoL/4JjoijHmCBiTl3UMYDYVFa8EuwxU7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702640029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ2Ngc3wsnlRfSK7mFFAglX+P/sSFPL3+hcutCCWdBQ=;
	b=GF1NLFQu+PzKGjDbh9VeN/PyBcFtvjK9rKQD2bCorxVC4qrMpe2gA56Bpi+VMfu00nQ8vv
	SYD92dkC6QsiPQAw==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] spi: pl022: delete description of cur_msg
Date: Fri, 15 Dec 2023 12:33:37 +0100
Message-Id: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
In-Reply-To: <202312151816.munFeE4L-lkp@intel.com/>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The variable cur_msg was removed, but its description is left behind.
Delete this description.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@int=
el.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3baf45da01cd..bdec67cf45f2 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -338,7 +338,6 @@ struct vendor_data {
  * @clk: outgoing clock "SPICLK" for the SPI bus
  * @host: SPI framework hookup
  * @host_info: controller-specific data from machine setup
- * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
  * @cur_chip: pointer to current clients chip(assigned from controller_sta=
te)
  * @tx: current position in TX buffer to be read
--=20
2.39.2


