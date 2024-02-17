Return-Path: <linux-kernel+bounces-69906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888F85901B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2775281F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551829421;
	Sat, 17 Feb 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IbSwpNi3"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E241C63;
	Sat, 17 Feb 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180283; cv=fail; b=Inz9sF7vyV3+51aEER7wG/3OKTigi6vmRYlQrEaW6JG304cHzErZ9HUkkKFYXK4wqzAn5r6W3lwFrgS4rBBqmySMMVbDJ4aZbXtP6YHOInYK8+fcykCjI1Do5zu7F/euPiEHLFGbPVJT6RScijhLMOGXLBXjQ07I5xfqhbu7Xxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180283; c=relaxed/simple;
	bh=knB5Wr0EdvldGQRBN5rgKEiI3upQjgeFbpoodzisEAA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d2nQSPuKfHBeBKLhB19NWY83qhpxWJaql7DqulEXp6R1uVgHFU8KWIHGfJP/qMa+rltnUYNus8Br5dJoqYS44fZQuHqQPBMc4fa7vdJWG+9Sm/t+kvOWQty+fjiDfZ70OP6uGVXV6b3xIresXrM35vJozPayhFbpeH6PRx5XPJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IbSwpNi3; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HDfIU4002150;
	Sat, 17 Feb 2024 13:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=mF0XP3Dq9AaRaDfxaQ
	QVmxh6UnzuW/dbeRBhpf7Ent4=; b=IbSwpNi3yOsrKhgsHzQLKxODoGdYk5Mb/6
	euKAt8n9XXio2vmLqU5ofDJImud7uPcnh89YnioSQJP9dRCymzXYdXjNPesMXJMu
	04wm015B+txHr3CjIAiWTHmHUdaH/2uThev+fwLFwPz3FTNDf+TPRCuesym6hy1b
	aXOrJ/iX8h06S5yBmYhowcIt23dXSFe7Z3CLNqOFn2+SCOTkD20vKVbDDMPLmK1K
	SaQ38emeTCygd8ZA34VPN6gJujuDK78a+HPbZdKlROHWaujDV8PbXZ3F5SvrgsK8
	LJeRJ8F/n+F9GEKoJ4odB57JkEo+WE4u2wPqM18PF7MecsvQxH1w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3waks68a5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:53:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuNkqiYVyM1pkcCka8TBpYyF01mydrhwQKkUONVpJiNggvcteSI3yyyJZNGbaigd6AgDxhgC6Iz1ng3oO2hwwVtfn7YNuEStyej9am/sRV9MhZ+9JKnLmkG2xHopohqs4WBFeBz3iCAeX1z/TdezMoxJKu7iEB1hKQTrG5QrIJxppbChg2AIx0jV3jfNoJxQilpQEK8v52LngZEGv4b0kdPDdllYVaZjALuw7bXIgRims5ofBEdeRsZ3bD8FBC+p2lmPSqi9GZOLG/qxT8Ek44sQbzshwwU6QwHblbcCRcb0M6WXbQafeTdd8vLL4KyKt/XI/KZ3bT8qae4x+4glYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF0XP3Dq9AaRaDfxaQQVmxh6UnzuW/dbeRBhpf7Ent4=;
 b=ea5huz+F2XXTfqiBm2vpxJNc+XOxeGABmsNeGu4nOwk6hyvmPu9qLlS68KOqOiGKuyibGYRYrGahILeNUNEPmDGRI+3EWavSDzoXTU31BZxO9H2J982duXgyTvBxFoSO0+n5AwQKQUDXm5Sgk9jCPA2+82BwgzsYZxTx1FTc8HFVA2YJiWYvlkUP9atHODc0R+JoOPagJ7vYV3t17XjuX2ijUTHe6djcM2WiQSs37T+LMNr5exvaqcjg/P/363EeoZNJEqpeg5dc2seHH2/8V80SiopU1YzwN+sxNZJSImxqz4rhKAW23/1SW4rY5BuRvh0QtIC3y7+TJN/P1Kzrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 13:53:12 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9c74:bf8d:9e30:b9be]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9c74:bf8d:9e30:b9be%4]) with mapi id 15.20.7292.027; Sat, 17 Feb 2024
 13:53:12 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: linus.walleij@linaro.org, brgl@bgdev.pl, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next][PATCH 1/1] gpio: Delete excess allocated label memory
