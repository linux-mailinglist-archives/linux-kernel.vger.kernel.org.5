Return-Path: <linux-kernel+bounces-17292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F340E824AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ADDB2107B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123832CCCF;
	Thu,  4 Jan 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I/I8tLGU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906422C864;
	Thu,  4 Jan 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404HROEt031049;
	Thu, 4 Jan 2024 16:37:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=R4WHZkzyUxMFNzJPOt4iCdtJA4wb/qiu07YuOpJh66c=; b=
	I/I8tLGUNRdgBHYkNzneRnxOPeWrXn2vsIAZwMFgx8rmwEQONf0zqfUYnzekfG4Q
	YfEANUL99S645M0JoAIL6F09SGfz/7+xrTLY+C2civmaXF7yQikgFk1nrY3uCYm8
	EkQssVNxDL4GvKZS7w8XfUoQWNtLJ/ZTLLdum2UvxbxTeMBivcNjShEt5a5/2++W
	pHITK0dhXhCunrxz0VFkCRv7Xf5LDNc0OEK5wbHkp3p4nZ07LmxeWV26vNCIyjaw
	8WRobPhSi7D7aLB2YOAgCgr/DoeqAbmWFqkh4IaU+jqmPyu9X1VXlRtGuOEExDYR
	BME02dbSdFtbo7Fuk15zdQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ve137rcxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 16:37:39 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 22:37:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Thu, 4 Jan 2024 22:37:22 +0000
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3FE65468;
	Thu,  4 Jan 2024 22:37:17 +0000 (UTC)
From: James Ogletree <jogletre@opensource.cirrus.com>
To: 
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        James Ogletree
	<james.ogletree@cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright
	<ben.bright@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Jeff
 LaBundy" <jeff@labundy.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai
	<ping.bai@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Weidong Wang <wangweidong.a@awinic.com>, Arnd Bergmann <arnd@arndb.de>,
        "Herve Codina" <herve.codina@bootlin.com>,
        Shenghao Ding
	<13916275206@139.com>,
        "Ryan Lee" <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "Maxim Kochetkov" <fido_max@inbox.ru>,
        Ajye Huang
	<ajye_huang@compal.corp-partner.google.com>,
        Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS" <patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
	<linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: [PATCH v5 1/5] firmware: cs_dsp: Add write sequencer interface
Date: Thu, 4 Jan 2024 22:36:34 +0000
Message-ID: <20240104223643.876292-2-jogletre@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: siF3kDsI2bs7-Kw_R1TFS51ASELUXuPF
X-Proofpoint-ORIG-GUID: siF3kDsI2bs7-Kw_R1TFS51ASELUXuPF
X-Proofpoint-Spam-Reason: safe

A write sequencer is a sequence of register addresses
and values executed by some Cirrus DSPs following
power-up or exit from hibernation, used for avoiding
the overhead of bus transactions.

Add support for Cirrus drivers to update or add to a
write sequencer present in firmware.

Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 261 +++++++++++++++++++++++++
 include/linux/firmware/cirrus/cs_dsp.h |  28 +++
 2 files changed, 289 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 79d4254d1f9b..31a999f42e84 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -275,6 +275,15 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
