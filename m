Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEA782807
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjHULfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjHULft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:35:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86528DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:35:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMQ2T6022818;
        Mon, 21 Aug 2023 11:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WmtnrtUlPIXW/qhH4tLidvVsHXPBpOxAvlLme6U7z+8=;
 b=ksWQJl+zagNg19NL6rlv29oBMYvf4xgKhwqSMhA7TbI1v7FkqqjwV60I+/j887+OsrEO
 LLFnsUgvaIJAJlz9WPWPPDyB5ry0PxCEcE8DDQn5Td7Y3NsLRjm0YVm1uxg4fyAJqCfS
 t+5azSJdEWtD5w48kt+gtuG2yVuqw76VMAbJ77pPMzuLlUJ09z6bJ5JjiaFZgcvEtwKi
 6poxNuvi+Sl2XgpgLoTX035BVb8BdL57pFTrTYssJ8XsfEsZZHV+wWrEIx6qDaL4JpoJ
 zwmM92dpaa4dyyqP8RYpBmgWyi5XaJDevcApC+3Qvjsq8/pgNW/EXWZVvfFKAD/sII0S 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3anqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 11:35:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LB0vk6029937;
        Mon, 21 Aug 2023 11:35:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69txhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 11:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LybA1TAJNHW1kDLoeWv3elUC6F2AABeFVhPTB5DLGK5YdRmIXOxSdmoX1sEajRzjAJ6wEWxklwy0pVW9MGlpQBfB2R2VlQC0KFwrsbHG9LczB+j/5Jd/M4gTzIPhiqnNKAcgLWtEqod0tfdP3WXj85ylFmuaXrAes5udVaa1CQP9TWvJcZ7nhrb8WWU57tgY6xPlSY76WDpy+KxvblOgsGfe2wxUIShc8MuT27WeKUGMLcuKB+4A0ssu5QnzkwCwug/HD5dWD2Qc5X9+cV5K715cYw+x2u//3n7Od6hs7R8fK++4IjMjy34X6xzz2v7D/dTXpb44tnfINq88sUFckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmtnrtUlPIXW/qhH4tLidvVsHXPBpOxAvlLme6U7z+8=;
 b=loGS/eThnIT01vGE0VfX6YfqX6sEiAuNqr0OSY39EiaLi6BSonSsrOyYXYwTbp5vp11TRRWVRxyCREyyj6/V1lsUIjsqG8ayxqDGcgysONVZlF4mbuGg4mMoZLl+9kWgEey4M8yMK4PYUFk8ZZYkQDsPKoBv5igsVQ/SiUOMnuO6cV9NSvTp7fQFcvLnPHJg3MjnIgdHl2q0VADvltX4GLzMkLcUD+1XpyujD6PZ4pirIObZ8c+z05fB+eDW/YPComJ+Osr5N6xZyB2SIGvAqTYZSR9Td02VBsUG+W2jMF9/NyJk3dzejU738WNu5iac53zxI9Dr1gaRT4ZwTh3tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmtnrtUlPIXW/qhH4tLidvVsHXPBpOxAvlLme6U7z+8=;
 b=JTeup+b01dFxxscWqAz1g7DjWU/FCER5sFID7F3yUbyJoBdUqG8HORbWO3iPFBUog5yJZpXf8fM/MQcnqZLPWExPsZVXQBpnv/fOA+aScKu6q4RkMkHT5DkMJomDh9J+uWFxFaRFt1oZzy+pr/YkdbVYDY88Lcegb9JRdjRPL24=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6469.namprd10.prod.outlook.com (2603:10b6:806:29d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 11:35:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:35:20 +0000
Message-ID: <9aba4d8b-6a46-6c08-2568-2e7490723526@oracle.com>
Date:   Mon, 21 Aug 2023 12:35:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
 <b9bda816-612c-b646-63e7-54cb3fedf1f4@arm.com>
 <1aa1ecad-bdf0-84c8-a37f-94e1d0fb8a03@oracle.com>
 <d0fe22e2-dea9-123c-6c8b-d89fe31b6592@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d0fe22e2-dea9-123c-6c8b-d89fe31b6592@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:208:55::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3d4b5c-565f-4344-1d6a-08dba23ab330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQGYPgDDve0RGf37PjAxY9/Uqo15Ci/Ofq70fJCzCP4t4N8q3ywWGqy+itR+36kcsvbGF3xCO6tnGiUCK7rMe1gqagjHINnJJZbN6e78xBTTtCbTgiihEzqeq04ZIW8aQ2sdssJbLkvxnW70aftzvm3snKsGel/2TmP7jKO5v1jIOvUpOG4K8js0PIj99qG+lRum1XIwqNQ+IF0vARQ+KyqXtS3UrilYuiDS5e51CccL6CHYaZpD8r8iwPem5T2uB5OQ33SfInmjfB+4edJc4VmFXClTwaUe/1qjOGe3cx8oGmkJGUto6jb8XPX7Vy5bDtklrbZPPVoLBXUZambtmC0mz+zhLYx6y/vWU5xqXLkmM7lIYVfYsDSwO1en5G0yacvXamZEjbKo61fY6cPJiP4sfan9Iwyr7gJU1HHGYmoN6+sFZ3lGVi4YhJdZtwgqp/krj5qc6E1rAvLa/t5lrKqYCq8IVmA4WkACmECZycPqMeUX3ExQdOXFZvLjIwgdPVsjgA7miR54YGjaFtsr5BUaXySky8jKMwnXGqAFvEFe9J0axVfKq3eAuGl5ntcnaLiYnAT9A2N5piwnZP8qjVmHyDyY6jOyFtd5s1eARzZWro1r3GEoyRVnyigUlTein5Ghn+nUdS2GVk08YhroYzJeTiyYPFs7Y50ORrBPHmgpEMlNjyB7U/7J9AjFeL0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(36916002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(966005)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTEzSXNiRFZXcWpiZlRiTkFLWjRSaG9EanR6QWxOSldLbklwczFUd1VPcVdt?=
 =?utf-8?B?cTVUNnN2NWk2dk13Y0t0MWFSekRyOUhuTWRWSGIzNmtHK1lNcXRjM2dwMWFo?=
 =?utf-8?B?aFZtMEZiL2p6SVJEb2gwY0hVQU1CWVJ1VjNKMmVKaUU1bFJjenhiem5vQVho?=
 =?utf-8?B?eDk1bnpqMWRoaTRFWStUZmMrMlJTMk9JcUZzekRRZ2JUcDhkNmZ1SXN4ZGxn?=
 =?utf-8?B?M0dlbE9TNzltNlc5enozdFUvaEJYb2czaDNwL2dBeFMydkdrbk85anFzaHll?=
 =?utf-8?B?R2x3NFdCeC9Fbzk4Q0FSS2VJREdCQTdOenJmNXlYWE9CRkVTMEQwQXdhVURh?=
 =?utf-8?B?VERpRXZsazRvaitGcU1KNURtY1ZTTGlKZWpJMkZnMFI3Mk5IdDBUTlVnNmI4?=
 =?utf-8?B?ckRTV1F1WExBb1NpbS9ta1FqRWk2VzFVbUpyTThGMVRvajFBYU5CKy9xSmpm?=
 =?utf-8?B?K2w5cVpDV1dmRUd5RmVyN21tamRhK0t2YlVaSlFDL3hTS3V1MDB3dGhlbVgz?=
 =?utf-8?B?ZWNaVE9aMHNHRVB3cHpGR0laakxyc044c0xnQUVhOGFEbHJJU1hka1FXazRE?=
 =?utf-8?B?OUtYdlpsZFpiclJwQnVIWmpMdWNDZFE2MSt3ZzRoMm43dHlCTEJTb1pvNS9J?=
 =?utf-8?B?Zk1xcmZ3am5RNThQU2ZSV0ZmNnlTNjlTOEZHRS94eWw3K1czRWRoU1dSenFB?=
 =?utf-8?B?VytTa21MWmR1RzNtSWhUTHp2UWpTdDN6WWtXbi9RTUNESWk2eVVjN01CRDJ6?=
 =?utf-8?B?OVFPczVzOUQyek5oUzVEZThFZGNydkthdk16c2JUK3pQYUswVlZNYlh5WXF3?=
 =?utf-8?B?QVNvckxzRHNBbEJ5dWhXVWtucFVJMVZUNVo5T29BTnpCdDFMMnJGMDZjY2xG?=
 =?utf-8?B?bVJZdlo0aVFXVFhRbGdUYnpBZE5pSXc5WHBPeXJMV2tBWiticVM1VWIrTEc5?=
 =?utf-8?B?eDRZVlAxN1d4OUdFZC8relE0V3IxUWJ6angwRHhYd24zUUh2ZTRRZDlVdnRD?=
 =?utf-8?B?MHAwR3VnNkpoRmIwT01ETGFXbitvSjl1cUo2ZGZxbEhNSU4zRnBRcXJqS2Nj?=
 =?utf-8?B?RHk4d3BYYmNjVGllVU9qaFM4OFBzL2lvTkQ2bnRBWkl3NU03RC9HQlFQaTND?=
 =?utf-8?B?eFllQldOUzlWenExYTJmbSt4VDVYL0Y2MHkvSUc3aUNpc0pHdGJEVXJhZ2xM?=
 =?utf-8?B?SFdBZFp0MDVOKzRFdWpiZHFmbVowUUlQY1JldFBKWnJ6b1U1VE8rV1BhRE1x?=
 =?utf-8?B?Q3Yrd3BIQmJFS0lwTWpQNWN4WVltZXVaTndDTHk0MkZEZFlwZmZReUoyUE9l?=
 =?utf-8?B?OXhVM21jM1RUWkx5a285SVh4MFplSWNtYzRJM21RLzkzMkp3b2ZZUEVVTGdW?=
 =?utf-8?B?WFk3YVQ3UVdndGpsWkV5K2cwRjlSUXJ5Y2M0NTAzVEpoQmkvTDFRQ05IbTNx?=
 =?utf-8?B?WlJ5WTR3Y1g1alJVdzlUZFhlSks2THVjZEJOcmxnUXF3SEJTamh2T1ZTU0VX?=
 =?utf-8?B?U3ZjUjR2R3NlTE5zam5RR2c1RHJZWjZWR3JNYUVJSXNDN3FtdXJDZk9aakUr?=
 =?utf-8?B?ZGRtcDJ6NmN6UlNsZ1haWnp0ZjNrZG1UWFVWQlV3T3BjZ0Y1cDRjTHR2dGFY?=
 =?utf-8?B?K3AwbWFNQ0dFMWVjL1diU0NWN0tBSnFnZHZ0S3Z1UGV3S1ZzK3IybVRXbCtr?=
 =?utf-8?B?VVNJZzNnaHIxZC9JNmhhazhzZ24rUjhtUG5rdUtobDcxb1BsOGNBdk1mYUMv?=
 =?utf-8?B?NE44bVVFZDNyM09TZ1pDWW0rdWttT0JLRW5XWXF3d1U1SGQ0STVhZkNYNHgz?=
 =?utf-8?B?YW0vRVlhY28zSXRkSEIyUG5IaUNKWVU1OUk4NU5nYlIzNGFQQlhYM2RHVmxv?=
 =?utf-8?B?QmVlbmlmWmF0eU9pMDVXYlV1S3o4Z0psT016ZC9OeER4Y3I5MEt4RHFUVDZP?=
 =?utf-8?B?US85MklNdTNrcmFxblQvL3VvNFlLelJXK1grNzdsSHRGMS9VRy9RTFUycDVy?=
 =?utf-8?B?U1U3anQ1OWd4WnNac1pCRkMwdlVUa25ZNUFlKzg1M0VmTW9GQ3lOWnhjTnUv?=
 =?utf-8?B?SWFFaUJsUGFCOU4vQkdHUS92dFVoREdXRVFkQ3RWYjFnSmcrK1Y3TDVvRENX?=
 =?utf-8?Q?OOlbfR8BDZv8NmhiVmfigWCvO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y/eeYKbW52fgdv1rI0tsgu9QPAjJol9xE1WryZuwDKKD+t9g9dKS7BmxYySGtk9mUFLVeDxYYXGhS5oS4WSTk5/CVMVb1exlqSEm1Ue4T/OAfMAAPZ5Ia0yKiX4qMjip4O+hpgF/UaJ7O5o8E1sztk6J5Nz7JNiCpABiIWaVdK58Llji7EtgIVu1kjnBKJdWazbZaaJvc0BZiP1FVwAefnY+NE5TRkN6hA1FqNAlcbwST0hrS5ZnTIyLRxdHD/upaO9QMLHG3Ub28GED5v+IRvhWC3TH/YdDaB+O1bCb6TBRJBj2DwbR+Wc3cbQUAYMTBK9ygNQI+33Z+mnn8SMqI7tsdoyAggXLgZiglZpkqgJJRjErh3rSxUvheb5F+BHjmNPXwG+GA4ua/RLmtJSPqixz4oKHiXT3wockE9RWMJxVqXRz5trxX/drMee/t858ys3MwbxHcIOypyQpY0wcqmj8DMzC6A9/WLSFWCqAluaf0UBkIDcXsOYeYMxm8lAB89sIMr9aPcynpIaaZkQMKikG9nDKpapk4so2nsP/DGNdj2Fl2gPAu7JaipVR19Eye874HIn1Q9GcaKNgExY14wmT8GHRc3Og5Ee7Vb8JY680g6bP48m9R58U374wApgOy6Pp2rnrezlue7FCuQz2YxJ/v2uOJrQWQGN3plU812nO4ZJ7JGZDMr+c1V+B28mjeNMR/fNAYIfANC6UpZ+ImT5W85/txpv8MGsyYD+jq4wcJ3W8e2yXkXzmxK23QqABIEApQ+YmmbD5oIK+Fm0st2bQT+OSafHVu1pi3xDQewm1vs1Wuz8GERF4Ytz+92IicDNRJuoY4PZa+WBo8Z8+l7orKOGE6muhzNekCG3LWWV2v18jfFpzUopvPMDBChKbnX5v94fbwpluE0G1xyEFSAbKrKWFYpHUDaiZKJmhdi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3d4b5c-565f-4344-1d6a-08dba23ab330
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:35:20.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6jjAZ/6QaVRgSS3w4pyV93kyRn7WD2+Jm+9RfXrUWpzZ/W72eYeA1aC+GWGn9estEAfnWiz9IzCnG/1HYGVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210107
X-Proofpoint-ORIG-GUID: _1eZr8CELm7f05IQujfxfjj54ApYd3nZ
X-Proofpoint-GUID: _1eZr8CELm7f05IQujfxfjj54ApYd3nZ
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 16:10, Robin Murphy wrote:
> On 15/08/2023 2:35 pm, John Garry wrote:
>> On 15/08/2023 12:11, Robin Murphy wrote:
>>>>
>>>> This threshold is the number of online CPUs, right?
>>>
>>> Yes, that's nominally half of the current fixed size (based on all 
>>> the performance figures from the original series seemingly coming 
>>> from a 16-thread machine, 
>>
>> If you are talking about 
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com/__;!!ACWV5N9M2RV99hQ!Op6GUnd7phh1sFyJwVOngmoeyKKbHWbSsNkhPB_7BpG45JFOHmN0HQ0Y7NOZZQ7VduKXaRYCXTta8LjrS99neyg$ ,
> 
> No, I mean the *original* rcache patch submission, and its associated 
> paper:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/linux-iommu/cover.1461135861.git.mad@cs.technion.ac.il/__;!!ACWV5N9M2RV99hQ!Op6GUnd7phh1sFyJwVOngmoeyKKbHWbSsNkhPB_7BpG45JFOHmN0HQ0Y7NOZZQ7VduKXaRYCXTta8LjrOGggfnA$

oh, that one :)

>> then I think it's a 256-CPU system and the DMA controller has 16 HW 
>> queues. The 16 HW queues are relevant as the per-completion queue 
>> interrupt handler runs on a fixed CPU from the set of 16 CPUs in the 
>> HW queue interrupt handler affinity mask. And what this means is while 
>> any CPU may alloc an IOVA, only those 16 CPUs handling each HW queue 
>> interrupt will be free'ing IOVAs.
>>
>>> but seemed like a fair compromise. I am of course keen to see how 
>>> real-world testing actually pans out.
>>>
>>>>> it's enough of a challenge to get my 4-core dev board with spinning 
>>>>> disk
>>>>> and gigabit ethernet to push anything into a depot at all 😄
>>>>>
>>>>
>>>> I have to admit that I was hoping to also see a more aggressive 
>>>> reclaim strategy, where we also trim the per-CPU rcaches when not in 
>>>> use. Leizhen proposed something like this a long time ago.
>>>
>>> Don't think I haven't been having various elaborate ideas for making 
>>> it cleverer with multiple thresholds and self-tuning, however I have 
>>> managed to restrain myself 😉
>>>
>>
>> OK, understood. My main issue WRT scalability is that the total 
>> cacheable IOVAs (CPU and depot rcache) scales up with the number of 
>> CPUs, but many DMA controllers have a fixed number of max in-flight 
>> requests.
>>
>> Consider a SCSI storage controller on a 256-CPU system. The in-flight 
>> limit for this example controller is 4096, which would typically never 
>> be even used up or may not be even usable.
>>
>> For this device, we need 4096 * 6 [IOVA rcache range] = ~24K cached 
>> IOVAs if we were to pre-allocate them all - obviously I am ignoring 
>> that we have the per-CPU rcache for speed and it would not make sense 
>> to share one set. However, according to current IOVA driver, we can in 
>> theory cache upto ((256 [CPUs] * 2 [loaded + prev]) + 32 [depot size]) 
>> * 6 [rcache range] * 128 (IOVA per mag) = ~420K IOVAs. That's ~17x 
>> what we would ever need.
>>
>> Something like NVMe is different, as its total requests can scale up 
>> with the CPU count, but only to a limit. I am not sure about network 
>> controllers.
> 
> Remember that this threshold only represents a point at which we 
> consider the cache to have grown "big enough" to start background 
> reclaim - over the short term it is neither an upper nor a lower limit 
> on the cache capacity itself. Indeed it will be larger than the working 
> set of some workloads, but then it still wants to be enough of a buffer 
> to be useful for others which do make big bursts of allocations only 
> periodically.
> 

It would be interesting to see what zhangzekun finds for this series. He 
was testing on a 5.10-based kernel - things have changed a lot since 
then and I am not really sure what the problem could have been there.

>> Anyway, this is just something which I think should be considered - 
>> which I guess already has been.
> 
> Indeed, I would tend to assume that machines with hundreds of CPUs are 
> less likely to be constrained on overall memory and/or IOVA space, 

Cheers,
John