Date: Sat, 17 Feb 2024 21:52:55 +0800
Message-Id: <20240217135255.1128716-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 001229f1-52b6-4720-ebf6-08dc2fbfc7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XXkhOsTdFeBLmgqbMNy12eAroeiRadBFau0Va9Kv2cHSM12e2oEML6U/dgPBqDvekZlTtT6qq7lqGRhGp+iqcJ8/QgsLoh1rAoGQ7mMjjC3oGPUyxvRKZnunTR9Q1se96hXxHHHeDa4w1BQbeIBhGyEyKcZhqKepQm04y7a3v5dFywZIwwVOcdbJyb80ERgHrGxOnVRqvERpdbVbos/ha/hTnMaHVYEFf+cIVSIaVHlk2d8M2+URCxpnyHEw7VxOwRaG7N17s9OLrSyT40K2aNP2p9aBoKVgz1ixOsRjTD133fcDnUkPBfI2wdIyZKcP3UcqVZ2q9mhIqoS+SXP8mhX1MOXPGYX8XVrlhIuKvU/reyoerq2s3Ke1tNTrVVJIHrSxlpQ/2dw/K4et4NOY8vCPFthvQbFFa4SRZjAOpUYNdw3cHQov7ziSrE0v9tWPAzIPTZJWJTGWnabVgCOlHGGFeDlUEh9uezJiwe6tFfrVZXwv1q/V4KhlmYHZ9kqNO6nInlD4tZpQbLPiZV3TE0M3N1bR0hw79borTV6n4bEjjUjHh2jSykoY+3YSmV+DULUMoeOgIOMS5/KV5j6k7dqWw/7rWD/5cruT7Ct7582u7ffAZK45Mlp9dgo/nROt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39850400004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(86362001)(316002)(2906002)(6512007)(6486002)(8936002)(66946007)(38100700002)(1076003)(66556008)(66476007)(6506007)(41300700001)(8676002)(83380400001)(6666004)(38350700005)(5660300002)(52116002)(478600001)(44832011)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XDBBUxVHhNxhVAump27ku61Hcgz6Q4/RKlB9wUHclQvh3R85BcMp922UZr7P?=
 =?us-ascii?Q?XbmvfhBh/W9aVcFskko3QnLe5Fa5XBqNQqsajRYxMFp+zEFuPDOUWS/qB2xt?=
 =?us-ascii?Q?oqJKvCDQOrpFameOPT2y/eCWPrdHUp4Bc8lT2URRyN2V+g2VqfWfGzK9RUgF?=
 =?us-ascii?Q?D9k77O1usERA2v4mm2HXSNXotRZ7t55AWUJByZt6SHDHKXE5zgHynxlpGKvA?=
 =?us-ascii?Q?5mCj0Gdu6tAZP9YAd05iBgdXHqD1JrC6iqbht22pUUXjUPJaWsyUKhKFHU9r?=
 =?us-ascii?Q?s4ng6kevkj3csQl+vRaEUIQtEkyNRlzTlcYrNuhMaLZU6eSvuPntqu/jBdsx?=
 =?us-ascii?Q?O0sB4JBDp+mTLDixz/ySVp3/VmqWl73XB+45+9lKqWGV7seC+I99cF7E3Eb6?=
 =?us-ascii?Q?V6Ngytfbros855yUJWtx+lXhLgfhs1BMzcilXub73yhMx1WetNAgZigx7jLW?=
 =?us-ascii?Q?5DOcRP3qi20a+HiNucMavxumnwFQwLaAkF1DWm/qPEE8lVAXeDj+j9sshara?=
 =?us-ascii?Q?n4OJSZsISE0g52d7YQ0/owhxsMSuDPKvMBgoj17RcsXqFHh7eUQq3oFfXRey?=
 =?us-ascii?Q?i0lcU1HUHlFuH7AWNGA+6hp9glmNpLuEIUbl29n2EhfSHQLDvg7mOY69LHyn?=
 =?us-ascii?Q?kOusXbkmthYs6859aCPgvN1df3yi7JZTNRnoQ1vuoR6iY0vIhTfNRXH3KCOY?=
 =?us-ascii?Q?5RfTiQXcSl6Y31RGjZbosuN3Zv0Zl0eSkWmvSndRbL8R1VUav8544UdeEEH+?=
 =?us-ascii?Q?40gQ3hAMVdoKniM02s0gtKi5QItxmFbxMXqNY+Er5u0RMOumJEzqAdwpkASX?=
 =?us-ascii?Q?vqsH6gEMEkB0G5gOcbl6+Y/bKBwTXUx5Xinfebp8kFVQGwVmqNtEs/7tJ3S8?=
 =?us-ascii?Q?Ew3syPOxt+T/yAxTIsKZy9yl93DBUr/Cl9Z7DPOBon4gAQBNXA8gLTU3ei3w?=
 =?us-ascii?Q?sZZfjnU/puODKW8oLSKAv/wXa9SEigH1Rw3EVBY0JYCSaee5PswWZFW/3nUY?=
 =?us-ascii?Q?CQzmg+EBaGCe07+LPZq2+MgnM5jmk4R7QZSNhDEnPvj8G3dHrl6fRBtPhdDX?=
 =?us-ascii?Q?D3/4Boh2LsokCF+pmuhtnZE6q+siq8amglIntamdO/ZsKd9zacXVrjdv/QxM?=
 =?us-ascii?Q?eYRKdu934EKNdylyRc39HTBlsycxZtlS1ij/Q9nZJ++JcCgwpVUQXO5vurmC?=
 =?us-ascii?Q?95Ew4ITBqex5kXqo/zG6UMgikDFP4lW3ZsP5X/G1aYJ+W+qOA7RXu3kPlWpT?=
 =?us-ascii?Q?BCacQ5z1L6djOlihPAN08PnEplsfuFt0vt08v/l09TV8atqrRl6nYHqpW2y3?=
 =?us-ascii?Q?uI/8VWQykBEkDpIw38vJ6/RSnYH6KqVYk5topael1srpp1ERHryJ74tPGK+z?=
 =?us-ascii?Q?wZwUkVov/curEhhnoFc5rEh3RMXgeW3ouLvn2bXQl6EpqNm9W0W1yfMuwKWr?=
 =?us-ascii?Q?MNIdAK2LzHaEaFMCKRZE/lva3RFunT4RNxhKURpiyP0smS1gNPOPTqgmKP9i?=
 =?us-ascii?Q?Tf+E8sVHNxP3T+tP3RylfAvyMJ/6oYh64dKe1P8pUmRNxBw542UgwcZc0ydV?=
 =?us-ascii?Q?MxHPV14N8uiAxwYbNfj9lphI9XtoyK89UxkQiN29jU6+V+V9RyiDzBeU7w2A?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001229f1-52b6-4720-ebf6-08dc2fbfc7d4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 13:53:12.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9YQbjTru80Oq74popuy1e2gN/hiiX2kbLGNWxb5Vm2S09i+K7bIv80vyMrGIDu+usqkD6gPVXr+gvM2wrw419U+WODEjoBI1bcPLPmF/ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-Proofpoint-ORIG-GUID: JolyDotmc4MYXIp8SC1m92R6vD2hlTSE
