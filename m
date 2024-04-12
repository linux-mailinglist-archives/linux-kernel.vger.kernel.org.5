Return-Path: <linux-kernel+bounces-143194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386078A358B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6931C229C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC1A14F12E;
	Fri, 12 Apr 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jUKST0/k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UHIHk3wM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237F14F10F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946146; cv=fail; b=PF5cBDpGDAu1jSmvSUjQaH8/yDDB30pxP05vrU0uqdecGkVok9J4wo42IxiOAhuvssmG7A+Yb+q5ZUIjbee6oprTU6qIAn2jxYIDc/1yNRGsDPDyRli/KHjl7okcKDWs9VUTOcutZcTrjbGANmCSKsG1oU1oVkA/qRoXpZCJ9OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946146; c=relaxed/simple;
	bh=yuRyK26QBP8hG6BfRY97wBbIHkLJsSAmFq6sLLy4qVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HbEe/rmBE7P4PEdvj5UMuEo2ZuCxGGlS1nzPGpflWU82iJ+3tR57a0SfGVe9R+4CjHvS5rx1DqkpuX/1ngYBE8nlbOWdeEtHahCeU5DrHswmUZrQBnQ2h4cN+kRMuBv05bJ3Ppyy47ZSeRKulMfSTCb7J8H6HxLF22+wMi9+F1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jUKST0/k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UHIHk3wM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CI9hZL026998;
	Fri, 12 Apr 2024 18:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=vA4YLOAyQ9xtjctU+acsQ0fDCbQX0dFxfmWmHAYHdf4=;
 b=jUKST0/krdyneCqrGpXRwvmK8KPvshjFheYeNhK40nBxhSkT1s6/UO1HTDytaDyJd8Iv
 vFPaZDysglkQNtKoswzKfchVVt/3kLKJD8730DCHmzRXsAyqeWVS5N6BzcjSWg7UGifd
 brcsCYGVMbszR48W2o8KVwML9NClrgkmkAkx7cJ89G4L0Xpc4JMAffXmBhs0nb6TadRy
 gwmgo3CacNDqZibpFFyAQm5yvduVF/dQycwl6wc2+Qrascdf7C/3LRO+n7G3/l0p0+Rx
 E/gA7jN1SsAwrwYQ9fFCy0h8xhWD8+gjiwh8HR7iZq0ZwfA4/b6f0LSa0p/wINUwMzxZ PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw02ckmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:21:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHoaFl008048;
	Fri, 12 Apr 2024 18:21:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubb4nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5RL9oniyVG/cTeakegf7x3/Dc0K9W138K0R9sQAYUwO3pe4BiomkZQC1YONRUt3vf9HQkFuLZhZMuGuriFGHeZuweDm/kFNQ2/Wqu/le127dn1++D/DfQcHjmtuk/i6AI1tbV0Dvt0cHbFsTOqa3VfrprPPD1xb1xR/lfUVqbRqum+rQPpDVwa0ebFt9mvjl2M6+15GRH6v69cM5Q5/Ij6OHp9Ru8Hm8iKnwR2bEvk4cgknAPZbHB4+7o4TFU9Ab76wq4C1l4l6IqHLIHksBHwrlsnCf4M5NjPM5d2XcN5Fxuc5ESk/JVtN6wmOE2P/h9T3qRX1prvZL93tFl50+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA4YLOAyQ9xtjctU+acsQ0fDCbQX0dFxfmWmHAYHdf4=;
 b=PuIC2GOGDp04Ap1zGMVL8AdMhisLrQZdI+p1paXan2V1qhkXI5ZF8Q8SRFVYTLMB0aeiROaK5VvZCEo+s+3rZ29oKTxmwBX/hYRuN8w1duRkFVkuR8IuWkykjV10veILMtGxdYIDMDv9OGVYrh2Owsd6nr3asqU/iqXP1gaYRdrMS+Zksqk/1qGQDX0Zpj59pIUp1JPk4EL6biZx0EbxeaqPYfR3k8vM6z20d33XqJwY+BfKtRyQ9Zqgli6s9CZAuSjeyIibhJ7tJLPPMP7LiNeeowfvDEVeGN+c9KPtku/93posYtXgYCsPKs6vDdZNe0sHdyaa9csIfFMRl1muiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA4YLOAyQ9xtjctU+acsQ0fDCbQX0dFxfmWmHAYHdf4=;
 b=UHIHk3wMzBDMzVsvA+NjV7M8MrjerinmsLMhSO9Afwe0vH9c8P78paFpGr3Z+39ags2s05q841ciBqvUhOTKIb+QUnmeD0XXUsLQR0Jy69gdnNxbsFLrbG553UV0xU8/Y165cG8fFVIpEcEOVPgtSnbETEPVpKoRskWN7opKPb0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 18:21:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 18:21:47 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/2] mm/hugetlb: convert dissolve_free_huge_pages() to folios
