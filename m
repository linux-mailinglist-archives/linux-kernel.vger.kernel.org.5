Return-Path: <linux-kernel+bounces-34446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C96837AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737B21F23181
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67561133415;
	Tue, 23 Jan 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W5tLcFP6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u8cemDRS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47664133402
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969128; cv=fail; b=NJyvn3pKDu/AMrY1o50GXdxeE40GD4HAXpXW0dGTocZ3dBRYAQc3MoAImQiuhG3FnBMjqMqh9GVF/qI59CTADfvY914BSXdKh2b3Sxu2M2C33dLqWm0p8D1Y7zcIah8WE18vQAaYc7Myx/e1wQ5Df7vxgRUHuB7bJkyLCyD6gjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969128; c=relaxed/simple;
	bh=u0luaJpNMss3tHkpW4a5JPjSdd3mOMifSJZylLOYjZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6s2y39rccS8uVzKOU53otiFoRnmar/BQd/9AxSmF5JI30kArV7LrJZeMSxvanWQHBba0EXd9/+9cB3e74r31HA3N7LK8dLts+yPD8A4740sI7dZV3QXvBBRVtVah4japkLxPqMaGhHkX4hzvTHcwwmeVy/uH3zL3Rv/P9LUjfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W5tLcFP6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u8cemDRS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoiRG026562;
	Tue, 23 Jan 2024 00:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=RwIYjZx+0HMVDYXdzj9GHabIsF9hqvpfOnMl7VIdl2g=;
 b=W5tLcFP6di6SkAe96SDLyWQrd1MHuee3AMuivdtxuz/vFK7Gd8fJZxF6ILe8VCez57Em
 DlpYJB3aPZLOIZkql7Yhs2Hk7BCi8PdRwJtarBl7qQKPf9XoMmifXtIrb02E6MSxyb4X
 NrVTd4r/sshXsHuD5rpVl8pgTpfUSLckbhhP4OfKaSHPcNMCUjv9S2wKcCwvojPJu/IU
 QwoMGTgXri4aGZ0bdy64hIimnqjSpl50edTfb6XAJycrPtGxFPmzoCdftWu6IUNjf1wx
 yFLPExT0Y3Wh6sLwaJ6uWr0bkjrN/slfeXaljqFkWqBR85AfVZ3dzvKE6K4RWooB+M16 Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwcyeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 00:18:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MN0Nmb016406;
	Tue, 23 Jan 2024 00:18:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q0kx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 00:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7YsArbkGFelKu6xpsPIm6NdGZY+tvbIoDFjIdumG+f2TMQv9fxr8oxP79Mxxig3a+BXL9p+gOlFGgnMcV9JLIiOz7xdPN1HmZTKxP+/VKtl4swgpcRR6RWLeJCyOho3WahSyBk4Wn2hI8OV+4nyJpVuRq0fOUbqS2Pn6fA4YPWvlFBlUQc/dhUpdfWJo3Q/60q08+jILkeKne7o0v3kQT/kG7tHyvpTMTkzlkvFyAo5X13Hc4tkTMPnrfu+jGwKW8ue4u1Hzwrcta5gRZvahwKvBg+sp8hYAhRbjrzzPv06bpJlqDEahf6KfyfpxcQSOukouKZBOP2LshmlXGZldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwIYjZx+0HMVDYXdzj9GHabIsF9hqvpfOnMl7VIdl2g=;
 b=IlSnIrTjdthpPOTW4BkGvinHmITKjuOOvNLwwvOpY+2h7akGvB8QvEYzeZS5+M/Gq93i9IK0XQAL514wswd2jiK+Anar3Mz8b2Ypue68LkXnoXn132CW58KWhc0agGNEJt4gBLsYU0Cp9KqEI1Um7gau+qWx28yZfms51WxTWAPyloYp6Cj6ObA8ILpiOdAarT1urMY1XsZzxaxa6uBX52E4dbELjCNS0xj3lf4/Vz0/1yWBmSjBXBHg50QBxRZiDWAz1yKAPXkvTgiNgP5e7EgV8KyhvQGzC9B+GFMbVdVCMSXwoOMgzPLDkxUaGPlmmEzf4hZjz0S95IrWam9N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwIYjZx+0HMVDYXdzj9GHabIsF9hqvpfOnMl7VIdl2g=;
 b=u8cemDRSlYpaiLKSXJV4UhCujS2dziyKcEj3l+dXaZ221tkvBX0b7/O60/HXWINDKMlYSWiVd+KIMi9evLWSlDVraUQLFHLAKgh7y2VE0uNikr6JOD5JJrylXIN4e1LMHWQdQNmNHvFy/JPQT5KDbdz0H9orry7YSwk/J348O9c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 00:18:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 00:18:32 +0000