X-Proofpoint-GUID: JolyDotmc4MYXIp8SC1m92R6vD2hlTSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_10,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170112

The changes in commit 1f2bcb8c8ccd ("gpio: protect the
descriptor label with SRCU"), desc_set_label has already
allocated memory space for the label, so there is no need
to allocate it again. otherwise memory leaks will be
introduced.

unreferenced object 0xffff0000c3e4d0c0 (size 32):
  comm "kworker/u16:4", pid 60, jiffies 4294894555
  hex dump (first 32 bytes):
    72 65 67 75 6c 61 74 6f 72 2d 63 61 6e 32 2d 73  regulator-can2-s
    74 62 79 00 00 00 ff ff ff ff ff ff eb db ff ff  tby.............
  backtrace (crc 2c3a0350):
    [<00000000e93c5cf4>] kmemleak_alloc+0x34/0x40
    [<0000000097a2657f>] __kmalloc_node_track_caller+0x2c4/0x524
    [<000000000dd1c057>] kstrdup+0x4c/0x98
    [<00000000b513a96a>] kstrdup_const+0x34/0x40
    [<000000008a7f0feb>] gpiod_request_commit+0xdc/0x358
    [<00000000fc71ad64>] gpiod_request+0xd8/0x204
    [<00000000fa24b091>] gpiod_find_and_request+0x170/0x780
    [<0000000086ecf92d>] gpiod_get_index+0x70/0xe0
    [<000000004aef97f9>] gpiod_get_optional+0x18/0x30
    [<00000000312f1b25>] reg_fixed_voltage_probe+0x58c/0xad8
    [<00000000e6f47635>] platform_probe+0xc4/0x198
    [<00000000cf78fbdb>] really_probe+0x204/0x5a8
    [<00000000e28d05ec>] __driver_probe_device+0x158/0x2c4
    [<00000000e4fe452b>] driver_probe_device+0x60/0x18c
    [<00000000479fcf5d>] __device_attach_driver+0x168/0x208
    [<000000007d389f38>] bus_for_each_drv+0x104/0x190

Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/gpio/gpiolib.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 02be0ba1a402..32191547dece 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
 		return -EBUSY;
 
-	if (label) {
-		label = kstrdup_const(label, GFP_KERNEL);
-		if (!label)
-			return -ENOMEM;
-	}
-
 	/* NOTE:  gpio_request() can be called in early boot,
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
-- 
2.25.1


