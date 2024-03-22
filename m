Return-Path: <linux-kernel+bounces-111511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E506886D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D615FB260A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283661687;
	Fri, 22 Mar 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KIJgdC3w"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCEF60EDC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114027; cv=none; b=Y+V/Rxz2XErlJzUuXwlOVcA+WeG7oDzor0R8ZsL+Y3hrCwptZRbWdrc+JIEwHoBRvn27lTZQNXzur2bIZIYRFSnHY5m4NN5IvgLy+h1Vi72O80jO3769LQGlBwJC8eLpjzt8L92udVLyUc6JX2OM5kjBrJBHlgJs9GCvqHPOCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114027; c=relaxed/simple;
	bh=mdqtIYLI7ySB5WYgm0DkMef6gSKJXMJEWXd0lTDdv8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf57gr2TerhnT52KNbAG3nBC2nN0W8hssWRkwkkP4tGq5uhz+lhrXSG8JdSNk658MO22j+tvnNXvR7/yX6zxYPceE9WnTU9Z0iIdqMGVYHi03n4zoZp36J2e6ry4W3SppouDEXvEo6eqWCMam7FyAqA5iBIofiSTAHGPPeId1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KIJgdC3w; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7UuWxIPnybw+fXmWOR+T6chr++eA07KTFJ+uAPsLliA=; b=KIJgdC
	3wpJyX69tIEPo75mbwkhPyX3KJ7WdYUi+TlfounlBHSbtouIquSRDNpF/PgEgtEz
	06CfZ07a5KllrIFS0bXI/SNzjHoyjeh3qj29hpyGLfni0n3GIIVzIlEwvtENF+Rl
	P7P5iwUenB7BB3I1Z1IHSrVAvsVTZFv8ygz8kvs9aHj/xz+GzrXlVluCROWiJoUJ
	rYxi5mDaLWNhs+ou5r5GAf5WvhyjmCLtRe1gO6g0BqRncN8Lhi/YcNN5cd7rXebt
	HYh2dcmFC1krakK6e/PnX0yvfNhK2vBQI0tuZVMrA870eYMjG84PIt4zQC5IHI9o
	GVTJQK/GSMTL66cA==
Received: (qmail 3871095 invoked from network); 22 Mar 2024 14:26:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:48 +0100
X-UD-Smtp-Session: l3s3148p1@geygxj8U/pRehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/64] i2c: mchp-pci1xxxx: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:26 +0100
Message-ID: <20240322132619.6389-34-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
index 5ef136c3ecb1..48fd69c87af7 100644
--- a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
+++ b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
@@ -414,13 +414,13 @@ static void pci1xxxx_i2c_set_clear_FW_ACK(struct pci1xxxx_i2c *i2c, bool set)
 	writeb(regval, i2c->i2c_base + SMB_CORE_CTRL_REG_OFF);
 }
 