Date: Mon, 22 Jan 2024 19:18:30 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yajun Deng <yajun.deng@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Message-ID: <20240123001830.glqdmrv2qc56zfpc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yajun Deng <yajun.deng@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
 <20240122220031.pwiravglee7o7k34@revolver>
 <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0ce681-6d04-4775-7358-08dc1ba8d4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SGjgJVfb1isW1abOh6sjnDH7HJBARu0HFiYOzAYR8vCdagzAamxcTcKhAHUqPAQ4PvfZom8nSymbjh1ThtVr1lh4HmuedSHfVLMLQFDT9VkO6YTb/tyRm7yLt0BhRUI2gsgiDCk1FJKpwROKaKo99pVeQ2T7tKV/XvGSYA8YbDmeNeIO5+1cY1VqxSpBCGu9OlAuLUWxtd1JftvQuN10sxsBTpWnd7Ds3baAwc0AIcA4v1g/RcqmAj7nnW0F5w93hGbf6VLNeRgTOlna6PemjQNcX0Y4ZnBtiq251J6FCz+kRaFl+ibCN7fj8OL3UZjEVDxR5llhtaqX8b2YH5MiedRbDVwhtE8EsDzajCskBKkSkBcWhJtONuDJOSGVpH7ivQRUGdOr17KzsTZzY4gZ4rdxupXHZu0T89FD7XqqmyVirJx7CcvkoVqwmDvUygWyp8V3vdquASbuUxsvI7bcyxRlySmN1JyS95kVi57eIeudtO9qo3XTJ96RTrXdz0H3tlCmWD0CRxiK6s+JlFsvCP09P3MAtI1RCdTkroixgavMl1YzTgmCyk8IinJSF7JW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(8676002)(4326008)(66476007)(66946007)(66556008)(2906002)(6916009)(316002)(5660300002)(26005)(1076003)(86362001)(9686003)(6512007)(6506007)(478600001)(6486002)(41300700001)(33716001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EkBZuwfsmxnQd42EgKEhS+B2Lz/ylRgFn659ToDjSqAXRAop8inmGh9itLNi?=
 =?us-ascii?Q?r90N/n4i4CcwXjz/tinhBWzzoQc+hIak6or18yrgALh2qqdC9khde2LDEJeT?=
 =?us-ascii?Q?AkhxvMomwCm3Ri9biqhhPBYWdwpkVY7DZm0NfWKUf4FTeHiTnuNhhI9w0gTr?=
 =?us-ascii?Q?bjCrPTmF1DArovodgD9QQJffbQ7HUgHHUgn8/Y3PTEJWul8Vl9gIZIPSKLft?=
 =?us-ascii?Q?NFIDuBJEQmJEtU7qHKbg1e0FlKlAi19I5+7AxzUYLWMdb57UGWOP9odyePtL?=
 =?us-ascii?Q?4QAv7HmgsROIInG/ffA8WlfipaPYVvo4et0wxyMFS0TEOiHj91rM9wbY+zXY?=
 =?us-ascii?Q?HNJSmof2gUAxMfYS0M7Ot6uu7EbAk1pUvCLfDrb6YRUYXtxTqD9jl+09MhK0?=
 =?us-ascii?Q?NPBEGyHFL36TAf0xViaNCywEZkd035LBcXEgg51U07VaDezLvTWQr6BCzTC+?=
 =?us-ascii?Q?3pMYvuvlBorT1D++Piq4vOazwy/DwzS5EaTN3hd14iuHrgdhqHyPxzUboi2g?=
 =?us-ascii?Q?1Ynt1/GLDthVwIQ9vWGQlf+stAMi2kYfttAs34+ekc9ggjt4DfWZWRoI/5SI?=
 =?us-ascii?Q?kQ8AuBMRCV6+IuRRrzSdKC5ipCt0NRZuiMcXKcl5U1PdSY05CoQSScwKnOpC?=
 =?us-ascii?Q?+XPoPXbGtktWL3rrIBV26lTdPv7vNktMzC/jOpLkl7VN6vItu46tutUovWlg?=
 =?us-ascii?Q?kjSJN+sS62lRXv3wfPwSOpFqjgieMdAR79gFt4KmrtL+yHcOVGSIHahKm3QS?=
 =?us-ascii?Q?M8PEWyBqV3zxxmcygvG99x+t4/KqmuoJGOQIUfj2n3GEff/HMMI+GLIchdOU?=
 =?us-ascii?Q?RCTNA3Zj2CQjNJVtLrYG9nkJd7v0m7+cB787b8fhhwPYizMmzVBP5qqZFtPz?=
 =?us-ascii?Q?4sXW7Khrw7g8JfmJYRkRscVo7Q+r8oTk7e+w44+gu53WjiLC/zdjJPOw07Dw?=
 =?us-ascii?Q?n5NBQj4cEzXtCTG8SOG6Xu16JZHXhjHUanfHXpkPds1MhOSUDXN6Ml7hYlYQ?=
 =?us-ascii?Q?FmIj7onafo2XSPpRfxpsPmQFONVJmd+qfsgynAZLylgBueB8XAMdNr/u6/vp?=
 =?us-ascii?Q?z2FIgQ9UvweMCX7QTmXqnZpk/hQQZeq7b1oEwOFAIezdgGZM9rB/drIDpRzm?=
 =?us-ascii?Q?n91Oz19tv6kSOoxU9tA41p6XGF0NKZHRSQiNVI6zdUctMTCOvjUMnd4rvtQ2?=
 =?us-ascii?Q?5OMMWumwdnG4dv1enX/uEWkX6EWZzN+RbnZHH3j+fgFKDh0a21tFBO8NSOCB?=
 =?us-ascii?Q?cnrQaXWmOEgDLmxlxgzdcrzI7WW7CqCPDd08GVbdfazdf2h6vT7BaFkEN14b?=
 =?us-ascii?Q?Ww5DSRFldX8kVQLhXFepzT405MnzJhDwDT406qaURPCIT7ZLDZwBkvsXERu1?=
 =?us-ascii?Q?VwjBhaHywbDdlhWqp57X9r08BPkSLSc311hqTqCu6hC6UNlWzHqk4+n67+wq?=
 =?us-ascii?Q?4Tfw10e068npZ0FfCTL/4B2rLPPJg4XLpYFJ0TwxnGLCMpHjkxeSwXcQmDIg?=
 =?us-ascii?Q?mFqyfHPnYuOf9ppBPHxnumhjdJLoI5XKKpVWw94Xze9++9QCSppW6d8aCVEQ?=
 =?us-ascii?Q?0V/uQpbNnuiZMx/I0Xx96qEyubZxH816cID1RoQf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mzJ46xZKvLmLhSqkhb5kpeOiH/NXjL26w9jbEu/hVyxzXIJVft+d+nSKoEvJTC78KRNjPhL9RzQ3amcGtdZKcFKaVfsw0+htJcaIP5ORyQAIUmHwSe2TDuteJzdu61pbgWQ0oxppCVeIViMY8G46pdrG6n7CurSR/V8YyZiuuN1DcwMpugKTJI0th0mQwFmN1hpqHpI0XZ2Y5yDjduDzXHNK2U7nUF2fQZ5GofpwrB5f+yibzCm4LNN4O1HlrLVOJUV4xl8MeotdU202qAO83T3a9Q9l0lztrsxa7NC06sgXo1xhGM+o+vc+0x7wQByCb7tYhBUdcCJS+/g+K20Q1OJ9TOvct4XleigzPX7FJHL2nh+n1japhLqwT/EsHyH0ZSMvKKD3vKWFuuAk3vRzVUe7IFA4a1AFEpAO+kk9I2BNqi5/uAf8QZR0gWdFz7KUesu6wxlGT/KKItt+9+9exZJ8qdR6j9fM9lnpW2ncKBfR8Iez05K8JWX5HAAxDA1FwJbgZ151RryXw5pkWieTNQ1y9/rjXY1bjTYJacKn4iFU+/mbDC21PM03byXlYVEJTUa1eqcdQL/83LMVgoNreZE5uFii9YThJwBNxgmM1/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ce681-6d04-4775-7358-08dc1ba8d4fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 00:18:32.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvzPUY0fT6MUUOjLpeLbu80GKa2p6c7rX3mQugYOggaifuOqHkG0l5Z1xtpwdMCFxtUNbSoU9GA64XlywtfpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230001
X-Proofpoint-ORIG-GUID: Q1DlWZK-eAowavQ8lECKuoAAAP5-ShOX
X-Proofpoint-GUID: Q1DlWZK-eAowavQ8lECKuoAAAP5-ShOX

* Andrew Morton <akpm@linux-foundation.org> [240122 18:40]:
> On Mon, 22 Jan 2024 17:00:31 -0500 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:
> 
> > * Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
> > > There is a lot of code needs to set the range of vma, introduce
> > > vma_range_init() to initialize the range of vma.
> > > 
> > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > ---
> > >  include/linux/mm.h |  9 +++++++++
> > >  mm/mmap.c          | 29 +++++++----------------------
> > >  2 files changed, 16 insertions(+), 22 deletions(-)
> > 
> > This isn't a whole lot of code, are there others?  We're losing code
> > clarity in favour of saving 6 lines?
> > 
> 
> Oh.  I thought it was a nice cleanup which made things more clear.

I'm not totally against it; that's why I suggested the changes below. I
think a name change would go a long way for clarity. It's not as much as
I though it would be though.

> 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index f5a97dec5169..abb4534be3cc 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
> > >  	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> > >  }
> > >  
> > > +static inline void vma_range_init(struct vm_area_struct *vma,
> > 
> > Any reason this can't be in mm/internal.h ?
> 
> That would be good.

One other thing, do we trust this to be inlined correctly by the
compiler or should this be __always_inline?  I'd expect it to be okay as
it is, but I've been proven wrong in a perf trace before..

> 
> > vma_range_set(), vma_set_range(), or just vma_range() might be a better
> > name?  My thinking is that some of these are actually modifying the vma
> > and not just initializing it, right?
> 
> I'd vote for vma_set_range().
> 

Using vma_set_range() leaves vma_range() or vma_size(), which could be
added for the calculations of vma->vm_end - vma->vm_start.  Davidlohr
suggested such a beast a few years ago, but that one would need to live
in the include/linux/mm.h as it occurs a lot more.

$ git grep "vma->vm_end - vma->vm_start" | wc -l
198

. for just those named vma.