+/*
+ * Write Sequencer
+ */
+#define WSEQ_OP_FULL_WORDS	3
+#define WSEQ_OP_X16_WORDS	2
+#define WSEQ_OP_END_WORDS	1
+#define WSEQ_OP_UNLOCK_WORDS	1
+#define WSEQ_END_OF_SCRIPT	0xFFFFFF
+
 struct cs_dsp_ops {
 	bool (*validate_version)(struct cs_dsp *dsp, unsigned int version);
 	unsigned int (*parse_sizes)(struct cs_dsp *dsp,
@@ -2233,6 +2242,111 @@ static int cs_dsp_create_name(struct cs_dsp *dsp)
 	return 0;
 }
 
+struct cs_dsp_wseq_op {
+	struct list_head list;
+	u32 words[3];
+	u32 address;
+	u32 data;
+	u16 offset;
+	u8 operation;
+};
+
+static int cs_dsp_populate_wseq(struct cs_dsp *dsp, struct cs_dsp_wseq *wseq)
+{
+	struct cs_dsp_wseq_op *op = NULL;
+	struct cs_dsp_chunk ch;
+	int i, num_words, ret;
+	u32 *words;
+
+	if (wseq->size <= 0 || !wseq->reg)
+		return -EINVAL;
+
+	words = kcalloc(wseq->size, sizeof(u32), GFP_KERNEL);
+	if (!words)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&wseq->ops);
+
+	ret = regmap_raw_read(dsp->regmap, wseq->reg, words,
+			      wseq->size * sizeof(u32));
+	if (ret)
+		goto err_free;
+
+	ch = cs_dsp_chunk(words, wseq->size * sizeof(u32));
+
+	for (i = 0; i < wseq->size; i += num_words) {
+		op = devm_kzalloc(dsp->dev, sizeof(*op), GFP_KERNEL);
+		if (!op) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+
+		op->offset = ch.bytes;
+		op->operation = cs_dsp_chunk_read(&ch, 8);
+
+		switch (op->operation) {
+		case CS_DSP_WSEQ_END:
+			num_words = WSEQ_OP_END_WORDS;
+			break;
+		case CS_DSP_WSEQ_UNLOCK:
+			num_words = WSEQ_OP_UNLOCK_WORDS;
+			op->address = 0;
+			op->data = cs_dsp_chunk_read(&ch, 16);
+			break;
+		case CS_DSP_WSEQ_ADDR8:
+		case CS_DSP_WSEQ_H16:
+		case CS_DSP_WSEQ_L16:
+			num_words = WSEQ_OP_X16_WORDS;
+			op->address = cs_dsp_chunk_read(&ch, 24);
+			op->data = cs_dsp_chunk_read(&ch, 16);
+			break;
+		case CS_DSP_WSEQ_FULL:
+			num_words = WSEQ_OP_FULL_WORDS;
+			op->address = cs_dsp_chunk_read(&ch, 32);
+			op->data = cs_dsp_chunk_read(&ch, 32);
+			break;
+		default:
+			ret = -EINVAL;
+			cs_dsp_err(dsp, "Unsupported op: %u\n", op->operation);
+			goto err_free;
+		}
+
+		list_add(&op->list, &wseq->ops);
+
+		if (op->operation == CS_DSP_WSEQ_END)
+			break;
+	}
+
+	if (op && op->operation != CS_DSP_WSEQ_END)
+		ret = -ENOENT;
+err_free:
+	kfree(words);
+
+	return ret;
+}
+
+/**
+ * cs_dsp_wseq_init() - Initialize write sequences contained within the loaded DSP firmware
+ * @dsp: pointer to DSP structure
+ * @wseqs: list of write sequences to initialize
+ * @num_wseqs: number of write sequences to initialize
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_wseq_init(struct cs_dsp *dsp, struct cs_dsp_wseq *wseqs, unsigned int num_wseqs)
+{
+	int i, ret;
+
+	for (i = 0; i < num_wseqs; i++) {
+		ret = cs_dsp_populate_wseq(dsp, &wseqs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_wseq_init);
+
 static int cs_dsp_common_init(struct cs_dsp *dsp)
 {
 	int ret;
@@ -3339,6 +3453,153 @@ int cs_dsp_chunk_read(struct cs_dsp_chunk *ch, int nbits)
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_chunk_read, FW_CS_DSP);
 
+static struct cs_dsp_wseq_op *cs_dsp_wseq_find_op(u8 op_code, u32 addr,
+						  struct list_head *wseq_ops)
+{
+	struct cs_dsp_wseq_op *op;
+
+	list_for_each_entry(op, wseq_ops, list) {
+		if (op->operation == op_code && op->address == addr)
+			return op;
+	}
+
+	return NULL;
+}
+
+/**
+ * cs_dsp_wseq_write() - Add or update an entry in a write sequence
+ * @dsp: Pointer to a DSP structure
+ * @wseq: Write sequence to write to
+ * @addr: Address of the register to be written to
+ * @data: Data to be written
+ * @update: If true, searches for the first entry in the Write Sequencer with
+ * the same address and op_code, and replaces it. If false, creates a new entry
+ * at the tail.
+ * @op_code: The type of operation of the new entry
+ *
+ * This function formats register address and value pairs into the format
+ * required for write sequence entries, and either updates or adds the
+ * new entry into the write sequence.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_wseq_write(struct cs_dsp *dsp, struct cs_dsp_wseq *wseq,
+		      u32 addr, u32 data, bool update, u8 op_code)
+{
+	struct cs_dsp_wseq_op *op_end, *op_new;
+	struct cs_dsp_chunk ch;
+	u32 wseq_bytes;
+	int new_op_size, ret;
+
+	if (update) {
+		op_new = cs_dsp_wseq_find_op(op_code, addr, &wseq->ops);
+		if (!op_new)
+			return -EINVAL;
+	} else {
+		op_new = devm_kzalloc(dsp->dev, sizeof(*op_new), GFP_KERNEL);
+		if (!op_new)
+			return -ENOMEM;
+
+		op_new->operation = op_code;
+		op_new->address = addr;
+	}
+
+	op_new->data = data;
+
+	ch = cs_dsp_chunk((void *) op_new->words,
+			  WSEQ_OP_FULL_WORDS * sizeof(u32));
+	cs_dsp_chunk_write(&ch, 8, op_new->operation);
+	switch (op_code) {
+	case CS_DSP_WSEQ_FULL:
+		cs_dsp_chunk_write(&ch, 32, op_new->address);
+		cs_dsp_chunk_write(&ch, 32, op_new->data);
+		break;
+	case CS_DSP_WSEQ_L16:
+	case CS_DSP_WSEQ_H16:
+		cs_dsp_chunk_write(&ch, 24, op_new->address);
+		cs_dsp_chunk_write(&ch, 16, op_new->data);
+		break;
+	default:
+		ret = -EINVAL;
+		goto op_new_free;
+	}
+
+	new_op_size = cs_dsp_chunk_bytes(&ch);
+
+	op_end = cs_dsp_wseq_find_op(CS_DSP_WSEQ_END, 0, &wseq->ops);
+	if (!op_end) {
+		cs_dsp_err(dsp, "Missing write sequencer list terminator\n");
+		ret = -EINVAL;
+		goto op_new_free;
+	}
+
+	wseq_bytes = wseq->size * sizeof(u32);
+
+	if (wseq_bytes - op_end->offset < new_op_size) {
+		cs_dsp_err(dsp, "Not enough memory in Write Sequencer for entry\n");
+		ret = -ENOMEM;
+		goto op_new_free;
+	}
+
+	if (!update) {
+		op_new->offset = op_end->offset;
+		op_end->offset += new_op_size;
+	}
+
+	ret = regmap_raw_write(dsp->regmap, wseq->reg + op_new->offset,
+			       op_new->words, new_op_size);
+	if (ret)
+		goto op_new_free;
+
+	if (!update) {
+		ret = regmap_write(dsp->regmap, wseq->reg + op_end->offset,
+				   WSEQ_END_OF_SCRIPT);
+		if (ret)
+			goto op_new_free;
+
+		list_add(&op_new->list, &wseq->ops);
+	}
+
+	return 0;
+
+op_new_free:
+	devm_kfree(dsp->dev, op_new);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_wseq_write);
+
+/**
+ * cs_dsp_wseq_multi_write() - Add or update multiple entries in the write sequence
+ * @dsp: Pointer to a DSP structure
+ * @wseq: Write sequence to write to
+ * @reg_seq: List of address-data pairs
+ * @num_regs: Number of address-data pairs
+ * @update: If true, searches for the first entry in the write sequence with the same
+ * address and op code, and replaces it. If false, creates a new entry at the tail.
+ * @op_code: The types of operations of the new entries
+ *
+ * This function calls cs_dsp_wseq_write() for multiple address-data pairs.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_wseq_multi_write(struct cs_dsp *dsp, struct cs_dsp_wseq *wseq,
+			    const struct reg_sequence *reg_seq,
+			    int num_regs, bool update, u8 op_code)
+{
+	int ret, i;
+
+	for (i = 0; i < num_regs; i++) {
+		ret = cs_dsp_wseq_write(dsp, wseq, reg_seq[i].reg,
+					reg_seq[i].def, update, op_code);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_wseq_multi_write);
+
 MODULE_DESCRIPTION("Cirrus Logic DSP Support");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 29cd11d5a3cf..d674fc061e9d 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -42,6 +42,16 @@
 #define CS_DSP_ACKED_CTL_MIN_VALUE           0
 #define CS_DSP_ACKED_CTL_MAX_VALUE           0xFFFFFF
 
+/*
+ * Write sequencer operation codes
+ */
+#define CS_DSP_WSEQ_FULL	0x00
+#define CS_DSP_WSEQ_ADDR8	0x02
+#define CS_DSP_WSEQ_L16		0x04
+#define CS_DSP_WSEQ_H16		0x05
+#define CS_DSP_WSEQ_UNLOCK	0xFD
+#define CS_DSP_WSEQ_END		0xFF
+
 /**
  * struct cs_dsp_region - Describes a logical memory region in DSP address space
  * @type:	Memory region type
@@ -107,6 +117,18 @@ struct cs_dsp_coeff_ctl {
 struct cs_dsp_ops;
 struct cs_dsp_client_ops;
 
+/**
+ * struct cs_dsp_wseq - Describes a write sequence
+ * @reg:	Address of the head of the write sequence register
+ * @size:	Size of the write sequence in words
+ * @ops:	Operations contained within the write sequence
+ */
+struct cs_dsp_wseq {
+	unsigned int reg;
+	unsigned int size;
+	struct list_head ops;
+};
+
 /**
  * struct cs_dsp - Configuration and state of a Cirrus Logic DSP
  * @name:		The name of the DSP instance
@@ -254,6 +276,12 @@ struct cs_dsp_alg_region *cs_dsp_find_alg_region(struct cs_dsp *dsp,
 						 int type, unsigned int id);
 
 const char *cs_dsp_mem_region_name(unsigned int type);
+int cs_dsp_wseq_init(struct cs_dsp *dsp, struct cs_dsp_wseq *wseqs, unsigned int num_wseqs);
+int cs_dsp_wseq_write(struct cs_dsp *dsp, struct cs_dsp_wseq *wseq, u32 addr, u32 data,
+		      bool update, u8 op_code);
+int cs_dsp_wseq_multi_write(struct cs_dsp *dsp, struct cs_dsp_wseq *wseq,
+			    const struct reg_sequence *reg_seq,
+			    int num_regs, bool update, u8 op_code);
 
 /**
  * struct cs_dsp_chunk - Describes a buffer holding data formatted for the DSP
-- 
2.25.1


