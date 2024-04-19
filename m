Return-Path: <linux-kernel+bounces-152004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C88AB73F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A13F1F21EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD213D297;
	Fri, 19 Apr 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wj6U0TcV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3BeEOXw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D02A1D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565709; cv=none; b=ZBH8ILSddip/9d075dSKDHA/nrAwSIri6j0nTrZfGTDLSbBDTBO+wREsKXY6RHOl5KCtGUNG3pZ8ZL5RbCJ3d01k+Fw8Frn8ouLgY/xJ75VkILqm/YlWqg5j6YGD2SVC3nzs7CRkJ+fh0hrxCNOXhZoCwjw1OKVpqlOjvRtmCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565709; c=relaxed/simple;
	bh=N9ubrqeMRhwqn61y1S3Ns37dwsKRexvNg/kzstQsxKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a+ZBQC0SQaK9mAHEN5bYT0DQYiXeep+29HjRO9aQmBNWy/3m5JCVbAx9kNOaSiAxOvDkjwDAkpqQ1zLrKUkaStZCaSNWh/oSDir6Cv3RkOHMoVK6I3OAt8XqaOU3XsDQwigbbXFT/uR20yckVl8aqXPcWy0Ju90kRhWtcKSSaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wj6U0TcV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3BeEOXw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713565705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9lsnDvMwkCFndVxVxAky0sNQfGRuRjzwSshQ0RUho8=;
	b=wj6U0TcVE0P4Brykt9NO2ArQXXmfMhOqxLxRviizRStYnw/xPVJSDoKGAfFo1MxHHYOMHP
	JQDNOsgW8jv6AmcsmMUAkCvFcJ99r4G2M/AOy0pBFRYRx4Lr94yHVETUf7k9FyLpVNUbgz
	5Ft3un/R6CsJ+hR0lAxVoX3OHRAOEDJ9p+Ri6A/50dBwfPRtF7h0vlABTpCxcOw3YWroPW
	2rGqnSIvku8nA/aw6+zryFXLY3yb+yN8ss3zCF/fSjoOwZ5A65BR6rrirQZu9mU65su+sY
	KRNUkQoWiCMqsnEPXHwHMF9e3yDNvZqy1VaUjldml1IEV73pZSWT+O0nR/9rZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713565705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9lsnDvMwkCFndVxVxAky0sNQfGRuRjzwSshQ0RUho8=;
	b=F3BeEOXwuCrmoYsJuFoLcwd9Q/gVzytmaDpfxPZtANmHvfg7kcRUKT1UnEtKy9jfXfYQIO
	gQCHoEKeS2LiecCg==
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
Date: Sat, 20 Apr 2024 00:28:18 +0200
Message-Id: <20240419222818.50719-1-namcao@linutronix.de>
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
v2: add missing colon

 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..e2034da2aeb0 100755
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
+		'Reviewed-by:', 'Reported-by:', 'Suggested-by:', 'Reported-and-tested-by=
:'
 	);
 	foreach my $signature (@standard_signature_tags) {
 		return $signature if (get_edit_distance($sign_off, $signature) <=3D 2);
--=20
2.39.2


