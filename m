Return-Path: <linux-kernel+bounces-97402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017D876A08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9461A1F21AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602C381D4;
	Fri,  8 Mar 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QbbpC+ci";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DVaYUj0j"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1ED56B7F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919370; cv=fail; b=r36lDQ3uS2EPPaRO4S1HIwmUlmBSq1PfJfSs4NlrneNCx9KfIAzz1SPxp19/po66wVFxLyZkSozJzbrtLHeZEbPEpR3IQGeshGpqYb/1lLdCI0A/scymKR/8XZQ9WsgsO0qfqj1beQjgAhkOazlZ+mqyRgPKIZ13Mv8x2zI72I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919370; c=relaxed/simple;
	bh=EgmdI7Adpban0fqq+xwnN1UnwQb3a6Y062xPoFdTORo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YGI4lFsZrByigMdfF+t1KJJXixjwhzzMwv1H3K+EKAl30DqO0vdhPARoIhXwnkuUlpA7ZkFR8yFwS1hSMHOn1FqrYnO07v1sn8DUZ64oAPGwRmwtPnB6WVp8mDS7/BJ+4NLFQvYvb0cDvHA+7u2AcyVk78y+mzR0FkeXCMG1pl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QbbpC+ci; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DVaYUj0j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DTZHD013824;
	Fri, 8 Mar 2024 17:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=1mNz+md3LdV+IleabeqoYGnL4hmz7ftiGY/viSpeank=;
 b=QbbpC+ciJ2MfBWh41vCzfiUkxZzHZUxqj0aMhf8DimMsPLNzyQu7WyZYAeTvyQnAyAjE
 d79tDABr5TLbnEjF+hmVzzow8lewrrQQiuJYKzqgNs4X9rRk0LS4AnWj7n+l8bDBZWBs
 14fa8iiDFCSNjixUygr7ywZIUg9zspDxyoFNBTnX2zNevk3mZ/gD40Z5Pu47i/biFn8L
 SXrGdBw+t4sloDM1bopaGuGNg0fPt7B2+kwptsJKqahBzZ+V4wAt9R16KVH6nBTAwGqb
 00StmNAl0ErnaGwsrmJVRVJq6/jNO/bZ13HTqm+FQrVxy0AJ7GIf6fJwt5eoHZ/r0C61 gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv6g64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 17:35:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428GVXfj016085;
	Fri, 8 Mar 2024 17:35:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjd55cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 17:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR0RUcYZSS0Ao/d2yoHjWsEd2J0uXcs+lwJpyCgcnqQgaSnnvfrU/M061+9uhGnXsNZQDCN+Vm0k1EPTCd6ZEU1+355B18F8NZISfLZzSpjtT1oXvkNttnO+x4HINg9sLZ6RcCr2mnUbUrMqZH7VBU+dGyHv5gi7596wtn4u9kXkJV9u9A4UHtAfiIZSe4mj6a04zFDqOAQ8fzDrk/jlf6dHjwj99kyet3JEGXU/9eASPh3aeqSGioIi1L9/5unrAUcSxV6MpNoorSHGc6bBH2SNDfoEAhxQs6fYkCm2ayUgoOfhyK/qU615WO+wu+LnJLWEKBJKePCxSAkyZwxbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNz+md3LdV+IleabeqoYGnL4hmz7ftiGY/viSpeank=;
 b=k46keRRwA6SojEiYh3lgfQt6pJSlWGn1usH55k7+UCHHShlT4cQK/0A1Y9mMlbYMxn5QgHsgSChKH+GQlbQ+kSRd7CMm93W0iMRryPJUQRrSSQ4WoHvZq58g9hm9F/ZdfIG4YUXjo5MHXR1jpdU1x8p0Ll0UkSAsDlwlk1EgqCAYibLXRqLPxE81QaiDl9bldrYsIEkk65fAZMcU8BJWer7/rIocLMfpAxBkUy2j1TJ3mVzgRcktPcw+5ZeIIJYKuh3OEQ9XQ4LlZRc5hI+m8NsaL1XXiThXUSJ7blpZMGBhBtA1tKtvzi0M0JxD8vowNeOA0c6Awt9ggP9sBSuUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mNz+md3LdV+IleabeqoYGnL4hmz7ftiGY/viSpeank=;
 b=DVaYUj0jZkBcwZqDH75VFz7lH22LSPkWIJLmKuP9apXCSJbuAHDSWevhLhWm1QaOhblJzT5WmVqxjvSJJJeZJv3urGoXppS5pSEZeBcbqlW74ISa24YF/wAdzDZER2pGPg97PnC5akpA7aDZRmpYyk868KFMoG9LfSd7KpQKTf0=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 17:35:40 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443%4]) with mapi id 15.20.7362.030; Fri, 8 Mar 2024
 17:35:40 +0000
