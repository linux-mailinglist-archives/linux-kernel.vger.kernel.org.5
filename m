Return-Path: <linux-kernel+bounces-105019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8E87D7B4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD571F222C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0A1847;
	Sat, 16 Mar 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="vV3y3KZp"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0810FD;
	Sat, 16 Mar 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550751; cv=none; b=KeLdDkyypBmt/kdK9KrPTjw7cDXYmcC/2ZvMR5fgCP9Dxg/ygLN+eOlExOt1rIDdioqWaNGeq6Z1Nf14iHW4jC956a7iLUN8ukdM1Uhvlz26CjmPJyQzOHUtzGyp2zZBeLHZyP2JXT2+sKUm85zkdxyE9vSuE1YXtSOp/1fmWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550751; c=relaxed/simple;
	bh=jvr0PIbn0nyqRCyO7pJ0Hs9rBTEJbPJzgG+VYgmmLjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCva0jSsZMzGVRM4K/nSPwsoWnK08G3w7epBOg7kJPJGuJs4eoalkcGumRqaXixFRuecJqLyBpSkaMIHLyfzD3Wv2atyZ+rnsXlDSZV4+7pmDjWK0SXndxninMagYZ3cv/BUByDHA9YL7R5E8hYlbfP9X9chy6bc2yT/714uwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=vV3y3KZp; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
	:content-type; bh=4NSf3780jcQvryheQKbVaP1K5KnZB7/pr0Qc8v0iBK8=; b=vV3y3KZpIDp
	1gURf+ybmNXDffUPEcuVccXEqy71Sktq5UX65gx/yetHPqq44Bur72h2ab26tfcdfaj/hKeNxGMhG
	KzfjFRoS9QjA3ICjcGF7ocmNSP1FhKe0uiu39RL1GxgL+NwYa77fGFCYlghkytKA1yIFFnXvr1LTU
	HkfzCfATtQPpRa7EWSBpVSpX5tPogkXoa9LDk6lh7U4ceYHxfuy8KmMfTR9YGL7TZGw9B+cK37Gcu
	0PgH+pQY/JCqI+vYppNFzekqEloj0505RxH54JGoRTqVo2+atb9Wk8935sIBSN6rRRFS3QuXWodW9
	TvkT9q3s1T13CeUbdM543Ig==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlIO0-00DUq8-CM; Sat, 16 Mar 2024 02:58:59 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlINy-0008DX-5q; Sat, 16 Mar 2024 02:58:54 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] spi: mt7621: allow GPIO chip select lines
Date: Sat, 16 Mar 2024 02:59:15 +0200
Message-Id: <20240316005917.20526-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00503044966356)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8sM9tNQBDeE3N2l1CjpmaIPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQpvJyU9EF7gOc/LMwk9dvTa+WmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsotxMDYRAzuCR0I/uZN17IfdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3KxDuzsITj9XSEsqBTpMNClkAdhK23InA2zzja5I1riDVsRE
 /qfh3BpRIL035Lwa3AR5iWi4B3c2TvD1mYFCey4YQsgkfE0ewNgNUY5lZOQ5d86hkdfWpdNtlHKD
 /N5YI0ii+HGJbtyrZfX5fEH4LjZJ4azDVvtI4xLpBrhpV1Z2g0cC96lvLg9F6alXVA5GCKQ8jPBS
 b1sSQu/sXnVb6BTD1y1EN4lWLphXo/QFY19KiazSUJJrHpiQXIumX+z7RP3Fs7AeUg8cSzkuHTCW
 7WeivJsOGdLHT5AmY9PDPjGy0z6bhalFEM/pjPCQA+BAlnIZxFSV0ux1niV+gnzf0coKruD/dlzX
 C6+t6EZu9kdJCbEH65DSZ+j3bGAiXooYBVbntXLVlUvPrcBZhPHsfcZm4zuNRcgRKiGg7nXFaZTx
 I/6scxhAq/6af00PEtBNjYtqmoKr5eemJzKNdiP7m3gSrWCqyhAo0JR3rThOyxKFbWMT2xK3KT9R
 mx5HiKCYjt40eTXlWiUAYdLmsJdAoPIA+QBBCmRnfEQkXp5mAyXTIBVUuAX2KYddQlACXnsZ2u9C
 nazM3+ZE40UYhpZLE/UxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Extract a magic number, from mt7621_spi_probe(), used to
