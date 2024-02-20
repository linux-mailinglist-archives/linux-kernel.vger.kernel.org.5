Return-Path: <linux-kernel+bounces-73490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2D85C364
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F89B23048
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFF77F1B;
	Tue, 20 Feb 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ya+prmzT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dBu2PMsi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B277653
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452637; cv=fail; b=oUSGRkW54qDpiffbnLUH2f0R7sRL+r+/6N6XqEDcEdv9NCat3R33qSQjQrciqTeW6yvcFdV85U0x+pHsAA2JwbAfA9lHxquSYXd5RgkGG5KUVRGvnddmWNDPJE2sETaQlWiD+UUT/AWlmo/zdI9d5gS09pxTXHKORharbwpnSaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452637; c=relaxed/simple;
	bh=8iBSgIbcRYCp97Mb05scqJrjAPvV3RMW/mtDuA6YBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvwA+Xaivim19Zpa97w+jVigzMVvHbP+lTDh8hcPTEfoIipHhTRuGfTb6saLvGAIuyub2WRfp/eTRsUuD56H8l0O5/cTz4GLH+IIKrKhDujBKGrXNuPwzVLA8XSKpe8a0k3wOL/ayww35xxYeNS3fEqRLKsiU82C270z9H2rKok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ya+prmzT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dBu2PMsi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe35v015874;
	Tue, 20 Feb 2024 18:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=BipQeMtqWOwg2FuhIJWvg4LV+FFcyL89+X/Cjx66jH4=;
 b=Ya+prmzTRMXqQZHbB1WpmVQmDB5fv6mxoX2NtavhbUQPejcER5Dodg6pBk7UHH3Ahf2e
 /2Jn5mXAFMk5IefHQRlNG2waxOyjPAZ6W/fu8EeTRBdF5I17pfQzWlz5Iy7cEdoV2RoS
 lIy/4dzH49BFOcBMZaWNomHWZa4YALZex+qpZg31EsOx8Yr7lm9KwyCQWJYrlA2qsyRV
 QgZIQ45Iv6na1DjjX7Auddof3wZLSxO7McGH+xDDuGPmiPBxi49XqR78TW87XVjx6i3e
 huq7i82+Xoits12DOxfRf5VDcz7ZAEAc+EpfpSe8R84NoNaR5uTY6Z9ENaF4Wo7yDuTX SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7eff46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:10:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KHTQbx039679;
	Tue, 20 Feb 2024 18:10:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87pjrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffWTXYbaqKLrwRGW47wpKlKcw0Np1+M1LzXnrFeosE/p9bSO4mxoM7KRYBFSCD0nF8aFwD2moSB0yn0mO1mFWOO4P208mNHQpbDGZqIK00SDjb8MB1QURA9SS0BEhHI/68EM2dbhSJMk5uKRzvcPZc5J29e9NPXQud1M5V93LN0/XSBLWlOo5cbkxof4eSodoidR05KjlN2zC8MNe1WV3iFhdTXeLcrIBZU3mopkkG8T+C1reluQ1XleOrEua5ZYiTr0Cuk/fkhyVVXdEvJBuIoViN3Rga0KQPnKpuAlrIk+XeFsJ4cYnkq063ErIlp8ixehPqbr9u0btSEYvK7EUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BipQeMtqWOwg2FuhIJWvg4LV+FFcyL89+X/Cjx66jH4=;
 b=IILl+GCJRxIqQ7LfqJtoERzPxzeQ+V8U2Nj0kkwKb9pz/tI44TRy1m1dQjPuB63OjOu1t/0Ai3H1sbmrFkHIhjAkzhqTFVCXhBsHoU211COm1I4OfbuIcnWdBGti9ilvTu5tmdNX0lI1T/J6DDAz3Ak1ea1b9z09o9km7SIdXfh8xV+SHwuSafxXIL6iDCbv63KfV9aik8ppFOWjp4FcRHsTLAN61IEYvcAVibHJ+t06XOWZnVl4Ro3bVNz1RlO44Y1PUGApHm28MjcNzS8kCWGcPFTb+d9IC/WbZ/Cfi6vYoaRPOScZvzfW8NSQM7JXpZTffVHpC0kugSRQbTseIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BipQeMtqWOwg2FuhIJWvg4LV+FFcyL89+X/Cjx66jH4=;
 b=dBu2PMsia9b3cl5aG/XPQQoBqOA1HXFJP+TN2ruIYjiZqB5K1obMv6QqfX2MphS02CZStn1j/D/hHrJ4YAQMVrzm/PT1KZBWjzzAiHCtRYVv8eKbmuJ9Gt/ESWXilvB9jx6xKaZyhfVEspOl53GcYogRqAJ+xSgysQsH0sIyt5g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 18:10:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:10:17 +0000
