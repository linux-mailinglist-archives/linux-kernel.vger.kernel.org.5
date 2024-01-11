Return-Path: <linux-kernel+bounces-23065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E382A71F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17241289903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A91C31;
	Thu, 11 Jan 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vn5JYEQE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C441FB0;
	Thu, 11 Jan 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=32J24GHc57Fohhb0X9exlI2oFEDZDXgIwq9fIgFZJzQ=; b=vn5JYEQEKeExbC/McC/AL0Tzbk
	9FgtWaREyiUKskoMsOnH8ggub2Awh9G9AaOBXjBziqExIVVgeH52K9nhVtj2gtGPPIhA+YNT6uMEk
	/ZhY+mmK4OORnn+KRy0SEA0SBC/yG0iGu5bAx1ar9qEO3HhDo/SRMUJq40ebBMUNgj7HCNJBgMc6Q
	aB747q7kzr/N4cHDstptHXzhDuH3sug8jKtOZRrtuCDrtIK8Shme0pQYgiRYUXyw0OaeVjRKN0OcV
	UuYaulfxUY1aM8pvnh05OUnG8r8qYaNZzr1ZBD3xMGeggzKH77qD3bbGea8rWLSXxv/wFzeRE67uf
	SCBKsAjw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNn8L-00FsFR-0o;
	Thu, 11 Jan 2024 04:57:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: p1022_rdk: fix all kernel-doc warnings
Date: Wed, 10 Jan 2024 20:57:36 -0800
Message-ID: <20240111045736.7500-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several kernel-doc warnings in p1022_rdk.c:

p1022_rdk.c:70: warning: cannot understand function prototype: 'struct machine_data '
p1022_rdk.c:90: warning: Function parameter or struct member 'card' not described in 'p1022_rdk_machine_probe'
p1022_rdk.c:90: warning: No description found for return value of 'p1022_rdk_machine_probe'
p1022_rdk.c:129: warning: Function parameter or struct member 'substream' not described in 'p1022_rdk_startup'
p1022_rdk.c:129: warning: No description found for return value of 'p1022_rdk_startup'
p1022_rdk.c:162: warning: Function parameter or struct member 'card' not described in 'p1022_rdk_machine_remove'
p1022_rdk.c:162: warning: No description found for return value of 'p1022_rdk_machine_remove'
p1022_rdk.c:187: warning: cannot understand function prototype: 'const struct snd_soc_ops p1022_rdk_ops = '
p1022_rdk.c:199: warning: Function parameter or struct member 'pdev' not described in 'p1022_rdk_probe'
p1022_rdk.c:199: warning: No description found for return value of 'p1022_rdk_probe'
p1022_rdk.c:349: warning: Function parameter or struct member 'pdev' not described in 'p1022_rdk_remove'
p1022_rdk.c:376: warning: No description found for return value of 'p1022_rdk_init'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/soc/fsl/p1022_rdk.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff -- a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -61,7 +61,7 @@ static inline void guts_set_dmuxcr(struc
 /* There's only one global utilities register */
 static phys_addr_t guts_phys;
 
-/**
+/*
  * machine_data: machine-specific ASoC device data
  *
  * This structure contains data for a single sound platform device on an
@@ -80,11 +80,14 @@ struct machine_data {
 };
 
 /**
- * p1022_rdk_machine_probe: initialize the board
+ * p1022_rdk_machine_probe - initialize the board
+ * @card: ASoC card instance
  *
  * This function is used to initialize the board-specific hardware.
  *
  * Here we program the DMACR and PMUXCR registers.
+ *
+ * Returns: %0 on success or negative errno value on error
  */
 static int p1022_rdk_machine_probe(struct snd_soc_card *card)
 {
@@ -119,11 +122,14 @@ static int p1022_rdk_machine_probe(struc
 }
 
 /**
- * p1022_rdk_startup: program the board with various hardware parameters
+ * p1022_rdk_startup - program the board with various hardware parameters
+ * @substream: ASoC substream object
  *
  * This function takes board-specific information, like clock frequencies
  * and serial data formats, and passes that information to the codec and
  * transport drivers.
+ *
+ * Returns: %0 on success or negative errno value on error
  */
 static int p1022_rdk_startup(struct snd_pcm_substream *substream)
 {
@@ -153,10 +159,13 @@ static int p1022_rdk_startup(struct snd_
 }
 
 /**
- * p1022_rdk_machine_remove: Remove the sound device
+ * p1022_rdk_machine_remove - Remove the sound device
+ * @card: ASoC card instance
  *
  * This function is called to remove the sound device for one SSI.  We
  * de-program the DMACR and PMUXCR register.
+ *
+ * Returns: %0 on success or negative errno value on error
  */
 static int p1022_rdk_machine_remove(struct snd_soc_card *card)
 {
@@ -181,7 +190,7 @@ static int p1022_rdk_machine_remove(stru
 	return 0;
 }
 
-/**
+/*
  * p1022_rdk_ops: ASoC machine driver operations
  */
 static const struct snd_soc_ops p1022_rdk_ops = {
@@ -189,11 +198,14 @@ static const struct snd_soc_ops p1022_rd
 };
 
 /**
- * p1022_rdk_probe: platform probe function for the machine driver
+ * p1022_rdk_probe - platform probe function for the machine driver
+ * @pdev: platform device pointer
  *
  * Although this is a machine driver, the SSI node is the "master" node with
  * respect to audio hardware connections.  Therefore, we create a new ASoC
  * device for each new SSI node that has a codec attached.
+ *
+ * Returns: %0 on success or negative errno value on error
  */
 static int p1022_rdk_probe(struct platform_device *pdev)
 {
@@ -341,7 +353,8 @@ error_put:
 }
 
 /**
- * p1022_rdk_remove: remove the platform device
+ * p1022_rdk_remove - remove the platform device
+ * @pdev: platform device pointer
  *
  * This function is called when the platform device is removed.
  */
@@ -368,9 +381,11 @@ static struct platform_driver p1022_rdk_
 };
 
 /**
- * p1022_rdk_init: machine driver initialization.
+ * p1022_rdk_init - machine driver initialization.
  *
  * This function is called when this module is loaded.
+ *
+ * Returns: %0 on success or negative errno value on error
  */
 static int __init p1022_rdk_init(void)
 {
@@ -391,7 +406,7 @@ static int __init p1022_rdk_init(void)
 }
 
 /**
- * p1022_rdk_exit: machine driver exit
+ * p1022_rdk_exit - machine driver exit
  *
  * This function is called when this driver is unloaded.
  */

