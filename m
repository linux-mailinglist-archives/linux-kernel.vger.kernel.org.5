Return-Path: <linux-kernel+bounces-153879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F78AD468
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBB289089
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9E615530A;
	Mon, 22 Apr 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y2QznhdW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ItrkuRqw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC915443B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812028; cv=fail; b=cgp/3dtWXcQ+g4DqZBbAzBJ7XVXIKKIM4al1fTpe03ywDQuNpM+JozYNsm0oEgAsezclXyfbivxzcM8gi8UymePZww9CUILD6eyR+XQAN7TJWHFAJUrjaL7KpCWeYErOAqYNQiqym0VXY20l7lFjQUymlxryr0Wb/1gJnRZTMck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812028; c=relaxed/simple;
	bh=BOdjpV0/4Dnb6Twxt/DwLSQICV2ZAjssqOBj+qS3kJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bua9Ck8j2Va5z+26+FZIL5BdKJImFFphwByaO5fKFeKu1TQ/wr06aZW/QiO/E8/TWHJ1XGHMGvO/+xYv9gdJUGsHdHNYXtu0qzc+tG1nxGZpT2sjO0R5km0osyirmvQc4CLb8BFm5ecOpgtbnSjGJEo0BuHVAdwPhGMqcO/AzK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y2QznhdW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ItrkuRqw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHmi7X017349;
	Mon, 22 Apr 2024 18:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=zSKBcCQ6dV6XBaaZGaBAW7sG4dKUn3yi10MGuYmfxRU=;
 b=Y2QznhdW5DJoHlfQFEevXV6LdDFPE0px8gvZnnZu/4vCLrnPn72Uy7/ia+zAD8dmSVop
 bVtrzrkJNzRtgwc8cjyvXDi4X7Z4xo1ahskIKQiGyqgODddkvtYll5ZGzcDd04AlkSXO
 udBpv3joX69pyr5a6cr6kjs5rBU/yJ+XwrdYCcWszDX+H065TLNGTRplxpKzcAFQecTX
 vs69SNQMRWFQ2Jj/6+oX1HV5ubJdb2ELNADv/c3Oxt2dGoxDQ3OWVZJQWYihArb2y9gR
 CSKw0FNWQzu323qUhCFb+ToFv10fl7wyfoqsXY78Oi78A5dJPv8NigKAIe6vInZjhlAP kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4bfax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 18:53:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHPg0t008645;
	Mon, 22 Apr 2024 18:53:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45cb6as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 18:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDsLK3V7u6+Fur5PQN4/Y7RFIMYce88bHfc/Xv7GWrrqC7lLLtCGrXSK073UaIyHZtuoVxnE+SToV0J0hAxnjUbianNpBudvyQdZljsSGb3x+/95ffYf2utOHbMPGm2zJvjBH5qewhSuutXMU9D6TDcsOFFKepDUyZd7tF4kJ0WvxnhmvVRS3nI0w0XRlmdNmNAs7gHh64Daw64jDg/c7qHZJCoze9ZmSIBnJ2U6LKUjnZa2ki+LfK8Ug7PmwtDkFoOF1wKoq0JwlSyG+nDnw15rPfE9x23yziNWO34cpTDi4EFiqfR2THhQ2hH/ZhaufzLeFHv9fE4t80DqUnry0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSKBcCQ6dV6XBaaZGaBAW7sG4dKUn3yi10MGuYmfxRU=;
 b=BielHrcVgVUotWuCX49rHi/Yhh0vvvK/xrb0st34Mz75k4d+Ki2Lcd+5knRxaTqc7ApbeuZF1QG+7amZw6Mzei8Dck2C1Jk9b1mB/q96N++V4OZWYapvBw7oHXbP82oB0yv3C+P0Ob9C6jXtrvI92Da150EAr1ehVg6BheJXgsXXn0bBPHxks3wJ8nlWtGNdLFU1mQjeqb+0qU9u3PYSyXvNc7OlJyaQpibRo7ObrAKkfYd84m0luvT5rcEINgvwV4Fds0l+i1Z+XNXi3rwm39HeaP7pk+/ZuDTMuIlQmdfpbvCnNTZtZw7h58t7kw2OBCo65Z+5jErQkZBewJOEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSKBcCQ6dV6XBaaZGaBAW7sG4dKUn3yi10MGuYmfxRU=;
 b=ItrkuRqwIRWiXfcsZ3EzbS9IOdflfZStzKQ1xOz6tFxpjcDJ7nlSYooCs3WaKF9x4NrC8QOO9mG9epCcqcJ6sb8nLu3BxLJsIGenA88q/7qxarXp8M5T8hwTiOZpyzcgTjF4TmFYKa4MhcXwgBA9sTvJM3rMrGS2v4kWoV9dXvU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:53:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:53:18 +0000
