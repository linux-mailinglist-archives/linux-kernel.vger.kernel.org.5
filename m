Return-Path: <linux-kernel+bounces-141793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E328A237E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D8E287DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1EDDA5;
	Fri, 12 Apr 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mvRJvch5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bfOe3G6P"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD833F7;
	Fri, 12 Apr 2024 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886996; cv=fail; b=EvqiO3pRllNVLtkMa6n1F5kcia99VBUEZA5EkDHKiFowJ58K1r3ZOZsbU4wn25lvEVfaZSuNEJJqTbHMm7p05vhs66ufruzV6qrywi53bjBpjozidbGqi5uVFjgdhiHLSnEAygTom95yPaPRaRV+J7qNZmRrrPPHZlinv8Glyxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886996; c=relaxed/simple;
	bh=Oifwm/P8Th7ySMEp3PNVSnuxsZTJS9qaHbnNW4aqEcA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=mLp+mwIi1MoFpZc0RAsmRCWdMtEAUrIUSaVLcHV91qJFLRDPZaOYWjBenbfM4+YDJ3HjkXqeA8N7us+4rB32gjXXDFgUwf6s174BHQ2r91/6JRCRVVaAEaF1B06qZWry45OQnE5/n8V1mmrggBxLBODxfNkkRMriSDTdzipEjVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mvRJvch5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bfOe3G6P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BNDwgp017542;
	Fri, 12 Apr 2024 01:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=MFvDog6Gkn7Xx9BXEDKZQwFfaR+NQIVJEwRK2O16oJo=;
 b=mvRJvch5TzauKQjm4lxdF10dg+X+VN1kFBvYZ9GnCu5KlU4P3XJg+z7UjOrPBdBGaAam
 xzeBAAC7h50vFKKq8H7JO+23eNn+PHEqpu2SNLGinMVMFyDJ8N2qDZXVHY46ceVNBmOD
 RlKCNISOuJLfH6b+amt7POIRVdH7bo7Hc3oybI0iWsmNs3OFUFeExpuyY4GBDC5RJ3H6
 UBeM4xB942o8AawHhT60undIAhmOAQQkeZi386CaGxdS2XQxyKD0d2D03icA0k5PVpBq
 CbeZhmW6ehCbDzw+dTfXZFSaXIpqM7qVMv203YhnjYZgk+tN0xob9XZTxwDPcvZWVR0d rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawactvfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:56:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BNfF3k003022;
	Fri, 12 Apr 2024 01:56:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavugm3j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ankdEuxWHXt6IuxElUDY5InCOxV3LNB8djfjdDYYrwlxZIkhx4/1mEpepKG9Zv7KmyK3isoL+giuf96m64NNytJ7FbPCIgh/vGGzOaujQ4WepHsb4EjkoI+jNIXGLMNEahvo/boQODBLIbx/ecvYJUgNxf7kkjYFcUwrk+pH7GNIVfuXm4ZgiY54hSeDMFf8pBZiNCYPh4Vd6GGF9uw/yI86Og4nsFAAwwXTo6RHpLyby4nJ7lxcP51aar8bPs211WNmr+95JtJx2ocsWYqBwcSqAMX8+iMM6XFZ9g6x77yMGRpy/UgmvoTdktbmk0hu4gDU8d0wkeUmXlolQkMZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFvDog6Gkn7Xx9BXEDKZQwFfaR+NQIVJEwRK2O16oJo=;
 b=k4eZilqPgCJF6E7+xdKFo19hTOBUMX7nYrBkzH6W2hYh1oI7MV1lVeGgUqbaKAcLrqv19eydHW/TERviB0rSRplC6+ig6hfPe4ryVc0RnmMtWS4kgHOq2KyEUjz9byPsNC+RbmxNOcUzo8OfsDL3948XCfguGPQf8BDxkY244O/o83G0hs7rQgpdJdDfgXxQM003antQM7pbvOJiTGWvF6K9b0ZncsYrZOVgSEwKXephw11PFBPQKY/LzBCQEOxHLgqmUW49sb7gWOX70IMctbm37TF4/pAwuV+/hC2vAlMSCvJkJC4zqXHQI7dWaKUtunICcKCb0Cy1kQPBrcpVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFvDog6Gkn7Xx9BXEDKZQwFfaR+NQIVJEwRK2O16oJo=;
 b=bfOe3G6P291nP3PPAMnooYqLPBB9gVSRHElGdn3fLrI6OqpMOsfev9kY89yJZyy1FjJ466lyrUVYt4lc1ZqU1O8+cmkItePdr2JeCQBOvw7+ChGKzlcHaafDhNJol/Ot+GALSUB596Kxgf+IrZYC4nJD5M47BIyMAHUBZDrnad0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:56:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:56:21 +0000
