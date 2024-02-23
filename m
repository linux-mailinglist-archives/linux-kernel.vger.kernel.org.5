Return-Path: <linux-kernel+bounces-77620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F2860828
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F054B21087
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA54AD4B;
	Fri, 23 Feb 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MoAhjLj6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PwkpYDcW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF458847E;
	Fri, 23 Feb 2024 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651136; cv=fail; b=fhNRVg5aLKV50qVtpjbszWxg8C1lggbMAYC6P4PR0uxYblDje1WX9TrHA9QStr38CcB1YVx8z5arLeweG+5uj+9KpFuj2hOZdL3HV0CZ7gEYy25wtDP9NgAf6NEUo4uG5cuFBNf96ohRWrP2nmiQj8cARgkQ3s3jwj7O90T+n58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651136; c=relaxed/simple;
	bh=eZ9mONgI1gjVZMi160RGdnC8PzQ+dASKxc6TH8xAmFk=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=rYXMRN4Mie8E7JDlYlz+cUYrnOajz3+0YL3PCo7aaYl43mvTczv4P7ZCcxeuJteEmdefC2L9wvuMXvk2Ogn5kjaHhxS3KzF3sBs1RRgC1WBKC0BVFTdiF0/mYV3rwSi0/T/kqi59hf/fqgKg44fLkD9C+L6oB5dpPePl2yC3vic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MoAhjLj6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PwkpYDcW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQUZH013906;
	Fri, 23 Feb 2024 01:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qQTTTugDV/C3oKRs/JzN4fs5FhlGf/AkAql690BJ4vo=;
 b=MoAhjLj6/Rtqq8Cp3vqAln8M7n1Ola4x4/PFeawpuKUBKwYPo0m+g/yX03hj+yAfkXnq
 A/c1+mAzEKOpqmo4C0LXwbqKRVlScgrLpAELGMPwaW7GHQq5t1B8nJ3wB4p1PpiHGn62
 Roza4E+L6mZuZ8v/DEEhYYdhq9TItPA81nmy1/aghOI48Upwi2+xYiUHGunwj7ihZd9q
 TPxLuegV7fsA//CElKQrPzsyNGLowl+HcslX3SoDhP+zpWGJ9rVzHjku61aDczWZu5XE
 NM79J3jW77Lkx6S7dnW99uuBb9IYshWJAH1QKD2PpUAVk9DvLFabCJCcj+dTtx+3+Ju7 NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw6052-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 01:16:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N10YVA037737;
	Fri, 23 Feb 2024 01:16:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bf5qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 01:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwxM5KVBt1SDXFIXuJpOr8gTFb6ESH+M5cdSVFcFJNwKi8roo+X5Y3sVkDlfbYzjtStwFFO5fuMgFQRCGC3Aly+T/Y8QKa+1BL4AvafzUzVWYVN9XFpXk9cmTG4znW2K1A4mTC8OJAhTqCBEiPVqpmYwkaYp72tHZy8d7qv/afdS4eVwbM7W/8pQVHiYd/tvKZKhPLTRs8F3eI1DMIesS0sbjkoebElLnHIiQ7GaN2OV14f/sCnbHrwK1d/hNcJmreQBAzOH7/E3Il0CNrPo4/3+gyUrPO3K7fuUKlQDXuMVvZ1NqxIBr5h8TZlIFlgAA4iyq3j1hxBdX7x1GiAAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQTTTugDV/C3oKRs/JzN4fs5FhlGf/AkAql690BJ4vo=;
 b=I0pwQ8Ygp5Id/xB4609V+NR39vn32V6Z9b7LCDExIDXUdk4nRv6tdoH+Tn21HICSlXGrBrTCx4Lyc4mhJqUOgvTBLTfo7kyXFCO3AuaEdCZiEHK+zPjktfsooFrMak5mgsRVLL8SuI24hYxMkaLvodDuItwSfy6FusCl9TveMVS6HUJwRoaTjITC9m59cGtva6WS0bSo1cpSBbs9MpGnTbkmDUA2uXimCuI/M10znCq6GHW/CnxDa4EeR2dI0HKxYwUzdE62UCdhQ330mw9uqqU6TQeZRtzzdJaozvPQRGgOgHpAw+0RVjJvYHfXp5SMYVI2yaPBXxkc0XCyaQkfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQTTTugDV/C3oKRs/JzN4fs5FhlGf/AkAql690BJ4vo=;
 b=PwkpYDcWrQXpAKghEyXKyILrKRsGRkm0y1GeVzQAwrLdcM1WHLYqZ88UvrCpVKa2H/fEmbn/QUH/YGoYQ+fqkmuBucICPKBPZhKuRBq6PNK2tyhrB1IaDDE2twFVUqbnAW6yp31LHMYR3aJCLC6NnUT7EHAPLxplFA2dhLEsp8M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 01:16:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 01:16:29 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
        Sathya Prakash Veerichetty
 <sathya.prakash@broadcom.com>,
        Kashyap Desai
 <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Arnd Bergmann
 <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit Mogalapalli
 <harshit.m.mogalapalli@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bk887zg8.fsf@ca-mkp.ca.oracle.com>
