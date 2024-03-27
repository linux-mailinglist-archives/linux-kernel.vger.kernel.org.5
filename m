Return-Path: <linux-kernel+bounces-121347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B6888E679
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C501C2DEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA5156993;
	Wed, 27 Mar 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kAxnOBJa"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108713A409;
	Wed, 27 Mar 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545047; cv=none; b=qlpN9atOwIrlmoaBVWfBIBOCRvHOgpiaEfxIT0KZSd2z/tPI6t7cwpsmBFLXrE2oAftrED5Bq7oyuIoBV5Vk93OebzLv5tesNgQXgJMmzW3QRAu3UOOe/GdM6S3TPblrqvMjfCNvQZER/Jk4R2Rz+90ANbhQFvlPjWBG/P7KEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545047; c=relaxed/simple;
	bh=MyBQItI9T6oUNd3jwtJC7oQTKO/65lYY+BXiE3uPndY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CGHC+qid8QISSnnqNs0IftUssNQkZVk0FwcywpcG4dit0LlkKJla1gk8MuWV5z/dUgINkPlySmYpUJKZhb/RC9ltRn10s3+346K65goc8M8VQJWcAR69g7yETK2IpqF7NHLRDuhim+pSN4RFDIUXdjRCTKBq+AaxFh2OL/LtUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kAxnOBJa; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711545035; x=1712149835; i=markus.elfring@web.de;
	bh=DqdtVmEhkl4Nna1V36uPqCzGe+SfZ6RaLtSSk2wAW+s=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=kAxnOBJaDM6eXQahXFstfTa9+kemCOOTLnXjkEU+FWouPd5W/TKMI10SkQOW/eVm
	 AAYYuDznjqKIUdOe84utsz3KZ3W7oaCYw8fTBsqV8S264YAOXrcOXI2JrvgJcL/zO
	 m0Bd23Qcg2lBAALlt6pcoracJJnkQn1jMkfb07VN6I7XLqiQOyTlXz93kB0tr7wLH
	 v5ik0bWviOk8reeHHVMMlCziCIcZlc3llVY5xaeqdVvrgFhPY4cZeXrwFpPhOB2Rr
	 sCoutegslFi8Ov6JQwr/svBWZENSZb8CR+Q9Vtxg76GOc9vOorrGELqBynHJZ/UXX
	 tgXS0GBlFSMBf0R27Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jWK-1sqOoB2vXQ-00vB5u; Wed, 27
 Mar 2024 14:10:35 +0100
Message-ID: <b1d4a52f-4dbb-48a3-be59-8e9915f21fa9@web.de>
Date: Wed, 27 Mar 2024 14:10:32 +0100
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
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_script_?=
 =?UTF-8?B?4oCcdXNlX3JldHVybl9wdHIuY29jY2nigJ0=?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/GsLLolzgh3Wa2AC7CoJ+Uxsk9+136AxseuiGYTn64DzRS/S+eb
 94wDxJ3m9vCw81/NujQP+PwEx2iVtTwH1YnWGe3Q/+mu+J/RLPxUp6oCF3yTXkEk4miqU+1
 BQOH2wqk06rvPBvo5pxvyWevTwTlkG9RZ81z5bWgevzEofZtO4Zi8E9W8BRPd/elPKWwzaP
 FbQOz0cq69ohbPJDA493w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y/bbGx8rh3w=;UXBewfoOnNthhQhTisIQ2qEfgqb
 tT6gbGXsn3szUoSIPIxhyztP7NEajaHuUf1X8KE7Kvz2FvzEcrPdy+iIprIZIIXY1/zLiHbKV
 BNIxTllP9bu1jZTh0DKXPkJVYGIb1P6AzDP6irHg2BzNqBfvODY1zrlDqkR0TROkElMmO0Bkg
 ZAses44mEj779kI7XDunee0tmkerXKJBcoOO0CMYWP/sBSeyhdaHosHjPjEPbgMPHubfbMBwo
 xqpY1n69ZZxayA7xM1rNpK3tPnhxKlt7GLjn1JOa7uRhroknUmcuCkVMstvUwXmYdnhiMJbd6
 ViUd+pvSRHRlsRewgT6HZY5sZxR0pEOO0PhGQijHjdvYjFdvPTKETwt1yKwNLQ3wKHx+BCmCL
 T6FpWMI4q5A55/toXjY7r27M2g73/GwoK1bJwvgaf+/WMZq7/AzbEmGnpj7DgJfskyDR/zuGk
 1R2ueSLDWmAdJ2nV9UacgIpLkhCZvOdAjqIMX1lUhcOhGzT7WN4N2f0w3OHr7VCAcyg1lhJbB
 PTsMFU4h2ss3EV5eAPXQBHRT+99IPQyLaxtxqcWWI3ET/bORItwCkgEhkwNJ8Q/g5IHQDLcMy
 evuB7YIltZnvzlrDK5XMdXJjWjCgzxr9G/c+H8rIFuKPgbYVQMIQblP87ocmTHUAz3z4qh4Q+
 4lP4K6V0JKBZpqd1JvdvJpKYa842HcReern/JhMKkWnxn6qgMrOBIMyqaJenWpECjU+wku26A
 g8SI4q/dkyl85ghlGkl7vkHrmTHjhRgUHutPrAerboglvw+F2m3aLLwGhC/8taggS5RzRaFAl
 CcvUDsQpkMsGaGqUt21rIABkIsvDwaedoY0h9JIdQxGg4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Mar 2024 13:56:03 +0100

A wrapper macro is available since the commit 54da6a0924311c7cf5015533991e=
44fb8eb12773
("locking: Introduce __cleanup() based infrastructure").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/use_return_ptr.cocci | 57 +++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_return_ptr.cocci

diff --git a/scripts/coccinelle/api/use_return_ptr.cocci b/scripts/coccine=
lle/api/use_return_ptr.cocci
new file mode 100644
index 000000000000..7b42a58cceb2
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_return_ptr.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a return statement by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion returning objects
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context@
+expression e;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+*return \( e \| no_free_ptr(e) \)
+ ;
+ ...+>
+
+@depends on patch@
+expression e;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+(
+-return
++return_ptr(
+ e
++)
+ ;
+|
+-return no_free_ptr
++return_ptr
+ (e);
+)
+ ...+>
+
+@x depends on org || report@
+expression e;
+position p;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+ return@p \( e \| no_free_ptr(e) \) ;
+ ...+>
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for return_ptr()")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for return_ptr()=
")
=2D-
2.44.0


