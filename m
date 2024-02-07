Return-Path: <linux-kernel+bounces-56623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B984CCC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841E928CEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F77E571;
	Wed,  7 Feb 2024 14:31:07 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8222C374E0;
	Wed,  7 Feb 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316266; cv=none; b=coH475KIczGwj5DaV74LgK1sxY1cnY+mWs3HjzgGdJqKeXQaIYVv6FQ8ZUKwMldVjx6kLYWjSUxWQl9MFYu9uHNN0kUVFrnwQM77wtXydbs3hO6kUqAryo9bq6vs+iFxn5vrUZLBD/+CAOD4BLIS3DKa0IoYnlPZf+90SL9VQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316266; c=relaxed/simple;
	bh=y0KWZrJXOyRC5CIPTz+1fodmZg6ChjIlV0scfDMLO1g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=vEEp8keN7P+m1ofpKFvoG2TSXdhz8LUZo3RSJtIXUx1Ku262ZToZZc8KMGHJrSIEe9vcteUKZGjUPv4L01GYUDz/1oLPzaUmWBQloDfO0NPLKvQYCm7Uq77NvlnFJ88+WFxC1L9eY7R5T0aovfG+ZUPXV4mIX+320pS5D1Tuwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 9DE684C8FA;
	Wed,  7 Feb 2024 15:30:54 +0100 (CET)
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AD34A13F8A7;
	Wed,  7 Feb 2024 15:30:46 +0100 (CET)
Date: Wed, 7 Feb 2024 15:30:46 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
In-Reply-To: <87o7cs5r29.wl-tiwai@suse.de>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr> <87o7cs5r29.wl-tiwai@suse.de>
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker
 support for ASUS UM3402 with missing DSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
Thread-Index: mkayzFxE17dOTxly0rkuWXxYNN7URQ==

Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
Add DSD values for "ASUS UM3402" to cs35l41_config_table[].

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_h=
da_property.c
index 923c0813fa08..d8cd62ef6afc 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -102,6 +102,7 @@ static const struct cs35l41_config cs35l41_config_table=
[] =3D {
 =09{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 1000, 4500, 24 },
 =09{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2,=
 0, 0, 0, 0 },
 =09{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2,=
 0, 0, 0, 0 },
+=09{ "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1=
, -1, 0, 0, 0 },
 =09{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 1000, 4500, 24 },
 =09{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1=
, 0, 0, 0, 0 },
@@ -485,6 +486,7 @@ static const struct cs35l41_prop_model cs35l41_prop_mod=
el_table[] =3D {
 =09{ "CSC3551", "10431D1F", generic_dsd_config },
 =09{ "CSC3551", "10431DA2", generic_dsd_config },
 =09{ "CSC3551", "10431E02", generic_dsd_config },
+=09{ "CSC3551", "10431E12", generic_dsd_config },
 =09{ "CSC3551", "10431EE2", generic_dsd_config },
 =09{ "CSC3551", "10431F12", generic_dsd_config },
 =09{ "CSC3551", "10431F1F", generic_dsd_config },
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


