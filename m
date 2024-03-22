Return-Path: <linux-kernel+bounces-111200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0388690B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803A5283F21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BF1F93F;
	Fri, 22 Mar 2024 09:14:07 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658EB1B7F3;
	Fri, 22 Mar 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098846; cv=none; b=qZe59SjwAIZKyhPyOkVybbONXqBRFFpbFHE8sDOC4G/2IhXiU97OkyH6sjH0y5ZU960S/RXCK4HFx9HIvYrqGT3igWy0Yt2WwDqjxhDA4q8Zw206u4Ooe04WFm5y12QM8DH/egne8CjHoFsq7zKM8fnkGeG9Hlz4l47VeJjUoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098846; c=relaxed/simple;
	bh=aTE6zAKVV5uqZysPm/I63UdVchbAgigUe18rr48Hj7Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=huZKAbln+vX42ufja1po6hVLoBhGjSQcRDQ421TNE/Z2htUojlmjsmx9x2y7XQzB4roytn3ptpUqIIKanf7rvrDuumFS6kM/QGeacAiYAhBkjBLNNWmYJvXUSs7mjJHoh7NrXPeYxdSFtQxvHsW2ZMvN1Q8j+9FYkaDni+vMBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas8t1711098743t325t20718
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [183.159.169.46])
X-QQ-SSF:00400000000000F0FH4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 1856326279137474112
To: "'Jiri Pirko'" <jiri@resnulli.us>
Cc: "'netdev'" <netdev@vger.kernel.org>,
	"'jiawenwu'" <jiawenwu@trustnetic.com>,
	"'mengyuanlou'" <mengyuanlou@net-swift.com>,
	"'davem'" <davem@davemloft.net>,
	"'edumazet'" <edumazet@google.com>,
	"'kuba'" <kuba@kernel.org>,
	"'pabeni'" <pabeni@redhat.com>,
	"'maciej.fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'andrew'" <andrew@lunn.ch>,
	"'wangxiongfeng2'" <wangxiongfeng2@huawei.com>,
	"'linux-kernel'" <linux-kernel@vger.kernel.org>,
	"'michal.kubiak'" <michal.kubiak@intel.com>
References: <20240322080416.470517-1-duanqiangwen@net-swift.com> <Zf09VnR2YI_WOchd@nanopsycho> <000001da7c31$be2330f0$3a6992d0$@net-swift.com> <Zf1JEfIq1E1SHiBD@nanopsycho>
In-Reply-To: <Zf1JEfIq1E1SHiBD@nanopsycho>
Subject: RE: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Date: Fri, 22 Mar 2024 17:12:22 +0800
Message-ID: <000001da7c39$0c8eb4b0$25ac1e10$@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFwLs5rgYGClTpBePjvbYMXpqMxXgKXsSFcAjPmTUsCO1Kfl7Hf3JRw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1


> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: 2024=E5=B9=B43=E6=9C=8822=E6=97=A5 17:02
> To: duanqiangwen@net-swift.com
> Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
> mengyuanlou@net-swift.com; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> maciej.fijalkowski@intel.com; andrew@lunn.ch;
> wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
> michal.kubiak@intel.com
> Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match =
clkdev
>=20
> Fri, Mar 22, 2024 at 09:20:04AM CET, duanqiangwen@net-swift.com wrote:
> >
> >-----Original Message-----
> >From: Jiri Pirko <jiri@resnulli.us>
> >Sent: 2024=E5=B9=B43=E6=9C=8822=E6=97=A5 16:12
> >To: Duanqiang Wen <duanqiangwen@net-swift.com>
> >Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
> >mengyuanlou@net-swift.com; davem@davemloft.net;
> edumazet@google.com;
> >kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com;
> >andrew@lunn.ch; wangxiongfeng2@huawei.com;
> >linux-kernel@vger.kernel.org; michal.kubiak@intel.com
> >Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match
> >clkdev
> >
> >Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com =
wrote:
> >>txgbe clkdev shortened clk_name, so i2c_dev info_name also need to
> >>shorten. Otherwise, i2c_dev cannot initialize clock.
> >>
> >>Change log:
> >>v4-v5: address comments:
> >>	Jiri Pirko:
> >>	Well, since it is used in txgbe_phy.c, it should be probably
> >>	rather defined locally in txgbe_phy.c.
> >
> >Did you read Florian's comment? Please do.
> >
> >pw-bot: cr
> >--------
> >I replied to Florian:
> >" I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so
> >other drivers which use "i2c_designware" need another patch to use a
> >define. "
> >
> >Sorry, this email forgot to cc the mailing list.
>=20
> Could you please use some sane email client that properly prefixes the
> original text by ">"?

I'm sorry, and I have  set up the right email client settings now.

> >
> >>v3->v4: address comments:
> >>	Jakub Kicinski:
> >>	No empty lines between Fixes and Signed-off... please.
> >>v2->v3: address comments:
> >>	Jiawen Wu:
> >>	Please add the define in txgbe_type.h
> >>
> >>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID
> >>limits")
> >>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> >>---
> >> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
> >> 1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >>b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >>index 5b5d5e4310d1..2fa511227eac 100644
> >>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> >>@@ -20,6 +20,8 @@
> >> #include "txgbe_phy.h"
> >> #include "txgbe_hw.h"
> >>
> >>+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
> >>+
> >> static int txgbe_swnodes_register(struct txgbe *txgbe)  {
> >> 	struct txgbe_nodes *nodes =3D &txgbe->nodes; @@ -571,8 +573,8
> @@
> >static
> >>int txgbe_clock_register(struct txgbe *txgbe)
> >> 	char clk_name[32];
> >> 	struct clk *clk;
> >>
> >>-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
> >>-		 pci_dev_id(pdev));
> >>+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
> >>+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
> >>
> >> 	clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, =
156250000);
> >> 	if (IS_ERR(clk))
> >>@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe =
*txgbe)
> >>
> >> 	info.parent =3D &pdev->dev;
> >> 	info.fwnode =3D software_node_fwnode(txgbe-
> >nodes.group[SWNODE_I2C]);
> >>-	info.name =3D "i2c_designware";
> >>+	info.name =3D TXGBE_I2C_CLK_DEV_NAME;
> >> 	info.id =3D pci_dev_id(pdev);
> >>
> >> 	info.res =3D &DEFINE_RES_IRQ(pdev->irq);
> >>--
> >>2.27.0
> >>
> >>
> >
> >
>=20


