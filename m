Return-Path: <linux-kernel+bounces-157913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BA8B1886
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C62B23C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E611721;
	Thu, 25 Apr 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqsejYyR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k8W2mBYS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A81097B;
	Thu, 25 Apr 2024 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009392; cv=fail; b=b8AJfU7I1r9obtvNrrgxIZfUMiA/0q8vQtpk5BYwJoAqgbRidYY9L+ZUCSroR427aLTWGbC2dohKqjupkw27GO9SC+TxA/g3sOTU7Abfj7NdbGaIlWmAz5ufwwAnjJfSDPy8D+k3lbhFArnd28SgqKXkoeBFwhPrFvQZ7UOqY2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009392; c=relaxed/simple;
	bh=wDGCRVcqVXsMYPj7XfBI2LmFSTJ+bpHvLVg8NPcvqA8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=DikBqAU4sbUFSNNgdOW452ov0gL+QOQNEWcIZLM9sw/KSI5m1SffTnhadwkwgzTamRqHPYFw3H+0SNVZSi869OsJBBoktjJ++Hb3hRwEiU6DsMD73rHKxRoYOlm5tJHb7ZWz0zbZhsQ+NQOR1+lea74ee5RBZRnGQC0n8CZ5qtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LqsejYyR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k8W2mBYS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0iVWf027761;
	Thu, 25 Apr 2024 01:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YV0RBCFSCX73C9zQjfBhcqMkdbM1v39GbgFv3262gEg=;
 b=LqsejYyRTKe7wsISedSASxu1kRRCLSHJ0QXSZTwcX3ctsrswf05ASOAKNmerG2HsLTfB
 7TQmdpSyNdBX4UVDaan84XERuLoGGxbp2PdF8YcNot8rxE/Ue6/bVLzZI9GvLQ1Ah2UD
 Qc46buIz88UEqzutOGJaBf0YyvTNOCHbb+jKDKmtd19PbKc2QtDm3Nvz0UILeDriwZ+f
 qbo5oC1C9F0aSL5lmJYXCYnQXtANabuTsWfx107VuHM6+bH8DHA4y0eXTddrTGfNfOGo
 Zq6TFA8bIhrOecl3rAHb/DDnVxMZQUwiG8qE07bgNwjSk7JqIceps7gUwPY5FZ3cWu5S iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re1j1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:42:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P13QRo019972;
	Thu, 25 Apr 2024 01:42:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5npc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul/KGAOCq8y8waTKcXGdz2bS9ZisKSW9Rbq2U1grk2cigPgQ70UAW4231OYP6frGsc9+VLbY1T0fRlDEHZLIvGgF4UvFQjY7LhBX3nZuf92R/OnIfm3k3nJijdhqI7O1w/0ucni7hA0mRr77ELqzQ5s8kt+ZgHV1c3qLjw+OQRoq0sv2rVCitueKRasTxVTeDkj90rrPnQGGjhzzjnnrsDD18Fnr1Avgg4vTwd4OlyxcoTRNI0gdFh2ZfzJqWQI7nKV7niEeosxN5lJgDpT5ryp+tqujifDvxe0MYnteKHyn9Ulo+kZwnYPraPbQMoxPDRf2o8T8ZoX+9v4zp3GaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV0RBCFSCX73C9zQjfBhcqMkdbM1v39GbgFv3262gEg=;
 b=LMkmAMiWdxnbqoYQB5vqYkFRdhfx3u8CCco57eGw/XVBdh0eRX9CPAVu1UpF0yU0UHT4bYMDzsvlbGs62E2zKFalt8y9bcF2hP2l1kFR04RVIAAvsHDedtY5ObEYx7wnLSRLYw8/+Ntc4DLzBwNtxD3NJtwkripQiFA23vtV4fxWczToDRAD26rSe7ych/KhF5fzgatCPCG9nVzRzvyY7qTutl/DRhlGCQH/8Frqv712CBQJU01Qsuz9uBnxDgHcLdfSJVzDVCojBA89FtGU7cVWckdeDFtk8gVA/09o//T2VH4p1nwlwigCdglRTkYZDa5GAVggcS/BG2tVz2ZFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV0RBCFSCX73C9zQjfBhcqMkdbM1v39GbgFv3262gEg=;
 b=k8W2mBYSYBIKO9e270Wakvji0E5zIiVv3sRg581gXAK0RwGUZNL1VqtdZceyXKfh6sz3I6SSEI7RaYcbs6uagqVTtRv6Vyqj1xAg5DM13rKZSYjhkNEeeCOwAtKdyKGU7edmqllZ/fRwuU6HLsEMjbUVGIhPUWV2FPu3D3+dhPk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7183.namprd10.prod.outlook.com (2603:10b6:208:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 01:42:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 01:42:38 +0000
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Justin Stitt
 <justinstitt@google.com>,
        Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
        Charles Bertsch <cbertsch@cox.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Sathya Prakash
 <sathya.prakash@broadcom.com>,
        Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
 <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit
 Saxena <sumit.saxena@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Himanshu Madhani
 <himanshu.madhani@oracle.com>,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/5] string.h: Introduce memtostr() and memtostr_pad()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <202404240858.0FDD390@keescook> (Kees Cook's message of "Wed, 24
	Apr 2024 08:59:33 -0700")
Organization: Oracle Corporation
Message-ID: <yq1edau6ww6.fsf@ca-mkp.ca.oracle.com>
References: <20240410021833.work.750-kees@kernel.org>
	<20240410023155.2100422-1-keescook@chromium.org>
	<202404240858.0FDD390@keescook>
Date: Wed, 24 Apr 2024 21:42:36 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: e3870b97-0167-4136-9b68-08dc64c8fd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EMyYsnDRIbKXFTvFVYwTgDnBcT/F2ZCp05AADjlTfoIX/4D9WuWheZxulpNJ?=
 =?us-ascii?Q?XQoB17Nh+F5+h2kCcQR25WWDHDFJ1y+Yk5vUI1PNhW9rKBHN0Ns8TEyTb3nA?=
 =?us-ascii?Q?mmPlKcHyejt0doOqHyGrryfUDyl22aE3ecVCXe50L0e1xVfBMrNJORskKmNK?=
 =?us-ascii?Q?VXDCWrnjsbHzCjCAcZlIgLwHPVauHd1IwIQTl8orObcKdi88xW2b4jY8D6/q?=
 =?us-ascii?Q?jXlJohCCixEd55a8ZknMfdFgG9WEDfUqxKp5RFiELdNVm6DDl/G7V63jjg2a?=
 =?us-ascii?Q?NFmQy6ye4Q5MT3UGtiDui0BMs3tgIzHA9irHrOKgBreM+jheTjjFRHXzigxi?=
 =?us-ascii?Q?YLZ3Gp7OfU/59B/LwgDhIdUdTR4TLPEW/EV0+qHh2x/yu+xVyu2vyPxDpRg+?=
 =?us-ascii?Q?JXiXPWLHXIFOFlQwtp8v4sF3uX4pYyST5d2uLujy0078jFF+6q91STkbAtlD?=
 =?us-ascii?Q?8ih19Q5Qc1qptUwGeAWSAsPyzANNk7dS0J0C+o88U9jd9aSuLWBjN8NiS1gX?=
 =?us-ascii?Q?PINQVUh9T9QEb1t5EsyVhWa5k9ies5WpokcadLeZKxufwJn8O0exEKRE5emB?=
 =?us-ascii?Q?8aUqieSyQSey6UJD1+e0TEk5WFOMiRSsHOVHh7SJ90aZ0ljS/QYjrUN3+tsc?=
 =?us-ascii?Q?np//szigxLQHoFuMZdDFSsFF9fsSKm7XojUfJckY+I9zlUuy+HTQdG0YXIbG?=
 =?us-ascii?Q?ZzYpafWMZ0N3yGeYxAJpA9liQSSU7XJCCWn5joxdNaq792iZAL79dZnw2Fgi?=
 =?us-ascii?Q?/nCoeqJrHUwjeyFEW0fY/VwCY3F931iulqX33wnE4uSydlEOZfKs//xcUUi0?=
 =?us-ascii?Q?mgo/XEmA9wnPr9B9+3Jq2M44L7w9/c703tf2+THf5afpJkZF73OYiQ3jrqtl?=
 =?us-ascii?Q?YUpjGrYP4SLXgvN3yHVDZbmd4s9TkBKpa0sGMQIf0R8X4LR82em9QcfBPvGx?=
 =?us-ascii?Q?iPN8mzp8uxtCttohWCFsIAPdwOvsKerHQnv04cWX3ScKAoMkaEAlYinm22/f?=
 =?us-ascii?Q?IRIq/zSv4+8Y2XTm9HLOuzw0hbRTtW698O1/vmq8hDJtcF8h52Z5Hgs8Zzo+?=
 =?us-ascii?Q?BV/rTGm9nW0RG5FBtyzQpFU7tiSUGs8wT/moGst24wqUntqr2NSwKIiyXag1?=
 =?us-ascii?Q?vZ3Fwgwng0vnN+13ux3d0AAZtTrgk0+/dSNScdAaWzi3rFZEZ07mDPRf9QJC?=
 =?us-ascii?Q?Gnp0SB1kbFupFQtbKp0DK/NjigAZ4KQ0vu9joFhpmBSnp5ed2tslV5z1vwfP?=
 =?us-ascii?Q?evxpYhDZ9uuGINPd6lqN4nEa9wGuq8B0BfFcJc0E0Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rO8YsfXG10tINAB5XhOfZ0KXuiFJ1GEH5JEe2nmwFrDPCOVKpFz6xYAeC3jC?=
 =?us-ascii?Q?iWIqRE1oFNyyt1vpp15tWK3khhYvbXy1zdc+POP07uonXLsODRpwx938AYbs?=
 =?us-ascii?Q?mHbmm98EgwiS1bz/0fqVo25+cnEhaR1u4hU37/M4uiD0GY+AesHtEy8dFe86?=
 =?us-ascii?Q?rdlv5EIb2azZSyi+35ZHqwGHXgzHvGDCj/CVqLotCtuje2Qc7HPFwcyx/86B?=
 =?us-ascii?Q?7pOY62unS1Sc+mIBUQBtk4ZgN5Ektl8p0kDf+V8p8ubNOapH5tFWI/N4vdP6?=
 =?us-ascii?Q?HKAVQ3NTjG4xnbcHHLsK/EfBoEfC1jVvoSyqI7dgWzGHYDWCZik4lagAJAOX?=
 =?us-ascii?Q?3wiUP57bgozab+wT1n2I5mzMY5RNFqSjX4DzX6g3Nm+8f8skN93QQaU1ryHn?=
 =?us-ascii?Q?IGiDONnktPvVaptkrEUMyTmBR76z9zBNPE7a/60/E///SUetfYgUTp11tjfd?=
 =?us-ascii?Q?PfTbJWIghg8dshGTiu32CqQ9Uiy65/7QYQIcCK79if085FH/ZSrbAH3WBacc?=
 =?us-ascii?Q?65Myy8ue3rjvc/FuKP8HOkuUBjD+78UB4ms7gSJjyBjzOLmJMXn4dbwRFk70?=
 =?us-ascii?Q?aWhkfHCD0g9XpmFRi03RBcw//IdxwLsO5BraEzpVXComPkcuQq2kFPOIYHsV?=
 =?us-ascii?Q?PAbPw3T48M8N94PkR4FvyBSCIZoS31nxrDgtL1FLEd2Goqp4qca4+gtEAN/G?=
 =?us-ascii?Q?z+uD/HKLj1jBzdDn2Ulb3TU3V9doazcUIFed7DD6x0Vy9r1CTRfE7usDf+Qe?=
 =?us-ascii?Q?4wqN8KBza56ThXQEh9bsLvpN6A4v87nU3EwMHUjoF4Y8LNmleb0Q2xWQM4pR?=
 =?us-ascii?Q?JaBqEtAYFhmPSptdQpiaz7KpomS8dtAiRkoGorO5t+OL54SRTQJin/hIvRf3?=
 =?us-ascii?Q?qCpkK1YUfcIdbmH5oHMqbvAzkbvkOrGG+aQBalsw2OjY7xBb0kyDQe/m+2Lh?=
 =?us-ascii?Q?vrvKVDdpjmau7oDqSPVvgv/cM+yYN5PqlDGsmrBSiHg/RCe2rLPmxYMgik6y?=
 =?us-ascii?Q?GvkvqFckKWWWdSleNdld+3oAag796hK7CMmtBBwp/GFwNMbXNheEMR5jJZ3O?=
 =?us-ascii?Q?C+XRrz5A7GmTd2tyvEV+fYHEvomXfY8ynoOcBwMLQAhZBY0XdSfOu6KsKu++?=
 =?us-ascii?Q?fOc1Yfx856CZHbM+3pf0W/EL+s4eu5cFp9DX0tH8VuKFibYuZVALoOinYtsr?=
 =?us-ascii?Q?jE4+XccwM0m4USm6ddVrppilVmc2ln+kAK5OoqLugPIvGC2aWnS4NsBxN9HG?=
 =?us-ascii?Q?k90GyCBIhp7dhxFI/3B+RKyGoSxSQBiXXyzb3Ul4x1zq+wuKXrVF4C+YklTs?=
 =?us-ascii?Q?sCm7NEQEkgY4vnfiUCSwxoEryk/fTVUcsRbolCGml1vYAWUn/25SpVaAZc3f?=
 =?us-ascii?Q?Z26uK+/6ElLJ8Mmw01GcyRYdvDxQJqBL0L7Rqu2Wmxqcq+JuNiPK+PPDm4ak?=
 =?us-ascii?Q?lLvShpr4dRbFSktVXPciJDCMdf+DZu9BYsxVTirzKziDH2qx8qZDbymJzgpC?=
 =?us-ascii?Q?rGm6RCr5DphMKF/TWZPkozaZkcVITD0Ic7aJkZgpEmO6lS74q9Mp86pQZF5d?=
 =?us-ascii?Q?QeVI80mbOkx614wMNU00QNNYd0+iepKnZOEbfprJU9biASqKZeLVbW8eoyOA?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gtH1TkrbzM8Xz1wAKLS/6i4fwqpRZFjkHF2gnjCo1vh54C0NsUYum10B3CP/KQfriu7uAWUvZjfGy7BAEngSzUwTeNM4Mq0358VtpcZkX3DTRX5W5H7dwh42JD1OwnOWHawrQJT71Ji5+fXIoXTM7JHaeZgbMXO6cmu/atnpDGegQtf4O4A536y4RQF1fex2zW2XF1bomN50Y4/cqY4dJnW1mwlE3g3vtS/XpcR1grKcey/qlVWDPap5fnjAZbAU5Yku07b3clYUpwApjrlb6SXf2xa4lKzaABqG+6Pgg+phZ0vr6HSiStHPch7JzFn4fI5HiogKoaT1MN7GZt5TAIn+vmqmxiukSY1ZTVAE3Bt5f5J1t2FOgvpj1wANXWMo2YwYQH63dHiT8+0kr4vEcfF/NEjKDsvkxb2finJzj+z1gpwXpkkCywNYPkuOwYEUnShpqONxvjgiMTqY9pfG1mf/BLmkja5HrSbLtiAWUmfDNrAyKiWUeoohtxEypEsPkcBpHDWqC/0Sa5E8oEh8B7rwts95lEcrx1CfJRT/Zs2Gk+NDUZFcjK0nNYnFYGTp4A/gAJqc9EDmuFZpcXTzv33mVMVo2NsUmG18sA3Tfm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3870b97-0167-4136-9b68-08dc64c8fd57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:42:38.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CR0oulbOy8FGRnedieApRNA96eMyxfl9qbc1PfbXVfzPp78hjJR6XW8KOGqs1dQ0kuzNKC4YG9Gr2vBLIy25z5jLlZaeCE2sSAPo9mqDQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=688
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250011
X-Proofpoint-ORIG-GUID: hxDk730naZ9n0Y1t7ADW4cDwochl08Vn
X-Proofpoint-GUID: hxDk730naZ9n0Y1t7ADW4cDwochl08Vn


Kees,

> As the string KUnit tests have seen some refactoring, I'm taking this
> patch and refactoring it onto my tree. Once the SCSI fixes are
> reviewed, if we want to land them in -next, it's probably easiest for
> them to go via my tree.

Sure, no problem.

-- 
Martin K. Petersen	Oracle Linux Engineering

