Return-Path: <linux-kernel+bounces-31468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD57832EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FFC286FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35745645A;
	Fri, 19 Jan 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="r+Gv4n3N"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D656447;
	Fri, 19 Jan 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688381; cv=none; b=ZJF7WFQnb7ydQbSxRje6b9XJr8KdO7VhLEM0x7U7fDaureLDbuLOvvKUDBbXdBKrCjIpi9s1qUjrhN0qnkfZUEullTFtpy4KcpNZkwBNgr5nYbpgYrJbRx4X6We/nxOfQk+oav8V0ktczu8J1grcaRgLBYRLcB1AfSGayIWSKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688381; c=relaxed/simple;
	bh=sBqFdsnrpG5B2aVYepB4f2kUIlIRBbAjsJR6pnILbSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBoOG6DAJ93VdQ9u3dqz4zOJEHGzESwtKZfH8GReX5J52oRBSuyTwY1+pctjInbdOImW+2rGWToAL+IMlyKeCWzdntDhN0PkU1LXD6Wf0WFmRTVp0RdGS5cOPre4eZBpk7vEAc98k3Dzjv4L6fOU0whpgSp3FGv/7UJxeiCujvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=r+Gv4n3N; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705688362; x=1706293162; i=erick.archer@gmx.com;
	bh=sBqFdsnrpG5B2aVYepB4f2kUIlIRBbAjsJR6pnILbSk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=r+Gv4n3N0kqDcshWjM149MnwQbnVFG+pNKS0sAe9hXZRo2ymuTbnngBxSMvBt1pQ
	 5bDmwnP1fSyRHCg8ib12FDEtpefdJkGyKxVa5wNi4NPNSA/heEp1V8HO+yJOdJ0Fj
	 GdOAP35qxYYlKXTsn9eR0LNvVqbdC8qXBW17B4h3cbao8L19co0SgphZ+1jmN5d2V
	 mKh0ATMg1qXXinsxLGbeyVV1/7xSkU/jKbypkYrsrOi6ivm8PD8joRLGZhX4OjCea
	 V7DXBpB8puodWgzmsg0QOcZWpGGhyBzbeDt0cN5f9hFru6elOGsHCRCKxKd+pJYFW
	 Inci3UMJ3Gs7B+6Ggg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MPokD-1rmfbm3wId-00MrKt; Fri, 19 Jan 2024 19:19:22 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of devm_kzalloc()
Date: Fri, 19 Jan 2024 19:19:09 +0100
Message-Id: <20240119181909.7079-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KENkPdNVovQVg33hH+1L5lSU0tTV7tRXp9M+P2HMwnVAPTlbIbL
 PweBJcCplxH72i91i8mgFr5KWChN98onhXv6h0ZIbcxqjjsXvFY+rYFXe8TDQixEbV783cF
 /JdyingxCL0j0rqQzM4f/PWAgV9PNBReQ4Rp0dGAaIBXdCzNNXwmRmJXfxfQdoHBkGFIOrG
 A/amwTK/l8cXqaszrCxkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u/hSC2xNnJ4=;Le7EPSL310H42OZtCq1g0w7KJq0
 OoKMQ1MPvTJ9XaGVPc6RO7TqvN1mqqhQCYYO50EJ4FEXFjfE3MUYymywEheZrOWSp68TtOj8l
 sxzcHXsQYlXkpSVJ3c5Eq/sCul3W3oh5JDZo1aidunFmcoRg191IWxUVFuyq8W/5aN7SLpFWQ
 +oEVidHQtnavFyNenPY7vZsjWWuA53nHJlZ9eAG3A/cpthPciVY8oZ7OMG/5BPRuB7Yss1v9y
 xibpdriWNDM1XW/tMjLoeE5WiLC7tej6nuPi2KyKoAbBlLQrtHI3jBIlC8/9P1QLBT8na6mQU
 2Ctxs5pWuqBMZ8WdF27SexQXJFNPEHzVGrnPokDzMVIWxvHJpcfL97VeiwyD/1UbgVPq8uWK/
 8J5QHc4d0MeXU6YoRgEEz4PGAQY9ISBYNZek208dlC/T1ziH2vNcd65/1pCfXP7pcPafBywyo
 GCsYE/41wi3vE1k+c1b9UXh9KVtC/Jj4Dbm3AS4PTGIHoQ09CwYa3NTlUlTpbOjz5tj98bO7M
 tujTHUIJ/ybasx6GfGObe65n2R2PZYjnTCVrkcztiePLq9Zng4qZrTCZqPso94aQZFrl9dOM0
 P4EcbYPgkQ4LzLYzxjuo/VXfNvnt2aEKHeSTJPyCtqtRidll/4oavaOJktMDOxB/t+gl7uvSM
 dd1Vd2zzyxub9vGzUAfqdaXMBmNWiGjY0UFcc+IaqexxQ6v80fK2b2FYqhQ4cHhf5dR5Gf2pK
 1eecqAOArHVoUh+8SKp8/WDvvvJWIuk+MTdd4rA4cFYg3T4zXhnBUNhkCtV/kkd4tD3LLWxq5
 v2cPlEnaJuDLwrXXeup7U87sgLSSlC6TFU36BIZTkyzEKFQveM/dRwLThoTqjTRnZQdOSnD7F
 egc5kHoBTMeFHZ2t3WzNcm7tExe4woNci5M07XQz77SAy3kFi8493bZ679F3l5Y4PLlOurI/B
 nxzqcpqKBUX+q1QjvniClAM2wiY=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific devm_kcalloc() function instead of the
argument size * count in the devm_kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/pinctrl/pinctrl-zynqmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zy=
nqmp.c
index f2be341f73e1..5c46b7d7ebcb 100644
=2D-- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -562,7 +562,7 @@ static int zynqmp_pinctrl_prepare_func_groups(struct d=
evice *dev, u32 fid,
 	const char **fgroups;
 	int ret, index, i;

-	fgroups =3D devm_kzalloc(dev, sizeof(*fgroups) * func->ngroups, GFP_KERN=
EL);
+	fgroups =3D devm_kcalloc(dev, func->ngroups, sizeof(*fgroups), GFP_KERNE=
L);
 	if (!fgroups)
 		return -ENOMEM;

@@ -754,7 +754,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct=
 device *dev,
 	if (ret)
 		return ret;

-	funcs =3D devm_kzalloc(dev, sizeof(*funcs) * pctrl->nfuncs, GFP_KERNEL);
+	funcs =3D devm_kcalloc(dev, pctrl->nfuncs, sizeof(*funcs), GFP_KERNEL);
 	if (!funcs)
 		return -ENOMEM;

@@ -768,7 +768,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct=
 device *dev,
 		pctrl->ngroups +=3D funcs[i].ngroups;
 	}

-	groups =3D devm_kzalloc(dev, sizeof(*groups) * pctrl->ngroups, GFP_KERNE=
L);
+	groups =3D devm_kcalloc(dev, pctrl->ngroups, sizeof(*groups), GFP_KERNEL=
);
 	if (!groups)
 		return -ENOMEM;

@@ -830,7 +830,7 @@ static int zynqmp_pinctrl_prepare_pin_desc(struct devi=
ce *dev,
 	if (ret)
 		return ret;

-	pins =3D devm_kzalloc(dev, sizeof(*pins) * *npins, GFP_KERNEL);
+	pins =3D devm_kcalloc(dev, *npins, sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;

=2D-
2.25.1


