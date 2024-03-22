Return-Path: <linux-kernel+bounces-111119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C60886825
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE911C23F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84B17566;
	Fri, 22 Mar 2024 08:22:31 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F67168CC;
	Fri, 22 Mar 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095751; cv=none; b=El0mWLgzCeYHJmLcYgPgjN5dPyna5duNw3t7a2SyB6mAQPFz+bcVmHucXp99sA9XeVlY0VDy0dKFI9d7FGAz/GMN2vm3jMRq7fncKjDzSBetQMAKhUE+4Hjr32DGG2p8WZpD7PVZjQfy8Ew8bfFCr8To9yuJRfMQzchAI44YQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095751; c=relaxed/simple;
	bh=/JC9kH3/GXHoXGUSw1qcqJheDHHcI3KNF0aeQuH77fA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEqnz0Ekju8LM0/5cwY3/ukrTwIL2ooQQcOJ48cyhGe6xQTNN0ss2/aOttbwq+avPjVRj0JRfDzA/omnQd2aBf21ndzriflHl7KDyPkEfhSjJ2bPqdtU90RC1ziK8bL+JaAQeeI8aStGOp2h+TYdAtztR5tdbNb0XfietbdGVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas48t1711095605t408t26085
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [183.159.169.46])
X-QQ-SSF:00400000000000F0FH4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 11884217184907262476
To: "'Jiri Pirko'" <jiri@resnulli.us>
Cc: <netdev@vger.kernel.org>,
	<jiawenwu@trustnetic.com>,
	<mengyuanlou@net-swift.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<andrew@lunn.ch>,
	<wangxiongfeng2@huawei.com>,
	<linux-kernel@vger.kernel.org>,
	<michal.kubiak@intel.com>
References: <20240322080416.470517-1-duanqiangwen@net-swift.com> <Zf09VnR2YI_WOchd@nanopsycho>
In-Reply-To: <Zf09VnR2YI_WOchd@nanopsycho>
Subject: RE: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Date: Fri, 22 Mar 2024 16:20:04 +0800
Message-ID: <000001da7c31$be2330f0$3a6992d0$@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFwLs5rgYGClTpBePjvbYMXpqMxXgKXsSFcsgNHLUA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1


-----Original Message-----
From: Jiri Pirko <jiri@resnulli.us>=20
Sent: 2024=C4=EA3=D4=C222=C8=D5 16:12
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
mengyuanlou@net-swift.com; davem@davemloft.net; edumazet@google.com;
kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com;
andrew@lunn.ch; wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
michal.kubiak@intel.com
Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match =
clkdev

Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
>txgbe clkdev shortened clk_name, so i2c_dev info_name also need to=20
>shorten. Otherwise, i2c_dev cannot initialize clock.
>
>Change log:
>v4-v5: address comments:
>	Jiri Pirko:
>	Well, since it is used in txgbe_phy.c, it should be probably
>	rather defined locally in txgbe_phy.c.

Did you read Florian's comment? Please do.

pw-bot: cr
--------
I replied to Florian:=20
" I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so =
other
drivers
which use "i2c_designware" need another patch to use a define. "

Sorry, this email forgot to cc the mailing list.

>v3->v4: address comments:
>	Jakub Kicinski:
>	No empty lines between Fixes and Signed-off... please.
>v2->v3: address comments:
>	Jiawen Wu:
>	Please add the define in txgbe_type.h
>
>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID=20
>limits")
>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>---
> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c=20
>b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>index 5b5d5e4310d1..2fa511227eac 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>@@ -20,6 +20,8 @@
> #include "txgbe_phy.h"
> #include "txgbe_hw.h"
>=20
>+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
>+
> static int txgbe_swnodes_register(struct txgbe *txgbe)  {
> 	struct txgbe_nodes *nodes =3D &txgbe->nodes; @@ -571,8 +573,8 @@
static=20
>int txgbe_clock_register(struct txgbe *txgbe)
> 	char clk_name[32];
> 	struct clk *clk;
>=20
>-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>-		 pci_dev_id(pdev));
>+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
>+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
>=20
> 	clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
> 	if (IS_ERR(clk))
>@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
>=20
> 	info.parent =3D &pdev->dev;
> 	info.fwnode =3D software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>-	info.name =3D "i2c_designware";
>+	info.name =3D TXGBE_I2C_CLK_DEV_NAME;
> 	info.id =3D pci_dev_id(pdev);
>=20
> 	info.res =3D &DEFINE_RES_IRQ(pdev->irq);
>--
>2.27.0
>
>
=20


