Return-Path: <linux-kernel+bounces-69349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B188587C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6271C221F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13307145324;
	Fri, 16 Feb 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gg9ReKux";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zNK8/yhp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02331420A9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118025; cv=fail; b=riWhma3SOVwYbMpvrYRlMrlCXMWhION17iy3tLhlvNC64N6B2K9FiM1rZ/jnl7l0TLDOIMLFMcrDXHumrCbceBsq7Q5cLe8e7WHnQDMmplyHS9y7bdAVmoOorhvLAy/GTHVTlI2yc4U3xKOm0pD4+sk9wqYA9mhNPnTAQU7ul7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118025; c=relaxed/simple;
	bh=KnICgGgh60C+MDR3o33DyZyreFrQKi4oXQqlTB7vAEw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LXqAODpxniceCu9yMA1UkDVlgJSHi1Hlxt/MqKF8QxGBp2/zdjNo3qQ2CT0MW8osBGHKp5I03XzBmoV+DjrU4puB31jzKA1uq5HOovofZGUfyawnJ0phLWmO48FE9Fi/EQOH0aqttsObt0tsh0qYs2hK4dUTf0iiFGdwfG252IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gg9ReKux; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zNK8/yhp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEV77014766;
	Fri, 16 Feb 2024 21:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=C7E1LFEFqRFsFhXCtqRYBbiVglsmTcGDBOTo3k+XP0U=;
 b=Gg9ReKuxYdnZsJLCovFckR500BkxJSE8sZnqN6YOky4cMkb4JCkS/LymVcEDMELd/Kpz
 hHr7Yjf1nZK/6U4lJTtoDNlb4Dz+E7BXVgwe0Ajo0MKBJhizgaukW6QRzv3bbnGVequB
 CYTMRSa4ZFM06+9LGbISIamKLlQpP9w1ZgQvtFxRWPMceTk+PLHltymiuBYyE2q+lB55
 5tDbLcy0GSGrUVb44KYgs8d3y0xIPPU2ZuEXwmJkXwRrbzVT5fzT7wYCWOipG9pCF92D
 cR6nhavasHe3sC9CNWT2Upmvemnk/7xcIp00K2VDms4FIM0K6MTUAveCBHMLf7dg2ZFg SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6xakb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKQueG015073;
	Fri, 16 Feb 2024 21:13:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykce4gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhBPmqbFb9pbUmynBEqMknviZc+4KXw1ri6IsmR7DGjQYkGx1LkNIlm2BPF3HzdLBGzdyzyBV2g2Om3fCFIsTBg6noUgtBAANhF5q+g8Hzl+K/lCpsJTCNLE2SYBsSOtcK18ZOQfJTh1iMJ+PNE9nMrqHu2jH7ir0XhxO6R04BJOtZtnXmFzdCpHuIgcar8pJushjjp/xkfIoKBBU+pJKvI0pshPpzQSH3cYlI4snN7pkU3ELKHPIXGldTAx9BUuGUpQINB7UWn8uk0dE9HCmH1PLwWT5A/F3baH4nHKqtj81pBosjF2KUpHXZnyqxLtrT8hQhCzCW4+3zIjOgQLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7E1LFEFqRFsFhXCtqRYBbiVglsmTcGDBOTo3k+XP0U=;
 b=RIN13BpZkqmdJQjpcav6L8CY/weKFF22/qFGnXoKs9wok9SjWu51I3wWvmCQQnntnzBegdAWdFUZFVgXgZ5seassrJKmfpEAeqdNfILkGpUEzji+X1skiTU5M86cDNsHVqnvb870cPxAWzk+Bxp0Y4QZOIsiassf1VFTxbFd3J2mFkCs5EY4A1aeeOxD6hoK8LQ89nR+jFI/YrwALRN13juuxnCIq+CAtlnu4ENy1WPhQgxlblZm13CtNqQdhx7hXFw/+uxBKWg2IrHJpuZhb2uzf2CEGgBHf/XFycnTk40Ewiu/Q7hJVgfjGpfKYdJ+LPA7ISDZQVF66pftALQXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7E1LFEFqRFsFhXCtqRYBbiVglsmTcGDBOTo3k+XP0U=;
 b=zNK8/yhpl8WbsB13LjnMESpnc1VlgTk023dGxIsQbjSpdizJ6Hun3OgiIv/JU/Q3zvMdydpVCKsEXhlCZkzO0LQjiuVqs/SIYXv9V4Gjo8qKj179rZm1DEBzuaBoSyGQFN245rn1rTKXeGOwdmy6cXBbEWSZJ2sD7n3za+a2myI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:26 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:25 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/6] mm/migrate: introduce migrate_pfn_to_folio()