Date: Fri, 12 Apr 2024 11:21:38 -0700
Message-ID: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:303:b8::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO1PR10MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c79d0d-aafe-4bd0-6602-08dc5b1d6a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H+CeL5NOvTTx1hMbacFJiHwpjJbJkgUImRRnjB86Q7UHEq6k1/znTpUql0Mrgbi+yBSxScxPicKpsopNpvRfjhOcv50X7U3zyIVTy5LZZgyZ9GOp43jp1/+QY+aMX6Kk+VWmTlhcAgwVUoFzmwZzsjYCRurhNKeHBzOa8xP7XrEgOrR0SgfkVG1yafgvRgXRL/B3C9mu+GbyXU8NDEuYEvZPcYKNcqKBEwckg1z83T2+WVGkE6RhItkq4aTAy8RgZnUI3eo0C0dYLJTL9fbztD8YtjlvM/Ti8b7L94+lXbPxGZ15ktOCk0h8H3swiSoD7L9EQTiZ+V9pJgygAzzJBqzQz4Qy6fptgYfwETuDeNmYNeQMSoyaReOXKTIjdtZv7fIJ2E1LuH1nfpqCNwg6dO7POWz7v+yJhDL51iA6j3P0NLWirg7Jdckxyx3UGT2NZv2ja7NUHBB/fmrab+e0S5lpsuld77plex5qOJ7owG1maZGdHOg1exjLBTPubiHjN0BIBwxVGepf0AyMPdg5rNmX59ieMoL7MCsIkPZO4tlQCZx6BUskFt8A+d6rj3tATkDSRARpK7Vri6KmJG5oUCb/eZ+3Z1qWVR2MHXM1SCMVb3el/P9UYuHNHWlzfLpbccMns8RSetHq3PLJugw/Qj7UTXTu8Ndr+wtkU3NUhlw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PxzAdf7CW5193iZvN6vfeNele+JZSiIJwj1VSi243DEaqQQyfTLcq65OC67X?=
 =?us-ascii?Q?+xSC0eqHH/Rj+qtBfoMU6f4eVTRDl6+BFBP3FFREABCVbKHKGbUzgK/swlJ1?=
 =?us-ascii?Q?A5Yg5+HoaJOa8v94Gpif1GA52nAhldUsHbgXKxra5lUgfxvAVjmoj1qbbKw9?=
 =?us-ascii?Q?rx3TS0/6F0Ncg0zfmGQkNOuGuxa+tKqeYixEw2lKIdFV4il5ExQJcQhQSBFY?=
 =?us-ascii?Q?pg7kZgkA8a7areEqobtN/esp3xpGEpJKdql/82UKyiutOmw0tHTN/2GBG3k7?=
 =?us-ascii?Q?LsFJUFEs+CJU9amBaefyhQC84avc1C2GOQGsfi+U8S0P5GloFYuRr3SOlL9K?=
 =?us-ascii?Q?PvD8JQQrOHtd+FxixCfQFnHKdd0SQAUMcCBp0rsqvE663s/I03fG2EXhDx57?=
 =?us-ascii?Q?yqESf+ferIYoVv9SMvAEtZ034N2MfNnLo2kzUaOXe2gvtorlyUmDTWtn1Vd+?=
 =?us-ascii?Q?rrqdoEoaeD41ohijYv36eXXBrsMfeniR9bnuFfMvRlzPJ25Zo2G0qbzdGIGr?=
 =?us-ascii?Q?FjQpcNeOxXR2dRhnoPz28cYFQZ03h4+wmxIYrJ9MKEKdQCq4eglt9yWsnwoD?=
 =?us-ascii?Q?4/m+GBNttgruVHk71gbuGD+kZtNjF5k2S0FI1z+pSjbVUjoDj0F+aICc8dU3?=
 =?us-ascii?Q?dIA7CC823IRloqp2BSVL0NT6mlCtA8H7hBBSUJbcefTdL/4rmBc8Dcggu7Pj?=
 =?us-ascii?Q?31/4K2brk2vF3iKLBj0hXWAwzB29UH0DLDlNjMbol8tuE4x+BibzkiyRQymY?=
 =?us-ascii?Q?FOu6OP6tRL3lH0QuRqTBX0ZrzqkZMRyHd5hZq8yq848WoD9gIRohjABnBX4B?=
 =?us-ascii?Q?po0GT4GB/IKMzfA/jEmudpptkOgkrRVgEsyx/HGZagoHJFW3H26TP6qHjBOf?=
 =?us-ascii?Q?jvC6udnsVeEZgq2K/o57J8FnOdl32QyaD4UJWrcKFDBKWX4/5ONi2JLTmL6J?=
 =?us-ascii?Q?FbqI/xEY4MnlfKrm/3wmwnPXlZHnZiLIIpwNG2mXEmwyC9ZjiA0wV4xKQDov?=
 =?us-ascii?Q?onXuW2DQ2CPYcyD/6nBXfbgW1DVPX0Bz4vq0pdYxN8gVst9ePxgF58pQU30n?=
 =?us-ascii?Q?zdrseg30dGuqbs1+Q5ZrOPrqtYnfCH1+XA+AI+yYmkWfnsvXwcp/3BExRPJ0?=
 =?us-ascii?Q?acCL5CjhVrRQTnS9e+lkv21h3Y9TNZJ6k/6JCg/ZDI9noOshSzYXXpfuL3GD?=
 =?us-ascii?Q?7X3/7LGRRKCxRqga4I37o8lkNvup40xIo5EBsTIDEpYgB4ABHTAkkXFwrKq8?=
 =?us-ascii?Q?DULV5Vp8p7aClF0tGqfUI/Iyuq68hnvxGYv1MC/p4rk+EaoVc0ODMLs6qUDh?=
 =?us-ascii?Q?Fw3MO7nX/DNh68Gh0yARpAtX8hU3cGEsIpqYcFvVvE890rneELPw5j3UmnkA?=
 =?us-ascii?Q?eXM+AUxXS42P2AHDo46kGWQAjzawzYydjCf3L179NEkYlOzknrpe0/0BdYyA?=
 =?us-ascii?Q?PXQNAX0OliS0QBHukl7OqiJCt/esuSzyWpNL16+Ap/gym84s5Lt2AxwcEKtH?=
 =?us-ascii?Q?KIFrQCfl3Dv+YSwhCAAefuO8Ah64wNpPgpscLPEbB83cxlJFn6GTiiE2LOuQ?=
 =?us-ascii?Q?k0VvFd1YRWNom059ee0TQM32JBfF3uClzD1VtZOZcsBu8PRIccCJ3WKjl2sQ?=
 =?us-ascii?Q?HL6D0AD2PZn3tE8qEaxbtZA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dhnCS13Ru9KJQiZV/ysz6G9twMpLWS42d9VZmoaB1xDTODI7zKPlwPWT3QD5oyvug9qulozqi4g1eZpqq7idDf1cEguSubFm2TlfOHF2p7UAlC6n7cQTlc/sSioNS88f9TOSAKEZ1xHlUiItg5oc60rn27DhqdUNAWrnPmVSs/y2kwUjA+XiLB1SUBWiARxtYkIt9dWEV6VEcJiAzt9RnvgQZBMNZa/BAc2Kl0YJT8dDxNvISM4M7ii212hob6ZNO2R4kn8jC6jKF78DMv096CTwoVVB158H+0HJe0BjzX9TdigNt1ToV2k8BMGBOTeQ2SRPA97XnU+dOQRRcG3e6ENmo6veCbDx+LaP1yegH5oTu5kBX7aY28lkU0n8DE5LEdoJiuVaxSg8A8aYn6iHtmzer3BdGDbadDcMGtIkJeGkVrXHGHAGlJNKK/xqSykvvdoibG6h7R4ks+R35meG1lLF0S2LEsVBjqpwK22wp/RGFM4l8r3OLvRvPNmujw0CeIUhwPU6CuRbecuBqQ0kaCAjxiA6d4R9nhrAvCq8QP1JDeXYK8/pOWIw/34JjYM/eOu1Dc+cA2Z3xZx6COnRWRSvtSCJCKfj4Uz/vT+ZJfY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c79d0d-aafe-4bd0-6602-08dc5b1d6a32
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:21:47.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CiacuYTcFimOE0p1deNnK4IHXCjIpq641IoDkNXn8w6kPPfOrUHipaK2pna+eLmUJIIx7NJxjY8Uq3wnK781xVrCXJ/Ke0pvH7wYHkpvZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120135
X-Proofpoint-ORIG-GUID: K643jE3cifWuy7VSwqMOYResIwd-7T42
X-Proofpoint-GUID: K643jE3cifWuy7VSwqMOYResIwd-7T42

