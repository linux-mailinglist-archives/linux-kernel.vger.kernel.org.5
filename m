Return-Path: <linux-kernel+bounces-5427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7A818A95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40661C22C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1E2E413;
	Tue, 19 Dec 2023 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hGRh5DKE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3C20B2F;
	Tue, 19 Dec 2023 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHd0vS85wsXDNDVDVOGA47636cwaLnPY/A2M4bNUqnRgcul32LX+n73go1VAyxaPDM/MTs9ftXKrjUtKojCTvtTl04y0lFDvj3FwReuNDrqV9ZS07cPjUpt2GGoB6EFH908HzriIZV5yqTd/b0YTVC4mHNRUGjfvpvkPoKlzlRmjGnSSLEuGDQ/VBLdNjTWxwUBqIZsnHWerfVxM91zmxoWi+8bnyNWFgVCeHXxhLrUsxvkcIitIs8RcvK+PdN2H7D+xAoqTIk/W0tEocc2/bGLdJ8T2/T/U77LfGuateIBnuLbUarYwImyXjpXfWwG3manv029QGaFknGwk//UlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZardim7wj5rjx4QXEHp6ThG8Gm+EQ8dorp0M8OF4Uw=;
 b=Z3rb2T19RdHlFV7G9qcqVvMQ4AiqINEofkB2OY/U0ikNS5M0HrYsz2dF9cz1mRgezPX81Vj0oV/ybmzkNzLGhAzYBGHTjEHpDzx5EtLUyOnblZI3ZCIShjdIxcFi01ePMOgRk44/i2zjXG+WrILYkZjqXlU1rFp999zzWRUVecEkN5YueWBelvDPqDatazGMI3H33zvAYLdpKVme4J2wrnfUXfpXXZe84VYrtJTquZr8iXKxqGW24Wassg9x2TPA4Mb7no/h532kCYP6deB3GA/kg6QASGF8Jn0DOO5lvUoH/3pJmda4Sr6we31t/f5RlhgmbAfuOE8t0aBDqKImmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZardim7wj5rjx4QXEHp6ThG8Gm+EQ8dorp0M8OF4Uw=;
 b=hGRh5DKEJOqgqExHv7c1tuEqgAqrF1jm5xFPTn4EkOImb67MLJ0vPYLBc2pF7STWxJeE7JmW5W/XNP3iLjcdWwDQTMOv4apxT2QKNDfag2q07eRwT8MTOK8H2htD2OWcCcWtkYhbzmcRjdTERGI81+T+pSJlLQwDHmAWVguhhLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:29 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:29 +0000
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
Subject: [PATCH net-next v9 6/9] net: macsec: introduce mdo_insert_tx_tag
Date: Tue, 19 Dec 2023 16:53:30 +0200
Message-Id: <20231219145333.240323-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e8f85b9-99fa-4311-c03e-08dc00a266ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p93q/8ncjiQDoJa/90HmzrF9brfmpErZ6i/y+su+5z8fhOOo6/jsT6oAmpwneTAPcyR2FCr4g2zpkisLj3xAtIGd5XLAF1B1js4qIJ8EYcUplr0yeGx9NtCNdQup4+prA6ngkj4VBwL4C51BaA1wR/YDXb38K/BAkw7lNaS6L/ETl4ili5NCG52m3DZ0e3Xv2M1f042qRdjzFab641G1SceCONdQKoJ0WWzq/4i4oXd4+QanJBeCFyQzfUvKiTIcUzSnfsUWEw4Pgr9+hMPX/a/Drv6Vjiq4Dq+LBLXxNvpGfAxZXNzF9ceQj/zLf0Bzj/y5O/j9WjQ1F47m/SigqRWu4aI3x1Amyu8QgiNypodv1hQs1ni2KPg2n2DOoQ1j28hXH7U4dMhnoBO8/WLv6wY4HtuqeOYAzCt8PDnjolKWHCEvTBJFYkDriP4Kh5ILRWuqCLGyAV19rXZxjq+zKmp+DazeoSu9eKKnZyB14gTUkW3T6imldh0UrKAJoNDuzw/xE/wskzKdEr2UyP/f54ciLvnVvV5nbCCQTmrRC7B6ThSKLD1OWbK43Qna+aCMUtNJp/P273IV5aJmTQorh+0S8fLOA7hWO50ZZetLnfNnWEk+rqixdzgXm058wuwR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6666004)(6512007)(4326008)(8676002)(86362001)(38350700005)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCgVnrDkVsmqmYxiYGreig9k0tttEdcCAKeTybtT6f8NYz3HL3+TecFFCddI?=
 =?us-ascii?Q?VY2wQaunVxTEQiyEPF6dl/5hree/mF+8lE+QcEFE7L90oLvjqStLb9MPKY74?=
 =?us-ascii?Q?UqOHmaFM0SweBxDOe2Ns82YgdccA8m52KrIUNBJwsbb5kgnOdm86J0pWVWjb?=
 =?us-ascii?Q?1BD4mDQuZ4Duy0vCae9zNSIR3YSaqTFgr1V98Fzd5lhrC4WYxYuCdHrsgsqG?=
 =?us-ascii?Q?89DhGhBCm/4QbLAoEJ7rrr6kJUwwbose9AjuUNkAU7uwMbM2/YY2fj5PTVv6?=
 =?us-ascii?Q?W7/vvmh8GZhzmJ2dvc+I3RlkspO///G+5DwYprlIuvh4swGSsIl/udKuox5g?=
 =?us-ascii?Q?7MU2sChkOKIhHPQNxvtVN0A8dxPS0t0vzIKgsCBa9dw69VHysd9uIVmHFDZQ?=
 =?us-ascii?Q?vcph8iFjEHkRkU2af3vQCs+KPZ/tFRiVrCd+FpqVKbuPPeLR9Ss4hclxnncF?=
 =?us-ascii?Q?pC8MvMDnPGK/bCjxgczoV8DUrqZxpFXYdV91zzfQUdAawdImSokEUCtBzcl3?=
 =?us-ascii?Q?p65vK/jlIPZrG5jcKQbMWo5LbGPbGQHMTOW5FolkUpKnNsYYu8IrEbPAHDdH?=
 =?us-ascii?Q?OUEDW/VgKGWc10vzNEgoDDvbSoLyqA1XVPUsDqJioMPhAWncxP9tjz7jBKTx?=
 =?us-ascii?Q?3yNuH3kdnkbIOqktJPhDbm99UT5KyJXM4mNbHd+8cOqf9oUmZXfJdD7mu3A+?=
 =?us-ascii?Q?/dvqmgfKe5R21p3cEum20zVaf8QzyZpzZq7VBUz+wtA3WaJ09oNJclIM/G3Z?=
 =?us-ascii?Q?pZqrv/RFAbLxsqXI5I7NJMl1bmTQSCbyAWxf2nuBzAdxSf0XUYo4eUTggWgS?=
 =?us-ascii?Q?hbA9Uja5lDqp/oqQpI+455sHVsDpuhysYMnryAdgtIOAZznYFSjifmjm2Id6?=
 =?us-ascii?Q?C9eTQS4UsOBrzS1p1ey9xwOHvk0VYG9eK6PzoxTqcV10IPuuQzuZRsa0r+iz?=
 =?us-ascii?Q?smT1eiSi2SgZZgDP7wfYr4+r905mr8uHEQ6hmt89KEuLznGLXCFJWXmwckJ3?=
 =?us-ascii?Q?OCD1VI737tx2d8q87nzwqB4vIS5OdP+JLmDTAQwZjNBdbhWfXSH9CV15hGzD?=
 =?us-ascii?Q?jMA31C1aaXPLb/DzDuyYOXrZCMdfPmkYOiRPeMGUNeTOT+lX9MdqC9Z7b85+?=
 =?us-ascii?Q?XUjbF46p1FOrg6V7U6sqM47qcKC9bPxDiXBQuFHYk8KRU0wLBJwBI+PS2w9j?=
 =?us-ascii?Q?O5cmtze6BIIbKdFNQz2NRicYtxsuKQeihTd2ImaHWMtIEl4eksoEyj3IoflB?=
 =?us-ascii?Q?FOcfawmrnmNzIjmfkOj/N2hdzxW9FnO81qQucPaJKGJ1Ll9EbGwE2RUcCiYk?=
 =?us-ascii?Q?a5TWV/L3Jzz33iTealrX/q12tkSusnjjJYbdatI0xPJhex/wHQQyidMC9cJ9?=
 =?us-ascii?Q?v4AHwd42C6o+jjvbCmB62bax6hQ/7GLyav8gwejH3bcV3lV42fb0PoYH3+oe?=
 =?us-ascii?Q?vEjn1LUZTRQl0huy58UrfTHWD2I9GseZUfd8JEsipeNU3kfHOcC6ZfKiXykJ?=
 =?us-ascii?Q?MbFtFo4wHF5fhiYJe9DoKwQXtSiRLTiCCdoBUqdaK8oBPLhSgV48Xnhf6Ltj?=
 =?us-ascii?Q?/qPGiGlnQmOTg3b5uYag3Lal0Fg6SGoYO+Cqf0Kw6G5prMvlVmqusV+W8QTe?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f85b9-99fa-4311-c03e-08dc00a266ab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:29.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+17dDdBV2SNKJVWAu462lzr1WetY1i8qkMBfxZ976XActeWN7rkdZLOCCsbPv8SHzlW93FaoovLFHo7QI8/9IBjk/WV1Sbl6Y04JIW1Gq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
