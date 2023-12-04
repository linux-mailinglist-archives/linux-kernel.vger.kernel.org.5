Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43087803449
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjLDNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:18:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE2C4;
        Mon,  4 Dec 2023 05:18:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4D0a2H021959;
        Mon, 4 Dec 2023 13:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I8pZdjDG/woisVrjwzCOYWsJKwmY5BcfQZieDQejZFE=;
 b=WVjxZxeRuZRLHBRE41QJ1/BoH9CiMPei8EDruF1dKIpe3x2CA+P6+TyU2B1Shy0Ukc5P
 zQ/KaUysmFXVCq/6eoEJ925vM0l/j49hfUYoG2X50cc6d7XCwQUu+0I4UOmIbzWu2fUO
 QxRqTLk0DVbB3rs3KEMx3obqVAkgb9xlkj1onLJVZkB6OIz6Dzusy/fWC9gsTX3QxZ3C
 8Is80uwKyvCtE6puyCSAMx5oSWAvj/KpAmguxbWgKBMWltUqntfxy08JZ7GemoL46YF2
 LlO+Xp+O9EqdBS30n9IldqQ49OYQ7gb4n4YwNufF4KurXGCPK1BtcCJ17aSRVerB0KXD rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usf95g222-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:17:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BqJNn014400;
        Mon, 4 Dec 2023 13:17:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15r8x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM3gavSo0rcE452VGgFksDh/o6YWWXuSHWKMgXLeNoeg8KPNP2HeTKvmNcVrZuOlWKEG/44o5KzzP3LeXvlWLbp7vbPuwc4O0vaeG4NXx7IpqRSulswN7BD3nKmHxbMGeKQq+dlShAbF8PVyvxKHSmEVKsSvRBTrNJfxrbT6eC0cLEyrQgQmKTSiIuYYZ0WGDIVFcXXbsYcmkAJ04vQA/OjMJgGqmaQxaEEz6AqPeGFW5/JoWrWm87JHxkkFkq3XSprmYXjYH1Vt5mHWZ2O+d3j+ezVV0tvqFak1hAYefgWVZHQYVU3ppY3E51JubmM2YBRXbu6Vpxjh7IIE2xdW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8pZdjDG/woisVrjwzCOYWsJKwmY5BcfQZieDQejZFE=;
 b=KVK3rn6rYYwsIdb5HkUyfKgiytCDDTvuXVyfInKPvAnxwvS2UOiyqCP1Y3kAxySYHFo7yn18H8lpHxVsZUNqHL2g30KfkKfpWpDL/gOXokIbYKzid9tHMdw8KZLi/tN2IoQFo2lulMflC03zmzyJPfYbClaghH2+XWrYxKKCh/L/2B1XMSsguCqvfsDLhcyfiXpHqig0S8Vqx9B26w3reZZj5TkwX/PpR6j6vGbYT1YZTtZDkFherpT4UDD06+fPmizWnYmBo/Sw6Zpwpc38q23vjfTpLGvcXLJINEZwUg/RQ2c0YokbjzgsjHxnGYciHwWSZV4ht2HbPO+5Y/isqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8pZdjDG/woisVrjwzCOYWsJKwmY5BcfQZieDQejZFE=;
 b=FJEEr9FK/9Mg4uSEjew17x9Di8H3pkxAyJx7aT1d60NirWwS+jEzh7RaB3w4fQ42U/ptocTlJqtDxMLSO1VA/a01BQa9mf/yfc2j+b7oTIjtShhKSeP6xXfEj1iv+/oRUwhbUfJ8NLswo4COQMfI0nSQRTJx1SBvFVkilOG9YSI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Mon, 4 Dec
 2023 13:17:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 13:17:54 +0000
