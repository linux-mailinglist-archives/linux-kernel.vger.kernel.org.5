Return-Path: <linux-kernel+bounces-84136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2686A2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8B6B26479
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD35579B;
	Tue, 27 Feb 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ECmsLgib"
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7715577B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073642; cv=none; b=KWzUmcNoGNgU+IqAic9UPiMcyJiNarVm1O8OHwlJF2gqcjX2tg2UnjDsPDvt/ZrMIswN77VeZX2IPiapDT1f1XJZ+oIUFngRs+/dUdP92BHGPXb33BurvBE5CYwF75dxAfez2vzMI1kgUz5/qFXAzDzBF1VBmGNMcUcz++uAWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073642; c=relaxed/simple;
	bh=DH72h+bpNe+iPB8Hab2NfIWuu6JASlyb4Bjuve4uwvw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PaPnAuSVhfvmni0jH7W8Lxk1DnXmk0nArq1fou3XcP3tCvQ1D113TTox1GDpdqHOkC7YclJir9VYoT+X4fDW48pSa/vJoVROdE9/OW6azKPMWaXC1OfO8OFkVqHusvpwy3kIPbvWmp9irR9lTecTFqmqF81Yy+1iGiZF2dLbiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ECmsLgib; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1709073638; x=1709332838;
	bh=DH72h+bpNe+iPB8Hab2NfIWuu6JASlyb4Bjuve4uwvw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ECmsLgibmxYsfd0xUtCifyqqH7aXK4Ip8Z2k7NoOgxm8M5DTg3zbpnSF5wnddKwgW
	 1zmissZJpbAKyT4SaTnm6/5BNKf/QehzNUBfQEN2zLsJyye1EkbeGTmc37QGqIB0yD
	 QpAYLNL3LB5T56NC9s+iZQgzZEU1nXeVguArE+oK+eYmvMAXH18VstrrCwc0w1fY+d
	 qv/H1kI/kUPq3fVPUOOflhNZ4k2KWz4XAnXEj/MjHy0+Stvsmm8Vs6oRj7q5XwNSvn
	 oCoAnJ1wqNZVMQQarKAFvPpReDTaak5q+jqbYadilXYIBSAZ1jn2hm8gox9aGLaXsx
	 oDxu1UVO1OO1Q==
Date: Tue, 27 Feb 2024 22:40:17 +0000
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Cc: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
Message-ID: <20240227223919.11587-1-alban.boye@protonmail.com>
Feedback-ID: 10280386:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Alban Boy=C3=A9 <alban.boye@protonmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index 975cf24ae359..c6a10ec2c83f 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1217,6 +1217,15 @@ const struct dmi_system_id touchscreen_dmi_table[] =
=3D {
 =09=09=09DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 =09=09},
 =09},
+=09{
+=09=09/* Chuwi Vi8 dual-boot (CWI506) */
+=09=09.driver_data =3D (void *)&chuwi_vi8_data,
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+=09=09},
+=09},
 =09{
 =09=09/* Chuwi Vi8 Plus (CWI519) */
 =09=09.driver_data =3D (void *)&chuwi_vi8_plus_data,
--=20
2.43.1