the ethernet frame. This operation will increase the frame size with up
to 32 bytes. If the frames are sent at line rate, the PHY will not have
enough room to insert the SecTAG and the ICV.

Some PHYs use a hardware buffer to store a number of ethernet frames and,
if it fills up, a pause frame is sent to the MAC to control the flow.
This HW implementation does not need any modification in the stack.

Other PHYs might offer to use a specific ethertype with some padding
bytes present in the ethernet frame. This ethertype and its associated
bytes will be replaced by the SecTAG and ICV.

mdo_insert_tx_tag allows the PHY drivers to add any specific tag in the
skb.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v9:
- macsec_adjust_room renamed to macsec_set_head_tail_room
- macsec_set_head_tail_room sets the right values to dev->needed_headroom
and dev->needed_tailroom acording to offload state
- macsec_dev_init use macsec_set_head_tail_room instead of calculating
needed_headroom and needed_tailroom
- macsec_insert_tx_tag use skb_ensure_writable_head_tail to expand the skb
- macsec_insert_tx_tag - the final skb len is calculated in advance and
the skb is dropped if it is bigger than real_dev->mtu

Changes in v4-v8:
- none

Changes in v3:
- improved insert_tx_tag flag description
- macsec_adjust_room uses the difference between MACsec room and 
device room to adjust the macsec netdev room.
- macsec_update_offload return error instead of goto
- macsec_can_insert_tx_tag renamed to macsec_needs_tx_tag
- insert_tx_tag flag is checked in macsec_start_xmit
- "TX offload tag" replaced with "TX tag"

