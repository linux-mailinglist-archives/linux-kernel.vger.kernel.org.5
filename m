Return-Path: <linux-kernel+bounces-13658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E00820A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A992F1C21484
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038061C2F;
	Sun, 31 Dec 2023 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Yka56IxX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A71844;
	Sun, 31 Dec 2023 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704012078; x=1704616878; i=markus.elfring@web.de;
	bh=ngcIJAm1Ej3Lwv2XTWs2kB+R0dxqdh3OvapK6fY30go=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Yka56IxX65Vva7X8yOY2pHaQ572/pOCr1TZLW2keM5A9KcH7h5zZTgl1u7pjS2X7
	 /0COmjiHpRoO8mAvb25HFXC3MKPgkR//zD2HMwdAelhpbL6WEa1Z1lDk973vJBqlO
	 jURWmb6XGy4N6WkgaDj39ynZwYRHLw1GcCrWYyLTRGGidJR6dSMklzHmhhNpvGu7X
	 KOORuwWIEQutgfXnWO1igBqi69XzY1clT3OlGtmnfVmpHZffKlZtINK7zakOMHQzK
	 SQSrVhs3x0yZl9ifgbK0tLZT8M3D1lnNvIhT1T3/epYOMu0ZaVzagz3P206Ey8JpC
	 C0ohN7IfbKeICR0mIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1rHfWg0WEq-0071hb; Sun, 31
 Dec 2023 09:41:18 +0100
Message-ID: <f13fafa9-fc7c-4c95-94b2-079a737249be@web.de>
Date: Sun, 31 Dec 2023 09:41:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] gcov: Delete an error message for a failed memory
 allocation in new_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
In-Reply-To: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kxxYdW4wymw7KpnJNNyv1l1NELGgaOlkuwGrmtORTO/0KZS+Jzj
 Mm65DPw7apHAZzNHOFZ5a4xHhBMsSDvrb66jXX8SxIdXrAtjRZe0Al86QpiqrvTgxMD5MLI
 is9RfZLN6aP9SJT/HRCMmxu1/4ogkvFNJ2RPKSJ1+g2CMKEr9RvkbCSEi5FYAI2lqkl89VM
 iR04gRxEohS4ap1gDwEdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+QbkL5WENas=;KEQg9KWpsJcI5qKxX12tTZfBLWs
 6Y8nqZtw7OWpKjWCrQS1uG3mrIKHA5zyIpnrzQYkOJTyFUUxKCS1TL2I8AjmO0EPCnKjCJ/xv
 r0SW06DXfkM33CVFha3TllRaBalGm6yGrDNG8zKzh3IKrO+x2fc+ppBMixZCwU3hkFbH6nCH5
 LhDkXsIkWpeFy3U4sldPneyDrzz5hP+HSQ4v/2bNgwr1oidVltcDkniwjTm9OZCblvVWVAqyU
 T0ma74LXZXdFkWecfa01v+IobhPk7/ZoyejPQ2Frh7cnRPGgGqqfFOOeAEg6EZ/r4/b4/HqTL
 7H3LeSsAB7Vr15juzEqpgS6nMP0Q4WE02SqOD4t0+50jVjoVQ7+ArgIfUoTw147Ly1CKcx/rq
 vc7fnJLBPE4uH3zzhwPfvs19/8eQiqqLOkNLwmICwGbq1Pv442d9JgUCbr5gnI6/IC9UF9qGR
 IEdIVe/OqfUiPICPuPvYTvg0oRoY1FH+b10WuKQdjwl9JEYxbML5L9nCT25p/U3415NoPk9Lh
 p2GV/4VDKiGgU+cxZGIX17y7WQ+c9DqjOVY8JS/+4h++smiC8w9N9VFxVxUtEZqbpq6xbxQiC
 j/8+LOW0+usZszTsy8z74Msy4eIN6ZvLC5BJBaMNOjgega6EPa6e+iRUR/CwZCihEO9YThE99
 EfjMuFVWErvdGvaL5DBn8z4dzhlPYfA/8/w2O1v31C/I1+VnjC0h70kbYL1TtmmjMRHHjlOoa
 TOh49F48WpSCckyzklxI01YUs1uRDqUDW+7herpNlKWDEPwlG/l1Ly7jg3M3mWUKl4gAbiWIE
 zEL0hCtTNvV+1cNwiONve4/ZEIozzmbsoKgOvVbLm4VzAfOuJ3SaTFwOI8x7tFjQkyE3vxynA
 Rw/f44WbSmcMUXsVYN/VOUhx2tOclGcrm+uaMdrGHYG3Rc3RNTt6H7BEAisIPt5LPtA5y4ur9
 fA2Q2w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 09:09:25 +0100

Omit an extra message for a memory allocation failure in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/gcov/fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 01520689b57c..0fbfa444a388 100644
=2D-- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -566,7 +566,6 @@ static struct gcov_node *new_node(struct gcov_node *pa=
rent,

 err_nomem:
 	kfree(node);
-	pr_warn("out of memory\n");
 	return NULL;
 }

=2D-
2.43.0


