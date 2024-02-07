Return-Path: <linux-kernel+bounces-56889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5F84D0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800201C24D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF012880B;
	Wed,  7 Feb 2024 18:05:49 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65383CBD;
	Wed,  7 Feb 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329148; cv=none; b=RrPEqLrb+gxjcoBMZo1GYw2VTZvoPqX720rnat2PrvX3WtRv6Fy7kiEsiXsACXDkRkn6+uo/yufl4oX7+kSqL9jgNVSw9/l7aIwUiUjs8PNEFqX0y4jGKoLL/SH3aLZAajplMpV1NquSgnJ7xHKKTXLl1vUeY88gueYPACbZDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329148; c=relaxed/simple;
	bh=Djh3dR9ICrd+gZPt6qihUmY39eEIEk9Bi3cwjLDP6i8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AFHHv35ahSjo6eAyQqimnmZMbjvF+2SROH17+dPgq03x2Vkn21ShYH/7SgF9Swl0GLHz9UZ2ySGn9c4BLWtQezye6y9whTIs6OujSP6ifySNpZRQMqUF5u4UBZ6ygkVHHK3gGexAAw3C8/Lm4aEFr3YJl0nestLNp02w1BraAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id AADF34283EE;
	Wed,  7 Feb 2024 19:05:41 +0100 (CET)
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 20163B00565;
	Wed,  7 Feb 2024 19:05:34 +0100 (CET)
Date: Wed, 7 Feb 2024 19:05:34 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <742700696.587133028.1707329134088.JavaMail.zimbra@free.fr>
In-Reply-To: <87a5oc5hel.wl-tiwai@suse.de>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr> <87o7cs5r29.wl-tiwai@suse.de> <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr> <87jzng5mzv.wl-tiwai@suse.de> <1618884269.586462178.1707324711030.JavaMail.zimbra@free.fr> <87a5oc5hel.wl-tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda/realtek: cs35l41: Fix device ID / model name
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
Thread-Index: 5oxs63Ed4iOvYd3kfZPXRwyaA/JxGA==

The patch 51d976079976c800ef19ed1b542602fcf63f0edb ("ALSA: hda/realtek:
Add quirks for ASUS Zenbook 2022 Models") modified the entry 1043:1e2e
from "ASUS UM3402" to "ASUS UM6702RA/RC" and add another entry for "ASUS
UM3402" with 104e:1ee2.
The first entry was correct, while the new one corresponds to model
"ASUS UM6702RA/RC"
Fix the model names for both devices.

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
         SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L4=
1_SPI_2),
         SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L4=
1_SPI_2),
         SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_AS=
US_GA502),
-        SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC", ALC287_FIXUP_CS3=
5L41_I2C_2),
+        SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_=
I2C_2),
         SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_AS=
US_GU502_PINS),
         SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_=
ASUS_G513_PINS),
         SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_AS=
US_GA401),
-        SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402", ALC287_FIXUP_CS35L41_=
I2C_2),
+        SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS3=
5L41_I2C_2),
         SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIX=
UP_ASUS_GA401),
         SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_AS=
US_GA401),
         SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_=
I2C_2),
--=20
2.40.1

