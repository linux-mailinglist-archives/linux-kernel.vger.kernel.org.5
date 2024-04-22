Return-Path: <linux-kernel+bounces-153783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 674248AD30C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24431F2219A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518815383C;
	Mon, 22 Apr 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDPHYwNc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T4VslB1f"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A311514E2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805530; cv=fail; b=dVHAaa36thTytKiO8TUGFWiMVC8oIFMdmUpohV+Mb6UnJXMvx571gVY3Ji/rp8syiHXyJdK2CIGyLVMaGqVtJ2RiLzcEZpHWkH78krIiDHlD210y8Kqd44cuRkVSb5G3cq5Up6JWRan2nzd3xu7BCVUOPu8rZw/tReehTDls8AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805530; c=relaxed/simple;
	bh=mljtB6PHiiT3Pl61FkEtpytnejZcy1hUSw4twkChswo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gjb1XM5Ixl1Qls6xIMVhmjCtu5UloPJJXsDwAUSV1jaS8/dvBW9s7bBfDFDrCVIP5mCsdf7Rujb5ZX7ztXPvacSZGnOjLnHbnPoUqTbTrJzeaBzWAVw/c5Qny/R6T7ZeyGHipd/jonbEw9adM1NOAR5m5TY7EGFjrAvE7UUB5O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HDPHYwNc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T4VslB1f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MGXeZg004904;
	Mon, 22 Apr 2024 17:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=NFwATdcY1ibmgjo+G4RY4WY1dEH2u6oAgSf7sj2NF7A=;
 b=HDPHYwNcIgwuZzCrFOwLCKmcRV1u/2HnejrxV1+E0d09XuC/S2sIhBeHBTlbzM2+DmC2
 KGo5pb5DCeS0WG+WUfR1s3Je7qnRLh3GRW+S4w2j4oaBuB2ZgDBGPL6vYj9cDhnTCvEc
 Y93EgK6U7WdHKmDddHwiPo2NOv/4QCtthhhOpppl91D1QVWiY0z3onj3hLo1C+6sSW7+
 bLJ0KSu9AU9YETrrKotJc/FDmSqc7vAO1ciEgJmPLlFSirVx1KrhHLljQ4a2qNvuHY1b
 sULrCPKOE2l8w92kyeKD4XGVnJWU4YDo01FxedfQwkfkuJWTgPApcy/YK5cAvOYtoADP xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2b889-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 17:05:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MH0uq4010203;
	Mon, 22 Apr 2024 17:05:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456babr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 17:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsXBw/wWcQk4Odxaoe0oXyW2J0f9iwamCW9H+IzC05HwI1mx44m8fvaXM3GerVL4pbWyL4D4QuT3QB5un8Dm0jqp1J5WZgsVb/lHclWlft0NWMloSoVsGH+4KgQI/P033lykQe7Za4j51uT6E1irrZ7u/tzAc/8D8/MNkmzi7xdJGiBVhlNuR8oBT6D09I2qOt6L7U/8wZfYG8IZpnf9vVTNKYb7MWymvfctcrVVNsRwGLNyRULSOo57VMoLuO0Ms5xcQPq7Jf+wxeLbC8bnvLDgMeqJ8Is5LCdG1SG6qwYaf7wT3GA4Yjbhe+bG4wtwCIMZ0HZa7FwcZ/rSoX+q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFwATdcY1ibmgjo+G4RY4WY1dEH2u6oAgSf7sj2NF7A=;
 b=PLy0L8ZJ7GKJu4XSZYSbANBKRVTXcJM/z8Gd1JPB2tCw3sgGrV13Uowdg0InMMXOi2iMEJNLJj1JdD3So3hy1qBcCANcdOmv0ry1naj2ltoxmORu+AXbwfsvhPw9z6eMAaL5a+UIB0UATwbmM2OSIQHm4035SGHC7DCGszE1vsuJisuC/NuCNQpBVk6mmbyJS+YMP8oWt3QwjSBU1To3RCstQG0CnMWak5M0GN66ek3b8aY2xRY5CSBoSepkGsF2beL74l2rlfUxdRPYu7VxH1SZEcJbP6hByzTBTrNlCnu4V2CvvjGDC8DMp3mH5IYt76xaW+k/q1gNoeaRQfx8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFwATdcY1ibmgjo+G4RY4WY1dEH2u6oAgSf7sj2NF7A=;
 b=T4VslB1fPla5Uw3YuzpOoDa1koJD8nK8CLYAyrv08OZ+/elNswIuHqcDZcIZJB87+ic5aG98TP5E6v5d/LMkQ1z4N8dGjZyCA2tfTb3umomXL+yb/Xy0IJ7yigZTz3VG/EYRIIo/x8EYrHGRqnuBwjKPviM3H9dPSKMH1elLDdU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 17:05:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 17:05:17 +0000
