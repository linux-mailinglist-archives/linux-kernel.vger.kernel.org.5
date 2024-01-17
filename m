Return-Path: <linux-kernel+bounces-29375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7104830D68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB1286B09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C924A07;
	Wed, 17 Jan 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqR2jC3X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mj1by0Tn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB311249EC;
	Wed, 17 Jan 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520705; cv=fail; b=Xwr1ROZTd1m1hoLrPgdkF/v0kehmydEWOBXxe3yoW0hMZVk2Xv1bjB7KkTrhCLpL/arMx3BuE5oqNdQzdgL3Xs1L/I58JOvC7lrLNB7pM0EJDpk4A11jS4gJkVo3IOiE88qv0AZxKkeViBVln1UFVfWQXAzmDr/POVYBiiflkao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520705; c=relaxed/simple;
	bh=66QLZngMRlyaWYX6Q+z7om3P/nUgabYSrHMk+iINI3w=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:To:Cc:Subject:From:Organization:Message-ID:
	 References:Date:In-Reply-To:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=g39AKfMmpLcssRAMrcAVSZA6UOT8zXTPwbkF2Fc2P2xfhXiXaJZNI1N0DmzFg13IpCzngyzsBZXddKPdoJBgUetMtiNTQQ/0Xial20Ntf4TDdtaZwFKLYFdu6lWH6C3u6HciwoZcIlrfJ0YSOm5j8offmILrJ2GKFzTe2oU+Uzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqR2jC3X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mj1by0Tn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcotx031346;
	Wed, 17 Jan 2024 19:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qHsPrTlTSF/mZuAryvDvh8qeXOI+QhpdCLhL++XpN48=;
 b=IqR2jC3X2f9+5BJYMY1RqNJPoNKpFawdjjOcEmkBqldTvYob3a/C7GvFb6cs8lzg705T
 UtxiWFtzxumZzRxSQnhZYIBJtl3KSDbkHsnznas+JitLN4r6n75LroEd0pVugD7SX/KQ
 iAujrozD/+U+k8eEGtJfhH9gAVgUR1DIwuR4ykrn5Cfuuy/y21ypfc4y+9XLljXLJFyI
 L9t/lbrmQSa7HVZt5S8SUXzoTqY93ed984gpPfCfXyIm1bMyuCAKpmaUiflxSJBh9NQU
 k8JgOnCWI1W2Y9x0VyHeR8GqEXnUBgtM0gxI7OafAgvX5cimS32NENvxYrLVx5SGRxI+ 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjba0whc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:44:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HIeLil035953;
	Wed, 17 Jan 2024 19:44:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb0p7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZnfCWxuTx75Ota8v9FPCql2TAWmtvMvUnzpCpq1OYqPUYr5lEsOsjMj7mXl7fdPk1gaFXEtODiaNG8f3QcEN2ob+sA/h1K9m9pJIToVvapFk//CYTjlaLqFMxK/RbukKvNGnbLJRHK/Wh6wxvKAAXXnh8y+juaXcTaAmb+9DQEYkj6C8CuXFJOt3gwQxtQdqK4Z8Ri51XfAg6Lxha+lwbwfRfzgWN2xIyx/0eTOEmuPjD6n8vNJgCxu81nj3M5PZaOTV/rOYQdT9zmydM8f5DXWs7fsdRFWZ/9Dj/Up40FD3ISvqls5rh2hNRM0J2lCbmYQ1s7nKLy2wzwD4XryIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHsPrTlTSF/mZuAryvDvh8qeXOI+QhpdCLhL++XpN48=;
 b=lbZteDBtBKSnnKAVz1VM+TwgJs4A7aw7epdCPW82h0qphESXsvZpH8310fSqqQpkTfpkKKk43fGxHXd0L7GT5IkBUWKC28K2xB/Io8nOdbe1iNJPTfOU+6xrB/YpwHph59HSdSRwrNuUMjsylGimFhGiL4/EOrBRScUQeaRF+26gMiQIr6Lijkh8YI0VR8c6NMe9wycatN0jYrVBGXYv7JyS50SuwVNFHIcmMmm58eN94FXsANa448/QuKnDnjVTOwEtFbUPPW2/AkL7cEBNVBcLBbWjszbHakIVE3hdRZQqOI6wWMBQSsx6fFQj3u8r4YK5SSDe6S3FGuYwBOuCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHsPrTlTSF/mZuAryvDvh8qeXOI+QhpdCLhL++XpN48=;
 b=Mj1by0TnoeYuxCxtSg6iy7LyqrjShvJ/KPLBc01xg2musZ2HX6698eYpsgNegCK2uKUDyS1qG6kW5VT0plOShBcrk1qR8B2O81SatloxGPYc7Y27k+QxJjjOBAVk8iN8KuSTQHDLGAtSysNiH0xo7JpAibIdppr3/FupLJb/Fhk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by LV8PR10MB7990.namprd10.prod.outlook.com (2603:10b6:408:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 19:44:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 19:44:44 +0000
To: Su Hui <suhui@nfschina.com>
Cc: artur.paszkiewicz@intel.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org, ndesaulniers@google.com,
        morbo@google.com, justinstitt@google.com, dan.j.williams@intel.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: request: Fix an error code problem in
 isci_io_request_build
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cytz3fuu.fsf@ca-mkp.ca.oracle.com>
References: <20240112041926.3924315-1-suhui@nfschina.com>
Date: Wed, 17 Jan 2024 14:44:41 -0500
In-Reply-To: <20240112041926.3924315-1-suhui@nfschina.com> (Su Hui's message
	of "Fri, 12 Jan 2024 12:19:27 +0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|LV8PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 37711451-503a-41c6-ba29-08dc1794c0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nXrPgELaMwrxxkbS7yNL1/DJwqYi5ZmR3BXf/xP9KxrQFxn5g8qU8B12icUHHvAVSB85Oej+I6s5Hmk9exTKVKhcEbeUfJlaXVXlYJ27f0+9MNFQeORfmwfLWdKTIgTMI+eoHx5GNfMAXsel733fdN8N8f2tAftKRmIugFV/SURjJFw4Dfz1FMmoUSuf8wthIXAxbTEGWLNvkeHHoRj6R9EQ+nXpysmOZhIBU2u9ZlW/DG6vn0OcHsYVHAEBDsnXz7bWGOdFxhoMKma6d+jyc9KXIh2eOaflg8IPMSsVICcJb1eHLzOSYWxg5i2pB2qsV5li1kmCQz/N5B2s6t/Kt7oW+Sm9O4SFp+ZYuIoDqXXSmUI/NrbXP9Bg/lGxxXvn3BSEP4vmxOT4qIHwU1s6IPjR3FsHjV8cf7GodEL+SM1eRz27OrkwxLaTJzv5inS4cxp1sYPcAHf4CkIfDi9oo4LwHOtDunyrkzr58TlxgxThimFu6JYWaeEcThKpVwbmOgoiUzQ62b4MzwjDhQLTesNll60M2P6bqkNgIszCPn+2A7ZCJSAYG+LP+B6DjEpD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(2906002)(4326008)(558084003)(6512007)(478600001)(6506007)(36916002)(6666004)(8936002)(8676002)(6916009)(38100700002)(7416002)(5660300002)(316002)(6486002)(66556008)(26005)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0Ax9kTIiHLWBsLjIj20qeQTXi7JF43jsnTT/srPtZBvvUJ+t7Bz+ee9mHmPd?=
 =?us-ascii?Q?V94Jh3r1UHMZ1JCtzBIEGgmEjRbgzGNijIQVgYA9MlHt9/UqU7gSj8SGAHfW?=
 =?us-ascii?Q?0ev7dd8sPEk7h945+sk89rdsKsVKF2poZp02Jxfk6Sro5vOuXb85M9lxGUkk?=
 =?us-ascii?Q?zImcmdV9ZWgaYVKlGNIH8kTJHZ8ltNNqLQLerJ5gkU9uiNbhUEi+Be5xw3z/?=
 =?us-ascii?Q?h4OFg3HYEy4N0YAAJYNYgVfeVgVjyXvRbU7AqDvooysNTceUWFsZSATyAiIl?=
 =?us-ascii?Q?u6Z0t0ew0/iokRS2mEuECjChhwCQ0FqEwvRrV9raQpNshpn9oSs24sdmdwc3?=
 =?us-ascii?Q?Qdq/rXjwfbwc0Z4lycIaaceHOFpyhyhvDl/dJQRsgIFXkJm9ta6+VNVsoFAS?=
 =?us-ascii?Q?jB3G2lf6J+DZDpgVbBie0Iw1/z1KImKKGMniUW18jpLWjVFPwkhKTBgFsO+a?=
 =?us-ascii?Q?MAVSpvQaHCoRQtRIcO1M3whJMoYQcwrluHkUP5eTS36UwslIP+Ug+vsWK09w?=
 =?us-ascii?Q?0tkLzV6O6Eu/utFW+19VW3IMuhm7rzbBGqpuZD2JEQPlqXxCER+IEOoU1Rvp?=
 =?us-ascii?Q?52rLC2lcz4TsCbLsOg/CdaXwOyvoKp92QJN7jAE0+0kGZzZr0L1P//59/Lp2?=
 =?us-ascii?Q?fmTE/XxvSvEj4u+gchV+wE7PAyJq9/MoAxkCSOzmFaJEZ3miPCyjkKuVyYb+?=
 =?us-ascii?Q?u09f1yBb8IAXQ1mYouyDkacWyHsGrwbuVJK9AHnl9/U7F58F/e0hgdi3Zk3i?=
 =?us-ascii?Q?tVwDUqc3K9b7qNEyyqkBEGF3jtLW6Vlg4XxE2ntnOX0V1LJoYxEG9GXlxl2v?=
 =?us-ascii?Q?jvhs4yMsERnzVe6Jub3jQfV+yOHGWQtUcG+444ZLwGqYKlnUWNsiBeV/QdwU?=
 =?us-ascii?Q?wy1jo4Wp4yynEMfQXiqqMObEvWMpOZg8IWf7Pm9P87eX6UU4HiWwkNSdcT9x?=
 =?us-ascii?Q?isD5tzlWJ7s36JE+U9hUjJtrTEH+IkWB29AOKHaoPj94YZvdb3myOMZKb2J9?=
 =?us-ascii?Q?Brvrii3HYnMqmGmBlAAYvYEnFNqzqqQYiQIphtag+Q7UtzCWbkyHrAHyU1zG?=
 =?us-ascii?Q?khQLcT6elcUOyEMFMLQ4ozU2+VVbHVQQoLO4fiCjT8Dvb5q6qFS0rMkbYypR?=
 =?us-ascii?Q?TmDRotkx74ASJzUJPkDl2IqxMExDWZvb1DYEOc3FNP3OCgzOvrvLMeUrL6Tg?=
 =?us-ascii?Q?Sq9WoYTK7NJPm6ZDCOr9ogjfk24C1EMaQVNldushuEX6jMSMh7Wk46TIYV23?=
 =?us-ascii?Q?/fywi1K2/k4H1AO1aE7pPvt30tZOui9tn53dvDVO4khutNFQwnxPEVJVrvF6?=
 =?us-ascii?Q?tg61w8Y1fKdSbk6d/PSBW/XcQt1jscvU4xPQkd+/fBkUwbGvIJVxiaHikPiA?=
 =?us-ascii?Q?jRBEV35G5NCOELtTQedWnPDVNZ06PFmehBtYoyr/mgcT66zRIxMntH+nYiGf?=
 =?us-ascii?Q?8/RoC+PUmsICLtJ2uhHkEe6EH5zCrKtGCivvGVeB9/kGbGtzJIW2klnNUWcu?=
 =?us-ascii?Q?MSzMPOiW+R7970V5YirAO0YUYF7D8bIHE/oMI3Zs0zrFvPJMNuv3CQuz1SVY?=
 =?us-ascii?Q?hZu8kimJtG9sxct2IfZQDCCaZ3cC4kmLhEj/aQ39Zon+WHv7NjzzNajaQTLZ?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x+hlYoQgk9X0zHeYQYHEnDf3HGJDiczD4v+ALPX5+ysGJekXCcy49pVtQ/pfBLV4wJ2SH7Hlhyu6jAdZMdYG3W/5MDkK9uZyNpICbkSDjIHnBaCj7RcSmBGEHqbkqdR4HWUySa8/GPFrDfxiMzUrKEW190W0dkypCnFYlvo/Rrrix8wnBCNMg0gelEC+UKzVV1UEjsq+TZps41r2e9cCPq/EXBzVDj3oVE2iB6aEFTDJDEiOl2+yDM1rem3mT45cxskDhf47R6xq/06qAOExVnaX07m6unOCMMLpCJ6Quz6CiXIuZ3FdYa+YTJCptd9W3Y0x+9iMZOvV+4shGdNK0uO7+npmgzfEVAly0fCcCEX5w/YQzaMQlyqegKuiCJDu08lM20/yoiOW6a3DFRWllOlc+NySwep6d0Xm+XzdUNHLoxF/LeKQvc8MNyn5mjGHSfoYU4ygBvCHV2fRtNdAH0Ui1uFX67AMzzp0SIO0wnugXgIA4RfIjUIcDsOuKkj/UflzB+D959o0Jsu6JBqQTGJ0nGwKurJ0Ym3sBZylIzV0nLo0bYDzUgPPuTRukxGfg8Ppk8/zqmcwTq5LX87C0DkuOmNYkWmRlYpRJev5zxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37711451-503a-41c6-ba29-08dc1794c0e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:44:43.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjQd4pWx1o4mRfsvv3dKjB8c8wMsYjcswS9bd1Dur/nhSzzUzbPwGqjla0yssWHVEnN8Vq6oQQGoQaU35NYMy3DxNarhe8yGPE/SN5A3M80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=612 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170143
X-Proofpoint-GUID: Wm4QWvMKGZqU5Ggq8maw0tOkefZLXiSe
X-Proofpoint-ORIG-GUID: Wm4QWvMKGZqU5Ggq8maw0tOkefZLXiSe


> Clang static complains that Value stored to 'status' is never read.
> Return 'status' rather than 'SCI_SUCCESS'.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

