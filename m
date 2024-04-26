Return-Path: <linux-kernel+bounces-160455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3FB8B3DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836B72820B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319715EFB4;
	Fri, 26 Apr 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLvWGXby";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MY0i0IyO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40F148842
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151753; cv=fail; b=bV5yRYlggzB9kXGJ/sS+Dc977hcBqond1kD2QldvLUjyoay+168MtPq1alxSDfB0kY54hHW2B60lfbITcs41GsC+10grJ3yICXbu3X4zHMqJu7sxL6sNmNGK9Z1TTJ9x4cnJUlSsFpILHo2xuILGJbCL1WuzFHo1g6gO9tkyWww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151753; c=relaxed/simple;
	bh=kagHDMBMP356eQKgLIXHyjhZCjqL3qSMVx776EZq8g0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HvSB286xMH84vu7JwXwzjv2a9MJZmvC8v2BK5lAQckoypuDWL7iEXvw2FtsjkexROAk0NRI89ACvccK1OSWs1I7M31pH5JSFoeYRTWVKsCKSkV/LCGEmkqA+LiZ2s+iRMxltBCvOeBfvw6wPz+edwK4amt+AoFhD/JrCdbHj2P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLvWGXby; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MY0i0IyO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8Tlx0008323;
	Fri, 26 Apr 2024 17:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=MNBx4crddd9h14dDvWU8dw3tYEvhR2S5PpErs8rnU08=;
 b=QLvWGXby/D1njIzCGFDQWPgn05VXS2FCGIiPrFDDJVgb40GZRuBCMzsGOjKZCBm+Tzcs
 yLWBShYg1h/z9sUgIkCfw+YK0bmK1I0wklNTK3OtGr10NPzfWablNHSruJHq2NPUfVJ9
 d8NQ/lJJk8sdfTvBf8wi9nIlQ6R5ToD3pDrqD1v0GbT6TQ7N8lXnosarx1Ka1/rc4MLj
 0/1Z9h9E3soEqzIa/hFtcArOWkcEp8oEBYq189VLI18Ty9229jIu8WhCoX1qwQu+CNZF
 U4mIxdYCZjs7C/RQ8qMFel2z+p5tdWCGyV3IrJNqzcMe4glZNizHKXkpFozMBBWUDgiG RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbxa77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:15:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QFNjdc006349;
	Fri, 26 Apr 2024 17:15:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bybha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8gYT1/uR8jnqk3j7MVF/mU0nKvPhUqAKgNRiCY0nEFfqFIdBspKCyOTLwRJ4zm0tL5RHRnSySGvlifv0a4M0SsZnG7uzS65m9cDG7sssX4eojFrFd2zZ3ffLppB4uXhwNkohOpjMLE3YY1w0An3c/7RW9oacgqkcsISncjOv+Ab57wAbNqa/clyXkseaf6Hn2GWtNIPUDh9vRLxU0U8laSLQdtlQSylFJr/5dip2MOhd08ShlfeDx8PyuZyxFOr5nYqyq2LtfIIbabdFl8TTuN6J5LVcgsgZZiCcO/A1fINpgwNQs/gkpJWHKC/TyzrxGw1Lr12BkUQ0MxKMaQk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNBx4crddd9h14dDvWU8dw3tYEvhR2S5PpErs8rnU08=;
 b=IKBYjb/5AyLyx0a9X4cHPApRieItC+GoFiVYNdi8YNVOmgCyaLq/ENSxTrutlzVQZruI7xSXUbt5NafulrFaadjcT0yvF2jaxYnGt8i7aYPVNYTQyAIEr0cpbRG8SHBDyi1v3FkOEQKoTddIOdjiZcoN1fZvZNU5Lpl9Fe3fFVrWGNO4AR+5Km6PYHbw1RRbyTwZy4nrKsEy1j7tBtvFxpdqe8sVDyShoKjfGJ4HuBGikP5WbCLd83TkThHly1WjySByVFImmrVHQyeLUA4LGBIdRyQhCgC37xtG9GPa4TE1/vAcBAl2gekAsosS7KBs2pjs6cjARcmcTSm0Zk/99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNBx4crddd9h14dDvWU8dw3tYEvhR2S5PpErs8rnU08=;
 b=MY0i0IyO3LBRgydBCNJ5MP62TRr+SH1+0dQeNlT5QhnHAEZkPAgx+//el0MVG3Sako/RwmSJ1bybEXs8Wql685yPEaotS6bf68mq17w3rRBV5rkUvxCuKRrgGtRRHpV/HIAnetnQ2Cixa6i+/KlrB47HIwJclzUB8T0/R0qWA9g=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6207.namprd10.prod.outlook.com (2603:10b6:8:8c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.24; Fri, 26 Apr 2024 17:15:17 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 17:15:17 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, nao.horiguchi@gmail.com, osalvador@suse.de,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/memory-failure: remove shake_page()
