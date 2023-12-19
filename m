Return-Path: <linux-kernel+bounces-5416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74947818A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E00B217D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6A1C29F;
	Tue, 19 Dec 2023 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZypYJml5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1291C688;
	Tue, 19 Dec 2023 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsNYO6pe3lbDxarJvDo7Vy00YwsQKCRHlz2FZ25JdDWUCdlJm+Aktp9+MXReGWdMNoq0Nmgw/rAtZnhAR7HQrqQG0NHDq3cpZHfH88Ew5Yl9C56cAELn+0Yl1RUUP3npBQ4D4S7fdmD1D+I8StQRwZi5DeXRRj2AZpBMGmE18saNu/HdQ3BPQkRtGGdV/JRA3MYi3F7Uf0HeKgX7XISsTk11Ug+XoS+QPy7uRPeWID3U9tBMi+Sj/7AafjNbMeLwutscAEK2xkuJ2qCSr3y6xmkk2uG7OB7OVvY8F3aDY54OdBhRWPpL3Dj56kgju445QAui47gvFwEHlBXKlFZOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa2AV/luowHoGs5Za/2ij5Qm+Hqrklt7u8xdy2plP1c=;
 b=YsA/2cu9y1Z8PDSbp+Jnz7zGBIYqyor7SD19ejpYrc3Ssf5CKZgLAqz1W6ysjNmoVHPKSa/0svArad0lsx+FoDEDjfdZioRoTrMF+IIFDDwoxlWAOOkDSdq+5gPoEII49ab4i8dnK8oU5uu0994K9nCAHWEjuV2o07DxTQgIxSViYZOmcEb7ZDuGUQbFqYkyVn4HIvXbv/Kqo7xZ0F7mDIZXlmXkHRGJWyg9BzjePDn0paefnV1axdTwEvR4EesFKT9VN1tbrubu3FgFed79sRnlRFNdYdG+XNle46MWNzRyd1MnxrIJtRY2IFn/59iP3iwWMJO9zFYCrdypxQZ1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa2AV/luowHoGs5Za/2ij5Qm+Hqrklt7u8xdy2plP1c=;
 b=ZypYJml5bBOltsWOWBYJOuzeK4gULT/O7W5XYtRSw78J5tyIA99EEDQtoGAp5KMx1NVN9my27TmJ9+4kmWzaDcczCtns1+Y1NsUBynUvZwYXQaa4MLQjnWSBRpnQEDY6NLVW0H1Yy6EzgCGT1BdJNP/WU5R+gQqsH4BOBqEP3u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:53:57 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:53:57 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 0/9] Add MACsec support for TJA11XX C45 PHYs
