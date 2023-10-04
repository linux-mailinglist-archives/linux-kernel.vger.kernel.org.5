Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB777B7A92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbjJDIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbjJDIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:47:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFADBB;
        Wed,  4 Oct 2023 01:47:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948j0M5009074;
        Wed, 4 Oct 2023 08:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3zd1dCiQTG6mO0mpsA8JQJS+SHZN/tqkQYgK95uSPSA=;
 b=3Mn/+mVj+6xbIRc+wyHRoNuMfXM6+BCQvJeuKpALiRKJUgzebcLKYGwSgLsrIYzMcEis
 cB/Y5kMY7UXGjLkXmSbMmMDEQK1iqIJHcfvtHim/c+VuxKjCSP5QGHbBdM92obOAkAnJ
 r42PflPj278kVO2/t6bQdrlYSKYrvFkDDXpxbJ1i3yD17nCnvBaZA96ZNmcBxNJCbYeH
 nNM+o2ZZnu1BYfVRBGD1+9BEPlQgZ7yMK11/mqb2r6wHs/ldDjD3BgH+hsSZFHNt0aLs
 f2e6yDus08t1hbkn1ocQLmRCM4qg35wWc50PNfZVil9jjoUinyV0bXLiSlhYGorRXFK+ bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbxgbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 08:47:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3946ZSqt033715;
        Wed, 4 Oct 2023 08:47:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47fgne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 08:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd23ltDeXtRZ99qXZ6H1KM05BYEj4EiwkS03O03qcz0n7toZqeeaGG8qAlOwZ770wfJ+Ntc4erZdhdoYJP0A2EDmTVn2EewiuX0GpNV18CUZl4vn7XoPg3W2/WxUi/tKhn8C8iEcq0TmRnhOcW5RZDyliQZVWZlAl+7gjhqF+AoqRjDh13ARGItALkxw4EuFdyc1SRUVTNKYMAzpOQPI3P3RTmN4TrvOBTyhnI3GOVvPkeGVdJNG3fK4oUe5H3VM5K8uPHHfStRttgLuLDjf90DHXwpKIQqXiK2a430g56SYclgWY5r1FWT4tbjXhQH1B3/qwZJ/3OklGMhFCXOD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zd1dCiQTG6mO0mpsA8JQJS+SHZN/tqkQYgK95uSPSA=;
 b=MmA6A7+dpVMJeXbYA/k5mZqV2zJyyJPp6yB2Z7fD/TUTPimm/In86QEU8cb32CuOZMPhY4tnNWI0F13zQdKaHAg622kzo+16iiDPBMn9EMrXPHnVQrMj6gWGPPO02Oiu6I1f4jiaWrde5hY64KKe89koQXdIB1JIwzOYR8ltIWoioo/O3VaTfMrR8oPE8wABnV9xPi5IIVixy+1xMuIgg3L6SIzsAo1eZKOZj/jCI/ly/RVM2PqY9uBQUWAXYKiFa56rwFr4JdydLm7f9ED6xfocKNQo6B8TAcyLs6LPAVZ1lWFhx+pDsQJxUYnTmkYs4x7RfTpCeuStgxc60lGwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zd1dCiQTG6mO0mpsA8JQJS+SHZN/tqkQYgK95uSPSA=;
 b=ToYJkXbhmNx2kxiVKFK8Bv7hwykgSzXSeBtanLxBaq+bmo8JY2XD4p3Alwq6N2zyxN5g1+zbdIcKFywC1UfpCCac09s8BtDN/3hLl8PCgBn3MNb+bm2gp9CB4wxn1V1FFGhlIbcH53+URFrL3Iy7+IId9obLSNmOkuX8BS1V9CQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 08:47:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 08:47:29 +0000
