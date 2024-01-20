Return-Path: <linux-kernel+bounces-31830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD583353E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124F1283E58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881E10788;
	Sat, 20 Jan 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="a+J0bbi+"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608F12E47;
	Sat, 20 Jan 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764347; cv=none; b=DHuE42FqXB5QLoCGSughtsixekL0ATyOjZVOU5iEbJm54lUIleIfeg5H4m/V6QceyFgwmicxjv5FpC3YjF+j1w7dJg/Ky30fC6nXzAxlpToBk2a0VQDE+5tcS+d2LwSF3rAWyqRL1m0sG/IkycHDTIzqPsH+7D5QLkKab5UmK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764347; c=relaxed/simple;
	bh=0JcJgRwF76wGIs5To2XuhDLeUD7IzHJSy+e2cc+KXys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZWOdEssB/ovMeQgzQMcQcVEBrpEGooJZcz0q6AZi3Df4jRNcsgzjQ5hzX6Y9AH1kqV3giJbCE2rHo93oo/j22VWbKtjrS1YOf6uqvlJeCRm9nlpAtDq+rTmE4xctJXH4/hnmguaGjhYs4aGfWrJqr97Ms9aRVZkuJJlWVrEU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=a+J0bbi+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705764333; x=1706369133; i=erick.archer@gmx.com;
	bh=0JcJgRwF76wGIs5To2XuhDLeUD7IzHJSy+e2cc+KXys=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=a+J0bbi+NsDjv0b0ocCwCIWY/37ZnhbzPAf5hYXMlAvFmjEPWUcDi18t0N6wUsC8
	 QN454ULVBTCAYoj7L6G/yEWDEvuoOnNjONtkeEjqcAjbUS2h6ANeoehuqVgDLZIxU
	 TELT/VVcdZFjhQM00WLHZtaKnq8sPvWoX9OrfcrqS/o6r4Ezqqo6R+aJmCriTlxIr
	 XhEPiJv3Jlj3uh66h36tlKC7fdPTMxmk4zkOz3a0amhakJnKCTR8GBq2vrpLaOShA
	 ZdD77Nf4A0XrRvB6vTb+2VHxUZR+qbhmdHg6dsXkb40AD3i/L8eF/hn0pvTqPpP1X
	 4CZHGhyuallkx3iHcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MOzOw-1rm3zl0sIe-00PLJ3; Sat, 20 Jan 2024 16:25:33 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Erick Archer <erick.archer@gmx.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 16:25:18 +0100
Message-Id: <20240120152518.13006-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:krwpxKzuxrjKJNYG65YRp+r0EkkR1wBIMU1g/OgIxutkIvqq0Oy
 mZ64rNHG3mxwru5Qg74zFseIO0kbYKg68tGcipBH3oOCo0v0eP8OfOwt60nODjBS1n4Ajj6
 h9tE/I57lr+PfQuoKDdjBiw69dpYvjtOSU1cY/JKLvuDhZucSb+0HKijrDEwdzTQI4XVfm8
 WU1YTuzwqOA1qtPUBq+Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zOxPMh2inqg=;dVBjcptvjRaTcfEepMXErcxwZ5J
 GXQ+fZoR/t5YkQ8aBHovvX/vu751QvIbidTUF018n6kJF5vcNkTZXxpV2kFGCwxCGrncHqi/H
 fUWnQPwFAWrFJq1ruZt6du8tjk5MmKvmhYZAZclNID/KtJuxA9TOr8iAJxIs2Lr8FoJCdsyYH
 BcnONdX2PValbcfleEofllWvCrfPfM8v31J5bwpeci1wGXBR0FHyOdpJLhPsfoKfpr9i5Lz4O
 VxkD53Uzco2bicd80nGcRDAR93T0VAJkG4k3Yl4FUEzr0F/oYNn/Vclrw2EvQVdEMyfUBq4My
 ZCqFlbBbt7Zq6CAJxH0e7kb+YcyZEPhZQG4hYbgZQ38TET0iJds6yITyZvMkt2UvVU1PTGryu
 1rrArB4aKTN2y8I8LbMULpehbgZDl7YkAFX1JB/0xy5GuSOYTlQCgFo//2Rh+QotMBuCgMSzC
 2TQmWi3Zj6UT/Z4YSaRVQf6WRNZzVNBkLV5zBgTjFq50Zf2ncJWeIWB1tBhnb+1znaUhNDw4/
 KLZlfslgsg8TXFNvMUuud+vlvfNK/eZ8AqmSucDgy4qpboQf+Aj1p7lTTYNwRyESgYQtoMzLF
 zljPYDW1v7X0Hjaco58FUx7WaMHJ4vI0KnTh42Moba3c+npDIbfLBmquV+FKclXx4Nv41+er+
 n+DxTDIQDFGrmMCNGmYRRf2n2JaSq1ET+l7uyWjpyZWh12GceurwmAaIYvvKM811oVI54QtGp
 YVA54V0Q0GBkrBeDctPYK/eVsYW3qaYmm9iguwC4lsVGTDCaGxF9P6uibznR2NroiqYa7RNy4
 tlE3eEVOdCCauwH2dh6ahnlpbRkQPkuZBEZqnlbzWLTlG5fwCnTuZYEVrisLYgGVZv3t40sd8
 FN/aUoBj8VktX+Pghmief4gH0FS0O1xnbInUUnjeIKniaC4NzSvfD0VDbydFwtYk7gnNek9SO
 5tWhdeP5E5RqvhfAdX82TNnbm54=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
count * size in the kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/bus/mhi/ep/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec..8d7a4102bdb7 100644
=2D-- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
 	mhi_ep_mmio_init(mhi_cntrl);

-	mhi_cntrl->mhi_event =3D kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_c=
ntrl->mhi_event)),
-					GFP_KERNEL);
+	mhi_cntrl->mhi_event =3D kcalloc(mhi_cntrl->event_rings,
+				       sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
 	if (!mhi_cntrl->mhi_event)
 		return -ENOMEM;

=2D-
2.25.1


