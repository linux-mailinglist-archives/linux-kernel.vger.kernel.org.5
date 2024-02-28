Return-Path: <linux-kernel+bounces-85597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C986B823
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23C4B2125B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607674423;
	Wed, 28 Feb 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cv2lVUiH"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322274410;
	Wed, 28 Feb 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148531; cv=none; b=G5/2QjBHOCVFmBZpIYLy2sEXiknvgWNIKfrSjESjVGGPW2B1Rm4QR0o2stkHqlkyoHZRKpxr3tBAqzCERnfuEoU4oN7E6zzT5lEmND7oIYHPJbuDH96auca1SKBBYhor2NcZvqYeXZ+E4Pb6JemOX5nsZNgftUJukUahEeNb5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148531; c=relaxed/simple;
	bh=y3/AiIPJpnisyh+JMqGGimriuBFEELkPDH66n6lcrt4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pmWYxQ4+PcXTd49lmlNe5rD5O8F33obQ48oRTDFSEOEc4hiBIYg9SlFh6YmGJjfFE2ANK/Oee9dyACUuW8mg5BA5B5F6hq10xiWXqHM4QE2vZjpzUhzZlmNKUwsRz1BIcwOjuuo4/YZrkyfwfIcDIaJJPglwZv8GRVoridR1PTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cv2lVUiH; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1709148527; x=1709407727;
	bh=y3/AiIPJpnisyh+JMqGGimriuBFEELkPDH66n6lcrt4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cv2lVUiHA5KQlEXkHCHqNZshzfp90Wf5plfT4RhFVcUBE143fXFBv8cMKZpy8v/qp
	 eIZ+LmhOJbsV1Ri55hTq3af2JfrG96RLUIHwQPdKaI1J2tl1+/HwJFaXjB9t7vpMOO
	 EhY8ELU3rgZImU9nwSKwKHlv/hVydDhfjidXkfM++577TCxe+U/8Pg1QNgFCj6yTef
	 jOXUfPw5DvrSQRgCJWNBTln/lfYnH9FcJT1OJUfY/7ScKyB389pKQeBAQqRZUIuynT
	 7oU7qwAKLrnl+GnGsVYofUVRthQxNpuSnK4EWl907sv4e2Tpq5J+bcQIIbCHNuxqHj
	 jvDe5mCwkxEEg==
Date: Wed, 28 Feb 2024 19:28:41 +0000
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Cc: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Subject: [PATCH v3] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Message-ID: <20240228192807.15130-1-alban.boye@protonmail.com>
Feedback-ID: 10280386:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The bios version can differ depending if it is a dual-boot variant of the t=
ablet.
Therefore another DMI match is required.

Signed-off-by: Alban Boy=C3=A9 <alban.boye@protonmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards=
/bytcr_rt5640.c
index 03be5e26ec4a..05f38d1f7d82 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -685,6 +685,18 @@ static const struct dmi_system_id byt_rt5640_quirk_tab=
le[] =3D {
 =09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
 =09=09=09=09=09BYT_RT5640_MCLK_EN),
 =09},
+=09{=09/* Chuwi Vi8 dual-boot (CWI506) */
+=09=09.matches =3D {
+=09=09=09DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+=09=09=09DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+=09=09=09/* The above are too generic, also match BIOS info */
+=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+=09=09},
+=09=09.driver_data =3D (void *)(BYTCR_INPUT_DEFAULTS |
+=09=09=09=09=09BYT_RT5640_MONO_SPEAKER |
+=09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
+=09=09=09=09=09BYT_RT5640_MCLK_EN),
+=09},
 =09{
 =09=09/* Chuwi Vi10 (CWI505) */
 =09=09.matches =3D {
--=20
2.43.1



