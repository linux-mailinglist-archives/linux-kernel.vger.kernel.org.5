Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820707EE5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbjKPREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:04:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED5D4D;
        Thu, 16 Nov 2023 09:04:47 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGXrNX010010;
        Thu, 16 Nov 2023 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X8ZXYpkkhFgkJMT24SdLguIhiBz0kbxPB3WPJL+cxqM=;
 b=vINbSf1N6iG+AGOcML+AuMKYxeZqPEh38eCpE0tgRPdKsnGkpFANLSkWdLxLabDHCWbW
 NwsxyAENJqh4BtKaF43ltmOXuI2zsV4Y+YqZu/irGVMtdQLCCCCGHSQYqeCAwDUSyLeI
 8Iamp03rfuGQ4BhLhfsRzNToqcV4ppLNS0jXw3Z67Y/OPWXniU4FxFbcGrMUIXbOj1qR
 GAoqUQk8gfahyc0sDLncWiwL9q318djYjaJYyd5s+XIrNz0fTZP0hXUVFO+3yVSD7vpt
 lT7rwgkWkEfXb7u9hSxXRQKYU9SPJJgJeIF02rtG9v71w5M3KoCr05xzQaTWG56LHd9c /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mduscu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:04:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGOW0h027597;
        Thu, 16 Nov 2023 17:04:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqveg0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekk6PPV2JTB9KxLdvGhCdCQQardLaCvRhaDUchMBLulVbwAAGaed9v2+8L1qVV0mzvQWWuHByFBuo2lmLFZWrTZ6Ooky4ukAxZ1jrtHLEeKQmlrPMjLIJJ+i2jXMd5Vgtj9Fbr1SYeV/7+jPbm4S5MD/DC5VsGAyoAy14M+yDFGi+yVZ12NHgRvCliCqfhBbBP3pj0mtNRz0XpL/SsG6BlIfx06h+TCKxBGJxoHxC4SeeioObZe0XDDPV1uvuNY2pyIBmEO1q+Q1OzFbak2Rp56M42biYG73ADCNABsiWx1vrK/7+O8xIGKqjw7+crimS47kTrEB9/jxDsUe9it6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8ZXYpkkhFgkJMT24SdLguIhiBz0kbxPB3WPJL+cxqM=;
 b=BhHD0QIlnhVrNuD0JflFDUU5DhDHt7kQ7keDw+sgd68P7GDOZAXpywYezNw7NQcfrxaTm+qpl3VOV4Vf7plBU4veXcf/XYr4mtVFCUEcW1Z7l0Q5J9VLAA1kIhKH+Pyd97DVytx8s8Xvhdnjrn1+wmuoS5fXX5TamJBm+elYsVHT2P+4FkFd2NnXgt0eVMmKDAo4DXTa/EiSZG92jNXNqPlI0o85RmKh78DmYOKZXK3v+bjNX+DHLgNLxJY51kK14xksRjwb8vyAMVbOBoVoO8A3aRSEuxD4/15htnrBamvfdKt+351g9JbJMJSYr+EkcUcpDreoYYZ+nU4GNX7FCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8ZXYpkkhFgkJMT24SdLguIhiBz0kbxPB3WPJL+cxqM=;
 b=EWtiHMdaf5VRtGnP2p6WJCQaDsNSTZueZs8m4tG1/2q3QrpRkYOmMiSmxmTxn0csYbAMx044w+RKb8jCCfLL8Y0L27CqbBF9FnyfNW9R/a+BjTNQSRI66tvCbZ602f+ptr+8eqnYP2ITxWBEKuWeEqUw7eJhaI/6Sd4qxOlEV9k=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB7011.namprd10.prod.outlook.com (2603:10b6:510:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 17:04:36 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 17:04:36 +0000
Message-ID: <c13b580b-434f-4a4b-b0b4-917f8b042de3@oracle.com>
Date:   Thu, 16 Nov 2023 09:04:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, gregkh@linuxfoundation.org
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
 <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
 <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
 <ZVPXd-3TshjeScek@slm.duckdns.org>
 <443775e1-ed94-452e-8f06-eadb777bede4@oracle.com>
 <20231115162915.000064f8@linux.intel.com>
From:   junxiao.bi@oracle.com
In-Reply-To: <20231115162915.000064f8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cced30-cbc7-4b90-bb88-08dbe6c61cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0H/QhohtUJds38RIAWaruZSkdWBCQ5eIRNNug9bv5h58Q5G9M26egal15XNJWOJ82kSk0CFxigPcZbqW4ynNN5vsIQW8222+6m5yp0kCXQzoae1XC8q9Zl+1hdL6hVqtO8t2qTyHoPC9Tf2nfSex2SbA1ISVGUzs7n1dqLBoxYsbF9/b490PiuxIYqvdVJ05xDX3/u/IJRUycKsWJJYSCZ+yl4ZMLMf1sSM1o7G5znEgasXB64OHFy9P/aWqwvNLOh2CjtImyBH0V3ZBYuStzuk9jcMOtOPB+vzOjc6zgd9SrQ6EQDBswQZvK1X4pjxuqmI7tbFzbKkAfCVDajPatIVQrxI/bvLhK2T297MqrpBHVzXwlJkjf3CnPz0F9iTayDvHZapDkDMr6127rlHl1rT9wTl4f5RLaVDJxfdzolN8+TMb2mgNNeewVdfgwUazjkf7zr1HTcDKrlGUnBz8CfhvVkqpl/XVrPw/kneW5nujV3zrw8FK0QrS3kv7lgG9NnT+97XTvgMglokRsIlNURMyqpyTeWa+9wr7SvYgZf52dDMIBsTT2AX7jfDTG8CXCk2qsVsNJHaDjLDl7cF07PoTF4b8pU3JnCOB0IQdbmzooaL8fAQj7q242PSGQOxDxY7/ehZhWSj3R0TjFm4YZg4Delv03uuLdthW5P1KzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(186009)(64100799003)(66899024)(26005)(2616005)(6506007)(53546011)(6512007)(9686003)(5660300002)(8936002)(8676002)(4326008)(6486002)(41300700001)(2906002)(478600001)(316002)(66556008)(66946007)(66476007)(110136005)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5rcWRkUXA3TkVTNVg1ZkdNSC9wZUZrRU0zazFQYkU5S2pkMG1zYXRmWjhm?=
 =?utf-8?B?WmV3UCtyV0VkVS9RTzllZ0dOdytSUWV3OGxraXh3Ukhlek9MWFFOUThZSDBi?=
 =?utf-8?B?MEtaR0RMNnQ0UUxwY2d6SC9ZVVdrcUQ0Q1R6VEg4Uzg4OVAxSXg2TUp4bnZO?=
 =?utf-8?B?cTJ5bGpWeXVwUXJkVVBITkxaVkRoRk5tenlZWU5pSGpORUE4d3pXMW5weUNG?=
 =?utf-8?B?cU9MZzkrWUNJbjQzb3NVUnJyYkwrcm1nQ2txYXBRN2pRN1ZxWDMwcDJ6QThI?=
 =?utf-8?B?c2V1VGFyZjhVcmdPMUp5TXNWMlRuR1phYzdmUVdqSFpmaGRYamUxSC9wVXk4?=
 =?utf-8?B?Tk9YYVhHdk55Q2lJd2NlWERtV3FjcG5MYUszcWMzRitIc0xRcDJMdTkxd1Jx?=
 =?utf-8?B?YzNZL2IzZUlNOEVBYUhnNE5yVjVRMUpab21adFhtRnJkQzJHZDREdW5HUmJF?=
 =?utf-8?B?YndHaHlNWCtxTUtIYVNCNCt5alc4SVlCbG9OWnlhOUxnTldPU1FueUEyYWt4?=
 =?utf-8?B?WTJrbVYzY1FXWmJWdGdaYnBkRFRBMXNjQmh4am91UXNjZUhRZlBoTmdxUVBi?=
 =?utf-8?B?Q1RUSmxEWlNtY0lMVmR6SlBOQlZCdGZhLzJPR1VHTVBEcld0bTVvZXpEdDV4?=
 =?utf-8?B?RDVvS2toMFI5T3BCQmdObmtwbUltMjAzS3FBdDlGTC9VY0F6WVdTcVlMdmpT?=
 =?utf-8?B?VjNpekNoVVBOWXF0SGt6Nnh0Qk9GZkRPNktscFB0UmNhcXJPTUNCNG8xcW5u?=
 =?utf-8?B?UHI5RU13S0pJQ0JvQUYxMnlBR3BRYlN5Z3ZDekc0NzNSQ0JEUFV2cmVBVURX?=
 =?utf-8?B?aHlONUJoMCtGWStEQVdHb2xKT2R2VEUwOWhDMDlqZlZuWjFkRFl5SSt1Wkc5?=
 =?utf-8?B?akVMUndBa1IrQWtGVlRwYVdlUmt2WTl3eHZ2ang5cFFzUy84UW5FbGdXdVhF?=
 =?utf-8?B?enJrUGRGNGpoTEI4MFNoem1kNFpiNmZJN0V0c0RBNGl4NXVmSHJnM2RsREpJ?=
 =?utf-8?B?WE5qZ2pnaGh6VHYwZ3B3NS9sQWJhc2twb0NRazhPd2lBUFkzV2wvNjlpVGhH?=
 =?utf-8?B?TldLVWZHQTF0NjJRb2pCanR3ZENxZ2N3dkR6Q09IZkg0eWlJamI4bDMyVzVl?=
 =?utf-8?B?cG9pYTYzOGJBbE9JRTltNGwyTDZEMTdLL1A1eUVtanA5MTM4emprQmxhVUpo?=
 =?utf-8?B?SFpMT2NYYlgveWJoLy8xekwvU1VqTEtnU3BSalZHVHVwODZ6TUxKVHpFSjB2?=
 =?utf-8?B?OEwwZVdTUFdBbTRZMFBNQXRqbUFZdyszRGd4djRVdTNFenB1K2tFb1NLNEM4?=
 =?utf-8?B?ekh6ZVJXbHcxbVRlYmI5RFUyUFN3NVBTNk95TTlYZ2N1cWhBTEUvWkZ6TW1u?=
 =?utf-8?B?U21nTlgvK0VNUWFsNjlYdTVLZEJGa0daOG9ob0RpQVVjbXdmbFpGaUpKUnQx?=
 =?utf-8?B?WXI2OFVvSkw3M1RqVnJ6TFlFdUM4aWZyUHE4UjNGZytPL3BBT3ozVFV1UUhM?=
 =?utf-8?B?SGQrWmE3VU5ETjZ3RzFzL0tBc2s1L0h4WVV4R3BySjNqa0FZdVlQNVQ2QStW?=
 =?utf-8?B?cnpsSXJ0M29zbHUxVSt5c0Q4dVNLUENiclRVc2RtS21PY2llQmJPYkJsdURH?=
 =?utf-8?B?a0VhWGhta3NQaHhkUGZ4MkhBUTI5Q0orRmdYL1F6cWpEbkdnK2h5Q1laQ2VZ?=
 =?utf-8?B?WjdYK201U2MxS0FiVHBFMWVsOUZ2Z3FHZ0JNR0tTOUlxendGano2TGdqN2NC?=
 =?utf-8?B?NHVCV2lQRjVsSHJ3M2hLalM3VFd3OHB3SmJwVS9xRDh0MkdSQU9xRmpmSGE4?=
 =?utf-8?B?NEdRSmZabWxBemppcnE0MCttQjRMUGpBMVI0R0hodHlzdGt6TU5ZNUk1TFNJ?=
 =?utf-8?B?cFZLTTJJM0liMWhCQUZ6TjFYcElSbU9MUzdMbkhlNklqemtZSlY5RUtIcDRl?=
 =?utf-8?B?aDNkc0dtalo1aFcvM1AxZHk2bkpPWVpxZ2VReHAxY0hOcHhVYXhjVGMrWlRM?=
 =?utf-8?B?WFNMbDhlZGhPUmZnd3FraVFISmlBK3JwcEJtK0k2U3RZeE9HWUozYVZxQjdG?=
 =?utf-8?B?UlZwOWdPNDdpdHJjUjA0UnQrRFVQUTBuSWVKV3JvQ2k3ZWdzcVlKNmU4K3Uy?=
 =?utf-8?Q?PUFXqLmPqXYSxuSOdhZobUx45?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fzR7PIsxhzfRkqffPijFZwY0BFW2PSzk6HbEPZqWQ0ulEA/ch3uOLR7rzb04ySra6KqLg+sb5vbXDQPLHBAMzx7OjCc5/7n9ZyGpZu0ddIlfS8qBagsf6YF4i1hLoWASdW1MXqlef5PQ/TWMwSVhXWzIoGG4M2TMSLkU2/mvZmOfupfYman6TRyYKmISVO4ohv4MKe1X1Pac+1p3NTb0N3SEH+d5Aj8RwAXxQQKQZNQgskyp6yZSStRNxalpNW/DLUpEHCrWwBjWwRaww6izls7/V6fpoB4p3e2brhHrHoZuAz1NWU21fTx0VrRuiXNgupws03SrIpNXjUshySF1dy7FaJBg+02CyDlwQLRJ+qhopOTj9+ffWIuOOATWuTUWm0A2ky1tehkj7Y0dcA6KPMT8Ab5seDKpTBv3hg6Xlx85zsnNeVeQxBaKm7JsgZkjG4wLndflPp5qUbwAfX/LOLzU+0yrfBWT5HLQDghj6/m5ehPoR2n0RlFEb3kBBX0HhSnP+y7rrfPzHnZzRvjURXBopbv/ScmdYWRmV+LdVtKgdPKWjGDMHKUnvQXa/zSYSYum9Ze/6eahwzEmzvhJseEKFX92r/r4eXdj2btzB4PfA0GAdd5vuMrv4feOVU0/GPNVKhMjCvaI95yZIDkGtCOW0krJki+gGEFvmuhjMSKnOT/IW/Kk44FK/SNfhizlylFwOGHzak4evj+GQtABUWRtIS2mMf9V4f81uwKnkSl5F0/qf+KlRqu6Q9+qE9IWINmUB9shQPhYiP6L1L7MlF4L6ocj1vE8Fb1DcCc/NGr/iktS3py80iD7mm0FUW4LrGlAfA55zFRpKGx1V2iNQhbVVJf3U6jpkleTetOBzN5v9bXOzFQ/pOOlHMtPtLT1VAp7Rn0gT5ukb7J+Zu9Zfw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cced30-cbc7-4b90-bb88-08dbe6c61cfb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:04:36.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBQ2ywyIRdmE6krnRgYMma58Khz2Iw26Yui+Lf9B9vjWI4v9I5Wg0BrfYbIdpETu4eNzxe4MJ1sgioCGMj4GKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_17,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160134
X-Proofpoint-GUID: GjTvaqBbWpUwUIGfhugvNgrny84PDUI7
X-Proofpoint-ORIG-GUID: GjTvaqBbWpUwUIGfhugvNgrny84PDUI7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 7:30 AM, Mariusz Tkaczyk wrote:

> On Tue, 14 Nov 2023 15:53:47 -0800
> junxiao.bi@oracle.com wrote:
>
>> Understood, thanks. Sound like depending on Userspace on memory reclaim
>> path is really bad idea and the only option for fixing it is to remove
>> that dependency, but i am not sure that is possible without breaking the
>> consistency of metadata.
>>
>> Thanks,
>>
>> Junxiao.
> Indeed the project of external metadata management if fragile. You cares about
> IMSM here (same as me) so ideally we should implement metadata management in
> kernel- I think that IMSM deserved that after 10 years on the market. There is
> no better option, other options are just "workarounds" for the lack of metadata
> management in kernel.
Agree, sound like that's the way to proceed.
>
> Song, any comments here?
>
>  From the second hand, there is native raid which should just work, so maybe you
> can switch to the native raid?

Unfortunately that's is not possible, it's a production setup to use 
imsm raid.

Thanks,

Junxiao.

>
> Thanks,
> Mariusz
