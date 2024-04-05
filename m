Return-Path: <linux-kernel+bounces-133573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E889A5E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1701C2115B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A5174EF4;
	Fri,  5 Apr 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/8Ljbk/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE7171669;
	Fri,  5 Apr 2024 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350991; cv=none; b=kCkAczSGgoL8DhdMKq7aOxxs+DqNtEFdX5p8iPGXbAMf17hHzkNIn4YaNdKgDGrIdU5X1CLs1sMEDtnd1UzJkEapln6wxT4Ui/8ZKJfQ5g2yGsyFDWoLtMpMHpzBAnbeG7I/MppcQMCVwlRR8mlYKcWEZXg8/8l8QkU0y7jgbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350991; c=relaxed/simple;
	bh=4+g6js5mEU1pa5ulHJ+C7YQxyZdv41bK8ysv9MJSxyU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TO0Pe/yuL1CCwGZNzL15LMq2uoMQHrEFT+QXytAYQyqXo7HO/V300qAzy//Fnz/5udyniLeWJzoq/DHIDvC4n/24tade5o56nZ+FueETzFRKH48vIhehQgbMY9eb/C68DcxawQ0NvqYRvRoQY61/Q8iJITedy9wkJVJfq614S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/8Ljbk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565DEC43394;
	Fri,  5 Apr 2024 21:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712350989;
	bh=4+g6js5mEU1pa5ulHJ+C7YQxyZdv41bK8ysv9MJSxyU=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=L/8Ljbk/5fkA3JZ236dhrHG3f5JgFHRUtN7g1CRRS7g8TMvza7NlCS+/Q9hxjRNml
	 UldX8TzETK1FjtAJUPdr8h2swcYoPx8LIpCvCzi7Z1+whaYsiEtTwSsb50cqN2kPy/
	 ZSmCTEFaUqLgs2nRqCwyN8rjZSjhCEEoZ2CnIus+o9z7EDPiYVHgnpsY/kIUbgeG4L
	 7m92y7oEbazVHqlMFifDcVTM4fqnggZL9lAKyCpkVB0CYDkk9xXGll2mh5VjMXImnC
	 BkVzfEgxJicES7tmqlIQkTwYI/4V8m0kJeskaxHrUNLnwOOW/9/YxG8ro67ziPBbDF
	 i9e7LYen/RLlQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 561901200032;
	Fri,  5 Apr 2024 17:03:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Apr 2024 17:03:08 -0400
X-ME-Sender: <xms:DGcQZnwhPIGAwsK7wdLhwvmUrmxhrWIi8kQ5dztmg78mxG9NpKpDlg>
    <xme:DGcQZvTF9brGNMV6gb35dn_tgfJVqlEcpFGypaob1Zpu06E1OO8tznAkEqqnmlFbB
    H1etiPIy0nIcOhfqow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:DGcQZhXZznZmWtvHwKC4dzzKRFbg4AEzMgC_pLkGJ1uXPIVfBwZysA>
    <xmx:DGcQZhi4Wgf6-sHSxo8bQ2yWhcEczMUAFR18A4yBemB40G-Z511AMg>
    <xmx:DGcQZpC2aWXCs7_PaJVz0WLXN5kxWvPzjkdAK8mK3DJvvx1G-78e-g>
    <xmx:DGcQZqK3rtXTv1hKCVKykEzbzkEiR1aHYGLYImZQCqgO07hWWBb8nA>
    <xmx:DGcQZoOvpR1euKiLtFecPwUBzCTWriVC-Pf3ZTvG0CnSI6FfVAhUIFF7>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 03C77B6008D; Fri,  5 Apr 2024 17:03:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe5e2e29-6d60-4ec1-ab3e-492c463e6a12@app.fastmail.com>
In-Reply-To: <4d08af651b95744dc6cfa0c2624c596d21d83d09.camel@linux.ibm.com>
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
 <20240404105840.3396821-2-schnelle@linux.ibm.com>
 <95a63afe-ccd7-4551-86af-00b7fb0d8ff9@app.fastmail.com>
 <4cdb6399d803d37a883d1a2fbe119c0a14610106.camel@linux.ibm.com>
 <9d9fa267-067e-421b-9a39-aa178b913298@app.fastmail.com>
 <4d08af651b95744dc6cfa0c2624c596d21d83d09.camel@linux.ibm.com>
Date: Fri, 05 Apr 2024 23:02:47 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
Content-Type: text/plain

On Fri, Apr 5, 2024, at 11:23, Niklas Schnelle wrote:
>
> I just confirmed that keeping the define it also compiles but I do
> wonder if it's not even cleaner to just add an explicit HAS_IOPORT
> dependency and no new #ifdefs in the code. I'm willing to send a patch
> for any of these solutions though.

It depends a bit on where the driver is used in the end. We
currently set HAS_IOPORT on arm64 and riscv, but we could make
that dependent on which PCI host drivers are actually being
built, as a lot of modern hardware doesn't actually support
port I/O.

Is this driver still expected to be used on modern PCIe hosts
with no port I/O, or would new machines all use the i2c version?