Changes in v2:
- added new fields documentation
- removed unnecesary checks in insert_tx_tag
- adjusted mdo_insert_tx_tag parameters. macsec_context replaced with 
phy_device and sk_buff
- statistiscs incremented with DEV_STATS_INC
- improved patch description

 drivers/net/macsec.c | 88 +++++++++++++++++++++++++++++++++++++++++---
 include/net/macsec.h | 10 +++++
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ff0c43936bef..e34816638569 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,8 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @insert_tx_tag: when offloading, device requires to insert an
+ *	additional tag
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +104,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool insert_tx_tag;
 };
 
 /**
@@ -2568,6 +2571,33 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
 	return false;
 }
 
+static bool macsec_needs_tx_tag(struct macsec_dev *macsec,
+				const struct macsec_ops *ops)
+{
+	return macsec->offload == MACSEC_OFFLOAD_PHY &&
+		ops->mdo_insert_tx_tag;
+}
+
+static void macsec_set_head_tail_room(struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	struct net_device *real_dev = macsec->real_dev;
+	int needed_headroom, needed_tailroom;
+	const struct macsec_ops *ops;
+
+	ops = macsec_get_ops(macsec, NULL);
+	if (ops) {
+		needed_headroom = ops->needed_headroom;
+		needed_tailroom = ops->needed_tailroom;
+	} else {
+		needed_headroom = MACSEC_NEEDED_HEADROOM;
+		needed_tailroom = MACSEC_NEEDED_TAILROOM;
+	}
+
+	dev->needed_headroom = real_dev->needed_headroom + needed_headroom;
+	dev->needed_tailroom = real_dev->needed_tailroom + needed_tailroom;
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2605,8 +2635,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret)
+	if (ret) {
 		macsec->offload = prev_offload;
+		return ret;
+	}
+
+	macsec_set_head_tail_room(dev);
+	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
 	return ret;
 }
@@ -3364,6 +3399,40 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct phy_device *phydev;
+	struct macsec_context ctx;
+	int skb_final_len;
+	int err;
+
+	ops = macsec_get_ops(macsec, &ctx);
+	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
+		ops->needed_tailroom;
+	if (unlikely(skb_final_len > macsec->real_dev->mtu)) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	phydev = macsec->real_dev->phydev;
+
+	err = skb_ensure_writable_head_tail(skb, dev);
+	if (unlikely(err < 0))
+		goto cleanup;
+
+	err = ops->mdo_insert_tx_tag(phydev, skb);
+	if (unlikely(err))
+		goto cleanup;
+
+	return skb;
+cleanup:
+	kfree_skb(skb);
+	return ERR_PTR(err);
+}
+
 static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
@@ -3378,6 +3447,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		if (macsec->insert_tx_tag) {
+			skb = macsec_insert_tx_tag(skb, dev);
+			if (IS_ERR(skb)) {
+				DEV_STATS_INC(dev, tx_dropped);
+				return NETDEV_TX_OK;
+			}
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -3439,10 +3517,7 @@ static int macsec_dev_init(struct net_device *dev)
 	dev->features = real_dev->features & MACSEC_FEATURES;
 	dev->features |= NETIF_F_LLTX | NETIF_F_GSO_SOFTWARE;
 
-	dev->needed_headroom = real_dev->needed_headroom +
-			       MACSEC_NEEDED_HEADROOM;
-	dev->needed_tailroom = real_dev->needed_tailroom +
-			       MACSEC_NEEDED_TAILROOM;
+	macsec_set_head_tail_room(dev);
 
 	if (is_zero_ether_addr(dev->dev_addr))
 		eth_hw_addr_inherit(dev, real_dev);
@@ -4125,6 +4200,9 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
 				goto del_dev;
+
+			macsec->insert_tx_tag =
+				macsec_needs_tx_tag(macsec, ops);
 		}
 	}
 
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 0821fa5088c0..dbd22180cc5c 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -316,6 +316,11 @@ struct macsec_context {
  * @mdo_get_tx_sa_stats: called when TX SA stats are read
  * @mdo_get_rx_sc_stats: called when RX SC stats are read
  * @mdo_get_rx_sa_stats: called when RX SA stats are read
+ * @mdo_insert_tx_tag: called to insert the TX tag
+ * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
+ *	for the TX tag
+ * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
+ *	TX tag
  */
 struct macsec_ops {
 	/* Device wide */
@@ -342,6 +347,11 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	/* Offload tag */
+	int (*mdo_insert_tx_tag)(struct phy_device *phydev,
+				 struct sk_buff *skb);
+	unsigned int needed_headroom;
+	unsigned int needed_tailroom;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.34.1


