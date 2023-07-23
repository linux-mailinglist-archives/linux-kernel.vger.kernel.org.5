Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717D475E3E7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGWQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:44:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB7EA;
        Sun, 23 Jul 2023 09:44:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36N99wqu012395;
        Sun, 23 Jul 2023 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5ACNaMSY3l7Dl8yc44PE9RSEwKZG0otHrrLfoinNdi8=;
 b=C9WFWFX7N6uCA4tmBmGye8KvscDRUgjCh29nAsz5rr5dAmHJksJgLJWyWamBY8Z671uw
 Jsb8HiC5xbykmunFE0Sesn+8wscUkPclhKp3jePFJtlZnEgq8seml2kdGRCwi51+icRj
 m0wLSgpdXDhzkUjatnxPwqkef6s3leZQ+I5IiC0+3yyAetMHumEeQbJShpVsBpWVtA/U
 fMNtUL2vq7QG0LkQG8Z8zXGafyckqvHIeokto+2UIl+BqXm2YF9qiELW4soq+I/tbJzV
 nlctQt0UHjTKwZ57LIoxJl3O3GSt/RtH5H8dDB1ISRrccvaXJryELCTKZ0yc+FYM5eoH 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtscy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 16:44:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NFE8EK027601;
        Sun, 23 Jul 2023 16:44:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8uvjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 16:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0tlg26uiskh1bLp5M8KYISUjIteewYQb56eAZ6NOQjLqeD8XxpjjA5lvdlYr0YpjCtUoEnt96lv+z0esGKF9201IM+AvnXeOzkUzuwZ1o0WRxeTXClqpFanDIAV8XbyBQidBNdnUP4u6YHquGK3XvOIhUaQ569JuseFy6Wz4nkxPFVcjp1Nktve7FhHr/6Y1psfuFdL1dPmbFD75OT4FO8M2wc0/RiIe+zYJbOG6eo2kusMkIWhluY+oOaR8939PdAKyJSMZ+nWCgRRNCACa630CgEpWxFQvD7p94V/UYFMxp2ueS0kIhyt7rXb1s0Pnbwzw4VErBiDnIoOk0dOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ACNaMSY3l7Dl8yc44PE9RSEwKZG0otHrrLfoinNdi8=;
 b=RP4oY9iC8y+wGMXZ7OLUKU+P7XnE7z04PKJ+eLI9vzoJ9YwS7Y2sIuM2OuSXH5fhNqZ8E8wQHx6iURZmHjUIGN2yHszzU8u8uOxvvC4xpIaJLFEgP88jc28rsfrpMjwzNrJx2WcEiAOSEJoPXM9xF9igTZPsGmf3D8AQGwiTsoYAX6ESTr14DO0LNFjPbSMfCFCztdeo4PXNfVMLni8enF7hHMDg/J5ybizTsJkMsSaPqhWCyjMvYr/sMtXo0QNL1ONtSriFJwXEeusG5YGzB+v3x/vw7aimlvWB74u2XVKF1Lj9NvhemHLMusMXG3RnpHjfLdk55kCPclJWLf+H7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ACNaMSY3l7Dl8yc44PE9RSEwKZG0otHrrLfoinNdi8=;
 b=lX+0mUgKyz0YAi3AdmDW2fy4xHgo0s7GuWIZDTktynT8wxMbijhXAseqXfzgul3r9IjFn7tKy2ETwEbmNp6JK3Ki7iZqf+V0MLKu4GHogcWcn6sG1kF6/pu45Uqw8V8TNxpo8t4d0JMsEk+2eDctf3cjaAtEGDIYjW8M0NljTso=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB6853.namprd10.prod.outlook.com (2603:10b6:208:426::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 16:44:33 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 16:44:33 +0000
Message-ID: <59d94e6e-27b6-5b12-d592-8f814ee1788f@oracle.com>
Date:   Sun, 23 Jul 2023 11:44:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] scsi: iscsi: kfree_sensitive() in iscsi_session_free()
To:     =?UTF-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ISCSI" <open-iscsi@googlegroups.com>,
        "open list:ISCSI" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230719074534.5311-1-duminjie@vivo.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230719074534.5311-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d1d0ae-0e0b-4ac2-c70e-08db8b9c179c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70AvSo+nzcjiLq7llk8NaU32wlp4Np5DyQmvzKzC9fNC9fqQPU+0EK+vLh/YRNEJnK9gaRFA3k/rDmwbx0i8XGMjFFSAgi6TdsB4EorVEnLWXpCdZC3tz3XUFNOcV8xivVygj5EXQHFri7WoaCzAfCIYZ5HmGu7YGF7/HhwUndhPYpkhiLh9QW2KTKkDeejOeBqlksqqIhicwNV8AlOvNJIVeA8jAtw95cFQCGBGx0WJYl7f8XAZ6VnqTfjSmrVfgWSwfu2APra90NWkHtigV16eq3HvS/TTOY+WF06l7dQFAFFLJX5clSYHKK5fpr8ecWg37QqD5PpEP1+pToKI/E94igeQwhjQsD9Zq5ZffeuCMLZtHrHLkbeBqnWZG65D6XOXTiFWQPKHeMQ7YILw2px4zoYkudkrSoESYMv/BhCp/4gFCM/DuxoFKc3uRbSIgjRNOnPBMbXE6vIjjZW4MOtHVaq3CCbcc7hq5/EPkXYPhmr6DwtjUF/mtBCdxrFEmSMaVDS0z6oOKwAIKP9CwYoSKX97DLMZVLSWUfDMjvhU2Raei8jhUPmFzx8uioPP2CoN7xoAyreivi6Xqt2fgjBoWezlRDzMhLiwW1ZF25mcz6Uz9thhKGB55krtqwjdbAMdWQm3K+RoGjWBR0sAZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(31686004)(86362001)(31696002)(38100700002)(66476007)(110136005)(66556008)(478600001)(41300700001)(66946007)(316002)(5660300002)(8676002)(8936002)(6486002)(6512007)(2906002)(26005)(186003)(6506007)(4326008)(83380400001)(53546011)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpSWjBnc1BZU0FlSlJHYXd1WkJ6OVZWT2NaN0xSZmlOMDcrZ0NESmZzUlp5?=
 =?utf-8?B?VEVMYmVzL0hWeUtFdkg2T25EMXBzUmJsRXU3MVJoT29nOU5vZThYOGVhbHpu?=
 =?utf-8?B?RmdJMWxqM0p4aHlEOFVBMGZtbFlSNjlWT1lEbjVTODM5bWhqSTNMQldTSzRD?=
 =?utf-8?B?Nkt1SGhXTjcwYlBvTklQMHN2NmtwWUVRVFpDajF4U0M1TXBmM2IvWG11eW5v?=
 =?utf-8?B?djMyR0lWMWJEVHBiQ25Kdlo2RVhEOHFaMDZYTUFzL2xmTDcyMjM1VGdaQUlm?=
 =?utf-8?B?UXBXOGFXR0F5ZWQxNGZxbm1mMGUxNjkxQXJ0Ty9aRU9tdWxSeHlJRU5rUkhZ?=
 =?utf-8?B?UE1MWHZGS1ZadW00enFnYXlBMTN4ZmxMLzRHMHFKREp6NUpCQ0U1WVBVRzZ3?=
 =?utf-8?B?dXpQdEg3N2syeXRXNjJnQy9qcWlXdFNtSmc5eFVxOUtCa1NLVTFuWUdMYmJP?=
 =?utf-8?B?bjNIcDY2ZjJKbjRaRFhOS2huQVRHMFU2TVBmVXdNTCtDWVVFaEFsYXdYNURl?=
 =?utf-8?B?WjlUR056SVdKWFM0Z3JMMVpnRUxudzdVTWtWM1NHangvWVlTWmxHdDcrL1d2?=
 =?utf-8?B?YkU2RU9KVENNSk5VZ2c0bmU3SHhxOVN6aU9xUVRvWlBQN2tqYncxaEFZSVRZ?=
 =?utf-8?B?aU9saVZtMDRHeGRkYVdoNk13U1RFVjVTTThFeXRUN05FNlA1WmpSMVNvV0F5?=
 =?utf-8?B?QUNqZWxzaWFWdUZTVStIWTAwSVZKcUpRU3h3QVZXaGRiS3RHTE1ISGI3N2tG?=
 =?utf-8?B?cUgvalA2OUF4YUhQZllvSy80UU9haVpMdWpBK1B4d3B1VnhzQ0FQa2lhMW5K?=
 =?utf-8?B?VUlvUkFobFlEWHdNY2ltRUpCYkVMVG1WY3lDTUYrWVFmV3RoK3NHUXdTWlhH?=
 =?utf-8?B?TldrNWZmN1lNWVJ6emk5YkhKQzJ1d0Z6YlVyVlBGdUx3R002TFNwVHZvU1ZX?=
 =?utf-8?B?WmMyZzIyYVorR2c5U09TTUc5czRYd2N3b2I4cGhjTFZXYmthKzAwdmI3L1pJ?=
 =?utf-8?B?RGpGdm5NSVUyNU9tQVZjY1dDMHo0VDRJcDduQXFxUlVmSU9qbGtLVW1WaStW?=
 =?utf-8?B?RmdIZWhEeWY0RkYrZW5pMmovVmxlaVZpbnBabzI2TGppRHJ1MmFRSHcvKy9v?=
 =?utf-8?B?TmxjN2cxV1dSV3hFelErK3Z0dlk3V0twV2JtTXVpRXNWQ0R0VENIS01HU1lE?=
 =?utf-8?B?aXROQndFUWFQNks0cmtlSXVoT3FIbk44QlNlRmJQNThkL0UzelRpbnNsekFU?=
 =?utf-8?B?TTJrQU9zdDZRQ1JoTzNoTmZpWDZHWG1RRGxIcjdIZXQ3M3FlY1FmK3hPbHNR?=
 =?utf-8?B?WTZka3pINGFUTUdORUhDWHhhK2MvMHh4c1FVclhzQm9VMEdjdzFOS0g2dm0y?=
 =?utf-8?B?ajZVM1J2QmphOHhUT0xRNFVLSmcwNXlTVTF0Wnk1L0t3VkZMVXZTUmcyR2Fn?=
 =?utf-8?B?YmsyQ2ZoSWZWV3QvN0VzOU9BSU1Ha3ltSWQ4VEFrZHZ1QUFxcTdIUC8wazRK?=
 =?utf-8?B?ZWtOc3BGeEZuaFlGb1krQnkvU0NsSlNvUEpUYTBENUppMGJ0YncwWTloUWI1?=
 =?utf-8?B?eVBQcnUraWo3TnhkMkI1VDZKdWZnbFFhOEgzZDVTL29UNEZSU2hydkNkOXhP?=
 =?utf-8?B?ZWVHNFJVS2QzSGkwUmlHTmtxUVdlSEdEakJsQ0M0UmtBMWhzeWZyUWxJa0o0?=
 =?utf-8?B?WkVMaHhaMXhHYTVCa3M1TTRvS1pUQkJTWWE3Q1VBMWZVWXNEamx0b2RuMHJF?=
 =?utf-8?B?Z3Y2RUhGSm03aml0VU5oeXhWQ1hEQkJ2dzc0U2NlZnowQUpMdUR6TmgrdERh?=
 =?utf-8?B?bEhISUJBMzlZd25kY3EzSHhHVS9UdGtqRS94WnV2dkR6YmRscXVKdGc3RUp1?=
 =?utf-8?B?M3FQaFp5UlNkamp3NWdPTm9UUWFoVEt1SVJYMno1YkZ4VlMybEswTWUzVGN4?=
 =?utf-8?B?YWFsSjlMUmxsZ2lMbUpXcFZlVTY5Q0x4U0lheHBWOFhTT0MyNkd1ZTM1ZmQ2?=
 =?utf-8?B?enNBWWVEWFpCdzBjS1pKSzNyR1RWUmlhWnpGV2RSQnY0Vlp3MTNqVVNoRXNO?=
 =?utf-8?B?SktFUXhQc1BvV1dCdjNtd3BRTmxFYXBSTHVualgra09zSDNjak9yZlgvMXNN?=
 =?utf-8?B?MUVsTjZHN3RaWTBKQjZKeThTUndOa3ZuREdIY2dyVS9lYU9DbEx1WUdaOUdH?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7a7SKy3rAm9nSoF5CH75pQQhErI5YIuFUTuMqYOvpL5ub6UWGr6ML9pGnfkYUSluafhPl/jAylqWG2LXGptUseXVKrI9CHQAN8V9XxMNS4Dy+LT9N6lBGlcdcyGGQ9+iG31Ai/BXnnwPI2mNoieofzq2gL1KjLpWruWi3AgKJAJhUyqApIlZodZGnuSMCy/HJpTS0IprxKUodL+zJoTRsY4JzF6W2px3HNdpDyUb+8XirHcCmSXywIk/PZNLJ5FYr+1kFU7XBMAWA8g1ER1Z6k+dCLRFRhzdzHPXBJpn9/olGtKLjvalYg5t9/5b1c98EfGjHnNpDUWEl7ZMVw/IqVpbbx0Ik4MHWCYTxsuG8MCKRNBAs98UV36s1Oc1Nc+hwjU1CtXbdXDImZra7AkfuLZnIXpuBlzDSB7k33X9SkMv4WdWT+H1lqTggI87VJZyN9S2KkyvrEyfab3qTDq8K+AF3+e4BceRIL9mq9CvB+7C2/+IglbBGIjIyYviQ42PpS/MFP8lNaKU4hsgrmlPeZwVYsiWTpgwJOdKwiyxhxcgw/gW0/+ZY0CKB5VEM6MA6kpA+pwvOgw8kOyWXeyYs8TKS510CvCh/zxyhUezerpBSq5UD0BkBzlKhyD4ZixZ8lAqtXVM+TEIxLdgi26JdnoxBlIZBdmdF1dLa5eoBHyq+twF0nAkcM5SJDW21YPAKqRCAIjKMN5TmzAiBgyOaNCuLlXPqQtXEpKVmfUEH90jyZRV6PuPWdCjWKqOVdhWAO3IRJnuAey1a1BbMb8WIHgCAL2gf7FTxd6WI/n0/8Ns1SCiDaV6t2zCV9wj7IHDyKBl7JE55Dj/4TywxD8pqtwNUSuDsgJn5pmiD9X5MhSYfrDSJ8JxRGqLFO1/3rWTCHEJgMMNdqrlXymspkaZM08ZG2Xgo56mVM65KoAkQLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d1d0ae-0e0b-4ac2-c70e-08db8b9c179c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 16:44:33.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W4r2v9OpxXw3LBljUxj08W2BV9vyLRuB8LQKIUpaaIa15SLo11bU7a4UXpBdfqtJY8Fc7CHt/6Iwf3onrULgstkNQ8uDUF72c8Nof9LL2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230156
X-Proofpoint-ORIG-GUID: UEQKOalMEk8FfEeZDaLxi6R0t30lOE_i
X-Proofpoint-GUID: UEQKOalMEk8FfEeZDaLxi6R0t30lOE_i
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 2:45 AM, 杜敏杰 wrote:
> session might contain private part of the password, so better use
> kfree_sensitive() to free it.
> In iscsi_session_free() use kfree_sensitive() to free session->password,
> session->password_in, session->username, session->username_in.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/scsi/libiscsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index 0fda8905e..a307da898 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3132,10 +3132,10 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
>  	struct module *owner = cls_session->transport->owner;
>  
>  	iscsi_pool_free(&session->cmdpool);
> -	kfree(session->password);
> -	kfree(session->password_in);
> -	kfree(session->username);
> -	kfree(session->username_in);
> +	kfree_sensitive(session->password);
> +	kfree_sensitive(session->password_in);
> +	kfree_sensitive(session->username);
> +	kfree_sensitive(session->username_in);
>  	kfree(session->targetname);
>  	kfree(session->targetalias);
>  	kfree(session->initiatorname);

Reviewed-by: Mike Christie <michael.christie@oracle.com>
