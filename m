Return-Path: <linux-kernel+bounces-98792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F2877F85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B800B21A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3B3FBB4;
	Mon, 11 Mar 2024 12:03:29 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A83F9D2;
	Mon, 11 Mar 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158608; cv=fail; b=svFh5gLBeO1putlnNcvJ1pZtJPYmwGnpe//zgRnI6VMfZwuuODpEnl56uleXfPrcB1wZDJ5ZyiPd0Xh6FkvzHdaky45Ip3i/sd9RuVbAJeoQpfgO9wE+0zfeSrVFXODAgx5llnXXB0a4uPXqjVPa2Bih3Hwr+0jEW3nvaFn+Lqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158608; c=relaxed/simple;
	bh=cYfthZ/jaT38HqORkj+Brecr+mSEj2m8c1hHhjI194M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OY/EgjJMBFRfAyd39j1EedZuEN0nso1kSjH2ar11p2nmY1zDT287pelRYmNBjFebZvT4B1GwHN2GNKAdWrfruQWe3jD92446/qxs+k+k7j96KqChhe7fc5/+cSagliYU6rHOlpAhi20WqdSIMBqR+k8xs/S6dd9I00rVSjMIVWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB8y2XR7u0qUW+fAcaqpcYm/lS3oMjIzzy4t8kN8D59DMmDQgNObA/KQYFCuwP5bQJb0P6Lx7NGxxb6RA5Kgvd2TAsO5F53cYTnF02c7qQDeCvEOoCvjojGCeJX/8FRWmU/OP6mw6PKo2W6FustMRwTkdan8KZU8IbIB9/Leh9P/jIklsva1cT4PP6R469vcZgtnkWGEZAY73h4GuK2WI3DUq8T7c/PbMcBeJ/7RR/S/jXPV33DeHM7ENIzkriYEibPez+Ojf0HY9yi/nxnUPw91KsVzyY5MWIzzjbBLIJsLLNIP3qkHQaPhRcQAiL4F7jL0TW0GParQVGGCOwDUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhrZVVJAK9s6T2AjPrrnc5ZXfVhkVFtfA2/ycaCWrKE=;
 b=Xys/Y6RNKJxMJhKg6XwuQIPaDKG8gjriW4AFm1QdjG5N6/lXJKlLt9+1rmjE1nskDTdYNIrEcL1Yyg7K2FtgwNnlVSz6ljphxDD5GOpic+HbSUBiOeXVaUmY22F5goYrK/fm2WqiRwQMSHgoY0qtPWeyfGPGzajiCMS9PnoLBSRzbefc7jrq7XCxyfHweDVEC+2nGxu7nmvqG6hDIwXdJeXXzan/t909MHL23OZA4XuyPD4UyZa8DtTaGZMzC1H2bRhHPxo06TvLYcoPFCP3Kd+ByV9utO2aYjfAtZKtiSPfRhRjKLzTTxgbXwhRJgfe2uT12ZJcVRMGhdirpKqu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0557.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.45; Mon, 11 Mar
 2024 12:03:15 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Mon, 11 Mar 2024 12:03:15 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [v1] staging: media: starfive: Remove links when unregistering devices