Date: Tue, 20 Feb 2024 13:10:16 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] mm/mmap: Add case 9 in vma_merge()
Message-ID: <20240220181016.2gq7v7cmollbntgg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Lorenzo Stoakes <lstoakes@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
References: <20240218085028.3294332-1-yajun.deng@linux.dev>
 <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
 <f88de15e-508f-f651-0164-346845d23e85@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88de15e-508f-f651-0164-346845d23e85@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0361.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: ec68275f-a711-452b-f285-08dc323f3198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wB3Mj7ZLqSYNUVhJh2AgfiNQ9iBZZSQcpCrI1+GVYTXj9Ey2P5LrvbhssJ6vIo9jSZl6dCO3ieznlPGbqRigZjf2gDXqpL6LGr0Z03PNG6+aPGg8hAwytQiY/SBkMx1cOv9vlyy3g/oFm1ICuNZBVGDvtvDkqYlGmRBqyoRRAFZxY/nr+XkLwYPNOZzP6a+meRBBOUEkIbaVZ0eBosmGtdXQHyT9RASpteKy1s9wSvyaxmHldXzCKolva/LqrvAFqlX18lKV1jPdlbKrZdLH7rNhuW3fk2G17KpOJSP2H6od2KvmLt7JzplyEQ1p6Rwi/lvSpuCdji/VRBmJ9kb5/Q+5jPHDWROZ9FXfuKpvDDszYi/kCzZDNYR4tL8WJSpRFj6bRu+By9jqKjo/dqxCH19xf9OsSbi9DgoUxvMniJdQlqwxJA9HdFnJx+LrMG3sj3mZ/TNatnMQ1VuAaUj7zkux4zncPnZuHACLWumG0DFxItVh70k+MEHsS/82QclkenbdpB5nejU9j6ferrQuuhQ3KHDLDdD9cxdxvTVu/58=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f9hZTFSIfxsNZ8nNvRR7CY4fk6TGo1ZBQYJOH47RWqEMpZE+LEv8eJGpxq/1?=
 =?us-ascii?Q?pVKXHiZOQ4ni59fvOuXuvNAzln5N+C6maTdWhTUvAPWCgNpguZaJpN8i4hum?=
 =?us-ascii?Q?dF7shGRLiSYVI1jP6UmlMqrYUeHW7yErrvHAevh9i0S6co8OLrHf3uzcCz+p?=
 =?us-ascii?Q?8nW9u5xguTXrLnH/ArdJBPayOZIjWNg7rrkT+AkCjO6qmYAW0XLXQS5YAyPs?=
 =?us-ascii?Q?b8qP9ff/4s1XDqk9LUdtKvg4mTRCrgrOTSHqTtNLDepp4UYN/QhDlpJGMXTZ?=
 =?us-ascii?Q?QTymcwlgX38veMKLcbZ7c3FaFJDiXbCxKWIBbN5yd8M0h27+adXPtXg5daEu?=
 =?us-ascii?Q?jirTWzG4/Dju8Czca1DVgvsLW2+hOxaTkIa1OYndtsQ1+QuO+XzLqHLdei2W?=
 =?us-ascii?Q?FfBoBy5UQf4lPfQktQ2yG3+cy3QLFwxXUFS8S1mK4JrBudMsjv5P6De5wMvu?=
 =?us-ascii?Q?Nwla7HsRjbN9Bar3z/FddPm/fNAUp0oy5asNNJHtVZwWJbRutXP4lTUz/Zi5?=
 =?us-ascii?Q?5bo+uxQGSsgFpTYZGWI+0QzYP4sr1JfWBLCY+anhO1McSP5nG+03Xoe1KozR?=
 =?us-ascii?Q?48lm6vgDPa/zrVXCiGmHwAa6uldehU8jpAxSoF+RCM+PoJDFzJRm8Hz7K/Tw?=
 =?us-ascii?Q?30gg77TV5sjIgh9ovT3L/WGntJXw1eD/Fs1somrAdSmqElCAOvPcFjynbmJs?=
 =?us-ascii?Q?ZVEiBw2wruYdcL+XCKobzVkpZdk1g1XFRDpu4pxOa1mCowS2P+LP1rnneBWA?=
 =?us-ascii?Q?vzAbIDi6uXZ/dvqK9lryI2HI3G+gYH+dUx1fuGOO+Tay+vMAea/hKOx4MJ+Y?=
 =?us-ascii?Q?eJVfeah0It9yeOlWb+MN8B2pM0VsH/Da4cfhkCMzVkGOwG6njXPTFvK0g5aB?=
 =?us-ascii?Q?aC/3c0EbhngshF/0c3852gE+kbat2jt96y17Ic09Sy4uX1b604safSHnS2Sh?=
 =?us-ascii?Q?/uut0LPW8sldutNnzy/N6zWCiKAb7RKrTpe/xfmVt3Hw68yTQbkteRnApydb?=
 =?us-ascii?Q?gZEsN4UIpUfBz4ISA2Df3b1+NPFgtizQlhFsHGCkFnaUWbfjLL4fE+uGCYiy?=
 =?us-ascii?Q?ZdAiiZF+ML1HStCUaiUIZiWOhViI0GdbVpSPC++PvtoUjtejhUQFEFjjBzl3?=
 =?us-ascii?Q?anchfrwTGwBbnMXKDOr/3dAQ4b35y7Nz/+25Y8e7mvt5u87hyVOMW5PZIofm?=
 =?us-ascii?Q?iPFTETXULRqYHoxpxJOwBkCa7Brukk4/J1ChOs0mrW5V/+EQGhyW4NIK6Ehd?=
 =?us-ascii?Q?YrPU49YP9vp7+Cp0ChK5w/EVp6no3AGr4DJkZmd1eJDW+1OP3JnGPh/Rc7ao?=
 =?us-ascii?Q?U7CAHiDiaIwz8jPHMOEYz/6Yws8fMavcyxoQe7JHn4P0ID4Novlrk0AQWFfK?=
 =?us-ascii?Q?yipUb7HdNs3bPBJSlmihsvGTTBEm6gJ4SY/cH3ePjupsRE1/pk21fC9RuHpY?=
 =?us-ascii?Q?+qCC3iW0cSHAQdju3Md8AhGFbvUoJjuduq4uzC0OVWNJDcvxtSerVQSUeiMu?=
 =?us-ascii?Q?EOtC8fL9XCOGpUL6hfZ4oEgSrFMFZqm2DLuThUuWcRlya8UqaLBBrAerQRCL?=
 =?us-ascii?Q?oG1dpH4HFPVgL5wCV5sCWGU5Fp8+JA7e1uWD0y5Jrc4K5da4caPoxX0iI+tL?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VHQTN5fftvcq2un6B4+Qw4I44LDOl34YZ0nd4ExMSDehU6vI6piDssf98CrZsyUbUXoMyeimzZMM8TcU4lAmlZjOzKZ1eZI/aYDlKHMPbbON+32yufGP/8cejFKqmnbMc3pRH+I41L6VILq3pIBIxm9XtNgg4S0+6ERty/3UIcYxoyc3QQ10km4yRbsQI29UTaQILvYRnHeDxsjVy1kOF35ZQ9LcKUwQ06W8Ymwz4LKF+aMJvrPxscRbnte9BdmYDkH/BPiXi4HiXuc50vRXJWGcPJRG/MyUzgw6Y1CYqYefWh4wiIsHcm2GimwRUIdOTYN/WRvvoVhSicOGt1yqKop/9rMaeDVd4axtfniq33H4M3D8JUkSKOxjxtcRfJ1xImuTTnGLs/H8VnLicY35ZUCo1ihH9nYgFA6TuKgBWZTp0IncOEPHwCGCVsYlA0yxOAoUHwsvAGxl6VotXSrkPM9qQkNx4lmAYogVYFQrz0pkb9bsYJ80Xt39tAxeoYYWYcNHPkuAsBDvlPY1i8TLr8kIbPjxhZoZqJ8RSMiVy91ARhFPdYNp1hmJMYiRY0rbQ9mQB84pQFNpwa1B4R1UJrSki1NoC2eDant5/PuvVaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68275f-a711-452b-f285-08dc323f3198
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:10:17.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4/Ygky+kSXpJ8FvsYTTDQS7TgsvxfGK/3YrIZJjcvgj9tILWu90qasdRtHAt6DJAe+McPWVP8/oHYU8qIVe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=652
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200130
X-Proofpoint-GUID: dNONPGb_rgYpY1pjWhUnnlVN6XaORfBF
X-Proofpoint-ORIG-GUID: dNONPGb_rgYpY1pjWhUnnlVN6XaORfBF

