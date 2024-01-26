Return-Path: <linux-kernel+bounces-39540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5C83D28A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E000128BF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B999E8C01;
	Fri, 26 Jan 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lthhy7VN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f6dEGf/e"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0A8BFA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235937; cv=fail; b=azje1VNyKMXkyPpCStX4kygv+5MB/lOU5IjHNAwDp4Y6GRGhda46xcuWh7U8ypWDXZCgdleUJuAtxLrph29TSL4ksnNVsFXX8bBraTithP3nsJ5wKhI+s+CiklQFJpjYVFrJPGtsKQGxyNDONJm/xYDMJSGxHrQi0CZOF6OH2vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235937; c=relaxed/simple;
	bh=qL9y8Yy82diegTBRnGf6mQ3js4DJKKk3lXZGpuf/6lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWyk+eZBPVFZ1b04smAmOEJ3KzoewMnHwF2K48OaNZdKfFTyhM11ukWTQiqGqXgAub5vxsOzYXEc01b9RWD7e/VFNRDsGcYtTTiGoXrf5XX34WKMED9fvUMRr8ccYtEQO7AotGDRW6yC8UkAabZ+hPtuXlOAcWS6tZcaLQCO0uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lthhy7VN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f6dEGf/e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PN2PXL012790;
	Fri, 26 Jan 2024 02:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=WTlgaWrbtjIND2yq3TGzdbDDuwl11mQOTQI3q5YcL9c=;
 b=Lthhy7VNGsu3al3fcXRwct6xJIHJAx7vb4b/OrbO6qpPj1JX+HBotnrm/NDXeqYXWWEx
 H1Q6K9hTEqfFc1dle4HZwwXPSeietf+1zpXXKdzJL7UgIA3j0HVSu08H7BOsHMcgZl5E
 0bOuD/E8exKMVjuj3qYpNYV6ssZP0UVvRL24BzolKAwXfVb7emTvU2QiaJLITJhaTQ6o
 HUx/DYfTuDH6cgaJ/jIucOrfRTRaewoStY0+M2BeftGiaWlMkbD2hx6LxHYGSpN+Dyqc
 ZMDipt5tWTcOa8NSvWMJ1eJoCSfqSiut2wII69CZQd9trut7PtXl+YNXuF5/Up7n4Bat +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cv19kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:25:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q0O6C1014338;
	Fri, 26 Jan 2024 02:25:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375b415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFbsfdeJr5/0/D957GRVra/69qbnC4Stk2KJamMfpXYJtVuSc1AdB1Y2RCOr1g1pvio8P6rpgPcIyF7Ytg5G1B+ARkcKZWSodReIgZnca64FFVQXuRyw6UWyH/2Uog6GIAO6m7ybqY9xZkjcDEw8ChSaQCsmQm4vjLNYMXaUbzyaYvgwZ+uPPr6ElzlLXr1twH2Iu6JT/kr3AwnJnWHf7fAain0otCoNJJIX3bIEE6sBLtDgKQJRp9H/ETSt/rabgQ4eo0zmYHCMA4P2czcYJDVfDMetuk/0849EUTAd9sQrzWnjrUUqErbzpFYegcgOq3bXWIj7MhYI43cilTIGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTlgaWrbtjIND2yq3TGzdbDDuwl11mQOTQI3q5YcL9c=;
 b=k07EOvZ4zT7xTDoflx8hHXgB5Vgs/xLM9CrWrrgDomGOlG0WyDz3AQshEjb+bNHZHUtqqQMP3D1ncncZWgefuxYX7Cn9voWYOPoBDcGRItO4KQ94ISNGtdY+RVnyrbQC2BgYyOvd1XpEx0KgGCyg2OkFRJW/muIJJgCha4Ok+fpUB2fC7rKPWWvBDaxKu0L74GkiicXeVot0ZFiGb2O0frweOBk2uMmtC1YeUbbIYmYmhtAh743nY6cBeTjL8qiuLJ7OD1y3dKyEyXBxsvUGIL9jFISmiSmc0+TXjT3nhWd8NxbKMhAja2RhPBbrsLNqmT7/GNvEGita2C/NRV8jTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTlgaWrbtjIND2yq3TGzdbDDuwl11mQOTQI3q5YcL9c=;
 b=f6dEGf/e7XgyYeXVU0ChCBxgoVKUEILkplyumdyTSp2NvBxXFclbaCoIHn6o+11kSkgxlqPHuvbcaaqLULcZKGSEZEAjW5ORENNh/4iIAOPigzmbhB5tB+sd+wRuJ3lZ9AF/KaSVNYTP5RCtRkFJ6NgW5f5ocb2Duq5SWH57QE4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7666.namprd10.prod.outlook.com (2603:10b6:208:481::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 02:25:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 02:25:03 +0000
Date: Thu, 25 Jan 2024 21:25:01 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, lstoakes@gmail.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, vbabka@suse.cz, willy@infradead.org,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mmap: pass vma to vma_merge()
Message-ID: <20240126022501.juc5d7xpotjyying@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	lstoakes@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	vbabka@suse.cz, willy@infradead.org, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240125034922.1004671-1-yajun.deng@linux.dev>
 <20240125034922.1004671-2-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125034922.1004671-2-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0055.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4367df7f-428e-4375-9d51-08dc1e1600f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W91HrQSaewOfUS5ULCvZVwLDUq0sxpIzzSHrBFHgFg4p+e+5un/sJxNfzYJpSydSsToAJiEtRQYd4dDviqTBah1k2FAz0OhJSrf40s76JcCgv14asEQffHnEn2Owjx52AtkRhhlWcoTgyF556jky/Dw0PuE+BagDKozxij8Hfbc7EJPVs/xaSvTHe51X5M9wRjb+5FFP5gtYcF4P0tdFX4CDFSLkHRkXzlK4ikLcndIMp3K+c7GtgGKAnWYA3DZtlyi/kjCZS14itQZrCACeXrYS4niBVwAAwUBt+GeoBHm97n/9UEdq3P+mQFmyhj52vCefAsNFRk/QBbUL1nkGvF2MEiO/kxc2Cug45HQDMIYH4hKbBjOpYkyT9tm72tz6/dd33hy2rJ8KQYKDxXq1Hp0AnLELkqK4aE9pBwhV6r0naQm0VkZLGqahQdadP6mO3pzi9VwiVYdoYtnQz/9VWWNeFOD5tmGCyiCIzrJYuB+m7kFr2U818Mf38/yaoagLl1GBajvhc/aQfNjr2HCKFhKA1W5vwVPNmAwoPYGQsDmp8g9xujPfNOMvTtYI9WcJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(6506007)(8936002)(4326008)(8676002)(316002)(6916009)(66946007)(86362001)(66476007)(66556008)(41300700001)(2906002)(7416002)(5660300002)(33716001)(38100700002)(1076003)(6512007)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?owy1pMs53Ia2uwS6obrkegI4oX2oIXMJ9ZyvOkeK4UFMnSWn3AJP7wWYpeDi?=
 =?us-ascii?Q?P4NIqrtRJp7lOxJX+DIVOG+1fY6BCfLhIR895ViYJ4e4fmhYQUan9PGnzOM3?=
 =?us-ascii?Q?fOfp9K8IY4a0rmRvyg3K70GinPTKOrmi616bK569A7mRnkG8a2VX54kd2Hw/?=
 =?us-ascii?Q?T5XPfsqVgiY8r8WYRoI9PvlEn+sUUlTnMxTNcN5PtQCGDRIV3wBi6vkqRLks?=
 =?us-ascii?Q?d5jTXtG9zYReCbKlxIygKpBTCvQvO0R7ujJbckdeDpEQpQrF720Nzp81jF+u?=
 =?us-ascii?Q?aAZXm5ePCr/t2abkkdtdG9D10WvaYIzYHkZi+JIfbjGVFaaQNAGQsj+lb72Z?=
 =?us-ascii?Q?Otwm0oiYTNAVFsPcu6Utf9I33WR4LBOJ3szsUIXaeChKxwrqPospp19kpvXw?=
 =?us-ascii?Q?7bwX5mrmRTimBA3y5OdsQ1cbqfqohnH9MG/OCYm0jjVU6zIsDR0c9oTXaZ7T?=
 =?us-ascii?Q?PMVYHJpPzB9/MD4EQbYMHBLELD73fVqMSx6Jny4us9grpq9SF8ahsyaeiu37?=
 =?us-ascii?Q?tHVZ1ZHJO0ivA/6oKXW+plYFqM22NIrtPUDy6gmgQHP/Mk6W1aGZCmeNup6v?=
 =?us-ascii?Q?/4d3Ue/gkwSnzcEINNk5ExR4S56emg3ZlSzMG2VTD8EpxH2SpxW6B1KkTwNv?=
 =?us-ascii?Q?VcLtXs9keasdlsUo7JYWQ9vKD5P0XE+bQM87+WbKHuhYDiS4DUvAuQKVQrHj?=
 =?us-ascii?Q?/2Krkay0hwhsMSIyNS0GyY/bFEDul2JWZJpjgFZD/Hok5UTQnDTPa8sBQNNG?=
 =?us-ascii?Q?dZv0QfkhI9ariKag2u+HiMUPyz33KuTi74U05SqdnfvD7qmLwE1Stmnj7f10?=
 =?us-ascii?Q?E6ceGuuKheNDPQFS4S46unwt42VjLzTVTR869Z0WY/N0zfGrddR8Xv18XvT+?=
 =?us-ascii?Q?pdCoGXxSXpx/xu3nFnW3+kArUPMlGAGHsvL55w9C5/WCkPcYABxjO9/m/Mmi?=
 =?us-ascii?Q?N1I0qrtaLfTUNJhMGW+iGDhBAZVirqPjqbuJDpdaZBYjyoV49JIzcM1T1MoI?=
 =?us-ascii?Q?uZoXLM+f56isyA2s9bdmp8TU01mrom+cnU0udanPueT082HAn8mTi9OdChML?=
 =?us-ascii?Q?IP2eKaiqYVBxl0E40TmCqZSYpD+A6+xG2M5onHmG/VHSMmHZO9MyfHIeCIIn?=
 =?us-ascii?Q?+MUS/LfiDY0DnYAlQsljz6W8p7mbHLuHq3wJygzwqyyY8dPjYVedqxiJ4Zrg?=
 =?us-ascii?Q?n5EVQw39WpUa9OgTPXAszClTyqlXH5PyFAxIZqKOE6BNAEUIYgDB6XfR8Dos?=
 =?us-ascii?Q?41YB/83NmphI9q2VI64b6wtYJANq2W/xQqYKKYSIZeutc3u4iceWE/06iecV?=
 =?us-ascii?Q?1IuhaseI4mfbpfNDANVPUtEPGJyYvOcRpW3cFdLp3U+5Ri9cmLidgTMVQi25?=
 =?us-ascii?Q?bJNL/hFaHNQ56a3SQSICIfUEaX98qsmN24Yt/0JKm6x98kx7HoDB/tZr4zl6?=
 =?us-ascii?Q?EAeJERJMQmlFTdZHrnXZ8yNTnOu/cDD7QhwACj3QCuP7QC6Gzn3l3H32Ls8v?=
 =?us-ascii?Q?UF2KCFaGsL3NoGdCEZ0A6pHZ/35k+udKVvyHUUfle0JGFwZt/RYUdvWBTcFU?=
 =?us-ascii?Q?H9oeTb/oNgTd/9FAsyQmM0wllI3o6ur5zxGp8TN3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WQ072EObyXsDbFrzbWEI6R3Q/M4WvDEnMOi/V9gGoqUhWytAmoJqiDudICWCKUbhZnChjjfeT/twX6wVgKPqh/p61GYQeko+vvmA9Zw2o1FxIzA8/Sqed6YalWdtBuzdyIDYKzFP805+0gn83dB8GIDrZrDYG8G9H1Y6/TDsB5VzDCDp3jOX9Ng2mxafsyC/LcfTUXlh9L1uN5cKVI3qJ9EZm1ZEm92pZTgvyYCYNoWMFACFCcWQ2c9ZAgPFaypfRMQlVheEK/FbdtVqECTybnxcJYBBnZYDzhpun4wP+2Xmi6/ITCO8iK+i1AJgyv67I9zjRnZg8DoeS9E+8HX+zkIcSI8ltFSFm0D/wGHwsfe47WxVf51NTTTY/ISdq31upOQtER8ucZoHlJRQnT3cd3EpYdq1mZunEHrrDPK+4l5fCjumG2g1Cxt6BL7KCnBjMN+oWS/2M+0/2bqwqJTAi68mHfmfUgHfUmo2SEjckQgBIcyNhVJJ5rXOO68bJL6iwVPQGSgl821WS3bZpz2/cvMYGDjNw/4yPGsKuTkAPo4cRR7qxOeGhaIe4hPO9tyjK1wc9xBG0Ictz/7SbvIW7wO9SrtXj3c0R4iqwsn6MMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4367df7f-428e-4375-9d51-08dc1e1600f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 02:25:03.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCoOCN6DpW2z2xtUiVzo7WKd2HFZqU2y7AAxeyulzzDad+l/P0imYmMf426zWJCDZom5OosogmG5tX7yJvLbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260016
X-Proofpoint-ORIG-GUID: pxaFboipmb8VLRR_pfmrdRHOvlvpkD1A
X-Proofpoint-GUID: pxaFboipmb8VLRR_pfmrdRHOvlvpkD1A

* Yajun Deng <yajun.deng@linux.dev> [240124 22:49]:
> These vma_merge() callers will pass mm, anon_vma and file, they all from
> the same vma. There is no need to pass three parameters at the same time.
> 
> Pass vma instead of mm, anon_vma and file to vma_merge(), so that it can
> save two parameters.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Thanks for splitting these up.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 49d25172eac8..f19bc53bc08e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -860,13 +860,15 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   *      area is returned, or the function will return NULL
>   */
>  static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> -	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
> -	   pgoff_t pgoff, struct mempolicy *policy,
> +*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> +	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> +	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
>  	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  	   struct anon_vma_name *anon_name)
>  {
> +	struct mm_struct *mm = src->vm_mm;
> +	struct anon_vma *anon_vma = src->anon_vma;
> +	struct file *file = src->vm_file;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
> @@ -2424,9 +2426,8 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
>  	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  	struct vm_area_struct *merged;
>  
> -	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
> -			   vma->anon_vma, vma->vm_file, pgoff, policy,
> -			   uffd_ctx, anon_name);
> +	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> +			   pgoff, policy, uffd_ctx, anon_name);
>  	if (merged)
>  		return merged;
>  
> @@ -2456,9 +2457,8 @@ static struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
> -			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> +			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>  
>  /*
> @@ -2472,10 +2472,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			 anon_vma_name(vma));
> +	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> +			 vma->vm_flags, pgoff, vma_policy(vma),
> +			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>  
>  /*
> -- 
> 2.25.1
> 

