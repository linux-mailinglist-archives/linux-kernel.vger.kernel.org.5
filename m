Return-Path: <linux-kernel+bounces-131777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D34898BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237BD1C25B79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECC1D531;
	Thu,  4 Apr 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IISVG3k9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCF224DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246260; cv=none; b=VhSkfp85EJzFAhkmvlJoNnh7NC/6qfjflNz3molTbJ1kNtOdvnGXfZmw6Jm8yzqRjvTPeGTA3g7Lpclj4Q+IHjBPBj25y3sME7OqGNzrRWWucMjDlvT8wQikn3XBbvAhpdO+wJ+3/J1tF1wcBgoKfNOWSRvGek0CU1euVgVlSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246260; c=relaxed/simple;
	bh=W+wU60ZPW3W9JIhL3CypslsBTwp7+UZfTV/ovpgWWJo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BkmdcyLk3jamhK8lKxofRmcxaAuX1JT/ap35r8M1/zdJGjt8dzO8jSKeCx4VMn1eOCeHdVzwAdsHnaySc8vydzOo0SZuc/+HK0nuhrYafpdatI6dxg2IYrLJQ1Vf9aaupIDj0sQPkAiCVhA8QZ05j9tvrFhDmQYuS8O3ntWZsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IISVG3k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E9C43394;
	Thu,  4 Apr 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246260;
	bh=W+wU60ZPW3W9JIhL3CypslsBTwp7+UZfTV/ovpgWWJo=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=IISVG3k9hNvM11VTLpU4Iv7Bhmg2h/l1Dv6ZS1sUSZgZqWoemfM3f4nUJXfY9bmhf
	 qDj51GvPbhDFkMsxmTAR+QOQAs6SwpDoXXfvzLYIOegtmD3ZIeB/ekzfSBJjp40fVR
	 5qzG+Hq2MBlE/a5oFsF+HP6ulXR1yo8wM0CVrdWUNUx+QAdQ6sTlszCsMafKeltBCz
	 3SC+Ez/p5G85QkIDBWDJjubSLjIYwoyiEIOivZcmN0RDpkJOFcvu0qZ7eFcgTkZLos
	 ZAXhAK3A9x55CSeYzVN3bUBarGRWXGryy9K47UsjEG18tYbQauaw5uP4dC/Lv5eufo
	 /RF26skIkv7OQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D83E51200032;
	Thu,  4 Apr 2024 11:57:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 11:57:38 -0400
X-ME-Sender: <xms:8s0OZrCAj9o_nwJkTnzZWVfJdvL4cR-bYhw01DLfCPjo7Xip2aIIbg>
    <xme:8s0OZhgH7oZIhrZsP1KiuaEvQZ1rpjFrdAD1Se0QFfKxUMr6ohONIdVAWKB4KHOBp
    xuchoh5uyZawAEy2bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:8s0OZmntOJ89YxUj9wURfXe4PW9gXlFtYpsvKIzNwHNZUjdd9loLug>
    <xmx:8s0OZtzXOCAb_4C-RNCo6E-R_yTrinDjIBVpO80fF3_l3vvGQkfFFw>
    <xmx:8s0OZgRVN83O5r-1s_6ceKu5MowPuYRJ9Il_iCxJWU-cXRa0FN9aRA>
    <xmx:8s0OZgZnh2_cSXzn2HCT8G1ZpckZVsrPTLoaJRuUDs58Yk24uZYZXg>
    <xmx:8s0OZmdn9_zT6BRbfl-NSVbzvpxnbCUgn1Y67fY1roaUIFiIjo65-RiD>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8EE03B6008D; Thu,  4 Apr 2024 11:57:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9d9fa267-067e-421b-9a39-aa178b913298@app.fastmail.com>
In-Reply-To: <4cdb6399d803d37a883d1a2fbe119c0a14610106.camel@linux.ibm.com>
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
 <20240404105840.3396821-2-schnelle@linux.ibm.com>
 <95a63afe-ccd7-4551-86af-00b7fb0d8ff9@app.fastmail.com>
 <4cdb6399d803d37a883d1a2fbe119c0a14610106.camel@linux.ibm.com>
Date: Thu, 04 Apr 2024 17:56:47 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
Content-Type: text/plain

On Thu, Apr 4, 2024, at 17:41, Niklas Schnelle wrote:
>
> Good find! I do see the same #ifdef in v5 but maybe something else
> changed. I think this was also hidden during both my local test builds
> and kernel test robot because of the PNP -> ACPI || ISA dependency
> which I think implies HAS_IOPORT. So unless I'm missing something we
> can't currently get here with HAS_IOPORT=n. Maybe that changed?

Rihgt, I just found that as well, so the TCG_INFINEON driver
won't ever be enabled without CONFIG_HAS_IOPORT after all.

> I'm now thinking maybe keeping TPM_INF_IO_PORT is the cleaner choice.
> It saves us 4 lines of #ifdeffery at the cost of one sometimes "unused"
> define.

