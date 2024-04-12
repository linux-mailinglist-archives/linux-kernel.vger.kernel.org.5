Return-Path: <linux-kernel+bounces-143193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCA8A358A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24931F2267E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2014F123;
	Fri, 12 Apr 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DbZwOCtl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GQg+9FA/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234114F10E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946145; cv=fail; b=PFaFNEyIEAtOCtCXBObVcd0nRdQ7M+mxo7iLyAiQcygzSkkPF9UJr3NGawMd9ar8u3xaPTMJfzMHUDZ1aXs7mvRIL1r3U+O9GXzZS/IRB7TPSzlO1zQgE7DqpF0SeEgV4Cu1z37Zq1QfrhX+/0rik+nNOlQtnnCj7SrYWVpyPhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946145; c=relaxed/simple;
	bh=3SYCIj6EjeIw0y9zkdKrlPqqs2ensiKCDO3OzmijoZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPQ4+Fs07EbR8RDvJL7Wo3JSxC16h6g5I/UqtRqYDSFlxS4KWIW41Wx7wL2Gc1TBXg1RykSelT7CaUUqGQNqC4dS9Mrler7Fh7reWbQsspuTiBrXdtfbS+xhq7pc7930Xo8g9alHKebK5b1YJlJEDOB00YuPfLr63XxWQL8+jgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DbZwOCtl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GQg+9FA/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHVc5U023414;
	Fri, 12 Apr 2024 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=KP68T40J5TUww6lgZMCWokKpEGUxjhNzGRaHsY4aY3I=;
 b=DbZwOCtlxKbAUewWeIjZEfs/AQfBUYExGpc5As2r5t+NFDVDjmc/vmrE8tToTQduF399
 AQ6QCMT6LyWkReSGmGKFrjJR3sBefar9nFzxoBoSGqBD4j9hlY5hQ6rn2JceN5JXRtjv
 RUFW1ex7H/mURF7oumQgki474RBU+SKQGNfao8TtQ/27/vpBbo5Ic9FKnzGFC05wl9U9
 8VxWB82iARjpFg7XX+Hjcz0b0dt8UlCe/B0FkWacKE2wBSqSVYUXQ4RvJGzuIclyayZO
 NFfFWFore2iY/jGglBwGyWevg/YzmqPWv0RTJfYkFSnGONluISocPu1ymvNBHYGS1HOY pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvmjcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:22:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CGlCcY008023;
	Fri, 12 Apr 2024 18:22:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubb4uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNlmYj5cRXXFMk8hlDviWWrnSNChu+/sdo7Qwt4q8tWA7y82VAxqJgZjoR4P6EqA8cHuztefsFutPn67WojlESaqPpKywQQsGn+9Y6Po9Ls5mGls22/rUp9vql8hd3yUGCpc4p7L/Hf61gHF7ECG2Axp2gpdqY7Aoi0hFocVhwkF/yUxddjGVmQ9ft+BVV1hn59N04htrpPdJ4aHML604LMr/zyrBpAG3StIeDK7ZXW9WqZB/PNDqhBKbwc+f6+4uYc0ZpIVKvyicfVn0PuPznB5w8YeOGejVdEMwkFOWjpCZpaW0gyyHUpiCpT+nTqqiAu+zHIR6LjNCOM2ElHd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP68T40J5TUww6lgZMCWokKpEGUxjhNzGRaHsY4aY3I=;
 b=eKH5ckmQa+CFvs8Tb/E4nzVIO9kwOIIvmWsjBlvR/xlOWfCt7YImcipXd8SmiUtsrpb9IKaTJdI4lnvX3x0NV3PBCI4Z3SDOhl/u4lee6AodSlWoqT+MNPGsfyv4UFxaZbKrhCyoprzFHyr1M3+zI5BavDl4qLDu1sWIpDQouSVFy8YQp7+lvk7CDT9Y3TSxj2Ma/70BXx371JT3ruYV1JOohHollGds7u2joyxTMmFkZ1XpWjUo5AxF68d/al5It+eDOOW/ihExx1k64jWXESUVKrDGu82OXZ4VUaOMFnilVlllaIBDqWwWwxuHVMuowbZ00RYGqXJ5lomCpnZ/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP68T40J5TUww6lgZMCWokKpEGUxjhNzGRaHsY4aY3I=;
 b=GQg+9FA/8Vosrub7dO3kMYquSfnrefsR/FLdcS9b+Lk+oCVLn6uUB9PDl6p+5cH1rpbnUGLXciU5nZ26NcbfdFz6CHw4Q4p3navYJUOVldQuqSfE+e7Pl7wJCLQLsHJieg2s1JQCBGpTF9k1yDRceq518rcombgf0opru5ZlLjU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN7PR10MB6500.namprd10.prod.outlook.com (2603:10b6:806:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 18:21:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 18:21:51 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/2] mm/hugetlb: rename dissolve_free_huge_pages() to dissolve_free_hugetlb_folios()
