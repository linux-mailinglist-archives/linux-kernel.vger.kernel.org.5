Return-Path: <linux-kernel+bounces-64560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C72854047
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0BEB20F01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC06312F;
	Tue, 13 Feb 2024 23:44:34 +0000 (UTC)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304963111;
	Tue, 13 Feb 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867874; cv=none; b=rSx0ggtYTSeO0hPTHXO8qMxa0Y9OdMoTuDTzNNS6Q8sRd7AQ86ujmtTYRv65XgSVUqLYj9BRbqzKsT8XNeF9GRbKCC+YsYsBQW4Lbn7I/lVqOZFE3VtrzsDJxoIK4jUpzmsHiePoYLZIK75L4+qKkuos8scWB0yY4Ma3G1Nmu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867874; c=relaxed/simple;
	bh=EREOCDuY/VaO1DK/rIWsaUxe3lA2A5pxjjlM1ctl9Uo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=q5A5o7K1KKJbVxgT8yjJR3rpqtatJV+XFoqK5OjxolmUKDNGria9eSDd2o+u06/6h0mzq3G325NrQbVDA8mrQ9piNWsEoizD1JUujPvUc1VFJMI4oyXwoT5dy3GVLHjSNnQYz8EWMwDXbQquj9yESV1PJT2MP1TjfT2+ZBYTIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1928313F86E;
	Wed, 14 Feb 2024 00:44:24 +0100 (CET)
Date: Wed, 14 Feb 2024 00:44:24 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1969151851.650354669.1707867864074.JavaMail.zimbra@free.fr>
In-Reply-To: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
References: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
Subject: [PATCH v3 3/3] ALSA: hda/realtek: cs35l41: Fix order and duplicates
 in quirks table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table
Thread-Index: b1DHXbQj7eN1w6/I0T0Clij1GRQ0gPpZp6io

Move entry {0x1043, 0x16a3, "ASUS UX3402VA"} following device ID order.
Remove duplicate entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/patch_realtek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fe81a628d7c8..16cb19eee589 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9893,6 +9893,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SP=
K),
 =09SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV", ALC285_FIXUP_=
ASUS_HEADSET_MIC),
 =09SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2=
C_2),
+=09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 =09SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
@@ -9936,8 +9937,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 =09SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_=
SPI_2),
 =09SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI=
_2),
-=09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
-=09SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA=
502),
 =09SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2=
),
 =09SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU=
502_PINS),
--=20
2.40.1


