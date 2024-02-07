Return-Path: <linux-kernel+bounces-56794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDAF84CF46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7601F21E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873C823A8;
	Wed,  7 Feb 2024 16:52:06 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381B81ABA;
	Wed,  7 Feb 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324725; cv=none; b=eD7KDoKOWjIummYRLjKxN455AQkBYMyKSwpxT1iERoWNsRGE2mm5COsPtw75VXvaR8NN4Fc4GCzUsvHL6DJSvEo5aOU66vTR3i2l8gFgFaDEWQw6hgXA+DCzXW/HjMf3/x7FzMFlJyGscV03Wk7aEgl+Rl3g0MbLtZ7CndVj3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324725; c=relaxed/simple;
	bh=ullUCm7exVfhJyVcH9cYkV6AWD58V3ikalbuxCkhQUM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gjiumpkLJWN7DycyxQprwyNoKyzMMlu9LVmN2Ey9F7dj1JoSREN+zqbpHm3bM+vK6Z+1Daq0eMHskgRGlSTS87jOj3Wn6A9Lzn1s0ktE8uI+Eq939cZOyNzWhXlLeci900ftF0sdiA6FBcJH2ReLXvTm7vqjasMSrapiFfohHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id B39584CE98;
	Wed,  7 Feb 2024 17:51:58 +0100 (CET)
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 1033B78050F;
	Wed,  7 Feb 2024 17:51:51 +0100 (CET)
Date: Wed, 7 Feb 2024 17:51:51 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1618884269.586462178.1707324711030.JavaMail.zimbra@free.fr>
In-Reply-To: <87jzng5mzv.wl-tiwai@suse.de>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr> <87o7cs5r29.wl-tiwai@suse.de> <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr> <87jzng5mzv.wl-tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fix device ID / model name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix device ID / model name
Thread-Index: 9pPIqsITclKV5kjHLQSEN4VMNuZxbA==

(un)swap device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7aa88ed04bde..fe81a628d7c8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9939,11 +9939,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA=
502),
-=09SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_=
I2C_2),
+=09SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2=
),
 =09SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU=
502_PINS),
 =09SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_=
G513_PINS),
 =09SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA=
401),
-=09SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2=
),
+=09SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_=
I2C_2),
 =09SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_AS=
US_GA401),
 =09SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA=
401),
 =09SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2=
),
--=20
2.40.1