Date: Fri, 12 Apr 2024 11:21:39 -0700
Message-ID: <20240412182139.120871-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN7PR10MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e89d317-7d31-412a-ad84-08dc5b1d6c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hIwINZdLb+QUXn1/QAQ3/+zcCqdjxgpIX6mFTWQrOzDGzRf7YSYL9Do9y9809oQVoq+Yzaef6DttKU2P/8/d+92Ng9vh2xkGAyeVLocB0rHxxOB1iGnPUFfGs3j7BA10omPRh1M9OuDebHB0xdbDUlrqe/PjtI8KIviwxIRxLesCmKN+mV6ZuETu51QWqeDeEv02pau7MVcyIV8OOnSPbSdkaN+ZgHhzhuSLvGZbelf20JJdPsGBXY0+3z5ipDRd7uRNmXdbRHtB8PcPQVpkbnMvgThhQ+RpKc3xwvME7bn5WNR30LBtrvb4mCwpW6szz8ordNJJ3hMvY1JruhHmDMBbHN0kUEy6SLXohHw57zI7JHeAf8al2LVAm5Pnk0Nlt0Z0H6mIdf78eAs6eTYSAqUwEKuhxgDGGthLn0Ia1ADY8jlrzGqHaANH0EPr/DoyPK/8mvg9KxuNmaEg7OQx8THXEKGuuth4O0T7afQ7nsU3ztVGG2fC+1nboVeMW8sme0j3HqieAq0AB860lMGzVHRQReBrDrn7TQH6uSJIdkOlr+GReg1UnawIuvKCywt503e5XuqoaBe4+Yp4NGqqIhW0tlrRnjD/8ze8IUKEMRC/OhJviesYa3fmmOT2r9K8MrfifowbyiGBBaYcIoplTeql588S66Ks3y+6bgHmYl0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0FxkmCbnLajc9G0j1hVNzQhgQYfm04MhnXar+Ad2VRjzzBjeytPic7ZCTCAJ?=
 =?us-ascii?Q?zRAwyp5g6SRr51mWKZcI0YoLSltdIfq4P1sC8bQztqYWphKlR0tZisNHPURV?=
 =?us-ascii?Q?gukr8sFgqOFRSBoGYupPjRniIy3CHDA1Jt7Bl17fP8Dm/Lt2L/J/+bq6rV2y?=
 =?us-ascii?Q?45VsZghB/uqUJpVhTcVlfP1M1xUxv/fgY4luQRHbNORFwOUIOS6lEBXNl+cS?=
 =?us-ascii?Q?EUMo4U2P9aurOcwsgblq1E5/4EFK4dseAB6x90HRSzVT5GYFBM8uBDZfK8WK?=
 =?us-ascii?Q?6lAn76DbcUE15A054u9RJC73+LnkqocEGMqgAA0FZ0tgAl4pq+xkNu3AOMs6?=
 =?us-ascii?Q?RQhimQRKLE2LHCC4WO1NcVZKjZwLyZ2Rj/No6EdRJusGese5r/TJ7oQm0nZS?=
 =?us-ascii?Q?+lnafK/fAYgcUK/9k26gnpXYfTLB1GDWVQoU13mAT64XqY1w2p/zADnt9o1n?=
 =?us-ascii?Q?V7dAEn9lFSvvV0pYkhKr0oKTRfCvl6ro2fiEFq0F+z0ItpVWa9vjVVqSWVEH?=
 =?us-ascii?Q?YM7D+eddOpTtK8kdQWdRnnvQtkm3BbjoEzdZlC0/z+cWnZ/uaDxskaMs+GMQ?=
 =?us-ascii?Q?7JPNTWpc0RXo6/x2DHD4teLIocRbCcm4p1I58P2b/HDaYXcqsX7v8SBNErN/?=
 =?us-ascii?Q?HzUTqDv6VteU1WG0TgN35f931fV5hFiqbo3u7r4iXTtx0nimgu+b+HKPM6Ti?=
 =?us-ascii?Q?A4uWnpjRjCp7fzkWUm6rnCDMVp8fqE7LuYQpxIYkkvHVT1sXcwkWGz3DkL4W?=
 =?us-ascii?Q?bEgXZONoDJEIj6Kj8c/z9QLfcpgkfjJ+rKJQgR1KZRVru9eChHzJwg8bqI+W?=
 =?us-ascii?Q?KkOBAE0x/WqaMYJ1dbAUNOWel0PMRiMqY+PTcLuvs2+obwTq9Ilie88uz4cG?=
 =?us-ascii?Q?cny2ksBKeiihQg+RUtEvlVxJ35yFOssmYhNbOsUfFNpdmxhFwC2ek01mEV13?=
 =?us-ascii?Q?oKSJQrPNv9rFP3GD4GbCjg0EFZWsOk+czKA7Zeu6yzyQy5j0sKleuQsKc7v7?=
 =?us-ascii?Q?xD7KDg9XYgCUcK+XSH2qspm4nMyzfjlFYJlyyUQhLVuSMu73Vh5YW5yYyLL0?=
 =?us-ascii?Q?uwP/J4s8rSuLyTnx7DkZB3o4DSpROMTzrsUn6Lil+CO91o43p8s/crCE9VO1?=
 =?us-ascii?Q?w2QAne77mRaiasPnJLyS46DbjGxqflc8VuyyiQj+YmZLm2hNSdG3yAslQvye?=
 =?us-ascii?Q?bQOLPAqGj7BPxZHtebqhw2SMmxBK+bdNmCoOM/z8ED+7bc/mTbl8WTFdatos?=
 =?us-ascii?Q?YU2iqxrNGTjDfbc1zAzWg9BDuEECFAfEIiJmKkjISgk+v6mUAlzlj5+FhAAA?=
 =?us-ascii?Q?MhanCqBGhGIcf6+bIBwZcy7I9BUOc84uJiVlC8NxVqOxTmR0k9CIkAPaUkyT?=
 =?us-ascii?Q?KnWDMfjcbNe0BQ+eG3Lz3R5XJ30xzRafRW6/lUbaTXUWK+x6DY+yIJrf7Rg2?=
 =?us-ascii?Q?QB0zx0MVFir0ovz7ogMGQDyzMRBl5bwhYQrssssXlVmqUrAM/GUHs0J3CeWO?=
 =?us-ascii?Q?F/U9LNDgA+2fuLZk4N7rLfk4m82zF9RgsAwy9SIsnw/gGQTfNAiR6RBNtf2q?=
 =?us-ascii?Q?+dEk0/C5C3O1WFWIxoIyjxErugdTOOCb1BLKCWXeB3Yq25uPIcnN6tOYzOJV?=
 =?us-ascii?Q?OBiIfO6CTrNyYaQOGUghARY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dqfDmTFI2zhJvJswE07YsxxgT3z4F4G3Lq6kU5L+26DMZGqbZHh5hH2YSkAX79PeP+/Fsxi2UhAi2G0uiJsfXPDxT/+VqHp64x2ul5k9J7+V+1wvP0xXaFTpdSpwESdJcx9yhk7oYMzl3hvjGJdkBmZLwBdzVXtOhpMf0HOBuGf7Ox7NYaglXbpUCf30eudhXfifVLCjs+e77MIEYt2HprHXP9gcLbg4CZ8eS7iss+Qa/rpZK/So3tQIfKBrXyDyv8/T6EsUQGZz1FUYJi299vxCZocZQFvPlClknVh1WyWBr+q/taHc/bziEEbQW7SYFULAcD93Yw1TIP4koalVJf+prhfNZWcFjkg+K4U96HIntWy/oxkfOxhgrvt4el4tDBNXce+jMupchdLtYou2HizH0IOn2qrjVWWZo0u+gg328oSqMG7EnJ7RPRLF9PHcB5eIx9/doJTwynwmVbVGfM+HHfLKKhL10EVVf8GSe2cFf9pjGdTr9hdI1i+j1pJ5ZK0MBh1NjUGp6I7lE63a7ABrFMuzwFtyvAkTiTpIFjtq4Nc1y74zvcfD/0hbrz6jxvDxbX5Jh+OLrq5RTCWYRHLLftCCreECRAeIVWdma40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e89d317-7d31-412a-ad84-08dc5b1d6c9c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:21:51.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5QWKQDzMiKHo0WbS0mXj+Y6bK3R06iB4hUFBkJM0ya5bFMMBbh8Q1XdgDJc91eq3xi5tqclUJAzfb62nCV3viIUCZ0DM6W9VOZSXjUxwXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=874 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120135
