Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A247BBAF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjJFO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:57:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2019.outbound.protection.outlook.com [40.92.99.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8248F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPgeiPcPs8TcUHsjxrW5VQ8TDklVmEagrGYQIXY8+cfF6o6YXR8VS/H9jSqrIdywsYVK79iJ6nmnEZDfrdtrNUxOKboo19+n2Paxo1YlplNiUaPl4Xl+LYl468LGJOegtNtp/IsxaAQfXECigygZ9zGe35SNKi0JwOg3GRjTC6+cqm/vtWOUnRETvqdTxpXrsOce96rktutlc39vQVpcXk6gaW7TVwIjnhzGFqLMu4utR/6sRbw/Nh3LUXuzc/swz+Krb4tQk48PzF2UHXZP/ibIdqhaN6U6AkGSHSnuvY5EsLTaX8g20aXqImHjaNP2GyvpbsDUvmC2eWnVribacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mgY8Rg2bhOMrQhFi0tPEt/AiXMPGfu90XKWlkuWOgk=;
 b=G0uDZpCppgml2Fw38CTy18ySe1gG5aXoBLLQTlNW/tmC3i9/zNUqqzkKg1ebtNpENKtAob1b5zcJnBZ2HjdbODo7HwSeziXXCIeWRaRUplJ+fHsD7bmorMJKiakxBZIHGjqdZbYIjapiiIaUME9VgNgRwzuHRPaLqxRo0OKHGWcW1r0U6giJx1czJY07Uum5R2DIw+sr6rIaJxbvpzdgJGnGiGLBO0L/OPd7wj1VPVUhFxcDFZIw/y7YeYAxKIyFhfr6TaMfNoShcYmW/tOyLoUxSO6zYoBuhSBxsfAufRUmArK1KUMBE0TERVlI8AV5vP4DgmkW2dVWzGGbIumLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mgY8Rg2bhOMrQhFi0tPEt/AiXMPGfu90XKWlkuWOgk=;
 b=Oyj8n19DWDIQl+/nnFq1M5eseRLe5YxwafhU+/CM91RXoZr79P3ONIcf8DEHn+4mI5xruy5aRPnLtQKdqqiYMkP5EycW2CEYjf2OQ2rzGZgV2y3VxZlw1zzLpCFETUVFlmAaqiq4q2XpOGfaZvtzxSF76jf7jFHE/gONCMK7d9iKkjAAF31P551PobInRyOT92pP+D5K+FZDcBfaYqa1nfzTV05sMWIXv6ToWKe5SBLq497Qlwr5XOGEdZD417PGJD5Xx8CmjXrrwkkvGz5cfjJTlKuq6PSXvLPd9m4IK91cwds4UxLhoBiKOTmTfmqDcjcNH9+iieGxxySrZxBcMw==
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::8)
 by TYCP286MB2702.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:245::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33; Fri, 6 Oct
 2023 14:56:55 +0000
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbcc:7850:4492:eb87]) by TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbcc:7850:4492:eb87%4]) with mapi id 15.20.6863.024; Fri, 6 Oct 2023
 14:56:55 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     will@kernel.org, joro@8bytes.org
