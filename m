Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E4810F89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378769AbjLMLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378668AbjLMLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:13:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68583B2;
        Wed, 13 Dec 2023 03:13:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9Ssjm027171;
        Wed, 13 Dec 2023 11:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8aUvfC+Wuz8le2aYTYhWk7PdVgASHR0wg3iRYr44iJQ=;
 b=NfaqtnIq5ZqXQTxKxlSlJQsh5kyDiboLvO9hSy8tet0P+8LywbaXNexcDbSZ1zCMkHwX
 UNeFx2YDtm/xZYXuysLI5qH2ut4XL2fVfL5UgV6Gmtsm90BUoF72DMiJKOByNWe4/BIT
 5wSLPciCZgfdf6NURRswng1gWcS3GbhjyBc6wnl9aorVZDPEFn667z9Z59aeZ7chHIPL
 oiEm342qxYsd2adImyOaopPWs5yc35ITGNreaLDmL/bKMaFRul0Tl5i+nzSLqbnszdAg
 877zl5ySp7S380OvHCj5L3mYVwHSqKA2Q3f4+NnNJ+jidTp3T258P9nbay+1cFj/ToAJ sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3p7tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 11:13:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDA88H2013058;
        Wed, 13 Dec 2023 11:13:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep83y7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 11:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYv4tHMqpvf2T6REw5/aPVnFqB5DXRwFLyT3SP/a+LwoUDppXRVeKqvMWB7wDWS26IBJH6cCYDxFI1LIh9phTWdaLOcAlOqQ2wO7FnfPm2PtYBhx7KIsoO49Q0mzoyD5IiRw/L/WhPy7b/mG7g9anDuJrgNb38F9iW2cTi6/qeEO2tn1m95hyLhddqVXZ2j+rBjEJxph0vPRPIMoEHRaa7l+c+JhtsLd1Apb4QLjsTVIdBhkG3o6i9TgbOnS7fi7cYYAJv5MHSrhPxxuKHZC5xxEnIjWzc58pcscS+svbVc26TFlQwC/L5qpjIs73xCyNJXjFEqDM/MqiVOCdq/Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aUvfC+Wuz8le2aYTYhWk7PdVgASHR0wg3iRYr44iJQ=;
 b=G9bNWyrAJfhNFHk/pU7Wm2oE8KPQBXwDsrwpng43m2M8YZcG6lPMSasbeC64cjkUTiu72Lz3DpgvuIJgZSwH9zT/hZQc2WZ4iRhXuy91kNSuutSItLC8PTcLdQH7c+z4UBjPgZKFKI2xH4ivB9R2BV+ExA0WE7jh5HVJWM7SMUjsDMwsANutx5ERHh/c93RhPoeo0vnolyPPYpVBOe/io29AGxBTTtKNXCo+6UbFYO7m231YTh0GH/zAMxJhFM7SPEDOgmybzhUeob8so85yTVNAj8LMB3aXoulG/pOorHg2kQv7PcHCMwWV9PtT5zfn/7pqNusi8kCUmqPMcsQ54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aUvfC+Wuz8le2aYTYhWk7PdVgASHR0wg3iRYr44iJQ=;
 b=obIuMD8jTVBk8nywaRZTK1f66kymz+tnPn5Ye7yk4N69iHXQiX3exQ4qJat7lBkQaxzmN+reL3obiIAgIgJaO3UQjRbfH0NxsTdbRSNUO/c+eXUMFjbD9x4c2i5Qwk7TEfr21T39AvUP0Pz0BezIzn5ieBVJFLUzBDydv4wjYuE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 11:13:30 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 11:13:30 +0000