X-Proofpoint-ORIG-GUID: 6RP7bwFo1oyJXyfop7EHaO4ltTXWlf2S
X-Proofpoint-GUID: 6RP7bwFo1oyJXyfop7EHaO4ltTXWlf2S

dissolve_free_huge_pages() only uses folios internally, rename it to
dissolve_free_hugetlb_folios() and change the comments which reference it.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 4 ++--
 mm/hugetlb.c            | 2 +-
 mm/memory_hotplug.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f4191b10345d6..9ad7b97069cda 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
 }
 
 extern int dissolve_free_hugetlb_folio(struct folio *folio);
-extern int dissolve_free_huge_pages(unsigned long start_pfn,
+extern int dissolve_free_hugetlb_folios(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -1153,7 +1153,7 @@ static inline int dissolve_free_hugetlb_folio(struct folio *folio)
 	return 0;
 }
 
-static inline int dissolve_free_huge_pages(unsigned long start_pfn,
+static inline int dissolve_free_hugetlb_folios(unsigned long start_pfn,
 					   unsigned long end_pfn)
 {
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f6dd5f597df16..51665b20d90f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2472,7 +2472,7 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
  * Also note that if dissolve_free_hugetlb_folio() returns with an error, all
  * free hugetlb folios that were dissolved before that error are lost.
  */
-int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
+int dissolve_free_hugetlb_folios(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct folio *folio;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b79ba36e09e03..431b1f6753c0b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2051,11 +2051,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		}
 
 		/*
-		 * Dissolve free hugepages in the memory block before doing
+		 * Dissolve free hugetlb folios in the memory block before doing
 		 * offlining actually in order to make hugetlbfs's object
 		 * counting consistent.
 		 */
-		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
+		ret = dissolve_free_hugetlb_folios(start_pfn, end_pfn);
 		if (ret) {
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
-- 
2.44.0