Allows us to rename dissolve_free_huge_pages() to
dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
directly and use page_folio() to convert the caller in mm/memory-failure.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---

v1 -> v2:
	- Change additional comments which reference hugepages to
	  hugetlb folios per Miaohe Lin. 
	- introduce patch 2

 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 17 ++++++++---------
 mm/memory-failure.c     |  8 ++++----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3f3e628802792..f4191b10345d6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
 	return h - hstates;
 }
 
-extern int dissolve_free_huge_page(struct page *page);
+extern int dissolve_free_hugetlb_folio(struct folio *folio);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
@@ -1148,7 +1148,7 @@ static inline int hstate_index(struct hstate *h)
 	return 0;
 }
 
-static inline int dissolve_free_huge_page(struct page *page)
+static inline int dissolve_free_hugetlb_folio(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 454900c84b303..f6dd5f597df16 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2377,8 +2377,8 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
 }
 
 /*
- * Dissolve a given free hugepage into free buddy pages. This function does
- * nothing for in-use hugepages and non-hugepages.
+ * Dissolve a given free hugetlb folio into free buddy pages. This function
+ * does nothing for in-use hugetlb folios and non-hugetlb folios.
  * This function returns values like below:
  *
  *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
@@ -2390,10 +2390,9 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
  *       0:  successfully dissolved free hugepages or the page is not a
  *           hugepage (considered as already dissolved)
  */
