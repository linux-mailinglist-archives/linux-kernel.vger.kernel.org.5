Return-Path: <linux-kernel+bounces-99129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05F8783BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E610B23928
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234C52F87;
	Mon, 11 Mar 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OEcv+PhY"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1347796
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170705; cv=none; b=uIuqps91yjrWSBflvk0UjCX858+D4Yx7MobgukX35wtL5CxSCQFk1O1HhzRb6wyV20F6I73iV/9/bsj7pR1JURqqvibbUWqThuGczzoYojS0AOIxiXJwrWYVzIbSB0shF4hlJTgMIM7VJY3y7/gUGYE2m6BuAsHD9v2hJqWXKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170705; c=relaxed/simple;
	bh=cCHkeAEUWjV0vuh+yfaK6MzpjAQN3B4EWJ1HtNvhjr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=oakiQRfgAe/udkKnY4XTty+KJaL5c1A7O9bZ8JUSWHI0cGEDlvW0n8fEyxaFkIw0P/dBM4G9B2WliEfxb0CnN1ywH+NSOX1N2oCezrfyZQNVY5vVvQrE5mRhH9Z/BCPM0lxxArJYCDvdC0P8K/9Temer8eotYqSN6r2b4snJLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OEcv+PhY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BB6F20012;
	Mon, 11 Mar 2024 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710170701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHLMM6VOo42thQAgvftidBXfGDSJiFdOugL44M1CGn0=;
	b=OEcv+PhYpbpMG8EzgmI7H8jCQjKaYUvG0gs3XwcKmTvJSgqllCI8oFyOrXsDFX3PjB62Li
	r/+dtsZC4gz71xlDqJA6JhR8XnX8yrNVTO7Xc6UFU2Ja+cZXDVJnQhd7r/JDUgje4U4w+t
	A6rIYwpjMZnM0VIBCbH0Lb2HXfqxRA85MXtk9+o3B268v8czRQzIxvqYfOVieSYNBecKkY
	VOZNGBg6eS53YvAePOc2SWT//SpENUx6KQquaMtHPHcp6F7iDfy16a9GoS7vvqXeiy4dvq
	kK24sGiPq5NEzjFLcsJlndy4dkuHU8go4vtt3RA1Hh3xGu4Sj+iwUc9B74Vb+g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Mar 2024 16:24:56 +0100
Subject: [PATCH 3/3] scripts/decode_stacktrace.sh: add '-h' flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-decode_stacktrace-find_module-improvements-v1-3-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

When no parameters are passed, the usage instructions are presented only
when debuginfod-find is not found. This makes sense because with debuginfod
none of the positional parameters are needed. However it means that users
having debuginfod-find installed will have no chance of reading the usage
text without opening the file.

Many programs have a '-h' flag to get the usage, so add such a flag.
Invoking 'scripts/decode_stacktrace.sh -h' will now show the usage text and
exit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index b56e79060e9f..e8c9976062d0 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -7,6 +7,7 @@ usage() {
 	echo "Usage:"
 	echo "	$0 -r <release>"
 	echo "	$0 [<vmlinux> [<base_path>|auto [<modules_path>]]]"
+	echo "	$0 -h"
 }
 
 # Try to find a Rust demangler
@@ -32,7 +33,10 @@ fi
 READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
 ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
 
-if [[ $1 == "-r" ]] ; then
+if [[ $1 == "-h" ]] ; then
+	usage
+	exit 0
+elif [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
 	modpath=""

-- 
2.34.1


