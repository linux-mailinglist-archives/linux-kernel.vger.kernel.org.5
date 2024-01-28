Return-Path: <linux-kernel+bounces-41527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724383F3BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D31F2214C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0456116;
	Sun, 28 Jan 2024 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="MsZ1r1AM"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF40802;
	Sun, 28 Jan 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416216; cv=fail; b=Ypx24Y14v1ijeTQ04GfYWfWVCv9J3Po5eyv2gjICOS6WgPkUUcDCp71jPs59tWNHlldyt9OcTl1G3FUnioTTilDE87OjYViitQNdJ6y9l2DfqV6aL9WrxiiHWrs1WUKFUomqtKmUOS2317+sNnKukl4lbuFoGIc0wKhx/yggXIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416216; c=relaxed/simple;
	bh=CMcx+HyDVx6kOCk4/RwVQRb9BKeNA0hm25MfZulnFNw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kFPyXuKxkaSxv90rgNEtjbEAalgGRGTh6zEWCIoHjTIKDiitZ0+AMJu3Sy65d8uEMFGhpzg4wCCl15zsf/7UThJC/O9bqrbd2zxX521q4eilLiOpgSUk/nepjNzhqRvUh0OYvko5yKrIGhVHFf4TiN+kyj7LTwdMXl4uplLANO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=MsZ1r1AM; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40S4TiNg013077;
	Sat, 27 Jan 2024 20:29:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=solEeJm6YKb3PqyZGK
	iMtT+oQhfT85NJMFCceBi78l0=; b=MsZ1r1AM+3wotyO0Y74lam7QCNJ0O5Vvdt
	SezVkA6A7yt9YWCEpnOwIePLnlEdssExgdS9IZ0jUVGVJ5BSe90mboUcnGaECVyP
	JpRe+qMoi2xquc8OiI/qXodeHBJAEBykjhImOGETK003LfXeuEP3QgjVOGYyX2qq
	r3+ffFmt218v0QsosiQYzEd8PZJRar220jupuiZTKXKGvdhhxxrpukTIyOaUJxfX
	3d5l1W3DI2w4x2bKAN68lufQ3GQwPjmRDm3t3BhzJQNuQreHKSOlMlKDfuL6r5ey
	+20+66Tf5hRbD8I8Fc3ELbPhBiku4y/bQfBY4kDtN3U4Uc+B2vKg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vw27kre4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 20:29:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH2Gg5LrmCz3wJRnR3yHjG/1sQ+dbVi2HJz8/P97L6713xKS1+cFSD6QCTmoPmrSG9jTLMNwqEQpLLms3nF5puAkuk98SQntGUqmyIhwWsi6+EaVM9SpimaLlVnoIP1+tVBxJ1xTjLP9AIoBfLTlpMIgiDWVcpII4N6D27jq5WBbkwUR4gpKzdbGObWcU8J9J+o+jlRs7HhOwhmHODKett2OeujeLDeD5OkYD2gZ8bu1C22B63e3S+KLsUfS2OHTh/iQUIKbAZ8w6u9/4FdnV/WOgE/D5DhCWG2jAjgR6XRP8PH9jg0JCA2s0dn3WJRvOZIGetUv487/IKVrG1tZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=solEeJm6YKb3PqyZGKiMtT+oQhfT85NJMFCceBi78l0=;
 b=KpYevn8Tn/MGr5XhJBamSi0CpbMRsa3fHicwjjHVZf6jw+wEyfauis4nppZ0nFQ6aMMmc/TKass0xfm7nxR2Lewe2nd++yIzFO97NPqBkd5sD5vFXFcpVgFhgHjQVh8nuwZ0S2+YL+gM1WdFQu1Jyu8zzTmNo2DBVdq6HdvhsoahNC57Gk76vlLdU9+8U4a3Xf1dHhhBWovOUpSNqWd+p+AMpF9dYzsoGLr2BylhEYgtUhPPdsksu2Ali8HH6Hb3s6cqfHqc0vxj8xYpmyVuO2hb9fI8qnF0uONd06LDzOdKHcyHyrAVo/wlxz8OOaHGY3kgHSKGwEOveIi9qBSaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 04:29:38 +0000
