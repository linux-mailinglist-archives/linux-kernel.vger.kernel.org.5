Return-Path: <linux-kernel+bounces-37283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE783ADB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BA1F21825
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83507C0A7;
	Wed, 24 Jan 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kODYqAT/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JfpDIgOa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CA77F3E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111295; cv=fail; b=GKN3klZAyke/f78hxNNuVcMUpCfUwJvHRwGCgyAq3c7hBXrlTXLp9Hvk+290jqLW2EbNhCbEAGjWaEwNO+/VsvzFdUf+V64FGSd0+dXlGMPDm1EBd5SKuCXRJUsACgyTsoDhUa8qWbJ/QI7SsuB0DW0d/+zFq7QYzOFJ6qdOBws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111295; c=relaxed/simple;
	bh=doQfi9mFRKh0+prhXF10Dj5dif3VT6fqDFsnm3iq9q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTa2mbs7uFAwgTvmK99bk5NWUnTLSf/ZlevxSm92VbW4wQUwN42d255aFF2zahqV/aa4AHEsxgqXm7Vp5jYPgYYPuNh82NOnjATk5yKVUXnxA1QAh1oUvKppkAldVe37+Aq6+/w5EnImvWPRGTJZuITFdOeyBv8Syy+0SRP+ouM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kODYqAT/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JfpDIgOa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEtvIt026118;
	Wed, 24 Jan 2024 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7v4k+dArpkcWJo3C8YkOs16QSuG+gLYdH7aSjeg8rO8=;
 b=kODYqAT/gx+ICdebR6AtMBJbJAMJeGWkBU/qHmq2rI2gc2ApS7OZ2DgDPQeDKyjb/13N
 YLP9lbt7F9hKibQimoAEFfNwXl2I4YQ06ae5RW4PkBMcqirt4SVlztkijq13xk6g0r34
 +Z4bkEqS8JQb04T4V0jhGEMg7W/aaIMzipEPat2eRtemTsGnXIM/Uw4y0j/MSgA4sT6T
 Iiqd4DhYI+aa7GDxdP+0UkzgkRyMEwCiAPPVNgGh6psYTAZIXC1PHft2uY5SLuKsbB+r
 S3o1zDYFacTp/e+I3D4Kob4/OhZ7DZ6NnZIxcPc3hvWvlgfRn1b0N2z63BHrQqDN2PXx 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n841u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 15:48:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEfCNh029468;
	Wed, 24 Jan 2024 15:48:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33v4hvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 15:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdSrj2tZC3ZVAfnHV5GSm28a/AfoAvbhlP+Dv0k3gy/+wRtwsnrDK0CeU+PJ9wszti1l0ZZC6zFVuFbUPdh+MJkS9ZR5BC2CEtNoxjQf7Wbd7UJq2IcgFv9nhShlyxgP+sjfalDt8n+HlSTdqhxsf6uQqlRUT2Vis2OYYB8Dui+h+b78m7oW6kvSaeJMHYf2nyZeFIBxVMmSCkyhvoykW0HesLF1Q/Inlb2DC91UpB0DN9zZ3XEV5i/OuzTiXAfLLZnt4GlnCz+5K7779wWNjU+0MhHysG6Qmcxib1o5LJGWL0pfDKQ+lAOtZ2DHSW6s3YJbfodOy5AULNAoLEaxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v4k+dArpkcWJo3C8YkOs16QSuG+gLYdH7aSjeg8rO8=;
 b=e5J1u5lKipTsd5Ryj+gAiD9jd0mGSGD2TdLKjo+2YL+RbdVXXR566krQ9DkoaQ+u1+EGQAwFk/E+w3coserKgYN+mBwWlGJupCYq2+BcRWP+rSFQbRqfXJkve1DDqh8OoTLGfJU7mBTiI5xRrJLNVr8xNNaUt2vj/UBiim/EG+nkD50jbYSeVA72VHuPa7Y93/5Dp+9/NVa5hE1H5WJdR6o4yVg2PvOP9etS20tsvo9vtpNvrEV9HRQhSWxXEiVOvRjp49IiAxa3sTLDZXmBjM01pKbHkhhM84mqaoGKCxfFOC/vavECRBPav5o6BFQTkyy4aHmVYnFcN/0QnpADrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v4k+dArpkcWJo3C8YkOs16QSuG+gLYdH7aSjeg8rO8=;
 b=JfpDIgOaXKpL076QB62IbB89qUQ2I0EWJffytyQge4Y5IJlNSy/xrcsdQbRjELR/0i/GjsGYssm1y3zXWznMeaeN9dQfrQ94Tw5PnBNpF2GnrGCtDgjKlicNXDAkmEQiGehg+K7fPMGE/jh4MGrAoi/zBQu73pXAqArwjkXel9Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:47:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:47:58 +0000
