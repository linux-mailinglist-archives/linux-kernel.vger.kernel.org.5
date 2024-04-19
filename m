Return-Path: <linux-kernel+bounces-151902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68598AB585
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F31F2250E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87F13C825;
	Fri, 19 Apr 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3UvpkAR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WUoQtnpJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CE1D699
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554408; cv=none; b=nJwRIcuHKDiZhBaeZeL3BYQSvox40Ke9aoHvLsNaf/qZ3rzUtG0dsaQMVoOoTo+IIRy8Yy7TnnbGbGR+jwtNi1QDH6fvNvFqzvuPSRhj4wUZmdRJ+tH6LHWXs6TtGXCDvOc2ZfiVOdFTgOjGxwSTRWut1qA8m4DILMCI26qlpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554408; c=relaxed/simple;
	bh=dsLreS8ezN94+SrkN64n3P0lK2RlZJstgSTHNRSulXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WIFmvJxabYCn0wA4u3qHCxJzLomqTOrbl9pA5gle/iuHzFGYhMgVfi4vWrpWZM0/1T12axZj/cIE0/gDB6XNck8/FnqZLWSm+E3mPllUK193x45er19rJ0JIOla129tyJhrnGeNLD4uJuTBygo8iCnLcELPMugA0nrY6Vt+jWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3UvpkAR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WUoQtnpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713554404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xvzVRZmUmZNTFkVABN5qZ89Paj9zi6AYo3ZioGQPcVM=;
	b=z3UvpkARnM6GbK2ohOkbeK+jgddeddXwhML8BmsCwh/Dd1l6TxqYL81v5ur5jNg1Y/R9oK
	u3dt2mWoMiDomZB13l30O/GzvJxrARc6IB3mv7zBCqsUA7ViMSTjAlT5lIIEgbSipt1pjF
	WmxCMEip7EFA1urgNFYQB2e4w3W/yv45CzrH8wWng+iT4kR04eqJh01rSVYG8BTv1PBox8
	m5nI8N8r8vyF2HRyoLv2t8kUs65XNe6u/2Pxo87KfJHwfQ8J0Z5i+QJAJBP/PecM29wGeQ
	NqXX+acfixs7vsNgyrA4NNGVSObn+eccnjWkMLaEwnSWug/cPPGaiecZmAh2CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713554404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xvzVRZmUmZNTFkVABN5qZ89Paj9zi6AYo3ZioGQPcVM=;
	b=WUoQtnpJQYt7wMAtgqrVLIpk3HAjaICIU46SgCR6UFi+U+HQv6Stkf8hhwc0j21tEbGKgD
	GroR3ng20o/YscBA==
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] checkpatch: add "Reported-and-tested-by:" tag
Date: Fri, 19 Apr 2024 21:19:57 +0200
Message-Id: <20240419191957.42396-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The tag "Reported-and-tested-by:" is used all the time. Add this tag.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..ff44720fcf23 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -618,6 +618,7 @@ our $signature_tags =3D qr{(?xi:
 	Tested-by:|
 	Reviewed-by:|
 	Reported-by:|
+	Reported-and-tested-by:|
 	Suggested-by:|
 	To:|
 	Cc:
@@ -712,7 +713,7 @@ sub find_standard_signature {
 	my ($sign_off) =3D @_;
 	my @standard_signature_tags =3D (
 		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
-		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
+		'Reviewed-by:', 'Reported-by:', 'Suggested-by:', 'Reported-and-tested-by'
 	);
 	foreach my $signature (@standard_signature_tags) {
 		return $signature if (get_edit_distance($sign_off, $signature) <=3D 2);
--=20
2.39.2