Received: from IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::740d:39ba:9695:b0a5]) by IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::740d:39ba:9695:b0a5%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 04:29:37 +0000
From: quanyang.wang@windriver.com
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@amd.com>
Cc: Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] crypto: xilinx: call finalize with bh disabled
Date: Sun, 28 Jan 2024 12:29:06 +0800
Message-Id: <20240128042906.557038-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To IA0PR11MB7402.namprd11.prod.outlook.com
 (2603:10b6:208:432::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7402:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f4000e-ea82-4c70-5a63-08dc1fb9bc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s+tEcCVHEvDc30AQrKjji6zwq1gC+CeZpYHNoGxlKcpOLzeHyF2lgYRaiTlqVpZbflXHlLJQKegNuAASeR7xGUcG7EO7Xh4+rXdPa0EHb97c/LRQpU75RGXvLl3C+ZKiqB2fjmpOjG/MGgypOsTzUO7UsJSSHuXu1mHZhK3duvMxXE9nHMhe6d2bwmIO1ZtYoRv5Mdx3TGOqQScz2eXVt3yVWLCcICx4PznEumclBnXT2pTlp6y4JdxS4krFYdzPdq5Vt6k/ZpfYgf5zUWIHVUrZJ0P/FgICi3ToiBbExyjW/wn7u2JPqdqE8nzYoRjQRsHijENf5E1lvYQAbIUW2bbxqQsxGQe7qrSI1z8g/crxEs55fbpd2SQxCWJi0u/sSmvABeEEg89QNdg0wuZtIj1/gp5ZACjskZLHGjqxVnBnDnb4wVfGeC8we7FWzemZYZmgCbfBhhbATc4FvjYtuQGlHnc42o00/7p+7kYemZBcWbqAoL7YJs8iRyllTJjgDORYnhbGIHd0jiiPx0ivEFQRaSkWxRwHkeyKHy8ZquPKWBTxQbqSjxifWT4k36/TVJIXwAcGs0CBty1ut8JKYhqX0RVkY9RnH0Z+74vNss4OintOtPfAkaE3V2g9sGmDXycBpgcNECuf3Vj2HdvfVPFka1iQhVsOFAoqKyf4qGE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7402.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39850400004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(8936002)(8676002)(4326008)(2906002)(5660300002)(86362001)(110136005)(66946007)(66556008)(66476007)(54906003)(316002)(38350700005)(36756003)(38100700002)(6506007)(52116002)(9686003)(6512007)(478600001)(6486002)(45080400002)(6666004)(83380400001)(26005)(1076003)(107886003)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k9NckFh1cgPGSHvV5D5tUusEyorowe3ThL1s1Ia/gLOhCLZnWbEXdia8geDK?=
 =?us-ascii?Q?xGAvLcJx0UNy29Rug19rEShqg3s5DLKxo58mROUVnqxA7bnx2XUpjSQcFN3m?=
 =?us-ascii?Q?TO7wT8P4MqJkYwyhM5DuIXsF13P1fsRYGcoyy1KR94TkfOP8Dc5rN/IljE+1?=
 =?us-ascii?Q?un1UFaUTyWP+wSukT08+LpwsN5WsAG1WT/DwSfHSchD8Z/gwwMdEtaRnSDFx?=
 =?us-ascii?Q?Jn0v9SoDN+R+crdwP3px9M/5XRs9GI90H3IDR3bTDxx2M/8BRxrxECu+lbEo?=
 =?us-ascii?Q?wbnR/0mOHRmGQX/I7GJTnwNTPUsxLyhT6XUN0rF55rlmw4+9UECl0am9SPL1?=
 =?us-ascii?Q?AVfs5Aen3nzFwCyO+YN1evvB4YroidgLufFSkULdf7T8Wuw4yrPa8NYDt/pa?=
 =?us-ascii?Q?gFybRvSunc20fs7Orq2sVCBaF8S5Ptm+gr0yVN/S7n4doHVhzNil53KQ7Y0D?=
 =?us-ascii?Q?CcuKbuAAMHta0kjEDLOT0MvcY1PV03Y5hr8A7GgRwAdHk2Kp+rlgjG3WmGJi?=
 =?us-ascii?Q?MsPpE6CHNgBfHq5lJzgQlTju3DYU1JCs4qMKxuzrHUeLJKc4B/QgM7Rd0xml?=
 =?us-ascii?Q?jm8zIC1c0X9w6ZBh8kggY8P8M5ylYaHyRWvL/Wv7vOTHvs+P1ikEcyswLg7z?=
 =?us-ascii?Q?PkyKGF2/QVDJxXS4o0JvuLeaKbnFS+bBb9UCmLJCS2dPKuy0iDP7f0iYwug7?=
 =?us-ascii?Q?sxMOnAPhT+vzJImQfDs6M5ZX0OWUtsdl2937oyt5M0NKoFIVBYLUJuYTpaoX?=
 =?us-ascii?Q?Q/7O65Ik8DUoegI0QhHjIDL7K4Tutegr+/xc+WozeI5pVXKLJbVN6Kk+7ol+?=
 =?us-ascii?Q?oyRrrsdHM4AEw8XQEMEbPXQqy5lNoA97UkFgRTnxWkETOl4VvGMOGwobiiOL?=
 =?us-ascii?Q?p4mekRBCfau8NZ80kBZsx7ccV+uq/RBrybF2T2ThVmxhuAOdms4e0ldlh2CZ?=
 =?us-ascii?Q?6hXUzeWxmjhZF0LYlfjIHFighg24ClanKMwwtCVa/wZYAbeX+54RaVvepQiM?=
 =?us-ascii?Q?gEQ2VRP0isFVTwvp0q/22+G8gvc8HYqlESpN94XhO+yhH5RpxyW++e7aLago?=
 =?us-ascii?Q?VY5jY7NNp8HR/ITvwX+4YEvWH/5OxuGNtsPZ75MbpjQqZM4HHfW2sqsAG3CL?=
 =?us-ascii?Q?rBItIwkw5q8jqK5ctAJDyi7fFgeT27qUJufk6JbJQVKGp1myStLLDQZekjEf?=
 =?us-ascii?Q?iCOnB7hzE50M2Zv5/I9HTXn7Arc8waMzbOMz4/2zdiuO7DdLnz5yaYpOBTCx?=
 =?us-ascii?Q?626ZUKyhBewZRfjGE9Io+A6SQXMlpyO7gYuJt6SsHRBSpFa/PoumjDCbaDWZ?=
 =?us-ascii?Q?fbm547KnQqSB4Y6hLPFx1io8aRa3fIoWhTZpU8Pv9GOTazcd5hknQ8B2hk46?=
 =?us-ascii?Q?u7VM0Op6dt65twoZxMAPZypFN0UtvoGUHcQyN4H6b2gYxr6Hp8ufZTQ3Zacd?=
 =?us-ascii?Q?ajzsWLQUfDZPwZxVuTZ3joIOgez912rfAQGlZDCcLd2NdOdLc/et9Lru12D3?=
 =?us-ascii?Q?6eamDGNV0ELs1RjilIf/5Pe4RLMlDgAO6ZFEQ64FL/y25M497Kccyzd08c6a?=
 =?us-ascii?Q?Fk3MciVTZ5DaMZEU3Vq2tSn+EO3BuHxu1VhkcgLXTpiu5Zg3D5s04MkYB2UG?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f4000e-ea82-4c70-5a63-08dc1fb9bc72
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7402.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 04:29:37.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQ9KmIw9jwRpmGh9j6gzzpEjNSGGy5clCABovDpDG6oR1km9upjT0kSByuk4+OZ0c7lfyVLiDES0vquUo56jdb4ZlptI3vid9zBlJHpEdKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-Proofpoint-GUID: qUXDgUUcDhpDsU4Tr7DHnzULifxRPUoD
X-Proofpoint-ORIG-GUID: qUXDgUUcDhpDsU4Tr7DHnzULifxRPUoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=705 mlxscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401280030

From: Quanyang Wang <quanyang.wang@windriver.com>

When calling crypto_finalize_request, BH should be disabled to avoid
triggering the following calltrace:

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 74 at crypto/crypto_engine.c:58 crypto_finalize_request+0xa0/0x118
    Modules linked in: cryptodev(O)
    CPU: 2 PID: 74 Comm: firmware:zynqmp Tainted: G           O       6.8.0-rc1-yocto-standard #323
    Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
    pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : crypto_finalize_request+0xa0/0x118
    lr : crypto_finalize_request+0x104/0x118
    sp : ffffffc085353ce0
    x29: ffffffc085353ce0 x28: 0000000000000000 x27: ffffff8808ea8688
    x26: ffffffc081715038 x25: 0000000000000000 x24: ffffff880100db00
    x23: ffffff880100da80 x22: 0000000000000000 x21: 0000000000000000
    x20: ffffff8805b14000 x19: ffffff880100da80 x18: 0000000000010450
    x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
    x14: 0000000000000003 x13: 0000000000000000 x12: ffffff880100dad0
    x11: 0000000000000000 x10: ffffffc0832dcd08 x9 : ffffffc0812416d8
    x8 : 00000000000001f4 x7 : ffffffc0830d2830 x6 : 0000000000000001
    x5 : ffffffc082091000 x4 : ffffffc082091658 x3 : 0000000000000000
    x2 : ffffffc7f9653000 x1 : 0000000000000000 x0 : ffffff8802d20000
    Call trace:
     crypto_finalize_request+0xa0/0x118
     crypto_finalize_aead_request+0x18/0x30
     zynqmp_handle_aes_req+0xcc/0x388
     crypto_pump_work+0x168/0x2d8
     kthread_worker_fn+0xfc/0x3a0
     kthread+0x118/0x138
     ret_from_fork+0x10/0x20
    irq event stamp: 40
    hardirqs last  enabled at (39): [<ffffffc0812416f8>] _raw_spin_unlock_irqrestore+0x70/0xb0
    hardirqs last disabled at (40): [<ffffffc08122d208>] el1_dbg+0x28/0x90
    softirqs last  enabled at (36): [<ffffffc080017dec>] kernel_neon_begin+0x8c/0xf0
    softirqs last disabled at (34): [<ffffffc080017dc0>] kernel_neon_begin+0x60/0xf0
    ---[ end trace 0000000000000000 ]---

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/crypto/xilinx/zynqmp-aes-gcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/xilinx/zynqmp-aes-gcm.c b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
index 3c205324b22b6..e614057188409 100644
--- a/drivers/crypto/xilinx/zynqmp-aes-gcm.c
+++ b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
@@ -231,7 +231,10 @@ static int zynqmp_handle_aes_req(struct crypto_engine *engine,
 		err = zynqmp_aes_aead_cipher(areq);
 	}
 
+	local_bh_disable();
 	crypto_finalize_aead_request(engine, areq, err);
+	local_bh_enable();
+
 	return 0;
 }
 
-- 
2.36.1