Date: Wed, 24 Jan 2024 10:47:56 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: introduce vma_set_range()
Message-ID: <20240124154756.edja2u2rjzlm23vy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240124035719.3685193-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124035719.3685193-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0438.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: c3082955-61fb-480c-4161-08dc1cf3d63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sqbPduAMR9LCZkmz5cTVvZj8ctcwtyEbc37Q/iL5oXjRGWC4zmLaUSPIOn8EmD02nlXusVnHSjClFbvfzZtoTTibMpDnDRX/VrHeEWyM/1fDtfh1w0ZiKoLZe/sI4jbD15rRkT0UguR9S+/LJjOYG2gIe+jh3Ea4FzXyUWsAJjG2gff3DPQ7J8xg2cpfpAQ3jdvoImUzM8/yHHFIxoFS13/kFjhJv76F/li88hmNdNWcYFewhGrrqf3HI9QogNayl0OH6gn5Dw/7Bda5Tds0apIZhgknvG+uCn9XlxXhqEVm56T2D3POi3lv5cQFOFyjkwV4CSLOZKoV44KinZ38ackljftTmrgM8sq3qKG1STDG/lC/siIutPHe9dvV65GSldfUdRp4E+hdMda0JhbBv2jE0Hse1/pq6Bhqkm0ys7QDUSchzx4xxPcus3+Y1886blz6NCalsoQzPAmPzumW5/xZF50jYBi2OdYDXZQ/EsJWLgHKfUcfVfOjVduHHCXB363S80zCmD26bMxxd807d5cBVDcYM+HInymNChIHaoU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(33716001)(26005)(1076003)(478600001)(6506007)(6512007)(9686003)(83380400001)(38100700002)(6916009)(316002)(966005)(5660300002)(6486002)(2906002)(66476007)(66556008)(66946007)(86362001)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NkFJhX0kam1hdB9cbquM2rCqSAG/plaRqZSs6l/0Q4z84krMZMKfNmnWx60v?=
 =?us-ascii?Q?hpoipBxP1VXSVNyW6HFslpzZGC8itEhvBznKLxqaGHXbe61WaxMPooBrItq/?=
 =?us-ascii?Q?aOmWmdEbFtxnMlNApPxgI2VJK4o7xlCiy/RzEb3PmhOlg4OKDBLqvY47djc8?=
 =?us-ascii?Q?7ByQkwBunaejhrMvKngiivBd3l3ZuYCdlGXQzEtDoIysIQXwwBBnUsXnyTcJ?=
 =?us-ascii?Q?kuFJJtxiR5xJGHBaamB30vFBZVbc5diP7gWoWpI6v+90fJB4stI5PL/5tI9x?=
 =?us-ascii?Q?N74hhQzCC8g1OrTtrDt/xjBzVFbZree4gWGLLu43vnW2WIoMzKGrP0OZWjEd?=
 =?us-ascii?Q?SCM3Izi/tiHRc9/0V+PYWCaa/piwKe/Zvi+yRkAyahpwHd++phiACByiYWqQ?=
 =?us-ascii?Q?/n6Kc/s/lWsCVn1q2SrDsMH/ZqWUK27lQjCl8TlVJb86+6h4QxcRCBA9gMCI?=
 =?us-ascii?Q?UCIo4auXf53IzyDx0gZQVbC/wz290+Q6d5c0kMZ20lb+724tQE+QGR8GeJdy?=
 =?us-ascii?Q?4uWym6a3zCHWfdeIL4H/QJAZkrTRIw05EaR12Eg7VGRdKlreHhLmLsKtNiNC?=
 =?us-ascii?Q?9DxR6z62xzIzMSm15H2Jz6gRXb4rhkjtPp3IuyF5J6i7hN6v1lv02LEJKGqm?=
 =?us-ascii?Q?E7Cmz1bZUwnCyacTWdC2Ph0sdwobY7OQDiiF5Ycco/i1GUig3lAy2QFjcSZ+?=
 =?us-ascii?Q?KM/HQMhgzUzLU7DpewEY2VqpnH4Vo9BuTaPJeMHbdgRHFSBOdRvHhpVflen6?=
 =?us-ascii?Q?KaGVKp5E6RAvraNvkg1u+YbIsEjxnXkurl54v7yrlK1iZVjWiGrKKwHsgtgy?=
 =?us-ascii?Q?TIScbvLcLor88b/gZZ8Lf2jOzSmdaSJPQgg/R2QB3dH5GEryq5HvhQn4QRwD?=
 =?us-ascii?Q?Yf/idq2rDtV33GgVCAcaxgPzCw5qfFQAkwEU00YB10xSgJjOlztMoVIBU4EO?=
 =?us-ascii?Q?7q9tiFA/vUKVay1Iu19IYv/9j0isDpjGLFDZ7WxO2Ko0N11vmJs1/V2A50hs?=
 =?us-ascii?Q?iCAzde9bJjYea7zmO0QcujsFEOlVLL1zWEK4NIN7C0hBHDBW0f768Tq3WUEX?=
 =?us-ascii?Q?VM5Qm2NK1hmD9/TfLt1TjJJjYEL+ZpqkdojKnho6kphkfrQdBi5eiOz3e+He?=
 =?us-ascii?Q?JFVOm9Rgn+YMp4bJHSEGEjA+jpNyLvSNknXC9Ha6qTcGPyCFIu+7O/ocmwN3?=
 =?us-ascii?Q?MQiNQLRH+q18/wH/O1mXaM3fKCmNlsFBnnf6EeIAx/a5NfGka/V0lvDI35vq?=
 =?us-ascii?Q?JAEJIoOGt/fRiKOpF6dMeXwYralzCYJ/8Oa5XX8FNCcXfd/zFvyDTuTIVgpA?=
 =?us-ascii?Q?eON+jkFFhmTcABHL8oQB09l88By7XX6Io0v9+QyadOO5FvXB0voHbFK9Xr8Z?=
 =?us-ascii?Q?vCs+q7FSGafldc79cIk15B7HogjsuFJ6caOR9XvZP6KIXYiAMkF4eOtDzhjs?=
 =?us-ascii?Q?46v5pHHdne0jH72Pr1Mf54bHNe9POVkFdda/+MmJonSpaEtju/C1NAy+391H?=
 =?us-ascii?Q?LWFhIScWlkRtPACKDtYZJNY33bqcScympjv7L8Ug0SXdeqJOeNtjhu7fvGGL?=
 =?us-ascii?Q?BNNb8IGisos3Qsxq5UbwP/DBw8m5w0+G0DoB3U32?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	muSoKg5ikiofNot7crykaa0PlqzdsStK1izw72PnwJEb3GNP4bnVY/30RcDkkYc7ghUYjCNsbdbo9prLJqpJBLIAKmohtWAB5HGke0IaAZ2RQKniXQl9+muvceVeClrB/jQG0hsJwF8yJ4pQoE/3B3YSHQgD0C0zapRyCC3X8zY9DFts7GIn1VuJxLT9CCnLarSfcU30VhlxbnO16WS+ZDLQDoUSRu4ZZ5nFf2K0FJh45YKpDjKr17x6NGwICAEHeMmZ/OrEVYzbYTBBdc4GwD1qdkHrqwruDz5W47mCIOb4/VFqIuuwTrbeFQX4XSr9+YECCOoUMlUfGN1CUjnOWHp8fSFcQPTMtalDEmsFyhEgOAeCFn08Nfd6K9RdPZQIqQ8y+fBZpaWbU9S03eMh9be91+IfVt3DTxgVsv9sxx88tqR/Cgn3nHx/rGVg1w9G/NutQSky1EuFT8+M2p4I72iPot2J4mCiuxGJNtr5cKpMN6NKfQXAI3HXjVoJfTVeMCo0btW8iv3BFH3rqUmMMaWWcvepW8EHM0/+xnBifos59/eeOELmKYS/N8+eNbELAfyxJ3SVLsj1MNFPvGKI1ETQE1v0OaYPuvohtohcUXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3082955-61fb-480c-4161-08dc1cf3d63c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:47:57.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOjiHAzKbnXsPncsT7KrB6A/JmpZBbhtC6a4CiEBoAg2dIfQuInzPW5ozgmbavfFjUG2AoH9vxUCnkZ8fffH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240114
