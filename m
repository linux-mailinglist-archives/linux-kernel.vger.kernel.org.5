Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3E7940BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbjIFPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIFPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:51:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A49172C;
        Wed,  6 Sep 2023 08:51:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Fo1BV005730;
        Wed, 6 Sep 2023 15:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5swgylxKGGPWum33wzw83E0oNXcQCBkvsQv8PNd/j6o=;
 b=PPKqBeM9cPQYxo4IH7NTcqYVZ7A9zJDiUGHV5XyPMiV6vsLcw2PVdQLr8vWDOMUn+/gd
 Xi4SxN+7ZDp0UDSgH9FTR7+LDJE8slpl2vy0pS88ER0AdIBz9yjF8M4V15HeF8JsPHDc
 +SZlpFtCBj8r/kwbxw4AgvfbewHThbZvLwadi+rlLpre5wKJS3kQERFXxxhTV0lJ9fj/
 oD91Qg4uvPgdCjnzbf8GTxYLhzYoQPpIgtyYtM5Ge8IwsLfd9VLCGVsTbbI+ZpkniM7f
 0rBuRRW21KZ85gDlelR6+pRqhQGrzNXJsu6p7GpnBXkMHhrjao6qiRyvMKa6K5XDQIQ+ 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxvdq0047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:51:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386FH9PF028230;
        Wed, 6 Sep 2023 15:51:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6eh5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZED6m++OWWRb7G6VGUJfr3ybQcHjb5K3ZjLzN6kMVmFO3zmzJtm45lxWYw8cLCTJyI2in6gCLkQDnzQ1JK6L7jD3FAqK3GAGFRG5qexdKqFLlMGrroj/5La3rn+/BsteN+byawGgnvC6bc6RHdbyRMinKKOmRLC5jOHdFLI925srWPRoVOxJRpYwJYM/Noc4GEKc6pqAnhQ0G3uBIq5lWNreqN8TUHOk8XUqJZLM2e5kto4X2b1JUw93NaBHPmO/Yq2pk4H47gdFLogjqQjh9c7J9ekH5RO/J58rIUPpGoDf+jcu3Sio1tjRm3XNP2qbuTKesTG7P7GxUFoH/FRYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5swgylxKGGPWum33wzw83E0oNXcQCBkvsQv8PNd/j6o=;
 b=ZViMwn4uq9RXFGsRB973N5tduNRy1wnkUY408D4y6xZh5EI6TFd+gKycGAIN9RkoJ7yrqC/O0yle8U41L9F9GwUQwTQvGbEj7DEQUpuXFDPXJMnBHeuaL66tCyTlSO6Jwp6rSqe9opTzndgNuB7GAANljZPPmY1rc3Cb1g0LVS0Qe/9gD2j96Gnz+niawgc5HhymxlGYDV4e6vvxhNMPSp4ewNIgFIf165/kVWKJxW2aAN8/M8zu/icXZ+kBokoqxbTMTTahIY0qFORobQhycHi9hRejznpiv/pkZ3+KHMnRA4XWZzyXLEvE5VKnnQ+gF/lweTHXdI1BQll8yHt5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5swgylxKGGPWum33wzw83E0oNXcQCBkvsQv8PNd/j6o=;
 b=bajFfKwTOx6wu4vjAR9FIpVMYzf/ocahYdZcbLj54wpCzlISimguDuGCzJsV7udFTetw5KxfbzoOGcodJNQ6aRaPAcvenBeJkT8he5ED+dZ779Xv/0H9bth/7A/hnwOmuYrJNIzfocXTd6j1KRBsjD/3YrtaRJFWBjskUfQh/sQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:51:07 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:51:07 +0000
