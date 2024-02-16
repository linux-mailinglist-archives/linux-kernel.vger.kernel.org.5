Return-Path: <linux-kernel+bounces-69352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75C8587C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBD2820DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822F148305;
	Fri, 16 Feb 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdPOxaJR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ib9k5B9A"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072B1468F4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118031; cv=fail; b=FB2AuCJ9i405r/RQjt1/L0CCtck0+ZtFXUrmjQ0uO4In26yVi6SVayT6jUt5V1q7TP3bWeFjRzxpmaKdcJd/T3wznOy2yErqm2fcj6vyTHFF7K2B4rXIKgdlfvFKsKrxDkxQmawh9kaxfBQpluliVtl1cXsaqXW5vg9FUeIIolU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118031; c=relaxed/simple;
	bh=KXfmiuJOAZJqzhSBzWDrkSQJHrgaObobh7xgUq6C63o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVC7cMgQ+vU4ZT6+2zwopwr9VUiTEyJqewZMFMpOwfafaB6YhTGjpbF13sG06V2rQ0cnkfnWjg1dDyp1IQ/C91kFT8wrjDDGy5S5JVKeWjjFg1a4OVVOpERmt507ehAqscQIKk3NiEZ/nf6QhltaM5HCBYF7M0hhbt9QQFFXlKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdPOxaJR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ib9k5B9A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKDkCW012190;
	Fri, 16 Feb 2024 21:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=PULTjpQ4CgKFl7QQYFQWEw7UCRXWWaoj/fracxY/qoc=;
 b=kdPOxaJR6iY5Io3AphNBbwNdkmtb8bA0BCvvmMXa8jKEufwPunQDWkIwfAwYpKUnmMCE
 s+YqH8d9mhxfMz8a2pi6NIT6betGgsJXLTiIRAwpdww7h+KZ8DNtH81jX7bh2+/Lcs3j
 5Io75iiq2qkMq9VVgyzCn+DXzYy78C+WvfyKnebPUopPqLW9DXYy7oke6jWAlozZdzIM
 7qYs0Rmf2GpRCPo1SsqrmjeAzt1W10vOKD8HFkVmzZu6IwHU+Ev2z870WwS2gFP+OiDg
 OCyJzGYMxDaEZeqfsTjoJTk7sm88AT+Bj1aso8+cNBjDOwMiW8EVNKEYXPBHsC10I1s9 Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301p5vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL4CMP024548;
	Fri, 16 Feb 2024 21:13:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykk0v8y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZlhbG+P9lCtFZIaZVMBZZBvmGG8/3MhyjQ0HVNfkyXz8bGZ7PvIZFu7V+5lnEyqGmtGV1T5pXKgB41GbiELHX9tB0n3jFIEv7y5R+7kZ/qxJzPdzVNl7+7nj54/OO3cCA7NAe1ZVoCDtjooGYxEGP63A+FJH0HvoEOWmf4hxN6ku4odgfFzye9ECcsfBugKgQ8gmPJlOO2FUcfSiO/TfRvLNgqnT5ciU8s3E53sxzauxlyfTudRDTtcLRWve13u+Fm7gQB5qkT/Hxi0oUYdZGFuHMV92f9X3amaUaYJLjReBWYOOJ5IxtjVm4Eeg3naVhYvrXVl8qzWvgH74v5FYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PULTjpQ4CgKFl7QQYFQWEw7UCRXWWaoj/fracxY/qoc=;
 b=YsrEOdhT+2HdNiR1eut8BWH/VI5s4YWA81IGHAK5EQgbx6phVUoeKNORLkdfT8T48VBfCBHSauwF2gJ1EKZeXEY0QO80cLQmusQ1Ah+JeN7RFGphJs/z69e66jGHTRxH5nGT6pX5kFSDutGeoUWyqEv3B/XD46Uep3oCHLuFJeIFzWzexjsmyJeoE/uVgdFO9itLSgD/Npo96I4l95MA5N7C3Gk+EQO2p7inOA2ZfJ2SL4DY4OZk4Uo6DrKOgfMJm5ZVqOqW2FSZC/PCvomhMWPKxRiWCOSJPaPhDOdZJPvcGTGWNm1juvD+uyfA2lASR4V3CH06JWgMpsnPVc0WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PULTjpQ4CgKFl7QQYFQWEw7UCRXWWaoj/fracxY/qoc=;
 b=ib9k5B9AeozOi3TZnfeXrneZA7qWBYviOiwAlFjFGiuKN9hguSfQPj1PffIyIQUIV0S/Lfx9NxIgxqSFSwFKo7VJd881Aw2hVxkZ6mBAk089NyfMBJiyBvILPYh2F3YoE6qO7FhiVHc1lWxNq5vTeSzUlYgghXqa4AwQk/uauvE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:36 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 5/6] mm/migrate_device: convert migrate_device_coherent_page() to migrate_device_coherent_folio()