-static void pci1xxxx_i2c_buffer_write(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
+static void pci1xxxx_i2c_buffer_write(struct pci1xxxx_i2c *i2c, u8 clientaddr,
 				      u8 transferlen, unsigned char *buf)
 {
 	void __iomem *p = i2c->i2c_base + SMBUS_MST_BUF;
 
-	if (slaveaddr)
-		writeb(slaveaddr, p++);
+	if (clientaddr)
+		writeb(clientaddr, p++);
 
 	if (buf)
 		memcpy_toio(p, buf, transferlen);
@@ -775,7 +775,7 @@ static void pci1xxxx_i2c_clear_flags(struct pci1xxxx_i2c *i2c)
 	pci1xxxx_ack_high_level_intr(i2c, ALL_HIGH_LAYER_INTR);
 }
 
-static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
+static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 clientaddr,
 			     unsigned char *buf, u16 total_len)
 {
 	void __iomem *p2 = i2c->i2c_base + SMB_CORE_COMPLETION_REG_OFF3;
@@ -799,10 +799,10 @@ static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
 	 * The I2C transfer could be more than 128 bytes. Our Core is
 	 * capable of only sending 128 at a time.
 	 * As far as the I2C read is concerned, initailly send the
-	 * read slave address along with the number of bytes to read in
-	 * ReadCount. After sending the slave address the interrupt
-	 * is generated. On seeing the ACK for the slave address, reverse the
-	 * buffer direction and run the DMA to initiate Read from slave.
+	 * read client address along with the number of bytes to read in
+	 * ReadCount. After sending the client address the interrupt
+	 * is generated. On seeing the ACK for the client address, reverse the
+	 * buffer direction and run the DMA to initiate Read from client.
 	 */
 	for (count = 0; count < total_len; count += transferlen) {
 
@@ -836,8 +836,8 @@ static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
 			pci1xxxx_i2c_set_transfer_dir(i2c, I2C_DIRN_WRITE);
 			pci1xxxx_i2c_send_start_stop(i2c, 1);
 
-			/* Write I2c buffer with just the slave addr. */
-			pci1xxxx_i2c_buffer_write(i2c, slaveaddr, 0, NULL);
+			/* Write I2c buffer with just the client addr. */
+			pci1xxxx_i2c_buffer_write(i2c, clientaddr, 0, NULL);
 
 			/* Set the count. Readcount is the transfer bytes. */
 			pci1xxxx_i2c_set_count(i2c, 1, 1, transferlen);
@@ -872,7 +872,7 @@ static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
 		/* Read the completion reg to know the reason for DMA_TERM. */
 		regval = readb(p2);
 
-		/* Slave did not respond. */
+		/* Client did not respond. */
 		if (regval & COMPLETION_MNAKX) {
 			writeb(COMPLETION_MNAKX, p2);
 			retval = -ETIMEDOUT;
@@ -896,7 +896,7 @@ static int pci1xxxx_i2c_read(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
 	return retval;
 }
 
-static int pci1xxxx_i2c_write(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
+static int pci1xxxx_i2c_write(struct pci1xxxx_i2c *i2c, u8 clientaddr,
 			      unsigned char *buf, u16 total_len)
 {
 	void __iomem *p2 = i2c->i2c_base + SMB_CORE_COMPLETION_REG_OFF3;
@@ -934,14 +934,14 @@ static int pci1xxxx_i2c_write(struct pci1xxxx_i2c *i2c, u8 slaveaddr,
 		if (count == 0) {
 			pci1xxxx_i2c_send_start_stop(i2c, 1);
 
-			/* -1 for the slave address. */
+			/* -1 for the client address. */
 			transferlen = min_t(u16, SMBUS_BUF_MAX_SIZE - 1,
 					    remainingbytes);
-			pci1xxxx_i2c_buffer_write(i2c, slaveaddr,
+			pci1xxxx_i2c_buffer_write(i2c, clientaddr,
 						  transferlen, &buf[count]);
 			/*
 			 * The actual number of bytes written on the I2C bus
-			 * is including the slave address.
+			 * is including the client address.
 			 */
 			actualwritelen = transferlen + 1;
 		} else {
@@ -993,13 +993,13 @@ static int pci1xxxx_i2c_xfer(struct i2c_adapter *adap,
 			     struct i2c_msg *msgs, int num)
 {
 	struct pci1xxxx_i2c *i2c = i2c_get_adapdata(adap);
-	u8 slaveaddr;
+	u8 clientaddr;
 	int retval;
 	u32 i;
 
 	i2c->i2c_xfer_in_progress = true;
 	for (i = 0; i < num; i++) {
-		slaveaddr = i2c_8bit_addr_from_msg(&msgs[i]);
+		clientaddr = i2c_8bit_addr_from_msg(&msgs[i]);
 
 		/*
 		 * Send the STOP bit if the transfer is the final one or
@@ -1016,10 +1016,10 @@ static int pci1xxxx_i2c_xfer(struct i2c_adapter *adap,
 			i2c->flags &= ~I2C_FLAGS_SMB_BLK_READ;
 
 		if (msgs[i].flags & I2C_M_RD)
-			retval = pci1xxxx_i2c_read(i2c, slaveaddr,
+			retval = pci1xxxx_i2c_read(i2c, clientaddr,
 						   msgs[i].buf, msgs[i].len);
 		else
-			retval = pci1xxxx_i2c_write(i2c, slaveaddr,
+			retval = pci1xxxx_i2c_write(i2c, clientaddr,
 						    msgs[i].buf, msgs[i].len);
 
 		if (retval < 0)
@@ -1048,7 +1048,7 @@ static u32 pci1xxxx_i2c_get_funcs(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm pci1xxxx_i2c_algo = {
-	.master_xfer = pci1xxxx_i2c_xfer,
+	.xfer = pci1xxxx_i2c_xfer,
 	.functionality = pci1xxxx_i2c_get_funcs,
 };
 
-- 
2.43.0


