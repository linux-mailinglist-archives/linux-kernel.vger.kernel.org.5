Return-Path: <linux-kernel+bounces-37487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1C83B0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21536B301AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710B12AADF;
	Wed, 24 Jan 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LCDlsrHU"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B112AADB;
	Wed, 24 Jan 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119777; cv=none; b=k4gCQdpV4eWN2orUWiRMgpCg7QIzZgbzsKuO3xBPw4ZuRkKEuK6u/iaV7DT+xiimnXLl7LrFqyjsS141gwKsDNkMlV+h4jMERHhjrV38BzIC/XMjKqKQlbTh5OwDSncERxCJP2WalhptroSxVFHdpF8rGOtUIBRrUInFaZISwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119777; c=relaxed/simple;
	bh=tcaTYT9XLlgub7zVxU5yN++R8fNU1BKmqhWIRrUYMVY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aw3kgHm4zw7nM/z4cN+xkaMNXvYru/esKl5VRQfp+u8UfHqdjgH6QV9UYqTjLtuovXXab7T1J4Ohw8cfFtuIbCZ6AtcrdksiiJhSmt+fehOJg5rHF7HVRtCbXxO/+u+2OzKZV8onB8FiCj4MLqBtGu0qPWVc/oAw1LswpW0epk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LCDlsrHU; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706119753; x=1706724553; i=markus.elfring@web.de;
	bh=tcaTYT9XLlgub7zVxU5yN++R8fNU1BKmqhWIRrUYMVY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=LCDlsrHUztOXda8WecVV3myWPXt97jl6PoJ/xExvT1yzsGkdAt1mFRb3tkHNooiz
	 uPAyoP74GYydQ2M63gcXlmLA8nP2Ue7Hz0/7MQwGvwd+4tA2DK6WPQDKLEKRIm3eJ
	 fN09k23zdW3N24xmyidKv2HwxEH0Lm+dZ/g/OL/9hjbT40XNx4gENLa+UIqzWSuD1
	 LCg5qVFkcuUFLsNUpbe7QOtv3P0hO1bzxTV0ZHdbLRLDyDZNDRNm+Bt6mFmhenWDK
	 cIyrAxVxdsdTU15HAc4ef/3R9PCQhK/Rih9JO/6kjjXhtJYCxoIifmcn7xKgBr5+n
	 w1jQAelrwrTSC9Y+CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1rYzCq0Gc5-00XOul; Wed, 24
 Jan 2024 19:09:13 +0100
Message-ID: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
Date: Wed, 24 Jan 2024 19:09:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_script_?=
 =?UTF-8?B?4oCcdXNlX0tNRU1fQ0FDSEUuY29jY2nigJ0=?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+R+0lFc93rU0ByW3WjO8aNyBaw+zZ0nWeefyndetMWQjTB/K2F
 5Qs9KmaTDM8lc+hBShh1Jsdd9rCRklmtn9O/axOuDeVu6CAQUm+Xb83MeY1hIJNUMZuhQ6A
 UodX6lzF+blrzcYd+ls9CN9K2ksUX2Y6OWtA8+gl9ioK7rn328uTHXrFRrs6vKJcLUP5nir
 Gl14Wh7ywvGEzSKFM+bTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t6CMuhiGozs=;C7xlARAWolS5eb6itI9pt00VJi/
 4CUWvA7WSWEt4RQZgh8ygzv69tSq8oyVYDKOmTMSkOAwHIYXkTrS2Ot9Wa73Ljuf7/8igDyD1
 8g/t1HxR4peObdDVivgVUWq6MZjpvVyvKfxmbzJt5ukjKblOkVJ2hpmIcRrzeND8zwS2J4T+x
 SbFXbqOMMFW/5dlHxHR47CUoSbdCMDrPakk4reRYvIP8DhAbIYNAFb57V83xz5g9h4Jol6OKy
 r10omdKMW2RmVBnkCFsgZVy+HnoRl6WkhSIJRMT1EniNCPRlu0sNZOmvPaGh+FAW5D16NZi+i
 rkn7sFVfHyp43eeTM+2omt7FU5GbLm9IaIcnStBAKNlHdpMqAjF7/k43r7X1wgulsgQrMJKI7
 U4J5BLfXO0puWdufADxxC/8FNJIdsyM5nFYPp57qOCP2Dfx8rMYqSsfTcpImqhb6L3WyatxDb
 M+jEGBwf73Jp28OIbpNb6DJh6eqGckdqHl2pcLWLEUvrf2GBOwx/a5ArRL0GsqQZ6HrVIOBJo
 1u8lly/QZORv724G2EY4F/lcCI0VmfKuaXEGNBw6ADC3DIEzBJCb6bwWdCXCFxcnLqsh3aVpq
 jvoZ6qOTHkyHL+zeWwBV2IRcdkMYhEBPgP7420X+7O7Cf8CsnAy8cS2D+W8rb7YzuTeLl4LUj
 FNEkGDPryls8Lk7RehHRG8+yGBmiu4IFC7dUKnUTS615+ax/MRM6GfQoE3vzx+p1+cAqpn8lL
 E1roYgG0uQ4t7j1abzv3M19U/0s4jBNklFCI2xQVnGUThiaJyd2J6gQ08U6Tkx+ZIc9+t1SsE
 komaH+oOd4NSZzTRWQDKCd7mxTNqhGRsUMa5g6I/XE7teHMqP6J3Mfg4iQ01ZgrUKhx2wE9AB
 J4G2s8//n5uwugciYUtXJeM7E6ehuMxR6u87ZPBFNksMTLmrTXLbFVEplZPjlV1QWV2gLB8uP
 SBd0DQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2024 18:38:39 +0100

A wrapper macro is available since the commit 8eb8284b412906181357c2b0110d=
879d5af95e52
("usercopy: Prepare for usercopy whitelisting").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/use_KMEM_CACHE.cocci | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_KMEM_CACHE.cocci

diff --git a/scripts/coccinelle/api/use_KMEM_CACHE.cocci b/scripts/coccine=
lle/api/use_KMEM_CACHE.cocci
new file mode 100644
index 000000000000..259a8c998bb1
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_KMEM_CACHE.cocci
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion cache creation
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+@@
+*kmem_cache_create(text, sizeof(struct name), alignment, flags, NULL)
+
+@depends on patch disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+@@
+-kmem_cache_create
++KMEM_CACHE
+ (
+-text, sizeof(struct
+ name
+-), alignment
+ , flags
+-, NULL
+ )
+
+@x depends on org || report disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+position p;
+@@
+ kmem_cache_create@p(text, sizeof(struct name), alignment, flags, NULL)
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for KMEM_CACHE()")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for KMEM_CACHE()=
")
=2D-
2.43.0


