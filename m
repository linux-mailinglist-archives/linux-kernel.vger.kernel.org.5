Return-Path: <linux-kernel+bounces-120740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3C88DC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9358029F7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCE5915F;
	Wed, 27 Mar 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mvgria2P"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9522065
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538409; cv=none; b=rvSRta2T4I5vtrDV3qZfZg3YQoo2V1s1Gx/t6bpom7HOiiEMSxnX4jjLxypuafI56VmSk+YRG+dzswBs7XYXxz6/qOOGG3varfHNeeY6Whu8iJ4Oe9xdG7dVAij58/q5DGXjxQHwcbL42YsduY1CrgcQkbLSNZ800ijHsDoM3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538409; c=relaxed/simple;
	bh=CVqGuVCUlKaFKKUufVc7iIVVXE18aJ/gXwJWPCNPUEs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pDYNSmAsit9R4iw4NMojsafQu0l/O43T7eMyZJ6A3jEMEt9hJ/3CbujF/MBqvP9YN16Pe/UX1mI5FrMFMo2sLwvkEtrG//vnPffjQ4MPt1aOv1Z1ghcA4oU/J6CrMfU1RiWm0+G8RHkKt+u2ySoxiu8d5preqB7H838xMxYryBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mvgria2P; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=assffd3au5ez3dtxassprdhwme.protonmail; t=1711538398; x=1711797598;
	bh=CVqGuVCUlKaFKKUufVc7iIVVXE18aJ/gXwJWPCNPUEs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mvgria2P0PRp+e5PTaWA3S9jrHjHyLgQA7om7AADs3vl6yCxbDo0gdraqox3Dmm1Z
	 96HXLuHrCRFwBwvxiYLmIkDaoJyM6CBiZN0NWXVyjYTqhsgnBCfy/unB5a4wOpgVXI
	 mKvcu+0lRAMksmDlVnSFqZhPRpK0gWywfq/1G9yqD+rkgASUhstQrpSak5L6724YaZ
	 mKUOYZm5EqpFpRy3a2zGF1Y6xHvME5LDt67qPom96JKxmTdRJ2ZvKGwR+8ngjqb97V
	 Bc9sqspRs4+HlvjNfAxNQxBX0VGHTuZVmz0usVzY9mr0Hv95Ro/L0W4P4ZshizfKM0
	 0ZIlxQvBlYMKA==
Date: Wed, 27 Mar 2024 11:19:45 +0000
To: arnd@arndb.de
From: Atin Bainada <atin4@proton.me>
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Atin Bainada <atin4@proton.me>
Subject: [PATCH] misc: ti-st: st_kim: remove unnecessary (void*) conversions
Message-ID: <20240327111914.38104-1-atin4@proton.me>
Feedback-ID: 57663010:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

No need to type cast (void*) pointer variables.

Signed-off-by: Atin Bainada <atin4@proton.me>
---
 drivers/misc/ti-st/st_kim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 47ebe80bf849..c4f963cf96f2 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -563,7 +563,7 @@ long st_kim_stop(void *kim_data)
=20
 static int version_show(struct seq_file *s, void *unused)
 {
-=09struct kim_data_s *kim_gdata =3D (struct kim_data_s *)s->private;
+=09struct kim_data_s *kim_gdata =3D s->private;
 =09seq_printf(s, "%04X %d.%d.%d\n", kim_gdata->version.full,
 =09=09=09kim_gdata->version.chip, kim_gdata->version.maj_ver,
 =09=09=09kim_gdata->version.min_ver);
@@ -572,7 +572,7 @@ static int version_show(struct seq_file *s, void *unuse=
d)
=20
 static int list_show(struct seq_file *s, void *unused)
 {
-=09struct kim_data_s *kim_gdata =3D (struct kim_data_s *)s->private;
+=09struct kim_data_s *kim_gdata =3D s->private;
 =09kim_st_list_protocols(kim_gdata->core_data, s);
 =09return 0;
 }
--=20
2.44.0