Date: Fri, 16 Feb 2024 13:13:15 -0800
Message-ID: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: ef414004-76fd-4796-fa39-08dc2f341d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N9KjnPrEjQhizHTSf16oCiJNXzX9WfmHScdtzKJLPwJHJj0gWhz6RlV+k1+gFnvcgtthmcOW0yZRsasZNQOb6upo5Kq4OBR9tUdJ7kbSZ3YCdHyCQesLpiDbzAmLRCpel+eSzDUsxTmEu7T7HyBQ1FPPtiJ6ihJUWxggntu/7xRa2t2gy/RNrDKLF7dASyjM0Jc+RbeXQMXbZRQWHZS+SGsW4fw+0XSvC3YvIqPA/CQDNU9BBOCukziKOOgzh+fgSujTsQOWxNlq88cD8PbV74Ud5/sBDzRo3UIARl/TkUTihRFDO+lP9u8/khhai6ITvm0VrgvIA3c7hdHaW3cxxc+8+zzOg+H7NLa/JzfmVPIqGJypwrxeZHs4HmYj181qy0RWCDGsulVuJ+bASna4WYNqyTBhW10PPwazmgfPs4mxwLBGHf5kcdloKRrJSFy/ZBAshscbZhREqNpAudqxH7k1y0Mu+ZKrUAvHByFh0uS9tRvEsft85Y4dFXrfYRDqwCoH/b2r5K9hwjrJs0JK+GYGxFkhdrb6uuswXDC9mRZLPybTQddB8YtWhytKGe7J
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(4744005)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yyQRW4+qY55BFFmk4+/Fj/vbJ+YQpKymLdLmICXi42QbMDH2c0siJRYnYw/H?=
 =?us-ascii?Q?8X2NOCv0h/Em5SpJ7ysKAqMYZh1eUaK/wgPKeP43xcVjdgjCvwxDEkNTngFZ?=
 =?us-ascii?Q?mezel1rIY/9bhNzQWM/d85mKbiRwfgVBUc3ZNmJGBryTnzhvjpbhgs4ou4C/?=
 =?us-ascii?Q?4H4YGqjslT/szi14v5YYTtK0vGQQjKyAint2+/tR+yop4PHHkSdigMyLungt?=
 =?us-ascii?Q?VAgaqh+MkV608Zo7cjQu2YLhQ53FuSdqw79BA37ZfgJicySmGq3uT71+rDD0?=
 =?us-ascii?Q?KXX96l/4nGEjrNHCRLtvfl9WfXq5K8ZUDDmEGcbmvvty6PjnSBZ3yI3ZzxLl?=
 =?us-ascii?Q?D7gVUvHKjGcNrb55nmZ0NafYNrTrD2p9SOc954K3ppCHILpmtmcZfxyjCRc0?=
 =?us-ascii?Q?nhD0CnFsaggjaKdJcVlwuMTZy77m9B15/NC0GHls9z50U95aBJz9eP5BsWKM?=
 =?us-ascii?Q?6LmZLS9r4B8KqHjb/vY/oCosXd/9SaOHiKS1qaC1HP5+grCV2JO5N4RcfbKg?=
 =?us-ascii?Q?bUue6D3KJTaZzOLqP/iFG7dZsdOgzF68BQKoP9W5qLTOOPHZuYjq2ePBKR0J?=
 =?us-ascii?Q?Z3jFV417HyrajB8pBLFrjnTW70BdUj2kWMUT1bSR8ubYFRnu+pItDomv0WGf?=
 =?us-ascii?Q?hEKStBKZk6cSKrjd9EbnJAuFU3Fg0bmTkB7ae7AACTTqAKM71ZYuBAjIz2lZ?=
 =?us-ascii?Q?cQ7RsesUjEpxmHk43XMsSPp8JHSjurmtCwJI1UZSvQESgToIyrtTrFfqHkqm?=
 =?us-ascii?Q?PNWDCpmyyLWFpN9HdaQFDTrj0xjc4grjlD5SWdHCdO9t5zVQqRcrxmyH/dJ1?=
 =?us-ascii?Q?u0ZwI32MPEx3nPTN0DQ8oCAdvQgZQUnFDTLawBnGFVsvGrskA97U6noA3IxT?=
 =?us-ascii?Q?91T1I7fLQFSQkNWkNnXYAZIhdEEbreLGvthukcWfuNjcmSyqcATbFELUAljy?=
 =?us-ascii?Q?WxqR+HUGrBxUmMUDFSxnAP9UL1Nuk+khkB/bhxGRx8sp6hKFZ2/VqqF1vXgS?=
 =?us-ascii?Q?SHHv8C3YdyF3CaniD2fcuo9V8safhaJ8Fx/B2wHi+8xQaTcIDuqowsgFB0a1?=
 =?us-ascii?Q?ZLv4RVWZY5DFKbPICYISMH1uealKnGWJVKbMC/13e+US+AcdDmP4/KstI7Zl?=
 =?us-ascii?Q?/ASS40W3EUjHOOjc5xls//h6/Y1mP9bfYN664wBOiAdTCnMtl/go+/MtF7su?=
 =?us-ascii?Q?N50dN0YQkhhyPczo9ty/Df5233ObGHC0FkXSpzKxRXIQ9PPoSdGEtRdVMV+z?=
 =?us-ascii?Q?PXKrwf8sTqbX7RK7tnJSjH9lbDhKa96tuqZGrqWgeV/UMiGfsQ7uiMzQQcOc?=
 =?us-ascii?Q?eQGCqW19WMHSpZ4X6KGBH5JU1x+FIm8ThY7eKFNQD+3bWp6dKJvBcen/WrG0?=
 =?us-ascii?Q?4s6Hgvs6BmAZV1cqVhKy3ADKklYb21J6siL6osecSI5k2AOhLyzvTZUupc2D?=
 =?us-ascii?Q?hmq0bcRx52VudvavLdCF+a6KHREW+cPYCvd0tLK8ull3RxcjUxSp/femU+aB?=
 =?us-ascii?Q?eEm/BrKpvcAsB68B7NqT6B6m7E8ul0VQJLIpBwJA3LX844OtRnBm/17jjpnl?=
 =?us-ascii?Q?M+51V3tDb7OUQfRuW4Muwo6xb+9kNqxp6U1u9/8VEeI8Dpq6AevtiwupUTdK?=
 =?us-ascii?Q?BCo7+z7Vz/l53vi9UksRFPQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2+JaVPro+ERTv336M6pxf9ecIEqjeq9g586IK9h96zBAKVZ9sJNDlW9NSqZ4hlF+BDw5VujxYlWuWexEeLmUzqqd67x6tnLVcyoJybDtuDfE6omTFNxWSIvX/dG7SZBQ8rQXLKsVMNa2iDCB5FUhAipa5eym4VtGHsesZIxpJrd0dCygY3aX5NdiwM14pVk9wlKmEzq1W0o2loOjo0gzugRl0ZpD19OgzTAd2+03jF+QjkpiduStw3WuEVSS6DImGcz+ICP0v5aoYZsNLdmIk5ZLfOeoEsh/Hg8bhkwpE899sVV1bcu0bPzw91w2YbBIAebgtojku2yhMKykyk1vPjgGWcZxCoKbY31c6hRUcYPp/Ewigm9biiluNKwqU3uQijo3+6ivywzGmod/HPQXHNiG38nLb4Ys/x40meye9FDY8GjvSk1yMGL5mdc/69ZM2K0/1K3CgsS9slVNkc53laVf5kJdiUTxoE8kalo6nMrNfAj+vAo89p/tON3FdM85lIorZ2SSLoCseft3EJ4ugIyEPK9qrxpWL/NdMcMKJ30RKBEQ54/J61EA+5f9Y7uIUYwFvH06pRK3YwOuFm7jN/uG1YHSP23+scnpVYr9XbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef414004-76fd-4796-fa39-08dc2f341d64
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:25.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIbIZ33os2BlNkr5raEsKKDlFslu0k3/4Wv7jDs2+6sVaqJmSZ8PytEasRfKfiHpFHr9Av1DJoZiJ0u3U9DKudoQNvFm5Vh+xTOJKn7tIfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-ORIG-GUID: qgc8GBs-fDdfyB1N6LjrkrIiPkCHMymW
X-Proofpoint-GUID: qgc8GBs-fDdfyB1N6LjrkrIiPkCHMymW

Add a folio compatible wrapper for migrate_pfn_to_page() so we can
return a folio directly.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Suggested-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/migrate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2ce13e8a309bd..21a1a5e415338 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -171,6 +171,11 @@ static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
 	return pfn_to_page(mpfn >> MIGRATE_PFN_SHIFT);
 }
 
+static inline struct folio *migrate_pfn_to_folio(unsigned long mpfn)
+{
+	return page_folio(migrate_pfn_to_page(mpfn));
+}
+
 static inline unsigned long migrate_pfn(unsigned long pfn)
 {
 	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
-- 
2.42.0


