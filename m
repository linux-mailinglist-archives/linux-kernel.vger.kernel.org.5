Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD57EB88B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKNVXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:23:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0691C4;
        Tue, 14 Nov 2023 13:23:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEKidO3005288;
        Tue, 14 Nov 2023 21:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2vK93/k9j6okU7S2tyHJh35JNzcg+Y0SOdgbqUbwJI8=;
 b=RrBJESL6cXbKm0rqyQT8BwCkoCYDXJ23bTmbKrtKtjdEq35bb7Voaly0TBju3Iam8h7X
 1AIoa06r92JKZsPybHvwWDHte/eM2BGKK1vSPHYPa0bdMbyQ49Km6RW5Elh89NvS8MRx
 UFT5GiKza5hC+f9o+CRyFaHliMl0aAF4MNblbYuQl9JmdVLlh0+QhgpDw6KcVRrxd6ND
 hlOPXCP96/gGIE0hxlCzB31wa0OYLEZPQIe7+B0tyV7vheskYmCvfgIciY5tdbso/J1L
 RwBxwEYtiQcqIJIGsx1lzlK8rc4mKLUe5yDc4T35TX6EfwYc5u1d3J/STsyyc5snEbHe Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2eq71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 21:23:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEKJT8S006905;
        Tue, 14 Nov 2023 21:23:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxh1yn7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 21:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9oT2kurDsU8cFCPdw1vuxVORcZR1oq4h+Xyk+vhvriGyxmQQBxQ0AFTe6u7xX/QPxKDI73w2/Q14a4tr8QNn6cJdnHko3w7178zvnGlVMpwyW1mgL7hTHRk9SzJyzsai16+swGyOalAiVXO5672xQOLJ9tPfN20SU/MVqxBmyFy4DHug7sV3AmYAKtXnDskBMLnnd3cdTmrVwAcBatZkDEDZ85UYVrCOvCJg97ldeLI1KajhFRCSBA+840Q2QoJdBf8pTDNzRLu6bYBJJtlsNbbzQRVbt/So/d3OdoUKMFHrEyrw/3oQDi8cySJdgxCewkRttOWg0C/4FIA0x/67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vK93/k9j6okU7S2tyHJh35JNzcg+Y0SOdgbqUbwJI8=;
 b=l9pye/iZPZsJZB4mitjHhchYI6LTttyHhk96395ITl6mxEp+I/7Cy92NT+cIOIzFl4b0kJ9Fzu3hFl9dt7aMtzimHj4/1TfLoZJ36Pn7ZsrWg0yLr2XCAVM06MgMlnNgWFyX90nDlb6P8R6wJAvkSqwsHQ/tj80kwqBW2bbu10pS/TPYiaBFPYow2fP9FHUOBjEgwGoB1z3oXGjkEyzFPX2n52Ynyzq/tr5klhTnyZvwtbxoMVMKLegEo5J98W46W+Dweuo1ZMpqiQkYdzV+DKEwQBNC5UFjF1FI/+1veCWxnpjWHyVTzXTi+Az5yZS/Rv+oBPZwO4YbToKFl4fq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vK93/k9j6okU7S2tyHJh35JNzcg+Y0SOdgbqUbwJI8=;
 b=IJifzn4U6n4Bu2Yk9Vuuej2IAEb3vgSftDkRIzm+W37ngcqLjZmc/j5SKjaNV2slvYm+w29g/Jx0WBpEVjZF0sx2jrcKE168SXlrauFAy6cTIjUk4hz/nLdXZAyCtpP4mPgnI7Pir5Y/2/m4jAILr8o5TbH/FxJgIyLoonpXu/c=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB7144.namprd10.prod.outlook.com (2603:10b6:208:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 21:23:28 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 21:23:28 +0000
Message-ID: <b95cf250-9a58-4a9f-8b55-4b6d00a6a6c2@oracle.com>
Date:   Tue, 14 Nov 2023 15:23:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scsi: scsi_core: Fix IO hang when device removing
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <20231016020314.1269636-5-haowenchao2@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20231016020314.1269636-5-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::38) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 83be8e17-4c5a-4076-339c-08dbe557f1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGGqxnGQFyMpOmKL+tFDTdQ4tvtwBJY0akzQxoU2UDUpRPizfvj5UgPpvR2C6GAb+y3ZdA7FhJZE526zj6XN4vHR31wZbo8HiMTffaJ20pLzR/CHsIUe/hFfzQuuv2CvLBxUpOLZk4O3xjHnKiTQ/xdpCbjYYf63sYvyfZ8Uo3wxKDqomLqDqnloLefrxgwy09Mywc1wVbREzB1jO5fUlCQgbxJKDF/EAkpcBkCGM7QxvAyoxeBfIU/8AIR5A4jDvj7go7lQ5gI2PxFYH1whhY+w0NvV/hnHrKxwOckwUS6JzYmk82XNmVWkBwZMeKrPSyh12cjPeo3VhMu4rcfH8qBr/8HPidLqNBmV/sA55XUIq1BTN9hwmDLvkxhIWjyuDnILhqlEN5U3xgC1GpMOLGSK68CUgbiF54G0fK00mTUSMnc2nRgA8ipgNxVSfxa78wmq5PjKqK2bKvIE1X8hPRtQeoGCzuCwyRVgfT0wzBIlwvv20D0rhByT1dVurpcqbtEyohbCg2u0psk4oD40k/fcn7BDAbyktXGK30zIPDRBdkPgHfw5fzXurPdue+QBFEjCjEU5ds2WTMkEs9n5pS3tPyWqXS2RImxSjatHpXj1IblahGr2oar9ofM1kAC8T89VHuyf0qwHKzOTgku2nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(53546011)(6506007)(2616005)(6512007)(83380400001)(8676002)(5660300002)(4326008)(41300700001)(8936002)(478600001)(2906002)(6486002)(110136005)(66476007)(316002)(66946007)(66556008)(31696002)(36756003)(86362001)(38100700002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjcwU0czQXhtVmYrSHMyb2V0b2tzdmNpRWFOVFNmbGV2Zk9qYkJYaG1pallV?=
 =?utf-8?B?YjFuOG9EVlA0V0ROWEVMbHBsUUV2YnVtdGFnUkRJclFlNlpPQmF3djErL3Fj?=
 =?utf-8?B?MFR2c3lDUG44RmR3TGgrRVVhL1JvOXFoUFc2cUVsN1NqWkhaK2Q3T3ZkSW4x?=
 =?utf-8?B?Z2dVMmQ3K0MyRHNOc0w0ZW5mMis3S29xclYxMVlOWFZlUndvdEFtOXdxRWFl?=
 =?utf-8?B?TmQ3TmJFa3hSUHZNWC8xb1QvU1lHdEdEZGVuR0hrbDByM3VYcTlOeGw3V0xx?=
 =?utf-8?B?UzA5R1V4NlpmS0N3WGJTV3pqVVFkWnNNTWZTekxnbEZxbVExV1VZYm0vYXNy?=
 =?utf-8?B?NWJFU2hUeEE5ZTE1dktDd1M1ZHBJeEFhTHpFS0Y5Y3Q5cC9SQW5vNTIyOGRQ?=
 =?utf-8?B?cm9xeXBveDVzclFKY3oxdXlmWjdLQk1iVy9nLzFueG5kVVBaMlBJcmxpMy94?=
 =?utf-8?B?MXNJN2ViRDYzWDdBb1BMc2Y0RTBXa3p3TGs1YVMyMkdqQXpDREd0eXFKODg3?=
 =?utf-8?B?U0NtWVY4dFpzY3hVbVdCRUZHK1lUME5NNk9FRXcvRVJzcHdhYjlUNG11RzhK?=
 =?utf-8?B?UFFZM0VtK0cwVlZGQXFBYUgxRFkvRzYvQ2ZRM2RYSFJKOExuVFJ4V3dZTDVO?=
 =?utf-8?B?NHgwK2txRHlOTGQ3dThDcFlCZmZWTU11OHlPcGVpb0Z1eG5EVlB1SjJINGFU?=
 =?utf-8?B?WDZTWGpJNW9nV3dnd1ZTSWlqa3IxMytDZlVMSEV5MDlsYWwzZk0zT3JVNjRv?=
 =?utf-8?B?amVZb3JpMmxGYjhXQmhTRlZXR0VjMHFOSmZQZmRPZytGUmZIL3d1SzkrSFVz?=
 =?utf-8?B?TEhROFVCQk1SM0Y1VUhoVytYY3BQdXQ1WnZQTE5VSFFHMlVqRGQwc1ZNKzZ5?=
 =?utf-8?B?a3IvZ3JoeUxqRy93aG8xZnVTUkFxSWhJS1dOdmtOc3EydDJXQzEvRUl2Q3lO?=
 =?utf-8?B?dk83QVJueUJLWnRETXJaenlxR2g5UGpXTXdlVlBNUXJFNTJoN2plclZJNGM3?=
 =?utf-8?B?MWVMa2hHK3ZOYlp5S1lCYWx4WTV3eE03aTMzanZyakhaRmRtMElvc043RVhl?=
 =?utf-8?B?YUF5RjQzTDlaNjlVUmRIajdXTWdWVnFzc1RUcWZUQThtb2lMS2ZYbjV3VmVE?=
 =?utf-8?B?bzh0VGFaZXBkMUpGOXN6MlgrK1hNOUZrZ0JrYjhiWCt4Umo0ZmRUQWdXQlF5?=
 =?utf-8?B?dVhsZEMvQ2NYOGtWZUZBU0NvdjBxZXlyR2NBa1NEN0hRb3hkMHllMXRqTzhw?=
 =?utf-8?B?UENTZXQ1c1BFbUJVU3BQeUVtT3BiMU85eUl5RnljckJscTBWQmVYS2lsL1Vh?=
 =?utf-8?B?ajlDazlWWC9wcjZQcmJIay9BdWY1YmdHQm9VTFZTTjZjck5yZW5HQUh6ZXNI?=
 =?utf-8?B?SWdhMGs1TGcwTVNGbGJBZndlZTdILzZmZUIySWdZKzBBNFY1QWlEU3pGVlFu?=
 =?utf-8?B?MGJvYnBrcEtuNzF1MEl1QWEwa3kzdzJiQzBMVWg1cXVGa1hGQzlWWTJkMXZj?=
 =?utf-8?B?Z3J6ZDh3cjdxTHJTM24xY2hTdDhBS29MQmN0a2JSa2Flb3d1R052TnVCZEsz?=
 =?utf-8?B?OGdNdVJ5ZGNrOEF4b2lWeDVjZHNSZTVIOFJLTEZJQW5TTlFNWGhseUkzbGxu?=
 =?utf-8?B?MTJyYUhpWkduZ0FxSDd4ZzdNWGxDOGZvMXF3OFY1Vk40WHBubkRzd2dZMG5D?=
 =?utf-8?B?VE16Vy9BNHpJdmJVZ0R6TTNBQUVhTkZnaHhPUGRodCtWQU15ZG52ZkJuV2M2?=
 =?utf-8?B?d2R5NGY1c3diQkZVNVg4Ny84SUVNMWQzM1BDUnRRMjlvejN3QlZHOExxNGFV?=
 =?utf-8?B?YUl2QzV5SmJIdjNGbXNqNSt4U1NlSURwdndoaEFBTUxad29yTC93K256VjFX?=
 =?utf-8?B?V0MzdHJ1ZjN2TmY1TjN4a05DbXA3QkdpOEdlUEdtNG1GTnI2SjFJRzduL0Ey?=
 =?utf-8?B?ZXVEcmpsRmU1R2FSKy8vZ3JQQ1ozNmRFTWFpNTkxTDNVb1p2US96cXBTRWtK?=
 =?utf-8?B?L2txRjBGbzB1eSt0VmE0eGtWei9uK2Zud25rTTdlUG1BNnBCL0Jlc3M5aDBj?=
 =?utf-8?B?UzJjK3JIUFBQQUhlamhoSEh1Q2VmbnM2a0pheW14NVdxTGgrZVN4NG9UcC9K?=
 =?utf-8?B?eE5mcWhtU2JMNzhsRHFQbU1HbmloNWw0NXZEV2JaR2hBKythMVNmUGRRYi9J?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sibRJn74Wt+J3ATh0tgv53RegOiHAEhXmsOA/EqbwxVjFUBqJPeKS5nqsmZHnIVyiblYhOizcUgKoMj0CedF57ZeueZF9QCqfjoGS8yHBqywT1BvjCJGwUu05dHkhBgDkzZJ7Lvk5UURGOYxUSLYI4ey38XB0HF636kDf8llTtCFFrl6lEaGwhf6YhKGwQI/YO5FXamuIZDf9BB8znH0spxMwGtICIT64UqfpeVO8OPln1IcnhgJjzVJhnfOfakoCGmGOehBAIvw8fDSE4JPGRANRQuotqfa4KPt2rGIKif0Q6YNQGaAZ6L59KtF+3LQ8ZwR+znrFY10J+Lf+AE/gXCjE4mPwQUX/Guy5tbTJXNFTe8XJEhtangh3mFSDduY74UmR9yS9/zt9LyR9xADNHuVBWDJCskDoZro/18FPIdFUhQ+U/AIE9bqThVo4/Tbh6Otw5q8G85HJZYWiwZghh7fNt3eR7Ck8EPsLmZ+Sc6zCQElGPfcdJe87xZ0Q9hr48cH7eOO/xsbCutabV88AsfcJr5KUHuDaicKL4dl8afk9Xz7ckDipJ03qlv37Njnqqdhuq8j2KDjLdypx0IaCMz94P6AOpfbkkSNKR8qIqBxTqgv8P7GItXYxO5rvB3RWARC13szuqG/jTyNep7rnHGFgAUvxLtoxBYoJPSRUpM4GgGpkZ2LHOpZ3mYO0Z2hncRyU4U6udAGIceOZNbjyZ+KRiAG+35yroPTtnYF7qghBxC15mZvzXuUubF//bwE3QJbSE9qJKnuiUyfone9XNOvGo4SmID5X0qISpQ9WmcxrUJrD5SprG3Oh29CfN/kh18GALURSYDMso0gxc/zNg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be8e17-4c5a-4076-339c-08dbe557f1d4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 21:23:28.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQetpapWj98oM98FNL7WfgzXqfyEbX4595LF7gOYlfY+JZ2bQJy9I42JBpVZYVS8FvDCDa4z9NBO/1jvtzlx1qeYO/dGFA/mR1Lbeh474Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_22,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140157
X-Proofpoint-GUID: UhRE_8uydd_1cnvJNAU-363n02IitvgF
X-Proofpoint-ORIG-GUID: UhRE_8uydd_1cnvJNAU-363n02IitvgF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/23 9:03 PM, Wenchao Hao wrote:
> shost_for_each_device() would skip devices which is in progress of
> removing, so scsi_run_queue() for these devices would be skipped in
> scsi_run_host_queues() after blocking hosts' IO.
> 
> IO hang would be caused if return true when state is SDEV_CANCEL with
> following order:
> 
> T1:					    T2:scsi_error_handler
> __scsi_remove_device()
>   scsi_device_set_state(sdev, SDEV_CANCEL)
>   ...
>   sd_remove()
>   del_gendisk()
>   blk_mq_freeze_queue_wait()
>   					    scsi_eh_flush_done_q()
> 					      scsi_queue_insert(scmd,...)
> 
> scsi_queue_insert() would not kick device's queue since commit
> 8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")
> 
> After scsi_unjam_host(), the scsi error handler would call
> scsi_run_host_queues() to trigger run queue for devices, while it
> would not run queue for devices which is in progress of removing
> because shost_for_each_device() would skip them.
> 
> So the requests added to these queues would not be handled any more,
> and the removing device process would hang too.
> 
> Fix this issue by using shost_for_each_device_include_deleted() in
> scsi_run_host_queues() to trigger a run queue for devices in removing.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 195ca80667d0..40f407ffd26f 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -466,7 +466,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
>  {
>  	struct scsi_device *sdev;
>  
> -	shost_for_each_device(sdev, shost)
> +	shost_for_each_device_include_deleted(sdev, shost)
>  		scsi_run_queue(sdev->request_queue);

What happens if there were no commands for the device that
was destroyed and we race with this code and device deletion?

So thread1 has set the device state tp SDEV_DEL and has finished
blk_mq_destroy_queue because there were no commands running.

The above eh thread, then is calling:

scsi_run_queue -> blk_mq_kick_requeue_list

and that queues the requeue work.

blk_mq_destroy_queue had done blk_mq_cancel_work_sync but
blk_mq_kick_requeue_list just added it back on the kblockd_workqueue.

When __scsi_iterate_devices does scsi_device_put it would call
scsi_device_dev_release and call blk_put_queue which frees the
request_queue while it's requeue work might still be queued on
kblockd_workqueue.



