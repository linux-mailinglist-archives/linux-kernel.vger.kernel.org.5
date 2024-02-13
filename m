Return-Path: <linux-kernel+bounces-64552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3C854037
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51257B24262
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B063130;
	Tue, 13 Feb 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="UkTsKg3M"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8C63115;
	Tue, 13 Feb 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867521; cv=none; b=i8WJ+OulbfMKr+cIo2aYy3U2tpagvBa9Vhy+AzyIUA0uupGPtAXBWCWdUlLJ8XPuSWEr+Zf1WZK99GmBOv+qfdWL0hOxnEpyQhP87/026NKRpZoQd1lRGgVrpvoiVHIFMikbsrVwO84gArYknQARbjFouMc+0TaZg1oL038lVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867521; c=relaxed/simple;
	bh=YQ1R5ZVaXDLGFd215ozQjhvZOtzMKOQ1hIF/Ckw706s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MzA7xUe4xZY5Lpt0aOxjVWC1LzzX7TNp2AA6R43Ih6u8pERkut5T+EJ18NiV7++Y6cMkNaW07RYX8XbtQeCogqBsF/4QAXttpWNXT7xeiLnokh6ruvmkeUWRAat3eKcVOo9+dR4j+Psqhhyfug4K2ct3Y3T8ijsFKUzG1NsZ/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=UkTsKg3M; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1710B19F553;
	Wed, 14 Feb 2024 00:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707867511;
	bh=YQ1R5ZVaXDLGFd215ozQjhvZOtzMKOQ1hIF/Ckw706s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UkTsKg3M6ufBbKw1N1HspN3w2fQ+vfQ+y+warM3QptlIZgAlHjHTWgkHq0jNs2Fyn
	 70KsL0ElkRHYAD+4A9pJoc8locIokRJ4Cc0fjrju/SCOfDTcQ1F8r/Ql7TQZO39yDd
	 qq86VESTgqLvItkKfztDCLdmfonXMgvcdn91h/HmBX4SKOfd66VQCDFrMkPQKBI/7t
	 oDKVGV2IrIyu3UBOA6E3s3MQYYXO3sCZOInFU07YC9ysNYtDRf9uHWANUDZVCptQsv
	 vf7gwfC66WSzls0KUvpNSvykd2HMxx3vwa6GsbzNMmh4r12S7I91JkBB4PVa2G7U3n
	 8ARUy/LK+SKNg==
Date: Wed, 14 Feb 2024 00:38:31 +0100 (CET)
From: lagiraudiere@free.fr
To: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1435594585.650325975.1707867511062.JavaMail.zimbra@free.fr>
In-Reply-To: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
References: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
Subject: [PATCH v3 1/3] ALSA: hda/realtek: cs35l41: Add internal speaker
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
Thread-Topic: ALSA: hda/realtek: cs35l41: Add internal speaker support for ASUS UM3402 with missing DSD
Thread-Index: b1DHXbQj7eN1w6/I0T0Clij1GRQ0gBIG7hii

Add the values for the missing DSD properties to the cs35l41 config table.

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