Date: Mon, 22 Apr 2024 14:53:17 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        harrisonmichaelgreen@gmail.com
Subject: Re: general protection fault in mas_empty_area_rev
Message-ID: <4vyuejd7gikyjlbmcpmdcemplminhy27ltbodmq7nkjsozzod7@ttzgzxrjp63y>
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
 <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
 <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b>
 <usubtr2bibcnwca3rk3ytbd2jbpvshgu44faujrrrcnidnrr25@ttdhvhrz34vs>
 <CAJg=8jyaV20PannVxVQrqasmo3RCTAjOWfmkdm3ehviMoc=V-w@mail.gmail.com>
Content-Type: multipart/mixed; boundary="xkl2ju77harx26p7"
Content-Disposition: inline
In-Reply-To: <CAJg=8jyaV20PannVxVQrqasmo3RCTAjOWfmkdm3ehviMoc=V-w@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f62db6-3a04-448a-ee5a-08dc62fd7996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZdwFTmlS3R1nlTWuTqfB4fCsWb+YMs0rZ6xC30GwgtwOKA3bkXzqKufnJiko?=
 =?us-ascii?Q?bJ2qbrJQ5w/DGgrf9jAMe91ZXaHk/OAQx50Z/kV9TCYEQoGOLRIq1HU7ZVPX?=
 =?us-ascii?Q?gTC38bA+hFQ6QhUmWvxRGXrHbyKolc8B/SvVoO7/XjtzyxG+xYrr67vw5diS?=
 =?us-ascii?Q?C+EU58NkN0vqjd72UDzPdKstYoFLwxqBCsJeqIdnK3hlBFRwRCYO8IkZP9pK?=
 =?us-ascii?Q?uL6EmdmSRirUWi3eRcbOcj7Yya2aRf9nJhoseV0vVBz1poWmMqhClKIeLGUm?=
 =?us-ascii?Q?I4SxOFLEwA1eP9eYKeHnJAuma0bRazLy6sC1cKJOwRm3FYhNkLC6WArXDLS7?=
 =?us-ascii?Q?TOr9zdDHcugZuJ9wf0NP25EnuOOEPvNIXdeExeDjQjR2Seoeljs8e8mHfzMW?=
 =?us-ascii?Q?RdxE5w8OxQA9w+3jT2B4BjcrNvQQUFErSuymDSYcRE1TU3a9FodmrF40iYRD?=
 =?us-ascii?Q?zNqXO2BzqLmngLE+iUpygSju5MdYkFRM7dPKdEsjLcRLJMajxPNdSyg+6AXi?=
 =?us-ascii?Q?zrEePSoKdNvHq3CNY+cLN6NiRQQwT0yZiKHnVrugT/6ShcHkbXOLdDzNoXNV?=
 =?us-ascii?Q?ns0/1xWuOz+FGxZ0yXE/rEc1dG4v004Vck+tb/eDpa3xeX262+9Q2ZNOydD1?=
 =?us-ascii?Q?9ezcP/dDxDLtrOYQ4EzchyZayjpH3MLnnoAcx5JDt2pJ9kHcFefAcc7c5hNR?=
 =?us-ascii?Q?d2b+a5kUAc4V7kjp7O/vzpsgPZ0XiQiYCoWDLBr3iVqA5yoE+8qmwMbZhPZ9?=
 =?us-ascii?Q?DjD++1dNcV76XqfPr/XtnRN+cYyqxW0KPszLpxTn46siZwG9dxX+wLGZ4qM9?=
 =?us-ascii?Q?ucZkMobMaIYwHaRk222O2bc2LaQpdgVSj70zUxKULvb6Fk1OH0Q0p1Kd8L5j?=
 =?us-ascii?Q?vx+ct423rq9oAQGlsMbB4fi64djGYPEOZefEVjuSvhQ3aOlOAkLf+3F100lU?=
 =?us-ascii?Q?Uyok4v0xyCKlcABntRwSLJynxojM4QzjCEeZ5+JHlnAfawnoyZuj7IJ0XH27?=
 =?us-ascii?Q?9IJypjSjMC+7ql4IgqAOAFy9DQIuz+L7Sfu9qyxg578eTXR5+QT4FPNNwsN5?=
 =?us-ascii?Q?vz3yCQy+ztQYNFiwhC1n3qsabytSLT4m9jcTMl6pkcL/doHLbLf/gfhOZUZ/?=
 =?us-ascii?Q?YPHFtodkRMcdcOjUXaL6fF9SijH5WEKroshVnj1OWFgF9mx0vbjD3/9RZTK7?=
 =?us-ascii?Q?T8iOTpwKKSnyuOomUHkwT7EbnceuaIJEF2XwHyZRrBWyQfBQlONTHPWKsRA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V8XFZH7SeAAJW45vy62xUNV/Vr8nW1rKlM+ijdb56SJy8heZ7wmAomcGEKMP?=
 =?us-ascii?Q?BqsH8z6wDDOKA5WKyjZrqQ6+ueCjlsA8vc53tD7MAMtGZ5cn1eZgU5zOqSZT?=
 =?us-ascii?Q?Wf06n9GkcHsKN2LVWCVS1ML+UdHTozQNtpR5iTQcYidqYMsSugpxnWz+zQsZ?=
 =?us-ascii?Q?/4tnJhenqiO50Au1zF8xgmIeVoTGSOj7s9FZjsgsTkojcf5MtH7sOLuLBd5a?=
 =?us-ascii?Q?KsR76YLamXYvw5dIYAcMHC8NV/agFAoA1TpFkTsIyXxDc/quQhwe3RG2G5zT?=
 =?us-ascii?Q?sh+OP8dg4vojWgy956xbRYf/383Owa4nf9NimE9JqHASh53Uvob74Uay5+5N?=
 =?us-ascii?Q?9U2gBiTI9UtMkcDNLKx8aRO2L8Qz/Tbbsrhp0bwEWk6XhDFdjK/ArfZCLNL/?=
 =?us-ascii?Q?p6IPgcA+yVggm+4zV6MIVlTW2Si2yjwfCbYSRMGciBE2xwEJHtMGUMeLOpTs?=
 =?us-ascii?Q?uluZSukThvuvpyjNy9RjocatNJ9xWaoZAOQ13u7jPapPOwkrVtyn5PBPTVRs?=
 =?us-ascii?Q?rUlZp/IhZDadKBAs6YuUoff7lvjDoDAwYhGXIWceO5dkO15/zdV44I72xDIk?=
 =?us-ascii?Q?6keeO4/OK0K5UObuzxc1FrYQthA3tBaI8vazXpCal/i4n42Q3FJyGAtss33L?=
 =?us-ascii?Q?VEtBTE51FI9/egULSB2uh1eD50WGRIU/0PCv4418n7z8C2tzkYlmljd/DEe1?=
 =?us-ascii?Q?sa/Zzp8A7Wo5heeAhmiwRZ6vTxhl6gfFoDTvdaBsYcLzOG5k06UL8W5Y0NTS?=
 =?us-ascii?Q?lFaCxdAE8mumzvexVnCl2oafzO+XGO9vKZOvpYQJHEyd2nlXmN14TsDZz0Y9?=
 =?us-ascii?Q?2EVHFsxtzdRKmev35cWKzl7VhrgMpDLWG8V1RlzzkGj5VYIg08mcRcCWpf9W?=
 =?us-ascii?Q?QLJkEj8cHYnAe59KDJdbU4MJr9gW7Cm/yCegEUJMqrPQr48Fe6EcIMwFXArV?=
 =?us-ascii?Q?JN1+74w9kp4/5t1WenOH4Hgv/Rn5IjUhKII8C24+Bh8lV0aweT6hQyPDz+4m?=
 =?us-ascii?Q?ypjoIFuhqOXBPNnv2hFmpcySG3t89ejTNeuur/jdX3k7f0hrMkHvmgAAKTfG?=
 =?us-ascii?Q?RCkUSHOZkFTOkpninz2mBAoVilVA6268vZ6E/1zcc3RsOnlVxN/XcO2yuMEm?=
 =?us-ascii?Q?l1VP0Fg9fMAkOydsrKhUESEj7/hejptgfZeV4bjjXLK+GEyqcCnLJCynIn4s?=
 =?us-ascii?Q?gw0ssw+QHAofCvwDKYVeS62ggfygdxfUE2RCoLsoH2NSUU/ahWA9HcFEAiJ5?=
 =?us-ascii?Q?AwlGBOmc1AOV9BoFhpmqOGP4jRFvjYJoeS3qSp3w3n6rtTmuWLnyzzrrVsQV?=
 =?us-ascii?Q?63S+H1UK0coO3Vhvl+N8mha5SrBpb4TYA+cBF77z5vRycqLz2F6V/u+f42Q+?=
 =?us-ascii?Q?lGnaIyUJ44jOnM0wJYkERomUTZbVoLpRNgYW97BPLEllx7d2xwDURwCjYV4Z?=
 =?us-ascii?Q?87mhmOg01gar7Uh8vXTElYxf7q5gzxEM7rh8entKj0SWEd6LtpQU0VVShifN?=
 =?us-ascii?Q?vnX3XRvoF/Zmi2TLTok7tiPRSSUJuDg4UPR9D9XHwFYg2EA6xHFKwsu8An+G?=
 =?us-ascii?Q?rtwf2vy51mx3CCAZqn2pP3OGKgTAxj0GiNLkie1J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cpVJjglqLtEqDSweKba11Yz8hU7AEQZMRn7XfHKsoIDSDuZOmm8tnvazDb8GA3AsKv9i/C9ay3vSXPGEnVBXDeQEe1o7+wmWrVWlMaMnKkV+etkRrcP8d+7o74vMgjVyDGUKuIXL4qgYWto0fW6S/qP3NQegTIjz4LFMDKUx+Rkcq3yls69v2EZuJ3itiqbONgvXv13V4ctJRKaoVbtpocQjw+s027G/nIAS+BFivTdJ2cB5uKI4jkH3Ue3mOxyQUnOv0lC4+r8ffVxfyjmlbT5wenc9W6oT+eJBOBaoyxRyAPbnH6BEp+ecYQ+qld9fskgcpBzJeJSqD0ZjNlrdjcdMcWr7Hx8HDIBjNuLtD0YxbX6wgJ9GDyLfxlscW9IQdiO2NROI4gGIcdWlD6joPT1WIB7dEQx4M82odLjy12Q3zeejw5daNSKGpVgDyOGzS0K+QvsDIgO3vI5Rj3c5BPZ6Q66bFASSj8YeV/mz6WvIxXYyltQDGYwYawUHGv5nHHCjbsWttE/lHBBOHNlTuEPgcb6nZ5RvpcyXQxRY5Rw5IWMAQyiQT1om1ajJPLjppI/E2NqwubBTj9eIZPJxTslkkub6u1pjfSHTC/W3A60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f62db6-3a04-448a-ee5a-08dc62fd7996
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:53:18.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5atAn0qnBV0QIbPsGI74AnwJ16aofwk16CVby+vvYnRYhNNtZFawIZMp/aEIarbskcXBvF3n2bmKXa7dNmaUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_13,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220080
X-Proofpoint-GUID: oeb_AJfPfT3LzLP1jIgd83B56leK_wAp
X-Proofpoint-ORIG-GUID: oeb_AJfPfT3LzLP1jIgd83B56leK_wAp