Cc:     robin.murphy@arm.com, jgg@ziepe.ca, baolu.lu@linux.intel.com,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] iommu/smmu-v3: Refactor smmu stream data structure
Date:   Fri,  6 Oct 2023 22:56:25 +0800
Message-ID: <TYTP286MB3564A9E3854CACDEE366D59DCAC9A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+9i3Piog5CYZhKt2MQrntFMhW/556ncV]
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:39d::8)
X-Microsoft-Original-Message-ID: <20231006145625.12408-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTP286MB3564:EE_|TYCP286MB2702:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c86921-8c5c-4f85-155e-08dbc67c7b1e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UbZV+LzNd8UdTJJNgX8SE8Yx2OFbBr3RgTrPPh+XLxWGnN/hNYxWCS96ssZOuGEp4iBEIzTr5OhfV93dNr57eq31B+y+ArZH6SKXA4WjPvCEmbGzJ2BfcROH5VNPGcLgCsqUhoIARzThac1cS4tP1lfXweI0GS2R30qu51vs+8wK+J1vDumR3VZmMVM/aFIcLxyXWOIlyIHThSAT/qEDB7HMod0S9UiFmHyV3cu/ZwzqDxC5Ze2HZkNEAsLE9VEQvxl/LjfhpoioAJsSzDQeFmeByYxoUHoZOilNPPPRwdSBjw0lAe6+sSGlaXned/Il/DKmdtxa88uDSc/Rxb57RB7t+nsoexI6eM+lp2l2rve4dDcxSr+amMx3Un0vB/1xHi+cFOHkyy8tq8vY9EP50cJCCHBKhDJiZAt36oNH2f8koolun9YoFmflL8LXbcnljctOdk8RmD8uOIlp1U8fJddeEnhbk/BeDUejjnSApRfx8AX1ajUJU7JJU12HiUpUbhgoTp/nQyKCRNvl0C1nxYUcPlqS9zZ87tQREdlKNbjS7IXr31db2VviyXKeQSZ7lAF4h7acJn2XylrD0oQ4CiMphH2yJ5z6TllzavsaCMIjQYbxkyu95pB1RYsAIM3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODf7tJzVNRjL8kDI5HkM6DtiwbloE0cl96eFjbNEKOwmD+xdBTFpRs+Yr7FD?=
 =?us-ascii?Q?cyf9DhmTYFpvsU6KXdTGT135Dg9rvfw/jwmUsIfw3O5F3gvEaHw+hTaaBKpd?=
 =?us-ascii?Q?2dqhO+8eovuqE9Cty9U4saoV4yYGBrD+N2mgF15zk2sG8seTVBse0p5AGDI+?=
 =?us-ascii?Q?0lOK/iDiHIiLL/XBp8ndsEzy33OdLPAKv2lt+Kg8NzcNYKvux/WSZLz1qBFk?=
 =?us-ascii?Q?aTvgDkry+W30dXd5hPgwLVr5ZsxlQABQhe7ZUkPglTsXflTv0YS/eCUzLgZy?=
 =?us-ascii?Q?el485dBJ0ihYK9dmXJm390pyVp6IBEC3WtflbWZMBT/1Ek/l1cTI4Y7byLwN?=
 =?us-ascii?Q?U16ckJqZBn7z9KtYE3rJB+0UgF/Dv76Ofi3/MChEfOPlAsTABrvAibUJOA7B?=
 =?us-ascii?Q?pjnkJCjVWMUFbtJ1WU/2ddoUTyZfqZAhYP1uI+2zzM83Q2+/c4hHGjK4lEKI?=
 =?us-ascii?Q?sT0yAdfg3YM4ekAI4KeYi0Ij1PV3DLY6kjU7qVSgDbW9ql/2AlfCDQH+pIYu?=
 =?us-ascii?Q?uptc2GAiagghSIIHYmK2i7ZAegud1icsD8gzUjem7lUj8yfzTEQVAT/03nn1?=
 =?us-ascii?Q?H90kRPRGVIZlD5QxSbarEeMAzru9vah5AlnZajTAFB7lg/tdL6xIhAo13l4T?=
 =?us-ascii?Q?zcgKtiyldz3i24gPnX3D3Cg20X6lEuqs6tDAOdYoURSXjC/z2oA9vWmruAjc?=
 =?us-ascii?Q?4ad6K/BV9aqN2di50h9P39xHrC3E0sHpP8vyWXLnjPJTXofe0p+6juGxqXTm?=
 =?us-ascii?Q?xXueaPeAyzGcG2VOsWfrIA4IU3RoNm5NcfFlsiadjNAaYq2EsuyTupZiRGyv?=
 =?us-ascii?Q?w3pa/nKF94ptqgxYBldUvXRDWa+ynNiye6uj8ohV1FAs/tGkjXJH621RM5vi?=
 =?us-ascii?Q?CDFB9qN5nWIA9QfdX0yyVQf0PVMy1CvKSwMPKHQ18MK7MDkn9bqzgL0ZOz3o?=
 =?us-ascii?Q?PZrK6wx5A9b1AXSsRrNcEhORD7fixM0blaSgzLLeC+r7bUYQxH4Cuzf+nt2K?=
 =?us-ascii?Q?cBu3r8IxK33MjyOGlxiInWKE/VgecHQ3NP2XFbPiCzfzrajtrVk2nM+BrcQu?=
 =?us-ascii?Q?KLX+7WE7Y6ntYf8fMTPHha19EclNkAzMOju2OB7fCGtnXde7/qs+ICKHMG6x?=
 =?us-ascii?Q?cg9hsiYM0nVQMGebuglMLZZgYxgYQN2KY1AqdZFugrawjvLc7COqoUm2shzw?=
 =?us-ascii?Q?ZK5lriCLJtZhPjJls2yyUJoJeIqiwsem96qGXg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c86921-8c5c-4f85-155e-08dbc67c7b1e