X-Proofpoint-GUID: 1TKyZr8kYn-no-Kj7Tub9dmNzI0Jsca0
X-Proofpoint-ORIG-GUID: 1TKyZr8kYn-no-Kj7Tub9dmNzI0Jsca0

* Yajun Deng <yajun.deng@linux.dev> [240123 22:57]:
> There is a lot of code needs to set the range of vma in mmap.c,
> introduce vma_set_range() to simplify the code.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Thank you for making the suggested changes, I have one small comment but
you don't need to re-spin the patch for it.  This looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v2: use vma_set_range and put it to mm/internal.h.
> v1: https://lore.kernel.org/all/20240111021526.3461825-1-yajun.deng@linux.dev/
> ---
>  mm/internal.h |  9 +++++++++
>  mm/mmap.c     | 29 +++++++----------------------
>  2 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index f309a010d50f..1e29c5821a1d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1114,6 +1114,15 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
>  extern bool mirrored_kernelcore;
>  extern bool memblock_has_mirror(void);
>  
> +static __always_inline void vma_set_range(struct vm_area_struct *vma,
> +					  unsigned long start, unsigned long end,
> +					  pgoff_t pgoff)

Nit: This isn't part of the style guide, but if you just indent with two
tabs for arguments then it is easier to expand the list without more
lines.  It also allows changing the function prototype without
re-indenting all the other lines, so future changes can be smaller.  I
think you would save a line here without affecting readability.

