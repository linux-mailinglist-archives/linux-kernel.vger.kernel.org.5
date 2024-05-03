Return-Path: <linux-kernel+bounces-167418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A08BA947
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F88B22A85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54814BF85;
	Fri,  3 May 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XljgjdAz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xyp5zQzr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F614A4E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726681; cv=fail; b=UyW912LQnOmJOJ7sscwJh6ZE86kLmmxskehi3T5oNTse+GgC/SJvTMMwW6Soeglmh/GLOq+DjdFFz80QsyjZh6A3ycUulz/kqgIoWsAdxwC93bhGX+Vx/+wD5P2NpgUGmCFiQvNSQbpN47c8HhxlSwp/6CJzctMLHx9+32eJHZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726681; c=relaxed/simple;
	bh=Zht+7pk+ssLVdC/NyZQn2Ehu/6DXA+UkAioTAMQUt4E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YKerkwU8guDWiq6ZRtRbz54UuEcT8ewIt653LfXQFfsXRmnV1rEZOau13hKJ/p5y4kqOh6uh25lwmlUq823BX/R439q+WaDTjL6rtSmo8sik1Svubk4DRF9YdrUV6ELMmurhxO3BMgoLFbGULE7xZnED8qtLtvZ9CwC5RCyObzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XljgjdAz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xyp5zQzr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436i9Q6002063;
	Fri, 3 May 2024 08:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=EdLCzAscXCzfcs1nB5l6F5166lSIRqBTsSHqcerpGWs=;
 b=XljgjdAz6UbepoFW75paoxPU3OGJIRYjLhNpvMnoWbqeN0mKROvzmkJ64hsAQ4ySn/bc
 1vy91dUFOHYFoTT+QvxPp0AMmCEUP7EuYdEKFtTHt9CIwEqr5siXPM1iL4v3cxF/fFyD
 Cc2/csYL3awc8kv7BQFbQ8uiavi7q86aBUNezm9C7A/h3negtr+cJeWOqiXrQESRt6Nc
 kMMgIQ1lU3a1ukK2ntOiDxAY/Y6rP9dAcSzpsxnM6XGJT7TmrstOzRfyl/pp4EezeHAM
 JRMLMk3ewMNd30AzbjAZJ+sAmQ/JlC1r4i+qRTcXaGeQqQebJiKK+u+H7FcnW380suWd Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy381tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 08:57:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438llMf020021;
	Fri, 3 May 2024 08:57:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbjbk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 08:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huoQuUXPgEg1IPgbPlU0HiTiNPWwBbRmPep0VLF7uoggf2AWxxidcS+gjwGWuQP9RY96SVcCwmyfsr2ku6mO42HtMINB1x7m/3n4L1e1O2dBu1VTJWk1ueju0HHC0vSCSr2XNr31TFoxLtJNgBVTntXXMQ8QdZ/2/wxLs1Ndy+0WjcNq+P64ByGV2EGbddS7m8QyaMemMO8nLqo8et30+IAQ/XTCxLVImGXDiBMAySvCfiTth27rshwD+SYoz9s/dgXdrf+sZmANgfYYXiZwbzwlJTkcc5k0RoUq0cdIYhai/13Oq+uuYKa8LbQ1FZrF/YUxLX30XzP2d5o3RTTD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdLCzAscXCzfcs1nB5l6F5166lSIRqBTsSHqcerpGWs=;
 b=QrPUqEBrRRBaV/H7bI07WCL6pfilma0nEQMdTQR7gwNYOnxDVwiHt13i2+OVMa0R4crfA408S8O+zvCEUze5HT4G9WsJ3ZUFCdSUbOty0dO2FqXcGnA7nbCtAtTqNN7m87Sossiu6IKs0UHtGJLncuupxUgKfW8YajKi5xVVp0lrMK35go+qjWmK37L8Qtd0SzRTsy+B5C6o6hCo3fV/XG2YuyLLwfUUsFrqIIGV13XkO6KRj1Ifw9O+4iln6V/23uDWF3keDua9Z+1QNQuuN43kfhmA7miJ5FfZRZkbrkYpk4QiKdOTKxu0AN6EjbIA8CuqTr28L5NI1tXRy0z15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdLCzAscXCzfcs1nB5l6F5166lSIRqBTsSHqcerpGWs=;
 b=xyp5zQzrqOL3VG3dRiXEERjfyS/n4jzB5z8W2zFqUtCqsG3WDiq5zIuCGTPrVR96Q7CKPQ4bcJJ6otxYcZJmcLjqyErurUrzcrJKFVWHuCDvIWmbXeKjpDOJacmNO5cEdlm9KQhYQyn0Nu/G3L0S1fSDnIDYkXr3iGia2+bQTrQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6508.namprd10.prod.outlook.com (2603:10b6:510:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 08:57:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 08:57:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH] mailmap: Add entry for John Garry
