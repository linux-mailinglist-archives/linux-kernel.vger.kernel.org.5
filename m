Return-Path: <linux-kernel+bounces-52811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EA849CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F68F28193A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34C2C1A0;
	Mon,  5 Feb 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KLm4V0bl"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF528E09;
	Mon,  5 Feb 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143025; cv=none; b=Gutw9QNlCURSPOOJHV9xhDClhJRvC3cr32OKGedl5cD35hv9ddc74GVVpN0PU7Acx99wCxGPMnn8vVL89WC90zq4ZuklwN5GSwMjR/e29v/Y0k/qflZu2F/bTUykgBGwtdzYSr07teRbx8aLU7dM9GMgPMlXL/sNIAxBrXx8L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143025; c=relaxed/simple;
	bh=dnIBfbHB8ZPlHqVXA+eJYYPip2Nlrn+++FytfzTBiTM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a9APTmotxZnZTdknK1zj+Xr6rW/AvkP516nqGodpA4pf8BfmatBoSYtw1/ZkXuRUQuklCUyzuPgHoLake0PVMWikE5yk39Nek1hEpXtJm1RfUnadWAQ6gLE4tsVK3+i2ml5w7X3AgZyaGTRKDq88quFx4oAAu5n1Xet3T19Ae5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KLm4V0bl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707143000; x=1707747800; i=markus.elfring@web.de;
	bh=dnIBfbHB8ZPlHqVXA+eJYYPip2Nlrn+++FytfzTBiTM=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=KLm4V0blbSMIAGoBSC9mXB8FoGR1shqWQKuYJTqNaJfah9ZXy6C88xPezTwQZ7iZ
	 o08IgUmVlAlGV7wN1RLyi+hIXUzlzlvQp35zt1qBJJQEBcNtcmHMBYgboazVK0emi
	 dicoXgwXol3ylS9hXSZsTfwYnXp1cJjAMemJmTzsn6nUOLPYf9ageVqO//u1bg1k8
	 qXNmlFfBe9xLHTag/LUC+J7H0nZjQ9oafUi3/ud7F8J4MrwwJG5X9VooDKviXMVEy
	 L9NY5TYvDF5h041mtEuN0T/Wp9p0T7ItXjZAu93OzkOArdZowMiTtEnElDO+36wZQ
	 mD6eftyehLbH38lLVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1rjK5d3GOr-00CNRJ; Mon, 05
 Feb 2024 15:23:20 +0100
Message-ID: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
Date: Mon, 5 Feb 2024 15:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pmdomain: mediatek: Use
 devm_platform_get_and_ioremap_resource() in init_scp()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qk9+8YbmEYpkEKxu5CX80yzJiKq/O07RES/6VuICIr0ippZkpn4
 +r0wYvjgmLpZo3rV+cALSmNXrH8l2dLYM5uGCk9VINKHybD8mkHH5LUwB6ktuwG6Vkq5za9
 aXPi+9TgrBgoot1B4GWajqZcqGIPBDYJKMX4gIoappbK/MU0JA2+BYk/eyXr6jPsioXFmDd
 Tuaaz/TxM9fLDgzWwUqKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r9Z430C379U=;ilM33fD4v70mE6uWIXsWyXQKWCK
 dsXZDH6BvRcR7mUyDjiXmJM+hkrFdUWqXEQs0b90wl7rQDuhQt3LlEcSrGTCR6BAlhQ1E9GVD
 QEhX4KXDLu0RkEZC54ydlfMNFozgY4v5Pww5o+i3eOvabToBAR9KPl2RX9NPQNSX03JbX5MaC
 /Ch9a1Rc29+bNhZ2YwMEM8RdjvLXC8+xvXZle598Z3gV9R/U8FF+yATT3KbbI4aiB28yuxvzl
 6kdlXxDSTF5uIv3XpfwTglBBLE2nQwewbptuwUoStSqUzjCOXuMsjDdRj32Y3zcEXxPWqH8pC
 CYltKfBrndxqR8q42dvy3jBuTjjbvR8wrLVQBxb0c/BjlTS2D9IvbaYCysY0E9SHgz+fse5LC
 Ydvv3SJ+JLmyd62OrYrS8SmTZwdKeFgqYptLQXK2IZ1Svxji7PQLePDBZc4/wIfBdyJiQ3yJC
 irmXwRVzLw7EinjgwxuRAijiutU6m9l4uSIOLBL3peBfvUlshrv4QwnY3JfJ0eEJ8+h2InKqh
 PEFKAft2NMmHWimsJQ192fxKgXUxc2k94s11+35g26/1e2U3q2OJaKPYK7pDy07v47AmW0l/O
 6eRr2l0aI+hiIxPcXKg1BTOnBt6cX4odLRItGYCreOqp1Uyqdd2cADTfYVgN/KzQ43KplSqLp
 6GpjXXDPmy1qN82nx3Ppz9jmdsbZwFUirV+3dJRORZzL7iKVpjXJLEhN3zhBDYMRBuaweivKt
 px89WBWS8u6KGQ4zcLICgaZUxS/7nMh+TlXziDHtozxpHw5d7KcwpNJjffvUYiIApEaBXJ6Mt
 43yfxJPG/y4L1Sq0I0MepnInsU8wuAFV2EWGCnz+JVMJc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 15:08:27 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pmdomain/mediatek/mtk-scpsys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/med=
iatek/mtk-scpsys.c
index b374d01fdac7..9e7f0771e7e4 100644
=2D-- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -441,8 +441,7 @@ static struct scp *init_scp(struct platform_device *pd=
ev,

 	scp->dev =3D &pdev->dev;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	scp->base =3D devm_ioremap_resource(&pdev->dev, res);
+	scp->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(scp->base))
 		return ERR_CAST(scp->base);

=2D-
2.43.0


