Return-Path: <linux-kernel+bounces-99128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF68783BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586691F229DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7147F72;
	Mon, 11 Mar 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJaOLTQ2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33A4776A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170704; cv=none; b=QTKTZzCiCfV3TLxFpnFi5dzVPWBnSPsHwYP5cBHbAtoqA2EKMIJPQh4kJr+HiuPMGIi2AIxaYLQMb84cibZaCn+Pez39LvFHjGa9oRD/UqhClgoEtXkeI153mwosgEbePufKtg/dM6LUbH7o6Xd16cmkJMIcmrHwKgwakkoisOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170704; c=relaxed/simple;
	bh=ymon1yWwqDlaJM8D70vqVA6CJA9akSWJQ9LrnxPlsu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=nFk/FkHYxXTcKT3RHwbV4upL/hWSGN1mQqH6znaLZepWRO7MIFidgFSpfxuZjfmmYM3wXoYKJPruEUooig/YmFqEiBdKSwF7QBsywPO+RAAK/tOpwOtmPqICmmh5QET/TuCGJrfEy/zXvzOtPlJp7mzoTi/J4dM8qSA0EpGAha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJaOLTQ2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 792F42000F;
	Mon, 11 Mar 2024 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710170701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=843mOsM8xt7PPp6LR0HKYOK9c5hdfvsD2Mx0jZBABLA=;
	b=RJaOLTQ2KLsSgdVeR6Oku1thjhwDnN8FThYbo5Bf2ydCfwXqMqpSti10OneeKpav9pFgpK
	hloZD73tdqIOkdk7OrwdQZJJNLhP8RjpoT2BBlBI/Nzp2WE6SApi29B/l/TIdOjrL++FOV
	PSbQS3TBddXj805rqZHPZC9w1VxjnWOMmljwXvkUCeNjXFPsHh1kLgRm9v7I0FW6HJj/Rx
	RROv0Frokx4KmKkGq9LOIQ+Swk+bxMuUh6+VB/jNjykLRZr5H6D/j/xoa5DTU5TeGXiiLi
	HULGW+BY6QWNhd8zizCIn0pSFaLuGNz1UzdJ6rzlnbRJ6m1CypfKsUW49nlc2g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Mar 2024 16:24:55 +0100
Subject: [PATCH 2/3] scripts/decode_stacktrace.sh: clarify command line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-decode_stacktrace-find_module-improvements-v1-2-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The syntax as expressed by usage() is not entirely correct: "<modules
path>" cannot be passed without "<base path>|auto". Additionally human
reading of this syntax can be subject to misunderstanding due the mixture
of '|' and '[]'.

Improve readability in various ways:
 * rewrite using two lines for the two allowed usages
 * add square brackets around "<vmlinux>" as it is optional when using
   debuginfod-find
 * move "<modules path>" to inside the square brackets of the 2nd
   positional parameter
 * use underscores instead of spaces in <...> strings

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 7f3fb5e82707..b56e79060e9f 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -5,7 +5,8 @@
 
 usage() {
 	echo "Usage:"
-	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
+	echo "	$0 -r <release>"
+	echo "	$0 [<vmlinux> [<base_path>|auto [<modules_path>]]]"
 }
 
 # Try to find a Rust demangler

-- 
2.34.1