Date: Fri, 8 Mar 2024 12:35:37 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jane Chu <jane.chu@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v6 8/8] hugetlb: parallelize 1G hugetlb initialization
Message-ID: <vbj76pzf5mvooydne5fg2ewgjiducgficskq7hcsdxwywsda7l@qisdlq5q2n3o>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-9-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140422.393911-9-gang.li@linux.dev>
X-ClientProxiedBy: BLAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:36e::8) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: e96b58e7-241a-4d13-19d9-08dc3f962c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g4cX1cKGQXRfEw2XMoL9ngeDxZpdNieQu0m0hqLodwRFoBbL2WJ+SCdKj9fzvepntyrZrg+GkAYGDaohYe8/lFFTZzmITf2BJTYRns6jQLVtf9R7hdkNykl1g7rpHcpe4jBqy35J5kzomiaSOSEj3c70qd5RFMy/Xi857BzToRB6rnCDZv2LJVIC76fpZkLpE60BFhlT3Rywytrt/Tz8Jnj6kPB9YlBJlgfcYxw1FcCHZ3rCVqGwKFK3obW3EZ7pSS/o6bjgdCVcXUY0Gg/5P62J+vZmLBSoAn3d/pUwNMEkeu2eXUtNlZwWxddjOlfPGu9k7GgZWQNPLjZ0re3jLEQIUw4tGR3izp4TWuP5Vxx4Ho7E8okxNOs/zdwyFm6AMmRQeGOINo4WFsD0CcPei3nDhW9Z2D9JZoznXWFUxxXaOX8QrWkbo4FKK4mpivHRbHxw6LemSXQ0aYy53cr8X/DzFkb5htEW97o+NvwsnmXfvwc/D1EfAGF15jphVG+BzIcDV1BmO3Xown604a0bEEAGnB2Rzp30YoHuYA6kLGbf+R8RRn3RxtuFIJE8g0JdmfoS71ABCGQ+XsyIhIZuZLjftMq4+x/LPO9PP/W3x1RmQgJS2clPECEi+4hn5QKiYVUfnTIzZVeHO9jbSz6sBVbDsalC7okGaRYwh14FNMk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xCa9qsmd5xQ648J1H2oRh/CkluChQJKqanzyN3anWrJ3DdxGslBHK2H2PjlQ?=
 =?us-ascii?Q?BamP4d+kRwsLAV5ivtdfy8bUBtRSZBnkx01VSLf2+O7F8kYam68koYH4W+Zg?=
 =?us-ascii?Q?trzD0Mi9vs+AyHdY17AUPAS0YWAM4pbMaG5uqA4SJMgl6lkuXQ455f48sCPt?=
 =?us-ascii?Q?8Sf/AJSa4BTPxY/SimikYKd38Y/6pKsxwqHzTec/nQ05BKO/Pih61KD0MkBV?=
 =?us-ascii?Q?FxWUYJfm0KVTKsaYGyV8mgCDziVPiFXzFD1tts8p3UHdD0o/SNlsDrGXL3uf?=
 =?us-ascii?Q?ql7CaANt1EWIC4vyVCubRiwg8BPJPSdnv8kK5L8z1/XAoJf4fAyDm6Jj/z1n?=
 =?us-ascii?Q?wwgEEu3m76IFjTB7QFTSzREt33KhNzsblj1MjDokx6L07u5MBmk6HKZNns4+?=
 =?us-ascii?Q?TPnuWocCiB3Jegs0qrHeFaOE9PivSh6pv3E8vRxc2/NsLIGDKSPgxIzP8+UI?=
 =?us-ascii?Q?JBa5NxJi/ZEV5htPquHHp2gBl+Y1mk+NNBgjtsdaEcB/CmlUmAhUaai2/QkO?=
 =?us-ascii?Q?+33fIjkCy+7vhjwEQ3METKeeNnt1DMQtmyUKTC/0tYaqgO0ktubGyE25pwzT?=
 =?us-ascii?Q?mY8DwESiT1TFy62OFPy/nsYq4fMwNusgw3M89OPp0t/c6cpahxk7l+I185jL?=
 =?us-ascii?Q?y7ZXi7g9FcdYQcsWXW4lTYEeZeXhQOuMqked0zdwa7wcMtRn0uE3zahxJlFJ?=
 =?us-ascii?Q?PgAZAa7zRUkoornCa9QGOLdOgSnMOA+bW/uJMeiuz+LZs9LaCS2IkYJtOr77?=
 =?us-ascii?Q?lLW6bO50PQvDOdiVXJFxB0iCgI4um2bW8ZDtXWWlGC7x0XmYWrFMEbhvLaLq?=
 =?us-ascii?Q?bQSrwtgXRXmhLI0BU0XD1pzScjZNq2nAIYJeFye+iwHRW4Iw+0/4KX6AAWBS?=
 =?us-ascii?Q?+jeH6n2nHtfuJsxYoGu5L7penF7+3wukzQ0SVBotXvQDr76HqQC2RN26dD7L?=
 =?us-ascii?Q?YHJNbskljr1cAD6ASrWGhLmNzrrA1r8xiAtnEWpSc9HtCiPjkIByrJo1S3t9?=
 =?us-ascii?Q?xV7jlT2EI/roDnRLVqK59+525fZ8B17wS24RJ7LCP++oD3uko+GJrzM7K18j?=
 =?us-ascii?Q?ENO2DeOA4yAP+av+88+hFL6+kssfClFOpVHDOZ8V80ntUeu2RBlEEZlUYS2Y?=
 =?us-ascii?Q?ETm8y2YF318tlBo5COdfR3Jkn95N4i3kgxLmSLDxjGt58b+vZXOd2HTRIE4A?=
 =?us-ascii?Q?wpW1IZB/iyqcyhNY+cv3jmHTi4L/S0gi0BLydHPOiVP79g0eWXkVu4hX9t/o?=
 =?us-ascii?Q?E51SEnAlug4T2lwPOigIvFqQomIpsM0MZJyUVJt/P9j5Absm74uvCrnIXEfV?=
 =?us-ascii?Q?zwJmMQ5rufMOyuTifErp1LaWlJRin8GGlmhR8Qov1Wkjgjr9HGRq5Nt6UD5L?=
 =?us-ascii?Q?VqfPk8HT6ItKpGZJAmiSlWuva7wq9gQ4//3P/RvEVRPuu9/SN1jrjZ5+umpD?=
 =?us-ascii?Q?3uCKcs/eRIcLlOu/H0mREofbKrEgcFiJqhhdfdskxXBIxDG8EMxvMp4r+mMx?=
 =?us-ascii?Q?RQhfcMwa2ozxZ3J6IOS9S25fOixP9Oyf30pJzlFXlrp9iGWcBqZaacI9Anni?=
 =?us-ascii?Q?X3WAukyVJ17CNSVUmFe/bSMTG5F6xcbbPrTshAkMaRhgQ49+WCy1D8pjpoLd?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CK4GssEZwA8f6QLaCq4aq0u7Ip6o/WjR9qZ70DUaFZ9hL+17nJahwUVFrOCrVTQ3Pl7hZeFp+UgZF8MeU1EVUx4xSn+/6oy8x+dwvIQW+iZfNjAInhh5ghBjno/kYXvqmNoNsVFU4pgjaf5bnjtfVMGi1/kvZYJrjPTcggxfBue+6TdVlutLhpK2VThnIXXxwoBkVToLdHmJD5t3r/V9XumZ99zUJiiqxqTF2otCj3E29k4/86c4iyS2gfU9WAYE2x3pXTrIinuxGnVSNB7pWD+xDSZmRtWrB5HvJ3bCo+yIj7LeiM9YqyZq0kZQmKIPBgMUzT9F9q6hoQmFfApSC8hrGqbMtK9Y3QFD3LU4ezL/XDb41TBJ/zrRMccrvLWkxDO+F2t/L75Ak7DD/XDdHgtFyVUH67KkM5/9KdUWsEfwxbvd+vZBpX0nHnjtlRBNGbt/fGpb3t5Hde2174paNveXGCbcm+JHI4dERgjnpTjD4LeJRU0NYDK4v17Pbj/CAuQdqThIC743JRjFuZx+1o+yGZs9XONu9H9N26y0FElxMJDkOo3zfkyb+vS7WSUV/xAqrsdeuY+xZGXIZK951fGJu8mrxHaiGXFfoRuf3vI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96b58e7-241a-4d13-19d9-08dc3f962c5f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:35:40.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sFe2Yly1VxlKWu96EBIljO3BtTUFZaqK9Ca5s72OGHjKHYaTripnv1oX7sgKVjGaEqHvCdwBpqDvU1LITX0q0c+BeGKjWgvOHd+uJ8TmZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080140