Message-ID: <eef82056-ef8f-4f53-a512-1a39ea9e90f3@oracle.com>
Date:   Wed, 13 Dec 2023 16:43:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20231213110725.2486815-1-harshit.m.mogalapalli@oracle.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231213110725.2486815-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e116fe7-5830-4bdc-2d79-08dbfbcc896b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlFrQ6dtKP4SIZbkDZGM+SOTH/0c0zd7amwTpgrkK3z/pB9hvOdyjXNXejFHrSsZdywC9UvJ88xHhuyskcsmPo7+Q5AK6hM+VfXQ2SHfF1jV8FiTHrf6cmyz8Yb7K3E7lyZx5cnW0mh4wESP9m6DLh0yaOZ1Bz1VZQo11AM0F19yqDXt0SoSLB7f/ZQ222/PQgMmoIsus+p1eD6OOSQhHy63l7Zk+CLZjrZcrUaQ4wO3Db9hJ6ajFtUQDE9S4P8/HwdfxV744/C3s/rC8Vz2iy98h8SgV18mEDxqGaiRYcMRZGvOgocDexfIj/pMLx5woOLzJQrckJIGJgFUMx8SRO8sGb5oB5Vtc0/l1LLE9+HQdNtMxVru0ca9RvmJqm38s5F5YRflQO1XC8L+jkXCOvA70A1B/H+8WEwKxyP+U2No4vTaDpVPp/fCDZ+UIKeRzxVUUHj8AkG77h/cby5Hqa6uJRvZJOpNd7uTlhuCUUUQjIUK90Tb0lA5NsL8NauE9xcGZk5vJmdbl63JmNDKBWv6lynw/3+t25XIj6F47CVKGkj9HzXrLpBXXtNcBKUBy+js+e9zNoQ1yxv0vnGsr5ZvwkLwkmnaA9gb78d3lIh7jwoIgKzK9jp7JngGv3dUMZcEqLllzHi4eVOTQnTtfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(66476007)(31686004)(5660300002)(2906002)(316002)(6506007)(6666004)(8676002)(8936002)(4326008)(41300700001)(38100700002)(478600001)(31696002)(86362001)(2616005)(53546011)(83380400001)(6512007)(26005)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNVR3p2TFRUSVpxbTdhYjNjc2NSZzV1Y1BPTXVRenUvS1dGSS9acDFBekdj?=
 =?utf-8?B?TkFURDhVbVpZVjRHRWJ5Tis0eUlHalI3WHMySm9kUlF0RkxhSGVUQS9ScXA3?=
 =?utf-8?B?K1VJd1pFVnNhNnBESW42SWtzQ0c3SnhPcWREWjJtQTlrWkUraCtSSTlRWFpO?=
 =?utf-8?B?Z3BBU1hMY09oRzJvVHpMZjNjN0d6Tzc3U2t0a0Era0RSR0VNdGJmOStpVXNy?=
 =?utf-8?B?VzMwT0FGRzQ1Q1pZclVjd1ROMmVqeTBPZUQ2ZG15TVNvb01GWjVjWERLVUkx?=
 =?utf-8?B?R0Q4SFI4VjVha2p3UHR1V01sRGpTUWhLRGloRGJIdnVTcnpFc3BETlBFbjNm?=
 =?utf-8?B?WFN2VlRCNDlIS3pLVXNwczZFNzdLUHkwaDZHQXR6ZjVUcjRwT3ovaVlobTJs?=
 =?utf-8?B?aks0K2dnWXdaZThEaDNadzBRQ3o4ZklPOXNPeW5SLzFYZEVrNmhaaUtlOUV5?=
 =?utf-8?B?dEVFYjZta00wSllpSzltc0N4THZkQzcrQjg3dUhvc1R6dzRyVk1MUTRrLzBR?=
 =?utf-8?B?NFZ6OEZ1RjQ0N3h2dXhTTHc5WVJlNnF5TXdHNmdJTVY5b3IrVk9Nem9TSStX?=
 =?utf-8?B?Rk4xa0VjRUlhd1MvL2NqdU56KzJDNTJJTldXTWE5V090UXlPMkQyL0drSE5O?=
 =?utf-8?B?Z09vdkVwZ28waUFDODlibjJZc2grbGhMSDhDL3NYd2p5RzZ4VGUzQmlPYitE?=
 =?utf-8?B?V2JxbG5RSEZQdHhkZzdRUnloNXlmSGZsTkFMTkNwUkxwY3Zhd0g5czc0Q3dI?=
 =?utf-8?B?UnowcFdUL1o2bmg2SjJBVG11QXdydXgrbFB3OHVWT2IzYXdYanhxQXd1NkRJ?=
 =?utf-8?B?ZDg4dmEyUDM2eWxnK0tFME02aWVSd0p2OUVCRFdzSXYydmU3RnFSbXpyakYv?=
 =?utf-8?B?YTZ3ZmE3WDRmTk1oOHpXbFg2M0NYbFVqSEhwWDBPeEUyRUswbXNoZlhaNjc0?=
 =?utf-8?B?M2Y3UDlJcXBxcWVrTEJmd2xrbEFxRzlQNVk0d1F3WWZZTWVrRTRaQzgwVnBU?=
 =?utf-8?B?TXRSVHZ5Q2ZROGRlRWlmdGtlUkswbjkrU1loWFAxVmJaTGt5WGxrSjNHUUF4?=
 =?utf-8?B?dCtRZjNEZGhrZ0RtbUQrbFNSeDhzNXFDeW1nc2ZkNHdDd1h6ZzVPRnk4R2VX?=
 =?utf-8?B?S0lCeGZsbloyd0Fjc0E3bnRpYlJHZUFGUTFpWGdhVHgyUFJaUHJYVWRyUmVN?=
 =?utf-8?B?dC9lMEQ3bE9HKzdyQzB5M2tVYTltK3JCUVUrZ1FzRU4ydU9KYWFnekE5RTBu?=
 =?utf-8?B?MjRiZW1NMCtnZEtVREc2RG9Qbm5kMG1jSUhsUTdwWU9ERTQxN3ZKREN1aXVE?=
 =?utf-8?B?WGMvNGhLdDA2dGZzZjNrdGFIemNCS3pKWFZXZkFlTW5NQTYxZDFXaHB3emFQ?=
 =?utf-8?B?TlI4RnkyNjI5ZGtpa0l5OGNvR1ArRkRWRXNtcFprTzlUaFkyVzRUV0NPOTgw?=
 =?utf-8?B?YnJOZUhLQWVVQzkyZVF4TGJQMEluSFM4NEJNNG9TZysvckhZUkFtUXRTZnVz?=
 =?utf-8?B?VkMxd2FGdzdjTVhRREFDVTVFVndMV1ViNzVHenF0OWZsdENTWXlRTGZVQ0FP?=
 =?utf-8?B?SFAxa3VYTnNyekd5cVpnbXpuYWt5Z3I2WjlpbEVhKytSM2RDamsyckYxUDY1?=
 =?utf-8?B?U1dOTDBRempmdFJwY3I3UGxpZml1bmlHb0V2VENKMlJPeGk2eHNSOWlJeDRO?=
 =?utf-8?B?OUJYd0JpVFh0bmtGNE4rOXBPM0FWR3p0QkgyK1dyQzljTmIwQ1cxYXZudGFL?=
 =?utf-8?B?NEFyd1hIRjBEcmh5b1ZQell1ODkzaVIzdmhCN1NXZllhclVPVDJ4WFhyNnVu?=
 =?utf-8?B?NHdRQ2FzdG5Wa3FTb0Z5Vk5hS2FJa1hTa1A5ZjhYbHpFUHBRT25xSW5rMWpZ?=
 =?utf-8?B?T0c5MUwrVzNqRUlIQzRUcFppSjZPaEdMYURYMzV6akNNbzlJM3NWMjJRdzNU?=
 =?utf-8?B?OVRwdHpPRVZLL3hPam1UNWpvaVc2RGxINTRTWjVIWEl4NlJhdlptbW1UVjlQ?=
 =?utf-8?B?ckxudlhyLy9rYllLcHNOSWxuRXZDTGI3WnNwMFh5bGluVFVEODdsbWxCeW9u?=
 =?utf-8?B?cjNTdCtXNkI0RVgxaUx2R0NDZCsyM052cWM5aDlubUVQQ05veWFQMGwxWHY4?=
 =?utf-8?B?Q2RKbVY3SGpUUERJT2M3TzluLzFSenAxN2lzTkU5TGNNWEkwUzVvcEQycFlK?=
 =?utf-8?Q?ZfyFn3OqaeXhIoAMOjEkSFM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 15jGtvN4HDdIKXLz0cfpcNiHooZjX9nXVJUUxQg/O/dB+OpftLpWhJyFeFeX8QgvjdAGUDkB3pmuQgS+w1c/AA1lWZh8ywuz/gCZeYSYAXRTNa8T7oFvQ3XJVO3JA8tnj6c2NL+CHL/d3gVKTcXVuUgTXKKlFY+Zq4Caj35O+ur9lX4zKoXbhkuIvmbhL3nlUDp71SqkFFhGxJDQyu56r1jixR3ZKLcZ+WOpRhTBwH96APKzu1qkp27EPMgL1vQ3jutHNczx0ZpAuY5TbvFRLzgKQxBcHTbyoLboDOxosBLjIydoLcJNrqwweIdj2/CgZtFX6EV7HjlPDObacKiSInDuRNzw7EcmAEKwzqJ73ma/WTC73KwD06TW02mRR4X1J/e62mrX8aL+2X+ZOr0kl+DawKSSANeuBtTOoSf+V+KfXmoMhZtDsCv3eW3AHUcw3j36NxN3Yy49caw+nkfn4uWqzXPu6JmiDhvdlSd5a4eMru92UFJ32ONf4BwoPltwpYfG1PKmoqP4lbP5fpxxpxg91xgH6GMD9Or4eSNTPW//OrsVgElzk1kIi0fbrYweo2gFFU3eYkWUGOwM5U3G3+b6tmKHDuaS8wG9GIUVgWq8dpeK5icQmUd1ofbzo+BVWBTEZn1SIks9oAzVvJQEFRmsD0VZPTqmwfTgroJb6OICs6OcqmYmB90VVZVzhJjJ4bZGZcIRaSVyhH6PTmr/xZJI/3KTGv7GdJl+9Sw1u43FXQYVoFOwJhzuJYoGLwR67gBBnrXKV4TyBIJFtcvQG8RadesvQIiAY5W5RgnERQnHfECffdkO+o79mbrr9In15FNiCL57tDMLp2fqmC/HsK9Q4cWqt3Mzvn3B30490HhvjqEqSwf1i8GmePdRGu0PQqvNziSRRyh7UzTRpo+34g/db5W/RF3S0ARRRtb4Ak8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e116fe7-5830-4bdc-2d79-08dbfbcc896b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:13:30.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr1eOtcPH2GDqm7aZ6Q2liB5A3thy1x0qZEiKZEBWKBr4XTDiNFryvZh8kzgKbel4NmzDKaiifhLB2pY9GfQJIds9aLXg1aSeKfVk8Zae/2viu61SttiGsc7HzCrKXFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_03,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130081
X-Proofpoint-ORIG-GUID: lfn1xqrGdT4TUbWjVTtepqthTCbeDLBE
X-Proofpoint-GUID: lfn1xqrGdT4TUbWjVTtepqthTCbeDLBE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 13/12/23 4:37 pm, Harshit Mogalapalli wrote:
> Free the handle when the domain allocation fails before unlocking and
> returning.
> 

Please ignore this patch, I have missed CCing correct list and few 
maintainers, will resend it correctly.

Thanks,
Harshit
> Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch, only compile tested.
> ---
>   drivers/iommu/iommu-sva.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 5175e8d85247..c3fc9201d0be 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -101,7 +101,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	domain = iommu_sva_domain_alloc(dev, mm);
>   	if (!domain) {
>   		ret = -ENOMEM;
> -		goto out_unlock;
> +		goto out_free_handle;
>   	}
>   
>   	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
> @@ -118,6 +118,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   
>   out_free_domain:
>   	iommu_domain_free(domain);
> +out_free_handle:
>   	kfree(handle);
>   out_unlock:
>   	mutex_unlock(&iommu_sva_lock);