declare the number of chip select lines (which co-incides
with the native chip select count of 2) to a macro.

Use the newly defined MT7621_NATIVE_CS_COUNT macro to
instead populate both the spi_controller's max_native_cs
and num_chipselect members.

Declare that the spi_controller should use_gpio_descriptors
if present in the device properties (such as those declared
in the cs-gpio property of a "ralink,mt7621-spi" compatible
device-tree node) so that the SPI core will recalculcate
num_chipselect to account for the GPIO descriptors that
it should have populated in the cs_gpiod array member.

Remove the assignment of mt7621_spi_transfer_one_message()
to the spi_controller's transfer_one_message hook.

Refactor the mt7621_spi_transfer_one_message() logic into
mt7621_spi_prepare_message() and mt7621_spi_transfer_one()
and assign both to the spi_controller's prepare_message
and transfer_one hooks respectively.

Migrate the call mt7621_spi_transfer_one_message() made to
mt7621_spi_flush() just before chip select deactivation,
to the end of mt7621_spi_write_half_duplex() to ensure
that any pending data is shifted out of MOSI before the SPI
core deactivates the chip select line.

As chip select activation is now taken care of by the SPI
core, due to the use of the transfer_one hook instead of
transfer_one_message, the calls to mt7621_spi_set_cs()
from mt7621_spi_transfer_one_message() have fallen away.

And although the SPI core will handle activation for GPIO
chip select lines behind the scenes, it requires a callback
to allow the driver to perform controller-specific
operations to control its native chip select lines.

Rename mt7621_spi_set_cs() to mt7621_spi_set_native_cs()
and make sure that it takes into account the activation
polarity of the chip select line it's acting upon, as the
passed enable parameter represents the desired line level
and not the desired activation state, and then assign
mt7621_set_cs() to the spi_controller's set_cs hook.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---

Changes from v1 to v2:

  Mark Brown recommended using the transfer_one hook
  approach, so I did.


 drivers/spi/spi-mt7621.c | 95 +++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 4e9053d03..3770b8e09 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -52,6 +52,8 @@
 #define MT7621_CPOL		BIT(4)
 #define MT7621_LSB_FIRST	BIT(3)
 
+#define MT7621_NATIVE_CS_COUNT	2
+
 struct mt7621_spi {
 	struct spi_controller	*host;
 	void __iomem		*base;
@@ -75,10 +77,11 @@ static inline void mt7621_spi_write(struct mt7621_spi *rs, u32 reg, u32 val)
 	iowrite32(val, rs->base + reg);
 }
 
-static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
+static void mt7621_spi_set_native_cs(struct spi_device *spi, bool enable)
 {
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 	int cs = spi_get_chipselect(spi, 0);
+	bool active = spi->mode & SPI_CS_HIGH ? enable : !enable;
 	u32 polar = 0;
 	u32 host;
 
@@ -94,7 +97,7 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 
 	rs->pending_write = 0;
 
-	if (enable)
+	if (active)
 		polar = BIT(cs);
 	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
 }
@@ -154,6 +157,23 @@ static inline int mt7621_spi_wait_till_ready(struct mt7621_spi *rs)
 	return -ETIMEDOUT;
 }
 
