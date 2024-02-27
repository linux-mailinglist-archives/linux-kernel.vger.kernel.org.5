Return-Path: <linux-kernel+bounces-82603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05C8686EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECD41C285E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90538FA1;
	Tue, 27 Feb 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqcccUh+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qnrNBF7Y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984E38387;
	Tue, 27 Feb 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000618; cv=fail; b=puOAb8Bzn1FOUOhLXXMLqRN4ZoYmiD4yHh69cXdMOwdpNYgiph0X8Z55eQEh9XNhhNPndhkL6BbDTgYkAViGcg47N5NBsL2d3aoGFrK0C6kK+T17IZTs/r/etBrG659pfX5v7M9yyjTA9MDUYT1MaCnZKMVsB3+XuUpo7uGzdYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000618; c=relaxed/simple;
	bh=aZFzL7Wg+lgufjHf42LNvvRoOpjckb3b2lNwBRuxgas=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=l/Fgk076YbZLNGXHoQ2RMZEwMnZZn/7ux6uwvVJilAl34/Fy6xaIqPFL4eGFArU78JFpjPLG8IrWpjYMEam9ljeIyanQM8RsGVkfYTxxVSkK7g/KoPqrqELAG3n8KQ2wh05lxOrEwXLkoSC+5fqaDiTk/HrNvzfWwMWyTCL7WxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqcccUh+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qnrNBF7Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1E3Qt024402;
	Tue, 27 Feb 2024 02:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=TYiI2QUhvJuTfefHOwDcnZrqnrI1cUpU6x2vsiWySCs=;
 b=eqcccUh+nbwIaqJLGceajxahDaUkWZtkeol4qJtaYG3K+pzGDKmFEOfMQbYMJymUkWtS
 wYDLFDwRkHLRa1T29rEf76O3LbJEF3Dwf0NLv/A8kpuI/9zOODxtzsMb0YuUmte6VClY
 KmPD7vFVZooR5LY+QEf+3rqlpoFpIxMjtq6JudPkJKRAmtrgHBVJGN9rDXlvK/hfKs9F
 nsCMyNGXZv4JTyl1Jri67B1WHDSSqYYqY/lHpxT4zCpMZDS0Fbw6ft2csh2n6cpAx+BU
 3a9nLTyd72LGmbQKbYufVNh5BE/NrMCiGCjx1ARyFvLjZ6XEJLoaQ2FllkPle5sVylWH FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cce0n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:23:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0OfK5025531;
	Tue, 27 Feb 2024 02:23:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wd0252-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM5QQpJDpSo+sgZlx2hyQEsrs2Tf1ZEdpzlyBULwpnKazfR7+F86bGEvTMV/VSfrKlJi0NMZDvQz3ZimfL6vr0kphTHJJkYk5r/eitiwdd6GUN0VyXjrmOV43PyhixaojAMTsX00lcer9rg5YtNqyIyp+j1jVrFzpu3aCKAhaP5ld6sjCLSwd7QaYM8hBaEcLKvA+ytWnLhR+kdZDuUFnnwRCQLQZnpF2XahcTEBB3t/PYmNNJKLBxNXi1IUtFfCUhuPCDG9fCdkugUPHtZG87/OXrYEYDJAefjccamIrq+7j2kZp0XCb+gRPKJUsIckGoVipMeUrem1Ogysd+W5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYiI2QUhvJuTfefHOwDcnZrqnrI1cUpU6x2vsiWySCs=;
 b=T1HXXhKUaRH5CwfDlKlnMXuElePjbbvdhCE/kqBlbkZXyp6JPYsSvneILFwjAl/u+GFymQDEXBAbobDy6NWnfy7BqjFgd6GGLDVht4SMCBVHoP5HrixEW4zmuGajQ00YzTFHCxd2lJzdxjzz0P6OxPf8u5lmKkkYdH6sjfbNz/HJsr+R29/4rKuE1TDTwig/HbnAtcrYKeQ6xWHQGksRkMnxxfbU60M7YBJkn38Q8eyzRnjBGqF7kA1374gVCXO7KBAdEYBse3BkowPZmjvBSNSw493zIrXHm+mST/e+PNNw3sU4aWqKaO+YvFwkBSQAlnrPhogLXoHkOrNZD3MnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYiI2QUhvJuTfefHOwDcnZrqnrI1cUpU6x2vsiWySCs=;
 b=qnrNBF7Y8wLAdE/Oasck0BRpYaRkJoUVjkbAvvbQJjfXPk1KuX6O8DZu6NbuIRivJQJdoSYijKK8WCiYY47PiXmoq5kq67X4b2GeDUayVNotlC7SOVIbLmsxGKozlS2ikYCI30rWtIRleAcwRhvOWVlnJBxuEOqXQTwgTGB9rfM=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 02:23:18 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:23:18 +0000
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scsi: constify the struct device_type usage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttlu4pdh.fsf@ca-mkp.ca.oracle.com>
References: <20240219-device_cleanup-scsi-v1-1-c5edf2afe178@marliere.net>
Date: Mon, 26 Feb 2024 21:23:16 -0500
In-Reply-To: <20240219-device_cleanup-scsi-v1-1-c5edf2afe178@marliere.net>
	(Ricardo B. Marliere's message of "Mon, 19 Feb 2024 08:45:53 -0300")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::9) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: fd833624-c197-4b55-4d50-08dc373b0f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Up0NnZUn+uk0FHDwBRB7al/1ULA1ZDWuO0lH7FELQjzaxD56QHI/UKB/nAhEnAJKISaTLgaffZkVn2l/D9cVFjFmbPiSvrf9FVJ3/FWg39GY/Gw70pBUVB+GVNbOeos21LfcvCs9FBfObnzZrbTg5xa0WxYkp3rNb3MkXjGqA7X9DR7xsN/PKyoxcFMiXvHDaKn2yTfXRes8YI2dLnK7RpKSidRApIm4rf41WbaHl1+55SYZMJRHtk82YzU+pQfDnoUddDhJskotlwTKLQQE5IEmP+C7pncFPTasNXEqHQdBAKnPa60wCj+yMRdnvOeYaghB7bP0SpzRRAW76sjJ7d+YzpNvHMxEJjC04e3eyFEJZve79eGGgvefoBUe4KeenylM8WtRMVrbP6EUADWJubuNaBOu0fXVHpIadLWifDnZr8hmCtg1+juVL969Lz++5vFeU5H46A+fnnIoMrFYfncD+omU3Zd6BxvF9sPNJMEUYP64k2UaQMCRk+gaINGwaYefNGX4ztbBGyEv6CxQ4oZPlMUhf2yOG+b6zCoVwcQaDxkFY/Qpl18YMZL9b1kUy8Mu6h0c6A+BGYBFSb7ZI/x/o24TYYinOP8UhBGhp+WifIiKAwzJbBobWfCkAC7X
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wzPB2ilp6xkkq9N0UyxzgU9b4f/PJVkbcHRN1hL4slu9Ojrr5ghAf7VrQzM3?=
 =?us-ascii?Q?xOsn4MDHkcG1LjpPYvLcganKMtzO3pdc4TTpUJZ8olGnhsDirXrcjIHSNNWY?=
 =?us-ascii?Q?qaIZfxB+1fUlVjXCzPXct+U0vaX/qicqEV2FPYThDRxIyvSFwElNpQzmwL3y?=
 =?us-ascii?Q?Cz5nAjD5dbYHv2SV0uDY54F7dxBI3z3FHaj9dEADW26pl0AHrFRqa6FPxo3r?=
 =?us-ascii?Q?tyd9j/JSaE31AqHSIg0AKUv+ZfsrmBpdxFFHdGKtGhKzqHr/u6ku1aTRVc88?=
 =?us-ascii?Q?uq1E4chtrTBL22Xt0HIhECiGSOe8r5IRy/396HsiCw5KhlGwDjoJcDG9IOs8?=
 =?us-ascii?Q?j/YsXhTRuizMx6wuhsrmE9f2jG50oHKMH8sgoXVy+vcjZcC8zC/mFC2bEJVY?=
 =?us-ascii?Q?8BMDWR0UWPsZEEThbuL10y/8hcRPW/nOP9gvNxu5/fPOnT1RiBWPO5VHGdP6?=
 =?us-ascii?Q?8tLjsUccz2Ew141qnOcmsCwuGHqatu0XBVSv/sNC9JGBDixEZLIE+7aDdg6d?=
 =?us-ascii?Q?eF0yYhDqAR5nRHRksXVxpSoTuLKsrn/eFvrcn+MacZB6u+cLHX2oglWAETfp?=
 =?us-ascii?Q?Kjs2KrN2xRF4aoXbSXj5pk3eEnVTqoD914Y+HOgJZcTwFQvhu2VW1EyH8zkJ?=
 =?us-ascii?Q?KAAWFWKHAF0qLI5OexYFCSvJ6SXVlrh4PnDpkK8qd4j2RfxrI0p6ZMO4vv6q?=
 =?us-ascii?Q?QCKdKGQeVl9+Btvrn8/YibbB8njAkv3nKh9fvE7UUXg7DNG6t/Tzxd3p+yX6?=
 =?us-ascii?Q?d7esIAcn97vbw/HEriDdUiChg1uuskfnKazcltNsVuoKOs1C7gSbKhsokXsj?=
 =?us-ascii?Q?X14qBUDZHxs+CUXfYFjLt3jcZTy9DxYEZPYInwxQhhzsCSt5mwksAMtE/Xtf?=
 =?us-ascii?Q?It3CQKPdFe9L4OZv+5sxEaQfT7eGqTBMT/+ZUYuQKlXLLY4EGIaRDEe6qFVr?=
 =?us-ascii?Q?ZQEG0Kdqc3ta19IfGxwTcSTNtWySj9YdzHkTQvTpPVp4M2HHzbEjw2Sz+29H?=
 =?us-ascii?Q?7ZZcsfnHLGDWLqjB6aOYMmXWqlROJpxQXboT4xilwXDvzu/r0V7qe+o4i4V8?=
 =?us-ascii?Q?Sk9sl2chT9cfkqbgdrzPO+MjKLuow9i2fX5ZN6aUmB7IXuupCD93T99RA1zl?=
 =?us-ascii?Q?J60XMyRI25VY1WPm9NTNBf2OTShi1Hxt0JZT25IBfuUMf+rRTMFXni1Mu9P+?=
 =?us-ascii?Q?M0bMbjR65RcsgIwtllSh2kP4uEY7+ecsD6nxNAy6QSrfLJfRd0KSimHmtFti?=
 =?us-ascii?Q?Sxbcyp85Nx4qzgA8wOp7EWnlhhhiILf7IMW2HQgVzW8byngXbVI5KgQ0ZUgT?=
 =?us-ascii?Q?L2lKDnoCrCva6Esg9f/txdi5+CA0Uf8JWzMEjreGSodqh7Oc/4bRifa8faCi?=
 =?us-ascii?Q?QRtXpV8Aqb8qMfa/MFQqv28GiFe/GaA2XvA3X3SOJ5Ha+8KjCvwSC1ksf8So?=
 =?us-ascii?Q?OmyrAtJOMkFyBrUCl6/wSxYPsKVryOE6a0Sn10KCCDVrdcXZ2xuO1dFAqh9b?=
 =?us-ascii?Q?P0pLHUbZMfqvWpGpMtNX6yJsFDJ1Tq9BDYOPUbzK9Hr60X0IudH1GwGq+bCy?=
 =?us-ascii?Q?vcNc+uWqYLZ0jnc2XwtjhsV9vFRtU1LI9UeNtX/fldBXGYJlKwyGD3X/APnb?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T0Ha8kbdpdA7Xv7r4mVmXxbZWMaE+WzDcQ7da7cAZYtrFTNkwWTofNW9b3sKGuWNyA5bpJVhNjF7WnVUMZ74KaumzeqbM9I4J3jkcKj90BVmfBRromNZeL6V8ikD5mg8J43V5cLgzpWk4Mc+/bAOHdCtd6dLBwwzRaqh5zQzmax3vM+VRpQAZAZyqOhxwkE4KAMANwqbPkb3Tbe8yl/+1Qd0stJZOyq6G8JDF/LJYW82sAQhNjVoykBAj+NFW7RK2U9xB5kL2gzXTIb4JxmA7AWWSPMgxnHc1bZ2iJ4bsNvfU2BTrKbFASmljdGeiz1Fth7z9qHYMKuU52S6UoFGY2T88Nz25TrqNIkdtkp1L+ehkFGFW0+rdEp79NwLlHou51fLOrSqY1MtGccl2Db1qxJ6gwpBA4ahtJG+TUKZuF5JmMhdlA3+i97Fw6hDVP/rNpiNsRQLgV3fHr5+EzzjUQF/eGoO+TJOKhQKDOq3cAVl1nrHePzxniqLup0jlWFNsUDj5tl2+MOuyuETZGVfVILJ5eVQ6XTdyXlHaIF85kCi+gPEgx62SxvDS4Aq8o81QT5RkPhrkUeCQRiuPDHJHqS1gX0IH/H/4IX5F9EI1nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd833624-c197-4b55-4d50-08dc373b0f7e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:23:18.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkZBx1K3EPuLIc+hjsfCGUIlyZOsXNZR+ZWu+2pr4d+HEp/CyvFIdPdWD9XyJ0ZB1S+KivHvM2ifkP3PUjbowrtRzYB0bxCJyDSbccnlLDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270018
X-Proofpoint-ORIG-GUID: ugqllbSGVS1VH-Qe-SWvg-nRAB1bbQmo
X-Proofpoint-GUID: ugqllbSGVS1VH-Qe-SWvg-nRAB1bbQmo


Ricardo,

> Since commit aed65af1cc2f ("drivers: make device_type const"), the
> driver core can properly handle constant struct device_type. Move the
> scsi_host_type, scsi_target_type and scsi_dev_type variables to be
> constant structures as well, placing it into read-only memory which
> can not be modified at runtime.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

