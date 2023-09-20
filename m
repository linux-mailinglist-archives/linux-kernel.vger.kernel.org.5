Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B747A7730
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjITJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjITJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B4AB;
        Wed, 20 Sep 2023 02:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbGzVS7i8uUx0yQA/zPP8Me6bmtXVJVgLcGEaODa3ecppY33OsADKEzZT/S+A0XIi1loaxJzQDMRaeJUHo5WetS1+cxgJu1dqH+wdQzQPjID3DH+CJnadtBACF1P5Gt7GvAZGOazGv1xphtxvoYVhZmWkXoWsx3eRvzuLQTfwXGKejAJOdwZzL7i1+1xgrqCMBG2qXtFNcKEdCRCJcqQwwFTqWuV1MtYWkBNk+QamV/y+1IlakrH7gBQQcEnxT8d25/9vjiYy0Gbvw1F6FfXR77zRgpQBlCIYWNjp8rHTUahHerbrlGsr51bG0Wu1sgcccVgXG7c6zn5ZqFPYTPWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhxkpvnpI7gkLbSIp8OD60+67rs9p1MZtQ9BCPBLsr4=;
 b=As8DryXszdcodpOaqPzgi2Nd19cUgr1Ut39aaFZu0ZlNlfkOi54SwnUTC2O/L2R5RWuUDAj4KH8+iN1aPKqUrVqPfKCp/TaRIkHeX/a1VDKO/gRg33B82GnPLrz6AeDdzAuIuS7AiuoDbv9gbTA/oYdjrMIuZfb/f/Np+uDfM/qooATfoB1YkCLvr3GaTajJLCG0SUNqduAgp+H74xrB7SqXKFrYrKavQoiyo64iUXZwYo20LxqtepunVSaqBeLIwaPvoC0BSIMhC3LeB00eClk91ax6dOLtmlUsnRKjBXhqh/O1eW2uZLcPZke3AuA4NQkBmBeaSceI6F7Nzhcmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhxkpvnpI7gkLbSIp8OD60+67rs9p1MZtQ9BCPBLsr4=;
 b=KVO5qqzoc7HTViOpRIze8QLxz7LopjYXVWHw2MfC60CYFPSjlVBrtx+Z8fVpOZgy2zjroXkqrTg5D1BDgNTZhXXFbmLNV6iykJbxAtF2cPCVrvXZ+/u00fn8qT5UTJCUnRwDF41d24cnhbU9Kd5tuR02IpDiYqhFlhF3HiXnm24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 09:22:58 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:22:58 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 1/7] net: macsec: move sci_to_cpu to macsec header