Message-ID: <dee45e9a-6a45-e949-2b46-1373fea8dcda@oracle.com>
Date:   Wed, 4 Oct 2023 09:47:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <9ba10b14-931b-42db-b7c2-e6f9aa95e477@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9ba10b14-931b-42db-b7c2-e6f9aa95e477@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c476f4b-1796-4009-d787-08dbc4b68ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrhcIzz0n+qrfLTmPd4H8WJIw8hnxo2hHLo8EPNLasRlb4DZlFvIbliUGNrIbdif884+JaOImxETysWcphoAFS4pa+J5x8vEJKgaKCyzT3G2AhFJCS75GgaUxvcCGGWheB994ZrOxrHYeBDg70LxIGJDelSWNs1mKaoQ4qPouxPXdcr6fXThMRTkdVqWU2yPwFdef8mZoIp0uAPvQIw9MZ/X5NU/Jo2st0K6yv7tLcqbm66hPPY7qEsXqH2kSp39by3YRr6GBz3o0ODoSa2H1mgL9UN88LiG+lV1z8jYKJxO6ljWuLsR+q3wuaM7PX4gfYATNlEgbOuzXfNr/3tVTImWMuYuOMEQCLYk3s4mJzF4EpPNQ/UvnUjoNx8PY3JAgD/Qur9vq4ctmXhRKN6CwGP6LiugWkWWx6LsxvtVf51AtA/nqVe/Z1FZ6llRxkEeSUT36CAHkgdd/ibmHllbAfyxgwGHG2X2zPOqCGqPNItUMHARrgFcYLiCVwk8fDOZP21JFX/MV1vWa/HndevQTbczKuBICvnMtOaTL2tBS0Cm2wIeq1SHaurvpYH1q343Q4G6EpH5oCipeLksJ8CB4FwDUccMkGY/WWefC//CzLVvldTktCUDE3U7pTotcSKdOliWIdGfRlOvK6eXOwupnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66556008)(38100700002)(31696002)(316002)(86362001)(66476007)(66946007)(6666004)(36756003)(26005)(107886003)(53546011)(83380400001)(6506007)(36916002)(2616005)(6512007)(478600001)(6486002)(2906002)(31686004)(8676002)(8936002)(41300700001)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZCYWtILytpTml1OS81cmV3UThRMFh1VmxmMUcxL1puRFQ0RytObmpOcGFo?=
 =?utf-8?B?V3VBaWEvK0VNd1dLa0NpR3BUMGJ0RnVGU1Rudkl2VUFLby9jQ3VDc1BTL2Nt?=
 =?utf-8?B?Q3YvaldkN2hZNGkxanFYTkxZMkRBbmFEc05rYkFlRTZ1SjZvdm8zczFIZjhT?=
 =?utf-8?B?TDF1Y0g5UEhxbCs5MUdxcDNXYyszTU92WVMwSmNuNWlUczM5Uys0R3phcU1Y?=
 =?utf-8?B?OUNCYTR4S2M5enErNzh6ampzKytsTkt2SUlmZDlzTDFFaGRoaGc4dEZWY0ty?=
 =?utf-8?B?M0RZbzc3d0cvTnlHSzRYVS8ya3dHVTJ0anRTMFl6YlNqSHJSZ0pNNm5OVllF?=
 =?utf-8?B?RjZLZStFY2JCSkFvTFNraVlBUUF2bDhiWnVmUVQwazNxVDV0Mk5tQzU3b280?=
 =?utf-8?B?dWVHQmVVK0pSVzRhUmZVTHQ3eVp0L3NJbnByRDluMG1XZWYvclIrMklhUmJJ?=
 =?utf-8?B?UXIwellUMGp1aHUvVnpLUitIM0I1MDNhNTk3dGFaL2h5YmF5T3lNeUNwYWFT?=
 =?utf-8?B?bHVNV1BYWm1oanc3amFERGE5d2VvRVo3UFFSK3l4VkJyWmp0b3h2Yk5IYUJu?=
 =?utf-8?B?YlBnQ3doV1V3d3NyM1dOR3IrQlBSNmV4cFcxZTBNaXAyNWdPK29iVU4xRjZR?=
 =?utf-8?B?eHZZRFVPM1pqRUpKY1RlUGdLbWRYUERrZVNaRlBWQjZLT2thaUNDcFZudjlS?=
 =?utf-8?B?dG93cXJIYVZ4M2NEYTNBRDlhM0pvL250YmJxOExMaXJYK0xPa0JqTUJiQnlK?=
 =?utf-8?B?WWhNdlc5S3p5NVJ6UGp2NkNveXdRaXV2Wk9iVXpIRUk0QmM4Z3NQaHlWUi82?=
 =?utf-8?B?anFWWXhQRWtYRldyTWYwQ0o5NFRSUURzLzNRN2hrRnJoN3Vlemw3aDNpdjJO?=
 =?utf-8?B?a2FUcENHcnUrWXQ1MytPRzg3bjZIdEozUldHQkt1aEMvck83Kzd3M3dOVUQv?=
 =?utf-8?B?Q3NhM2tWUkpkT2g4OUt6QVUvTzkyT05KT2VUZmZ6T051cTVOdXBXbmZpMTB4?=
 =?utf-8?B?RC95RmxkVW1wOHlwM011ZW56NG9oSXV1WVJZVmRFVlNoYW1PVHNld2NhUVBB?=
 =?utf-8?B?R2NyZFF3aHJHSWxmRTBkR284MmVKUnZKRlM0QlY5N2xPaEtPMzkzcWFiLzVL?=
 =?utf-8?B?NWJiTnc5UHk0RkJIUmRYTkw5T1JBbVhaaWRYVW5VU0JoOWpYQTExdXFTUGYr?=
 =?utf-8?B?eU1xa2UzSXRYNmlPYWR4R2lRQjBUR0VNNlhWSHFHSktFK2JPN1FPanNPTXJH?=
 =?utf-8?B?T1J3enVEVi9wS1JyWURDM1Mxd1AxSVhzNm8wdlFCZnJvVld2NHQzdEh2TEZI?=
 =?utf-8?B?am1zelRFNkh0cWJLb3BFVGduMHAyQ0tQZDdsN2Jnak1JcVVEcXluMStMQTZE?=
 =?utf-8?B?cVBMZnNOU2pEVm9YMnVtaENLeHFuTjl0N2VvdXJPUDkxSmROWWVpNzR2QTgy?=
 =?utf-8?B?eU10WDdqSXVaSzNCY0dRSUVOSDFHSGJpK3lNOHJiL2dtOVh1TFVPTWI2ZjZO?=
 =?utf-8?B?WUtKeE42cDV5QnZ6WUI5YUJpM2FIRDk0SzJsNkFjQTFKTzRjZTJubXYvakZS?=
 =?utf-8?B?YkgxSE8xQmliU09pTHh6dXdDTWF4Um9qYTY0NTNnTHBscGlXMVF6VzdNaGto?=
 =?utf-8?B?ajhwelhPY0dOdDl2YnFLeVFCNWpwck5DbnM3Vmkxc3pMN2k4dzhQUWdZNWlq?=
 =?utf-8?B?M0QvTGo4NUJQWFQ5UHJOL2pHT3ZibENXSGdNQTUwNVZSc1I1VHc5QjEvb2Rw?=
 =?utf-8?B?c0o0bWx5NjhncldzWkNDM05YTTNkZnM1eEpEelBRdDNXOUQ1aGFEeldqTUdr?=
 =?utf-8?B?cHp3TmgzSHhENW0vbVNrQnIzWGRyRnZWL1lzSzdJcktzWXZEWk55WXA1U2lM?=
 =?utf-8?B?ZGFkcW8zelgrK0dQWXpubXJYUmZBdWdwekJiYXNkbUhzZkpSZmFKZnFRcHlK?=
 =?utf-8?B?a0M4TW1mUEp0THZKd0dMZmtyOWw3U1hGcytVUFRrdFFJUVQwNHpXMHV5WkZR?=
 =?utf-8?B?aG9OY2YrS1FyQ0ZFendHblF2RXFncVFFZ1pBLzhnMHFCQUNVSVBmazltQmNh?=
 =?utf-8?B?RHlMRVl3dUZ6REZVYmFTczRXSU9VajdmUXBaT0tlUFBwdStOeUV1ZzNjSGQw?=
 =?utf-8?Q?B/JthkvRzpnpgiXEAQAWRuLnj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U2Cpw6ERee9aRfoLOhuV5fdvH5vVGYZ6Imx1A63aIUaAShySqkLVcdXVKcsE2VQyRHb0+aVl9idBt9WIcj/lArlK2kI1TecF0z0fQaYDPXJQNtRBDEY5oBDP0xyIA5/CL2uyMzem3Q4ZmBdwqJPjcCRR7i7H7lc1YJ0jB9wcjT32dqxz3CTOdq6ZSww5nXpuKLooSieR7AlXyZZMbP3NTIXs++QD6c5vVhhAsmGfr4qvB2pU3x9JrS8/khVejqtWNty7C7LseVcoUEl9uMEXUmo9E5BStW6wD4gM0o6jW9EQA+hPrIPVbWfht8SNFMYPoMLrlpv5SD+ETWgeD0ER+JW+tHnLjHyPo1ajdRMEocRJLERUPNKkzaHIWEppX81dmbf84EKdfx2/UyOP8/ry5ENTMqGs3aYWeLMLxzQ//rAMaKyFwCsL1lRRyKpLkb1+88JpWQaCTP4TZGM6yseJ13xI0sk3XNF3cqjHKfiE4qgSthpQ4c3ePi7+AwkiVIUS5CLMqP7dlIdaB5G8s1nqFPPyq5edNxIgGyOiM1xHO9IthY2ntJJ9RKQMDeKv5zFeJwCGltXYHg6Q1zpzHozhdPi1wDs8HX9s4KO4n+1b9yYi5T3Hh3j2IRCLwTwb4+kYTpeyq/z239Q6nk780bvXyvCJXZWcJPo601WnjBpxlmhbFo7cMBdL4uCdoIXpF0O55Aax8Ow66zJY3D7WL1IOCTO3/nuvXlEy+urqIsNxbfHtz4K60+58hAJUYmT0o/dco8aXqaPyvphCAj02d1DxL04xjRIpEcC9m7mjvQe2jdpUB9bTnYRxk3DqkIjwfKeaBUr7CXoeGxI96AFADgCE+3jJHKwkV/pU+5HOHL3IS84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c476f4b-1796-4009-d787-08dbc4b68ac2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 08:47:29.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aYYY3Vz21ZRCn8UvFy9KmJA15kbQkhpDhMzEdZ0C6WrEhESdIvFCo91y8IaXeO1qU99O8GgpLfUWOHVkHFuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040061
