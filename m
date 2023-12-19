Return-Path: <linux-kernel+bounces-5426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E37818A94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B01F21EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165A241F9;
	Tue, 19 Dec 2023 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IXZDOzmo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059021C6AD;
	Tue, 19 Dec 2023 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0KNNCTW4mJr0OSqnuAHy6i3OFftR1qEux/u2GlzTIYGFbhDv+y0T9kT/XX0eSxr0HXXY23VB1uEc6/tP7683VXKd1eDjPGXsqbqDmODSlBEjKKgy+C637GouguAd+bKKuBcY/rNncQA+Oc/m29r6AiXEf0EK+lyOVwIreCBGr6bgTNyaJdeinGjCg/e/wvAlyilgjkfA8scckNvwwpJwuHRyX7vkJZHroefT+eBx1z8Zq6jlV+bqpnXEHcrq418znTt+8Qr7k8PSj0N6LeCCT/b+dU0Igfr4DtddiENN5wLcbxrLo1rmVNa/hGI5471Y5FA3x5PaGBVhOOg1aDygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSY+IaF1bwbLszK4Qz8FX9VbYtFiorsg0pTzGteOAmI=;
 b=Me2MU0oJGb2ftAkXS6Vzj7m9jTdcztqGA5FtGGgbTSpJdhHbI6zXBOkgBEzQTM5kdSPlWxBmooOrQue4mE21Ctm06wM2hppDuNPGwdXlh3kiqUIOTIo2lpSfFreFf8GfmXY29VgFMKmkQlA3jiu4z9l1yfODazVlx8sWYLObuvBB50GO7AfxqrypQaDcrFehykFq2tPaUBBXfe/E6MH2nCeECUKmyRMZNh13xnrAYYIRugwVwdLXkln2/3SFMQ+BV7cQQOojmHtV1+tSf6i2KHJgel1ZX+nP7kOAQfQghx5nttDSowEOkwMrHSPteq+dUDIgcYjjXiT2RAYYDAP/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSY+IaF1bwbLszK4Qz8FX9VbYtFiorsg0pTzGteOAmI=;
 b=IXZDOzmohKLDd26AIj88XPba0HPYVjbGv18d6ozo1WP/LHbu4yuGxVNBzwriS7j7g0eS5U73nz10LEKScVkcxxV5oSJyjkxD9jYvl/yE5+Xtg0QDYbfr/bakSYWmYtlaj6MYR1mN2yv0IjyE4fQ3ItxIpXQkeFBF6KFVoB1W1OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:27 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:27 +0000
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
Subject: [PATCH net-next v9 5/9] net: macsec: revert the MAC address if mdo_upd_secy fails
Date: Tue, 19 Dec 2023 16:53:29 +0200
Message-Id: <20231219145333.240323-6-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7294d176-3e96-464f-c43b-08dc00a26610
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QIgwuITl9sJa+okrtJGgSqoI4JA/nOAYG2E52WxvbWkNlOM/3feIJRQAs2ejdIzBvXeHl1C7ohKornqZqz4nwMnRl0CMnIL7VEHrg6m7t7ER5woQpf3W6xeZ1lFpZZyd6F4dQv2FbmiXzQLlCKWu0jidJwNujXwkcAqP+jvsgxXSIWVDHVzgl0Ws6RjAdEhZLW8M+Q/Q8Ab8SFikZQWEY9Jz5fHgJn2cGPS7AOKgEGtP810YXDbI1/CRe/LKXyx/b9fa3QxN355pjt38lIHciSZ1QwvsZiJHk/yetqp06n5z9w/NsPZHBBSsSCZcz1dgv0gk8Q9pTz4Zmpfroq9YqvqKZT99UHrJ37AUkFFZPX2lDMDX7wAW9eRH8rVLIkNc/B3nwrBIwg7nqNridoygoK34lu5yBghSNXAwCY74V7FRTXSRjEl6BxfqPG4X3q2z+pEN0kAmLCIgfNrvEH1NE7uwr4p+ayEkp3+k5Zb8cNFgMbeO8bJ6WZXGItH+AayAZ+CnPiSrU5AThjQvt5kvWSPCQ5rSvAis7AM4W80blImshNTpM5lPVO1pW/RYHOXpL9mt/cRWCGLWcNCCTEEahDaq0iUZmiLO3s46eWpyzLs2yiUGFGJ1XV0Z7nObxHEq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lyfEQ9TQ0GBKYETYunf0/GeAb+ION/gwJpRc950guMc8csWhY+xnyd+J3Zb6?=
 =?us-ascii?Q?Av3nAIQEQrJbV5u6dFISfzN47a4VUlffUjRkKVVSOjGyNc+X53V+egh4SMk5?=
 =?us-ascii?Q?RCwM7aYKaC7XxxvgEKJWCoKVHlrKzckPMHLranp3OSfi20BqdWnfMZ8VbOvS?=
 =?us-ascii?Q?y0Gp5c47VqtQfyYTi/9v7IhpWUch+kIbiXamMPmnZIOZYtV0A2QSf7E1a8NK?=
 =?us-ascii?Q?12luIv/JsFuVLIyQrnAzn4xonLTude7EfyeXQvLT7Gwx8kPlMQmfQTShxoeL?=
 =?us-ascii?Q?eMUdX498xG3WqQpBiwBPcQkq0ZD1U4zSaQ71RV5u53pvpbsSATNczA6gYj7W?=
 =?us-ascii?Q?u3LpFkkUfRqXcETERTQi0gZVIQneNSDExJxwpyg77XCkLK1n1SS1hrUD2zEP?=
 =?us-ascii?Q?LjYqTjYLgngJly7rwEb4XSYUUgUbS7wXHTfFnfsfKP+Q/HLBU8ntHgvaXGYy?=
 =?us-ascii?Q?f44JDqglSGqQ0Nl8uYMhh4IdsDDK2Y0P6eIFl+QwnM+STsuzXUaKXNxouTuv?=
 =?us-ascii?Q?5m7l0pAOnL03v6nJOXxDIW0e9c2gTroHDUg2ClNuj4jdlBPTO7VcaWlQR4+L?=
 =?us-ascii?Q?vtR7pHHv4sLIh55JcaP4DGYt9lItUGSvLiI+aW6gnUOqITxJzhvTHsAA2hiG?=
 =?us-ascii?Q?Z5UJkyffk04DP/nPJojkoCDy61vL/0hYr5BimQsLU59aKgW7pnYkW0UiSzBn?=
 =?us-ascii?Q?2tN+lrNoKrgMvy0LHrZo2IL4RHP5nS8LzLSINWLcClscuOeJmqENoh/9b5Hy?=
 =?us-ascii?Q?fdXu70cuIsczxtUQXcIUMmshL/rME1+CpYS+q1+NoS/bm6Wp+DDP8yGsAimI?=
 =?us-ascii?Q?GGPR6SQlQtBbvtR2IdZ2cOBl3QCxurhIhZEDPCOWUUqu7hmrFacan6ff5g/X?=
 =?us-ascii?Q?aX+t/3jbqKCYFj8yGuPqVXX6rmeTFyypA2v2wOcObY8XHwyOdc9W1xKhR+sG?=
 =?us-ascii?Q?uQJnpqwNkGc2KXXmcqEd9HcLa5GrHX65+X5IQazGr0KbIcO6CapElx+uEirY?=
 =?us-ascii?Q?BhfWqfQpKrym3L3v510CdWxsO3WDKVU9Lbkt8OD7mcf6v5n+s9pJssSAVy75?=
 =?us-ascii?Q?qin+biD1Bwy2BmNZWQVU0JE6GwS8tiXhu/hZjScXLDheuGiSroo9wYRbYJpK?=
 =?us-ascii?Q?yKSvdiVsDFEBKyPzEmMZmtLhwdHqvvSzxnyzqB4HxbyokXndnQteZ2N0tIDu?=
 =?us-ascii?Q?CJLLBrJr+gIaF15aoc8hDMrYxEjd0RmT1nssy1OZ/IMfnTbdFFbRDhJf1qMy?=
 =?us-ascii?Q?VKvKZblN/xNDgS3+YJ/hbyi22PHhiUGwSoFqzAQ215X65OcKX4ouqWXyZQvI?=
 =?us-ascii?Q?iWMs6TxN4dJXVIVaEJnXkkh7BkQ+57zXbr0t+HZKCBa0QEk1HOnhAT8LsIEl?=
 =?us-ascii?Q?wA/LocGnjgGRxxquUXqezOZGnGZKpUIr4OrC36WxBFTSR/cxDvPj/tN+1iIx?=
 =?us-ascii?Q?wz6N9vXItcUS5czsoD1FaV3xxbVBJutzcXDMgQxYLbgnXg1VhzEHeZp/5gvz?=
 =?us-ascii?Q?C2b9CIqdvnnO99FvvsWea3JxTIQoNWXAyJFwyqQ0oz+WBdAjCgHXRtqRfWoi?=
 =?us-ascii?Q?8iAd8OI4vBGdTscHl+od1+n0iGh1yc75sKPAGP/At16gtT75seP4rEaG6vSd?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7294d176-3e96-464f-c43b-08dc00a26610
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:27.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRNmUp1U/1cawEbXTjHo5lYNW1G8I5OQrX4hUoQbpb5iH3FbwqN5REq+BZAQj5LPCW0GHF4Xo3F9BvJyqUSDtzCoeAOqclUdQj8S5vZ9cp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Revert the MAC address if mdo_upd_secy fails. Offloaded MACsec device
might be left in an inconsistent state.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v9:
- none

