Return-Path: <linux-kernel+bounces-26316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FF82DE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4CFB21F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722B1802E;
	Mon, 15 Jan 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marun.edu.tr header.i=@marun.edu.tr header.b="c/CzhwiL"
Received: from mx1.marmara.edu.tr (mx1.marmara.edu.tr [193.140.143.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36E182AB;
	Mon, 15 Jan 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marun.edu.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marun.edu.tr
Received: from mx1.marmara.edu.tr (localhost.localdomain [127.0.0.1])
	by mx1.marmara.edu.tr (Proxmox) with ESMTP id B228B82A95;
	Mon, 15 Jan 2024 20:23:04 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marun.edu.tr; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mx; bh=jH8/0JQnWz+vr8gNXNlad8
	EEUqhrYAEXESLH82iEpiw=; b=c/CzhwiLKB9a2gIkbCyanFAM6j0YD1clWGD+p/
	RYXw8KcDcnbk6ic5h75Db3hjwRBTYSdVNrUmD9mFke5ijMwXPQBNED4CnEExc/XN
	j0afEPPdfIfst7ffeL7YxGXTMsCS2oNt1wDcxtomRCNQl9CNutO852DL6h2qgcim
	hr0h095nkT98VucmUVeEJyMkmYeyHf9AC8T9fOx+pqs3coZ8Fk6flEl0C8FxBhaT
	yVV2wTYWuDrvz8vIGpR1auCOVRrxZVR6mkB4yiZPUIk+NftLmStmpXI/fIerwsfh
	oQPHoOk8HQqYXDppq4w3iHjdCTuLnhgsvY7d+gDzYICJ73p6Y0SjZJ3EwILvO/fE
	Xo5go12Zq7E6BRCjWowuJnkK47li99jxg/jqOCKJye/cfi6F2/50RGn+ATgYcD+0
	erREHDhGotQuHYcwZZtB8wvbFkqYPgb49ek/RFzKDkLi6MPMRYNgQJ66KLQNut3u
	ZvVs+n/dJEhaGUwSsLw5dEiEhAtistvVWc1JtPlbRn5MI2gazx13SLiwPLqfJ0nl
	VgfZ3KnjVmZv8ggwCjwybIBHAOymmRckRBukicvmu7LU3/YfnN+SgBPeETZTmarx
	b1HgMk5kIxOiqvdSN9jcKmxmZ8+VfGgX6InSGuHLoHSF7KRLzGZLMDr/o7M0R/uT
	gMRVc=
From: =?UTF-8?q?=C3=87a=C4=9Fhan=20Demir?= <caghandemir@marun.edu.tr>
To: caghandemir@marun.edu.tr
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
Date: Mon, 15 Jan 2024 20:23:03 +0300
Message-ID: <20240115172303.4718-1-caghandemir@marun.edu.tr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113023734.10817-2-caghandemir@marun.edu.tr>
References: <20240113023734.10817-2-caghandemir@marun.edu.tr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This HP Laptop uses ALC236 codec with COEF 0x07 idx 1 controlling
the mute LED. This patch enables the already existing quirk for
this device.

Signed-off-by: Çağhan Demir <caghandemir@marun.edu.tr>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b68c94757..0f0a03e89 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9861,6 +9861,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
-- 
2.43.0


--
Bu e-posta mesajı ve içeriği gizli veya özel bilgiler içerebilir. Mesajın içeriğinde bulunan tüm fikir ve görüşler sadece göndericiye ait olup, Marmara Üniversitesi’nin resmi görüşünü yansıtmaz. Kurumumuz bu e-posta içeriğindeki bilgilerin kullanılması nedeniyle hiç kimseye karşı sorumlu tutulamaz. Mesajın belirlenen alıcılardan biri değilseniz, mesaj içeriğini ya da eklerini kullanmayınız, kopyalamayınız, yaymayınız, başka kişilere yönlendirmeyiniz ve mesajı gönderen kişiyi derhal e-posta yoluyla haberdar ederek bu mesajı ve eklerini herhangi bir kopyasını muhafaza etmeksizin siliniz. Kurumumuz size, mesajın ve bilgilerinin değişikliğe uğramaması, bütünlüğünün ve gizliliğin korunması konusunda garanti vermemekte olup, e-posta içeriğine yetkisiz olarak yapılan müdahale, virüs içermesi ve/veya bilgisayar sisteminize verebileceği herhangi bir zarardan da sorumlu değildir.This e-mail message and its content may cont
 ain confidential or proprietary information. All ideas and opinions contained in the message are solely those of the sender and do not reflect the official opinion of Marmara University. Our institution cannot be held responsible to anyone for the use of the information contained in this e-mail. If you are not one of the designated recipients of the message, do not use, copy, disseminate, forward the message content or attachments, and immediately notify the sender of the message via e-mail and delete this message and its attachments without retaining any copies. Our institution does not guarantee you that the message and its information will not be changed, its integrity and confidentiality will be protected, and is not responsible for any unauthorized intervention to the e-mail content, viruses and/or any damage it may cause to your computer system.


