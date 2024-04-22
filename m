Return-Path: <linux-kernel+bounces-153627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE6F8AD08D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E193E1C21232
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6569152E1C;
	Mon, 22 Apr 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mGYWvm8u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bO4xY5jX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E3152E00
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799496; cv=fail; b=h+mqiQAo/x1bZ2OdFnJeZy/SO3EHDBVYViihTJjj9K1NfYUgs/PlZBB7A5yjw4EQ1L9bOySFicYVT2F6McsJgw72EOGPFktsPBxAzpUh9Xv1R6B5Nyg/naCmtP/CTfR683KjXdtLQ4SH/WjB5hEyxEQpiq1b2rNDyJ8xotivD3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799496; c=relaxed/simple;
	bh=56zWb/dsezoRwoj9VDkzdjzN4Lq5QQ4Kse35e1HocAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryqiMeYQpMil+ydUtk2PWrLpiMEXc68KJSNXGwDBsm60am+/Z03XeGeGW3HqLnq8qTpQdybDRItKUD79NwaJy1hJ7HSnp5xwNuZsAzwvk5btprKwFlQZUcXPiEiwRCsIYzyG7AhoYIrnhaP4k2JO0Ouj1aT5pRcpt/nbf2wxIFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mGYWvm8u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bO4xY5jX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDYc65003103;
	Mon, 22 Apr 2024 15:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Xanzv/tJRSUAjVdR6Iqqm01R9OA/3vIRJmhEisFjFKo=;
 b=mGYWvm8uqsSzl3z5ueXaM0CEpOBYa5c0GbdtkK9rHMG3Zt+x7PUb8J9Bgl3yCVn9b9fP
 EdedVLQymrSt524Z3iEmLPX1NhwXwZubKy9CiwLLu6+lxB9PlIv98LVnRJbcufv9HaDa
 IONwmZwygjO1uGU7cYB0v0u2Qu56+hctmoMIJ90DeB/2/hoYObix/uBsuHQydtaRRUPa
 6quE7cqzqHbc09iqNX2RSRs3IwGRPcGPiJdOlzNd/tK1AKcTjI0vsBVZFYt+fZ7/PxGX
 pqJHwr5aps2O61TAT6epI1hKJN4bS+uDLBAYseBm/uF+hoTRDmoTppJ6VTT6+3HiGuqG 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2b0f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 15:24:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtCoa040548;
	Mon, 22 Apr 2024 15:24:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455t5hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 15:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyIl4kD2ZSvOeU5LJPqt2LvoZYKnVNDnmqHeDUY0UtC1M+SoyFHR/TbVEHeWp+lDn3T4tzhZbKbRh5bjPzVcXVuEthsMeMdJlk1BCb7X4isE6dvnwQ7UUDep8tKyCdcblnM76CbFutiHdCn06lA8I5LzEu9zr5H1D94LAT/df0yJfzdNkDdhtAJ7Dz8+kH7Vegcb5DFMuFxxbPw7/lDwJB7fSdj57v8aULb9UHfW+MAv/OFwOpNF7maA5BCs9jVGo+zN93sMCwm76RpkaqMCN8LX9KkA6Rw73J7yWHUm3QjydJLBJRSBkLB6C+t+xFBWLYY9bPSgAKBeUbVaVxHlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xanzv/tJRSUAjVdR6Iqqm01R9OA/3vIRJmhEisFjFKo=;
 b=W1ZQPshB8v587Mc6EnaHNoNs067gCA61/tIdFlC8zApFPkL9Or6/P0n21lIZWIOhOUJQ4Sk80WLZjIg8DQ3Gyv6FzKHYAEbXQUjP289ukWlvBoJ7fHGlHSDaCg7R+XoIVUNE0MaOaTLGEadQjHpmn68f8Uj7oaJyQEnAg3hTtMKzRQesVYGEwLe8vSmOm2MYSV06att3+rInWlclIeoH868xThn8LackJkp0+Xk7iqa9y6HW3JgLL9/QIz+mlYz6Z3Ka+l1a02a5dbcmWDX5vartzwaQQsD6wYwqKYhU6Q2uGS9kP/byBA3RypnyjwLd0ToUuikaq1+c4+O6ipcLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xanzv/tJRSUAjVdR6Iqqm01R9OA/3vIRJmhEisFjFKo=;
 b=bO4xY5jXfLI4kbR0mygpt4mkgdbDhX+XsP/sD6arnqXTW4qJ1zV7CWPYfergC+cwyk0H1oeZrtofWyeB9Hfhg+1zx7Yab99WpfYU8dP52KujzrM8B5sKlPOb+53m5HLoJY3oSR0u64o1EaZZov6uOhD3bsmiLO6XJruw9xtOGF0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5018.namprd10.prod.outlook.com (2603:10b6:610:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:24:43 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:24:41 +0000
Date: Mon, 22 Apr 2024 11:24:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        harrisonmichaelgreen@gmail.com
Subject: Re: general protection fault in mas_empty_area_rev
Message-ID: <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b>
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
 <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: a255fe67-5b83-4ba6-8a4b-08dc62e054f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C/0mbfg4Aa5iD3IL1rgoyO4THqHiC0u9XpvRYuUb4kqp0ivx+03Kr8mwcaDs?=
 =?us-ascii?Q?gT8ck9WzV0kgPc95IdtEXwxXEjJCOToP9lx/8uGUqSV+wIwo7V+9uwk0g+Jx?=
 =?us-ascii?Q?YIegiTRIyvA9kWTFb7FqZm6f5W7jRmpq9dntI9vC4sprr9i4rzagHIg/SMBC?=
 =?us-ascii?Q?tTIxrjQ+Oh5jsqTKzQMaEgi8US2iS/O5BXqkicZnio0zTzgVhr8KXvGBsLG0?=
 =?us-ascii?Q?iy7ZZ3F2Tt3Wwf0Syw4A9PCk8Lpex+PdfZl7ZA+KYm/2K4qQemMQzNesxkKz?=
 =?us-ascii?Q?ioxeeTdZcuHnjOLLzLjyVHyCivtqIl3TfzyL9n1LWZd2+tbwZqoEEj/PwOC+?=
 =?us-ascii?Q?2up5eMMvDG39OpAm9XWel0jqrA4sz34lWbtEf8ckoZo3E/hpYtyCfanwMnVV?=
 =?us-ascii?Q?imqPsQUxZKxEkSWmLO3vXRLYR7z8dJXL41QvzFUTYC+saK8tCnw1GlcaK0Zz?=
 =?us-ascii?Q?49CK8fc6RAHFaQYagArw37oS8Zjz2z+QfvYZFCdUeGfI7Ub1Uclqf6X2Xwev?=
 =?us-ascii?Q?PbztY34NAjNMLP/+vdhcpT0h+lsPz9ZL8yZao3rKGSLcaUYm+gfwLeMYrNN1?=
 =?us-ascii?Q?QzLVNmctVZAsWwy8a4jUXObH6YrJOCASQadUPoyBaXZeo5Mlg3D+Panh2Nw5?=
 =?us-ascii?Q?oPRmfzUsQWlnOr0VnLpFAA3kKAcH7/lYFOgd7yDY0WV3OUZRfl4PHaiSMXLy?=
 =?us-ascii?Q?EMNweMm1KTM/i59JnWuu5aJoy8q/C8Rs53U5mZgwJh1GuUg2VwaXHPdx1fDd?=
 =?us-ascii?Q?opBj0wseo+jCwxeIHZbNcjc+PXZOF/atsBJV8arxpheWOig4GefE04wZn5W4?=
 =?us-ascii?Q?QPklNrVK+ToF3yQVHA46rtLpDc+sQ+nokC+6CDLzVwCKb6dSRxzdEWJfYnXI?=
 =?us-ascii?Q?EVm9FWXhVHXl4bq8H4NPkBEux/fP657jWOqGqKC9oNN8zocw2hhNNrIrkzFq?=
 =?us-ascii?Q?awRks8JW0dCsu3kbZt/BdPSveM0RId4FfxmIpjZeRuItsoBGIpP1/thYYfck?=
 =?us-ascii?Q?52+sDqtcpDiRz8zBt69EQsL9PTclWtxd41ZemaHFefDy2GDtYdh9+bQLroQw?=
 =?us-ascii?Q?3GjYSAIxcdUm7hnQ3VRx2H7ELZJvioW43LU2+mlyTDTmD6LctINUA8wpNpQi?=
 =?us-ascii?Q?BriAOlcfVghNz3RELDoK9wSyhZYloLenY8G5eQ8XQJESI1nLn4McfkdcQU3R?=
 =?us-ascii?Q?RtQKAGF5AYW8krclxz/vRpwkKV4n0Yl2XL2mhcr0vhz3kzDkeLFlNwlSYyM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kUlhFLQqqdFO5TLGxxM5d6jJsBfZQtPn/zalf075CHKomM55EbcoYby3hH0e?=
 =?us-ascii?Q?FavVkfe9vhUBDDp20wd10hY9apCQBbNwSeeFwRNaPWEH25pAGpM9tSA3Xusz?=
 =?us-ascii?Q?CcxDXLp4bWSvrbkhOeu88BblBOsWRtCKcIDxR9TM2emkSEtJpoInysCJWF0e?=
 =?us-ascii?Q?2pJ4kWsrmutE8pmf2Si11Kgo7lyrQv9l0w8S86cs/mKAs+9+fIvmBG31gNT4?=
 =?us-ascii?Q?cOtgc8/2mVY7miz+prlItZ0Rlg7nsb4i3iTBp26gxxw1tF7wC2ZgfRUB9EB6?=
 =?us-ascii?Q?nYfwBzkToWOhM+M1sA9C+pxEOa+qU+LoLl4rHRns3t5F7Ar799JDgLECAwMn?=
 =?us-ascii?Q?9Pn5h7uenak63NxuKRifxxx8aOAYFCrytVcQAeybIcwVp27ap8yDSTAnlsJl?=
 =?us-ascii?Q?i1vxpnjuRdGVDmz9/+zhDRaQ0uhHomMC90w5FBfp+rtTr55Ib7Ocj7pf0wXC?=
 =?us-ascii?Q?6PWV04g2J/emNjViAgi7wQjyM4EsK4XELfZZrD2rq/79TukZNn7kHsKHCwgk?=
 =?us-ascii?Q?qgEmE1rXMjA1HE9m5TrcO3BhoxSRdvIkbAOWRtig+R+6g7GCoVymAwXplS0Q?=
 =?us-ascii?Q?lZ3V7/EExZ6cfq2USUomXnn919qekFP5EfntL3YIm6bQrdLiIkO1ErwdgNRq?=
 =?us-ascii?Q?lqmIuaDc2ccd9XzJqOrC7AD3VeiD8aQcBLCVVYai+SeSjZ6QcLEvLyWnCMrJ?=
 =?us-ascii?Q?4BGqjLVtt683LWvUuXonZlKpViTqMBgSWBx2PGuvSW6uXrmUeKECXAYlYBG4?=
 =?us-ascii?Q?DNgC6bxU8d1buAYPJqsC0sfKVS3z5H6nVlVw3fdRRs0C1tM3TIkcTML/8chK?=
 =?us-ascii?Q?JqGH13LYqIcUPu0twU7bxp3VnYjFBl7BNv0LDaytmDFe5/K0cH0l/3FgJUI7?=
 =?us-ascii?Q?imlIoBSwgPiblWO6yEtShl7+Dla4ZCKp0rgPBHVisxqaAulrV/A7OdeC+OKR?=
 =?us-ascii?Q?tOKjkfknllZYqlK++mCO+GR945egE55c6J/QiwMSFUQa9Vd9eRWI+dU4wNhF?=
 =?us-ascii?Q?hzuduDiZMmd8QZJH5gEA3we43HzuvAVAYsx7dVPDTTQZ2E6Pta6tp3OwvzPx?=
 =?us-ascii?Q?qmFJLgy2WXLv6I9/yKqGYFNcUA00Jx+gk7e3hL/uTRC96O2VCINOSe6ji/fS?=
 =?us-ascii?Q?ouEEV5uBTId/mv2Ojr1Jvx9MgYh56AsGETdi2mEXlXtZFqQ5hvktzDrrBO42?=
 =?us-ascii?Q?s6DU/MG/fJ2IGq6EoODMnTdZBg9wWLA8R33iNHQ7HvEU7oeszEqwZT2SikB+?=
 =?us-ascii?Q?F6vmg1rUweIE9iR3KMjxeO0L5kWhJEiVByDBAyk1ImgaHlDTczfZeBOUN91S?=
 =?us-ascii?Q?mOn8nBk9tBOW6/PAANvs39Ux+cqJ2ShfnUBRs4q1aLV7TVNpW3htu2V73ukt?=
 =?us-ascii?Q?t9hguak7/w6ehl424qzFJnTiuRElszk9xD/e4HyX+9x6Z6t12Ghg6Uen3m+t?=
 =?us-ascii?Q?mp5pIt3RrlEv4gLOBEBzxDvABL9JKAg6jOhfIt+VHHqkUly4abIP5WFQgBqx?=
 =?us-ascii?Q?+ifamCQCVljDt5gjqRrfarhE5qz9l0zgbuh6mKj2Sb3rLrklSef84HlcxoWn?=
 =?us-ascii?Q?JULOHpkcuNwEqp4GUoFTpUyKQHBVZx/dlVEc2mf4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LdA0MaTXlT3D3bWPi7rZBJUfIj78AUcM9ydNW3fKrlPsPNxpeNRkAprQn/Sq1j4Xaxq+/eiph3PdzhvR3foExWP4Uy9UGwO0UR3JSgKEnsfWeWA5qQ/sbaCeRs4QoZWWZI1SR9d7msKF9fA6L7gWS4jcGHa5vdbzwKCvs38Ep3OushhPWAC3TJLTWuGteLP6G/zL4R5QtaqjC2K7GWY4RGniyvsFFdivfZ1qoqhBsg9rIECOXwEyXnTjUeDuDApRGLYhCSbWE1NiIi7PmVQss+Lua41bsKjNUBWAWy3Klx9V5f9Cwujv6C9iUNSfTtQLp4qKa7LwjRrVd0w0yvbVhiC4a24vesgCCUhiA+yI3vcKBreZ9XaX5mKK9rF4r5wl/UQf5ClIJ8YY3cJCC+Y3vEltbT0HG9OY+98+6yJefcOU78VlW/7cajpGnGD6xEQJadcZko+V9SEA2IDfL4YORl1TI7bI7Vq0ltW3ojJ2f2qPVlPW86QKad+3QgvoKOHo+gROMMtxsacqc36Gx5qdiw3ByjFQNM+uWTPACFkmaitdeOpONoOrHRIHg2j6+Zy4EOzgWTuXg0nqvYCGgA9lis/gagMdm34G3TkTgAusUlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a255fe67-5b83-4ba6-8a4b-08dc62e054f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:24:41.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFsAMh6iWXxpe6ovSvw8WFEwzudu/ID4d1pesDXwpYCBokG7+Nqj54Yw1cLf4/SgHsS/cmlUAEsiGnzIfo/nPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=858
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220066
X-Proofpoint-GUID: OUYZg4Sr2957uavX4vu6ZeaHA6Au68q4
X-Proofpoint-ORIG-GUID: OUYZg4Sr2957uavX4vu6ZeaHA6Au68q4

* Marius Fleischer <fleischermarius@gmail.com> [240422 11:11]:
> Hi Liam,
> 
> Thank you so much for the response!
> 
> > >
> > > Crash log:
> > >
> > > general protection fault, probably for non-canonical address
> > > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > >
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > >
> > > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
> >
> > This indicates that you built with your own patches.  Could you test an
> > unmodified 6.9.0-rc4 with your setup?
> >
> 
> I'm very sorry for this oversight. I had applied the patches for another bug
> from this conversation
> (https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
> I will test the reproducer without these patches and get back to you!

After testing with your config, I can see that those fixes are needed to
boot.

I am going to try 6.9-rc5 with your configuration and see if I can
trigger the issue there.

> 
> If there is any other information I can provide to help you, please let me know!
> 
> Wishing you a lovely start to the week!

Thanks for the prompt response and information.

Regards,
Liam