+static int mt7621_spi_prepare_message(struct spi_controller *host,
+				      struct spi_message *m)
+{
+	struct mt7621_spi *rs = spi_controller_get_devdata(host);
+	struct spi_device *spi = m->spi;
+	unsigned int speed = spi->max_speed_hz;
+	struct spi_transfer *t = NULL;
+
+	mt7621_spi_wait_till_ready(rs);
+
+	list_for_each_entry(t, &m->transfers, transfer_list)
+		if (t->speed_hz < speed)
+			speed = t->speed_hz;
+
+	return mt7621_spi_prepare(spi, speed);
+}
+
 static void mt7621_spi_read_half_duplex(struct mt7621_spi *rs,
 					int rx_len, u8 *buf)
 {
@@ -243,59 +263,30 @@ static void mt7621_spi_write_half_duplex(struct mt7621_spi *rs,
 	}
 
 	rs->pending_write = len;
+	mt7621_spi_flush(rs);
 }
 
-static int mt7621_spi_transfer_one_message(struct spi_controller *host,
-					   struct spi_message *m)
+static int mt7621_spi_transfer_one(struct spi_controller *host,
+				   struct spi_device *spi,
+				   struct spi_transfer *t)
 {
 	struct mt7621_spi *rs = spi_controller_get_devdata(host);
-	struct spi_device *spi = m->spi;
-	unsigned int speed = spi->max_speed_hz;
-	struct spi_transfer *t = NULL;
-	int status = 0;
-
-	mt7621_spi_wait_till_ready(rs);
 
-	list_for_each_entry(t, &m->transfers, transfer_list)
-		if (t->speed_hz < speed)
-			speed = t->speed_hz;
-
-	if (mt7621_spi_prepare(spi, speed)) {
-		status = -EIO;
-		goto msg_done;
-	}
-
-	/* Assert CS */
-	mt7621_spi_set_cs(spi, 1);
-
-	m->actual_length = 0;
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((t->rx_buf) && (t->tx_buf)) {
-			/*
-			 * This controller will shift some extra data out
-			 * of spi_opcode if (mosi_bit_cnt > 0) &&
-			 * (cmd_bit_cnt == 0). So the claimed full-duplex
-			 * support is broken since we have no way to read
-			 * the MISO value during that bit.
-			 */
-			status = -EIO;
-			goto msg_done;
-		} else if (t->rx_buf) {
-			mt7621_spi_read_half_duplex(rs, t->len, t->rx_buf);
-		} else if (t->tx_buf) {
-			mt7621_spi_write_half_duplex(rs, t->len, t->tx_buf);
-		}
-		m->actual_length += t->len;
+	if ((t->rx_buf) && (t->tx_buf)) {
+		/*
+		 * This controller will shift some extra data out
+		 * of spi_opcode if (mosi_bit_cnt > 0) &&
+		 * (cmd_bit_cnt == 0). So the claimed full-duplex
+		 * support is broken since we have no way to read
+		 * the MISO value during that bit.
+		 */
+		return -EIO;
+	} else if (t->rx_buf) {
+		mt7621_spi_read_half_duplex(rs, t->len, t->rx_buf);
+	} else if (t->tx_buf) {
+		mt7621_spi_write_half_duplex(rs, t->len, t->tx_buf);
 	}
 
-	/* Flush data and deassert CS */
-	mt7621_spi_flush(rs);
-	mt7621_spi_set_cs(spi, 0);
-
-msg_done:
-	m->status = status;
-	spi_finalize_current_message(host);
-
 	return 0;
 }
 
@@ -353,10 +344,14 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	host->mode_bits = SPI_LSB_FIRST;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->setup = mt7621_spi_setup;
-	host->transfer_one_message = mt7621_spi_transfer_one_message;
+	host->prepare_message = mt7621_spi_prepare_message;
+	host->set_cs = mt7621_spi_set_native_cs;
+	host->transfer_one = mt7621_spi_transfer_one;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->dev.of_node = pdev->dev.of_node;
-	host->num_chipselect = 2;
+	host->max_native_cs = MT7621_NATIVE_CS_COUNT;
+	host->num_chipselect = MT7621_NATIVE_CS_COUNT;
+	host->use_gpio_descriptors = true;
 
 	dev_set_drvdata(&pdev->dev, host);
 
-- 


