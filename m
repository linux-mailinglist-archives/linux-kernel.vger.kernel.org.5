Return-Path: <linux-kernel+bounces-56646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5084CD2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C95289FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E57E77B;
	Wed,  7 Feb 2024 14:47:42 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A67C09D;
	Wed,  7 Feb 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317262; cv=none; b=hA0awFb5N3Rt/mDvnMepoFmmP9hfiZXFKRsqSyT1Qh8LMn2A4jR7bflklJCVsHga7k0XyP77kUksaFTSOnja8+WnwFebsPYe55xzqoRBRqbsNPoESKvdTthS07JFs4Mm1GZmgWyI5AoSZQjdRO0lkbrl070tI1ZSS2gdENxjt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317262; c=relaxed/simple;
	bh=EREOCDuY/VaO1DK/rIWsaUxe3lA2A5pxjjlM1ctl9Uo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=hL+aTiI41TyX8qeDgDODaOo4NSQqiHbF7XzT366F3ov+jNO4sK4MGA56puUp039UIRuXBBOJf3NOEum0I3djiLGWwtafj6KRKviZMH8YEAQNTYq+9TcVZnqqPfE7QbYHxyxcYad/ftfmgzWGjge/H69b/rHhpLEL/fhow8+zakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 77B985FFB7;
	Wed,  7 Feb 2024 15:47:31 +0100 (CET)
Date: Wed, 7 Feb 2024 15:47:31 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1028271990.585289303.1707317251450.JavaMail.zimbra@free.fr>
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fix order and duplicates in
 quirks table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Index: f3r19/NXxRjbUfclxQjveASnQPrB4A==
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table

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


