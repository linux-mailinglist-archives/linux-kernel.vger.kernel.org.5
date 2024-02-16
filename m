Return-Path: <linux-kernel+bounces-69353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C608587C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ABA1C22D70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270414830D;
	Fri, 16 Feb 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JG7/bw9J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CvJkzwvJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AF1468FE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118032; cv=fail; b=RMaCbfPIcVqu1rnVarE6322xzFI89GTDd4K/5xlqCzt0IrQVDkTDu3P1KM8JzHOLLiZA6C2Rx9wu5aCbITeKzlFysNzo4HW5RjR6xMi/zXSmsuVLUhSMO/23dD+tgB5FcjqzKoZa4zNSguOOYCA+J7EXZWo8HUZWuFwTFiuv+G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118032; c=relaxed/simple;
	bh=3zcw9mfZYh8b7AeD2C+BrgEKHUQLVgfDY19NUnakl6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szJWJxg4nsL/ylBMDpAGrVtKuFLTtEsfPI5eeheemn67mAWRzAyA87mwS0xLdIeY+ob63ipCxM3GL4cue+mw9IU9mSmKAYq8sIJB1Pf3DCZZY/YqFvmSBLoixo7ag/LDQq6a9jbkJOUGBpg3SKsymQrzHkaYJFUWO8sTnS3CvAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JG7/bw9J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CvJkzwvJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEKPo029625;
	Fri, 16 Feb 2024 21:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GHBrn3WQf74ZkfOmgCt1XexJieU/u7v9XU3QWsuaYo0=;
 b=JG7/bw9JixlgB9jkO2N1Ps+5ZoF3Ge+lx1l98ZXKcvY/2Ir245T83hxBoruYT1OTMy6y
 z+wGCtUXN2CqFmDLpQI1+KrkhB/n+gexpEnckQcwVevwjskW3TAnXc4MyiEaLQ735wtB
 pMaEZclBXoItxoU0U07vr8wnLxaL85sGt8kJ+S6f8qKJS/Uv54TJ/KGbv+UjmN76dlGh
 TQptkVKnvPklvhrVD6ewZu77cyTvfdRGbhzVh+C6/70AmDfn4Bfbbrz8U3IUX5Q7fdFQ
 19JxO+CdTDadCGRDGIFPRAaw/lpKf3YU34iJOcr+gUguEExAuyT2sy/NgABggwRgrnKO pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f06e5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GLAsSa013780;
	Fri, 16 Feb 2024 21:13:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apfpfx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEqN6TmSO/BcigAkqZ07or4Jf9zdFSiNsVzL8cjv8iqYRfwxL2HOD+KZC1gWLTWSQ/V6iXgqJ/pYXzpcYbTy1MBtAydjEe9TYRNafURtlaDG3/3WS9egYY6r3CGVW7+GQRdI+5xMGUzMmXHkbkTmF4cuNrIYYxNKbOYCs6qrJ9sZAPt7lYWETJaCkxbB7d6srStpjKzJIV+OUZC/6ENXp/y1w1+YPkYnQJcqJs1dJ8WTxt4GM1MKGtdu+pXaPYTftz0+J1mLw2FvJJfy+1NK5J8X9aMRxf9eyGAgZ8okAUo0BAO+G5zvSWEZ2LQflmX3QDRg72z9Zxokto41sqqXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHBrn3WQf74ZkfOmgCt1XexJieU/u7v9XU3QWsuaYo0=;
 b=guf6VfFg5ZT7I9EOIPsnaG5aMTtFoB7Vm6jc0Z6ZVv2HCihu+6t5dYlD3tycYe+y3jwNoK3YK8o8J/jw6h/Q/wTe4szCKvsUj5DaEQJ70C3f472Th8O8d4QC9xZesdKBsvUxDsGyvh+RyvGjfQphqdgCR1quDRrvaY/V5sNfgJ0Ng9fcy2TSV1DQCXEF3s6EHmHOLT+E1P/RoH0hnnKBZ7UNMEVbQm2sp3+/9NCHO7cIIAC0TNpgHwGGzuZ6O3DzAVpoCph38V7YgDakd6kIN8w7m7r00kkFc92wXflsLuWrZVmOq184fxZA8t6chu2J75q0j8FmawEIp1qEnAvo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHBrn3WQf74ZkfOmgCt1XexJieU/u7v9XU3QWsuaYo0=;
 b=CvJkzwvJR+kZcis2CMbzmRdiAymSH40WMVZWaI/8GPLuZBwNPz++VLZuqfR28rZi/7z9Qd7E/2cHAZiOxq6r1dGbrVhvkpbJX34Iv5ZUl6o29+QgTB1jdyBKz20xOlascL5kJBvAmcDgIXbfrMFFJofoRKDTIbE3O+plFXNQDDk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:38 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:38 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 6/6] mm/migrate_device: convert migrate_device_range() to folios
