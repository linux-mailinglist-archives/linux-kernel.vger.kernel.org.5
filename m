Return-Path: <linux-kernel+bounces-98353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1F8778C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CD42817E6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897963BB24;
	Sun, 10 Mar 2024 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ILKsA7jX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2UI8dz6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0743C484;
	Sun, 10 Mar 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109121; cv=fail; b=JqBZ6/EzrsfxjcjKimvnfv8uUnNn2K3v0H1SRir/CNFZSGm7DgdU6nccq9mRv8ze4IIOb+IgxofRt+UTX62EzKVk47XL+rVHD0d6MKkSqZqnFWWdadPoKTgGFERF211TJI/wDVDa2WP8VRwSEg6LXYUAX5uel4Cydrztmoo2Anw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109121; c=relaxed/simple;
	bh=ETzN34EUooZoW0LohtOA6PZ7KQ35k4xQay/oedlvbHA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=O29DMFo41ceVDpJdyc1I4kf9WguPnKxhewuWS43eU+APXd6CWUVv0v1y6K00iLYnN3GkVERnh9KRsfdxkDtt4cWftbwN4RN3HqnI9p7MZfgb7/xuFpgQxS809wi3UkH23jhSaPcr+DaGxoS6c7VmF2ZjRieFx7+8t7wKSFf4hW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ILKsA7jX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2UI8dz6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJixtm012501;
	Sun, 10 Mar 2024 22:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hsbZC/r9qGIEVO6fyH8slVGyXBgL9H6pqx8zt79AiXg=;
 b=ILKsA7jXz1HTGpzX6YQ8byAZqeBHrIM3kh+vlR6/WF/gsujFw1rcv6fEMX4a4S6AVz4u
 eUmaCPwxgD/RocZm0/MBk4xEbLC5eQhxUCZmcT6cIlnWWlAUjhmYVAkNCGhcOwU754Qs
 SCz85Y9DnxkLwNTAtRAKzz7NqIjt7EATSPuZjILglC6XXxBsrshrLIGyGveiguj3ZLcO
 nGb7sZgPj9FpNQB5ZS5bhAuis3sfozJomw/zQJu1KPaJvs+y2fD2E50lzSvAKz3Tl1U/
 1hLbIVgolgEI0ZEmSwnwatBiFZUPiLV1bsG3je4/Iubg2SZiJMadxXf29vUhDNdRXarb GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauhrr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:18:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJKTWM004791;
	Sun, 10 Mar 2024 22:18:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre74ywy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn9uczA0XlJMIfQR0TQw/pO8bw+t9/2FXzjZmfD1gS1l4OQdJ6UreNbPyu5JVp69OhT8P/IIcoCcjKQhZty+jBU9NIfUGrR8g8LGGTSu4w7cYB1QL4VI0RpvjQU5rJSxVB4WyEmTCXi3gcfQ3GF0gxz63sbPvb+myiB2QSUPrBOYD40AdxV3dpGDwIRskedQJQVUKYhTOLDdnmfZ0deroROpTJBIGWKbO8rCdZ0uRiLQV8wBTk2E4RAr4TQmp+ZwcYW703eWhPu7tyEO5Nn8Bxuu/IvVqzInTrDHH+EJvFG5LN7bhDXVTFyErlcQMHrDKmAh+Vdwf8jlX0Jh0nKAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsbZC/r9qGIEVO6fyH8slVGyXBgL9H6pqx8zt79AiXg=;
 b=LDPf/YHvNHXy4bEgFoC16FvwmthqJW4FQMWaEu33LXqpNTJ82BTtg15l7amch1ip3m/fW2rV2mGwVNE6BID6Fz0JBGz43JEnWvGH9JMy9fOYRWaICpQmvnWDHoTmnq2Thp/X+OvReJLyXU5Odcsfxni5zhGU0AIqukMX8R1Iwx0mKQbA601IaLubEK7Ov1x3H/zqLIVrG/lTsPxBmD3p6S+o8J8ME9TsvPKjQyl9dw0HmuCFiSOwW/xB/KARmaRloSmH43LN3oiu8LaKL855kIXgQcLwqhU3rn7QoHjWKT1OW6rU/EJ6gE77HrVumb6NxpjDYBXLoDpTNzukibjmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsbZC/r9qGIEVO6fyH8slVGyXBgL9H6pqx8zt79AiXg=;
 b=b2UI8dz6J6IT1Q6asTe6wHiDwRK+ZfPbiqKWLWa9QMGZRT+ksnmACWhZvqJdPMuAIjN8loexdSI5mpekF82G1j5kkKZCxYl3SIAvQXXPQiI2PjCFrl664sg5q6LDt/17RVMHm1KeCQs941Jm3xlMGXVbzO3F6rBQMwZRp/LLxIU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 22:18:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 22:18:29 +0000
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy
 <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee
 <justin.tee@broadcom.com>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240304091119.847060-1-usama.anjum@collabora.com> (Muhammad
	Usama Anjum's message of "Mon, 4 Mar 2024 14:11:19 +0500")
Organization: Oracle Corporation
Message-ID: <yq1jzm9d944.fsf@ca-mkp.ca.oracle.com>
References: <20240304091119.847060-1-usama.anjum@collabora.com>
Date: Sun, 10 Mar 2024 18:18:24 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 01786cc2-7cd3-4be3-5e4a-08dc415003a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a90u/nAnJ6/scVfOD5rTWwHKsWeim12mKi8ZstMOvQVhxDiG0demhvwDouOl9Ey/h312pUNqNjlXF19QPg2Qv6YA4arbCV1aD7zOr6gX3uuxC7JPaC3XgpmK59QN8OjzlSWAY88tun0VCoD+5TejxAD0aY1xeLedUXBwIF9WtvPS9AVp4T1jGsPdLO+o5IqU7C2Ab6+SitDDeY//Qc7F6Kyt/KoPIo80UolnOP+QyXUDvoWx4sHYVGKTfmwK//sg0MdDzdhCSpjTu66VexjDKGujYatZxDTXwN7/4bfFRdUAe/d8hNfWuFOE0gQovLDvpTNyiknFjbuIKC/7J6ao8xHJ5AYqvrdIEBLe1RdD08bZaB2XyaCfIpJYCMzBgAQl1OMAYTNp0tZ5bWMUsuJdBeqKzhq6ukk8mhAyMZTfZUjDHlOiA3sXfYRL7hg/nOoZuMTwwuAQ2oTjZs5iJ0P8n5reYH5WN+oP9lo2oGxeuglSYGXs8cnQc8Dx9vfEeMlqJkYBD6KvbvrEBkGZnhNysGqoOPeOfaYBDB8qat8icwObKuPBzvh87wI8PFwLspi+n0W64GazOfv1c4VOcaDJsTPLLjLJn31l6s7e3MFqa7pFVKH9E09n/7GV1Zy+W2Q4d5Ty5pqewYVgEhu3zzD49+5ft7mgYxpJwEjjNpNjy2M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ge+Y4BJpMkOySA7MSElZ1JlU8njq3ePfpc+ncTGeklrWqv2V68hDVVbaPUkZ?=
 =?us-ascii?Q?qqke/PbJ3WFTT5XDdhkAqxvdJbGY1P5jVo30FUur9+VcxmD+lWVNqhAAc0Wk?=
 =?us-ascii?Q?6A6i+lDhu/oufVvZLUPMCg5F8RoqLfZV8eh70o6osRmC4EjynjIjkSQPK2sy?=
 =?us-ascii?Q?5mSpDwssBORk6bu1vsm8m6Bh/YBUYJV4UFbzhg1vbyzra5jJG4dMCkDPauD+?=
 =?us-ascii?Q?7hh1+IkY659GmvaYR0mSn4J0E0Yb8SVJtJfGDQpAs/y0KK6TRvt16u1HrrMv?=
 =?us-ascii?Q?uQ8XVvB4gLH1C4p2PlSrXlElNZIs5WHhjSCRfBr7QHrKsQ/oNJF1f8cYWYAw?=
 =?us-ascii?Q?yHb8OtvXT3tUagd7kOJNeLY0ovUyNBsrCwLuCcJBzsSusU286/M1Erztw2J7?=
 =?us-ascii?Q?cMMMFI1/Wgs91zld07NlKtmNs29IMrBOWQLOJbS/S0GNNL8RLf22lm+aKa30?=
 =?us-ascii?Q?O2YGC5iIhUsFEUp5c2L5R//79rIl/xwW46Q8nst6jOOLkBTS5SeydLnb+HG1?=
 =?us-ascii?Q?QI2sa5V+J5BapMiuC10Nm5F4dDx/DemF1KBI/ogPsh5uvuozn8Ug1ff6MVzc?=
 =?us-ascii?Q?3uIZGqZFA9ryXVdjAq5YmQG+GkcLseA+tCYiqsXGK46tnHNcCrdld9uyC/w+?=
 =?us-ascii?Q?81eqZFqrKqWolaLsaG0YQkPgetcvW7y+q76Fa5PyxsGrehH76GeIe5iwcft+?=
 =?us-ascii?Q?zv14Fv9f9cSGhBhnJVlbTt87osEiOCIYDUyFmvRBvLuI55g+3A2ay8l9CgqN?=
 =?us-ascii?Q?dFBxSojg6r5JaeGPeDpUtedjUVM+WGxOn4h2wpEeeVkHEOVHVNYGqR2rfCOx?=
 =?us-ascii?Q?5q8rJVl+m3AHvd3oIFNlo00IzDRlrU8OWjAd4j8XDs7S6OpTBEoXwFbZuHeA?=
 =?us-ascii?Q?FXQeeMD9FkvxKq7OrvGO+WxOzlRdKQXqqYqqNwM4aTUJd6HRGjB07mQM2YTf?=
 =?us-ascii?Q?D6h3HiKDxSF3c7hfIlUDvmHz91XLtuc72sKOJtOds5crrc19XH+xDyWRdUmf?=
 =?us-ascii?Q?v5pf3etXurIhNAZLez4AeGt2Lyxzxw+xfTOUFeMGcmL2luZFjfhUgTuV+yuA?=
 =?us-ascii?Q?DAMEZIXAG/nOJEofnNL9/rMQkAW+sY+bhuy+5uAjb37ZXnR9gZ5MpFZ6Hx06?=
 =?us-ascii?Q?nDiDSuyowi3BNToRBj0OIPoplWFf29987BNqJ9Q9g05xr+RQkZqMLDBT4Du6?=
 =?us-ascii?Q?mphwKW8gKxAZYJ4s7uXc4N9fFOW3qcClWwzAK17RsM5BS9kSB+7T/I4GCD61?=
 =?us-ascii?Q?oYKPdkyhURZcs0V2/X5BosY9rJRlP2DdtF7EXFmbDVsBMDuqyCtiwsdDRRwy?=
 =?us-ascii?Q?LSPsWKT2/u/KN4Fpka06j8dbjwnTwzthMEsb0BkFplWXnX0tm7rQnfmyq2CI?=
 =?us-ascii?Q?lGTpiztb0J83NIDYXA41jbKC07z4awtJ5KdB0j0Cxnj/lyDZ/bmYwuS37xGw?=
 =?us-ascii?Q?6Jt0ceqIO9KFx99Up0zREtsq8igdxBREsuMHzb+hOzOqB0s1QmzDIAA0M3qi?=
 =?us-ascii?Q?t2rSvpL+zws3Bsux62N1jFJwBuX8XGFAzlNdlF6wzO8TxY/FrjTbMQz8Optp?=
 =?us-ascii?Q?2PnFKoFQbn+Ohpqi8VCO1UqJdgtYYw37QlCX8vegkzzSMpDB0uxEDWFSS6iX?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pd31wt4JGpAC6YCVPF+Kelg32GWs4yPuOdp/UkAbiMUUKqi2OaaNqTF+pR6vrrBImC31FHR/2I1unMjO94txb+Q3wI1ZroU7Ivjdd0FwEGcRTu23pQd0GF9h1MJEuE6UTAzHvj0QnNkhm7LJmOC25fsULHY1kARQuSpyKnnSaSefpO3hkC7FUSYvEtqwLlqW0jkDxgHBagjK5m9AIh+S8yZ/fIzYA4rNSyZJeHyxOi5QFPFFJ03NUWbuaSpQeJgU48y5OJ/5XGTTkGfQQ5EvXUoqbGZRVvioDmPPkE60nT/4gTcHDcvrM7CIgapQ8P/aeL4M+GBYPcl2ECe4irFC8UENkfPZjb0H1g5qKyQeUChQE5hPrYxVtT43FNv50kHw/29DyBcyb7vN6KULi9Vw02JxMfcw6hdIojQHRxrFxRmAQvk+n86Bjqbm7BY7iQI390B1wFlSYFlVOD36G3wOo66xaceD9JX+PCHU4KFCfJ5Iw6aaq7OwiIy7qsFrF/5U89lg8YhrT61zgRFjOPD37i5xIamaFRdflx8i3Rgze5wQ/ATg+kOZM7Kfa8JFUgoEqGC0EscxdYgVAwydgfi9cIEu+NnbmG9cSm1pOMGXvhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01786cc2-7cd3-4be3-5e4a-08dc415003a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 22:18:29.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNcK7kPGG81eqexcGGNGdDWFXCQD13v5W7iWSGHuNFjE1O95eXxbeYu/C/iwX7MDPl++3DByKY6yzKqFfK2qJA2qWqAHUVGXkqGTqkaO5X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=780
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100181
X-Proofpoint-GUID: blAUsERunJkgtVXwjWj4i2b9rj4obm4c
X-Proofpoint-ORIG-GUID: blAUsERunJkgtVXwjWj4i2b9rj4obm4c


Muhammad,

> The cmdwqe and rspwqe are of type lpfc_wqe128. They should be memset
> with the same type.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