X-MS-Exchange-CrossTenant-AuthSource: TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:56:55.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2702
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relationship between stream ID and stream can be abstracted in K-V
mappings, in which stream is identified uniquely by ID, but with notes
below:

<1> The number of streams is varied.
<2> The stream IDs are not necessarily contigeous, they can be sparsely
    ranged.

Xarray is a data structure which can deal with interger-pointer mapping
in cache-friendly way.

Compared with current rbtree implementation, xarray are more handy for
index-orinted operations:
<1> Find/locate an entry based on a key  //xa_load
<2> Associating a key with an entry. //xa_insert

Rbtree version for ops above will be cumbersome, for it is implementer's
duty to specify full logic of lookup, such as key comparision and so on.

As such, re-implement mapping between stream ID and streams from rbtree to
xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 ++++++---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +-
 2 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bd0a596f9863..31cf1c0d0a88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -489,7 +489,6 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
 	local_irq_restore(flags);					\
 })
 
-
 /*
  * Command queue insertion.
  * This is made fiddly by our attempts to achieve some sort of scalability
@@ -1446,23 +1445,13 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
-	struct rb_node *node;
 	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = smmu->streams.rb_node;
-	while (node) {
-		stream = rb_entry(node, struct arm_smmu_stream, node);
-		if (stream->id < sid)
-			node = node->rb_right;
-		else if (stream->id > sid)
-			node = node->rb_left;
-		else
-			return stream->master;
-	}
+	stream = xa_load(&smmu->streams, sid);
 
-	return NULL;
+	return stream ? stream->master : NULL;
 }
 
 /* IRQ and event handlers */
@@ -2573,11 +2562,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
-	int i;
-	int ret = 0;
-	struct arm_smmu_stream *new_stream, *cur_stream;
-	struct rb_node **new_node, *parent_node = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	struct arm_smmu_stream *new_stream;
+	int ret = 0;
+	int i;
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
@@ -2597,34 +2585,18 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		new_node = &(smmu->streams.rb_node);
-		while (*new_node) {
-			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
-					      node);
-			parent_node = *new_node;
-			if (cur_stream->id > new_stream->id) {
-				new_node = &((*new_node)->rb_left);
-			} else if (cur_stream->id < new_stream->id) {
-				new_node = &((*new_node)->rb_right);
-			} else {
-				dev_warn(master->dev,
-					 "stream %u already in tree\n",
-					 cur_stream->id);
-				ret = -EINVAL;
-				break;
-			}
-		}
-		if (ret)
+		ret = xa_insert(&smmu->streams, sid, new_stream, GFP_KERNEL);
+		if (ret) {
+			if (ret == -EBUSY)
+				dev_warn(master->dev, "stream %u already binded\n",
+					 sid);
 			break;
-
-		rb_link_node(&new_stream->node, parent_node, new_node);
-		rb_insert_color(&new_stream->node, &smmu->streams);
+		}
 	}
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			xa_erase(&smmu->streams, master->streams[i].id);
 		kfree(master->streams);
 	}
 	mutex_unlock(&smmu->streams_mutex);
@@ -2643,7 +2615,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		xa_erase(&smmu->streams, master->streams[i].id);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
@@ -3097,7 +3069,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	int ret;
 
 	mutex_init(&smmu->streams_mutex);
-	smmu->streams = RB_ROOT;
+	xa_init(&smmu->streams);
 
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
@@ -3913,6 +3885,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
 	ida_destroy(&smmu->vmid_map);
+	xa_destroy(&smmu->streams);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9915850dd4db..f500754d4fbe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -680,14 +680,13 @@ struct arm_smmu_device {
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 
-	struct rb_root			streams;
+	struct xarray			streams;
 	struct mutex			streams_mutex;
 };
 
 struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
-	struct rb_node			node;
 };
 
 /* SMMU private data for each master */
-- 
2.25.1