Date: Mon, 11 Mar 2024 05:03:09 -0700
Message-Id: <20240311120309.5389-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::24) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0557:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5f5e79-b7a7-45c1-fec9-08dc41c33bac
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gq+HqZDMiIlnbpg2H8oVq9pUX5hOZy2Nu70F+0yMnAAp7LnaHfnV0IV4mzzo4o4m827UYWhobfYCD7Bl7Kmp54hjgda4WLV6BcVYOh9Wnb+/iEoGFr3In9YOWO7YYLGv2q63GY7Pj/Z3c1Oq5VdVypNPi2henmu9um36r/LWkvQcZJPscIH+m3yQIU+WE2MzSrSab8yh6pBJJjILINCXoIELDPp+HKUqFpf9WnD0HTpfB8//XbzhcmZabbxdz29ojRbiGQ3AKjbNbq6tkF+T8ecPH9OqWHCgKB5waj4oHmqATYeD4Bruj043s87f2CFMYpALuF0K+pQj0AuTITOSQeRoCOn0tQ0DvBhbrTYK6Lzkmn/K0+q6wu5YzgwBJT5hg+hLcRJb7+KIViqFSzkSqb+92kgXXPkWZ4lS8Bx33jZmRiuweRtRZum8sq68JVQJjhLGa6odBcHCtDxFGfIGDC1p/rtrfbtBJ1H1IWOdagC8wTzFgo3Om6CDfV/SEi7TQe0JVJLotri8iLPP4+XcVCHpnFn33v5RUc4Ftab9Yd/QoEhjAl8CXISNSYQL+jH8JpmD8xeBFmMkLCyWyF006QQup58ZnUas360rT2hXmyQhjZOgssZYA9HIKC+PMaMQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pV3sxa6kwI2kadRBhCptBZH0OF30+MPTv3j/Nodmq6YgTgT7edejXqC33on?=
 =?us-ascii?Q?2ctbcHGk7U+GbPB3qmDjfe2hdxZSQ1nh7RQ7V1zL8pvKLhzfFGL3TFgVOPVQ?=
 =?us-ascii?Q?ElAkyReltGnpP6RiG5Lz1eLhphSQfpr8EYie4UVTM0inFMg9iqGG66T3gvCu?=
 =?us-ascii?Q?ZEUjl0dOpw11n7KE54v3fa2H13gyikaLR/468+fJS7lVfs1ydDrxMTD2E9Ow?=
 =?us-ascii?Q?L/7smWKjuxlSqCQayXacQDE3DWa9H+Q55eXUFHKCFDhF7PtO96pyqF8okkL5?=
 =?us-ascii?Q?qQqAYoqGt54n9sQSmEb6BSSDhcSaZ48J+5LXJg0oDM7y3vptJ2WYVi63etca?=
 =?us-ascii?Q?Gg1R1prB2JdFPOUQGG4Fd/nyFwvlyV8a+A3mPmXTQX5ZiPq9IAH+nfNmzqEn?=
 =?us-ascii?Q?iNIJXkXbKlg4dU/7ui9gvfBWrHiL2OWSlFOwHkVk0aN2D24WMfE+YD7BCqSn?=
 =?us-ascii?Q?1jz4mPINTCPDH5ECQYdwAD3DHB3VMtFJX1rppRQPVTo9eIT7mX0GTpM8lsPR?=
 =?us-ascii?Q?QwoM0y+PO3QdwpBBVzv0t/dzEqqNDTFGsxaoXd3xOrspJnifH4WTAwr+rkOu?=
 =?us-ascii?Q?zXnJBGnZ633lxdavxUi+YygAUIDVz0J+++22EM8kN/RVruFfeRJiCqutcalG?=
 =?us-ascii?Q?peHvJmLcHfkATVK4sdhhD+qiM8aIzcnB8HcsSFAQ0/HWxltfnoT8MyRZCGEg?=
 =?us-ascii?Q?qvV5wgl9Q//Kq6iXSMVirl/3AHmo6YchIJ1MsRSblt+6UxpxxDAcbfrX21Ml?=
 =?us-ascii?Q?iWTM7i011JVZYlX7GNHJyB62seuHjDUt3lf4kJXQfNP4Do42eRxSg35TkgWY?=
 =?us-ascii?Q?4LHXGxXqBs1sQGeYpXr5P7rg2IzpH0UieHGrUyDa9N+qcSr67x8d48Kikyj0?=
 =?us-ascii?Q?BO/wS7ZvSQozuTFFu00Hi22908hAYd18NDvJkZ5pM7iSgav6fjMC9idwpsRg?=
 =?us-ascii?Q?oqUZ+NF7/pKFbHpwCuzpC/So0+0fuR4W2tbTfhhf5SZuO2BfFAq+dBA2rHue?=
 =?us-ascii?Q?I8/K7SJSC7XaT/425IwyhY29TJrNrXIMxN+l7OcuMx/g0cOpMPZHQ4zShnOF?=
 =?us-ascii?Q?xW+dWmpddYrS4gapbOdqf6L8hds6t8i8feg95+9eeHuHB1H7Km25o15E/M+j?=
 =?us-ascii?Q?wVIF02LevHsODNqq56lRY9BnBj45ivPRmGNc70673Arsjh2pXwpk4Hf6BrvQ?=
 =?us-ascii?Q?+pOqU9uyBOQSs0aa4HF+232QLvsOyRewjWl9olLLt8qKEPq6zCVobv23NlGj?=
 =?us-ascii?Q?hM1O4LgxQ7tVUnC6cvGLUnH1aZ15W5b0R4DAdKSiXq6WOmfgmSo4QBuyKeHC?=
 =?us-ascii?Q?je+NH/TFoTE5zZGXxb7wxKWkxro0y627y+iA7Dq1fSjqU8GnSlNt+sG/nOsz?=
 =?us-ascii?Q?xBQkXi9ZK3GktBICcODLOSYZiBWiUZYViliREZUWrhrWFNWXg1z4Iw9fDDu3?=
 =?us-ascii?Q?RMu/Qzc+NdGjRE3QsGIJ5/hpZ/4zRS2H3xUj3Ou3q5NPwzP8C+/aDs7f+OSh?=
 =?us-ascii?Q?LiSvYymnA8cRufAHETkMJMKcWli//2xzaR9kakrzsFCDd4oTFU+HngtdiWj7?=
 =?us-ascii?Q?V9FWufOJ8bm9G8mnfLqF7U4TTjVDGVpL7V8gencdVi+lxBsAsXrDkN7oiP78?=
 =?us-ascii?Q?4dNqmk59sUrSUHe2UQNM3PU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5f5e79-b7a7-45c1-fec9-08dc41c33bac
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 12:03:15.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzHgvoxqqQDw+q7tgJIHwAxTkS69v0+vaZ68sQLHfdUR2BOGwuVmYgtlg7USwSC03kcA1prPwfAwAUxiFlGHSJfKLbhdKj6bl+PSP78ShWU72Dap5yyDRqHHySDkSCh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0557

Need to remove links when unregistering devices.

Fixes: ac7da4a73b10 ("media: staging: media: starfive: camss: Register devices")

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-camss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index a587f860101a..323aa70fdeaf 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -162,6 +162,12 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)

 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
+
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
 }
--
2.25.1