If we do need the driver in configurations without CONFIG_HAS_IOPORT,
then the patch below wouldn't be awful (on top of the patch that
got merged already).

     Arnd

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 99c6e565ec8d..5b45ad619900 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -37,7 +37,8 @@
 struct tpm_inf_dev {
 	int iotype;
 
-	void __iomem *mem_base;	/* MMIO ioremap'd addr */
+	void __iomem *data_base;	/* MMIO ioremap'd addr */
+	void __iomem *config_base;	/* MMIO ioremap'd config */
 	unsigned long map_base;	/* phys MMIO base */
 	unsigned long map_size;	/* MMIO region size */
 	unsigned int index_off;	/* index register offset */
@@ -53,40 +54,22 @@ static struct tpm_inf_dev tpm_dev;
 
 static inline void tpm_data_out(unsigned char data, unsigned char offset)
 {
-#ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
-		outb(data, tpm_dev.data_regs + offset);
-	else
-#endif
-		writeb(data, tpm_dev.mem_base + tpm_dev.data_regs + offset);
+	iowrite8(data, tpm_dev.data_base + offset);
 }
 
 static inline unsigned char tpm_data_in(unsigned char offset)
 {
-#ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
-		return inb(tpm_dev.data_regs + offset);
-#endif
-	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
+	return ioread8(tpm_dev.data_base + offset);
 }
 
 static inline void tpm_config_out(unsigned char data, unsigned char offset)
 {
-#ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
-		outb(data, tpm_dev.config_port + offset);
-	else
-#endif
-		writeb(data, tpm_dev.mem_base + tpm_dev.index_off + offset);
+	iowrite8(data, tpm_dev.config_base + offset);
 }
 
 static inline unsigned char tpm_config_in(unsigned char offset)
 {
-#ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
-		return inb(tpm_dev.config_port + offset);
-#endif
-	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
+	return ioread8(tpm_dev.config_base + offset);
 }
 
 /* TPM header definitions */
@@ -425,16 +408,27 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 			goto err_last;
 		}
 		/* publish my base address and request region */
+		tpm_dev.data_base = ioport_map(tpm_dev.data_regs, tpm_dev.data_size);
+		if (!tpm_dev.data_base) {
+			rc = -EINVAL;
+			goto err_last;
+		}
 		if (request_region(tpm_dev.data_regs, tpm_dev.data_size,
 				   "tpm_infineon0") == NULL) {
 			rc = -EINVAL;
+			ioport_unmap(tpm_dev.config_base);
 			goto err_last;
 		}
+		tpm_dev.config_base = ioport_map(tpm_dev.config_port, tpm_dev.config_size);
+		if (!tpm_dev.config_base) {
+			rc = -EINVAL;
+			goto err_release_data_region;
+		}
 		if (request_region(tpm_dev.config_port, tpm_dev.config_size,
 				   "tpm_infineon0") == NULL) {
 			release_region(tpm_dev.data_regs, tpm_dev.data_size);
 			rc = -EINVAL;
-			goto err_last;
+			goto err_release_data_region;
 		}
 	} else if (pnp_mem_valid(dev, 0) &&
 		   !(pnp_mem_flags(dev, 0) & IORESOURCE_DISABLED)) {
@@ -454,8 +448,8 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 			goto err_last;
 		}
 
-		tpm_dev.mem_base = ioremap(tpm_dev.map_base, tpm_dev.map_size);
-		if (tpm_dev.mem_base == NULL) {
+		tpm_dev.data_base = ioremap(tpm_dev.map_base, tpm_dev.map_size);
+		if (tpm_dev.data_base == NULL) {
 			release_mem_region(tpm_dev.map_base, tpm_dev.map_size);
 			rc = -EINVAL;
 			goto err_last;
@@ -468,8 +462,7 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 		 * seem like they could be placed anywhere within the MMIO
 		 * region, but lets just put them at zero offset.
 		 */
-		tpm_dev.index_off = TPM_ADDR;
-		tpm_dev.data_regs = 0x0;
+		tpm_dev.config_base = tpm_dev.data_base + TPM_ADDR;
 	} else {
 		rc = -EINVAL;
 		goto err_last;
@@ -568,10 +561,16 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 
 err_release_region:
 	if (tpm_dev.iotype == TPM_INF_IO_PORT) {
-		release_region(tpm_dev.data_regs, tpm_dev.data_size);
+		ioport_unmap(tpm_dev.config_base);
 		release_region(tpm_dev.config_port, tpm_dev.config_size);
+	}
+
+err_release_data_region:
+	if (tpm_dev.iotype == TPM_INF_IO_PORT) {
+		ioport_unmap(tpm_dev.data_base);
+		release_region(tpm_dev.data_regs, tpm_dev.data_size);
 	} else {
-		iounmap(tpm_dev.mem_base);
+		iounmap(tpm_dev.data_base);
 		release_mem_region(tpm_dev.map_base, tpm_dev.map_size);
 	}
 
@@ -586,11 +585,13 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
 	tpm_chip_unregister(chip);
 
 	if (tpm_dev.iotype == TPM_INF_IO_PORT) {
+		ioport_unmap(tpm_dev.data_base);
 		release_region(tpm_dev.data_regs, tpm_dev.data_size);
+		ioport_unmap(tpm_dev.config_base);
 		release_region(tpm_dev.config_port,
 			       tpm_dev.config_size);
 	} else {
-		iounmap(tpm_dev.mem_base);
+		iounmap(tpm_dev.data_base);
 		release_mem_region(tpm_dev.map_base, tpm_dev.map_size);
 	}
 }

