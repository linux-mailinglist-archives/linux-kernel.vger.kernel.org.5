Return-Path: <linux-kernel+bounces-75010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6B85E175
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C661F2550E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82968063A;
	Wed, 21 Feb 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WQAmWM5N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lvoAXjxD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE57FBC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529939; cv=fail; b=NguMu+o3oMtC+Rhwlgzr3tT4tTRzc9jmRdC0xtBNPT/wxp2MH5fWPTjdpMcebHTiZY7mR04Fjze5ka8x6T4bHG7/tPpVol5fnmZCJBPvTz6EW/IkXPf5r1TG5p8c5y31HqWhym5fFy2lDn2T3i7RXVcJ2Wg9Y9hMcgwmdjaAsq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529939; c=relaxed/simple;
	bh=XOXTEwwiWUylVVOgYsYFxS6SBHyCVqWjqH3DXTt7//A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtqvK6/2fTjumM6o/jO9Duy7mjYRQXNERmC5sM1x/o67Ew3KmdD1hDdySak6jxopMON452J/3twa9htvm1ABD/lZtrkxEuIbD+EyOGt0jmvQGLT2s7zz5sEtt9KtJfuT6MV87REu9LRJxwccbhbuSQnEB4j8RsGJZg3ooAYdOrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WQAmWM5N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lvoAXjxD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDiWTm011347;
	Wed, 21 Feb 2024 15:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=iQQLcUziRSu0NwLTCS6MxGrBl6T0gg3FHgD/URAkWQU=;
 b=WQAmWM5NHQ+CQaK5Zbx2tkl15/wuXVn99ULrAlqkxoaiOAT4e7g4orLsEPijqHHSexB2
 /FHNYInei+FvwjyXvfuWI3x8wHtjrrVgL2SelxrgwQhJiBPH6o6MXptbN9LRmWkZnRNF
 lCQO9Qoz/a7krEWxpBXVhLltGbkhqKdVoiLJq9AKMcs32Kqjtf9qRWOJZSULj7fdkG/D
 4vSBXVFnsLLv7eo5nhJsS1fRiMPCMcFL1bYRodZjmnx5EynwLrDh0fRw4VWV/N9HGQKv
 lyopvVJYKHatPbFhiE2HFuSl9+QvDDvWLrADL0iSIyyjX2ZnxpX4lAOMsMHFRMcTa5mM 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw1qx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 15:38:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LFbOhh006592;
	Wed, 21 Feb 2024 15:38:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89dang-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 15:38:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRiNsaR74US8wNYKSRt3+dZl/4fJamc3z6irOd7UtC8LVkbCw/oTvfCJTubhvHNnhBOO0ZB7H/TFV5ecwKFOhk2UZWw4AacCIpvThob6QX0jikx54YBm6JX16datFewwDYKjpFozfkEn5gcV4cix72QwhwoTZr4iFpLy/wJhk29cTRUyIE5uuBGNgaQ8KA+AP15RB0uAt3vvoXwgNElY9bKmPU0GPnA12I2zKoSz9oR993ng7MDB+pBNsYNCoQmbLnjL7HSj2iJlUpjFXUPLTISNVSnVLOhPDdO2Jml/asYwbx5vcVcNQCNR/kHrJaGqOh99dyLKN9JuJ+22jdaINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQQLcUziRSu0NwLTCS6MxGrBl6T0gg3FHgD/URAkWQU=;
 b=WTR0s7MWS6RIy3vDN86oMi0pr6GJAEW3K6esZicr3nbSdIv9CscgV0lTdg4kUmw+ciiBybCSXjsx8ftO1vqATiAeM9/MEhzJVKHSvOgdeYHeqC7Gpj12+Ao2Y7erwUrtKleyr+Iw/S1DnYJ2c9rg7+hWVQiMpSWFOEXqM0dInec+e2AkFyzkVBxF0UnSAhd8HRUNfi1sAqam6toFE5oycDTG/323p1JcRhBPH4zEZL0irh2ZQrM6GOkI0mCrmEsPl/JAyBZjUZK4LXmhrNSP8y3wKXNmZgxbyE8847ZGt8k5pHkZgt4Yd+pj8FDgiDr7NHeUXGHF6l/xZ24r4vqgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQQLcUziRSu0NwLTCS6MxGrBl6T0gg3FHgD/URAkWQU=;
 b=lvoAXjxDYIJfItCiQbLCGcID6cpoU+YDhQrrZE6B/DfXOjPAsXjwgzPn1OH86mHubkPCTspE53uJKwxCoZZVbASyvTKcIOsT29NDg22OqLmtlcaHghFCZbu3Nvb/b7N2r/r6IjddsieIZxqDp8ShVbH606dkVokO5cxcr7JRmhA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5708.namprd10.prod.outlook.com (2603:10b6:510:146::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 15:38:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 15:38:29 +0000
Date: Wed, 21 Feb 2024 10:38:27 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Message-ID: <20240221153827.wkmjnnwsf6lyxatc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	vbabka@suse.cz, lstoakes@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240221091453.1785076-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221091453.1785076-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: a4db4ec3-c973-4fc4-ee30-08dc32f32707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	USlzmdrfsiOR1Dyfj+m5UbpPzFklATPpv2PTQxxE3+izvGrHlv6z4VxwNlURHaE/jRm0xyDpFNnalUhKDtZvkiVlwR9fp2D3uMkfSU+VjPXzrauqWE3dsWJWGF9f7TBphfdrJ2bwgejRXBaUjPANverHo53c5yV8XiMEd/PSRC2sibxQiBkbHuK5gIJyznapWFt6GchsWYwlu0k/rzPHlKR/Mexfqhx2IZ4hwZRTaHQPIRwXbxOlHoJ1eVQyBgSEYhj66wKvMMFDItqnMXkuZHh4xlU1KYXP5JuxStpmQOv4ZArOYZjl6buz0Ww0NkY0WdIiC1mrWxdct+ZdkPKHsebl223zcoojbii2590jlOAuB24/cKH1AtQRdlYrfi0Va/WN2t/5y2i1BdI+tu56Rzkp/a8EEXhV8HMixUELUBrDv3NbR6/CIFKkms3hFNiFK4a56TfHb/8l9qkUUOPmLXmyjlcWM7ZrPt21gNRWRRy4/qFKZY4TXKK17N6o/iLTQ/YXizMwYIAYlsDIw+G6Uw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Iv0E3SuttJvHrQ0FL+BKcOzvAphQQEZOjW0lkzsBB0ogD85hSI8vsZJMZJ85?=
 =?us-ascii?Q?4FjersiY9+CAoEt0ZX4N30OYMgohSSAGdpR5w+sFEJMEZRNCSEvA9ih944gu?=
 =?us-ascii?Q?7/hNzsEd4b6vIpzDI85Kw0zNwpEsILyFqro56yYrqduLWyNxCtBNUugNZKcS?=
 =?us-ascii?Q?+kks1itDQYCfua1ZHyk/GOGTlROZEXzmvEkgTU6J1mB8abJkblP6Kz6UvH2B?=
 =?us-ascii?Q?qS/1KzL7z54Uo8lhdABXlLC7KJ1Zh81TUMdpoK3AtZlcEihH5KLWyciujWvc?=
 =?us-ascii?Q?5YOGnL2itbfRtCgvxa39dHELIgZonDt7dSxcX03Mm7FRiqoS0GFokj3g2eEO?=
 =?us-ascii?Q?/gUvMKY5VdPLrmyX8stGkU2sVY2GkR+XeDt0+Q2quPIa707YGiMGdZrPvmB5?=
 =?us-ascii?Q?y4642+yqqOMsnN+OdOvd5uKJ2+53Be51HxZ3Jm1Wxi19PKRidCLzu0g2UraB?=
 =?us-ascii?Q?QzgO1V9/DewqnkCACt6fhB1kY4ak+iOcDWGa+jtd21e+jPiR3Q6y/xti36Fq?=
 =?us-ascii?Q?ZmJZB8/fmSJcI8WjWhHEeLHt2KXHmDjMKXYHjVkgeSZGVWIw1OJHdTwCz92w?=
 =?us-ascii?Q?3eNbaP78BOFipA/uqwdw/j1Se+lyg1b9mOrmSx4VuUf3msyUXOLtrE62/m6G?=
 =?us-ascii?Q?S16scdA9y0sWo8h8s7gNrV4EyJK6W6zGmYU6f0Ba1hs2rPpdsl6ZBLMalKrT?=
 =?us-ascii?Q?KpgiiQoXk3dWtJugqbYnYjT/AZkO1G5NQnPleOWDjTdMnmT0Z52+O2CExtYb?=
 =?us-ascii?Q?V4Wsoa5iSUQzjNeYz8QudFmFJKsN+XhW5orSPmAa/4BLralrc3HJLz2JkhLU?=
 =?us-ascii?Q?t2ASCCmgPG3hPMNcdixfwP8FO1DFtG0/oNl5FIrdFBu7BZmfgyWyiYMMUjs7?=
 =?us-ascii?Q?yQApJl3Bb8UkH3OUYNeNepUG6AQaYqj9L0i1rgudtGsdBuaZCuTz8GNOypuU?=
 =?us-ascii?Q?mBi3L7KicGdal0MnfuLeBg0Wuq8y+120XaZZ0FIs11ZMUnERGLOyhdVF8t4n?=
 =?us-ascii?Q?hbgwBm9l7tcsv1Vxj6joQnyRZlccqp73Fu8JnU4xzsVkLnEtAYJEp+K11jA7?=
 =?us-ascii?Q?kRs5+yENFyg9a0E8CUUDT+oQCedeXbV9o1QtRJJ/0837VcpFrTTIBIh4vPoP?=
 =?us-ascii?Q?mNP/kwe4csqI5yjX0r2xFA6BD4FX4eUDRzSYwvvQ723SDxAGORm/Kug5m/SU?=
 =?us-ascii?Q?Fq9SFR2U7Sa0LgDPjmJBDixdM0U4SHsCkB8jTP8+wTURw4wGWBodG07OGKfz?=
 =?us-ascii?Q?0k4StI/32TNR1dMBRLGst0fYF0N/QNflZ8ngp71H+10Xmqc7ch1hqtHRkhSa?=
 =?us-ascii?Q?CWXnLRDDdIoxgLmkusLMoTzfpQGnuxfPDaoBZYOcrNlLnZYEOunn862zJlqT?=
 =?us-ascii?Q?SXqNSoBGfkfa6g7DwpM9cV5SwJ+tIJv81zFn7azALgoEBvxur0pZUWbN8hmI?=
 =?us-ascii?Q?Yiy4jVB3R7y8tuCJ3zuHIGuNagnnQq8DGYOvNw/LnQ2QlXQKyoaG6q9pFVqF?=
 =?us-ascii?Q?yqBzXPtKeU9W+lGzTlsYlCsuo7GUuklk/sqzyWJHF3euNUF+sqx/kkp+6kpx?=
 =?us-ascii?Q?rkLjeAGIOHdq8TIU3BLPYpDEXCjy2si24+ACZ2pBAXXi0waFM8R46J6ysPKa?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hiofgXPYeNTF8HHIiZ/1Pa8na8ifkw2wlaQVwKN3wGLzNON7ekfE6ubHpS00yyboRepAPkTCZt5mxdqEyg5hGrWxpzyYZrm+z4lBxhgYHlluCjNlIexOAj5s+F8pZOfE6fMn2Wa6juB5y02aiPacuIB7WbuJi/PLY2uoLPlUeyECZuLQGdkcikxuopZJc8mOlzxefwkeXpLT/gV1zN7Or9yau2pNBvdlI1X+tTjyQAP9J7yjeNq0h+otesCx8S1darDBDa3K42E0SNKGNgQJ42zN38QMgglm0yKb5W4JIVOKOTrVTVXGx5UzFLF6mWPyfsEgi5866d7O84fsgf3i/NQKgSU+TqqgVBriJihAqxNq4nSlo7GI4vw3k4eUYW8RGKAH4FxhZkYdtFtAeTI/VzbS7IQ/3cH4DmFzHfO4TuAOQjEvxGwzrp8MiE6q2ctceyAN99cfnbMBSyFUt2TWyxi+Wj21fCzm9enaLE0ibpOj8eRTLIymZ+E4KXBKWWB0Hp7C48i+J2gV4jpMlj/pmrTJ7yks+zvke9yZ4hZYxM6twPiqr3oSHQBrYNUQW8iWk4XQeyeYGPfPbZ2JJIh6jScfbV22wfyKJDLmnOlhHxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4db4ec3-c973-4fc4-ee30-08dc32f32707
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:38:29.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuiIMfWjGB+C+GMqVYwgAmKoi0pWERtP63F2tvtMgvGk1lavVc7Z1Fb5rjKrPpofanPC7XN6u/3DZaKP7ll8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_02,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=632 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210120
X-Proofpoint-GUID: gmiMlZNa8aOF7b2h0_fr8ALl32XFVy4h
X-Proofpoint-ORIG-GUID: gmiMlZNa8aOF7b2h0_fr8ALl32XFVy4h

* Yajun Deng <yajun.deng@linux.dev> [240221 04:15]:
> In most cases, the range of the area is valid. But in do_mprotect_pkey(),
> the minimum value of end and vma->vm_end is passed to mprotect_fixup().
> This will lead to the end is less than the end of prev.
> 
> In this case, the curr will be NULL, but the next will be equal to the
> prev. So it will attempt to merge before, the vm_pgoff check will cause
> this case to fail.
> 
> To avoid the process described above and reduce unnecessary operations.
> Add a check to immediately return NULL if the end is less than the end of
> prev.

If it's only one caller, could we stop that caller instead of checking
an almost never case for all callers?  Would this better fit in
vma_modify()?  Although that's not just for this caller at this point.
Maybe there isn't a good place?

Or are there other reasons this may happen and is better done in this
function?

Often, this is called the "punch a hole" scenario; where an operation
creates two entries from the old data and either leaves an empty space
or fills the space with a new VMA.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v2: remove the case label.
> v1: https://lore.kernel.org/all/20240218085028.3294332-1-yajun.deng@linux.dev/
> ---
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0fccd23f056e..7668854d2246 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -890,6 +890,9 @@ static struct vm_area_struct
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>  
> +	if (prev && end < prev->vm_end)
> +		return NULL;
> +
>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
>  	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>  
> -- 
> 2.25.1
> 