> +{
> +	vma->vm_start = start;
> +	vma->vm_end = end;
> +	vma->vm_pgoff = pgoff;
> +}
> +
>  static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>  {
>  	/*
> diff --git a/mm/mmap.c b/mm/mmap.c
> index cf2f058bb3ae..7a9d2895a1bd 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -663,9 +663,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, 0);
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> +	vma_set_range(vma, start, end, pgoff);
>  	vma_iter_store(vmi, vma);
>  
>  	vma_complete(&vp, vmi, vma->vm_mm);
> @@ -708,9 +706,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_adjust_trans_huge(vma, start, end, 0);
>  
>  	vma_iter_clear(vmi);
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> +	vma_set_range(vma, start, end, pgoff);
>  	vma_complete(&vp, vmi, vma->vm_mm);
>  	return 0;
>  }
> @@ -1015,10 +1011,7 @@ static struct vm_area_struct
>  
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
> -
> -	vma->vm_start = vma_start;
> -	vma->vm_end = vma_end;
> -	vma->vm_pgoff = vma_pgoff;
> +	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
>  
>  	if (vma_expanded)
>  		vma_iter_store(vmi, vma);
> @@ -2809,11 +2802,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>  
>  	vma_iter_config(&vmi, addr, end);
> -	vma->vm_start = addr;
> -	vma->vm_end = end;
> +	vma_set_range(vma, addr, end, pgoff);
>  	vm_flags_init(vma, vm_flags);
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> -	vma->vm_pgoff = pgoff;
>  
>  	if (file) {
>  		vma->vm_file = get_file(file);
> @@ -3163,9 +3154,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto unacct_fail;
>  
>  	vma_set_anonymous(vma);
> -	vma->vm_start = addr;
> -	vma->vm_end = addr + len;
> -	vma->vm_pgoff = addr >> PAGE_SHIFT;
> +	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
>  	vm_flags_init(vma, flags);
>  	vma->vm_page_prot = vm_get_page_prot(flags);
>  	vma_start_write(vma);
> @@ -3402,9 +3391,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  		new_vma = vm_area_dup(vma);
>  		if (!new_vma)
>  			goto out;
> -		new_vma->vm_start = addr;
> -		new_vma->vm_end = addr + len;
> -		new_vma->vm_pgoff = pgoff;
> +		vma_set_range(new_vma, addr, addr + len, pgoff);
>  		if (vma_dup_policy(vma, new_vma))
>  			goto out_free_vma;
>  		if (anon_vma_clone(new_vma, vma))
> @@ -3572,9 +3559,7 @@ static struct vm_area_struct *__install_special_mapping(
>  	if (unlikely(vma == NULL))
>  		return ERR_PTR(-ENOMEM);
>  
> -	vma->vm_start = addr;
> -	vma->vm_end = addr + len;
> -
> +	vma_set_range(vma, addr, addr + len, 0);
>  	vm_flags_init(vma, (vm_flags | mm->def_flags |
>  		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -- 
> 2.25.1
> 