Date: Fri, 26 Apr 2024 10:15:11 -0700
Message-ID: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1acb9a-a0fe-4059-5137-08dc661471d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sF6yoTcyV2WVJSBXdxxj6lo8F+r59147bGWFZW/6BEwMTs9Z74nDKp4TtZ6W?=
 =?us-ascii?Q?2RrFsoJLKtkYYG+fOJO+qfTkzPBmP2qgCHNxGdCyISvXOVEd+aHDne5FFSCM?=
 =?us-ascii?Q?86If1jQiiZ61S0CpEKJ0CFNHq6ygjQbTLQUvig/V+yQtexWytJ31SxiHeoKL?=
 =?us-ascii?Q?sWyLJMvSqEKkXE6RDcdrnaFTCPt+hHXyqpEabmIyxWWjknPpl8BbCzQVFJ9P?=
 =?us-ascii?Q?d+rDGSrApj8ab3hlr6pMppxCkP4oGLMZWGqk4WGt7pVESQftcFvsch+vMmTj?=
 =?us-ascii?Q?35PmptSs88Ul2KylbJ0WZF/w30nTUpdBVwrtj8+wwXCEKWSzOsY+fSnUGdjD?=
 =?us-ascii?Q?uPFCAlZFkA1I3ctEj3O1ikgQboSGs/qLLUafkDhXyned3urPuYJwpRGXn9Nl?=
 =?us-ascii?Q?phvOB9n0F0dbvo2bn1FCtewJZ4InPlpM41aN67vOfIXEvce+KVfNnJiYen3U?=
 =?us-ascii?Q?osD0zPKxRmdG176SQZF11Mn5C15pO2TY/ykWZy9BTx5y0/CrVZHv5b1NGP7U?=
 =?us-ascii?Q?sasdvKBKsBXI1zv84ddFqSz4p+2Wm4qbA8qItschKutZTk6k47idtnpvot4p?=
 =?us-ascii?Q?Nxn7PaO6vYnQMpvEAP2BloQR+t90oZ8kTW2OeldQIHJsx8zlNSjzzDtpEqD/?=
 =?us-ascii?Q?YeDCCAHL/PuyCFgczznckkjFHoLOFaaTZxKj5NTWIWzRg51iNzfIxQ9kt+nw?=
 =?us-ascii?Q?XNVt4nT8FrpEr400MJ0M0cGbQAINfO2etsUvVIL4fkAOz6RjCLBXybOJY/GU?=
 =?us-ascii?Q?ESuzFihQvKuj2cY745Q95ozGhAiClACG2Cx68lZ0XIZhCLsQOEcx7cu2V2MA?=
 =?us-ascii?Q?0qgrfmiV/fT+mz4Iqgkd/ibcQXuPUt6JhPjxFNhFDoBmaV71gj9i+U7YX6s/?=
 =?us-ascii?Q?1PD63y0fhVNnw9xMmOcR5EpiyJG60IJ7mO1c9uYqD5nKbIyCEOMAOMkyBPhv?=
 =?us-ascii?Q?ZflXBXirfpHn/gKbw1rdUgqYibnb4sSXhmspmohidSFHQK/QtzPQCFFDx7vB?=
 =?us-ascii?Q?K/bIDqZ0QT1f917Zq3eAxzb+8MDJrr/yfcHDYhJaYW+uAU1rueMNaztNvJqI?=
 =?us-ascii?Q?TvBZZS88yPYjupseXpU1XuqhY5cgeEho41MHWwJPMkjSqMkeNKT2GIAwkJ7K?=
 =?us-ascii?Q?fsTHg0JXZCgsctuC4AFqCobN5NcQF9IqaEAkGlld/Q+c5sK4zJCFC9JchN6u?=
 =?us-ascii?Q?Yy3ya4jwgBZAGgSqQms4/HOA6pmzpS5B82vr368VnNCilgrqFiYlI/uWJyB7?=
 =?us-ascii?Q?bHXt89OXZMH4815ozMfvGKG0+uQqlmpOtuUxlZrHxw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7AkDX2ZI0ycfGFprtCdzLdPyBn4LLys35IIfZpKjk9Nr/9oG0oPAIn8U3Z9A?=
 =?us-ascii?Q?snOeglOQ6+thiG40Gt7yaowZ8+0quwy+LFPZGkfCcUGFdAZUq3pGzSlnjY8p?=
 =?us-ascii?Q?M/OAtkzf3O5FrfRL0nKbj3s5OWZeolVhXHqlVGcTYKFBqI2aGUI5lu/rF3DP?=
 =?us-ascii?Q?s46F/PJ6oHwS2tBEmhKq2Jzif0OMRF4rCO+Fipu8Wine0Kof8xa0jj5lvo8/?=
 =?us-ascii?Q?TLex+ImpY+wEXqOZX4lSZox8fsIGXmC7hkMqvp7tcuFpsfemAwPo9c6PeGlf?=
 =?us-ascii?Q?q3BAcBWxzrrkIcUzzj9LRX4DfOTlDx8hNNe4iboVnmRH4UTC68Tk4oimQxd0?=
 =?us-ascii?Q?ic/uMZz8qjhBNNNP8iyncayMgnyJ2Ql36g2CJR8ryiCVfKX4YUA9RZLUK+2L?=
 =?us-ascii?Q?kbnL2D2JYz3+dlT4S2Razu9WWl6mwKnHoGcTuLAfGUcU1gavzgYYlJI0/QUh?=
 =?us-ascii?Q?6QQrjtD0xzNzsTHVrbcsPEm0XA4C1Q9CRugOTwlfPFopslSKlP3hP6ZJN5Vi?=
 =?us-ascii?Q?G0HEVQdbW1VO4BsZwBZIa3gVj3YCYy6BZq5TI8z0m4F0G18m81xS7RctKPnh?=
 =?us-ascii?Q?I6tGp9Rb3/TUn7IMCGd5qapfHOVsJI9AHYjG98VLcc8JYR6yHLajiw3rUF2o?=
 =?us-ascii?Q?QlAo1KcHDwr6VYInwMmScDgEZSZmYk8Pz6j3sKXOdRY69Z00Qiq1PqVXBg1+?=
 =?us-ascii?Q?67if0jR5ETRPVWBRZ+KHnI7ViQiaws4e4BjVtcodPic811w7FvuADINs+fnd?=
 =?us-ascii?Q?C4mQDRgEdcXKl07wWvX4Z2yW+dDBaJqYkhPY/UzwBni4IRVme8SctweyBp0G?=
 =?us-ascii?Q?4C7z88rEv1i3I5uzwcSm9UYOWE7QAIZqUBiWgTtDhQDEpjd1LytiX9+Ssthr?=
 =?us-ascii?Q?xCX7Clc37L65nDcgXpWLgC7bg15oATEjD+aRpwX0E6HJCNnYHygUynozppsf?=
 =?us-ascii?Q?Il/qh7p9aFdkK5im9LBwQ/SvJlpb6N6reyYKz+a5wpm+jkIvImfIrH/W2SyV?=
 =?us-ascii?Q?fwjMNfm2xafX/ofdw/pr+WcRGJbPlpM+eSem0WUL4CCW2hCQahfmgT92Yoee?=
 =?us-ascii?Q?XwWSaygont8gDz80LNQJYUHpIQvOMltfaB69YfSWQgaIsnOQKn3hADic7F2o?=
 =?us-ascii?Q?N/Ge8MJarVUdLn/P7bqzXUW4YIzgd5mC2rd0rAark7B0AxDB+zMwl1J5k1Pu?=
 =?us-ascii?Q?d/TjtuCzFIrJan41JhGmHWctBL9kRhkMii+aYwPauCV7KdlBzwtjsgZTGKi2?=
 =?us-ascii?Q?bS0k7jCYtp76RdkHus+ypfc1wuP1mZO9GHkSzZ23lqjRlixLY82TAQEa1N4K?=
 =?us-ascii?Q?XtnA7xZFRfkcAHuNzOA/uoKqnOckV5x41jUvN6w+Me56aLaeeEiZ8OaxG5Tm?=
 =?us-ascii?Q?YU6A0dCSk19lSgeDM8k3SZyfBFr9D0XRSzOBSF+s9uaDP5m/0G/7ulgiK0/5?=
 =?us-ascii?Q?VfBYkfd9z9dyPN3+Vms9Kzuj4uAqLWjzwb5BviTo/qWwTzivrVtyT8xtvIvD?=
 =?us-ascii?Q?F3Ek1uR9jhuDzd36Xbp+9LLOY7e7c1/bPD3tviBSvEkLVHeyh3Kc12F6nXbc?=
 =?us-ascii?Q?8B2XqM9egdpQ4jMZYsbpmCezZbx/1ora3TMSQP9EMUgQ7GCUTpfRZZbpWWjC?=
 =?us-ascii?Q?MHgY+AJJ+SlRn0f0Py/PCaE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EJLDxgXx8T+4bN376acDZShzr01eUEBiXeV/YX7S2w4fBiidoiMBakC9gRaDmR5xS7bGBt4JxOUwNB7yxhgj5t4QJXBXJ61Oh/c6Mmgld9YppsR4C7UgbOdhHqjyJR5Lg+/QUqKriSqncXTwnecwDFuN/7beHYphO2nXdeDyAPeT8pEasOhQSREvnpNR6EpPQkNGNqiDA1D+n5wbl6lJNFy8LjuIgqjs1UTxDElaMen43oVqURWgfALl1MZlA8u/CfMoC6j01TRcUZF/Ofx2fJEYuAi/Sb4H48LpMsw4nUnlQGsuzoT1IVUvJalFa7DvgAnqwE3d92opqCN5/DWr9FOqZ2qIWDr6dhuc9Fp0KW69H4FOxq/yXhMFMIB3TD+ZOhNUFfSIOuFOYV2lWBJndQ6S3BJWvSV9rPWkL6vf+NIy884kxI3iznK77VdmakstcOZr5jNjmKXM2Go9Y0s617Oev57/d8EjCtdPDqBI7BNbMcWm6cRqvj3oN9WSXl9m9f3H1n1nArEP12ZxPzM6XqciCvYE3oinSUtVoAGA01npNTmxDPAW/LSl0Rqe4NUJqx9tsh+kcWbCPfCtF5MNcqbqpt2O2IQqbQ0Ww38t+XE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1acb9a-a0fe-4059-5137-08dc661471d0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:15:17.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqUXcvvGv/UKsayNcps7JuL+JeY6BSd2Yw9Cxpcjz7DclVivS+MVnIwn0wwQMbrHsucPga7ccDKlp0Evpk47vK2q6Ha3kkf/p0g/Ouq2+90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260117
