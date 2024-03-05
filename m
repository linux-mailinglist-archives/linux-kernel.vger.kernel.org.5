Return-Path: <linux-kernel+bounces-92935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649587284F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD73B29453
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366C127B7B;
	Tue,  5 Mar 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="An8rDUCJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lx6H18ZI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46960EF8;
	Tue,  5 Mar 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669256; cv=fail; b=oX7Ge8565zMx1HcIIe/A1UjRpt/H2GiGQ8WaGPuK3pZyX+9G93AMdnVJzoUmzWNKcMI+Fai5TyltZ2rDzoXeoZnpvYTTOvNWysradcNjyMuK1bh5e/WHG94/ubsfDvxz1IsASBWvuPlsKthgoxOlfGS14/1ltIImqkKyw8SM7bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669256; c=relaxed/simple;
	bh=lm9fheTAMG7yBgm4Xli3n9WmVtt8+zT111C1ryDqTxM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ck1ufzK6IdNGSdm8XVGb5boa4TxWtmb2g+NSQJN9IzVvKuWBIOhbNnz2BT/ua2RjR+/KMe8FgJjcuddY4VaSl6QD/bHMV9M1cpwkUrzcl8rs6Ef3JODgr7vR7H0/P0izSbSnn6GTjJ7xINQ+jZJiJ//mYpWZVbhLeUZ2LOHEzsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=An8rDUCJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lx6H18ZI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425Ix9M7013415;
	Tue, 5 Mar 2024 20:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6D9V2UKpMoQTcwV+cqNjO7lXmkaIf6V6vFJsm0RQqW8=;
 b=An8rDUCJqLgzN6dLroGPxVLzpr6GDTpMLgZj+itaGa83H/9FZ5BS0WXBn/S18r6r1YN8
 1CXdyj0CG9JFXa3REqUdKVuBWp0gfAbzgdBCEbxtpK8JWPysKqhe5TgNA0PYTq+XtVZr
 ZFZZjT0hsEq+D6eJyc2wJI/wtvTQ08vzh1FUhT8Nikkq2d8DJ3WBvPHekXy8J277se6g
 MhnQbqhA71pEHukQ8bc6WTv3mqPLecXo1vHIBh4jZvuhDgbolz3cdAJScJ7MNiMUdH+o
 VAAPPN19ZlxfOe5Qrc0pEs7eAdDxJbpv6sXce1YozNfZdM8jorR87x1GchrHlbLz2uwt xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuy6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 20:06:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425JKTLo016100;
	Tue, 5 Mar 2024 20:06:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj8ev6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 20:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAUxsscy6VTHYZEU6ZxC9CSIFdzIFzAu4iph5ZknRlbLqBK6UJZIjxYmVYCP3aFOpN/BRVO5W4GAR0hr84jzSdV3ODp+Qnqwfd2j8BeJtdKXSJy808pcKTbUyvKNvx2K/b+wATJBtu5kgPvfhhCWrOVoRwO2mHmSY/9CzyQDywmE5YDkPIV+EbuXFTPw68tMeG2LrSiMaOpyQYXJrmuTyOm5XnhzcoPTygK8ADnSfZ158J6bnysD5TyA+JhYvVk3unI27+y7oeJcQKdXGCKUeqH4xVz8IRZwLcWQA3/1paFOPfq274et2UyYdNBGobb7ckPQ+SgMxTxefk2RiWdBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D9V2UKpMoQTcwV+cqNjO7lXmkaIf6V6vFJsm0RQqW8=;
 b=CXqFC+OS10bIz0gh4KmQOCeOp8HWCqlz5AO8u1mkdQs/PnHrJHHIWkJd8mtMn+8+NTIDS/oIn+CSVxt1N2dpmCbSGOKKzHPF0jH57dL/cQ5ZnekL7x7Isc1PrQxK9gLSmHAM8PTEvdKOqaA4kEiXvF04I1Af+ID7uHiVFT1nHHHjlnqoDar3TpYLHTet8PtgEkGsc/pYwqyR1OqA8IaTh0E+tAWoiKEyTponm+XSf98IKSM8j/fGK3HMZOCAhdgsMdLfKgF/hpcgE7Xi+B+KK3rDUt3X8TXNNJgoQeJ3RKul0vT93+0caamdJDv0pJ2NX00nwq6xIiz5QMCtzeVt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D9V2UKpMoQTcwV+cqNjO7lXmkaIf6V6vFJsm0RQqW8=;
 b=Lx6H18ZILIduO2qrsH50duixxsyQcm7M9v37pe5PDOiTW+6SRjanjbrz4hYxvqXd5AHi6gXGBI3LwHHcclGcK1Cb+7kZj9Uw/ln7+KwCuWt09kPmBqy2QsWAcQdsNV/1hFjxCATZ1T2Y6odi9Bx/Nn1GY4DJKi/ebVLeUYK3UUE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6674.namprd10.prod.outlook.com (2603:10b6:510:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 20:06:47 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 20:06:47 +0000
Message-ID: <fe892840-9cf1-4b67-b363-7d22ff4e83a6@oracle.com>
Date: Wed, 6 Mar 2024 01:36:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/25] 5.4.271-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240304211535.741936181@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a29db41-4e69-494a-a624-08dc3d4fc980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/EBo/YsMav3oyHg00A7ZcBaCI581a1NF3ImiC3wDg8RpNyXJRLWk3M1AWCf5Q0E5dKqq0HeJsnDkgDCERbsdTuPTwEsohMZtImnpXjfckZuKx2ANjhaFsROe3v5j6zmWCtMVKSruTX8vFuVeU8gGrqecok67nGDxjkizIspBrRQyLG/BXzlTihmVYriEWnlPuMijqcguqFayBvbL9i7Wr+NrRpRNRQmpdM3ORfZJOjNO4N4ftfAU4oWDsRk58Qo3VztYgiGPjVvMFlD3ryYCvg5f3bU4v3Xd+VCgN7UayG/5mx4Z25zUqMwoe4nJu/41jPB189aEJfLqH05WEv6oJtoFgnvGEinxNe7PizjsmKxu8XZUac+S2+v8kR9pm6pL7MPGcgQxHK9+VmQFLaSnbMg0s+ne16g7q/P2vMAgzY1EQ2B5LcxAgFa0Mn5SukH/1cgQA9Cgz3WdgekmQ0Th64f3XdYtk2qJzCsRF0w0M19kjaqvfwL7heA2tpltQtf9H70PWxv5gAXgXrY5FVHS66hsuHTRIRK47u4Q/xAuKIiye8gjqvoQHvDbR0jn65hfpgpxmlBmvYcBfh6Z+CjsRbgXGUOTHrMFcw7SakZEJys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWowRlQzL0pmdHNCTWl6c3lnODdPZUdKQVNoNDRNQWtCZVB2bEF6c2lCYy9Z?=
 =?utf-8?B?R0xzRUtyY1VqNm5scm5taVo2d1RiLzM1STZnT0FJZU5Pb21jcFVmaTdTM1hM?=
 =?utf-8?B?bXhiVHR4L1VoM203bUQ1NVdCRFVmSXdGTVN0VENPU09LZVNLdTFwNndXZEtq?=
 =?utf-8?B?RVNXbjgyaXZxL2NJV3VJUHVOeHlDTGxXS0h2b2pnSDB4Y3dvRWhsYldUZi8v?=
 =?utf-8?B?dGpGVGEvQXZ1aFZFTG8rQjJpc0xKYXlKNVpzbFZqYkRMZCtPUlNRSkV3aVNH?=
 =?utf-8?B?ajZjVWVoVmp2M05kY05HVURUSzdWcGpqaUN6b0hqWGV6b2ttRjJpdGNnR0U3?=
 =?utf-8?B?OGFpajNUbjlHZjhRRFRibENXekF4dTVHVXJnVDRPRjlGdjZVNituVU1jRkNo?=
 =?utf-8?B?enhKQ0R1d1ExeStQeWVjdUppMjZLNXhNUkdnY0pOWGZJbmlneHRGdTIxaUpo?=
 =?utf-8?B?RG5LMTBLMGhqblVhNGVuK3A5TWpLZlNTWEJRWXRRMFc0MlRxYmxYSllsN2FG?=
 =?utf-8?B?UUtQRjlJM2x6d3JBcHlNUTYzQUV2Y3BMMXRnWTA4OXpWMXdvV2dqc0RiSzJC?=
 =?utf-8?B?d1dZYVhxUGF4cVRaazdWS0N3U25KRzlFeCtuVU15c241ekJxNDhkYWc2bjd6?=
 =?utf-8?B?M0hXczI4UDVNYWRYVHNzMFVmZElmem1XaitZOG9WakQ1R0lwUmF3eHBLdjBp?=
 =?utf-8?B?N0pTMVRScXVleERwb2VxazBpaDVNWjd4UkxHVVBMNjJWK25yVXR0UWgwWm91?=
 =?utf-8?B?NGdjWWNUNVlLY2dYZlE2SmJGbTl1UG5RSC9GUXc1RWZQK3lFVEpFWXRpaTVz?=
 =?utf-8?B?d0d1R1ZNZ2dCdE5LLzJPRDdTUDl0Y2gxM1lhMi9JUDFMWkx0clA4Y0t4WEp6?=
 =?utf-8?B?YVBObkoySlJ2dkM2ZEhncURTdDNkblpJc0hwRFlqdHU4amI4aGNDR2huYXJu?=
 =?utf-8?B?eUpyRHpmWkNaZHA4SDltdDFxMnhIcUxxVFJUUHl5dk1XMkM2QkNYM2g4bWZs?=
 =?utf-8?B?RXZBOUp2TU81ZmJhRitTNDdpUDQwVW9OenNaRmtaUlU3T240ZjIxRG1xNUoy?=
 =?utf-8?B?VGFBZGtmM1pJdDhwUGxJSjVGYnNINkN6cUxqazNIaVpndEI1OFhiZVJKTTVY?=
 =?utf-8?B?UTIzSlRqWmFzdTBnTFdWUVlPNEIwNkZYT2ZQbzdObnVaLzlVQTFkTjhMeTEr?=
 =?utf-8?B?Nm1KYWNKUlpMRmpKSzFrVTY3aFNYK2pCdXVIYWhrNFBZTjdOZDVER0pSblNv?=
 =?utf-8?B?NWRxV2hmUmdMUVAvNWt0TFJuS1Y4VE90dklxV0F3azZzaWM0OW1oVGRBanho?=
 =?utf-8?B?ZGtjdGtFN0JhYUc2d0hPdXZuZWpTRk9Gd3lFcUJYTjVLU3JKWVdLcmIwaUw1?=
 =?utf-8?B?bnFFUkNWbWVjOTQrOG92YUk2bUJISnZnZk51L0FHQ2ZiNG4yUHo4NUxQaWQ1?=
 =?utf-8?B?S3ZTa0cvazE0aUEwemlScHBsTncrcjJyWGxpdXRtN3oxWmlGbnVmRHJtRmNO?=
 =?utf-8?B?VmZuMlJ6ZzlwN1VBSFgxaWxQeGtQWFlNVXc2Ly82cWRrQWZsR1JQd25wWkk4?=
 =?utf-8?B?dEdKQkNkdnpBQThSOXJMUjVxemc0ZHFKRVRCeDBlOGMrZElUVVJ5TUYvK25O?=
 =?utf-8?B?Y1I1QlJqdENkZUp1TjFtS3N4Y09yU05GVE1EY21KeDM4aVlwS2s4S3J5VnRs?=
 =?utf-8?B?S1d5bmF6ZGJjS0FzTzVZaUozZHYzUDJBbGRXV3RaWUJ2UHBJdUVxcVpiaHNJ?=
 =?utf-8?B?M1orVXdYdkZSMUgwOXJyZFRiSkdwaXlscnBrblJDRkplS004S1VyMUVjU1NG?=
 =?utf-8?B?MlhyRE5YdWpYTmVIQVFsNUxsbldUY290dC9OSWVETVV0Q3d1L0NKdkkrdUhC?=
 =?utf-8?B?L3pHcm5jdTUraXpnK0JpdjcxSENjY0N3VVp2SjRlSStzZ3RVa203OXhiUkxZ?=
 =?utf-8?B?NmhMWHVtWmw4QWpGVVJISnZvWWlnWVFTVis2UGM3MVUwdk02QkZzMzkvSUk5?=
 =?utf-8?B?U2IvbW9hSjdNV2NhNXplMDc2dS8weWV3N2Zvclloa01abHMralc5VFNtYllU?=
 =?utf-8?B?QzdINDNvb2FJc0xOMjlYaTV5VUV4QjNBdnd1UWNjOVY2OEZ1N2lZbGJZQTZq?=
 =?utf-8?B?OVBhUTA0MWE1b0lFVHUwV3NyTWpLMENIUnNZUVV4VmpUekV5OGRTRml1c3Jy?=
 =?utf-8?Q?4QDV+vHVS0x+N1N2bdXw1Rk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gVOAjHpjhRe83sBeNBOSsxlO+2U6z02XOTz95/QSxNE27cNq+i30ffLrhD/ODpVfd6tjDx7FvVaFfxwPVW3PgV9GAZzUS5+EC811d3g4504L7RNTviME77ibb1xq3IB7p8mrOJ2Yrv43UDanMye1A+v35FwW6DhHcIydJQ2k0NhmrT+Q0qhsKhyMPwrmqjzevpw+iDAEFiQ6mApIfFNU63ilYbHySlU0z9OSEupky4aSC77T2puu768EjFp/r8r6toqBEGKVtkGtXIxv8Hr45Ec9o/MuH5A29XetSIJN+y0GAJ73LxROkUo8pvXvuOrFyj1NouxyK7UQaxlYSLorbA7JmdC6ZCpSU+mv10CQwYglU3gMjkGYMQTgIoDUbJk2GhAJRRfOb09CemF+ZaM40JQot02vhny9fOFaPwEhns2oLdgHco1PeuTXpUjdHBnT5t629Khr1jJjB79ZPvWUC4SXb6SmeTnz+Wt8qURJG4Y8N4TPK8BI5zCsK+WyhVn6p//ZfEZSoDa/p6jKuQGNPcEcEi6YqKHW8FnFyA/7CLxbKa0YSt1V/vQQNJkjV3vaQMLRntdYaVuHWz3FA1HUMq7f+fql4L8BnKfTiBhdOPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a29db41-4e69-494a-a624-08dc3d4fc980
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 20:06:47.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: japM3ZN4rW9+Gu756S9y2WzArJpqTzqPm4cieatW8wsbfNXkezXr58h+tU4X0y59yJDWR6a8x/z69LHjEpPuNeYcfm4IvMIKEgiJuMSTaKjsp25n+UGhvMczHJEF+GWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_17,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050161
X-Proofpoint-ORIG-GUID: Co7_QPgMgzS0hWOheZ8cog-Wu9nz_4mK
X-Proofpoint-GUID: Co7_QPgMgzS0hWOheZ8cog-Wu9nz_4mK

Hi Greg,

On 05/03/24 02:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.271 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

