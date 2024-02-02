Return-Path: <linux-kernel+bounces-49539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C039846BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8817E1F2C4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BE5FDC3;
	Fri,  2 Feb 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YoZ2lFXm"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCD77629;
	Fri,  2 Feb 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865157; cv=none; b=riQEorA23allU3PhvicUklQJtmJSiJI4G/6EQzTFo8w3dfVO3HdMD81jxcfrE6xyIZp8HOsMaGu19uclFqAG2nPc6eNxucZAQpd8g+ZGln+RTcalDIy4vyxjdoC77AFPU6TeijkbxVgmLfeGw4oDayJBnAABzxksb/H7fKouPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865157; c=relaxed/simple;
	bh=PKmuhun5hicJU/NJ+sjbWZRyKiIfaq+KU/2m4Ypz33I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iMyUStjPplLItYOrJ3sdp+6oudTZmjd7uGrpRIEvFKnJLXenOeUBjcBGPTd3AkBpDuBQAvEFpnT/LaU/37zpUpWQ9gwiX3NDCIkRthE0s6D8kr64zUABHgPxQmXzhgMLl9sjABrWHcF1hhm8BiQpuSgsAZxpuU8t9qeR20pZqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YoZ2lFXm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706865133; x=1707469933; i=markus.elfring@web.de;
	bh=PKmuhun5hicJU/NJ+sjbWZRyKiIfaq+KU/2m4Ypz33I=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=YoZ2lFXmvZ2OprFlyHqNnul+Ti7iHoHITbf/Qv0+sYybFDyFPApxcYZgco1NbLrC
	 g3G9qqdg4oXTAQSst/+WjVpfztqZ/wzP7BkvkT6NansAGe0KEVTzOqueONLAHqWbN
	 PBMhCUwEUNV4nZQjn0JBHn4O8QCoIIRmOGD5qTCqiYywWDMXh3HYMx5rDGCQ6yFRz
	 pY7mbX0+aKaAR5/i0JjW2wxWmlNtuYxoTyjR+CtggGB1RueVvAK5/7zN54jaQTgE6
	 rLhBbiSgoKdGSWvYX0C7ZAjsrvlRLqMQfVIgkAwqA3uLr0r4mi+jz9SuEvhpTtizg
	 e0CqsZELpXvnX/Tfag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1qhbb519uE-00pcid; Fri, 02
 Feb 2024 10:12:13 +0100
Message-ID: <b08603d6-cac1-4876-a56c-30c680d5dc52@web.de>
Date: Fri, 2 Feb 2024 10:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_v2=5D_Coccinelle=3A_api=3A_Add_SmPL_script_?=
 =?UTF-8?B?4oCcdXNlX0tNRU1fQ0FDSEUuY29jY2nigJ0=?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
In-Reply-To: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WNCUmyqr1pA3HJoX6TmKsz0s9lqwB4W+ZMqtYmkzCS8cyhcxsx9
 tAQx6sZaiCBtz9m4H2Ox0OhV7tD0tcSninKyEtTVwNLfWbhGiD9JCIPpzw7DW1Q7nvpTbNV
 uTDlfbW8ZxrlscWTyEMoFq2A18KF0AbW71Vg0B/tCYy8nxDzSc/ybeSqszx7OcwAJhzxRgd
 vATfRD6HOZ0v6XQYh43tQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tTVq7jzpR08=;Ye8eBRyqLIxiAqAKtJr7JfjMptl
 S5uHgF3J4FUjCnAwNxEyn/aBm81DuYwi8W4WDjpaq9MydncgDfwEbBXkwJJZJXIeadL7ucYnb
 oyEVtHK8jNzKUpxdk2cKc+UZSGeK1WEpyEwDQFkmTrRf91cvFK5K+5LCmrqfoixHRIcuMTFJz
 bPq0rFrUoao+APs7wVUE0G01IZhoqYfuBkU5oQzmrf6pphelpM09gbupzrgehoXYI/hshyAAW
 lMb+typeC4i1wowqVjWc7DVXJb9gJMxOYRiFHv/i90ZqAftI1siCJHRHQh0Ljj7mpjY9uGPlg
 3J+8N7Fo6hEtq+wBGyBoWR4o52h+sFarmhaqEbHW3Vr3V33HZkpUajN5dUw3y9Dd7vg6w2Wph
 956D0XvJJbVpf8bDxz8l4Ft2YBmd9gXQlKtyIY5HUViKPTDisvsrx6FvtIZNopfQWMQq01KC/
 zpwUD3JKpuVlwEGtlKW+G3dsfBgm13rgj93imZaw8b2eXHrkl0xddxIhvMZGm5fjkjsIZ1Tjs
 I0CiAQERgPGNtTU4PWRymE2o9omIqGE4fDJ8kexA21WqkVbt6bwyxy5gTMoNyuWl1WQMDL+SV
 jbEvFxuWBeol9//5Kp6eIOh5/PpNkitzHq0nJ3rmp1sOwqMRQy2XGsheW8sUyDFkadOK2ZiGH
 JAt0UogtvCoEfkw6zv93QELD3AoB+ZJrrj7FgCeVdBLKRzDi8qIRo66QLPEosp5gV27UCnp38
 cPAnm2qwkYVsz6iAKs8neuRff1Q4WellYdaVot+IakM13/qggfkOu6777fjsZC4DFySQZz+zy
 VAx7rBZAaHem7dtr/fkvyNe9ejqfl7h/N2lz6ROjPi30Q=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2024 09:48:11 +0100

A wrapper macro is available since the commit 0a31bd5f2bbb6473ef9d24f0063c=
a91cfa678b64
("KMEM_CACHE(): simplify slab cache creation").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
* The reference for the previous commit was adjusted in
  the patch description.

* A constraint was added for the metavariable =E2=80=9Ctext=E2=80=9D
  also based on information in a hint by Julia Lawall from 2018-02-17.

  [Cocci] Clarification for scripted SmPL constraints
  https://lore.kernel.org/cocci/alpine.DEB.2.20.1802171531330.2205@hadrien=
/



 scripts/coccinelle/api/use_KMEM_CACHE.cocci | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_KMEM_CACHE.cocci

diff --git a/scripts/coccinelle/api/use_KMEM_CACHE.cocci b/scripts/coccine=
lle/api/use_KMEM_CACHE.cocci
new file mode 100644
index 000000000000..e158e4c7c1d1
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_KMEM_CACHE.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion cache creation
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@initialize:python@
+@@
+def is_equal(text, id):
+   return True if text[1:-1] =3D=3D id else False
+
+@depends on context disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+@@
+*kmem_cache_create(text, sizeof(struct id), alignment, flags, NULL)
+
+@depends on patch disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+@@
+-kmem_cache_create
++KMEM_CACHE
+ (
+-text, sizeof(struct
+ id
+-), alignment
+ , flags
+-, NULL
+ )
+
+@x depends on org || report disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+position p;
+@@
+ kmem_cache_create@p(text, sizeof(struct id), alignment, flags, NULL)
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