-int dissolve_free_huge_page(struct page *page)
+int dissolve_free_hugetlb_folio(struct folio *folio)
 {
 	int rc = -EBUSY;
-	struct folio *folio = page_folio(page);
 
 retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
@@ -2470,13 +2469,13 @@ int dissolve_free_huge_page(struct page *page)
  * make specified memory blocks removable from the system.
  * Note that this will dissolve a free gigantic hugepage completely, if any
  * part of it lies within the given range.
- * Also note that if dissolve_free_huge_page() returns with an error, all
- * free hugepages that were dissolved before that error are lost.
+ * Also note that if dissolve_free_hugetlb_folio() returns with an error, all
+ * free hugetlb folios that were dissolved before that error are lost.
  */
 int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-	struct page *page;
+	struct folio *folio;
 	int rc = 0;
 	unsigned int order;
 	struct hstate *h;
@@ -2489,8 +2488,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 		order = min(order, huge_page_order(h));
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << order) {
-		page = pfn_to_page(pfn);
-		rc = dissolve_free_huge_page(page);
+		folio = pfn_folio(pfn);
+		rc = dissolve_free_hugetlb_folio(folio);
 		if (rc)
 			break;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 88359a185c5f9..8cc91aa1a3f47 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -155,11 +155,11 @@ static int __page_handle_poison(struct page *page)
 
 	/*
 	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
-	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
+	 * dissolve_free_hugetlb_folio() might hold cpu_hotplug_lock via static_key_slow_dec()
 	 * when hugetlb vmemmap optimization is enabled. This will break current lock
 	 * dependency chain and leads to deadlock.
 	 */
-	ret = dissolve_free_huge_page(page);
+	ret = dissolve_free_hugetlb_folio(page_folio(page));
 	if (!ret) {
 		drain_all_pages(page_zone(page));
 		ret = take_page_off_buddy(page);
@@ -172,8 +172,8 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 {
 	if (hugepage_or_freepage) {
 		/*
-		 * Doing this check for free pages is also fine since dissolve_free_huge_page
-		 * returns 0 for non-hugetlb pages as well.
+		 * Doing this check for free pages is also fine since
+		 * dissolve_free_hugetlb_folio() returns 0 for non-hugetlb folios as well.
 		 */
 		if (__page_handle_poison(page) <= 0)
 			/*
-- 
2.44.0