Date: Fri, 16 Feb 2024 13:13:19 -0800
Message-ID: <20240216211320.222431-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:208:23e::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: e722a654-4602-4d40-9609-08dc2f342375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iec0L2bRHgZCzPu9w+VpfjpzRX/Fauc+0J6dRijpPKZIrZv/aqIVvKHksJDFA/jvTSOYEJIxwyYOtRQOzcuZQUm6kT7ds7pflcS2Qplb0QW+EDzdeE4qvJEuEjSy/V73+DvI15bbONxbOmqKOAe5GX2DGxRnh484yeJq/70Rvb7M64qVDJTeLhw4poid+Ps+isdUDiwb15woGwGtaR5mywr8KtpTxMMMNJ5kbSdjO+3jB2FVeAhDorMEUoBjXLgdXczK/0//5iIwuL4I6uvNZ+woHtnL+4MN7wyxNREd1NRO3lxv4opr2Li2vMyGylLSzqZJodOELScHpV0cdOEkwLwPZxEido9/MPirbszQXvL7NzSRUraIrs4dp9h4rz9qpdxx35hlIQIh4dTC6y2XSUv/G3AkNYt9kd7b2scQicleKYYHrPP6I5xXOsfxhaQlf4P+8l0WLou9ZKNxgR8uAsgqkqrijXBBUI9T+DVz6XXXRn5Jzc9I8o6IH2xjsvI1Y2nhijsjIBKi8rT9+Hk8h7+ZBqvSkE3BYbrGO6JQtAaCTLF2+fOWNaM33J3f/Bjw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(83380400001)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lNm7eksCAllHlXkRreaqDBWOWzQZWyzt7d7oF6xBKNSfRE256fRcoSLPVJiX?=
 =?us-ascii?Q?GJdlmYF7YnnXoea1Tc7ltxIQOgjOzcE/bHQD6rrTmdxYpDinxiQcXfuFHqUI?=
 =?us-ascii?Q?hImTh8tjF9tcaYJN6cCmpYU6ANbvy/lOcvGvz/amBcloPsCGbyR1xMI1DlFY?=
 =?us-ascii?Q?GDbkwkGFkJ5oWBude1mpVZyXzO3A//0oq8flpF9bM6d7r8OLxZM+BhEHXiL6?=
 =?us-ascii?Q?+6U7DwiRAtkA76SHtHBsJjYUBIbkhwNnWuley3brRnaQruJRHTVcyiYbqJss?=
 =?us-ascii?Q?4tvfodX2hyqjoBPyLxHiEl8uyLJi0ltSddI1SUZeABO9s1MckdXl8Rus4Eh3?=
 =?us-ascii?Q?7/fOAuOGWUoJ6FKyiOZ43Xp5+PaG176heNKJ6+qUmu/Rp3vP6cjnxnH9M+df?=
 =?us-ascii?Q?mwhQkhBJK/j8QxEJFBPhtJgvYf9dEPeb9pHoptlGfg4r8QyzdXlnGWlTFFnL?=
 =?us-ascii?Q?H4SfR24mUf/rnjHrpQFa7kU/7mXnxYFFCXLPsxC3YkA8MK+hwUR5O4xkHu2l?=
 =?us-ascii?Q?q6+g4Hh6C4KWTd66Eo/qwXWwMeKH9j0OOL86UabLFTrMzBOSrkBClHjIcD6Z?=
 =?us-ascii?Q?UaIq5ivQsY8tK2hkK5EHoFPUXir65rO7uc1bvGDtIajNgwgSQ9DsSOEXr5IE?=
 =?us-ascii?Q?HuKHX2MXPetqUc0tom3hLLa/vYlfV1k8tVFXbULjD3XfXMCI8QTsFLg/p7iA?=
 =?us-ascii?Q?UTUp/ogVI2vE+xodOsexCkjQbNP+1l0IjNdRwfGvACIa5P8rKmjH1CX2rYdy?=
 =?us-ascii?Q?LTW9TgwF2sJysbMEiFFpV44BOGmpq0Hf6m1pcmrVYAsVlNBH6CqcLlWpQX5N?=
 =?us-ascii?Q?Ks9NuZ/333di7ReUy5twnDAC9zMxJaU2LElfseF9oCQeLfBo79wS64L6WXKj?=
 =?us-ascii?Q?A7en84qU6aZkCZdsxCaNwsAGlZ3k1YnvEQClfxQuIG2jug1LI2mSSVZGURxx?=
 =?us-ascii?Q?6oRuRLQhaWe5PXRNCZWuN3ujBgtUjZ3siibxKB5UNEt8oihlLKyhWFx2Yu8Q?=
 =?us-ascii?Q?hgtIpV2p6VxAz4jsfDa05/oKxrG9leXlVDsh8Uz+0vqKnymEsQ0+XoQFv4p1?=
 =?us-ascii?Q?3qvRRaZ2WGLge1NLE0PYU29rZX3icO2V+PawCouAMwgKQmC02+K5303p4ODE?=
 =?us-ascii?Q?doWf9NopmsR7oSPPHY5JaRoq5kuaE5YFVeCiF/qQnr7dTskMlrOT6+KZN49O?=
 =?us-ascii?Q?UHgAly5r71AsamjTqo/YdYpchcC8BCigf8q5jr1Htkm536/034kyD/E1wnFI?=
 =?us-ascii?Q?vYC8NctDVri2zokofv2S+lj2ET3P6/FCX+VClqU860N5jQ0k5loOQEiPv75e?=
 =?us-ascii?Q?zLOCkikLKfnYb1vMqbw//tABX//DfoctODvzkkOn7VFhMjT5ilNLYsqtE5tm?=
 =?us-ascii?Q?XRCLd97CvSbdYzuO5gFNd49/6qgR1hFJoNdf7FpkwkgquVyM8A1woh2iORRZ?=
 =?us-ascii?Q?LAnrBSBW6Sa/exe97Pvc1sI6En9XKisr/ld0EbNy6Fsr/p78K4DGIdpbMkxT?=
 =?us-ascii?Q?TVk4TjhhVVcWoij4YpWUqeS4he8YgOkmIc9fNZsz9LNtGjGykzOiVmIwncmn?=
 =?us-ascii?Q?04oqSUoOEkr+BCRH90NSf0BWhu4PLKh+0lCpE9ue1NZm8GNTCX2qRCKqB0es?=
 =?us-ascii?Q?rxDrdIljTnBbRPa2cWm23fo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PiW5gTH0Qs7hETzQfjgMBRnAGpe3GjAbDbKARFXhA5eg4hXj/kW1UkW2+z4WADzIxhyqTaDLXPQaD+yuFq7HO6Ew+73V6VFwgKDsnW3hQFMS9Wuwb0GPzbndcOD1/AH5kpMvL04kPEiSPR9uQe8JScE8NVRL9chreoWaqelAyats2Sq7CwjWdO2+nBXlYzE4kCupGdot/ySiHNK70GaVyeA5ZtfTZokKIlrTLB0FhUcu17jVQwvv/bEtX/KbUGEaNvbjb4ngzzSqALw3ZpEJT2H5vAQbkbxAhrgLnZz/8iFcpgsjO9H3L7DrgVQVjNq3hQpzVU00rP6WgN+l5lVrc7Hfj4j4hluab0+xxdHINW79EmD4MTQApx6PiTO3WNUQZ+k3+NgWzYsVLsZMhzVDR+qPZ0OP4pif7gTeFhb0EF8WYuYr75lf6fHkdHEK51AmA0DKkvnItTKX73JzHMlP51x5pUwHAbk6QM+g/81MIdqQ90Ci28zXG5pgYtJzA5hXduYvrelgepv52e0rtbeaXsBP8rivNsvVd9uFpi+/7ju6UHFIhk3vBLYqUfnl5l/LJ/yOILjawFqtfZLCBa/ZSbMdi61JDrHpys9T5MJlkU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e722a654-4602-4d40-9609-08dc2f342375
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:36.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+hmmwcIVBIxSP65GQbBJk7L2qw8jae56N5HYTPFblDWxS1y6WEQNCY71y10vcVhcZbcco7yTBt0l3YO93hSVEB6Ax+bWXB77Ju1Ixy3oC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-GUID: 9X9YI9CLK4D13iF2kKjebom5kvh4zd00
X-Proofpoint-ORIG-GUID: 9X9YI9CLK4D13iF2kKjebom5kvh4zd00