References: <20240123130754.2011469-1-arnd@kernel.org>
	<96bb914c-79be-4867-b59d-62f80dbcdace@oracle.com>
Date: Thu, 22 Feb 2024 20:16:27 -0500
In-Reply-To: <96bb914c-79be-4867-b59d-62f80dbcdace@oracle.com> (John Garry's
	message of "Mon, 19 Feb 2024 12:08:24 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c605c4-959b-42c6-47ef-08dc340d1005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	etpm0XCD390yLVinHmtgvUxBNfgjLAu10NW6uj/fD28SdFKMjRYpISqVa+VOPo9c4kkcn0ZSfPWtbAgB/6bGeji/qJoinKjsyRbJQ/NjvtBDCcJIJdA/pF0eqUMHny33MZWZ63MU2ty10JZ5ZVyPlaTOOV8n7AYdQ6iptjHZ75K1j3sTRYIAk+4zx+ZDm0ZU2e9NsO0bjFicp1yWQUJ7Pc77uWXkskT7TYzC+yaL6/f3DwZNe1XLVx0TIrQ0fgEZqT56r5YrbeTrFSy44rycuj0iExz4zjXElln8UOAEwOxq30iYfWUmZV09Kwff8IfMcik7C1haSpju5diLzrdCY8c59Hy6zg20pJH1dL9btHJbZdHpvcYVH/fY7LNex5nfRh1elQQP+bvlE8QT+lYmqOP5hHfW605WFriyYbMj5JHqOSCdB79b1xY7aA+cVXSi0J+9zzbrOUFQX5Lppu5SnyoIz8ghGa7YrL00pXHMt0nTPJ8hfPP/MkfxnKuPq/NnP53BY9Dr5YM/npW2vS1LtWU5Q+7nxEwql4QdLYp0x/A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WYKXN98Hqurx7NKk9Pm+OBs0exdbWb0co2E2CwQtFPsHR709JJXSG0ildehX?=
 =?us-ascii?Q?4pVW2GKpSl/OMq7L0TZ18COQlP1lpLZtqw55v5/aNGcOaWja4SOQMT+GavBM?=
 =?us-ascii?Q?zsggKmPE+eTUOlobc4kue6cBM1o5wpdyYcyK78W2QuNZiTOnXgTi2nnpY6Mc?=
 =?us-ascii?Q?fS8PSjA3NaDZxsiK4GkgNcJpC3qdW7G/PqfV7eoJ+wZ/UOR6chzIDe158Yab?=
 =?us-ascii?Q?I4CXfm5gsVjao1Dq0PFV5U3sOi5XO9U724HbJpoB64Fpw/NpIAqXDq/oxMEf?=
 =?us-ascii?Q?VefZQFYzcZki4I1UxD0jXdXXo/Z1ru9ZPx0Js5mXhpIe7ZnMle/gz8+r+BzY?=
 =?us-ascii?Q?Tj7VDrm8ZFtvnghjfWmsq0GJ6LOvTbay5+acL6ASwt7s0Dbq4qjl5dfq8M0E?=
 =?us-ascii?Q?Jtug2yQtMcGXFugtQfG5lExxcrrfKmzju7ujYf0ojnOc0kYN+M7QbrzRMSmg?=
 =?us-ascii?Q?FvsgfiVdXewUKWZo455d2Hsh0jhpVyO+ipDxSwjeWt+nBTt2OYKcdwrncSMb?=
 =?us-ascii?Q?yCrsYdWzD+IwEVJBVsFrk2NZEonzlzWHAzG8ETqv0hTpie4G+ygf3fsYjgHs?=
 =?us-ascii?Q?HTlcWgXRAmf0c2d5xvpjjGqn6NZXDS2aTUJyHN7jzwpyK36C065D5cxbrTPH?=
 =?us-ascii?Q?Pw+E2MDpR6SXOv+YPDwTxebTEGjlPTT1tXzvG4/5O97uTjc+Ni2na40pHeTp?=
 =?us-ascii?Q?WmsIrYti9ZKsGqGogWoPEzzhtT+hupb+bSP8b1hj71LbzkVBlDbjlZz1SqQu?=
 =?us-ascii?Q?cXB5CqNE4D1Fl5IU7dguDf6uwr2PQh/2gM6UiJ7ABhTTNkwAovpEL62KQLTE?=
 =?us-ascii?Q?f1PfsJrZikj52L8JOinJ38CjKQB4o1RKMdIRGjC6ED4kAqvEzjJEbt9zUMER?=
 =?us-ascii?Q?kzCV8huFE3QC72aVTUD5vGGxoo0bBz1SouFhrWW6BnRZN6xEFVPd63wEtLWk?=
 =?us-ascii?Q?s5qU3JnvXyLRPEwuNmTjPGofugfK5l89J/uNR1h7PecQc8yD3zxwGnW/YxyL?=
 =?us-ascii?Q?t4wYpoRmtQ42GvhfB1ZODDTORMXp+wpWTlxkF4uAlbp8oLukyBkxHhSrxsVF?=
 =?us-ascii?Q?7LUgUVL294KU1WTFSjc6XEXj2ouzGSXvE/tzgWlGohxdy26k99q5IrIwkrQ1?=
 =?us-ascii?Q?2s4RSBu2uPOcxNpldj99REX0iV5hX3nOx5kakBeop0sy4H8tMhOX49o98pNW?=
 =?us-ascii?Q?IVe7E9+9q4lfS0l7GizU0egNkkClLUyHbnnlDVJHuoFVj05DgaTk0TemiILr?=
 =?us-ascii?Q?qPORX6mH13F1ND/PNFjK4yKYrK+1aIYGNyLLvNVmm5KGem+c34Fg/2npA+mn?=
 =?us-ascii?Q?TJ2LjT/aWer2mRKLraVl5YRr6mnXhPIX6ZGCSsihsNMSYBbKfdhaUVL00Uv+?=
 =?us-ascii?Q?NtWVnG6yJNwt02qU3ksyWDVKMoQSxu5Cz681fRMg6kMSLTdQ/m3CLHvbk0C0?=
 =?us-ascii?Q?G8Ad4r7BR7sZnXiFRFh8uW+R8RkEcFoD2mvG6jYZnL8f/h97cEijpjQHWznM?=
 =?us-ascii?Q?zp5TyUafZt750IhTGx5s6eJTzoTQETvB3oAc/EhQsjO8cD2cdtvfDt1RCOAu?=
 =?us-ascii?Q?hPZQN7TWzICiP1U34b2K75NHONc1u521pqvGHGhz1h9RDt9H3VvEyqZpgnO8?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n0lDWv+mDCwOK/bdgGcoxHtLCXb0HMLSZ9y1IjOFCiYPlGFajMTe3bVeKImC8xKWZfA2Xl1mUbWtQklyL0evVBfGifoyJVRvVjZHAG4vke19P6POCYoNSvrfa0z63YgptS2Eu7RQEsZERBoFJMII8wAJilJgrNZABIsxo0Tx7tIHX0OWH3QpXlxkNK8Y4zzoV8vcwb9ESn/BtoDjueL6FwDaFsIwUdPlo6g4ekRzV8/TRdkqpiUEYe6J9V9xDZj983XP0B2gaxsnmE/UHI/e3eCFSmAUu7e1a4YkWD5iSNOgyDLH09upkODpbyTwrnW9KLyqjD97e4+Z1NISsEQ7919Ldss9xeGA1F8jFj/R2IAebQLyMU23oXUiVH2TUnZG7Gro2lYqEEOOBiDAkxDQuTG1o+yc4+CUWEocy5P8Gu5lGZ+8IwaQqDvFOyro9ie4Ki0f9W7lCduHXGoTrcx+nDTNWDauJrPUxACOp+5G7jhNk1Scl8upeeBkwLsbGjKZbWhts69Q67GmNd8lTCnrmsAb2BIW8KL4Zp/qiSg7t2u/S2EwRHbxyk0e03Ry3ibIyhcfG1+DtoNtxGaVKBV5Md6HCjc+MFOZ0ctcZO+Lavg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c605c4-959b-42c6-47ef-08dc340d1005
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:16:28.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0tDVYrie9EfmfRGeDYn6KoOKQedrTDbw4x5zAbZmPy3dYxLLQMNSNxgxd9mj7kVUzrCjcmHS5DPGfScZF4gk3RGDCKevwuWgi7mJ2cnGwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230003
X-Proofpoint-GUID: W5yNvm5MZvRvzmc5b1OrQvOuNQez479I
X-Proofpoint-ORIG-GUID: W5yNvm5MZvRvzmc5b1OrQvOuNQez479I


John,

> Has this patch been missed?
>
> I have this same build issue for i386 allmodconfig on v6.8-rc5 and earlier
>
> Tested-by: John Garry <john.g.garry@oracle.com> #build only

Broadcom requested changes and I haven't seen a v3.

-- 
Martin K. Petersen	Oracle Linux Engineering

