Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC37ADD78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjIYQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIYQwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:52:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7DBE;
        Mon, 25 Sep 2023 09:52:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PECKlM022685;
        Mon, 25 Sep 2023 16:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gnTL/BZudjomjERxjS0IN0zVfTmbW4Q0zlyhINx56j8=;
 b=dOaMiO2w8plf0ZOBpsEnM5oXIvPVd06sAWUzceoBl3sC2cDoXF/t5/nz6wEPTbfoET3l
 XhYuJrBsu2dsKS1xaLpXOUh4gvIPxvXWIDzruzbwfIB7aTeTypcLEFlt1x4AmzPAL6SC
 CwFJGcw9M9zOmd609ez7RHk04O4kGytvTvBtY21CDLGLqMZf+Iz8eb15vxLHrDCjm2ks
 ZKKRLlLMloGFmimCu/uSTibvBZizFbtFKOXp3+4eLA2TwqIr+gPc3Dn4THQQJ6VQxvdX
 zGAve4LfjqrasDpQq29ju0qMhfIeyLECwH99wgVBRDmR16OOn+FEhA+KZ7gNF+FsL5gK 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dc841-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:52:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PGoZeG017935;
        Mon, 25 Sep 2023 16:52:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfate2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcd2WxKQzektXPL+Lhm7jabgpsCzQLjS1pMcoiq9QQl44fAtFiV1tuPIWKyjmv/VEhD76rfG2+to77R8oiKhW9hZyrkR3jO1Hxyimwcb05axUZSuS9XZsFDPmfdb2EnoGT7kesYnOsFI5sjgldIna9UP84oBqU6Oe/RcbcI4YKrOXOe57UTbFTJdTdqgiq6rDNAGS+2VXqsElMX2Nelxe9bG2d1YX6hY1oek2uWKIblDzG0D3IU+gJN9Mxr4A3YPaNjcLOVYKRfWRem52DTWibm9l+1sCKDc8udWXV9WYffldjnNtgNakuedwRPHGYM2Tzv5B8MIFjc+2YiAS8mwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnTL/BZudjomjERxjS0IN0zVfTmbW4Q0zlyhINx56j8=;
 b=mfDOlNuBcIfGxBxU8cr8wTdjEpgQ7WqJs1XYwAgIxtlq1bCKLXLNZ6xgdfD2QyESvn/7HV/ZuGzSXcp3oJdPMQGJwjXB01knxD6jMy+kRaSNvHLWKouJl12coZIXRRpNxrs8IlHRFIjtPx/aq5c7RnO5n/b7h+b7FfrHpMj8JPLT8BTgKD+SkDAXC7HZfDo4slr5Y47D4Vj3Km1ms/HBro4xZrzGBn3kHHivh/2ynNXulOCAZzgR82oJn1y0B1CMXFhfXRt1/hqMZYZwNfQP2xjdlTnPfd/6J+aYVC7MRCHZtOOLkRcePCPNMvoKsB98zi4DiLdBl5jyxhwGUOGjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnTL/BZudjomjERxjS0IN0zVfTmbW4Q0zlyhINx56j8=;
 b=mxcneh4Eysckctq6SIfcTsGngq/Bqm+GjW7GsAdvh1UInLfjAA8z1FZ8uYjoqI0ZfeU2DCzLbKI+0Tl70FUj18hVgDcciTyWKna8e52ZXQhRwWkgj0ZuV9IIlBmGXeLX1nTprK0tJftGHg7B9y32D5hTC2OiB6b4h2vFoZF0k74=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB4892.namprd10.prod.outlook.com (2603:10b6:610:dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 16:52:28 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 16:52:28 +0000
Message-ID: <8057d66f-4f0b-4f03-8401-51c85ac27f41@oracle.com>
Date:   Mon, 25 Sep 2023 11:52:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <bfc9e734-3a04-9600-58e7-91d7e7f53010@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <bfc9e734-3a04-9600-58e7-91d7e7f53010@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd8f367-6428-4798-51a6-08dbbde7cd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttw8MpNLk8PFf14ehIG8Jn+hcsTV3il5n4W0OwmAM5+arwKA4Z9WSImoZJGwwLZNSvyBFgmdVLWVUkaToTEh4KZj116TtlSqGPpU7a8fwkMB5aBJjEtIvdeBkzN7OnXnBqqv8HMKhxMEiywJLius8UznVu9K7HFfeyZpy3HDhOQ/15qN8YZoXFfHqs1/NEIA4jm/mg4wo2G0LgGH1YveGBnCr1xPaF2uEpztSCfn07ZQtSzGONy0wBcLMIRNX6oecWSK+bxjbS402rOGgN0kFDJGO5nwWuclSdNknhNliuyHtQggSBRn66tjlvyLMan2crDK2ZoXh/8BrE7lsVSj0O/8gNUrp20Wz1bE5M/TugU4W9QtzS1uRQFLPV4HjLxYNceNZiFgLeg0RthYUy5UO3TMqx2dYiNJSrePoeM7vMFxww1ltAUWhZlf0iqSDiBmwfbZHDvdyNTDrHMTZizCFqxZ/0qBI19HWTESXwFneIxKaI6QMWxxD9y0p2MlOZipjQeUtSQZ6syi5kV8gMYGrXIWuWxEgaSbjNZBLuYP7zwskeO8EMOldiHUr0urU22tQ4xxAC8qHuJrTF+ysaSvpgliyBjsdhjPRXi0Ay8OHBRSKpJR3UCKRqH3aIwnVI2LMKuXSS1hZC65HmTrZZ1Ouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(53546011)(6486002)(6506007)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(2906002)(110136005)(31686004)(8936002)(8676002)(4326008)(41300700001)(66556008)(316002)(66946007)(66476007)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ljME9vb1JTQjJqYkxxYklhWHcrZytIYzVidGg2N3V4NWtFc3MvVFIxTkY5?=
 =?utf-8?B?dFlNUGdoTmtzekwwcnAxM0NSQ0tyWGlTSFBablc0bE9RVzM3RTZhcnRiUFFB?=
 =?utf-8?B?RGl3SG0rNXpwRlZQWjJNSkNleElnUmtaTlIxc1pTblc4VWxFbjlYTmZTZHBV?=
 =?utf-8?B?QkFkOTZySWRieDVBOUIxZSswSS9EVVJuTTNBMktYK05mUzBoK3VJdUVYN3lG?=
 =?utf-8?B?aUdTVHhCenQzSVhCdlNJZmFKT3VzcTdGZmRaZWxvV0xCOUh5eGY0OGh5QTRx?=
 =?utf-8?B?UDdVYk5oVXhIN3QyczNHMlJqcVh1REl6NWhQdDZkQ2YwZ3lNaFNNMjl1a0hk?=
 =?utf-8?B?Z2hkdTJqOVV1OUhiTHh4MFFYWGRHaG1GenM5ZW9meTV6RmlzVkQ4YjhYeUFO?=
 =?utf-8?B?aWl3YXNFSDFUMjRJalBsazRNbFRnMzhsYVBUbmUveFNOZ090Ylo3ZGk4blpC?=
 =?utf-8?B?ZWZ1MDF3cTl4MnVGaDhxUnRhVTB0QXlGeXNZbVR3enNpRTlsZERRdUFwNUdH?=
 =?utf-8?B?MUVCbUttQjlNNXdKTDZzVWdTeHZWV1FHN1RPZjlXNmNnQlVoQzNza2FLYnJI?=
 =?utf-8?B?TTBham8wTTlDNFd0cEhOWThGRG5ZVGRJR0h3dTVaZ3dqN0gwUUgwSk5lYmdR?=
 =?utf-8?B?YUZsbjZ3SWlYZE15aHdxcmEydXQ4Zm9oWFFGaG8rWlUvNHhPOTdQR0dDS3pJ?=
 =?utf-8?B?UjQ1bitNRVpKN0MxeHBQNkRuQWM4SGFjOHhnenRtZ2VvY2hlTEIzTUdTcm5K?=
 =?utf-8?B?YjYwSVZlRENxWHZ1ZDZVNEdwTGhaaEdsOGkrL2pkelJtWmRua1hzeUNjYUFj?=
 =?utf-8?B?a2VaUWJzS01KWXhqR0FCYUpLb3dOUGdaZ1B6SHhSNVE2b3BQZ3Z2MXNXL3RK?=
 =?utf-8?B?N1AxQVc4T0J4enlWNEdWTXdhSlFpYWV5VnFJODgySW5tR2E0VnNyNlJLUTBa?=
 =?utf-8?B?NUNMVjdZbW9pcGRtS2o5OWtzK1RIQzI1MDRsVjN5dkdGTXRjeWRoY1FjTGlW?=
 =?utf-8?B?N1lXa2c2REF1NjlJTHBCM1c3akhhQS9IUElwWkI2eU1odFd2cC94SzVhVEZW?=
 =?utf-8?B?TXpta0F4Q2hoOWtURkZ3MFRBZ29yaUY1TjJCUFFWTmh5TGJ2ZFN1TGd2T0tX?=
 =?utf-8?B?eElJQjduVmUyUTVoakFGZWFDbW9IRVplMEFTaXRlMDdYY2NCdHVqajdzWmFp?=
 =?utf-8?B?RlhOUGV5UUVsaHlPY3BsajlTYXlTVHhnUm8yYXcycWpFUStTL3p3TjU0elZT?=
 =?utf-8?B?Zm5hTXpGYzBLZm4yMUZ4RU9ZYUhmYXRaandwQUFpYUdSUmRnL0kxNDdYZHEz?=
 =?utf-8?B?Nk5IbnpzcGNjZlFzbEJxdWJNMlZKOWF6YlZMUzVVb1MwNVhQd0c5THdjK3BH?=
 =?utf-8?B?R045eWV5WW4xYWI0Wll2UTdpQVp0cWE2bDhsSnBDN0RRT0U5cVI1WnFpT0Iz?=
 =?utf-8?B?UGJPbE5UVm5YOEtVdG9MUDJnbTU3VVpUdWdaTVVGK2ZGKzF1U1BuSkRuMExx?=
 =?utf-8?B?VHlxb2ZuaER3UzNwMmxmWi9UK3RzV3FuOWxaZXR0b0cyaUkyYThzL29HNk1a?=
 =?utf-8?B?VkRIc1JOVEtnMkxHeTNzU3pWYjcxVHJzWks3ZXRIQ2RtaVBFZlMzVVVZTXZI?=
 =?utf-8?B?Tmt5cGVrcU0yZXB6cHplVms4cWNOWSt3QlNmVWYxaFo0WTk0YlJCbXZmS3lj?=
 =?utf-8?B?VTRQdWNVaUhEaHc4V05OMkFOT1orSnJ2TkdFV0lrSWNWSGJjTTA0bUF2QXAv?=
 =?utf-8?B?dDBDNmhkS1hSNitEV0NJaWsyOVZvNmFwMXhwMlBMQlJ3SG15azhLZ0toK3BM?=
 =?utf-8?B?R0xiZVI5dzRKelF6NzNZdFJ2VGxFRGg4anMxQkpkN2VENnhOZmNsQ2luRWhV?=
 =?utf-8?B?UmVvR3dDdmRseER1dHhpYkx3aHN1WFlpYUVvemlKMVBsbjI0bVl1cWhpUFBK?=
 =?utf-8?B?S1AzY2FJdjFtNEJjSmJ1SUNaTkhydU5DZnVnUStWL1Y3cTlsSk4reEwrTTFW?=
 =?utf-8?B?dUN5VCswR01yVDZZK2x3eVdBbEdJOVpwcHhJWktwcGpCQTUwM1lBT3V3dXRV?=
 =?utf-8?B?ZitFY01jYUZvcUhvS0lFcmRzZmdNMUZOQXp2M1FyRnFDdFlHUkhabjY3WlZr?=
 =?utf-8?B?L1VNL281bUtCNFBoMGdXUllLaG9LMXZvazZPMmQyRXU3dzZjVm55eHZJRC8r?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RwWwllkfTfaGRo0EPKO4mZIYF9Wz/HY/EAQiKJVhUdApcSef+gJgZaj766nwZ2vhGPehQ5Zxv0ABN+KhZ1S5CuVnDpTtf78Ng6Om4LkaTchcedwh550G/TxHFgd9WZpLrwpPQ6tbglQM0MTG7+ljT5HWXuKhN87LJSKapYK47WfUsxADhrMCsaEQwosupt3WtaXdyQRARcKDfDyE9tSjMuldo/6khaoqiN+LWxrVr4OB0uNi4tO0srOhkhSQyHePrMbBsCoYf9ZpjtbRLsEMvoXqha1+T5KHE1JT5yNLM3495egdQgoDCxUhMZdtmY10bEDG7tyLFTXDIYAQ0X6J59v+a4w+jOFl2SUiGjvmJ4bsA4E+BgRbARlezpM1pKgx3ZNunFgnHCKjYduqNEjtkjhwOAIRNwdNJUxPPo0D/ghHIib1SonDps9FH/DaDRlG2xFvBqW0X2tu4C01Jqb+l4DPJrVROzt+/t0JDRgG8AGG86cMv+pc194UlkjpM/xuCzjVL0q1ENR/7bCZmJbm2xGzaIKF6lrYdnN5A3y5Tt0Ub12zLR8vvH7aNQ6RA0Rx0nxol+b8T1KhO1057n0lkgrZzhYn8Kbeg85WZ0EYrz9B0w9p17k6yHd54Vo1knd78NbiwMKx9ZJc5m3wbM94eGrfsy60N3If8QkMFCH5ZZrIqhZ8flQcmOBBbWzFwvLJ15BqHsJFT8ye4/3gyiez5hNt5+3AH6fCW7BPjh24S7g2ejdo/JdFgKvXPaQQL5qpj/pbeE6YRx7ZUVUIqXXgRcMW0sxwqLbiathc0YoOXL/Ait4EvXqaP7A/7Pbd9eFODHY544jLdLlI+t6pskFBzfG7jPhV4MVdEoQ9DWgJB64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd8f367-6428-4798-51a6-08dbbde7cd73
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:52:28.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhA0A4YXkqSAG6/DhoUzWNKdLgpkwnobzQvRAxuMFx43XzKOlpFActlxGtw01fq6v9bJPJbfi0LXPfb5nm2LuMvBv6nHYe8W++wBCNYLVRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_14,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250131
X-Proofpoint-GUID: XFb86B_xEamwqMVuz0CktdhP1o6fEwBs
X-Proofpoint-ORIG-GUID: XFb86B_xEamwqMVuz0CktdhP1o6fEwBs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 1:20 AM, Wenchao Hao wrote:
> On 2023/9/1 17:41, Wenchao Hao wrote:
>> It's unbearable for systems with large scale scsi devices share HBAs to
>> block all devices' IOs when handle error commands, we need a new error
>> handle mechanism to address this issue.
>>
>> I consulted about this issue a year ago, the discuss link can be found in
>> refenence. Hannes replied about why we have to block the SCSI host
>> then perform error recovery kindly. I think it's unnecessary to block
>> SCSI host for all drivers and can try a small level recovery(LUN based for
>> example) first to avoid block the SCSI host.
>>
>> The new error handle mechanism introduced in this patchset has been
>> developed and tested with out self developed hardware since one year
>> ago, now we want this mechanism can be used by more drivers.
>>
>> Drivers can decide if using the new error handle mechanism and how to
>> handle error commands when scsi_device are scanned,the new mechanism
>> makes SCSI error handle more flexible.
>>
>> SCSI error recovery strategy after blocking host's IO is mainly
>> following steps:
>>
>> - LUN reset
>> - Target reset
>> - Bus reset
>> - Host reset
>>
> 
> Mike gave some suggestions and I found a bug in fallback logic, I would
> address these and resend in next few days.

Please wait to resend. I'm still reviewing the patches. When I commented
last time I just did a quick look over to get an idea for the design and
what your goals were.