Message-ID: <549277c9-d3c8-41ae-afe1-c6860295ec26@oracle.com>
Date:   Mon, 4 Dec 2023 13:17:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] scsi: libsas: Move sas_add_parent_port() to
 sas_expander.c
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20231204122932.55741-1-yangxingui@huawei.com>
 <20231204122932.55741-3-yangxingui@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204122932.55741-3-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3352029f-a536-47ff-3ace-08dbf4cb6ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYfaKRr1e5ban6aJQSBtbP30gSFqNUDpzqULuayUdLQE0ZtSgdeb04j04PKAsfEvFtSvL/RCAGeMPn0dTyJimcGYMSxBQkNM/MRWv8AzoJc4iu9HyW33Or6ON446Rq8nXR/nMoVOl9jy+Cilf1QNP4eRro6nAp/qVfS2zX5xHp3A8tWpvaC1tDSNYayWMaW7qx057rbb4vwh/O7IpmnGL/uSBxn8m+WHHpPbNjGN+RWJZhTdt2++Jn11Z6BUgGLXVnAguCSxYCv1e86hVxfUEfHQhILagxdEK4h4Fo69Rqt/JaB1oISnPr2JEFQ7xSUdn4W3PZLFYBw95as9QkwRcpESpsCHBs4HQlUO/rXnZd7sGQXPLbRNsV3rMZhO3e5Qt7tw7hwvctpfcEVHPsZx+y4TdgdqepH8v/Sit/ktkmOH2QDI0ZsODX/pUUQ0/NF7RiU/eCZQwygWXowpU6FNPrGPslVc9hY+EYB/AwAnpVTQyNHZwaF2gl/QobHT7FpObeSPpuSaiWuCGE2OY9GrqccndmqD+E/crxavr7AOSrB+4/89nSLVb6UZwx5ypvVhDm5TRnP1nDx5IrwxND29CCFxFbB3czGCzchCgpf+2eopaBVR7ohFd0k+bU8ZqIi+7j7vHRN4q7IsCj3r73LVNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(31696002)(38100700002)(36756003)(478600001)(316002)(66556008)(2616005)(66476007)(26005)(66946007)(41300700001)(6506007)(36916002)(2906002)(6512007)(53546011)(5660300002)(7416002)(6486002)(4326008)(8676002)(8936002)(31686004)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk5YTTRtMG5ZRWVEYVgyU2hPUkJrZEVzN1o3ek5yRVRVWmNzTGRQRDNYZStw?=
 =?utf-8?B?RGJneHhGb2s2SENySnB5dWJVS2NXTFJSMGd1K1RVc3ZLbzUxUGVReGkweTVL?=
 =?utf-8?B?MW16OEdhUWlROWVwUmdFMk5uYlhIUXovdFRVU3lwaXV1Y0pucHY3cC9Vbkpm?=
 =?utf-8?B?Z3I2bkJheVdWYy84M2lXUzlVc05ObmdSUUhhVHlRdFBiZzZDS1cyRkRCczc3?=
 =?utf-8?B?b0k5OU1YZTJ1MFN6azZlMkkrSkNobVBwVEt3MXRFM2pPaWNodExUbGxGbVJO?=
 =?utf-8?B?YWVlR0xERWlCM3BQWEliem9hbS9SSVQvZHUwMDBuQmo4ZGZJNmN3YWhnOWxV?=
 =?utf-8?B?YXFobitPM2puQzVOVjFsc29MT09yN3JxelFZRXFYVnhTOVRDdHBvc1F2cGpN?=
 =?utf-8?B?cjdkSkZuNElHbnl2TXRISmV0SVUzVlpHTEZ1ZE5Qb1RvRVpreDlvTGoxRStU?=
 =?utf-8?B?NlpXbFlLZVBXN21WTnBRSnFmdnVIVXRVUnR0d2Q5L3Y1VUpWWUI4R2ovZmlw?=
 =?utf-8?B?VlBmSVJXekFFR1JIanZTeStaSXl3c2czTWZTeUFLMmUrVStmYUFzcllmQ2Iw?=
 =?utf-8?B?NHN3QkthWFQzSS9GYjlYdmtsL0Y2TVYrNU5hblhLUDFGby9qUlNOUUpmSDV1?=
 =?utf-8?B?ckF3eXE3bER1NkNmUnBTRWdqSC9KZm9HL0ZoNnVtSndoTFhMRHRXU2ZIaDdX?=
 =?utf-8?B?V2RNaG5NdVVTK3B0dHFINzR1blVhbFhNTEJmMFJrbmw1d2FSbDRxUGdlUWpC?=
 =?utf-8?B?MG9uYU9JaElMSnRSWXc1RWJMT0F3Ym5FMFE5STdHS3BPdWZZRXl4WDh6M05O?=
 =?utf-8?B?V0FVM0N1UXNiZXhNdUJ6K3NzSFlWd2JzMng0OTdrUFFsdDk0SjhuVUdOeHJm?=
 =?utf-8?B?dXpGL001a2ZVMEZYc2VIT2JJMmY5blAzRzZhWVllTFhEK0kwZkZYL09vbWtT?=
 =?utf-8?B?OXRrTVMwR2xZbnJkK3NCUzkySnNtcW91eUFKYlN6aHFpL3poNTBHellnVHA3?=
 =?utf-8?B?UGhaUzBES0tJVk5GdFhELzh5OGVNZ1plVkY3TGNSdjdUa2QzdEZUK0VSQlYw?=
 =?utf-8?B?WURabmRCUWU5dmI1ZUV6SEZoZTVzZEZOZHV3MVkwczlqSGdGZ3c5cUdLeVZG?=
 =?utf-8?B?THVYN29leWdPWFllVWY1eTNjbzBoanIvWDk5SUFHbG5FVW0xS3k5NnQ4d0dK?=
 =?utf-8?B?RUFKelExUkRhUDZWTHllQ21Ib1FhQWlwNjk1VW5tbXlwdm4rOGdKWTJpbjlG?=
 =?utf-8?B?UUNwWXVBTG9CM2gyRnNEWmdRcWRDVURtcmRKUXRVeVptRkR1blA4UjN3UG5w?=
 =?utf-8?B?cnpWTVp4bzNlQ1Z3ZnhJbDRNWDl4ajFhWDlFOVVZYUgwbGwwaGJVRU5BVUlq?=
 =?utf-8?B?SG1MT1QzOHhHVElkSlcybklYT2FKamgrQlM3L2w4MnVhL0FoT2hCZzIyaFdn?=
 =?utf-8?B?Q2c5NGdvam1Wd25jMitjNWxmVmZqSnJPNmVCcTl2dHBqUnJIWUVtcnJ6Qm5m?=
 =?utf-8?B?MFdLUGZCSWN4b0R0bGZGb0lFZXpldWVnT1ZmRzJ2UHh6Y2E4WTl3UUptZHVv?=
 =?utf-8?B?d2JrdGlpWkNoNVBXalBwUmZBcXZGRVhJWHFESGhQWG9ZaVBBZURsYWt3M0Nw?=
 =?utf-8?B?OG51cmo2c2M4QVdkU29FczgrZXByVzZlMEw1VTI4b0JhN28zRWhjOFNScUN2?=
 =?utf-8?B?SWdsQkdTWDRCMDZ1ZUE0N2luVEdoVzk5UDBnMVU3enFrUzNhNVh1Z1c4bU4x?=
 =?utf-8?B?Ri9hNGFlQjRyNTlqTWR6RW9FdG1zM0Y5ZDhvVzNSUXhjSTZnbVV2TlNNQ212?=
 =?utf-8?B?YVlxMmRPdWFvTFBqVUNhZmtLWFRzSThaZDZzY1NDQm1KYytxVGwxay90dEZT?=
 =?utf-8?B?dE1UM21HZSsxV1hsMC9SbjN3VlpOYk5sYThxbklKc0FMMzk5S291OFNYaWVD?=
 =?utf-8?B?WEZ0ZTMzYTZxWlNDU3I3eGdzOTNPTnFtdGU0QVpPbDE0SGg5MlpXYTRzYTdr?=
 =?utf-8?B?WmsvdFY3L1lpa3Y1V3pBOTMxdmUwcUk3RHBZS0luQndKTlNkQVZZRUkrN0dI?=
 =?utf-8?B?VzI1T3owRUJQcTZlRWRYYi9ZQnJ1OW9vcHlEVWFqZEkzWHlhS0s3ZC91NkZo?=
 =?utf-8?Q?CdoOAChp6ADLUxHC3X9PUFgc3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LhsTiih+Dyhs9lKS8Ia1MSov0ndaDBv0HfLpBcGeHQg8KfcDP4h0LtPta7qwv7oA9+G5q7teF+79RyTRseyQ/o7TAms1s9+A1qAYLA8Y+xpK7LWsyeypYYg7bwu4HqcfrHkwS0Y4o+sWvBLjTydALbep2tsBUrGvj8EaPxLuiBmFdtKzVPkct/3Lt/KaA8tlg+jlCznkCxwGALCNP069p6Ckb5nxNzy3nm7fOfwlN/9sF69T+e9lCpdB7mETPlyiMXsZyPXv1q/fumJLdkZWcKACO1t7dbnAV/qsghDbNCIG2n8/5LGuif8ibqdZT4drv4tSRr/VIxHoCZ4nPG8t2PqWWdUdKOuRiw6Dsz8ZLE2n4Vmu2pYmLRxaVEycix/v1SC8+qXFWnyaeaaaXm2KmSKqSaySZqa75i7NWNcC7p3sER78cZ+lVB8G4uIoNyqnxqPK3pt7EIg/MVQOey7X2lBlFJ7tcFzL4u+m/x0OmAoOJP/XnkSr0N+rnL400NBoyLJN9l/qVEu5SXXv8Oxs2wiNGx0+IKzc+9gBIaJBA1OLcbFlGOvkqWQpUvfKKNNMGsvRceYzsY0UtNwBm3kADmiINAepNyowpXEBUFQ+TqpROv0MAk+sOMEcNTyIQ/1rZHslJ21U2vOWajW/YvUNuINLdKlxyMYLm663X+y4iZk2Lxv/gSiZNH5EhIMXs5tTxAoTukSYZt/oOcb95TR833Ik6+BPBxSfv6bL84NM7nX6T5hHslpNL/Mla1fR4SNosix11Py9jVAk+dmIx2IbcIX3opdqvFzJMLD+XgKwzlK77NC+/iB9Bvv8uuo5z6WwfmxQ28HSxXtoCcskntjYk7whBHckIDwT0qAHqBpo2adx2PGlB7ddlmWxuGuQgLBav0wYss1cAKumP1MREsWJ392JOQLRthYvyi/ri6cUhg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3352029f-a536-47ff-3ace-08dbf4cb6ceb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:17:54.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgKhsx4aPgOG5hPuJGynPSiqsvuLe3ojE+s3WBPSKoh4LHh9ic4PT9MO6j9YO0VRHd2z2nTnJVjm6FKddJb15w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_11,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040099