Date: Fri, 16 Feb 2024 13:13:20 -0800
Message-ID: <20240216211320.222431-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: a80b552e-2cb2-49a6-3b5a-08dc2f3424a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qdF14UNC4iLwJhEPWWS3XiNv+USr1o10DZP68HSq4o9D5BZd/yWx2cO/mIdzQmeXHDSsH3lAZmKWsoFabjxBdhudC6CZW6q+T1rQkWFCt+w4QxJqCnI8Jmgvp2vflIXuWWyDlrEPeau6xIk85SMXMyH1cQ+8Pji57Km2QIb6/J8w4KPGA429lQr3idVNoXXi2BEt/7vsv9x+21S2C9x8KVBcy40TEkDHOdxSbAr0lS9HNHYjD6W+wXsRgXyIzjKPQ+zllcAXHCv1Ch4yprEoVwj72iM43ij/wg/c+9MdfX2nAkmZwUrsi5O42BbHvwq6LfeXuZJIRfkUB1kHkrMxUB3v3cMw01DjotnH248QCBgwwYfrhG2ijU93oPgrEb98ekv8TeZs+hrB3ELSuNKbVw63hBySqzXw+bNqqAXDpqibYchbtaV9uXNhdjyXn/0jJmwPSvuj79IeJDO47/lswufGlgL3TJ0epmCaepQqjjrgO53O62A6dlAKRemc1UbZ/UVsrJIrYEI7RfPBQsh6cRX1rtbM5kB7jTP4e/uIzyqYUsg96pCN9oA/nibK94jf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(83380400001)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(4744005)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y0v4x7AcUELOXDmidVcRvKpAqyvtWiFqd6sv7DdPiFofAk4GVbisveEXLAJ7?=
 =?us-ascii?Q?dMOea/odvvc+2cOvrD+LNcKbsTZl6GJ/Ubqzro2eF05WByRZkXmfsGrsugfe?=
 =?us-ascii?Q?gtagUdRVvsYDKO9UWPzmH/Kg3itUpn7u7+XLuyTlgX96mZg7TRWAJvb/gnbr?=
 =?us-ascii?Q?r1gVvO/w4RKBb+R8DC4B+qecjuFsXr8TZ5zXTQRKnwQ8jZmBwZKEtWvwWmdv?=
 =?us-ascii?Q?DM6WoKwlb+7V3OWqSE/CdIrBIKYDUcm+pJ4EzJjgspZSUKKgfCdPVMXqRj+3?=
 =?us-ascii?Q?LQHLsMXMzsEVEHj6gnC+PVsWqFUreiIMnm+YQ8UQWbYXnzOCMTrQcPTei53/?=
 =?us-ascii?Q?U4XzmDmqrzqGp8pOQEcsktYKvS3m0Oxz3lZRngHqG/RLP+JxbHX1baiJAGpn?=
 =?us-ascii?Q?+DyP8QQNGJx0KP8QfyWOMWP8Ff/gaoOmLdRep8uddlmkOdqo5eGT6ww1ezvi?=
 =?us-ascii?Q?8ASRucWewvHgWsOz9622fuQVIuLt8opDnih7OubqOvUDyD0ITD/QFgT9qOpb?=
 =?us-ascii?Q?DA6een6d9YRgE8TEJRJNi8x3dItiWK1snR9bL1aMPaF/2nFKhGO/JxPpiPrF?=
 =?us-ascii?Q?ZQmRqrY8mxUTYKiMEcENp+cerM9PYdfV7g3G9aBtCihQl0dZbkXWLchI1prE?=
 =?us-ascii?Q?vPqY6zR8J9Lqj1e9XGbOW4gnufC4AG3iVnujp7KDnxZWPDU11jEpCYtlo0AY?=
 =?us-ascii?Q?eHwZsH2HG541EUx2MJim1SGWkPQaC/zq02r7OVKi/uyUPF84EU7z+f4kn19v?=
 =?us-ascii?Q?E4Di5dCNnI2GYvt3Sy3vMgGgrk6e3F1qvEl4EAS2tEl/vhQQXWeIXhzm3Pnj?=
 =?us-ascii?Q?WNRzd51As8bvMeKTxgKfJNR5TXdFltK5cFu8dXiCz0NPdlXeTxt/MjXJzEha?=
 =?us-ascii?Q?ugjHZrAUpH2snTpPMrYksnoSmXFivqg658Yni7Jddb7rNhpjNqgp7jwkSKSD?=
 =?us-ascii?Q?oKEDi0Hg/jDjpO9aOwc7rrIbhp0XB3bCU9DjDxJI68xAzSAl90SfvuahZOoA?=
 =?us-ascii?Q?AHBGh9oJVjeU6bPBbzwCQNmj8Q1mnRZVOkqNC3Ic9rNA3TxaXklWBSSkHQoi?=
 =?us-ascii?Q?bGo3CWjjjJLk5sf7YpC7QVv5oHaQJPhVVdZ+FmLFI9DILpHEygOQfYzuCTuR?=
 =?us-ascii?Q?NqZj3dXP7JJ7IqA+sP4zYt8+wAQugK9Hn2UqunYl6CWbuSqvTvtTxvX6GBMR?=
 =?us-ascii?Q?WaeKnxqhGUoTh1IHAWUxFfpFTV+k0ZlWWiAub9299nMw0XQxcrctSPBsWZGl?=
 =?us-ascii?Q?U1QL6t2FQv12N8+lddw2ejGcnthRA67iTN+hDifF04cRmALi9BWjMzsGfrPJ?=
 =?us-ascii?Q?4eiaPf4C+Bfvc8aT3Ahc6duaG7EnauI0DivO9QXEpoUbi3l2ZYi0WhfkuSXe?=
 =?us-ascii?Q?JgkAN4tn0ki4NiTLD23NNAe1MzRZBHx7PcKpUbvtB8ax/bpFjudHb7EADiki?=
 =?us-ascii?Q?1Klp8hi149yCriokPFmff5nFfKsASMacJG23YLJwGcDb7jEngx3zVQ4htAEO?=
 =?us-ascii?Q?eq51rbTilZbqQPOlV+D3a6dWlXlmQN3emqzGm/yVqkN4Y15gITuau5xg/Mi8?=
 =?us-ascii?Q?tOqA05v/kQ3pJDy5NoGPuz/OAfiuUVqoB/1lLeSrBPR2JVIPPZwcKUbhDaG4?=
 =?us-ascii?Q?LWDDv48s4zg4noaMvoAjZiw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RZ61GBIEoJ2uLaGmrKbnRiTfUoHhYGLCHiPoh0Z5GfjQxHNgbcjsRrzy9rl3y4TDvGyr7Zt4oGyEFwY14J7yizmcoN/3DtO0RrtS/cUu0siqeas17ULWWMSPKI6FneXJ3S8Zk12bnfWf+wpE6ULLiXJZQQ65HyQ/Sc2Cq4zeyVCMBaA4KKfEUyHeWVUZ1IC87/piwvDJ0iRXu+8MdDU7eNG0siLNtKbGvkuaChqiewel9s9bLZKQjEoEBlEmfV52L2Pl7FVWUGf3XdtAD5Z+MtlxVN76oe5H6bGCnp6Pgofn3K+br6CEDjUKI261Ucyeeo2mJ14tCTfV0rE/dCUFjNfvZoCjRghtuHx5im1p3ZCvlDpSQCJXMd/oHXeVJoxU8HcPttdrjsZ9+JrTsDEsHsc40s9n/8xubHv+tLVSEhtWfXuOq2KzrL22vcHqZ+AEK8J0bTILlNW9plHazKoQ2DLfmYYDA2SDUMQq7GuB+fKtbsv323RbPPVgKLUapsCv5d9zL+mpeFI//e37pFVlNSyNAobtp9AXgBILcnaZbbDqTVjDRUxOWVoVy+d980pjQbJzwegdKMF3ENjy1RFC1PRY15vDZlShhUKUKG1jQm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80b552e-2cb2-49a6-3b5a-08dc2f3424a2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:38.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea1grRmPVkNyKloGVj6+nj8dY8Gt8OKuQWUKmAS2Lms0xskXr3VU1uQnUKsG8YFrm+U2XKINnVJvuyt63UUSGkylUASktt8GkYh4PR57a9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-ORIG-GUID: gt_se_bBm78GGJLXdfZeJ4TRBRua8Pnh
X-Proofpoint-GUID: gt_se_bBm78GGJLXdfZeJ4TRBRua8Pnh

Use pfn_folio() to get a folio and use the folio equivalent page
functions throughout migrate_device_range().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/migrate_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 5c239de0f08b2..0c8d86851e631 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -888,16 +888,16 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 	unsigned long i, pfn;
 
 	for (pfn = start, i = 0; i < npages; pfn++, i++) {
-		struct page *page = pfn_to_page(pfn);
+		struct folio *folio = pfn_folio(pfn);
 
-		if (!get_page_unless_zero(page)) {
+		if (!folio_try_get(folio)) {
 			src_pfns[i] = 0;
 			continue;
 		}
 
-		if (!trylock_page(page)) {
+		if (!folio_trylock(folio)) {
 			src_pfns[i] = 0;
-			put_page(page);
+			folio_put(folio);
 			continue;
 		}
 
-- 
2.42.0


