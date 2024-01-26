Return-Path: <linux-kernel+bounces-39541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CC83D28E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC00F1F26566
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99378F5C;
	Fri, 26 Jan 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oww86wDh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ch200KRm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAC79F4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236158; cv=fail; b=P+s+F0G5wMAtVUBpgv69d3rnMAqVvB07lhHWQ+V8wc9lAieZ9i+u0LJ3s0L1XEbcYa03NhHC3fXgQZ38cp9EuxMhO8u9wL4OIGIkAkMmTWrrTmPRYQcIVl58TnOS6IEVOgXdok36ctwPFcAxzDfUmARkTxhPbxfxsR2q66TyrYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236158; c=relaxed/simple;
	bh=z0+t91QG5a6XAtnOct1PvForyTOXArzJU1YZFZvBJI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwBlmDfgvoFZTtSGy8JDYnPdPbjtNb2c5bn1spb+0/4DubzjreO4iBV07SK2Jkf6tOwoT7D9QG0tHddnvh1n8HSotq3jHdn/O6fFYphQAwux/Y4+G2Dq6A+I/Wke4xEsso4ZZtuUn5H1yM/UjqymendBAAR6EylI4x2fnVuvIVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oww86wDh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ch200KRm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PMfGjB009108;
	Fri, 26 Jan 2024 02:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=cafONjflwI/xxxOO1kNF7EFnq5sCBOIbnktxgRpCjOI=;
 b=oww86wDhodxszbh15Ib5RbS5PjRHnT2NWZ6pieZptkkGYP8bLldm8YskYdtZ/hFAPMMn
 ol+rNRfQuLvAQwZUkchHI+V+am2sA0Z0HOZukya2DAN56+1NkTrGHoObw3upkMq8ggzS
 n3nsP69HT6KXPMAJqbnAGc/9gPKCpar1UTfFW02tgoNzM4TBXuNRCUCqt/w9ciA1WwqS
 gF5wKA4tsz28pLVzdP/pGTSRSwUe1oav48epmhjJjCaPTc2CnPikH7TZMLIEtapS4yit
 vVZ8g2z4hmQQDyF754Fv1VMPlQWbM7TUMmTJT5DdOSAbZXcRDEvW9ztbjQrUKDussOWo Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ap1580-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:28:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q0FfKJ003964;
	Fri, 26 Jan 2024 02:28:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32vbmyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cygsEa15pdC+vF+VbbU7z+cEAEZlEt1a46UewOqxgvgyuuEu27+ZLb5dnahZwKF9KSVZZ1/xRcdALcFhdyPH1gHYXO7UWdbi8Hs/4c9oK/qTHwTaWJ0W3ttn257LaVtVXf/kwxZ/BH1mLxvjzLWhWbnkZweMKmTCMTbsbW3GoyUkznMke0FTXnZMjrcNH9IItAPAtYa9JxLWSN5wHBKBHY2HwfsV+dnzbh4C0vVsTDhTThPE1Y0oVGXppLeBwpkkfa83wLpqrZukO5gGjtRRb1vBYlROBqz9M/LSj0IkPXgOHQxT7BoMrtS4a+eL3tnwUV6D9Vq5aqL5Ima0SW5F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cafONjflwI/xxxOO1kNF7EFnq5sCBOIbnktxgRpCjOI=;
 b=Yn7d7wDQ2mVjD6S4KOAXLZCrlcKcbpQKAPFzQONftuOKGBqH4H91UYs4piktaT7QL9Mz2tkSvtcxZ4c7D7U18brHXk3bp95vW6b02eow8aaCFcP/EBCRDJm5rFAZugLdrkGMc+WtBaY23Aipi0t899JmrOoT/gYQBJFbUWhyvblU37s/yeRrxYFGVOYD8k2IT0nMHX8p2mM7AFZsPo9mp4QWXhv8anqBisH/t4kk2Qf3FZaXNob5+jzYQOpPHTgOV0PQ+sHx5F/d+xlJuYaO5/8yyr0z3PJ477qIvoBNMd2XDRFQ6kV+C27chIjlUA1Wd3/nIowYcXPZfGyanjmJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cafONjflwI/xxxOO1kNF7EFnq5sCBOIbnktxgRpCjOI=;
 b=Ch200KRmwHkyM24ejipA5V6vCGjoP0VpcKATrTEcXcEZQ0YKGZQ9dS33nEXtzL4Br7saNcFNpK4HKKqw/VODMZLUmwWkbeMSIyj3HRTlOPQ59Ji0pU+1a0hNMN3x+w7bu/Ss7nRXUN9GkdE1iGSuwsbifDooCdS6ktuNaQEZoRk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7666.namprd10.prod.outlook.com (2603:10b6:208:481::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 02:28:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 02:28:53 +0000
Date: Thu, 25 Jan 2024 21:28:51 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, lstoakes@gmail.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, vbabka@suse.cz, willy@infradead.org,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/mmap: remove find_vma_intersection() in
 vma_merge()
Message-ID: <20240126022851.bovcqfbp23jkq2zj@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	lstoakes@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	vbabka@suse.cz, willy@infradead.org, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240125034922.1004671-1-yajun.deng@linux.dev>
 <20240125034922.1004671-3-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125034922.1004671-3-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0258.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 2139d29f-09b9-4ef6-fefe-08dc1e168a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vyfo4MfD+zUmdoS0G4E2dU+Mbew/53OKy/CgyVup0ohU1CcykGkwekOwZe39UayiFIWV19bD29c93kvpR2TAmYoUkPhzwWCWEOLq/0a9Mey9HslDGgep+RyXeNwSi/OD5HE9qtaY/1+Zr3kHfcuieeuUcA1nsA68nHym3Xp5/MnPIT+XHgqJB+kJBs3eNtaIO7x4YltHm+RfnOkUJeRZzz1our62jHpg6ooR0ywX20YOQiveB1asM8Sp3gDXxC89y1r9yvBPOV9GydIOa7rt64SgPBo76SnraJ+Us3Y5YfnBcGKITUQNhXHcTdWWfGVeCrIUabyfzZsdKTYUeTN7dkIKvq+hiWIMHQSvnU5Tdwz4k1yP565ULTKYJAfuxGSrf30ulqpUeIUgE2+0gfnxpn4Z/qqUco+E0dFJIv0MLOTwfkDKb5HRf4LKb0Al4T82kAOkdT0q9uEoSnmSvXOzvEfPtJNm2KwithtcpCYrZKHbBJPLtXyfH+61tOkQ2EGZvoPuaaDITqgnPFx51VUf54Wb/LyA6gTizbTKLyFf0Gx/WEW/iRYvWhZ7pmPQL65p
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(6506007)(8936002)(4326008)(8676002)(316002)(6916009)(66946007)(86362001)(66476007)(66556008)(41300700001)(2906002)(7416002)(5660300002)(33716001)(38100700002)(1076003)(6512007)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1au2d7kdP+z5PeGWd2vWJufDkArJuVvE+GKRWowadVY6VGHQyxu0+xGQHyoZ?=
 =?us-ascii?Q?GEJtdq1LBypHulIt/fK5NmFGLhGgQAu+vOaj1yt6dJnB127wSj6FrXjHUER8?=
 =?us-ascii?Q?ZRRpIxPT4vHZxWq9YePQP/0dnah8pOupn1PgaiFdbYXEuy1p/ob5iqxXHKyn?=
 =?us-ascii?Q?1gLuM91XYOQ7nAjZveScTMn/cxzNp/WjkAAxQRkuRtsQYa0zXIybREg3zw8t?=
 =?us-ascii?Q?ZEkS2Kv268c3BCimMAlBymdemmjPh6v13wkGkL2D90zorHdQifBVqCLRIDhJ?=
 =?us-ascii?Q?sXF3VTtfx/+1T/Q0ujaIioTpeLXBlhfH8O+FBZAOpnh2shPfuFlb9CasuESg?=
 =?us-ascii?Q?2rVSJTqQnN00MdF3/QrkyFjXjaK/VfV7HXZMQxWOX2RBnJ/lFqEcdTVJdpq1?=
 =?us-ascii?Q?gAMG6+555vnS/rI9oYN2rGaTi4AVWeUERfiW7ct1F5wQnFU1xi7w5LkgcxI0?=
 =?us-ascii?Q?e8UGfS1ea4bAnzw+21dO5H3Kob34gQM6M/4LuX+d+jPnHFV2fd64qhhORg5K?=
 =?us-ascii?Q?TK7g2/LZ2PVKbQZ6PCyW28kKvNc0tHysJ0MxuVpkc8AggaHhvIi2AFGOp5mS?=
 =?us-ascii?Q?yjgwoVij8xVkB3qNPu+s2hDDAacjHyVsxwUqA1fhkUeeIPLPYCIVf9oFAz2m?=
 =?us-ascii?Q?pwWMhau7aa+LCqj+7ue1eCOFcRYmWqY45pSnZNAOMvXGY4QUmugBv6Nxr2MW?=
 =?us-ascii?Q?JfecXzN8Mpcq/XzKtffLDmnQ+AlAhopTtr7jBJcLDD3/QtZnlv/Krq0JXN/4?=
 =?us-ascii?Q?uliM020iVT2uoXhACFnc4qH1TpUQ4m3G1E7a2RMiCwz+98xl03qGN4YV07ij?=
 =?us-ascii?Q?Uiwe+pT5seFQsMNJlUw8Qa63ytl8u2tObsrw+3dh87BFArPHNJpb63nNbINI?=
 =?us-ascii?Q?QjGcOkDC3yUM8GTUghTUUIoBAWVKUE6s1A2UdxjPYjJ5jkU8GvxUMrn0ABJS?=
 =?us-ascii?Q?v4jw0zcE8e+C/YvQ0TXH7wFUn175xeHGDe9H8icFZGKw9pcUOfBqxHG8RFm3?=
 =?us-ascii?Q?td3wpI9v6DvmrsFvn+11IqkjQjIp6kFoAm7T8XpHrMxj8kIH1gv7Wj2zHcXX?=
 =?us-ascii?Q?k5R9yzYpiWTNwaEMuKedLh62ixUCeeTuxvQPrvjKhHN5wtj6eebILP1az+gr?=
 =?us-ascii?Q?vacT1LGplUYYtUYkvi8W3a2Ayeqka4CF3+aRhi6wqBgUbgRykFa96xbWEyOo?=
 =?us-ascii?Q?Zd90dVEwUY9WOofIpUywknwV24cR85Vprx0VV94U9MXfsNmA35jWO63ZUoMy?=
 =?us-ascii?Q?2yj3W/HmfYM3ANyr3rpKlBdRv3Tsf8BvKZ+/TeOMhcLJTXKWi3GPyjN0yIiJ?=
 =?us-ascii?Q?cAzHQ8LDN+4zz6BSo0sA2mH3OvQrtgkH/CP0WYaBS9bPTgkbRWutaK2YXuj5?=
 =?us-ascii?Q?WhDnhEeIjRjTiTsjleNuT5DlH4h8VSxG3XGbku1gwFnIUocVowYXSDajVOKH?=
 =?us-ascii?Q?4lGNX0zJjjSn+fA1il3xqn7jNStRIP2COPUYZfFfcHd8W6SL4mm/oR8X+KDK?=
 =?us-ascii?Q?q1YgKKXi5wkVsAkLB8oZRloAExCECAtQpsmVjO/lhQzwFNq61EVs/MYM40qc?=
 =?us-ascii?Q?G4XPZwwVytnHlJbazm2V5oneoy/IwDiBQ93s/o8q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NzPqIPHIgucYCvNP7hU4L2BplxMmbr+nJfegHEjPLypDogVYpCvqjwPbE7wp1alb7LgG3cPaJyyL29BLqXji2+nRT/Fuee7VLNamtCjjVsomaljgVe+VeVnoDpxf8U0qD2cokCKYTJf4rb1SaJVsgLF8rVnF4zneAx0H1cB3LZXl5oji+RxAfBwphB6yz46NsbuhXgPW/ri1clm2PQ50kSyBFW4Jj3VIegG7QjlYIEE+x9UviTH9MWuFp4IufVfBez/BAlrIcmoWMtI460UiAagtsI3GPOz9JPr2SZ/y0/jGRw3DFMilwjC5Tb4QMSdRkwSjWQtWYl3QOkCGWayawf81ewYUVPIaypDIRcw7uPZ2x+RJdNTWr9jmHrqhcgTvgvLaDmk20eoo1i3fppoAA8IbU/GrNtsEmKvrEdMfr6bQwS3bOvC5sWDZmrGNZSrRmtl7IkbmC7AAXkTuPoH0TyFc/zVnLt5upMKIST3AWxdaJlKoKBSWLnPxX9ZHAnwAUL/IdNUSHKZPrHKUiCTaMo16QBXRdgl+p7ApWUru0BxHRqn0SVvQPPBRZIs7SU25dtnL8nNR+p5HwjErmQGa8agOuDeoj0f97rdJfnC0AgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2139d29f-09b9-4ef6-fefe-08dc1e168a02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 02:28:53.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PJ6lNkr7eittBkRUnuY9SYxHieVv1SlYtTI4uGl2VkKwYdWjzrvGCUVc0R46cDulMsdVCCUifYodVwTV+eZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260017
X-Proofpoint-GUID: -IajgTxUzyHAxI6FNRd95loKvtUYLmIU
X-Proofpoint-ORIG-GUID: -IajgTxUzyHAxI6FNRd95loKvtUYLmIU

* Yajun Deng <yajun.deng@linux.dev> [240124 22:50]:
> We need to find the current vma by find_vma_intersection() in
> vma_merge(). Since the src vma was passed, we can add a check to figure
> out if the current vma is NULL or the src vma directly.
> 
> Remove find_vma_intersection() in vma_merge(). And initialize the next to
> NULL when defining it.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f19bc53bc08e..ea02fdc91aa2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -869,7 +869,7 @@ static struct vm_area_struct
>  	struct mm_struct *mm = src->vm_mm;
>  	struct anon_vma *anon_vma = src->anon_vma;
>  	struct file *file = src->vm_file;
> -	struct vm_area_struct *curr, *next, *res;
> +	struct vm_area_struct *curr = src, *next = NULL, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
>  	struct vma_prepare vp;
> @@ -890,14 +890,18 @@ static struct vm_area_struct
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>  
> -	/* Does the input range span an existing VMA? (cases 5 - 8) */
> -	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> +	/*
> +	 * If the current vma and the prev vma are the same vma, it
> +	 * means the current vma is NULL.
> +	 * Does the input range span an existing VMA? (cases 5 - 8)
> +	 */
> +	if (prev == curr || addr != curr->vm_start || end > curr->vm_end)
> +		curr = NULL;
>  
>  	if (!curr ||			/* cases 1 - 4 */
>  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
>  		next = vma_lookup(mm, end);
> -	else
> -		next = NULL;		/* case 5 */
> +					/* case 5 set to NULL above */
>  
>  	if (prev) {
>  		vma_start = prev->vm_start;
> @@ -921,7 +925,6 @@ static struct vm_area_struct
>  
>  	/* Verify some invariant that must be enforced by the caller. */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
>  	VM_WARN_ON(addr >= end);
>  
>  	if (!merge_prev && !merge_next)
> -- 
> 2.25.1
> 

