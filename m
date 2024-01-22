Return-Path: <linux-kernel+bounces-33155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B9083656B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249ACB269E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70C3D3A3;
	Mon, 22 Jan 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6z03htM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249B3C488
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933648; cv=none; b=adDBf3ZM9nM+OR0kAhv+Sc8SR2K+QExZQrMJWAKdCs6K1d4ymAsomsZsUZh3Z8RSeS3XEmesQKi1CCdqypFQ6LoTWIehe9x2B8VqVv2jGhPtG8GdQe8QMz81stEuShHqcfuTccN3DxAwcE9auIcFh0uSUyjhjqmt5VCdJd7D6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933648; c=relaxed/simple;
	bh=JgGry89LGbjrWfZv6NYZoTSuvUCDfdD76rvu/I/jSPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E8DHd8gWmB4N+L2zCt63rwejheCVUipCm87jONiWOYsCF6eL9W7zu7zSQIKJngCLzmvsftEVLzIawNdXXfKhZ73k0cVcw9phx4gRF4bBTVkOAOBGbAfLCUulnUtWxM4mTvgOyd54ji1LW+nmqMPL9tHitPRnGVEAtrvp/FSVGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6z03htM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2cea0563cbso483003366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705933645; x=1706538445; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnMxD6w0kcsPjPfbJXwp4OAaCHPnU63xAnd/2Fgqnm8=;
        b=G6z03htMODZRlwOUEvoa8GZ1mI50fdBdMH6VvTZnJWadaWd+8Am5tA5qK/r++4Ceba
         kP7GtQCLtuRjaVSxwNEumZt1lwyW46DzcyBwETlFc4Bi8iNVgi/TlmpNV/oZmol0m1vt
         r45qy+woSg6XzAqIqr0kBAaAk7YdvWAjjUkOKrxov2a7l4s6MQ7PD6+wRL9JKUg9Zl0n
         0vA/5ti1yeyeG/FXGjEgP9oABRuqy32jb6FLdmwcgLsgStiJ/NZ07V/ziJVV4wnrPoZw
         5/WlUj2XWrB4UgV9D2Jd5ZY9Sx6PRnhzIOozqbpM0JSCXUdO6eZdzuqflGrOOaUaru+C
         CGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705933645; x=1706538445;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnMxD6w0kcsPjPfbJXwp4OAaCHPnU63xAnd/2Fgqnm8=;
        b=M1LfdiL6bE16Dup0ZjGucmYeDiPXNSt8iR/MnjHWwb/89AM/71F+NL7sch79hYyCNg
         Xr9K/a3qkMpDL4euBDLi3xpvwWaaisFViKaqlLSeCs8b6rTMIiSlxsnO98GqwcLwrTX9
         o6pF/Opb/fIipi8X08uDZpSTOUdpKx3n9Xnp8SecWk/rkB2hVbPZFlppfZHe8bveMc3G
         GXt9z7cul0xUwkxq0QAqBQAeT7yiG8mYqgBkC7EqCsGJExdwlicl2dCDlNnFgwqxxn1o
         ug8qN8rLol5E7WciTkzQwxCLlhd6Fz+WjBlU1aI26j2PR/bZHh1QzJRASmvS38UvEJCC
         YT0g==
X-Gm-Message-State: AOJu0Yx6/4cOvtTvISN/PTvbtG0ZU+DuCL3YQcDKH86i7xJJ2UsQY7Ys
	lHwAMoSc37XA+bUWMmywgWoP8z7wLtwu0QIH0fngFSnlK+ZZOWnuohFjlHgazTM=
X-Google-Smtp-Source: AGHT+IFmhZhkzwt8wVlbmPxfqRQrvONViFH1Y/jI6UTld79Uh7G8VeQYQzNb4b3yOIHVHNNlSaiQbg==
X-Received: by 2002:a17:906:1996:b0:a29:3c2b:c911 with SMTP id g22-20020a170906199600b00a293c2bc911mr2115411ejd.63.1705933645247;
        Mon, 22 Jan 2024 06:27:25 -0800 (PST)