Agreed. I tried it out for reference, but it does get quite ugly,
see below. Alternatively, we could just add a 'depends on HAS_IOPORT'
to this driver after all. Even if it can be used on MMIO, it might
never actually be built without PIO.

     Arnd

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 418c9ed59ffd..852bb9344788 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -157,7 +157,7 @@ config TCG_ATMEL
 
 config TCG_INFINEON
 	tristate "Infineon Technologies TPM Interface"
-	depends on PNP
+	depends on PNP || COMPILE_TEST
 	help
 	  If you have a TPM security chip from Infineon Technologies
 	  (either SLD 9630 TT 1.1 or SLB 9635 TT 1.2) say Yes and it
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 99c6e565ec8d..768ca65960d8 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -51,10 +51,19 @@ struct tpm_inf_dev {
 
 static struct tpm_inf_dev tpm_dev;
 
+static inline bool tpm_is_ioport(struct tpm_inf_dev *dev)
+{
+#ifdef CONFIG_HAS_IOPORT
+	return tpm_dev.iotype == TPM_INF_IO_PORT;
+#else
+	return false;
+#endif
+}
+
 static inline void tpm_data_out(unsigned char data, unsigned char offset)
 {
 #ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
+	if (tpm_is_ioport(&tpm_dev))
 		outb(data, tpm_dev.data_regs + offset);
 	else
 #endif
@@ -64,7 +73,7 @@ static inline void tpm_data_out(unsigned char data, unsigned char offset)
 static inline unsigned char tpm_data_in(unsigned char offset)
 {
 #ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
+	if (tpm_is_ioport(&tpm_dev))
 		return inb(tpm_dev.data_regs + offset);
 #endif
 	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
@@ -73,7 +82,7 @@ static inline unsigned char tpm_data_in(unsigned char offset)
 static inline void tpm_config_out(unsigned char data, unsigned char offset)
 {
 #ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
+	if (tpm_is_ioport(&tpm_dev))
 		outb(data, tpm_dev.config_port + offset);
 	else
 #endif
@@ -83,7 +92,7 @@ static inline void tpm_config_out(unsigned char data, unsigned char offset)
 static inline unsigned char tpm_config_in(unsigned char offset)
 {
 #ifdef CONFIG_HAS_IOPORT
-	if (tpm_dev.iotype == TPM_INF_IO_PORT)
+	if (tpm_is_ioport(&tpm_dev))
 		return inb(tpm_dev.config_port + offset);
 #endif
 	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
@@ -404,6 +413,7 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 	const char *chipname;
 	struct tpm_chip *chip;
 
+#ifdef CONFIG_HAS_IOPORT
 	/* read IO-ports through PnP */
 	if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
 	    !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
@@ -436,8 +446,10 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 			rc = -EINVAL;
 			goto err_last;
 		}
-	} else if (pnp_mem_valid(dev, 0) &&
-		   !(pnp_mem_flags(dev, 0) & IORESOURCE_DISABLED)) {
+	} else
+#endif
+	if (pnp_mem_valid(dev, 0) &&
+	   !(pnp_mem_flags(dev, 0) & IORESOURCE_DISABLED)) {
 
 		tpm_dev.iotype = TPM_INF_IO_MEM;
 
@@ -540,10 +552,10 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 			 "vendor id 0x%x%x (Infineon), "
 			 "product id 0x%02x%02x"
 			 "%s\n",
-			 tpm_dev.iotype == TPM_INF_IO_PORT ?
+			 tpm_is_ioport(&tpm_dev) ?
 			 tpm_dev.config_port :
 			 tpm_dev.map_base + tpm_dev.index_off,
-			 tpm_dev.iotype == TPM_INF_IO_PORT ?
+			 tpm_is_ioport(&tpm_dev) ?
 			 tpm_dev.data_regs :
 			 tpm_dev.map_base + tpm_dev.data_regs,
 			 version[0], version[1],
@@ -567,7 +579,7 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
 	}
 
 err_release_region:
-	if (tpm_dev.iotype == TPM_INF_IO_PORT) {
+	if (tpm_is_ioport(&tpm_dev)) {
 		release_region(tpm_dev.data_regs, tpm_dev.data_size);
 		release_region(tpm_dev.config_port, tpm_dev.config_size);
 	} else {
@@ -585,11 +597,14 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
 
 	tpm_chip_unregister(chip);
 
-	if (tpm_dev.iotype == TPM_INF_IO_PORT) {
+#ifdef CONFIG_HAS_IOPORT
+	if (tpm_is_ioport(&tpm_dev)) {
 		release_region(tpm_dev.data_regs, tpm_dev.data_size);
 		release_region(tpm_dev.config_port,
 			       tpm_dev.config_size);
-	} else {
+	} else
+#endif
+	{
 		iounmap(tpm_dev.mem_base);
 		release_mem_region(tpm_dev.map_base, tpm_dev.map_size);
 	}