Message-ID: <d2f486dc-c987-4b8a-a694-825305f0cba0@oracle.com>
Date:   Wed, 6 Sep 2023 10:51:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: scsi_dh_rdac: Avoid crash when a disk attach failed
To:     Huang Cun <huangcun@sangfor.com.cn>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinghui@sangfor.com.cn, pengdonglin@sangfor.com.cn
References: <20230803112841.588822-1-huangcun@sangfor.com.cn>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230803112841.588822-1-huangcun@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:5:14c::44) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH2PR10MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 256ae30d-cc83-4728-015e-08dbaef11521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/UTqUXbfA4NZgay6nwqjG6mzbXiYJxZ17FWfGClI0OcEmzCGXO2WZ+LG4GXlYcp0YDjf15KNaU/DW/nXST3McXtHpml71l6Ui4PJaPw6MZ+lVde4pbe2cEcJuG4Xt1Y7brg9iSnVPl1OHS8MaVhgQ/fxaUcmdC60ryBB6WyAhgXPUUJPg5aq/nGTwRtOSxF7Nw9I//i3mhNkpBJG44mx8IFRsZ3nodOC01NAvoWOKSkd52V3zkljY88VLjKHBKG4sOa5duw5uHMO4tTrwtnTNRpWP/+pC3CpwBABatp5LMdb2uH61IGZbkh8BUQJCWdJFJqdPIjLLfRG9jkif/gBPipVVUoIO4n4E/sTDe52d+bI1qJkOnBlxIIenlkqRZSM033pT9WlIyannWn1XoR1JOuQrLZXQdzqXC+UHEhrIVG8WeBL/9cbkkh+CUZGbak0+URfxjPpJIACr6t+OOIC8xqYDquSQRbChO7S8E+uiK8GSTszI8S09JitmalTHzvnfv5IAtt+hESt8fhBksjf1td3dxxyDPFgkhWm1dQ6dOpimEODruInk/cL848mGDkq5iI7Cw9pHLhrf7dKO6CGHEWRz14Qf6ho+Ld5bSu96UvNgxRvaes7YjVCjZs+pu/yYaXuzL2l2j1AqxRO7U0SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199024)(186009)(1800799009)(478600001)(6666004)(6506007)(6512007)(6486002)(316002)(31686004)(2616005)(8676002)(4326008)(8936002)(26005)(5660300002)(41300700001)(2906002)(83380400001)(36756003)(66946007)(53546011)(66476007)(31696002)(38100700002)(66556008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXAxUEIwSVVOMFpRRS8wQUgvc3k5Yjk4UFpMZE5SV2UycTllS2QvMHdtS29z?=
 =?utf-8?B?Q0syTXZ5bG11N2V6M3JhL1d6NWpHUE9PYXVvOFozNlVTSW9UUzVYMDNNNUYv?=
 =?utf-8?B?ZnBmSjc1NzR0aEpUK1ZsbjBQaHF2aVlDWEl4Zm5uMS96NVFPSmtMQXVDRkxo?=
 =?utf-8?B?eFFRYm1iTFBMWUUwOWNRQmRaTjRtS1hKUWppdVJrQzRxM2ZONDl5UGhEYTZt?=
 =?utf-8?B?OWZ0MUJvSmVvRWFiMjJ0enF2RVVKcnE2NWlFNVdhMkJEMTZWcHFzLzhaODZ6?=
 =?utf-8?B?bEdIOFJ3N2orZDFEMzZURTBEb0Qxb3ZCeGVKWnJyb3ovSkNwVy9CZC9KK3R5?=
 =?utf-8?B?RTBueExLQnc5MC9ZVkc3RDRHZE1SRWI2WXdoWS9TUjd6LzI5dklzSDRDbXV2?=
 =?utf-8?B?K2RJdFhudk5BNVIzZHRCUE9rQXE4R1NtWWQwZUp4U1FVZ3NBWERIUnVMMmsz?=
 =?utf-8?B?dy9ZRGtzNktzSTJoZEJCdG5VRDZCenFqbWhjU0hGSFptRzFkVkRPN213dzA4?=
 =?utf-8?B?MFFsR1BvRUExN1pRemdwQ09vZ0tVdWVzUnMyQ0dSNEIyT1BHbFhabE04NUhH?=
 =?utf-8?B?amtPOVZVTHN0S2RHZWFKRzFGbFREUGVmUDdyL21wcmp0dk9SNjZwNEtzU2tG?=
 =?utf-8?B?YjJCRXJDWDdTajhQYkZiSGRBZC8vSmpldmlvWG5kU3JHR0htU0JRRktEaHRq?=
 =?utf-8?B?UEpBaEJpS005cTJ0dWhDelJqOXl2MWlKMzlNdGhONTRkNW1NR1lrMXg5Mkk5?=
 =?utf-8?B?NmVNUjdmQzlROWdoV3U5ZjIvT2pRUXpRL2JIUzZyS21EWFJuSTVlYmpYeTNa?=
 =?utf-8?B?VnlXeHlWUG95dzBZVVBYSjMrOElFK2FFS2tLRW90STV0VTJKV1ZiSlI3MkNZ?=
 =?utf-8?B?M2RReEh4L1R3RkJ2dG9lMnVvUjhueStORzR2K0JjSUpjSlVLQWNlVkd0WFph?=
 =?utf-8?B?TE55dWRkR2g0VXUxQkhDaENYMWdSRk5MTm01SW5Ra1d1Y2pLZXhYSmR4cmVK?=
 =?utf-8?B?cGtBUEpBZDZCQUl0T1lGYnhQMXM3Tm13RDVOQ1VuY1JaMk1uVlVEN1N6OUl1?=
 =?utf-8?B?djdBeHY4K250Tjg0NVhBZ3d3YXRBbzBoa3ZuOXpINFRvL0EzTUhPeTRJNC81?=
 =?utf-8?B?NDV2YzR4TkxGRnJXa3Y2dmwzYjhnYmNzNTZvZjB2T0FTMW5uVzkyMjBWeDcv?=
 =?utf-8?B?UEwzYWFJZE05d1ZLS1ZCR2VFYWk1RTlXV1pqamlzUFBHaGFzTkpuamo3Qzgw?=
 =?utf-8?B?dmVnLy9VamNhZGF5djJBWXl3RklBeDl4bEJuNXNXRXd4a2l0clVDb2JqY01j?=
 =?utf-8?B?b2FENDRsVytiVDY3RHhNYS8vVGlDcTJ3aTRrazkwcXdNRXdkdVVKKzA3VTlZ?=
 =?utf-8?B?eFFNVTdDeEU5N2JyUE85dVJOYTFrb3dIWHVYMExqbVJQSkM5Y2lFY3RTZEdG?=
 =?utf-8?B?b0xHbFc0MjVNWVJZZFpOTVQ3TkgzY2lZdTFNSElZekNldW0vbXdlMGJ3b3ox?=
 =?utf-8?B?S1Y4N1B5d1M3cEFIMEZLTCtCckxuK0NmWG5yK0tLR0c2NytZcGRoL25sTzg0?=
 =?utf-8?B?dE8vRlgyT1BOUEozeVkyaXFNN21pSzkycU5QYW1ITU5xWE1rWWpNUndxcktP?=
 =?utf-8?B?bEV5M0hObkx5M25qZ2c5MjN3TXowL1M5RDVwSjJpQXZ4OGtDcmg0THhFVkxW?=
 =?utf-8?B?U05JYVkrZGkxTjljMlVWTE5PQnN3VnJpcS9BSy9OY3JoaFNLeUVoUlZOL21l?=
 =?utf-8?B?T3RUQU1iaDhONDMrODBjVUdGa0VwckVud0xRdjFiakwyYnJCcEd0NWhNNEds?=
 =?utf-8?B?bElROVV4cVpuelF3aWZubVV6ZkI3d3YzMDlmeUFVcmY1bGhOOFowOFZsNTkx?=
 =?utf-8?B?aURZNjBiK0FoSmtVb1BoN0t0UUZ6VEF1R0JMdENaK3BkYUp1OFl2K3NocmhO?=
 =?utf-8?B?bE12RFkwQWdaMnByd3F0cHdoVzBKUGFjcVc3OU9UbVZZV05sbXE1a0kxY3p6?=
 =?utf-8?B?WklQbTVReXNlY00vcW9WSXhoN3lQMmh4T2t1MkZoVzZ5aHhjUXhFUFJsTnBQ?=
 =?utf-8?B?c2VXcUp6b2hnNnllSWl2L0xYSm12K1hEZk9kaGJoQUNQUUJwdlIwbDlzdWpr?=
 =?utf-8?B?UVZEQlZKVE42UjliOEhhL0pBczlUQlY2S0x2ek1KNGx1MG9oUnE1ZDdaUGJB?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xmLnd+v/1cR1eSrMUpr8LNaiex/spJeKeH6j1rVL3M1+BMmxyKaNhkmkJxh6oPFzMolp39ZwgqDVDViLYrs7cfnkDGca1Sdff1zvd8X7ntmNO+4KBBlYLrAeDwUXLV1Y1eSJLXh1XjFtD09L2Jc/0smVW9oFHSYqS0Ve1ygFxSNuTnp8C+to4lS+/el07MLq0peKhYNKd9nUrtWLJatkNEov1JmO9ukZvmzGhGMlqV0+0PxJslFKx6xRqWjNo4YWcErb2W2kiKz89jQlzQDvsXBkYgNC0C5GZs6cpen94A4qUftrtKbFGfncCb7AcFhRpHP0X5//mKWqUmewKllioob05ixVOR/FD6Arw9yx5rwxMiBQyzc9F5wKs6qgP5t2X9iQTuGaV9sSh/y72mh05oNN75B7OK9o1VNxO6nf6DAeD9Eovzwea/h23dpCm2Z8TMOB1H3kUUkdNrnxHB1t05mPxpHiFm2C2l9H4+rK/0/uYfQJl7oSwtVYsXuoxKZgbrQTTfqKTda7+n6Zgz2G721oh2dSJiXuHrzFfm9ZRjUm/Wx6W6bRhQ8wlRJUHWgGgWdhcR5+ddvRR1vFehhSUbJHmzaXGdyZeX+qpluEsYGxn45cre9KgxDYAUeNFCi3XQgKBrnzKlKcXiXwneqAPfLDrmxd+sfhf5Tj+DCUnzbpv6hdqq+jLWFHzvdt6HW2zYCdzbRouou0bLLjszBHUmVQ1AP+a/s3qtr7TaRC8fhMwNW4n2oov0Hi6ELPOLVc3+biZduN1rzUJjrZvM/QuqO3oYkynC8O3/wtkAZr3o8vtEds/YK7t/4kk6+zPHrroiU8Pz2HAd12bwwnTVG8wQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ae30d-cc83-4728-015e-08dbaef11521
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:51:06.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7iFR7RXuMpcgzklMdN2dtpx9tgtSqYl5lX0QqSQgLMwOd48H5i7tFe/ntF67nj+rQ1lw2LsP01zfgWSwu6A8sBIJNVO/EeB/3uSc5SbfJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060138
X-Proofpoint-GUID: bav-dau3u9HbtkW5eNNsckFWTBjoYPQC
X-Proofpoint-ORIG-GUID: bav-dau3u9HbtkW5eNNsckFWTBjoYPQC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 6:28 AM, Huang Cun wrote:
> When a disk fails to attach, the struct rdac_dh_data is released,
> but it is not removed from the ctlr->dh_list. When attaching another
> disk, the released rdac_dh_data will be accessed and the following
> BUG_ON() may be observed:
> 
> [  414.696167] scsi 5:0:0:7: rdac: Attach failed (8)
> ...
> [  423.615364] kernel BUG at drivers/scsi/device_handler/scsi_dh_rdac.c:427!
> [  423.615731] invalid opcode: 0000 [#1] SMP NOPTI
> ...
> [  423.623247] Call Trace:
> [  423.623598]  rdac_bus_attach+0x203/0x4c0
> [  423.623949]  ? scsi_dh_handler_attach+0x2d/0x90
> [  423.624300]  scsi_dh_handler_attach+0x2d/0x90
> [  423.624652]  scsi_sysfs_add_sdev+0x88/0x270
> [  423.625004]  scsi_probe_and_add_lun+0xc47/0xd50
> [  423.625354]  scsi_report_lun_scan+0x339/0x3b0
> [  423.625705]  __scsi_scan_target+0xe9/0x220
> [  423.626056]  scsi_scan_target+0xf6/0x100
> [  423.626404]  fc_scsi_scan_rport+0xa5/0xb0
> [  423.626757]  process_one_work+0x15e/0x3f0
> [  423.627106]  worker_thread+0x4c/0x440
> [  423.627453]  ? rescuer_thread+0x350/0x350
> [  423.627804]  kthread+0xf8/0x130
> [  423.628153]  ? kthread_destroy_worker+0x40/0x40
> [  423.628509]  ret_from_fork+0x1f/0x40
> 
> Fixes: 1a5dc166cd88 ("scsi_dh_rdac: update 'access_state' field")
> Signed-off-by: Huang Cun <huangcun@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
>  drivers/scsi/device_handler/scsi_dh_rdac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
> index c5538645057a..9d487c2b7708 100644
> --- a/drivers/scsi/device_handler/scsi_dh_rdac.c
> +++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
> @@ -762,8 +762,10 @@ static int rdac_bus_attach(struct scsi_device *sdev)
>  
>  clean_ctlr:
>  	spin_lock(&list_lock);
> +	list_del_rcu(&h->node);
>  	kref_put(&h->ctlr->kref, release_controller);
>  	spin_unlock(&list_lock);
> +	synchronize_rcu();
>  

Should this be:

spin_lock(&list_lock);
list_del_rcu(&h->node);
spin_unlock(&list_lock);

synchronize_rcu();

kref_put(&h->ctlr->kref, release_controller);


?

If you do the synchronize_rcu after the kref_put, then the kref_put
could free the rdac_dh_data, while check_ownership is still
accessing the rdac_dh_data, right?