* Yajun Deng <yajun.deng@linux.dev> [240219 22:00]:
> 
> On 2024/2/19 07:03, Lorenzo Stoakes wrote:
> > On Sun, Feb 18, 2024 at 04:50:28PM +0800, Yajun Deng wrote:
> > > If the prev vma exists and the end is less than the end of prev, we
> > > can return NULL immediately. This reduces unnecessary operations.
> > > 
> > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > Adding Vlastimil, while get_maintainers.pl might not show it very clearly,
> > myself, Vlastimil and Liam often work with vma_merge() so it's handy to cc
> > us on these if you can!
> Okay.
> > > ---
> > >   mm/mmap.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 8f176027583c..b738849321c0 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -827,7 +827,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > >    *
> > >    *     ****             ****                   ****
> > >    *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> > > - *    cannot merge    might become       might become
> > > + *    cannot merge 9  might become       might become
> > While I welcome your interest here :) I am not a fan of the 'case' approach
> > to this function as-is and plan to heavily refactor this when I get a chance.
> > 
> > But at any rate, an early-exit situation is not a merge case, merge cases
> > describe cases where we _can_ merge, so we can drop this case 9 stuff (this
> > is not your fault, it's understandable why you would label this, this
> > function is just generally unclear).
> 
> Yes, it's not a merge case. I label this to make it easier to understand.

But it isn't.  It's not a case at all, it's a failure to merge.

> 
> > >    *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> > >    *    mmap, brk or    case 4 below       case 5 below
> > >    *    mremap move:
> > > @@ -890,6 +890,9 @@ static struct vm_area_struct
> > >   	if (vm_flags & VM_SPECIAL)
> > >   		return NULL;
> > > 
> > > +	if (prev && end < prev->vm_end) /* case 9 */
> > > +		return NULL;
> > > +
> > I need to get back into vma_merge() head space, but I don't actually think
> > a caller that's behaving correctly should ever do this. I know the ASCII
> > diagram above lists it as a thing that can happen, but I think we
> > implicitly avoid this from the way we invoke callers. Either prev == vma as
> > per vma_merge_extend(), or the loops that invoke vma_merge_new_vma()
> > wouldn't permit this to occur.
> No, it will actually happen. That's why I submitted this patch.

Can you elaborate on where it happens?  I mean, you seem to have already
looked into it but haven't shared what you found of where it reduces the
unnecessary operations.

Such a detail should also be added to the commit log so that, when the
call sites change, this check could be dropped - or be seen as
necessary.