X-Proofpoint-GUID: rB2_YzImKDoXQekXT4AN7_tPcJMaXSCE
X-Proofpoint-ORIG-GUID: rB2_YzImKDoXQekXT4AN7_tPcJMaXSCE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 12:29, Xingui Yang wrote:
> Move sas_add_parent_port() to sas_expander.c since it is only used in this
> file.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Ignoring some comments, below:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/scsi/libsas/sas_expander.c | 15 +++++++++++++++
>   drivers/scsi/libsas/sas_internal.h | 15 ---------------
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 1257f90130fb..7aa968b85e1e 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -33,6 +33,21 @@ static void sas_port_add_ex_phy(struct sas_port *port, struct ex_phy *ex_phy)
>   	ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
>   }
>   
> +static void sas_add_parent_port(struct domain_device *dev, int phy_id)

Can we have "_ex" in the name, like sas_ex_add_parent_port()

> +{
> +	struct expander_device *ex = &dev->ex_dev;
> +	struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
> +
> +	if (!ex->parent_port) {
> +		ex->parent_port = sas_port_alloc(&dev->rphy->dev, phy_id);
> +		/* FIXME: error handling */
> +		BUG_ON(!ex->parent_port);
> +		BUG_ON(sas_port_add(ex->parent_port));

how about fixing these at some stage?

> +		sas_port_mark_backlink(ex->parent_port);
> +	}
> +	sas_port_add_phy(ex->parent_port, ex_phy->phy);
> +}
> +
>   /* ---------- SMP task management ---------- */
>   
>   /* Give it some long enough timeout. In seconds. */
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 3804aef165ad..85948963fb97 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -189,21 +189,6 @@ static inline void sas_phy_set_target(struct asd_sas_phy *p, struct domain_devic
>   	}
>   }
>   
> -static inline void sas_add_parent_port(struct domain_device *dev, int phy_id)
> -{
> -	struct expander_device *ex = &dev->ex_dev;
> -	struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
> -
> -	if (!ex->parent_port) {
> -		ex->parent_port = sas_port_alloc(&dev->rphy->dev, phy_id);
> -		/* FIXME: error handling */
> -		BUG_ON(!ex->parent_port);
> -		BUG_ON(sas_port_add(ex->parent_port));
> -		sas_port_mark_backlink(ex->parent_port);
> -	}
> -	sas_port_add_phy(ex->parent_port, ex_phy->phy);
> -}
> -
>   static inline struct domain_device *sas_alloc_device(void)
>   {
>   	struct domain_device *dev = kzalloc(sizeof(*dev), GFP_KERNEL);

