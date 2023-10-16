Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADAC7CAD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJPPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJPPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:25:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FBDAC;
        Mon, 16 Oct 2023 08:25:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GCckRY021612;
        Mon, 16 Oct 2023 15:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vN94s0X4OAQg2nPLkW6wwlbqTcVVjXZC520SDQ6Has4=;
 b=E+AazYoWckHbDWaXUvriMDjm59kBqZ0C6APGjyY91zbS7XFFhkGwGqMc7+ZeTC/aTY7x
 5mMO5ypvduCmROnvQirls1XjVSlKqrpBJwrN8JVEF48bWpQzYf0jkskWAeA9x/qrIaSL
 l6plTVc8oPIpRjIC1UfoCnjWdsBVgjEGfYNBHPvjG/LlSVZmktvACXE0+4uTKtTNvDLI
 xmq1hsuiP8A5mtMEw84PZ59FuKmE3rcu1moe61BXgQE4x7JvAUaSisFV1bnD4lHyhbqE
 plkAT+TN/ezvBqOB6xEEV2K2UJJe2zO7oqV4C4z5Br3c++otxKvNI06BpCcjldbh/JFQ qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynb1xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 15:25:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GF63wW040525;
        Mon, 16 Oct 2023 15:25:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfyk1c8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 15:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKQrJ2Ap3dW3TYdeLA1pqO/7xfrFtJ0R9wdnunFSF75agQUpQZCrvf8ZXlsQgW36LGD9G2U6+vHzsdB2unDUiLkpNbmAtVsKJm32iz03Og/wM8e8Fhm4VaqiZ0zwJhv4O+H2pgSRVYFHgAb5zhNhata+mrSAYLDynIo6RcT0xKHujZcoS7bFVCU3WNOJ2A6TXpMP9Ie6IZTEfPXz5waMcQSMK4zeeaQyTNRj/8WWLtmlFysZ0a2AR4NM882OSwVEFzAaIW8zez1dqUaCckV0m4AZ/PtWcu1paGkpfrJp+LNLhd1ELNkx+Mbrmy66d1YcpHE+16ueiNsGZwtD+RdBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN94s0X4OAQg2nPLkW6wwlbqTcVVjXZC520SDQ6Has4=;
 b=UiWrxUX8kN1zBlc0EvzFzQpqfCPgiPccGzoUXLD/AkxIymvzcbUD7UflCdPbOF3863ImoGY0QNIpoNGiTX7ps3QydXgbV1N9O62CKyIWsTyaudJZaJ9VnM3Rgb5KQzdUX9WTuC+QhebTWG4ekWFtLDPihXwYb1exh1Q3OIqGNDDV2oLSr8vvIrZyqLnBCjNs+tfAYIZ/fg+ZcDgs8Wodnzj9m5/hKFfmHP5Ly07yLTX+EUZ5PQMQhwvz4WAZdwYPKzYKcjsBVeDhodBs8nR65lWVbShaL1MvpnTofhXWH+WtwiYdqOiXfCx1zizTtV0Jk/yC3zqUiYouVoHKyrUMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN94s0X4OAQg2nPLkW6wwlbqTcVVjXZC520SDQ6Has4=;
 b=Vda5jnh0fUq6G/yWAwUMtxzYZiJARwSBPrngfgICZTBmJ3tUuV/td+mGmWCUG2rMnw3ISO68FqHhTnkaM7A1vz7X3+xCb36NPEmAWV/TzoW7mZXd/pE+lcKpuXsj+WfOEsYHZWMQH1sgDsxamueh8sWi0PD4bRFMxmUnTTUW1js=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 15:25:16 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:25:16 +0000
