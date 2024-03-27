Return-Path: <linux-kernel+bounces-120175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC188D3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810DE2A8079
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB701CFA9;
	Wed, 27 Mar 2024 01:31:21 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70A1CF92;
	Wed, 27 Mar 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503081; cv=none; b=HX14UsxjK2jnOuBn3Rv4b0/fYhRc/6w2jccIBDN5xCYUPdO5fAUTfaOpWLLshBqvXB7ihmcIwYVT61zqo4ApBi5wPffibl4SgDN/XzZeyTNUJ4jxngQxwgj/nlw+SB1dfNirTWkT/MQuEhOHzKf1KTD9m9iRqmABY+ZYRscaaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503081; c=relaxed/simple;
	bh=PB78qaohyz8M/acpebMaE6FdLWqAdAAntBtk1iJ8u+g=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDqNEoYpoh0lj1AzZSwo/gIBAT03vJiyDqD5qL7/9HfudFHV6Jw8JQwFlyNkS/N4rDGg+tVj1vpQkv/a8w87DIWqo4eOJrjkFzevcBvqyLO5AqfzFQ49KU1rYlectb8WXdNmTknVPQtR7j3MlDe6W+k4XemzvKbPVD1GmEFk1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas8t1711502976t933t54105
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [122.235.142.34])
X-QQ-SSF:00400000000000F0FH4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 293933216363626304
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
Date: Wed, 27 Mar 2024 09:29:35 +0800
Message-ID: <001201da7fe6$3aa37f10$afea7d30$@net-swift.com>
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
Thread-Index: AQFwLs5rgYGClTpBePjvbYMXpqMxXgKXsSFcsgqwUFA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: 2024=C4=EA3=D4=C222=C8=D5 16:12
> To: Duanqiang Wen <duanqiangwen@net-swift.com>
> Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
> mengyuanlou@net-swift.com; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> maciej.fijalkowski@intel.com; andrew@lunn.ch;
> wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
> michal.kubiak@intel.com
> Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match
clkdev
>=20
> Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
> >txgbe clkdev shortened clk_name, so i2c_dev info_name also need to
> >shorten. Otherwise, i2c_dev cannot initialize clock.
> >
> >Change log:
> >v4-v5: address comments:
> >	Jiri Pirko:
> >	Well, since it is used in txgbe_phy.c, it should be probably
> >	rather defined locally in txgbe_phy.c.
>=20
> Did you read Florian's comment? Please do.
>=20
> pw-bot: cr
>=20

I replied to Florian:=20
" I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so =
other
drivers which use "i2c_designware" need another patch to use a define. "

He hasn't replied to me for several days, what should I do next?

>=20
> >v3->v4: address comments:
> >	Jakub Kicinski:
> >	No empty lines between Fixes and Signed-off... please.
> >v2->v3: address comments:
> >	Jiawen Wu:
> >	Please add the define in txgbe_type.h
> >
> >Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID
> >limits")
> >Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> >---
> > drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >index 5b5d5e4310d1..2fa511227eac 100644
> >--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >@@ -20,6 +20,8 @@
> > #include "txgbe_phy.h"
> > #include "txgbe_hw.h"
> >
> >+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
> >+
> > static int txgbe_swnodes_register(struct txgbe *txgbe)  {
> > 	struct txgbe_nodes *nodes =3D &txgbe->nodes; @@ -571,8 +573,8
> @@ static
> >int txgbe_clock_register(struct txgbe *txgbe)
> > 	char clk_name[32];
> > 	struct clk *clk;
> >
> >-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
> >-		 pci_dev_id(pdev));
> >+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
> >+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
> >
> > 	clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, =
156250000);
> > 	if (IS_ERR(clk))
> >@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe =
*txgbe)
> >
> > 	info.parent =3D &pdev->dev;
> > 	info.fwnode =3D software_node_fwnode(txgbe-
> >nodes.group[SWNODE_I2C]);
> >-	info.name =3D "i2c_designware";
> >+	info.name =3D TXGBE_I2C_CLK_DEV_NAME;
> > 	info.id =3D pci_dev_id(pdev);
> >
> > 	info.res =3D &DEFINE_RES_IRQ(pdev->irq);
> >--
> >2.27.0
> >
> >
>=20