Changes in v8:
- call dev_uc_del at the end of mac address change operation
- return -EOPNOTSUPP instead of -EINVAL if the macsec ops are missing

Changes in v7:
- patch added in v7

 drivers/net/macsec.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 972bd816292a..ff0c43936bef 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3589,21 +3589,19 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct net_device *real_dev = macsec->real_dev;
 	struct sockaddr *addr = p;
+	u8  old_addr[ETH_ALEN];
 	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	if (!(dev->flags & IFF_UP))
-		goto out;
-
-	err = dev_uc_add(real_dev, addr->sa_data);
-	if (err < 0)
-		return err;
-
-	dev_uc_del(real_dev, dev->dev_addr);
+	if (dev->flags & IFF_UP) {
+		err = dev_uc_add(real_dev, addr->sa_data);
+		if (err < 0)
+			return err;
+	}
 
-out:
+	ether_addr_copy(old_addr, dev->dev_addr);
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* If h/w offloading is available, propagate to the device */
@@ -3612,13 +3610,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 		struct macsec_context ctx;
 
 		ops = macsec_get_ops(macsec, &ctx);
-		if (ops) {
-			ctx.secy = &macsec->secy;
-			macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (!ops) {
+			err = -EOPNOTSUPP;
+			goto restore_old_addr;
 		}
+
+		ctx.secy = &macsec->secy;
+		err = macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (err)
+			goto restore_old_addr;
 	}
 
+	if (dev->flags & IFF_UP)
+		dev_uc_del(real_dev, old_addr);
+
 	return 0;
+
+restore_old_addr:
+	if (dev->flags & IFF_UP)
+		dev_uc_del(real_dev, addr->sa_data);
+
+	eth_hw_addr_set(dev, old_addr);
+
+	return err;
 }
 
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
-- 
2.34.1


