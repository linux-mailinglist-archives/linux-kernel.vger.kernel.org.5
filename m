Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1D7D582B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjJXQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343897AbjJXQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:25:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE94DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:25:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OGON4j007100;
        Tue, 24 Oct 2023 16:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=2z+ETLb3n+pksjjCMn0CM/tJa4DgZuYchTkdMJHgoQpv0FgyuTwwsTdUbjKNbTfAjGE4
 X037egp90vptvfF8TGGXTYsx7jynT8goLnlJ284suCur8LZTS0df0x94f/oRaN3gcOYT
 0n4++SFIkdhGWmQhLV6cPfxcBXpqcGcsoc1+/VfyXM6KWdGaQGrVtXny+B9tG3QTqol8
 yjX+9hOaMKQLr19SWUjA0uRawrsle+AtmMTdwL0yaEZVnDt/mz2VXRgDKCsb0UmagkZj
 ENdl5neys70mss/yfBHIJ54hsBgp7q4UoTHSg5BWCSOs3CI1K26rayMEFsaazo+fp3Bm TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6hanttb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:25:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OGKg63031109;
        Tue, 24 Oct 2023 16:25:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53byra9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtYp8x4EDvMPMCsFlpfMwk+cl0rZ7GS3mJoRZuWNjkpch0eFZKaCWMhcQNMBw5V8ie6rI0A6RBIV49D3YLZbPoOs4AToBMav8botNfnRoqIwsTECctuV6aK/VuXL+m9DKy/8oP2l9onoE8PcWgCNp0RNwmJs8VuerddA1hWA7BFw+az5cbsLMXgwiGdB03Bujo6FrfYD4A6bOxYY7ovHL5tmtVAhzBUEMc27yGehfpyTpGBsGB5hPbQNgjpy07Q356dieRYhPmTFxD350TfrqPxJmfduhE/GD1cULFwUu2R/tTvRDuAIh3R6lB+r81ZtIwwEAl9tGP4KEjh0NOkViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=X80eclngbu4a62+N2xDRNc6IX22BZ1GXVIOdQrIOQJyOSlexarzFjEyMKJfcdOLjtAoA0Uhap9PaBjoCyvO7b9UwnMagq/VA3qvpOI/MNhC3Rbl0KERrF4KH/e1ZbOgrVhsI/T0awOYJ01n5KgtgJNtNdiHGOjYwpKQADJKMgR6JiS3/qN3uVC9f3NWEMWSuF70FmwnGVRg2QI0z7Or26rBVMBeHGvItXkylkcGzDOadkMmn0AntYm7U5RGuSG6vg7kmOJ0b/J6vRndZ/7jfo1KSWuqQRy2TRHkk1P+5oTQ3qtdAqltPur5shL4TISsBtTBS4tNZrCM7ASZHLpTalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=SfQfqlm8JC7VXHOoY6k0/gqZfzrc4JAdu7vJNeYcs1UBFhiands7w8JEIQXHxdnKv6m0gmLx+hBUXYdvAzlaNvsPUbSC4pXI5jGtKScSK8N6hBOfWFWwyEWwGo9t9aLbUOatQxQxy5FyfyBQfj27cM4oIRb2TVWiGcKKhgWtWNY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 16:25:34 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 16:25:34 +0000