To: Will McVicker <willmcvicker@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Griffin
 <peter.griffin@linaro.org>, andre.draszik@linaro.org,
        tudor.ambarus@linaro.org, kernel-team@android.com,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: ufs: exynos: Support module autoloading
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240409202203.1308163-1-willmcvicker@google.com> (Will
	McVicker's message of "Tue, 9 Apr 2024 13:22:02 -0700")
Organization: Oracle Corporation
Message-ID: <yq1v84njqdd.fsf@ca-mkp.ca.oracle.com>
References: <20240409202203.1308163-1-willmcvicker@google.com>
Date: Thu, 11 Apr 2024 21:56:19 -0400
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:208:32e::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: bc17d347-e7fb-42e8-82d8-08dc5a93c05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qG8W5ikkFAgusN4jOrtYLqmqFBMP+pUoZFYoopEOID0/mwcqSDhRGa0mlm8g/765N6AsStqTty5XUeTmxy05Pm1iRXoFytqix/eWpI4V0/j6SNyUJP2j+nte0ggM9RZKXfHh/QshvS44vMioO5QXZ2fxPnhNuhdR2P4qx7Mq4TsnSR6kzwxv+PC3gkBH0uVgiwnCjlPJFAF2nlyKnetyuw+xPyEePu1gAC2ggpN4WabefbIuO+zxW4cRqXEm5fbHMhtu0VpC81zj9txjExgONKc2UE8sXTfRGTA0XZnbsx2/ug/UTXdtGQVi1DpS3i1FSoxg625+PCpDbppXFGT1py/23cicSUy7gvgF4NbvlBYOd7BKMotkBWMSf/BeKIG/+oBtV02OztyMQIErf5w8i0sKSz7IfoF7Lphs+iQnzKv5HLaFvkeo+YkoxjU2Q6tOFsxxl2bex7FYNTn1kFKxV1qxrfmlMer/KiZqM0uJF7RnMa4STQK4qQizjzE2IFs+f1c8t8m1EI0PtGztPtIY9TqVO2WeuOjFzadIYP1q66tn//zUMjX7XrDVXIBgs9s7t2OC1l/kR9ZvVe/WAIEtSOoBWtYPQXCijIDD75Lv8gp6knNYmWxTpme9ttmwLTgMaJO+57NaPf6nxG3Wvvos4fGxjTMY9jRcwg2P/kIqWy0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iRonGX58e/gHj/W6m5XgiA9ma8r00Ty6Hws6j0AaDW+B9Ru2EA6bDjAWbu0l?=
 =?us-ascii?Q?kps0SExwKKnzm6Id9ZJLzqCVke2mTAW0iD7TG5K/ie/6DNtuFUWrry3mQYMY?=
 =?us-ascii?Q?FY7xpi2pUMlM6MDhuihZWG95Klj6AnU7bwjpAiv3KYHc5rJYWL7/BOtDiS5d?=
 =?us-ascii?Q?bJTGo4HYCxD/WniHI/kszzJdxo0MHqybE/ftXhfEvHeU8G2owILTWMiwn16c?=
 =?us-ascii?Q?T9s572ivB6sh/Lk52BPd0NdYUXlOMDcBOLOvuaPlNRuaj8xb3IuQ3ZVEHnPq?=
 =?us-ascii?Q?Zb7pKB0iaG26BhOANIxS2k67RJsKbsrmOc6OUuG/uwhAszZ/8jrkOk6jitNe?=
 =?us-ascii?Q?pNmk/SrTEZbdtEiSbZKcZOfNVGfUJ2qUyIg8sl8Veu1bt71N22GfqILbjs5M?=
 =?us-ascii?Q?Yr1nrjBwFdVkxjXl2nlYO0/ie/AJDup9DwpGAoPUqhHujKlDrOFBbbMSrto6?=
 =?us-ascii?Q?XbmPa0hWWQ4n8WUHF6LtRA/5nGHgN+CWp3/BnJDlYfb2oEhPzh69GZsHGQzt?=
 =?us-ascii?Q?Va0/ZyKOS6GqGBvAMB5IEc1A+tCKp4h6iaBFZOHWxXmF6q1YExfkHeNvTj+G?=
 =?us-ascii?Q?V1WAXXRfsZhuYXkYVzwT9Srv7qsR2yeUmyMwKIjDXX557v4yBKHuEdmM2ThC?=
 =?us-ascii?Q?UMprummq8tvT8qaG4KI/muUbIP41lDW2WF2bBBSbLnG9me8tfyGodwWCgTJQ?=
 =?us-ascii?Q?QFXx2gY/9QWdixiD5HdH9euIeDbYLor149oMr5odj8CQkb4qq1ZhDzNiJeox?=
 =?us-ascii?Q?5a/DygPEVUM+jwDRaH2/lq3Tx1b+wrGT6zHI3FiN0yBCcHd6TXj2MSDjFQzl?=
 =?us-ascii?Q?Xl5R9NwEbRdfofayuxS3pMXMIfKPehxWw/Ifajk6ezrc5CXEFXXu8PeOMfBi?=
 =?us-ascii?Q?LtV1i8fE0Xh4WgDx8ZK5qAQvqYG1laWS+Hksla5iCOBM6cA/6F+4rb00mP0i?=
 =?us-ascii?Q?e81NvWAByGLyj+1sQQPN3mpoyrIygsiNeHsQ2tm0oMfcaDajuNjUUJNHBJOR?=
 =?us-ascii?Q?SlxOMEesj29ATZUS0OXPhM8ZjK+udNbvI4FIjC0Rt8Agg7/R7CO0U8cEe514?=
 =?us-ascii?Q?7kvURsleta4Q0Mox2+PHMWCf7uGZ2JdZTzYvSW0wWr9CXOPgi89eKS7BmQZ+?=
 =?us-ascii?Q?YVDqwDL9Jgrm4v7VC/qrx0cYoV9WQDhFhjUR2RMy3Vylt8F29s3Ib49Mt6pM?=
 =?us-ascii?Q?/ix4VtWfpmYpy9ZmZMU9MRecLVNrro3rOmkkKI1ZpDnBin17etC+eBkKbIkE?=
 =?us-ascii?Q?gpfIzijcX5n87Jwux3i9ycACdsr1fE+zFLE3UBMptGUJleBAvLXomSPM1bgK?=
 =?us-ascii?Q?2GIMdnhJRF6mBy+1cmfF0WF46hupcJ88ZepREQaHD+TdajM5MiY8QYR1P6r5?=
 =?us-ascii?Q?LkgajTMom+KKGRusL/HZ/LzdLDY4/1jgi0Fr06l+819+BZA/qNyMT3Ieldnz?=
 =?us-ascii?Q?BmUR/Lz4cuoQ1TZRtfTsjUomKzMR7pmjrd9s6egSUuNIriNHtCp6E1lsS1+P?=
 =?us-ascii?Q?brlApqwjcUnWOiriBLDXwzQtmYYJX0onQxJFpnSI20Y3Zl5nXWSq5/jTD3aF?=
 =?us-ascii?Q?JyMRXCM10ZpmrpDwixJ7axQUrvqxRtx3E6g2NhzLyY2ws62Ouva5eeH8v8jH?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UTM9aKb7z5PdbqWy/xnebT48HFSA6q4DWLMcHFx1qqvFMhdCgTV9wlaOoY5baDm9zR5O/lxTnYBQfgaTmbB5fJLSuPp1kSHO42sLA2l9W1odyAfQlK+hvHae+yTSttcjRz32TwCRoCg4U+YZszYsk5yr2alkMJW+VqcVf5tNDw8ihfMPobt05TaNtLkXdgMcMeMoLJ6xNKPRL7xmcPDxOp6kLgWZbH7xmHAh1MB50sGJId31K5YHuo4WtvnKtzbJ6mTP4PdGsKyD3ttXAssVju8Z1VUWHclwdkl93GNIsPSWNeAS+yaNl6ItbT5W0kj1UuEkQFF/ttRg865RGvwQYU6FX6NATjiaQ8lFzaOW+L9qve9GNFHQV5Tq2dXinhk3miCPGIRe1wbpw2nxX7eFamztpRHZD+aGK3o3a67dx3bRHnIu8nMeL4wZ4/f0IToqKGPShn9ReadLdCy69RN0chpS8EeAHZZYhln7RqS5jj6pgYNS8KmvoiVz5bK5Hv9ncMf03NTqDvkC3MaUlJc/ttjNavrv2wTJDL7xGFQBuRDIR4wcl2yJIa8lXx6/OZTWXdK/gh94D2Qt0r4+GJ4MH74pGUN4ZTucBRpyinw7h+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc17d347-e7fb-42e8-82d8-08dc5a93c05a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:56:21.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s2yL8sQL8RBa5Dr0UpyQmwO11oSiEU+v8JvKMd2A4Qc8A4klm5wlXu2Dd4zE7CwUEXQwBr+oCmxRa8xjVCrvrJmM7hRwNL9/5Sjcv22lkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120012
X-Proofpoint-GUID: ALExboTdUdvEpRewhhiwed3E4VMChmbI
X-Proofpoint-ORIG-GUID: ALExboTdUdvEpRewhhiwed3E4VMChmbI


Will,

> Export the module alias information using the MODULE_DEVICE_TABLE()
> macro in order to support auto-loading this module for devices that
> support it.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