Date: Fri,  3 May 2024 08:57:36 +0000
Message-Id: <20240503085736.3354268-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4aea1f-db00-4edc-afbe-08dc6b4f1a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?n6QgIEYwvhlfuq3q+rG+/ShDQUdfueVlczT+2KhnpfTCz34+J+xay/v+oLec?=
 =?us-ascii?Q?J2uIb4E/wXT5sx35pKWTZj+pSYR3bafi9K2SRGmzzopAOoHhUVRjamgXbVnv?=
 =?us-ascii?Q?FJYby21k60O43L/oC4fa5RdFG01aKiIyBZ8Sz/i0QOLHZdFfVj6hvJ87ltNQ?=
 =?us-ascii?Q?6m6PETLMn23Z8XoAHLe2MNSV3mNsCno9kOAvk4C+HQmzhclzwrSRkASgPZuB?=
 =?us-ascii?Q?NpSufJimMk/TkQjKXvHgRYrj+KE35c1NXhzVWZRArcRLIN2GA2jLxN0KR1Gm?=
 =?us-ascii?Q?cw3oyjq8fwHZAoyTTe0EJpzxrYtwt7MS9qPP/hk6MzoAMzyB9Fwrp7PhVEha?=
 =?us-ascii?Q?vzCUAx24Qqt4Ja0Y7+yEcBG4Z6l47oLBOjYFR4ycFBm46HO52i1YLOc/WmDX?=
 =?us-ascii?Q?s2r7sUjACrBQiHbXyYXqZiWFTvwSnWWwb2D0DQ5EIRxbOv/lxPMgTIx/73DY?=
 =?us-ascii?Q?ZMj67TQPogp3uW7DG2RmB9h6lpToO+d52c/KSgvfaZEtWgpScP/kc0Jm8nGU?=
 =?us-ascii?Q?Pk3Cos7EXW+OsI2iMsjUGRJKdSrb6LUwEWaAYWbMchPYWkCY/RFWS9yw7jcG?=
 =?us-ascii?Q?n+ZfgNDXw6vYBOC8wOfaWCnM97WxZsTfvbNmHfa7GkFgZimiIfAQ4VY8JVXx?=
 =?us-ascii?Q?Zbb4kYNGojJDEyYgB7uzY8rslbu2UuslDCt8OfoJo6zVE45aGsiT9tvMeoXy?=
 =?us-ascii?Q?L4lDEXyC1zuRMJs6BftMTbGFv67dZ4t8vafRBz1plWTb7/z0Ocyj63dSnMk8?=
 =?us-ascii?Q?WFLnXGiDc/i9YLjDm2kKcyvxsqkFpLBBE8JQBwU4RvJltP1WefaL/8N23oNO?=
 =?us-ascii?Q?iZ9PZ6BkyfdISYCmznlPndpQ7g2O+aI+yx2QthXgBxkQ1Co5G+fGqd8Eeb/Y?=
 =?us-ascii?Q?EaEhRvxpvAM3d9NG3F24qt5fbQENsfNQUEbIu/+47xUxl9Yyhxh3Bar88k5R?=
 =?us-ascii?Q?dMER/lK8cUsr4eII32NuzgssQ9rZFi+mBTgeNc1P4dbx/q3/mJ6bCRad8C6B?=
 =?us-ascii?Q?v5dfzWrrxwo9FjI7ydS0QwbE3oxHUOkQMuMhD5uRvv3tqWyRaTix4YuQ8rkk?=
 =?us-ascii?Q?LvKREO31m42ryteF4y7JbKgBmUXv39ffh0QlcwUV1MsmvJlKcfE+YKoYwAnP?=
 =?us-ascii?Q?+afSGlRNyG94ltyIjKtEALCtFE129AQyJCTYNx6nqoHSkKSzR1xOqgGyTtL5?=
 =?us-ascii?Q?5dpAaah1Ya5A2umaV526L1+f+2B4ZDDdLwkOESOdKTv6CFsKeGGxEw5m9PRu?=
 =?us-ascii?Q?qSbvT7BGpU3F/wteaXy/WkwpbmN/rG4MmjyXo5O1qA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tYZqZf4WYBvS8QXyuTbYH7mGUQWvNYLV7j1/UVoRDV1irLXDYfGr7tQ1APcB?=
 =?us-ascii?Q?ePMPByfaTOMOUtDDQgTmTuoXFQh/dS6xkRBV3+WY5aivC/kAfW5M+II9ZR6g?=
 =?us-ascii?Q?vlJeR58nmv86eUOqkG8wNMpONA3tGJ2IVsBi82+zuZ0GUymTxXRrBDH7JnVF?=
 =?us-ascii?Q?PSd0AKJwU4nsJVQlgYXm4wRsJRTx9Elxb2SRMy+/Jf+SH6tvPc3o1PZcWffL?=
 =?us-ascii?Q?Q8HLIqlnlPx7sbf2mcAq08bM26YcVnwF4ZNC9POnNDFtvdaCQ7xTeJjaXatC?=
 =?us-ascii?Q?1oZKdlEmZ49Qm5ne+68amyCTLXG78IOT0g/d3HryhIrNFNYWekn8lDoz8pMe?=
 =?us-ascii?Q?j96tBNDdIIKDQZ9FYVm0bzLPZnhN1a5SCw/o+pEAxeF6s3E4io4mJw8uFt1d?=
 =?us-ascii?Q?PHqYqXl9ylM5rSMo7YbaEpWKnf4CGev9PPWowz19yZzhY5kpAAjBTHyclB1y?=
 =?us-ascii?Q?vKrpAlwZPd2t5md5VBcfyqwOmTm5sb+2sVsgnMuTd0xrTSS+uwwUBmhDlixf?=
 =?us-ascii?Q?xN8PzC/FVycsuwGH/ELra6vStVufMxZeDDAWWbb1MxJChXrVIVMlwMj+Oq2F?=
 =?us-ascii?Q?Ing/Rssyfuye0WaG8z7m3QEpSkx9TrDdlvASQ6DoqovYBfnWmhPT4gUAPndS?=
 =?us-ascii?Q?iGksPGh9bwJsF/E3l78Z9rBUyu7CQFXjgzlyBQHNGjWqUou2HGChbwn6Pc5e?=
 =?us-ascii?Q?jjsBX4Jlv8ytyOkXMzKOd3Hx8ryXkl0Nds7pwo0BcMsqaKPS5OoVIBvXd72T?=
 =?us-ascii?Q?+JUIHqkAZDTDxObbf/bHLWkHvhMpLygE07w5S4mpieRRSU8e1WjUzVWWrN7k?=
 =?us-ascii?Q?6umrzX74tcytmUTQvQhjRfPRudhYDOzdstk77Z2gfiY0N5eJsYKFRtxUipDU?=
 =?us-ascii?Q?SZYN8gN0KDp5Bx9gEHDSUws3DRbBBEpk5b05OVvzasXrVJNKStLMBgQXHkWn?=
 =?us-ascii?Q?Xhm5KLneGC7l73+qIjuMZxCYNfCKUUG/3/s1TIG2DST5kBK58wGNNo86BnPg?=
 =?us-ascii?Q?0ANQCMXOTxg2SbWKg9GRVu2Wd0F5YJTjjDJQVBbSGtZ2xFqCq9IwtUcgxa9a?=
 =?us-ascii?Q?NUcskvFOWYBu3btq0k2CoAQjYEkaA2c6qAmdKQZLvbMc5GU4PWmC4DREv0bf?=
 =?us-ascii?Q?KLgDavPjcY3yfQBolKYyHd0qYmBQp1eiiCKpXNw6ov8rAMJPz4ulNF/szlnM?=
 =?us-ascii?Q?X0I6kmb0cD4SLhfhRneCO69MXhv0HPiO4BFZB5HtycgbGGGzNMQitQjjIGKg?=
 =?us-ascii?Q?TofMS0riGhcqmX//8XvewFnk5s3jbEH5/JwMcpSMmda9uxgIlm3bhoe9IGoi?=
 =?us-ascii?Q?7cSGX5KMcmG31B1BW/SW5rTjM/zYlg/BJsLS6k+Z8l5a4MGd4WBUuyWLWHd3?=
 =?us-ascii?Q?tNDUMFbeNuFZvSDhpcp7Gzio47o1XdoMS/SbA5GWPO1bGFJnGTUd5ZwLeb/6?=
 =?us-ascii?Q?W7LeafWGFvt8z43zav/t5BV4cGLqvE2mAN1+Y1WyzT6NDoLD/7UAvg3q5er2?=
 =?us-ascii?Q?D0N2XEfIAJVFsLMzacZfIILK6ukPFFA50uMZCVHrx3QPhbdyPG0G5Dyk8zo4?=
 =?us-ascii?Q?WM1kZ9XbRW8b6EUlJpI85LzhpjBnZY1qm0/1473Q1xLgV38B3BWssp0h0ELR?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zSL69hUTWALR4wcl/eYQlU4wEoyAbfcRZhVyx35LX88WKCiHdYjERe2L2mxl6hBKi8sEZgSQdzGmbvxUl2OsmjxoR3Ie/GoCP6ZuDeSRFR9hPJYTgvNkPnad5PjtIm69ya+w5e8m4nr6a30LZEkM12RPWnooWhRdu/ACXuM3Ex1jm7StVD0n8/Ln20hDo9G29M1MgWIwVeTbIgUtlbqp01jgQWC/GOpN6U04h5E5wMXbET0x8OvsmDioUZPPvYgy9KEi1zd/GLkmDoBSfg6ZJ+U0f4uxG4ontURajzg55t95tqR1boQqsfeSTnbGRUrTmWjRFyVh+qkCihgIXYoeSBlSwL9C+gINDJ2++KgKM8qR5ifHotSLHrfs7iqPu0wIyW8sVrqEbmwutiRmnjBlE662LOLyXlD/hlk2CeqpIyQvT4P2PbUkYmsmB0Vk5hiaol8WlHMuv3KiK+pHxFvXTlDz4zRap34ntw7hiGdGurwLjjtrkHd2Tp10hxsw1tv76lz7A5W1cr/1h8dz6fojFUyLOOl0kVRDdnv6vStDZdDV4C2Fd1oGnU18cBpt18k3+1eaNFJBqLLoK2fKnPINYrUZJ+c3oHF3fee3KDSavvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4aea1f-db00-4edc-afbe-08dc6b4f1a65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:57:46.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtrpBVqjpfFoGc3WwQTamAHx/pzTI/Jl8hwQ/a8twtN/XguYcRCcYATaqg2WZoIyFfSrHEmxxbtI/4soxYptqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=851 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030064
X-Proofpoint-ORIG-GUID: TjqLFcZCFE6ZaYpO2FY-UzoXYjlyk8Br
X-Proofpoint-GUID: TjqLFcZCFE6ZaYpO2FY-UzoXYjlyk8Br

get_maintainers.pl sometimes suggests my name and old e-mail address, so
update .mailmap to point to my current e-mail address.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Andrew, could you kindly consider picking this up? Thanks.

diff --git a/.mailmap b/.mailmap
index 16b704e1d5d3..4c07119cce2f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -304,6 +304,7 @@ Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
 John Fastabend <john.fastabend@gmail.com> <john.r.fastabend@intel.com>
+John Garry <john.g.garry@oracle.com> <john.garry@huawei.com>
 John Keeping <john@keeping.me.uk> <john@metanate.com>
 John Moon <john@jmoon.dev> <quic_johmoo@quicinc.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
-- 
2.31.1