--xkl2ju77harx26p7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Marius Fleischer <fleischermarius@gmail.com> [240422 14:07]:
> Hi Liam,
> 
> On Mon, 22 Apr 2024 at 10:05, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > * Liam R. Howlett <Liam.Howlett@oracle.com> [240422 11:25]:
> > > * Marius Fleischer <fleischermarius@gmail.com> [240422 11:11]:
> > > > Hi Liam,
> > > >
> > > > Thank you so much for the response!
> > > >
> > > > > >
> > > > > > Crash log:
> > > > > >
> > > > > > general protection fault, probably for non-canonical address
> > > > > > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > > >
> > > > > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > > > >
> > > > > > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
> > > > >
> > > > > This indicates that you built with your own patches.  Could you test an
> > > > > unmodified 6.9.0-rc4 with your setup?
> > > > >
> > > >
> > > > I'm very sorry for this oversight. I had applied the patches for another bug
> > > > from this conversation
> > > > (https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
> > > > I will test the reproducer without these patches and get back to you!
> > >
> > > After testing with your config, I can see that those fixes are needed to
> > > boot.
> > >
> > > I am going to try 6.9-rc5 with your configuration and see if I can
> > > trigger the issue there.
> > >
> >
> > The reproducer does not trigger for me with your configuration and
> > reproducer.
> >
> > Does it still happen for you in 6.9-rc5?
> >
> You are right, indeed, I was not able to boot v6.9-rc4 without the fixes.
> 
> I tested the reproducer on 6.9-rc5 (ed30a4a51bb196781c8058073ea720133a65596f)
> and it still triggers the crash in my setup. How can I help you
> further troubleshoot
> this issue?

Can you try the attached patch and see if that stops the crash?

Thanks,
Liam

--xkl2ju77harx26p7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix_20240422.patch"

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 55e1b35bf877..db91918d4d20 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5109,18 +5109,18 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
-	if (mas_is_start(mas)) {
+	if (mas_is_start(mas))
 		mas_start(mas);
-		mas->offset = mas_data_end(mas);
-	} else if (mas->offset >= 2) {
-		mas->offset -= 2;
-	} else if (!mas_rewind_node(mas)) {
+	else if ((mas->offset < 2) && (!mas_rewind_node(mas))) 
 		return -EBUSY;
-	}
 
-	/* Empty set. */
-	if (mas_is_none(mas) || mas_is_ptr(mas))
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		return mas_sparse_area(mas, min, max, size, false);
+	else if (mas->offset >= 2)
+		mas->offset -= 2;
+	else
+		mas->offset = mas_data_end(mas);
+
 
 	/* The start of the window can only be within these values. */
 	mas->index = min;

--xkl2ju77harx26p7--