Received: from [10.167.154.1] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a2d1b0c7b80sm11341325ejc.57.2024.01.22.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:27:24 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 22 Jan 2024 15:27:20 +0100
Subject: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEd7rmUC/x2N0QqDMAwAf0XyvEIsZYz9yhgS26iBUru2yob47
 ws+3sFxB1QuwhWe3QGFd6myJoX+1oFfKM1sJCiDReuwt9a0NYs3nzANPjKlLQ+t/YxzD2Jn74g
 YQNuRKpuxUPKL1mmLUWUuPMn3mr3e5/kHGPAjPHwAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705933644; l=4836;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JgGry89LGbjrWfZv6NYZoTSuvUCDfdD76rvu/I/jSPQ=;
 b=Pp6+OGdQ/yqUdPaaTjapztIu+C7lt9ei3fQIL9DkuDgx6kk/49/yVCCz2HDSe66Tby7L76/JU
 D3sMQSBzxjbDLROGH5S9jILtG7JSO2HE3/i0IKhC1ECakbQ+ClVSlvz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This SoC family was destined for server use, featuring Qualcomm's very
interesting Kryo cores (before "Kryo" became a marketing term for Arm
cores with small modifications). It did however not leave the labs of
Qualcomm and presumably some partners, nor was it ever productized.

Remove the workarounds, as they are long obsolete.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Compile-tested only
---
 drivers/tty/serial/amba-pl011.c | 82 -----------------------------------------
 1 file changed, 82 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fccec1698a54..c4df9cbc264b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -152,23 +152,6 @@ static const struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
-#ifdef CONFIG_ACPI_SPCR_TABLE
-static const struct vendor_data vendor_qdt_qdf2400_e44 = {
-	.reg_offset		= pl011_std_offsets,
-	.fr_busy		= UART011_FR_TXFE,
-	.fr_dsr			= UART01x_FR_DSR,
-	.fr_cts			= UART01x_FR_CTS,
-	.fr_ri			= UART011_FR_RI,
-	.inv_fr			= UART011_FR_TXFE,
-	.access_32b		= true,
-	.oversampling		= false,
-	.dma_threshold		= false,
-	.cts_event_workaround	= false,
-	.always_enabled		= true,
-	.fixed_options		= true,
-};
-#endif
-
 static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
@@ -2468,15 +2451,6 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;
 
-	/*
-	 * Systems affected by the Qualcomm Technologies QDF2400 E44 erratum
-	 * have a distinct console name, so make sure we check for that.
-	 * The actual implementation of the erratum occurs in the probe
-	 * function.
-	 */
-	if ((strcmp(name, "qdf2400_e44") != 0) && (strcmp(name, "pl011") != 0))
-		return -ENODEV;
-
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
 
@@ -2517,22 +2491,6 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
-static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
-{
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
-		cpu_relax();
-	writel(c, port->membase + UART01x_DR);
-	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
-		cpu_relax();
-}
-
-static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
-{
-	struct earlycon_device *dev = con->data;
-
-	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
-}
-
 static void pl011_putc(struct uart_port *port, unsigned char c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2611,29 +2569,6 @@ OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
 
-/*
- * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
- * Erratum 44, traditional earlycon can be enabled by specifying
- * "earlycon=qdf2400_e44,<address>".  Any options are ignored.
- *
- * Alternatively, you can just specify "earlycon", and the early console
- * will be enabled with the information from the SPCR table.  In this
- * case, the SPCR code will detect the need for the E44 work-around,
- * and set the console name to "qdf2400_e44".
- */
-static int __init
-qdf2400_e44_early_console_setup(struct earlycon_device *device,
-				const char *opt)
-{
-	if (!device->port.membase)
-		return -ENODEV;
-
-	device->con->write = qdf2400_e44_early_write;
-	return 0;
-}
-
-EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
-
 #else
 #define AMBA_CONSOLE	NULL
 #endif
@@ -2869,22 +2804,6 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
-#ifdef CONFIG_ACPI_SPCR_TABLE
-static void qpdf2400_erratum44_workaround(struct device *dev,
-					  struct uart_amba_port *uap)
-{
-	if (!qdf2400_e44_present)
-		return;
-
-	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
-	uap->vendor = &vendor_qdt_qdf2400_e44;
-}
-#else
-static void qpdf2400_erratum44_workaround(struct device *dev,
-					  struct uart_amba_port *uap)
-{ /* empty */ }
-#endif
-
 static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
@@ -2921,7 +2840,6 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->port.irq	= ret;
 
 	uap->vendor = &vendor_sbsa;
-	qpdf2400_erratum44_workaround(&pdev->dev, uap);
 
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;

---
base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
change-id: 20240122-topic-qdf_cleanup_tty-448ae426000d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