Rename migrate_device_coherent_page() to migrate_device_coherent_folio()
as it now takes in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/gup.c            |  2 +-
 mm/internal.h       |  2 +-
 mm/migrate_device.c | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d5..2c8b183b94485 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2109,7 +2109,7 @@ static int migrate_longterm_unpinnable_pages(
 			folio_get(folio);
 			gup_put_folio(folio, 1, FOLL_PIN);
 
-			if (migrate_device_coherent_page(&folio->page)) {
+			if (migrate_device_coherent_folio(folio)) {
 				ret = -EBUSY;
 				goto err;
 			}
diff --git a/mm/internal.h b/mm/internal.h
index c6ea449c5353c..32304bec79f3f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1003,7 +1003,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
-int migrate_device_coherent_page(struct page *page);
+int migrate_device_coherent_folio(struct folio *folio);
 
 /*
  * mm/gup.c
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d9633c7b1d21b..5c239de0f08b2 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -705,7 +705,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 			/*
 			 * The only time there is no vma is when called from
-			 * migrate_device_coherent_page(). However this isn't
+			 * migrate_device_coherent_folio(). However this isn't
 			 * called if the page could not be unmapped.
 			 */
 			VM_BUG_ON(!migrate);
@@ -915,15 +915,15 @@ EXPORT_SYMBOL(migrate_device_range);
  * a reference on page which will be copied to the new page if migration is
  * successful or dropped on failure.
  */
-int migrate_device_coherent_page(struct page *page)
+int migrate_device_coherent_folio(struct folio *folio)
 {
 	unsigned long src_pfn, dst_pfn = 0;
 	struct page *dpage;
 
-	WARN_ON_ONCE(PageCompound(page));
+	WARN_ON_ONCE(folio_test_large(folio));
 
-	lock_page(page);
-	src_pfn = migrate_pfn(page_to_pfn(page)) | MIGRATE_PFN_MIGRATE;
+	folio_lock(folio);
+	src_pfn = migrate_pfn(folio_pfn(folio)) | MIGRATE_PFN_MIGRATE;
 
 	/*
 	 * We don't have a VMA and don't need to walk the page tables to find
@@ -942,7 +942,7 @@ int migrate_device_coherent_page(struct page *page)
 
 	migrate_device_pages(&src_pfn, &dst_pfn, 1);
 	if (src_pfn & MIGRATE_PFN_MIGRATE)
-		copy_highpage(dpage, page);
+		copy_highpage(dpage, &folio->page);
 	migrate_device_finalize(&src_pfn, &dst_pfn, 1);
 
 	if (src_pfn & MIGRATE_PFN_MIGRATE)
-- 
2.42.0