Date: Mon, 22 Apr 2024 13:05:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        harrisonmichaelgreen@gmail.com
Subject: Re: general protection fault in mas_empty_area_rev
Message-ID: <usubtr2bibcnwca3rk3ytbd2jbpvshgu44faujrrrcnidnrr25@ttdhvhrz34vs>
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
 <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
 <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: eafa59c2-478e-4878-5c79-08dc62ee624e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pEhhOODNW3J2iHGCcWS9k6TgaXQe60oE3MM4hTIhJuhnc52Kcolz+ygPY/Co?=
 =?us-ascii?Q?Y0QhIfK7T6PWEP/XfaaGKdPX4vsJC2v/O6ZyS8hTGX4VNQ6TAR3dCrCSHh9A?=
 =?us-ascii?Q?DxP5M35QyRJt0EvePr9AudscER5Dhd8dE0QY7LRM4xLqbEwOlhH8gQmxmOlk?=
 =?us-ascii?Q?OZOulgcKm5sjKlL48r5ILg/MVWXMYCftSY2COL4kbNjXFVXqo714A/tiSfac?=
 =?us-ascii?Q?L4VC+M2OUTuahZbJxp5Ka2306w/x1t6bBchvXvleHiOYroE/wIutNstcFyxg?=
 =?us-ascii?Q?/HLrNdkcST4N7NkPaFVc1ISxuOLW511HLLNqlspxO7VLQL73hqiT2gh8VpMc?=
 =?us-ascii?Q?ZLCJBDcBEdmuvaWK/c7uaPOnqQFefqHBhG2ZF4cCd/mWZNv3IR4790dNwt9w?=
 =?us-ascii?Q?EXKL26wuYnIkqzW8z50SGDe/K+SDR3bG1KIY5xTS6i3C8cENz+OWwiMaFZ0/?=
 =?us-ascii?Q?ErjZcYUNLjLFyPc8UAe3yOWcfWoP/ivtJ3fe6T/KJrqslOlWbvC1C1OARHAM?=
 =?us-ascii?Q?bFh2DJes+5i4XL5/oUxDlTKIENDAOeuXeBDEy40GyQfrNqrkdL2oQ47iS/Ri?=
 =?us-ascii?Q?EizPjF7vkPRomPrWeZ0bX32en94JEZvEYVJacwNSC0kutjsrClOb75n3vqVc?=
 =?us-ascii?Q?dcgcMjMka3f9gnvQRGiHpqnDd1xAwMB2uCGzOTfrY10PJkOmDX6zzNBYVPm+?=
 =?us-ascii?Q?TJtpfBJOhaAVwN/jKCMgsdpbINwsGREj553fumARIFkhCTWehSOEOHxOrTxz?=
 =?us-ascii?Q?h6R0TaY2V/boU0oN8N+qMH/Otxn2X9KOmxCeCdvluJnRCrM/YZ0iS0G/fa0y?=
 =?us-ascii?Q?gUpZd90rG2MvG+duYyl3lpsv83D/BfPwecW5CY40I1f+yzJU7tKs30ogXcIR?=
 =?us-ascii?Q?5DVppLSvE2DUW42bf4V7Kubx1zTA+1s42IHXYILuucOCDQ44VSf304PKMkVk?=
 =?us-ascii?Q?isgD1vbmc9cNgTcxXf7Nvl/rLAjwPf1PcJfI6NgrAW/fYpOqkW/Xunfyz9XH?=
 =?us-ascii?Q?YOW5ykFtUPQrunoUXvNdhy2bNGUyFhtXVOOzvjHpjGCRsLMj2nO8XSEw8zvJ?=
 =?us-ascii?Q?4mYtrDTKn2WzShC/SmOJw+yS5rKt5o5uHoBHsaK+nh5uMjNVfhU4lHTtVTlp?=
 =?us-ascii?Q?jTraRJfhrzX+YOApI8rxOhF+kWKpHVaWUgKMF78eh3ZsFEXvjKZeZz8dpZF+?=
 =?us-ascii?Q?CAsyUI/GmTGUfBLBoCNxaHs6aaq2Ha0P8uI4xiUheTBvsE0+i7PoBq6xglI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O+03a+vMUH8/pzKD5q5XufCGwE8utKAqwZhEBHR52FxLtD9Y7XMgMZNk1Fel?=
 =?us-ascii?Q?o7cOWnZIhm9RqJwGyuuGjA5pjP5NNr9j80Dbpzo3/O9CzKjrgUmtx3o4IOel?=
 =?us-ascii?Q?Cid3m189zfROQPuRPQ4CEvCtJmMpucJj2GsctdlwyOQ28MTVE49PGHGTSRbM?=
 =?us-ascii?Q?5jYSWKxSTzJsj2ZILl1DhYepiUw4MXRNbJXQ3erB76VmxK6vRC4V/vBi6eAH?=
 =?us-ascii?Q?28zlhlpZiTpW/qxpu5Vds3EE5ubnyzKc+3HNI0VAfU9Peq5n52DlwjXeOLdw?=
 =?us-ascii?Q?0HYyZvuO5peht+qaY5hGb9UlSe8MRpdV4ZgBUCB0iaNZQAalUK037lm/kc4t?=
 =?us-ascii?Q?wfBufW4pedNgkZEoOptxTTLlroW650nKt3F3i/+TykO956qq04QoAP/tRfQm?=
 =?us-ascii?Q?d9GyFAGgton4ykcI3NHz1IlF8OMPgYu4CHkwQLOIrO76Ll6yDTLNUZi+Ih7K?=
 =?us-ascii?Q?MNWu8CSUyrVUNw16LQTDX/KSPQE5w2NAcu52T276GNzi7b4tTlFlQVIb98mH?=
 =?us-ascii?Q?F9qEOwvb3xW0BsfnIdu0ePSO8oj7klM+Qs8S4aP/hg7Nfl42HXhUiTkX/mXe?=
 =?us-ascii?Q?QuVcuF4xSvlNE2j4SlGbA7lM8bQm8+LvNHZO0g6nYDrOnPwKA+zaVzvXHovU?=
 =?us-ascii?Q?tiK3uGldwGuRJpT4PuSX9VeRwMHS5rJRLgaCNxpZsdqx5NfSwdEH+vRNJVEL?=
 =?us-ascii?Q?lBPxp8/tpVvypVmWK33hw9xZNEy6Sy7zpf9d3yMXPLTT4FxK/tM9BPhLplro?=
 =?us-ascii?Q?3IaCyK5Q+ke1p67lA4iaK7u1g5rRXVFIquopHbHcuIBVUUnvAUT94jkxnpOj?=
 =?us-ascii?Q?CG6CxDyLCWM7V7xkSUgQu8vL+BdjcH82EiKR+0dYl0WCm/9uPnpfgWPpJ8C1?=
 =?us-ascii?Q?Jiek3SmPgWdh+Bar2Peii6zuhUOFmV3esPb3880bxtkOIMIRTx6/i7a9L4yW?=
 =?us-ascii?Q?DX9PfAf68O1SxoumCqfkdCpgRGYtyKZeU8fSL7E8UUnE85BSyunJfi2twiMB?=
 =?us-ascii?Q?hqTEukemjtJH79qG/WqmTuXODLvTcYf5gsY+r7OrZvKOn5Y/G6FyfWLY/UEc?=
 =?us-ascii?Q?0EIC0JKz9kkc9bXEWIoRLikyMidErcx4xjSnqY+sAVR89Z12p+ZZneV75RHk?=
 =?us-ascii?Q?EmWe1qfZkHdxLNebaxmNZfnAgkEuE4kFPqxeuCcoDvsIXCHdoHxeaZ9ZzRb4?=
 =?us-ascii?Q?6dcjdA4psCRiRXDGiD62ORU7lZ9oj1IDF6QDjMAfWVUFG3ktRjqdeYL18clu?=
 =?us-ascii?Q?mSz6LtSsLPP+8/Y9hynI5pml/W20MdTxL0v3UZOkGTUIsWxo0CdT27sAxdAh?=
 =?us-ascii?Q?rODQUQp4kb733FIK1EMMkCDzCP/nayu9mzwJpjWsJWMaZf3Gwq0dZx55E0Jj?=
 =?us-ascii?Q?vyFpaBo8XNuiYaq/UeOFXoqVoY0sKgshZm4LPZqXJBF1GOvztbhZQ/jn+ZxV?=
 =?us-ascii?Q?bngQv0tYnEZ9adm0b6qN1uCs7Lja6RK4MXnvh0i1YhWzRcyq/roQT7TTRb9z?=
 =?us-ascii?Q?9l4RmE3JT9DROG7LPt1wZH+6AWE5jJijYn+0kO/JPoWHTQ8o7E/0Ho2c3ZCd?=
 =?us-ascii?Q?DHh+VPovojUYh/MyhXCZ42nhBMO3KjnjT8MSGcSi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uhEPRrx7TawheeoTSsJzKYdYAfoplHqc90wvx/HBNyV+e2tLoxaODzAE3KFnD/DQQEuoJawqeGovECR+XadQiiNO02ArIZh3lKrTYlAXlEdWLU6Qxb8OdL3A+NJmy3hAmzq4NfSAKVq2NvgEOJ87e0Ka6SlCvFcXZJEM5GmQ1bRpydtCgYL8mnkiQoLrEnu4epr5qint16IwTvRLIJGiZEXV0TWSlssAS9YlYdnwvHmZEcWPwx1C1PbRoaFfe/eS61xufRfh35L8YS+QaKFU3yhKZ6KU4VHmFtYmFIZ2K6O9VF17orsluS21M0zsM4ZWhmgrKjYFvQG4rvex2C1T2i5+s1tCz3v3brLriRh7jCxquOysO89k4V/p4A1wQ/pLTEt9I+eQvu1bRH2A++/iKfvJ43L6HcGDsbnsRbfzez/TBzFeugJFfPduSi3wo0Oq/Cl7T+g/kEtajO529UiJ3nZGHDktZiMvMJKLLLBwiTBadRthyuX7JJht6eWGygyQ3NiD/STj+k+m1LNCwSt2hcZ2jpqYOLPw9ln/jfiDRQVMJLu9G+Gf0Vftln4XvQTX9hRqJI7mhQrYoHkPxGkwooFnmQAAbWG5ZiEGdOZz9rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa59c2-478e-4878-5c79-08dc62ee624e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 17:05:17.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCdVSEypmeslhQwo8dAORiX1/7hQkyik7ZlpbdcyifBR4l3E4KpbWP4ac4OfZ3SCBAUJ1454J1WoFCjm4e0Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=865 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220071
X-Proofpoint-GUID: jodYTVwg48pOOIv_tiAanpeaS2G8v4dB
X-Proofpoint-ORIG-GUID: jodYTVwg48pOOIv_tiAanpeaS2G8v4dB

* Liam R. Howlett <Liam.Howlett@oracle.com> [240422 11:25]:
> * Marius Fleischer <fleischermarius@gmail.com> [240422 11:11]:
> > Hi Liam,
> > 
> > Thank you so much for the response!
> > 
> > > >
> > > > Crash log:
> > > >
> > > > general protection fault, probably for non-canonical address
> > > > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > >
> > > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > >
> > > > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
> > >
> > > This indicates that you built with your own patches.  Could you test an
> > > unmodified 6.9.0-rc4 with your setup?
> > >
> > 
> > I'm very sorry for this oversight. I had applied the patches for another bug
> > from this conversation
> > (https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
> > I will test the reproducer without these patches and get back to you!
> 
> After testing with your config, I can see that those fixes are needed to
> boot.
> 
> I am going to try 6.9-rc5 with your configuration and see if I can
> trigger the issue there.
> 

The reproducer does not trigger for me with your configuration and
reproducer.

Does it still happen for you in 6.9-rc5?

Thanks,
Liam