X-Proofpoint-GUID: FOoxZYJr3xrsNr9tcthZYLzdJkHktlav
X-Proofpoint-ORIG-GUID: FOoxZYJr3xrsNr9tcthZYLzdJkHktlav

Use a folio in get_any_page() to save 5 calls to compound head and
convert the last user of shake_page() to shake_folio(). This allows us
to remove the shake_page() definition.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b79..273f6fef29f25 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -385,11 +385,6 @@ void shake_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(shake_folio);
 
-static void shake_page(struct page *page)
-{
-	shake_folio(page_folio(page));
-}
-
 static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 		unsigned long address)
 {
@@ -1433,6 +1428,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 {
 	int ret = 0, pass = 0;
 	bool count_increased = false;
+	struct folio *folio = page_folio(p);
 
 	if (flags & MF_COUNT_INCREASED)
 		count_increased = true;
@@ -1446,7 +1442,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 				if (pass++ < 3)
 					goto try_again;
 				ret = -EBUSY;
-			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
+			} else if (!folio_test_hugetlb(folio) && !is_free_buddy_page(p)) {
 				/* We raced with put_page, retry. */
 				if (pass++ < 3)
 					goto try_again;
@@ -1459,7 +1455,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 			 * page, retry.
 			 */
 			if (pass++ < 3) {
-				shake_page(p);
+				shake_folio(folio);
 				goto try_again;
 			}
 			ret = -EIO;
@@ -1467,7 +1463,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		}
 	}
 
-	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
+	if (folio_test_hugetlb(folio) || HWPoisonHandlable(p, flags)) {
 		ret = 1;
 	} else {
 		/*
@@ -1475,12 +1471,12 @@ static int get_any_page(struct page *p, unsigned long flags)
 		 * it into something we can handle.
 		 */
 		if (pass++ < 3) {
-			put_page(p);
-			shake_page(p);
+			folio_put(folio);
+			shake_folio(folio);
 			count_increased = false;
 			goto try_again;
 		}
-		put_page(p);
+		folio_put(folio);
 		ret = -EIO;
 	}
 out:
@@ -1643,7 +1639,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-	 * shake_page() again to ensure that it's flushed.
+	 * shake_folio() again to ensure that it's flushed.
 	 */
 	if (mlocked)
 		shake_folio(folio);
-- 
2.44.0


