Return-Path: <linux-kernel+bounces-79972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A72862910
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273F51F217FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D98C07;
	Sun, 25 Feb 2024 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="g7oQi2Lo"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E808BFB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834084; cv=none; b=kmvH3J90Uqro/ogzXWklmcWZhlR6PG5NJx9pxOZyxfE+ZS95vQugt8rebPSh13NOBmO/diMfreOnBMXrDUeG4OimqZxLu1hfNYyNNbi7jYS3GU/9V8fINYb6IKXhKKZb18hRKJ4y+vkl2Gae23Henl+YmMBtKayfuxuZvDbxVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834084; c=relaxed/simple;
	bh=x/f9hZGAQVRLuG2BwE0elvw8ixnOBltGJfsVT75HSnk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=efhg1OcyoXPvSVXun0nvY2dGKk6FUIojD1cXrPn0abJ8NWgid09SYjrK1C1y0K68/ey5CLEFLsPIwMmFwOltWF04dgSYLtLQ40ajnqU9atTMc2ktx5lPg1bFY7sAtq/4JWgff5JHllGhSNCHkKXrlx/JzZD7cpDPTtJHK4gY4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=g7oQi2Lo; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834080;
	bh=QzjzGYwHl8mJJbJ/GLAvGi7Pny0jhSARgE05jH5zKak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7oQi2Lo8n3LChx+C58v2YnIuB78Z/R12XvbbRDjg1mP54HjM7ArkYGcGCBLDdk3N
	 +KiZiHVSrcEgkFBDLqepLY/KmuMCKmMZoVfwwcjv15OlDJrj/CEh+umwNbBSbV8LHu
	 +rklxbdmPLlbH8dYRNySJLgC2OXv1BI5CUszT91U=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708834068tyhcili55
Message-ID: <tencent_AA60553AD4DF41859328E9CACC367EFDCF08@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBn9jo7Y+wGMHn4Cejd+6lIIpJjif/4BEgTLgOjckXFcGjoDKyz06
	 6eeI1CQqNbfXL8CQbXRgrGSpgIigpvFhISz974yeFiJ4tkAvBnYtN054XczNv0h6lXBlVfGenCej
	 NYUjMs6RP1parsO18wchR/wriSfnHPGbUKhYC891VybbdEGL2N4K2bq0z21+p6KDJLR6m5iKy0hW
	 PLlvSRXg/01OrD3pPKvCc1+XVW96crg1eLY9vLdUFAWa9bp3U2mRz1Wff+fayfuCQXMaEYo1Gbv5
	 2dpFD5lZkLllWmtV7Yjh6sx00GamhJSc2vOSsHaouyceRp1cDwAlfkmHSIcNaGX9+yXK+AYmnOdc
	 2IUFaCEcKGxXcEaFEdWdV5c1JdFXUgV62NaYQQ0FVm5m5nV2JQh5H7TS1K4Ugy4D9pEmlYB5t2kt
	 nhJ8w7ytVjEvGntmN8nRDQ0EJwOY34/TeNagW3AieKV/ytPhIahX6IhceYccKneKcpiYPCYyrgN6
	 k2hdPVSj3tz8X9lT/NPnUUQlBy0NlUmSiw9tV3RgfAnO1RW121D7C4x3VdIEzbOB4I3ra/wOr7Va
	 nZj1nDb7hD6l2RGMb5NxM6rT3fMFdDfW+BFqU9t6zqbLEbuB9aZBh0HPyOyzml8ILG37F95nCIBh
	 dJGIyMUdtrnn2chinEzdXTWxIEdQf02kn1ZB4Oszf0tVHWJalmovGCIz2aolmIpVb5yGmoRkSccJ
	 ILx+vhS6MWE2cEmngRbJk8aPeOpRLUryk6z/4C/01/hVrpfwIhHfe+Wsn/Q4Oa28zRsQKVLqG455
	 dJOOFf4w1zQJHk5BmdJ0dBGjQTZzFoQ3eiQbk+crZjDAkZLTu9W4/oZR3M/2L09GKdP95woSQQ6O
	 /2aV7g8laid6ADavbhnqZaMmM0Kd6IG4zqbFWPYrG6D4D0e0yKBE6CV+qtZ0URRyUHjOc1BuEWNU
	 lPubllW3fUEMwCtcRngw/Asj8z6L/2vLb+fZmZIfw9Eeds7dkvI0SPB1YutY6lIVE2H8tYl/QH8m
	 gcBRV9zrVzcLKDsGaUJ3C2nPogoFA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ucounts: delete these duplicate static variables ue_zero and ue_int_max
Date: Sun, 25 Feb 2024 12:05:38 +0800
X-OQ-MSGID: <20240225040538.845899-9-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variables (ue_zero and ue_int_max) are only used for
boundary checks and will not be changed, remove it and use the ones in
our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/ucount.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..05bbba02ae4f 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,17 +58,14 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static long ue_zero = 0;
-static long ue_int_max = INT_MAX;
-
 #define UCOUNT_ENTRY(name)					\
 	{							\
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
 		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= &ue_zero,			\
-		.extra2		= &ue_int_max,			\
+		.extra1		= SYSCTL_LONG_ZERO,		\
+		.extra2		= SYSCTL_LONG_S32_MAX,		\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
-- 
2.25.1


