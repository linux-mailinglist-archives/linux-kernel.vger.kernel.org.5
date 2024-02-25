Return-Path: <linux-kernel+bounces-80252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2050862C88
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B9328151E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EF1759F;
	Sun, 25 Feb 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QuyMTe5a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B2LyyEXt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085F1B805;
	Sun, 25 Feb 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887125; cv=fail; b=LD2aV+C8oqEciPn3BNTSfH/GCg/nYyQj25bX7s7825EluVMzUpwNh80UhkDwNzFBk9a9j2dzhyhx9dkd7d7A+wZ3ylopl1iEACeZ4dFfajYsZQhNAMWaQ9dF2qeyk6Wu9u6rIH7dam7YLR8LHAh/n2V1wjecO6Hqzh7d4RX/hPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887125; c=relaxed/simple;
	bh=gQOpvjjlrDdRynweITgoNrNtRgURB8TFDkTF+sT59Rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Elmik+MtNEGW4ZNbPykWadGp6ZlK8LvrOpHRDNY6ZEWZZVPyhm2JXw17PaDTsOFVY7/3dN89mYR4nOZuvKArL789pIvXal/cQextd6kjgabors+GCaOxX5jUYIF9bovz7uSJxaFI6p02M797Ab24GmOmJOqmasJBVQKnfelj+CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QuyMTe5a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B2LyyEXt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41PFcJdb002550;
	Sun, 25 Feb 2024 18:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+lQIOQ7jMO7GOsHAXjJZIfzBc0nSf6Vghp6lC3pT4W8=;
 b=QuyMTe5aeNpcOvwsS4LU0EDtknT9Qbw7zVfTJtcCV1XntVhB95jjL300vbfllOVPeKmg
 rj1JpxL9v2Wltj7lAVKI9gC0Idsm8H4UhBC9ho0zBssNQYM1eMz2CkMWlBvsvX8WGvKt
 SAhCVgo/MQI9elwbLAvu4tsvpBNiyGnwLn6vU3BOOJ3qt9ezAs9WCyWgPtiJi+p+Edbt
 KOV/Y7yOJHPgRAcUcy4G0y1BNvgLPSmfkY7q9ySobeyrs2vRTkk0SsaunFjM+C99+Zr4
 T2cGWyVQAug4BdV+DDw6kRHjEUxXvz/59VWEwQpi27HFTeVFx+0XeSSGWYFP91GB1phg Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb2x42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 18:51:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41PFLeeW017270;
	Sun, 25 Feb 2024 18:51:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wb4kay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 18:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb1hzf2TqmgddWqx93pHOKSn7heuf/HSdc/I80z60sJdAlEqzR4G1imgzY8sOUVOt3R3zeewNzbyJQP33QVV5MCIPiPwv+7up1kM/3kp8SBcfDu9u6ZWWmQaJ8RYkldR45SSRs4e2tseppzGuVcTPxAhHDegP5zsBQZXOZXY9bLXF9a1erF8FTfyGchb60Q8qSDg7MbacqoO4+GFfzg+Bxyu9HC5BTJura+xpkekiXJPUX6c+DUhqblHg30dDmiCi7hSUtIieJxU2xjUvPkHQQAO0QVHeTt4pWrXh7vAV3ZZtve4siuVESD5b+QY3/E5wlPgL85WjRbJUlnBim/pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lQIOQ7jMO7GOsHAXjJZIfzBc0nSf6Vghp6lC3pT4W8=;
 b=dnTr6ezPrxKZ5Q7iTBI0cf16qGqktAv/xHZ+F1e8wjkqNDYDv+cSEeJPnKcDpQHmzohhugIQeYqFHWPpJCLPXHbPt84rZ8MRzfrihb57aqWFyctYH5p7DJ3fjTx9S3BmmfvJUM0UsiHQPUcIZJlEMzto3o3Eq8Gqvx9oZ7GzEjOvAOdUa2DAaaH1dwRPu02ztU/kub0Kk642bQo0azWF4hudo6xkgcfWKne3o6HVfSMmvS5WiFmsL46Di2yp9Av/wavHM+WQ9yujanSDyH1H52mIUu4tsJ2R+xqvuils07Mvs+Y49HkwCx6QySWVtlc03Vlj3zYhoICq9mvBCvTckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lQIOQ7jMO7GOsHAXjJZIfzBc0nSf6Vghp6lC3pT4W8=;
 b=B2LyyEXtgucm8IdAruuMzAsxcCBJNVdxkf9ai0FbBA4fMElBX8qxf2zfzSKatLbtUaieXLsM+3E9CaMXRWCy0JsnfI/Tni2+enZTkq4hICmNRDFic4PFSaXXkzJkAOyCul5dI1f0S2KjlMaFKonEruh4BEjpgJZ5U3bPD4mbMfQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MN0PR10MB6006.namprd10.prod.outlook.com (2603:10b6:208:3ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 18:51:49 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.023; Sun, 25 Feb 2024
 18:51:48 +0000
Message-ID: <ad071ad2-693f-4689-a324-37e80495635a@oracle.com>
Date: Mon, 26 Feb 2024 00:21:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52471: ice: Fix some null pointer dereference issues in
 ice_ptp.c
To: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Kenny <darren.kenny@oracle.com>
References: <2024022546-CVE-2023-52471-ab29@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2024022546-CVE-2023-52471-ab29@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:404:28::24) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MN0PR10MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7cc271-e4fb-4feb-0d6a-08dc3632d220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Wd9RE132+0O4wNQVD/xArHtu7sWWGFNj2yh9bZwl4X6zCrP8CnZVo5ucQh2whHwSo7D+IZOKyHfWD61nDqOwIFjWdpSvoLrFKTnTpOJ2ATZ8EmY5niEAFLwnS11B85brHXrKtb89Tl76M2Sc7ATWIFoO/5XPWYlVJCZ3UUh+DMuJ/Y4vnSVYC1LVAeoyrSyghkFeVqdnvKMaDiho8/hRChfbSsDwCimhoJXYnPHevcG4B6jsApej6P3A1K7vO2obWKYKxGXUqIKRL/3anyzuAjCkoSYPYYiEOmOxQ+GiVVnbfg59P99dbwJ63AWyPsLDG4zvAI9hKEsOA5iGkZa5mxbZfAzSs+7bX11+uGPu34sErYF+j9khDQuRAe1pKJ1rsNtHXaTQM7Dh/BFYdbyQCld4cMfx6mhptnidlVbal+UytzXTi5NNg1vUudjhgGAAP9r/Vba/pqmBkV9LUXPj1U7dOaPDetXxoPhXF9D4o/UXHNkaEQjbJhyC3pgmrwsnNeOACKyP/61jeu5+HlNDJw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M0lhVDZOb0dUTDlIaGtPNDFDbTZsTHN1bS9uVHhTT1lGMTZvY1kzaFZCVTJn?=
 =?utf-8?B?eG1iRWw4am1DczZtRGpNa3FoVU1ObWZlMGhGODdOZXdPU21XelNvVnU5L0FV?=
 =?utf-8?B?OEwydTMwYTJWTGh0Mi9tWTFGeHp6UHhMQ200VUZtV1BjMy9CSUw4aTRwODlX?=
 =?utf-8?B?Z3NSMHIxdldPN3VKak9PSWFUd2IxOU5oRDQ1UnpCUkZ5bFBtZG4xSUxKNEl6?=
 =?utf-8?B?aXpaS1dMQU5WRjZ6TkhPK2ZCWVlqUzhRMU5hLzI4Z3FOWjIrYVg0ZFpZMzFW?=
 =?utf-8?B?SVVkZ0VMbnFTbFRkMy8wTU1TamYyL1FkM2NEbXVkNWYwZzBPbkRRZ2RuNmhl?=
 =?utf-8?B?Ukc5cW5SVlVXLysxcFhpSlVaaGZWK0JMMlVEOFJLK3NsTk1aUjRjTFE0VE1X?=
 =?utf-8?B?SW1rT1Yvc2wwVkgwWUN2TStQVHZuMDI5Y1ZoRWRIS0tNK3Z3Wmx2a3NCcFJn?=
 =?utf-8?B?bUQyYzljU3p1cjZ4TllUNVV3Ymxva2V6TC9HSm4wSkFqNWpEc2FSdHlqMDQ4?=
 =?utf-8?B?bXpvT2RhVkE5aGpSUVdYTE9jSmxONU50OFA1UFFuUHRnL2RDNWV5aEJ3R2Iv?=
 =?utf-8?B?WUp2RzlITmVIdVZmd1p3L2d3UnduR09xa1RoV3dkQjVUeUNvWGRtV0xCUk1k?=
 =?utf-8?B?SFREaUM3eE5uNWhtMjAvajI2VFNzWG5BdnY4WEplMTBVSnFwbjh6bXJ3Mjc2?=
 =?utf-8?B?VzZySTN5dVZraXFhWUdyVUJESFBnSE8vTzV6ZWx6bEliaGtzMnFVV0pIK0xV?=
 =?utf-8?B?MGE4K2lTcGpoV0QwMWFCZFhySWlnVnRDU0JSdHJ3d1lJY1MrM1IyUURFM1Rs?=
 =?utf-8?B?TXdxeVd6SmIxTjIyRzhJb1BGVU0zREMybTEwcWhRbVp6RjlWMFF6RFBEMnp1?=
 =?utf-8?B?RWtoK2tvZndYekRHUUNUT09ES0tBeGY0NHJxUFNWUlhVak5Jdm1QdEMyNmtr?=
 =?utf-8?B?aWxPOG1wbGpibXhuQW5vaDNtaE5FMGJrWWk0UGxCZkp5bHJVTWVSa2NrUlJX?=
 =?utf-8?B?eGlWaEJ6R1d1ZjNxK1V4MUJDTkdWZjE5WmRmRWtBcVFBT25jNnV4YlZ2K3pE?=
 =?utf-8?B?NS9ybFB5Q1NNWW50YXhBMW8zVmQ5czB0cER3V3VsTDV6WXRQNnFDN0RzYitY?=
 =?utf-8?B?ZFhyNytrU2lRa3psa2RFMmRZVUxqek5hVmo0YjlpUys0UVZkQ1BScldiMTlp?=
 =?utf-8?B?NStMSGhhM2NpWmFIc1ZSc09oZ2ovLzJMaUp3U2Z4OWZvRmVDdXRQSTFOOTBB?=
 =?utf-8?B?SThucEQzbFY5QzZVVjdKeERNbGNVdXdvSDgvazFHQ3o3MnVaNlYzUFNKQnBZ?=
 =?utf-8?B?ZFRmMzJKZlRITHd5cFl1ajdFVXZKb1FsdjJld1NyU1pIN0ZGQWFNblY4Z2lr?=
 =?utf-8?B?dnN3YnlzMEo4RlZFNmwwNmVZWE1EOURyVGxNVzRRVGVvazNMcWdwSnZ6YmpM?=
 =?utf-8?B?bUEwT09ZTkd1eEM3Y0txT1FhWmZIMmVoVzdlQUt4Y3U3c3djOERDT1lwN1oz?=
 =?utf-8?B?aFdmQmVoN1ZXS2xMLzhJOE1ER0ErdXBTcU9wbU5CcUQvOXg0SE5wQUJsZmFs?=
 =?utf-8?B?QTZIWEhldi90Vityb1BXbU9YeDVzbTdldnUzdkRyZmdnR2NlQUY1cGZLTTNY?=
 =?utf-8?B?WFlndWZrMGNYOEJhM0w0bVZRUDdVc0IrdE9iRVBRUTJvVGtDbGtBczVrWkJD?=
 =?utf-8?B?eHRiVTJHY2VUZ2tBMEFHaU0vUUVpTSt3THNLbm95UEgzclR0V1czRlI0c1Js?=
 =?utf-8?B?bzhkWU1CdXZlY3UvU0llYkFaY0VaUnNiRWV5Z0QremJXdVdEQmhNK29wbGh2?=
 =?utf-8?B?Z0lXMVZyWWNKWDhtM24wVzlHUXhZTkxtWU9NekhKTEZsdWsxYnJtVTJEb1V6?=
 =?utf-8?B?ZEgzK1Myb0tJdWVUWDBBWGxhaElad1BVNVRETGw4bFVMdXZaeFoveW9vOExo?=
 =?utf-8?B?cDVVYmZUandsQmtWdHAwOHU2THNvZklYdkhKVFMxY3dUQm1BSzQwR2ZWY29C?=
 =?utf-8?B?c29mb2tUL2h6R3pJYk5JYzZGdkJHZmxCTEtmZjRWcTdBQUJUdXdJRVZiV0RS?=
 =?utf-8?B?WHRFbkJvaDdoeGU3MGFRYzlIVnV6N3A1ZFVGclJHUmtCc3RqbjNJek5kdGZw?=
 =?utf-8?B?cWc5NzVXT3VhWG5zYnY5bzF2TEFjeFZPRVlIZnA2Q0VnMTQ0SHVVTG5CSHg0?=
 =?utf-8?Q?EZDsMH3OGOPuEKr+2RIcl24=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bv8VYkhn/z/FbgYzzPSb5CsQSRNupJ6TCuMASchoQ2gcIHao5J6Wjy19Wgtwwjq+GwFRhtFWThnvDOQAaVz2BNBv5j1WwUGV4lgdApa2YE8C3KKCGmiT08nWu8aGIHi3N6ez2n4ZxRtb8ZcC5gXZ00V85NzwcDEMLKowYPsmGT27+f5f882tITMk+p+VM611fdWbc3bt0HDWfmHKZzCWTkTrByP1iPv/uUYI42S1Oa8PcCkSQA+roewrObLixjZKPg8Ti9BUJoUI65pUcQgGRwnuLEMAszJMwf120gzOfQs8deytYzGSZKzatdaSlvSCLP7ouUOwbg22S5E3yuYiC7oyZXjcub3DU9Ly0tobBk7TLDF3ZTlrq6mhF0cfOcip+N4VQzAYP/vo/xmw8MstYl/tWWgwZq5gp3eDPaDHca2EIN6DEyZrcYl1+YFctl+sC2D0kbZIu3n8GwPY1rqJ7jZcdO/QPCsb5Dh+1WukE1yBYrr4k96ot7bCpcUCPzC/enMT0ZeOOriepKgvmCFdBUhcHo55N/l0rT12uyHsybLsOXMLJNyNhlKzPwAfqccRzqvFNk9mhdBNSlp2sqvLARcdfFNGz5JQCTkDeehlHtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7cc271-e4fb-4feb-0d6a-08dc3632d220
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 18:51:48.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pi2Fo/yFYuXcSUu5JG5RVdZLIhedDAQ8EPb7UgsnMm/1QqbECcI1D9HQ3AcV4BQp2cjoIBi0leJO9gEkD5mD3bFH8KTyordL2fNZLiXKmy0kwAt0ZVVVZdaT0NDE3nX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_21,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402250150
X-Proofpoint-GUID: _UGiy6EC91UBCDzS8LGWIVlvm-gqLiR3
X-Proofpoint-ORIG-GUID: _UGiy6EC91UBCDzS8LGWIVlvm-gqLiR3

Hi Greg,

On 25/02/24 13:46, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> ice: Fix some null pointer dereference issues in ice_ptp.c
> 
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 

I have a question about this and couple of other CVEs:

CVE-2023-52465: -- devm_kzalloc() and devm_kasprintf() failures
CVE-2023-52467: -- kasprintf() failure
CVE-2023-52471: -- devm_kasprintf() failure
CVE-2023-52472: -- allocation failure

As it's widely believed that small kmallocs cannot fail, is it worth 
having CVEs for the above bug fixes ?

Thanks,
Harshit

> The Linux kernel CVE team has assigned CVE-2023-52471 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 6.7 with commit d938a8cca88a and fixed in 6.7.2 with commit 3cd9b9bee33f
> 	Issue introduced in 6.7 with commit d938a8cca88a and fixed in 6.8-rc1 with commit 3027e7b15b02
> 
> Please see https://www.kernel.org or a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2023-52471
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/3cd9b9bee33f39f6c6d52360fe381b89a7b12695
> 	https://git.kernel.org/stable/c/3027e7b15b02d2d37e3f82d6b8404f6d37e3b8cf
> 


