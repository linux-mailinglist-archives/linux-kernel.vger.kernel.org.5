Return-Path: <linux-kernel+bounces-56789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4884CF36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BE4B26610
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D581AC6;
	Wed,  7 Feb 2024 16:45:58 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F660811FF;
	Wed,  7 Feb 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324358; cv=none; b=rsNdktPWBMg2v4n4RScnubbcrkPYITA0bitZiaVuN2XsM91Z2vuhPmNMRI1TQn2tjq0ns4LU9AWoqueJcfN8+KRVLRKLaWDY2JOlUTi8WCcerGy8GyBxjmvZW9u2uZIwuphqo/zv6oLOPFyx0UkSUkHpILGRHEji+zTgvwOyOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324358; c=relaxed/simple;
	bh=FztghI6vbkCPQPpwB2LCkdAS5k0WW3LHHAPthyqFU4o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=R+YVGdQYASBqCJsuIgtGtLR44YQYbQq1cNpQVT2h/R0alxHEUPYrH9MwnYqpOWiVZkdxKAHYX2iQGYnQSbFXWjhbx62HNAFa3AWY2eEggW/K2cXPrAOFO/4IQseH6knRXGxlSI3vpvLafCV5lEDjNJ9rQOPhQrRLDIP0WXnymaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 062446012F;
	Wed,  7 Feb 2024 17:45:53 +0100 (CET)
Date: Wed, 7 Feb 2024 17:45:52 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <861258749.586395713.1707324352942.JavaMail.zimbra@free.fr>
In-Reply-To: <87jzng5mzv.wl-tiwai@suse.de>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr> <87o7cs5r29.wl-tiwai@suse.de> <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr> <87jzng5mzv.wl-tiwai@suse.de>
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
Thread-Index: t5IMP936atodSjXM7inCwLM1kMKjKQ==

Add DSD values for "ASUS UM3402" to cs35l41_config_table[].

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

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
--=20
2.40.1


