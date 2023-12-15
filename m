Return-Path: <linux-kernel+bounces-332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BD813F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA74D284038
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F2A34;
	Fri, 15 Dec 2023 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="hz/kgc13"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB87E4;
	Fri, 15 Dec 2023 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BENUP7n032766;
	Thu, 14 Dec 2023 18:01:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=LKVaQNecMEFPPNLZD8
	1T4XJR+Pk3CDYOEklo1RCfqsU=; b=hz/kgc13K3Lw1sIDCFkvzdX43GZ7x23m6V
	lgGA8E4Q3exB6aZrUkL4sYQJ0PuPX7lythzLkUcAGroY0YAxNrDy9OrAshUyp++/
	u62/Fd67ES+5+S6P5FsyPsuuEJjNhHGTUhx86cdZ1FCFBkCJsVA2sYGxdNcReaow
	cyCowAT34vdXyfvV3ZeMFbJfap+UyhOW38fYUe7TzlgCCK5BEo84aKBMOFnnS7Ko
	7dw3m+s1BAOUwrFFUGGWGoVCVVW6TwkGW/OQm3Sb+faEpQkNF99wH0UEbNPW4NNC
	YLAkCjWClaFIMWIa5Br05QYdhFtf1BnvjGiI5hGPaXUc9Hjyl2SQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr9k14fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 18:01:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g20zeYnnLObdvexrg5QbfBUqTWMfGTiBQiZWPDYeCGQQTz7T85Z2HGI91RHrhSyJ7+pBhM/qFmpP8XzwpG0wpikWQUoroUy+StSxs9YYfbIP1NbTB0SRBb2c1feRdhhwJSdESPso48S4sTZiiQZhC5sfT/d9+PRScUKRfAzRTeA8ZUTMMXlP0lGQ0zHhX+R9LqOIokYfrTUOh8dZ5DoLAxMBzbDxgWun6ERvEj7xPPvB90MaiY40koMpt4jwoZjtH095FCzl4B1+bEH7eImkPcFw4morK7lzGGXuLdT+XWDlGlBExXWqWsLXcBo7uGzOwv2f5bI3v8CpqMhyTEOI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKVaQNecMEFPPNLZD81T4XJR+Pk3CDYOEklo1RCfqsU=;
 b=JvYV2FXUzwE5QWhTODMqMlVvY6+l1LVrZPp9ZvVSnf2Jiyup+dcqnmPQQNDcVx3qpnjivKAGmIFK/0Q3mhhwHLBVA4qfeD2wjqxXTfRBi0HncrgEu5rOFnFDBc1xXsZxBDt+dfOPP5lYeTYIe0KRDqvzJ9apK8iYIcPcONuOetSFlyZ9oI5cbtLimpMzD7+QwlHVv86gELFFXKnGT6kZr+1tXB58WpX8O9xfkIArVzD0jfsZqUyLA3MXxTfh/sk1J0MvJ64wA3k8PjNbUR2nmRsd93060+nRgMQ4HEr+3+Jl/QCtvEokhfUtP4K7LPYChZys9DYmVRhhKR12+d9Wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ0PR11MB4832.namprd11.prod.outlook.com (2603:10b6:a03:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:01:13 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.7068.038; Fri, 15 Dec 2023
 02:01:13 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: virtio: free driver_override when rpmsg_remove()
Date: Fri, 15 Dec 2023 10:00:49 +0800
Message-Id: <20231215020049.78750-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:404:a6::33) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ0PR11MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 76427809-6e57-4270-8533-08dbfd11b711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RriIH1Bb364iSCAUjzu5Qv02+FTbvM5HjQ0HNM8YXrncb51uC72PO+SJbG+bpp4PqEfgveYEsVrw3X1nsZOoHmWB7aBeFszGk77EohZ4LA0gySKbNDRun2+PFt5JAZkejOtcDKTrYa2sts/ji41fB0+0Gi9SAovjsxcPqL9Q/MXTR5bdLYnzCh9oge07KImyIUY9bSAqVq7FpFOXX6zYqdyG5nUFsZ6ZaWwPCwO5jfGBg6DCZ9nsInupXmVL0I8/0Mp5dfA9kR4QRtZXVxyGo/WhDJt3z0bd6ZRlP41E1W9xxhSso84JtZr8YQELns1hiTl2DN3MI6ZCbaDCtEoFWf65l22q1LArwdaniyTEPO4VVKw8L2AhTlloYg1XOSYG++bsxANu7F30RwNrHF5SS6XpkaRCIru9dDuoSWpHnW8rNXW5UFrfQ+7p41wJ9LMzoi5HLpoHP5mftHSgZrMt0l+gp4ZnBgHALWcF7hPYvrIn1ZDTohT94trs79XgoP1d7aK40dXg5oQdQUDvPP9MTN0B38Lo1NTI/gSt3EUujx+tDMUsoX1k6M40+Ui9pi8B2oulUHt/kUPbsDXW42aqbZyrE3/m9bgjE4taM0GyBpltSflpbFoNiAhqigmjZpcVvoicEx3y5VynDxZcVmj3xQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6666004)(8936002)(6506007)(6512007)(8676002)(52116002)(4326008)(38100700002)(86362001)(5660300002)(1076003)(2616005)(26005)(316002)(478600001)(66946007)(66556008)(66476007)(41300700001)(36756003)(38350700005)(6486002)(44832011)(2906002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hMcWoEJMHLb4ofuFxPUhikSRAulrztBzAKyIQEnfxGk+h+nB8fGilKKHEw3V?=
 =?us-ascii?Q?Bj7+Wk0pRMlKbrErkR6CUl8Xp3IviHbln4hT6pXtrVFC5Lh+4PJG4f227zm1?=
 =?us-ascii?Q?TB9vt7XtUSCmM3GYGUBJrsnF3KiZb0qrThB25WT4pbY/WOekuPPbv/3VElbI?=
 =?us-ascii?Q?12WQkAWEBfhmap87V6Y71zUq1gKNL0jjHCVB9MzcTQ5jDSjdne6zTCR4sVbs?=
 =?us-ascii?Q?H0ZlvT2TrgEGKU3UP1voTy3gpwilURtXbN86uyKMMNKTMGy55FUSX2aY/l4a?=
 =?us-ascii?Q?jfeOSYQzWOpaS+/mBu4DfU39aYJBpQM0ONOUARtjOjsbMRLijuziKzctsumR?=
 =?us-ascii?Q?HjGENvfdiDVz6Ctj8H9TU3mcJJGfkRoBgciHD2rdMRWXun/Q1AMhmsxFJx13?=
 =?us-ascii?Q?2WOn06sK5+HEO60oTiVUKW3xdC9dz1VL+S01ErlbTzr9BKtcurAQ9Uco6i1u?=
 =?us-ascii?Q?rh7Yy8IlZl7dp+7G9DRtpWwgalnSes00vtgQf/rA/qBh/vvMnBZet1ds2CXh?=
 =?us-ascii?Q?z3MHx96+mIdWTNBbA+Im46jCtTTDtfV3NrkRFGzYC2d157azaAsQbgEceQGV?=
 =?us-ascii?Q?onfiXkfrauV/X2hYGB7jtlglhwEA0oiz+AXL8USTtvxspG0BLkI2tq0ZAQXG?=
 =?us-ascii?Q?twgrhmZNW2KtlfQQjViDWjKsWfBYQGHYe1Gr9SzmS0wa04oEMFidp1MPer4v?=
 =?us-ascii?Q?QBHsaW4eF971XRyBwI8N9Y0EqFbjn9Ytf8yokcbavhiI3rtS/vqY8YJNKg9Q?=
 =?us-ascii?Q?/RVhnAdlAS01A6KzRjDsU4UlS1ImlWT9H6BhAeD1xc5GGTedohxEcYQIcJ/0?=
 =?us-ascii?Q?7BhepvDFbuAiLMZ/PTV0HzQTvxsYGRNaYx302pwhOZ+9Bq6xCLpbo8ciCwcm?=
 =?us-ascii?Q?ZIOgP8palKfNubTKfaKa5jk2zbXtLxdpRdrhm24BnFRI4Z7cW2ezFoNHqHA/?=
 =?us-ascii?Q?TYXebn7rFgYsH3uMTFI4Eva8b54QsceFJNleQI8bZC1B7VtE9M0TKQTK3Tpj?=
 =?us-ascii?Q?F6IT2QYDDQGioUi3eblLU4rFv+fFMTLz2hA1TO+eAA6XsppenFPLbayJwiSi?=
 =?us-ascii?Q?MXUskE4hlB0h83h8auLjnFMGgjXwM2ycApV86yyysQYSkVEhXJLGNUbsobR0?=
 =?us-ascii?Q?+1pnfvO/0BvwRsmadlTidA9bdpPZ32JCA9ov5YdL8gjIQ/5Xs1AYR3TC0kRs?=
 =?us-ascii?Q?FDgGmJHdkFN8g3qBGXm91GwVZjLAZMzLQt2nBWHUVDCQhJOKqB/55Vl6PDZO?=
 =?us-ascii?Q?7KRy7jVhzwgmVjruNYL2CmYeR/S6BlfXDxmUze2TbXNfgaYBJ265Nf5yrDZF?=
 =?us-ascii?Q?mDjfNygtq4MvdwlbqDSq+wWG/eVNmLsJaKnFXkYyM9PG2d65i4Jrpiw+aDC8?=
 =?us-ascii?Q?TArF1lPcD5OXAI4L3rVZazhtj+Afdl4kz+Aw/ixRxGOYoIhc+VnAreU7rTbQ?=
 =?us-ascii?Q?YfILDblvR0D9k5MUlxXeIto+5OqFEefLlWOe7kflVd7VJGUCZGLD5g5DFHXK?=
 =?us-ascii?Q?TyHYSNT5QTTkxzypMHPEbXWIcPLXI8Y09iUCWZcLl4eNYzr5NacFdEuJbicG?=
 =?us-ascii?Q?juo1MX9ohSWRzjzvxezMDAUqtAVpZKctSZ0p5faXUu+nAcJWWzbAPsToFsG/?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76427809-6e57-4270-8533-08dbfd11b711
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:01:13.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dQzN7DGEm1GRLWeGAdW8jxIy7lPvuBpmvyMO/tTS6m9lDXi7fLyomrZJrnVqP7qzxXrI5za7G4ObB160EeRM2xp6QsYbFmat6gJD43Meag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4832
X-Proofpoint-ORIG-GUID: GTDKXRdVvYmG75wXWvNc1_m3q5mT_IeE
X-Proofpoint-GUID: GTDKXRdVvYmG75wXWvNc1_m3q5mT_IeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150014

free driver_override when rpmsg_remove(), otherwise
the following memory leak will occur:

unreferenced object 0xffff0000d55d7080 (size 128):
  comm "kworker/u8:2", pid 56, jiffies 4294893188 (age 214.272s)
  hex dump (first 32 bytes):
    72 70 6d 73 67 5f 6e 73 00 00 00 00 00 00 00 00  rpmsg_ns........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009c94c9c1>] __kmem_cache_alloc_node+0x1f8/0x320
    [<000000002300d89b>] __kmalloc_node_track_caller+0x44/0x70
    [<00000000228a60c3>] kstrndup+0x4c/0x90
    [<0000000077158695>] driver_set_override+0xd0/0x164
    [<000000003e9c4ea5>] rpmsg_register_device_override+0x98/0x170
    [<000000001c0c89a8>] rpmsg_ns_register_device+0x24/0x30
    [<000000008bbf8fa2>] rpmsg_probe+0x2e0/0x3ec
    [<00000000e65a68df>] virtio_dev_probe+0x1c0/0x280
    [<00000000443331cc>] really_probe+0xbc/0x2dc
    [<00000000391064b1>] __driver_probe_device+0x78/0xe0
    [<00000000a41c9a5b>] driver_probe_device+0xd8/0x160
    [<000000009c3bd5df>] __device_attach_driver+0xb8/0x140
    [<0000000043cd7614>] bus_for_each_drv+0x7c/0xd4
    [<000000003b929a36>] __device_attach+0x9c/0x19c
    [<00000000a94e0ba8>] device_initial_probe+0x14/0x20
    [<000000003c999637>] bus_probe_device+0xa0/0xac

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index dc87965f8164..1062939c3264 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -378,6 +378,7 @@ static void virtio_rpmsg_release_device(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
+	kfree(rpdev->driver_override);
 	kfree(vch);
 }
 
-- 
2.25.1


