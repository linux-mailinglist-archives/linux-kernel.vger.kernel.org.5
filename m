Return-Path: <linux-kernel+bounces-29410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADF830DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2C91C24127
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176524B35;
	Wed, 17 Jan 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AGiGBV3z"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E424212;
	Wed, 17 Jan 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523097; cv=none; b=onaAigIVE2zWJkOmDENOV1RMO8Jd6eSXJh8Dbc2K3Ymu/6WDG1vhsFzpGPNuzroGQLQXl2kVsHHbF1DoZURQlUKtN8CYnfg2i9TBkGztM8EKkQp7j1wqmnJnSQeM/oEJYz+YCdCQkV9JlqGVgTKO9RHlGQGRX278zmRV8D4Qg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523097; c=relaxed/simple;
	bh=UE38ED6EpRlZY0gaxf7iQTb5dYoGYagkTxGhMebsNqE=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=Lq5XU7QAU0NAFiwfluLQ3/ZUDbDc3ciTxrVE/kAcVHbhUmrMgpQYWi3C9xj5MwiErpjPbfdkje2L3nqfUa4vkguduqn4d0WOfS15/PYdm/SASl34BHDs0LekwYnqZ/QO9Fut7bcdILn2l1pqJu2UL976bKmilmD2wj34mDKjw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AGiGBV3z; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705523060; x=1706127860; i=markus.elfring@web.de;
	bh=UE38ED6EpRlZY0gaxf7iQTb5dYoGYagkTxGhMebsNqE=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=AGiGBV3z1AcVzDaPaFPfPt5DrKaMz2RNGife96dNBIjckShZfAuVkkLo+TEHje4i
	 v03fQnm7PY4gCoJGCJ/3HvCScMZ0LyV5Q8RV47c9qBI1UIHWndS1ZnORiduxi6lIo
	 teiLfz47+xFthZ2wXf4s1zAlESQVYo/5dLg5H0DdMkHo5jtuaK0nEbIKRgrl4gKUm
	 bbDZY9qVfy4pMgua+dIE6nKgMRjRSsVDVo3NeI1NLmkdMrOd4zGWiXa8dBRmtGigj
	 tUv4fyF4XYLSiO/cz27Lnm8lDHYAnTdKo5FfNsuL9283yvQutKeTcFLWIVbmUzpoG
	 7C+dO2eVEYIFQ3PRrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1rFzqK3fND-00BzEE; Wed, 17
 Jan 2024 21:24:19 +0100
Message-ID: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
Date: Wed, 17 Jan 2024 21:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Joel Fernandes <joel@joelfernandes.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, Sai Prakash Ranjan
 <saiprakash.ranjan@codeaurora.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pstore/ram: Return directly after a failed kasprintf() call
 in ramoops_init_prz()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6wzOESbIb1mZ02S49ElPi5Zvo4NveBoF9p3rDTJTlzJEi0YVnI2
 c1ZgYATqL1cTVG+KYL3CwX5YhdzThRbRFDhPMOhtw9CgcHP17D3csESEisOex7lj4FfJQHX
 U3bZEoCEv2aA/ATG+lmudUYtw9hU54INJuho6VcirMAj5atIgPedSgxqxmBzliN+iS8SM3A
 0CkraKfabfS/TkCf1efQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7a0FsOiFKps=;AujlA2bNA0FLb56dO9Arnk6Ehd/
 H52E4uHbwT1X6t+TIPDTZM5jukyM/UEl2kRsA9PzQRREhezlkIdEz+H7TPDIoa9ZzaGkKzSsx
 H1WSDFOWmFd+pgNgdLRoSdT1gqTSeXXUJednLL5/hK2CRaycpL7Llvqjcq6HQ7JtqiZJCFln4
 ef/dMVE9JF+UbaHdJlk/y+mq5F4hEu7I6Fvqv+//ZCAuVJpqxjzB+2aem5ReGFLpWvxcgl7HP
 HkQIAgt+K31oLrIPApIZX/9K6il6s6e6oSTgu1GCuZrftKQqqbBdyMjhOswZcIUIf2P2n0fUN
 sAAIA4e/XYDK4DAH9MD8spSnrcCltumApGI1s0CEkgmFqyAY3VM6JHoC6HRqvNuGXEItIHNMW
 Kvk215OnIUsMO2rHPiEP/GlBfWcjVSdA5gyw1oxHVbMCHM7+33TqGhVVtSfsjnBZbwlUIQHUC
 162ItZnfXSZNjbkYNZDdgu1U94JHF2QXY1Dcz9E9HCkv9CpPLwQAH5nKXUWvWxt2Bdzkx/40K
 GxI9REFPSmkzKxaMQgLQxfN9IeSDg+KugdaN6IAOeSvi1Nw5uepufdSLPPzqyIct3m/ysnC9V
 n6IEnJuzzQ3yvD/SK72NCWa32Ub2ntytgKWVVHNTJJ3cjfeNY0iqPle9qrKpIwzSCoFuNSDmj
 GOifNyEPupeVUfVVPYj7KGRjJk/PC7n6yvGV2pGPDQlRjwxU4wRzb6q9pPQF+xjtytJmsSzMQ
 lMg67Q3/WXEc12Bre5JN+3RZlwyaJkb1fWs7+iwA4ZTp0exTPzKcGYTYDM+VxPXMr83i+TTbt
 1y00b0pt71yxE6Vc6n3Ji1RpVuy/0SWaSiJazkRVwHqw+7Elh3MoKSqhdqZsz5qXRON0yaERG
 BkAEOfbp3v2ae0ZOuS8I4VGXHg4JlH1BC7GxSeTPIv55SsP74N0oSmce8SiikCdtW5pBmqc8d
 +c1z0XMx0X6pPuRtGnYnbjyaGuc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jan 2024 21:09:22 +0100

The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was pas=
sed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus return directly after a failed kasprintf() call.

Fixes: 1227daa43bce1 ("pstore/ram: Clarify resource reservation labels")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/pstore/ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 88b34fdbf759..1a673a4af17c 100644
=2D-- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -595,6 +595,9 @@ static int ramoops_init_prz(const char *name,
 	}

 	label =3D kasprintf(GFP_KERNEL, "ramoops:%s", name);
+	if (!label)
+		return -ENOMEM;
+
 	*prz =3D persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
 				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
 	kfree(label);
=2D-
2.43.0