Message-ID: <1676c7c1-902b-4604-b411-b313c529c3de@oracle.com>
Date:   Mon, 16 Oct 2023 10:25:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the scsi-mkp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231016160616.0286cf0c@canb.auug.org.au>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20231016160616.0286cf0c@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:5:330::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: ce53d65c-3361-468f-6991-08dbce5c1966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9wFFgwdTKC+e94irK2gUrHDBRWsn6se5p1SiAtyhKSScrJdKnS23OxaA53lrhK6FSK3ZsZwD/qdSSj1nUwZcfuRs7dofMouW0XQVwDJMAuCDEcs8OPuQS0j1ikm4Cp2LNqV44oKBzf4azJ/AYPJkCyYYiaZMdpV9M8oXiZH6Q6JZ6dog4ApA2w6hG39w9lRvNgLPsI870siVF0IFF63yUFoyGZIOnPsclThI383KL2YLshIF5IvG/x+OhXyv/mFPLbJjJFFo7t1YTF16sSSoybc8qKlkL30xqY0VH9eDgkqsGnf5zK/xiP0iydfHAOWGNpotCq6jusoNAXNLbTFMMpwpd6o9JRDF1H/74reETuCzvEjZUw1uWy+ZoiOf1WLcMFpJ6310ENiumPQozH+eoJhE35PG+c4BMqxhKgl0QuDGPJmoyGwJdvoDhbvrgUgHFLv3coierTIBN5kRRZjRURAwPQdNFWv5PHw6xMqv5fBwqW5qoVx1DcN8bJ0T66YrfknR4D8hG0G971rPtMow0+c5iUH8fhLLQjlHbtdzavH+X/KrqHhn8xghzXkm0hRa8o1PfqIVIl1sDlMWELooiZZBFlDU9CnO0uIgd0xaFSYUAr54c12dxggQ12kmTXGcGjCesS8m7EOUT9sapYW6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(6512007)(6486002)(6506007)(53546011)(41300700001)(2616005)(26005)(316002)(83380400001)(2906002)(54906003)(66476007)(8676002)(110136005)(66556008)(66946007)(4326008)(5660300002)(6636002)(8936002)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNMdHJkdElvdENYWnRFcEZWbVp3a0tlT3V4eW1iYkJsQkFJT2R5WTlOdlZt?=
 =?utf-8?B?Q0I4NXBiRHFNOTZyQ3NCQTBVVHRyUDhpek9janFSZG9xSTFKV0h5QjdpZFdG?=
 =?utf-8?B?bXFoM05BcFU0L1MwMERlU1hPMURUQXRHYk5zZ09BOUZNWGlSUm5yaXRUNVRC?=
 =?utf-8?B?VVNNSUt4QmMyeXpsYVJpUnNReWk3SFhobGNuZkNzZWM5aGZ3cjNBc3BkZmhP?=
 =?utf-8?B?WGJEK0VDWEgxcTVyVmNjbEFLSnRQSVVhVWowc3dBbEQ0MnZYcVRvUVR3MTcz?=
 =?utf-8?B?ejA2ZSt4TTNwT3RZMmVOM2NnbFM0SUZZNWxJamlGZEFlN0hIUW5DenpYZ1RX?=
 =?utf-8?B?R1JNOHdDaG03cnZ4eUxSbGlLeERUVVpFazlCSVJGMzF5WEhlZi9VWjhuUUJ1?=
 =?utf-8?B?VXcrWk9NTkRoREVBcXN4NkFrNUt6Qk55SE4rWENjcFlLbVNQazBGMDl6L0Qy?=
 =?utf-8?B?K2pUZDlDTVl0Nnh2VktjNzNDSnhNRERBdmdYL2tZNmlVaE9vMjk4UUFDVGIz?=
 =?utf-8?B?QWpybWkzZUdvTDhJSHR5dHBucFpiQmZjZHZDU3dXQ2dsaDBydjFQakZLamto?=
 =?utf-8?B?b1h3Y1Z1WCsxZjBQMW45MTdhN1pSaWdRVkE1SUZxNG1pcStMdGRXYnlYUko4?=
 =?utf-8?B?TjlqNlRBWkt1S3YxcXRUMWFGY3BySEt0ZlRoVThrUnRTT3ZUNXJ5bVhjOWdt?=
 =?utf-8?B?VWhnYnhuSkU0T2NTeVYwL0dIZUNWS3pxV2h3RzhHUEpzekNCbTlDWjRGYVBs?=
 =?utf-8?B?Rm5NY3hUNzN0TnZ2MjkrWWZXbjQ1UStNRUZiWmh6aGRabnMyS2JrSmVDUWpl?=
 =?utf-8?B?V1dsRHNZWUVPZ0xIUjZpRlZFd1IrVGVLb2tqeUV2d0l1R3NkKzZIK3lNL0xj?=
 =?utf-8?B?RFpMVnVWaDFjWTFjTi84OUdHRllkZjNGQ0RSUjh2VlJDUk1zZlRJbmVxSVV3?=
 =?utf-8?B?RG9xQTAxTUZyOVcvL3hRdng2bU9zeWZHWmwvcGNhVytwVmxyOC80MCtTVVN4?=
 =?utf-8?B?eEdNUnMzVzJ4WExqRHVEL1RuQ0YyK1djQkk5eDl5Ny80bkg4dkpzbHpYRWlH?=
 =?utf-8?B?Y2FHL3FCYzgwR0RSdUt3YXZFeE1jM2dDWVpaMEU5ZXJRaUVHbTlNNktNK3hK?=
 =?utf-8?B?RkV6NlJNdWI3bDZXbVpwRWplVkRjc3k2Y3FLVWNMbGgxbm1IWStGR241RDZz?=
 =?utf-8?B?NVVkaWFMVXFKT0t3U0xUTVVHbTNURmZKWWFSME1DaE80YnFWaE5nUEIwdDRB?=
 =?utf-8?B?OHBLR3JveXBEVlc5OEFjYXhKM0NBZE5EciswOUdCU01scmN0U0h2S3pxaXRH?=
 =?utf-8?B?K2JvbzZPejB0WDhnc1cyUnkwQ0wxVWxxWUpDVG1UVWJYZ2k3YkFlUFpWcTFO?=
 =?utf-8?B?MkdOamVwRFpLb3M4d0FFWjNhU3RoUjlCTHZuV3lmOTBVOFhCdm53TnQ0VEk3?=
 =?utf-8?B?Y05hWlRtWXJRTFUxVG5YcHA0TWlYWTNKakI5aDhTeVBjQ0Uwa2FNNzdYcW5F?=
 =?utf-8?B?eHc2VFE3ZlpUMFNwZms1L01mcVVwSE1JVHZhbzE2VjBXMU53VXNWWURaeGxz?=
 =?utf-8?B?eEZDS2xoT1lYMlQ3K253Mms2bGJHbWcvNmVocm5ObllRbXZFTU91TzB1NkJM?=
 =?utf-8?B?U0t4elU2RTNabTJFY0F6RC9ZUzU0L1lmMVVibHAycVRBL21GdkFTTkU5TGN0?=
 =?utf-8?B?cHBDWDd4eGY4czBQZ0FLN1o1ME9PZkdtNHVRdGo0azRQU2lZRUdqNWltMndR?=
 =?utf-8?B?ZlRUMzM2OWZMM1JlcXU0c0k2L2s1RTBlMXRkeTdHRXlhTVpQSmdXTEJ5Rnh2?=
 =?utf-8?B?azBZU1RlaVBRN3pTeWN4VCtqQmhKNjBvTDkvN04xVmFabHgxby9NOHQyMkxW?=
 =?utf-8?B?RzgyUE1MUmphaUV6Y1JiNXRsdGdUR0JySUUvNERrd3Z0UHhLdXo4OUNUUlll?=
 =?utf-8?B?bWJuWHd2YUY3TTI2aXdRVGhDSTh3RmdQdzNhVjBUY3AyWmZQQ01pQ3hOM0Y1?=
 =?utf-8?B?cUFtWWVyODdrbkJZYnlzOWZjUTMzTVdzOXkyaUVJcHZYbnF0aWZyWnVzV1lB?=
 =?utf-8?B?Nm1XeUs3ZDdoWmR1ZjVsTDRySFdDYWZRd0VkaWxiSzk1dUd4VXUwMnozR3Uy?=
 =?utf-8?B?UWF4cWN0N0dNc0ZkWGQ4Ym9wTnY3NTBDdHZvL3hjdFd3dW4xaDdoUTBwQUFN?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rAwA+t1DpXAzUYUJaH9bq3SPyWmZSyV+RjcrDyr1q1tRjBOSieTiGoI/1emJUqNZxw3DahMOp2fR0K995WrhrqNQ0lp2rC5YEVTNY9+6mRg5CE7yJMwYaQ6NQ7bkyBgnu2kf+UV9GRExqcWVZSwF2lLptxbRUH9qfuTI1nNQeSkaV9NCGhOC+3NGI8e91Ms4PiGruIMAeVG0WBKnMkPi3Zpcnd7wKAESMCEBdedhzDO10qrlgsbct8QndZC1vCNUtXuup77rkeR2tdYE+qTO6CchMZ1sIHUyOnsrnKP6FCj+owuv46O42b+fZgvH3lLXBhDyl1Fqu5tD30ZmmvyXzUis2XBjA2MCfkyaQjGdSxy28DPvGwINUT3+2bYqItGb6moe4ZAFDviuzwyKoazhpBl2T4XjYXFAYmm83kveVVe2HOrbfEjGCmuzGD4DOwwzY1lwHL2NI1iRj6P2GAi/VLeMHTCjkZFY6+6sIs+U69tFmMhQpnqLfCGnvbpk7jJZhwfCUbXAbmCvPGsoUFNc16J96FNxcO+y3LsQ7ZQvBXhI/wDDU9Z+t26HJzh8LLecniXaqzvqtkYdgVtR/8RE0XPonbhB/cYQukqUKYCV31Mxbq9i76QArlWBl5s/cQSLdwVcz4VmxBSSxNtG79cZX87g7JhoVHio4QD6g9Fuj03Dj8lJS58MTQXrB+jo0373dRmLZZHorec2drkZPiZYAMucPngWeeGcY2JE6W5gVv2CsQgQth110KUgcwxQWRcsrCFiR6J37b/v9QZg/wKG/8CSdOyCAWnWajQ+AO7CiZtyISOuJdG8Z1uWyGrSUuHK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce53d65c-3361-468f-6991-08dbce5c1966
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:25:16.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg2E5EbHDIBUvYL8gLDBYwRPeaym7lS7vs/XkWGvdh0rHwAQbRssogCEpJnhnP/MaKyeJmMqkP/SEY3RtdIlgfecvipB9HGgNMJaBCH3tdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160133
X-Proofpoint-GUID: GAS7vpltnlICjg-yE9pk8AmVqucMzM6M
X-Proofpoint-ORIG-GUID: GAS7vpltnlICjg-yE9pk8AmVqucMzM6M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 12:06 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (htmldocs)
> produced thess warnings:
> 
> drivers/target/target_core_transport.c:1930: warning: Function parameter or member 'se_cmd' not described in 'target_submit'
> drivers/target/target_core_transport.c:1930: warning: Excess function parameter 'cmd' description in 'target_submit'
> 

I missed fixing up the param name when I merged some functions. I need
the patch below.


Martin, because this is only in your 6.7 scsi-staging branch, should I
re-send the entire patcheset with this patch merged into
("scsi: target: Allow userspace to request direct submissions")?

Or do you want me to just send the patch below against 6.7 scsi-staging?


diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index c81def3c96df..670cfb7bd426 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1921,7 +1921,7 @@ static void target_queue_submission(struct se_cmd *se_cmd)
 
 /**
  * target_submit - perform final initialization and submit cmd to LIO core
- * @cmd: command descriptor to submit
+ * @se_cmd: command descriptor to submit
  *
  * target_submit_prep or something similar must have been called on the cmd,
  * and this must be called from process context.