X-Proofpoint-GUID: uj7tN5qyosu78FZhrMwWG5AJouct2PgB
X-Proofpoint-ORIG-GUID: uj7tN5qyosu78FZhrMwWG5AJouct2PgB
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2023 20:25, Bart Van Assche wrote:
> On 9/29/23 02:37, John Garry wrote:
>> +.BR RWF_ATOMIC " (since Linux 6.7)"
>> +Allows block-based filesystems to indicate that write operations will 
>> be issued
>> +with torn-write protection. Torn-write protection means that for a 
>> power or any
>> +other hardware failure, all or none of the data from the write will 
>> be stored,
>> +but never a mix of old and new data. This flag is meaningful only for
>> +.BR pwritev2 (),
>> +and its effect applies only to the data range written by the system 
>> call.
>> +The total write length must be power-of-2 and must be sized between
>> +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both 
>> inclusive. The
>> +write must be at a natural offset within the file with respect to the 
>> total
>> +write length. Torn-write protection only works with
>> +.B O_DIRECT
>> +flag, i.e. buffered writes are not supported. To guarantee 
>> consistency from
>> +the write between a file's in-core state with the storage device,
> 
> It seems wrong to me to start the first sentence with "Allows". Atomic
> behavior should be mandatory if RWF_ATOMIC has been set.

Yes, I agree that this has been poorly worded. Flag RWF_ATOMIC does not 
indicate anything. I will fix it.

> 
> Additionally, shouldn't it be documented what value will be stored in
> errno if the atomic write has been rejected?

So I was treating all atomic writes errors which don't follow the 
"rules" as low-level I/O errors, which is -EIO. However, yes, I can 
document this. Further to that, based on description of an error for 
O_DIRECT, which is to return -EINVAL for misaligned, I think that 
-EINVAL may be better for any atomic write rule violations. OK?

Thanks,
John