Date: Tue, 19 Dec 2023 16:53:24 +0200
Message-Id: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 971a3b6f-1a5b-4475-389b-08dc00a25377
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eyr+APKrAsIf+KRURz1NCLByNs5mACw+PBRujDLjrHBfoiSU8ZdcSO5TB7yywCvLqsGkCrmDpZ8317A3IFmjuLAe6l5NnPzej8DmThaFnEkwUeSuy8kbK460OHBSsB+X8FS0PwwoEn3fruxDHd6AczDSAys2pUYYTdt13UxfRkvLK7eYiMlZ5k3C9wxqmansXdz5vdLbzlo+WP22673bjNy9J7asBYJ3Ur6grJEO04AN/T310SDnNCm8fTDnFcmqMMNX8JQHFNHv/Btq5tAGBx1pLcGP8Fk9o/r/AWHEF5kt/5e+rI73rANJhdmwFlR1WwkOiNXw35A/f21DpIc5erIOmnkNOxFfiTTbA7inO7Yhtys4iTBJjzTsWxEs5g5WrTQB94joU8yITF6dcC/TxABwCGus0QIX9p+lhVs0cMjlfFLIL58rE7ZcKnMuw5HNEsZPbwlA5M7VEzoKkV5y4zqRMH2z3WIvjs/LtcZqQdisTb/i+e+gxd0YNUQHBoteO2fqkIuu+Gqs0bPs52IdVyav2GfgxKO/2Bx3584soqM/mAOS3u/CW9YVSFtEZG7MpRhArljpt35I/Wn7hauiwoqPxWMIII94DEhfvFg+4GYrk3OPzEL5Qr8j8/CKU6kG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(478600001)(6486002)(38350700005)(41300700001)(7416002)(86362001)(2906002)(5660300002)(26005)(6666004)(38100700002)(6512007)(6506007)(83380400001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3mAfeSZIPFJOZiuEgj+mHH0gGKVQdthabJNOkm09/y2BU0UWTrxyzuC/Ayf?=
 =?us-ascii?Q?SYZwVmz/ZKeuyf5MTKYkVfXQIyUUBZrVoT1k7rc3Yg2alc9EFB8ud8CAKfv1?=
 =?us-ascii?Q?0YbqN3QuUAfPL/hQdGl1vfNqoISXNFztxlHEg2wzQXEUKaL567Z9PajdXrhS?=
 =?us-ascii?Q?x+IVbSzIkiPyxbUJ8/jtNOaVgKz4/Ke1uioY+FCGMwt5mWLWW6hNX3Q+nD3K?=
 =?us-ascii?Q?5daseL99LXf67JH8pVUXMvMakxu81is5Kpg8ntaG42qcXgFcWBsC8UrgqAD2?=
 =?us-ascii?Q?ulBUpg7sBqcCxpH/lv+4Hre3RQfo4pyoVjFcsILtdqGuuYuM5YbXFIuZ/sND?=
 =?us-ascii?Q?AhSywM65garrY4HvjCZH9nLgGmo1q9q+/trxrgb0KHThPhhzYEiqj4RaT3Bp?=
 =?us-ascii?Q?kfu01rHjvmpS60RnWuMUknii/pvcCddVrjHp7cN6rjyMyqP3jZAf6AW3s34N?=
 =?us-ascii?Q?LTqFbl4RX2A7vfTvvblreRK4jTg7xJbCTkHL3kc4gKQvSR0trIiQ/fY2Zezq?=
 =?us-ascii?Q?hPDBtvqDdNZdlQvqpzYjljqRuujhcF/ZWLXXaKoAdvD4iMulMtLrPgBBAKWC?=
 =?us-ascii?Q?I42RqKA51BiH+Gci1aoXCDjk9b3wClMfmurxcnBqHoXhtviu1ZQQ7WJThNRG?=
 =?us-ascii?Q?5ylJ1WYd0RqHdotGkd3enM2hEK1MrTnM1OOnXnlGLqt+PA7rRR7TntrQli1M?=
 =?us-ascii?Q?IOetzk/Zw6ZYmJR966lCDu/F4dPvwa9Ov5imF1oOy2bNuLpHDuVr15EfT/pi?=
 =?us-ascii?Q?2d6Y7VC2/GZ9zm0d8NSkmvAdbypqzO9GZTcd6gTtK5KpsSqt7UR9HAR7KoL1?=
 =?us-ascii?Q?9O/ATO/u1t3t0iXFTQuexyQOulgICZ79V03hPwaCHmQKbd74O4j42KrSVEGL?=
 =?us-ascii?Q?ulypuI73PpWQzSHhTuKoUFybT8mZdEAEkZ5U3soM0Q/DOVS7KdZU6oSOxVp4?=
 =?us-ascii?Q?T8mo3BsK44pW31vyQZixTmXw9w6jKEMwV3hUwqceCqWG4mC4DCjYjgVT+ArE?=
 =?us-ascii?Q?FzGktUtKFaL+JmKy4iJkn8Q6YP/pdj7qY/n4Me3o2yZ2gTCDEIBroMJWngHc?=
 =?us-ascii?Q?jpZNxsOr654/gDJ5KImceu3XSRet2PTjDSdVFPPhDB/qnZ1DYyYmTfOaWzY6?=
 =?us-ascii?Q?Qz5x8BNaPfYJgmxs7Upy6MjpItHb9FVN4wIj+tbQ3eVPmUrhOvDWfyxDA6Fy?=
 =?us-ascii?Q?zDd3qEmMbt4UwL+RgZ3JDvQW2bPu8tOLalWZMC7KknktpBrjgCORB+YPLHga?=
 =?us-ascii?Q?AJVZXejaQxtzWZZYScVIB6B5u7p/dHU7nYdzmiEgJujMIWJuhcNEpgmOB4g/?=
 =?us-ascii?Q?Fpc5j0dIBqKlK+lL0BzlPQaiLN0JW9+A93gXxabY/z5OJ572hUvflT6w7Dv3?=
 =?us-ascii?Q?7eo2rs6CbT9ph4AdRMshtS25h3zwfcOnzUSiKRQWvjpQmklD0Qar0avUS3RQ?=
 =?us-ascii?Q?EE1f8cIolIS39lJDufKxfNDSPgm+Tx+Gk/NrjoW9XviuzHH2xFmssRNJjAbl?=
 =?us-ascii?Q?aNFRug/fGwkbyz2P3XvyKc08CMf3H6f5kf0PJ9iiEQNwTlXFOdFOvAX6PPZ9?=
 =?us-ascii?Q?onvo8mXpLcqjl692I2g1Bcfw+vK4X4anNug90peH7KSWKvvSmIg+zTp0Oocv?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971a3b6f-1a5b-4475-389b-08dc00a25377
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:53:56.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abt9QatusVAZB4p7IgceWlCZOc6L7Kv5Os/Wrad6A6vYUH1rK9L8D5qHhw6EA6NoLKkiuhO9bNpvhN9/EVvHuThKNRu7vF6j5AnE8WEnrJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped.

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

Radu P.

Radu Pirea (NXP OSS) (9):
  net: rename dsa_realloc_skb to skb_ensure_writable_head_tail
  net: macsec: use skb_ensure_writable_head_tail to expand the skb
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: revert the MAC address if mdo_upd_secy fails
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |  151 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    3 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1729 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 include/linux/skbuff.h                   |    1 +
 include/net/macsec.h                     |   54 +
 net/core/skbuff.c                        |   25 +
 net/dsa/user.c                           |   29 +-
 12 files changed, 2043 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1