X-Proofpoint-ORIG-GUID: Wtmjmqk5sFMOAU1ZG28wRXm303TTZ-Xk
X-Proofpoint-GUID: Wtmjmqk5sFMOAU1ZG28wRXm303TTZ-Xk

On Thu, Feb 22, 2024 at 10:04:21PM +0800, Gang Li wrote:
> Optimizing the initialization speed of 1G huge pages through
> parallelization.
> 
> 1G hugetlbs are allocated from bootmem, a process that is already
> very fast and does not currently require optimization. Therefore,
> we focus on parallelizing only the initialization phase in
> `gather_bootmem_prealloc`.
> 
> Here are some test results:
>       test case       no patch(ms)   patched(ms)   saved
>  ------------------- -------------- ------------- --------
>   256c2T(4 node) 1G           4745          2024   57.34%
>   128c1T(2 node) 1G           3358          1712   49.02%
>      12T         1G          77000         18300   76.23%

Another great improvement.

> +static void __init gather_bootmem_prealloc_parallel(unsigned long start,
> +						    unsigned long end, void *arg)
> +{
> +	int nid;
> +
> +	for (nid = start; nid < end; nid++)
> +		gather_bootmem_prealloc_node(nid);
> +}
> +
> +static void __init gather_bootmem_prealloc(void)
> +{
> +	struct padata_mt_job job = {
> +		.thread_fn	= gather_bootmem_prealloc_parallel,
> +		.fn_arg		= NULL,
> +		.start		= 0,
> +		.size		= num_node_state(N_MEMORY),
> +		.align		= 1,
> +		.min_chunk	= 1,
> +		.max_threads	= num_node_state(N_MEMORY),
> +		.numa_aware	= true,
> +	};
> +
> +	padata_do_multithreaded(&job);
> +}

Looks fine from the padata side.

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com> # padata

