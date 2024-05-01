Return-Path: <linux-kernel+bounces-164938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A640C8B8541
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61157283FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7A43ADF;
	Wed,  1 May 2024 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PS2aASDV"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C51D68F;
	Wed,  1 May 2024 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540460; cv=none; b=LeeoovMrAL3sy8Ebh0idhywLrN/vx81h0Kj6DNQVCCoABqr/08BJdeb77srvgWf3Tpoc8k30U/cc3xku0kt7JXemIsEO3gK59sajHLdyMg7KX0wO6/ToXRRpkoKuafe4vo5hGDmcxeTKkKocBA0VLTJOmmH55vt3hz4wfzuISIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540460; c=relaxed/simple;
	bh=RMWyAyYlUlSp9U/kE6nFI9ssssdGhoQ6D+bwcNf6+fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4OkQm8zlTVfoI+lUbx40mEpn7PWBC9D6LX63QYrEAJ0TqvY9LjbMq0WEflSq+xGe60o526sbUKNn/mTVWkD2kYJsvXg31IVWJZxnvXR5zipklcpJ709/mDJ2tTepkuKyWzky/UjXuyPQ/jQkkY5ofDchiseNCHfK5Xbyj1s3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PS2aASDV; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 229estbE3rs7M229esvot9; Wed, 01 May 2024 07:05:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714539918;
	bh=X1z/GNaSSMDxojxmVN0YxGfbCezIrv1/qyN8UGm7TgE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PS2aASDVNpLMOlRQ6EseNQ4ojnelR4JnXF0fuFJLIQdROzbT2X5jB2I5boEh12y3u
	 YoAqw1DtZPnSRkmbp1x/SZFexfGOW1Mj4S/2LVquZTYvFXbBj/A/iv2ZY2rpXSzMtw
	 ZCGL/KF1QGpghD9W40HGjdh0qaT25rSaG+dGyIlpUxmd5gMfE2ZNwXYM44uWx3oiA/
	 15NpG/dlq82E9YiK5yeyN1R8VgPW6dK7/8F1dj1vZCBrvxT4+eDXlHd3/0Tq12uZHX
	 zOml8gQVz5+Y89aw26IXU8/QQE8X5ENR8DQs+/A2ixDRyhWPi+hRn5GfqepXen3MFx
	 asoAR9ryPtFoQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 07:05:18 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: da7280 - Remove an unused field in struct da7280_haptic
Date: Wed,  1 May 2024 07:05:05 +0200
Message-ID: <ac251b456933bcc6fe297b738f9304bd259185c1.1714539865.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct da7280_haptic", the 'legacy' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This field was added in the initial commit cd3f609823a5 ("hwmon: Input: new
da7280 haptic driver") but was never used.
---
 drivers/input/misc/da7280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index c1fa75c0f970..1629b7ea4cbd 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -230,7 +230,6 @@ struct da7280_haptic {
 	struct i2c_client *client;
 	struct pwm_device *pwm_dev;
 
-	bool legacy;
 	struct work_struct work;
 	int val;
 	u16 gain;
-- 
2.44.0