Message-ID: <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
Date:   Tue, 24 Oct 2023 09:25:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Content-Language: en-US
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
 <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: ee211348-e545-4042-112f-08dbd4add91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRxdz4pYiNPBasQu2lHZ+TkQwyL0DX+O9QiKp3ON1a/ocBHpQqyJQM8kdto7eSP8EqB8lyhJM0WIllr2qLTG7ZN0Y1hLm5ctbTlacmiPjBEy/eldIo11ebwHQEpq0y1oCiOamGQbJvBP9Sk/2aDX/ek0owAmC5HNAy07USjuU4sOZpTrw+1I2xnU52pWyCCT7enUQUmTNaDIscJek7WnW1FzEgpORrsy1kL54HNPb5z2gG+oMBhPUnQWMXecgK1S7TXVA5i6jZZlZgOyzO+5sT/MIuEmdoQBIvj3gm4zibD3kzMX+LIGQ/8g0i7bOw1aNWr4fL2fbsrSixZHO2xpRfYRAQ8Q+21ETg12ioEuJFaZLYbjNdGkrVjLp/h5WEH68WVXTuLSEyJ0NRGrlGUC9pUbg6eyEgIrJ5oTr3auG6BXMZaZw0ICVG3GJis+zKaDJJXPgrCLq45juFVswdRrf4wdTV2XWdoboiDEDT0TxKGrJ+QCt4akBE/7Ymt58KJcDt7IEuoARVxPv99fxbdToLE4+7XxfpFoymAPh8souA/4FvZosiYk7lnf/di5/o4JHtQuGlOXpw1ag1C7VIth5xQGuxjaYZ2g4vBRAyA+IW/cRxt/3BDkYs+0sqt3JtXq30EyuFeY3vaAO3OpevqCTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(53546011)(36916002)(31696002)(31686004)(41300700001)(5660300002)(6666004)(6512007)(86362001)(6506007)(6916009)(316002)(26005)(478600001)(2616005)(36756003)(66946007)(38100700002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVkwS3pIdTBLNUVKMnI1VjhRWXZyZlhWL1RONS9HbGNXOWptSHoxYmppSnNL?=
 =?utf-8?B?YzBHQ2VBa1hOVE16d3BTVTlVQ3lXSUdoUFB4Z3Y4UzlMK2gzYXdVbWFaS2RP?=
 =?utf-8?B?a3RRTStpRElYTnR6VXZtQ0VXckNCL0l1V1JJNTFkZ0pWZHpUYzExMFFqLzlv?=
 =?utf-8?B?M1N1ZkdnZHhnb1dlU3ppNC8yRWprRkNwRFB3NWZtWUlZNyt2a0V3SGRvTTky?=
 =?utf-8?B?ekk4NnJxQ1E2dVBybWdnN0NCaCtQUjBPZm9lYkF4SzlVQWVoMlNnajh6cWV3?=
 =?utf-8?B?Yy9GMkgwMVB1ZTIvb2Z0dXhJOGl0UGFMY1ZSQ3gvUlBmT2NvVStNS3Brc2gr?=
 =?utf-8?B?ZGlCRWZvbTFCUkpZZjZpeFVVUTBCM25VdHRMdzZhY2gyc25rbkwyQTdlQnB4?=
 =?utf-8?B?TlMxRVlFeW55UlU0N050TXdJL3d6ZmhBZmVNYml2UEJJN1dsakZ4c2JmU253?=
 =?utf-8?B?Y3Q2c0dQaVdZc3k5TnpVZzRHd2F4bTZIcEVnWUJhMi93Y3h2Z2pzdWZHL3BR?=
 =?utf-8?B?WTB4Sk1ZOXZ5Qml0K1Z3NnROdjRpT2dPeUErUHJ5ZWpjZWxzSTgwU2o1cis5?=
 =?utf-8?B?a3pCbDMvbnlxeWJobjc0bERZTEZhUzdQU3BhTzNtUkZPbWh0K3E2TzhxMnp3?=
 =?utf-8?B?TGM0N1VsT2RJbFBMbHRLVkYrbVNhTExqYURJeTNoa2pFajF5Q0ltOERTRjl2?=
 =?utf-8?B?WlNhSlVyWWFLNWNldkR4RUNURDVCYkJmVXd2Y292ZzcyMmxvMms3amhyNXg1?=
 =?utf-8?B?a0VDMmRhbEZtRm9ITFg3ZVg1dFdZSGRUTWl4ODFWRVArZUlFY0xLeWc3OTYx?=
 =?utf-8?B?QW0yNHZvNDREN0xrOHJhbERJcGxyVktpVWRHK3BqOTVpTHdoQ1pNd0J4NWVj?=
 =?utf-8?B?K0lSVEwxaXIzd2NMd1pBbUYwTXVGVFJQVUk3REErK1ZvYXB6QWkrb2NiSFJL?=
 =?utf-8?B?UVpqWmJ2TTRhc2dWYktGdDFURlRtN2V0dTRDa1NTVy9kMzhjWjVBRjJrN0hI?=
 =?utf-8?B?MXVMNzJ1TEtHWnRKRS9McUQxRDY5cmU0NmkvUTE1eG9IRzZEYVBpSXlyTFYy?=
 =?utf-8?B?TithK0lVVUZTZWV0U3p4UEpRZmlwNExiWWNVdjFmeDU3cGZkT2c4VlE5UGtY?=
 =?utf-8?B?aitlZ0JHaWs3M2xPR1k2cWVhNkQybUlGY2U0UlJKRFBWMzBJVTZFMkVuV05S?=
 =?utf-8?B?WFU0TUxOS2NNMHd2UncwMlRwcGJuYXVSd0taT203WmZuT05VNElqN3ZzUUo1?=
 =?utf-8?B?LzNjVXowUjVTQnZhVHVIQlJ6MVE4WndDRm5VVHErM0ZWVnE3REtCT2pFTVY5?=
 =?utf-8?B?WjUxVmd2Qmw0M0RnV2VZN0hkcGdvQlFUVXdLQTV5b2t6RU5KZEN1YUVnVTJP?=
 =?utf-8?B?TTZ1VmpDQkFkcXFieHFnN25zS2J3bEpCZmNLTWdFcnc3MlNqZkJ5MEFjNmJS?=
 =?utf-8?B?bk1zckx1ZVRGOEllay81TUxBRHJFVDNsQ2JZc01rZ3NNOUpGdFlucmJpTXh5?=
 =?utf-8?B?V25pc0FmcXNrZXJPOTc3Um9YSUE5dTQxNC9xMFNBTnRLcnZVMlU3NkZ6T1Vp?=
 =?utf-8?B?L2c3Ti9BYmF4Sk5mMUdURzhsUGJvbHgvazdsOWo5WDEvQnJIVE5OZHRXTFZ0?=
 =?utf-8?B?T0Y3bnlXK2FYU2VmbElTSmwxUVlZcHo3cmIxbjA0NS9WYS84RllzUkNTU2tr?=
 =?utf-8?B?M3N1R1FvT3M1dWQxdzBrZTdCcWRiRjM0MmhYOHUra0RxdktSZ3RzSHFtZ2R3?=
 =?utf-8?B?SFVPb0wwUFVoY3A0c0ZSWjh2bWdDTEVGeWlkRk1keVF1ZG9oeFJoV0hqY01N?=
 =?utf-8?B?Uy9ic241WG12eE1FaVRrL3hiZ05SZ3B0L1Z1a2t3QjlpQXV6Z0RuVHY0SWZX?=
 =?utf-8?B?V1hRL3QrTjc2OWE4ZVNHRldNWitic09LWGF2K25DeVlLOVYvc2ZFNHBhQTVk?=
 =?utf-8?B?UzFSYU5vSDMycjV0SVY2NXl3byt5K2J1Rkk4Nmx0RTJ0bkU1K0g3eEV6Vll3?=
 =?utf-8?B?bWlQcU5VSGJGVDZ0V1BVVVoyN3RBWlBqckM2Tm5oSUxYZGttVm9kVEdDTkQ3?=
 =?utf-8?B?VzViUTFwRXJsWHpqWEFOaFF6NU0xaWY1L1lNbWJWU04xdFE4RVR2cjFJZGpk?=
 =?utf-8?Q?nKxbH8dWGbcTh1WQzJOp79ioY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ntYO3BBOTv6+AXg7teHKFfFkgaKReXlZLMm89d1/Jl29dVD6YR/P06p+xxifyqQ2S0A54rNlNl/kXfWlVzxAzaXijKqZ0Zcseklpd37G89dHCY1psKKRc5UNHgCYrF+PIPB9FB9PNSPTkyrzmn3MCe9aqYno4Lv1De8X+SXJJ8jHHKOrvpzPwE8EW3k/KFGhA8M/cQqsJy430a7bZZKuGCCnFTD2zT313vCY1RByhY8aPC5E8Ia3qqsnCx/yISMc2vqQAhbwOT6xS5e7UTAo2ykLoltKxNH6wVmUhwQEHfmiqrndvk6rc3nHg8rjnhHAneALIeLlqKk5iUlIiueCzPPvy8eqTzBjwg3N1dXaHZGbocG1AlrJKvEZkgi7cTqWO5r2Zs82BQSe8BPBKYLyHuHvSlCyjKqc9aVAn831phqj1fYEbo5tEwleOWuXn05MWYHj3AJtctmZNe8/MTajRrMWsfPV9qWlBJkmUJ3lRABnwCOOBiFA1Dk8e0vG2W83Mmkl2/B/reDD6OTfYLDeGa5K84bqnHU/nqLuTPxZyhVkrK4+AfgG0NCUx6Ykap5XPVRFZhVyMFoDJsHxFpBkYaJF9V0tnaaRyYF+QBuJRNJH9TdJ+Mk65s6JKr+rVuTQ0VQ3CQ/flAnWBJPSBhl8eKQFi6cza8s0/WmUxqxCnj0Sf5ull+XKUQYMf2h95tdxIMfwZM0BqkzDpi1HCSIVLf1VUb5hVMZr5f7cykw3kS0DrZUCWZrqH3oieK5GMe3pG+ZbkMEXrzkT5tF1o9ZoiHqscr6b3spXxXh5hlz4jHwxEqDiM+f2LAQ6J21P9eZVUWYiM2oFv5ebrE0+51V3rFNPrj6j3q0nBUsqQnv4PB3yfYk0ZjC6X1rA0iuF7lvf1K+MM4UnhMGPOFqz2UdF+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee211348-e545-4042-112f-08dbd4add91a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:25:34.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZKTxUFtIus4//HVGbbue2ZY2iKxhjvWm+0bmIyMJPoumB/TN5sttmPWDkewqWY/O1CKa8EnmovzXct+fKQLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240141
X-Proofpoint-GUID: CbyEc0uoFMfuoXClNtvcvj4sYXgJyswZ
X-Proofpoint-ORIG-GUID: CbyEc0uoFMfuoXClNtvcvj4sYXgJyswZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 9:21 AM, Si-Wei Liu wrote:
>
>
> On 10/23/2023 10:45 PM, Jason Wang wrote:
>> On Sat, Oct 21, 2023 at 5:28 PM Si-Wei Liu <si-wei.liu@oracle.com> 
>> wrote:
>>> Using .compat_reset op from the previous patch, the buggy .reset
>>> behaviour can be kept as-is on older userspace apps, which don't ack 
>>> the
>>> IOTLB_PERSIST backend feature. As this compatibility quirk is 
>>> limited to
>>> those drivers that used to be buggy in the past, it won't affect change
>>> the behaviour or affect ABI on the setups with API compliant driver.
>>>
>>> The separation of .compat_reset from the regular .reset allows
>>> vhost-vdpa able to know which driver had broken behaviour before, so it
>>> can apply the corresponding compatibility quirk to the individual 
>>> driver
>>> whenever needed.  Compared to overloading the existing .reset with
>>> flags, .compat_reset won't cause any extra burden to the implementation
>>> of every compliant driver.
>>>
>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>> ---
>>>   drivers/vhost/vdpa.c         | 17 +++++++++++++----
>>>   drivers/virtio/virtio_vdpa.c |  2 +-
>>>   include/linux/vdpa.h         |  7 +++++--
>>>   3 files changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index acc7c74ba7d6..9ce40003793b 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -227,13 +227,22 @@ static void vhost_vdpa_unsetup_vq_irq(struct 
>>> vhost_vdpa *v, u16 qid)
>>> irq_bypass_unregister_producer(&vq->call_ctx.producer);
>>>   }
>>>
>>> -static int vhost_vdpa_reset(struct vhost_vdpa *v)
>>> +static int _compat_vdpa_reset(struct vhost_vdpa *v)
>>>   {
>>>          struct vdpa_device *vdpa = v->vdpa;
>>> +       u32 flags = 0;
>>>
>>> -       v->in_batch = 0;
>>> +       flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
>>> + VHOST_BACKEND_F_IOTLB_PERSIST) ?
>>> +                VDPA_RESET_F_CLEAN_MAP : 0;
>>> +
>>> +       return vdpa_reset(vdpa, flags);
>>> +}
>>>
>>> -       return vdpa_reset(vdpa);
>>> +static int vhost_vdpa_reset(struct vhost_vdpa *v)
>>> +{
>>> +       v->in_batch = 0;
>>> +       return _compat_vdpa_reset(v);
>>>   }
>>>
>>>   static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
>>> @@ -312,7 +321,7 @@ static long vhost_vdpa_set_status(struct 
>>> vhost_vdpa *v, u8 __user *statusp)
>>>                          vhost_vdpa_unsetup_vq_irq(v, i);
>>>
>>>          if (status == 0) {
>>> -               ret = vdpa_reset(vdpa);
>>> +               ret = _compat_vdpa_reset(v);
>>>                  if (ret)
>>>                          return ret;
>>>          } else
>>> diff --git a/drivers/virtio/virtio_vdpa.c 
>>> b/drivers/virtio/virtio_vdpa.c
>>> index 06ce6d8c2e00..8d63e5923d24 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct 
>>> virtio_device *vdev)
>>>   {
>>>          struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>>
>>> -       vdpa_reset(vdpa);
>>> +       vdpa_reset(vdpa, 0);
>>>   }
>>>
>>>   static bool virtio_vdpa_notify(struct virtqueue *vq)
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 6b8cbf75712d..db15ac07f8a6 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -519,14 +519,17 @@ static inline struct device 
>>> *vdpa_get_dma_dev(struct vdpa_device *vdev)
>>>          return vdev->dma_dev;
>>>   }
>>>
>>> -static inline int vdpa_reset(struct vdpa_device *vdev)
>>> +static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
>>>   {
>>>          const struct vdpa_config_ops *ops = vdev->config;
>>>          int ret;
>>>
>>>          down_write(&vdev->cf_lock);
>>>          vdev->features_valid = false;
>>> -       ret = ops->reset(vdev);
>>> +       if (ops->compat_reset && flags)
>>> +               ret = ops->compat_reset(vdev, flags);
>>> +       else
>>> +               ret = ops->reset(vdev);
>> Instead of inventing a new API that carries the flags. Tweak the
>> existing one seems to be simpler and better?
> Well, as indicated in the commit message, this allows vhost-vdpa be 
> able to know which driver had broken behavior before, so it
> can apply the corresponding compatibility quirk to the individual 
> driver when it's really necessary. If sending all flags 
> unconditionally down to every driver, it's hard for driver writers to 
> distinguish which are compatibility quirks that they can safely ignore 
> and which are feature flags that are encouraged to implement. In that 
> sense, gating features from being polluted by compatibility quirks 
> with an implicit op 
s/implicit/explicit/
> would be better.
>
> Regards,
> -Siwei
>>
>> As compat_reset(vdev, 0) == reset(vdev)
>>
>> Then you don't need the switch in the parent as well
>>
>> +static int vdpasim_reset(struct vdpa_device *vdpa)
>> +{
>> +       return vdpasim_compat_reset(vdpa, 0);
>> +}
>>
>> Thanks
>>
>>
>>> up_write(&vdev->cf_lock);
>>>          return ret;
>>>   }
>>> -- 
>>> 2.39.3
>>>
>

