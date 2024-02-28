Return-Path: <linux-kernel+bounces-85513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEDA86B6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D111F271BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC774087B;
	Wed, 28 Feb 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ftZW5gsk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TtVBqMTQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58140845;
	Wed, 28 Feb 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144041; cv=fail; b=ulH+hs35oW079hDYT8FH0cjdPjW42punAznW5yOOsFS1Eq15xP8WHfYgUWaTVqeCYLlbnqyVsVOSPeu0HDJv/uJQONc35xpspc00TiF8vdGI4Qp2Apgub/Owo7JUnz5RQGAs7MSiqTYO/62CXXWvxtRIzoanjJbjgKpUQ8y5O8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144041; c=relaxed/simple;
	bh=CGWZeUYqwRGqr1kd963pIPVPdb9T8qNDhjZbUlP1zGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9IchvajCmN+EatviAiY4XVwi09oEcxnRTORUbTmjQKNzz3Y9Qz4oafQdHiYl+apuuxXDihnbfsThZd+LIPJXLdeSLgttGO0p+cWj3l6Camk+DJYLahwFXtCXKjPun3o3pPgfHVlDqDBmT8IHhoX7/TrBH8fFA8n6ZTfsZo8G90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ftZW5gsk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TtVBqMTQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEJweC013144;
	Wed, 28 Feb 2024 18:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Y1kSgCPucJQSeUKyIx+OqALG/CVDY4d4+Oqq1cl+QzE=;
 b=ftZW5gsk5TIAGTILV07PPnvQ/q5wazzNEOAZ5FcN0aLPlzd9FtAU3z2lhg70guzrdiS4
 W4lY6bJ3wkr9shiMFQqKI2OVLvLMbht5QTfjGQG/TgKuFLJj5YmJlanIyR/y4sxOZtyF
 Tlz2QOrqBhQQc24o+6w/TrJLbzll1+UJ2MgCeBe1lVc+G7RGdokiT61xUgAvF+O5v7iD
 pQZJ4L9BNcXQCE4mu//02eNkeiqxjo/0JzyQ0AhcgoLL1Lq+26txJkqL6+UV6KejW19h
 jqCSy+Vi66m7eE53Np57+qb6DL7isiikIe2poTvCKl6N6gwN5zTfMCDOYrW2KoWv6GRy 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vb1tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:13:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SI4BlX022687;
	Wed, 28 Feb 2024 18:13:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9khd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgQjN+q8QedMLfuDf+PFe2E+0p/wjshRfjdCeMzpHjWia6W6+7R7MGREhu93hh33G12wDn+6ezDOTACzzru9RA+rn9j8jQ4Pqpi+NYYVX4Yyk+AC7r2LxZODf2SuGOcemEg+07Gj6MyD3ukrllyrEVf2oARk73PwYKFHSda41HIw3kthQKSzLthFQbkKXfo+gK2p2g0ewFhW6NjbDBCDrPNZ2zKnD0DFI5WslPjRPs0hTUEtyA/7AcfOpouNSar42TqdC5pj/Z9oIPv6Qyb2CP/1GP3P5aYv8YQbdu3f6tCaLurbTzBJ/SZNSwYPlfcatN2KibcbYK8zsCFaFtLEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1kSgCPucJQSeUKyIx+OqALG/CVDY4d4+Oqq1cl+QzE=;
 b=ZPZu4Tb3534iNnTS7NSyrtfjduqJb0qfXNl/2DQ6+kPtv/U9dW4IhNAHgw+r++SjvPozywvlYBBnA8KDkllnmFRuOwHY72ZP2Gr/JLVRe/kXNCkA6ITnS86xWJlmxzZ+AVo1DnEFyiGmq6DyID1jNBrH4UB502Q0Gf+JWLSg5ERdX9ncLgQ5oKxlgwBcHCaTG8zAqColfLwY1luzBzyQp2porTLoEJNsW6gXWwJDu6JpoIRWN9w4thwQD4W1ZysQXjhCK9UVAWWIC6d+iVSQpgRl9Ytp7a1GpXOVphvIvqghZ8nwriv9o7rc8Gsl9v3zTX228+RNGpeSA3hGT187Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1kSgCPucJQSeUKyIx+OqALG/CVDY4d4+Oqq1cl+QzE=;
 b=TtVBqMTQUWsY5Eittq9IdiSWLLG9WvWVYc/4flfv2mBQWDV8oJj3ugFe3g3rD+BY5tIIYgq/sbAq/DatnFgWP+xTu7bnrPVkoA6vqcxZLg3oIp9ZR+chNHcVA9TJ8Bg67/CDnQcHiaTGg12FI053B3cYsfdg3fGsp73/CwgocxY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7002.namprd10.prod.outlook.com (2603:10b6:806:344::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:13:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:13:12 +0000
Message-ID: <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
Date: Wed, 28 Feb 2024 18:13:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240221073159.29408-1-yangxingui@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240221073159.29408-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9f6b1e-b701-4901-ec52-08dc3888ed32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zYlvqNVOUaVfqWb3G1qHBr0us/4FEddxsphKge6RUzZhdAolBvNpiGgAjDT7aTQbaVxePEws814kE0thm2lkBjt6JURhpOTN6f6h2W3+pB+pRuoddl4XK5hctihmxP8OBe2Ov0vm5G/zmLnR81l68ldVOz8eEDpk43OEXSlCCFoJqnMcOWthoib4NP2IyGJiUAq/RqPJCCd/treVEl2Z5PFECf/BIz+zFU7IaHhO5q7cL41FfqQjITHUbSVu9Lb/IFMAQunDWAEQOCQ5CL/Uyq24hNRQ0tZL447KTf6UJ9ZivPGLgMvf/eSXqjE1kqaqsvvsP10OnLe4dwUlb6CtUQgpq21zFTjuAjHxm+HSR7GA/r2/prdxqoI3dQ4qVtHz2Pr1XT0j9fI2wpWnsQEBg1XKZZi5quQLgfjOoc85KgTwpFAP89pSplJVzWw1+3nuj98IrSILqpirGHipKBBnzFfIS4GBWMV94Dzx4yWRLjK0eDk4YodjZYp4Xa+Xh1A5PuHjm+q2w/Wz0VO0kY125oP9ltabtITW22GbvvZtq2+BRqZiz4+63U0N8bLs/pYxxq1TNEq4iW11YIjVryHT8aXya99w/FUnfil3JSr77oOGeceHdi+Eyoo4xy2wZTynmJf94jprUxEiB3fSW0FpZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHlFcWpCVGthbzJXVnl1a0VqdHZBby9UamJlT2s5SzJPQThMZ3lad0dFL1NZ?=
 =?utf-8?B?aW1SZXVGRkdNbDlVNmFqd050dThqejVqT2IrdzBDUnRKU0VEMDR5TysrelBF?=
 =?utf-8?B?cFNnK1ArMVJFOVhkNndSUDBVYTcrMlBIa250VmZ1SUMzajJJUFBpamQ5aTVD?=
 =?utf-8?B?M2ZzZk1LWHN0emIwYXQraHJqK2ZkNFZPMmoyZ210cWhtSUpEZWtmOFplNWZz?=
 =?utf-8?B?ZmtaQlFvWmJJRldrRUM4RUxpaDQ3STJQQ0N3L3F2Mlgya0dtcCs5MnZhUUlQ?=
 =?utf-8?B?bzhUU0FKdU5yK0FaZ01wMmsxQ0RycWM4aTROanJBVnZWRnc2UlhzK2IvYW5O?=
 =?utf-8?B?SzFCcy8rZDJuOUNFS0I1YVM0amdZdjU5OUhlSzFMeEhuYjM3b2ROc3BKWmVS?=
 =?utf-8?B?L0laMWk2VVVZbytBRitDMUkxekJFVVBxRVFJUDhNd2UvQWtsUmMvbVhDY0dM?=
 =?utf-8?B?TDNQUkVKQ2JHMW1TR1hBVU9rT1kzVnJROTBCdTdhS01Vd0FzeDd2ZXNQZjdV?=
 =?utf-8?B?akdHc3RZTWRIa0orM0JNOEV5YmtLWWhTVjg5cHBXRlhjczU0TWxiTURWUzRX?=
 =?utf-8?B?TlllRmtvMy9GOFNTL29RQ3ZHUnRjY1N3NEdnbjZrT09TY3lxUVZxaFloRVpH?=
 =?utf-8?B?c05mR2VsMXF0YjlHeXU0TVZvbUppZDV5aUR1d2VqRXI1eDNlZVNQZFREKzdJ?=
 =?utf-8?B?bXdLNUlHZmRUdm1URjdkSnhSMk1YQnBBUWRiR0pUV0VyT29xMW1yRnhoRnpX?=
 =?utf-8?B?d3d1dHFxYVRYM285elRSaXBYOTRUMW9VcGdlMDJ6cFloZU5yczU1SkFkdTZX?=
 =?utf-8?B?WUZ4MHg1WDY1UkRXS0oraFlnbGVhYmZjaUhuaDNqR0dRSjRtc3Y1U3VhYmJW?=
 =?utf-8?B?S3RXVlZYL3VYSUNMU2ttNThvR2ZVcTR3dVJDZWlBdzN4bUlTaTN5MXZ2UVVO?=
 =?utf-8?B?U3hNOHJ5SWdacmd4SldKQVJrUkFqYlRndjFMTjlKVnlyUE1NS1BiWERLTmdl?=
 =?utf-8?B?VGg5bVJDWFlBdzdweE5xK0YxdXJmR1ZzSzFrNkRXdzFnK0hRK2x5bzgwdnFH?=
 =?utf-8?B?SnRXY2hXY1dyTVpvK2p0SkRQdzRMRldUck5iNHJxbUpvRmVQTW5XRzU1TzNU?=
 =?utf-8?B?aGFsOHgwcUk1VlVUUnMzanZkcFMvZ0NLbjFaZ1pzbjZwekppVVZZb0Yrbksr?=
 =?utf-8?B?ZUxJeWc1ZEIxMVhjckJpZnoxVWhFT1NTSWVOTmR0dVIxaU1CZUhjQzBvT3Qz?=
 =?utf-8?B?Qms1emlrUGpqeTRXRUhzRGlxSGpzL2pncEkvUUlRdVhCUWR0bWEybjNPNVJw?=
 =?utf-8?B?aFQxZ2hTc3R1d0E1MUlJVEtKQTBQYjY0WGxDTXZmaFZVM24zZFhNR29tUHJO?=
 =?utf-8?B?eHZVSnZNTk9aTmhtYVB3WlhubndUL1dsVGI4RnF0b3dxQWVZaEprVHJNblBi?=
 =?utf-8?B?VkFuaUFOZU1UY0lBNnNRUjdIakxydUd5OU1tUGF6L1psdkt5TkxhbzBpOUpq?=
 =?utf-8?B?MlRLTEV0ZHQvSXNtQUwramV1aXp1MTlHOFV4U01jdjN1eGtwVFZrbVVvWUdZ?=
 =?utf-8?B?aEYwdzlHK1ZQUUJIWVhGVW9mQ3NXazFNM3pFWDQ3Q2tod1ZUM3hxRXI1VFdT?=
 =?utf-8?B?Sm5xeUU3b0FwZVdXWjI0cjNFcmxpL0RJSXAxS2VtdWRYRGZmZlhSTzVJRWdI?=
 =?utf-8?B?UktJa1k5ZlJSUVJlbWhRZThicFJ4bTBzRlp2ZFQ2bjBEK2wzWEZUTmVLYmU1?=
 =?utf-8?B?VjRSWXpVeHR5RDEwUUdReWZMWlRXY1dreHVXZFY4K3N3cEZxM1NmZkQzUUhq?=
 =?utf-8?B?M0JyUk1ZTnNHeXJRZStjeWlUNy9NQjVqbWZwTlFDR3FtZ0tQQWVTWENFZlgr?=
 =?utf-8?B?QWlJVFNIeEg4N2lzbUhKdGQxZmJOQUwycGp6UmlIb2RUdkR5RzVjY1ZscHV2?=
 =?utf-8?B?dTdNR1RmM1d4MC9zVEM4OWkvU2c2Q3Y2RStESnZrR0dRYUk4Ujg3Q3BsVDAw?=
 =?utf-8?B?MzU3UFV3azhmZFlOMnNJdFhWNU16VWp1VURuaEU3U3RDam5DZENDUEpXNXAv?=
 =?utf-8?B?QU5CdE5VRFhla3RjajdzYlp2elM2RkJISmF4VDZjUG1XQm1uNkdrZTg4MVNt?=
 =?utf-8?Q?NOf6+td1Y9/fAl/6QZAaFb82r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	trjVLOvsXHfOpCBw00NuMJmdiFXJcZN81jS4SxE8OYE869Ucq5lOf8AkdLVJiAp9xobIygqKvW6SwRCns3yqimDiQ0Xd81L495wW5jq+Um8LyQUDGVP+Phz5WOZkznOlR34vaq8279u8V58kjZ5p7Op6TZVhI0qnYQRONdrwJJVcaaMaNpwa706NZpcNnxjGxvkjUfLfWji/Ff2OE5iZ6Bi0oN8G41Gjp7wwTltKixi7H66onlH+Drg6s81p5Jvptdf/7eg9gzQBZqO7VL8xvliN3PIwQeHdDO+THtounpjNW0wdSVBH49COB+9+R+dgk9CTI5INZRsC3FOWxrViuMf3CtamcuNHHe3tAHu/McW3ERteb1cvnEtTEAmdtrEw1WX3zq+NypfrHqB8QpLQViniWaCxvdmGDl09Hie7QOmqa9LCqeGL3ZKGPfEJ8wPoxfx9989s9iPew15Viorff4n15HrWdp44lh8zP7gSL4IYDjJl2WGpW9K274sOGEvAzwaYYtv6CMI5rrihjCYiDDWZ7cIoeJjCHy9NX5yMepccscxmNNmUkjaLOQ/Yb3H6/DrPFBdvBwDPyEAGsNkeeD2eNn9Tr01tMUK7IEQO5L4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9f6b1e-b701-4901-ec52-08dc3888ed32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:13:12.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNATXLe88AIVWho0QyJhUvQdxWsVp1612f3JNw9BCjMsYFGfYToWOt8qnRWcsM5Dv5s/izsj0eWw+IVdkUFpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280144
X-Proofpoint-GUID: 9PguZkiM764zsirtvijkwLdIziMH-6Wv
X-Proofpoint-ORIG-GUID: 9PguZkiM764zsirtvijkwLdIziMH-6Wv

On 21/02/2024 07:31, Xingui Yang wrote:
> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
> update PHY info"), do discovery will send a new SMP_DISCOVER and update
> phy->phy_change_count. We found that if the disk is reconnected and phy
> change_count changes at this time, the disk scanning process will not be
> triggered.
> 
> So update the PHY info with the last query results.
> 
> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..9563f5589948 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
>   		if (*type == 0)
>   			memset(sas_addr, 0, SAS_ADDR_SIZE);
>   	}
> +
> +	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))

It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, in 
this this case disc_resp is not filled in as the command did not 
execute, right? I know that is what the current code does, but it is 
strange.

> +		sas_set_ex_phy(dev, phy_id, disc_resp);

So can we just call this here when we know that the SMP command was 
executed properly?

Thanks,
John

> +
>   	kfree(disc_resp);
>   	return res;
>   }
> @@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>   		phy->phy_state = PHY_EMPTY;
>   		sas_unregister_devs_sas_addr(dev, phy_id, last);
> -		/*
> -		 * Even though the PHY is empty, for convenience we discover
> -		 * the PHY to update the PHY info, like negotiated linkrate.
> -		 */
> -		sas_ex_phy_discover(dev, phy_id);
>   		return res;
>   	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
>   		   dev_type_flutter(type, phy->attached_dev_type)) {