Date:   Wed, 20 Sep 2023 12:22:31 +0300
Message-Id: <20230920092237.121033-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VE1PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: de8d4ba0-0507-48e2-6d8a-08dbb9bb2ddf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/7YpCgSoS8pOioLXdAdJqKRyfvnhZfAYWjlKD8az75zbamQTuwJseLH8k9RcHmJfjbXK++TKAgz1uwDy09VC9xoLjTk0AXwSztqw40tkGXLjF/g0kRTFrXtOQNo2LGpcqsLKIjDb7daxCv5Kd+pWh808xqy+jC7tUnrYgaSpEj97S90UjegvMhXEpJMsVzz+RagpiCaSphKxviBo0rf5x4qSJDgwD6879VTS9cLEP+fetreQaeJGykOhV6dDO4QJ8RTI12a/SW5hf8XrTgPxom64a7t628DZiQMJmt++PEDgpGL4i9Z8eWaegm5DyI3QNaRXw3urwPfARbmvAzOKc3zZ6FzuP6LbgrHiCKxJzFEjJLFLP34lby1q0WfFuT1nOwFs/qB7JmjGAiqbEhTqbVIlBAofq3j8MuX2AiFJIkHjuqvsZ0XcH9pWYrBfLT1RnCzpG0b/YWIX5lP2gAA4GLI2tRaPfBN/aPc1A4K04LSTOFwIk7MiZR/vqwkegv1xEFDn1Vu0yoDDz6GClwd474cYStzZjJwdHd0b+23RzI0LhH7H2n7I5RVTZNPNnsPWvYO9GjwLK/B4zWDa842MuOUhL0o7aUO0zTdhfa13S/G8yN5D8Kmr0ubd1K4By+KLofjY5YMfFwDWfhVuWoZlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799009)(186009)(451199024)(6666004)(6512007)(6506007)(6486002)(52116002)(478600001)(8936002)(8676002)(83380400001)(66946007)(66556008)(66476007)(6636002)(316002)(5660300002)(2616005)(38350700002)(86362001)(38100700002)(4326008)(2906002)(7416002)(26005)(1076003)(41300700001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qjt5k1TNrXW0sVO+yIMT9rdzjgiulzf/VNqFUx5iTAzzC+X1OhyfA2Tjo1QG?=
 =?us-ascii?Q?zrSkbDmwB+WqIcgGVavYY9qLHKPFKTkiDTmHNUwUuGxgTVtVdpw+uvxU3I20?=
 =?us-ascii?Q?3eM+6RFqf3Ig0xTLLqDm0yjSB3Qr/noIxGCss/vFYSa1lE3Lshh40g+NxtTm?=
 =?us-ascii?Q?+EIScxueGffXFbYau3UObII/OJRpkvtxkQpCMbCAwdn6MhcLuk9I9chWllYc?=
 =?us-ascii?Q?mJJLKgDe5yZXGBVFBUHAuxb8wl/VIaxvzGVQkRTTBitZUpzxINhtEiyScQgW?=
 =?us-ascii?Q?AHX00t2DzZXJl1+M6q2CvxOK5cKZu1PNDmVuaXM8X3LJgkxWK/gU3QIlEfFd?=
 =?us-ascii?Q?36hOB71Tqw8N85gHJa33sBQIz38TtgbGWfwz07/U/adJDwJX54Z7uWA7lIPp?=
 =?us-ascii?Q?b8CV3REkahXwU9WKQLWE6xCe0Yw0UKxDbYUVXS+tnF/EoXqH2Y/K3K8GIGQP?=
 =?us-ascii?Q?3NNgZZDFmGj0l37IRHrMoG8u+9YJPwsPX+rmLrm79Vfi/qruK7SF7k8+imAC?=
 =?us-ascii?Q?k+OnCZe+s9SnQ7a6q7g5pwlpl59HWRe2fb8y4UrUEoWDME2ADHSv7wCdRWIx?=
 =?us-ascii?Q?A1c6Ry1HRoMstkxUe7s0ewsTCJWWKvRw3H376Lzhf3BY26Y1xz926MoUI2Y2?=
 =?us-ascii?Q?Abme5KLbHR39iLmxMkO9MQp8Qjf7Wq1l8xRiNBaiVb16BPCygXaVqrP80eVL?=
 =?us-ascii?Q?wG4L/E8oY//d4q6NyoYKaqr1fPPG1JRyo6oWNWiNdNVw3CuyP6Y04/ZXhG6B?=
 =?us-ascii?Q?CZQ8wTaWwdkdkNZvbBlnvAAsB7okspOTxAeZwtwzcfxaqL4Ot3iuSs4OTVfQ?=
 =?us-ascii?Q?1GcnszvcoFp1Gcu2nF/cP9SH6TiuksNZvdgjvMUs6cfP8muXJ0jEJcbBSBTp?=
 =?us-ascii?Q?bo4VPRzoP6iDDyUTiZOUhROBVa/7fiswpMV6udlXOlbLi2v2LzxcUMRH3hxO?=
 =?us-ascii?Q?eJdrOPAT3BKAwUfOyItJa1FWxTobDn4dZHDlJJy1Am6hdUvmGxUbukiM9+/n?=
 =?us-ascii?Q?4pKb9S4u4n4YJ8W2DC+o+gmilMrjFF4RrXv/G0qnOBZArnhQKp87cl4iaSVx?=
 =?us-ascii?Q?RQhOyOuqY9H8inGTUlOHwBCNcFBY0AX7LXCqOfhwJcN3aluKRhRwog1Mpdo0?=
 =?us-ascii?Q?n5XznJdj5rEoVEwO51OYanOj+YB/CBKgJNWOpDuHv81SjpZJH1wf/MMdSZgh?=
 =?us-ascii?Q?Ps0YCrMECs7sms4YQKReBByfrP1PfMG3r/pLO7MOTpnx77X5kjB24fn47m0o?=
 =?us-ascii?Q?ovilDCfqAu7wIPfn+O6SQlvkewqTnNEnIWyC1FbzBJ+ZGjJsU2K83vbEIxDq?=
 =?us-ascii?Q?Vcyhl/l3a+5aLe1LVuKy6cQ7kB/baBX2TD0BzAKjjLh2jpPmmFUEkkg0Vuti?=
 =?us-ascii?Q?8lZt+FgFJLG+mcfPUw8HluRBBJFNH+uyC7JuPTtF9yIAvlJMUBfgjtiest0W?=
 =?us-ascii?Q?rqAoaWQcHEoN4G7ikZDgw205Azs+n5qPEe+Sny2NwZvOQSeIzbn0ta2TX7Kd?=
 =?us-ascii?Q?3RtNfV6vo+43t54WgHBinZeHreaaG9Jy23wS35ssA3bApArVAwXM44skQ39I?=
 =?us-ascii?Q?sldutZD4syv1NUwoAyidwkO4T4Z1BNA3FbsXjHsYVYLEp+/mCu4d22au5/pJ?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d4ba0-0507-48e2-6d8a-08dbb9bb2ddf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:22:58.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x864j+NIcdZ3hC/maqlQJIkt3PBSCvab3lmPH2522WNu8G+Zf/QT4Mk95jrctNd1AsNXPav8rVeKyoy2DhHRRiw2UIZSiUpfMgPIK8pAeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- patch added in v3

 drivers/net/netdevsim/macsec.c | 5 -----
 include/net/macsec.h           | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index 0d5f50430dd3..aa007b1e4b78 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -3,11 +3,6 @@
 #include <net/macsec.h>
 #include "netdevsim.h"
 
-static inline u64 sci_to_cpu(sci_t sci)
-{
-	return be64_to_cpu((__force __be64)sci);
-}
-
 static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
 {
 	int i;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75a6f4863c83..75216efe4818 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -324,4 +324,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.34.1

