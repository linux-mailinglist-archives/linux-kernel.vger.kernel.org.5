Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18017CD37C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJRFVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJRFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:21:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66716BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:21:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJwjAP002796;
        Wed, 18 Oct 2023 05:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=b/7sJpQmtQYDDKsV1GiQtHFVf2Szv3G9BvmT4/v+ro1Zqe5fLk1BSogfmzxaQexwFVS0
 Aoh1BdCm6FPUzk7y4N92ZDCnQwpsVjH5Gj02f3CLprQ+2runpi6sfq7NsrOGOJ/qRSCI
 tMZuPA5adzhjZH99YFOxZMzS5s32l/DrDMV6IrmbfoWA92Oz1NTxR5tCxHvH8u3K0iGr
 mPRpptaCgm+DSaGLxHkld0NkrXVPAa9+gb+UbwzKDH+Cc6/XAnQsPHd+oe/MH+jFsxf3
 Aq8XYkymYkGtq2oVeRELiyHPOcQnjqCZfjDBBAljDU9aRl/Zu6A5w6YCZct27alfRmKU 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cesj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 05:21:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I4wwNd009668;
        Wed, 18 Oct 2023 05:21:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0nrg8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 05:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gamCIqz3TYdV5Uvt2qjghjYdFZErIubV8If9523ESncefv4whUM1rzfp4BN7Yu4MjYOss0A73bzTJPkz2/XfnTKQfx6sTWm5kxfrQiOk+C9NsfEGgDCFdYOozyseRPlZqL+HVnUUDz7gIl3Mp1JbkZJZzVsV+rOG9yPA6WPT36GqZZhMzmbdiHiDpQECIXC3/OTQdWYsrBQO4iQSXbj0CU7fPy8ka5x6aVUAfpzfpvg0Jt7OePT7CmW/2kJt6myuN+uzrKaxdU89IaxaSq9mFJaqkvXarZChjZnitqsoE8bo3+hFh9LuUwmcZDerDjrJlMC1PQLRWSIojWS8Inwn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=EGTrYX5Fmn/oLxHSqb2S3Wx4blQYfD6W3351eU9dq8fDmL/hCimX0hV90avEpJGHkPy6Fzcb4vs7k8d9edTGTay/MSjqun94dk+ptiHJeV2k1pMI9wb8HgVhYsdnKO8W1An4wiBYOWnOQ22id+8Xf56e4mEfbxYnjep/w8AIm1AfkbqCH8zwAl2OavMgxyTjO4bZKs77DZPvr2gRRoviCUpAMgTgcqQmf0aAoqk2jJnVL52Cq4F1Yi3y429KhxMT3nompZ43QoAJcRbHphhVFieuYXw5uBjOEbpe9JLtvl/ovVvVM/1fJnIB2EicoAg+716UXABVwRjfBk3qdxiJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=yuVd8k5RqhdMK2wvSBiRjdxC4GHiTdsQAIdEgIirC86CrJoOq5zV6AMq59qdv++/VvrmKlM8XQUdZj/gAlEBKA7E0X3P2nz6HZzZVHqxdNW2ImxMB7B+qLfa8zkZ4u2PalyLUa7pR8R7WrHlzOaSeUGTz2GNdne1rtt1w8LvXsE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 05:21:41 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 05:21:40 +0000
Message-ID: <7b86e89a-9eac-4711-840d-c677cc892cba@oracle.com>
Date:   Tue, 17 Oct 2023 22:21:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
 <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
 <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
 <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9056179c-fb92-4f82-c887-08dbcf9a1b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFyZLg99qJcS0Y9L9Inyy41g/uVv3U2l+i7ZF6e2LTtj3JMmK5xQR/Tnrf25MI2yfUw2O0Bem3yfwT+VwXQQ8HQTXGKQyeKciA8Q2Azhk/n2YuSr9V7f7aSdyhnLiya0jg1yMOu5N88VoJec0A7ec/sJ49t5D/UNoPlOQTh0YJW6Qh+mm9CrnpHCx6A3SwJpInt0LFJtzLnRcBLyrzrX1VsqURkoUxSwLYmbv/ormlYBab22sIlx4XEBuTzHRTZFmE2hBcppX2xRZqEVrJ+iVKIg4veS907v5NouXQjVQ4kG3hUBhn2h1kZOgdwZG84EiIR4ryZxiBJIGYiITcxy62iSGFz3VvMkr3UKmYi5sxJp/vh2bfjKqVtG8CRUei3f2LHxTequaFkpZLghj6ijqYuU2AWZgygnAelBxdVaXXuD53kyDkOpMsUI4IxKGDp9DQagDkqzyHLp13uOD7W5ozMPnuho2lexb9rgD0V5evY0VpRom8Lic1duF27mUjknh1H580MiZ2FZyp5e/h3jcZUKs64J47AtcvI9a0p8CW3lRHi0/0XSdrKJpUbe5im6j6H4icwWk4RVRrVp4+YAYaFQa/jTzHWYO9DIJyy3Ud+MVG6knbcGEQhLZsxUk1kyXnSSf9jwz0p253OQgg07S8jpEKvoRY+DKqTcR0AY8yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(6486002)(966005)(66556008)(66476007)(6916009)(66946007)(38100700002)(26005)(83380400001)(31696002)(86362001)(36756003)(478600001)(53546011)(36916002)(2616005)(6512007)(6506007)(31686004)(2906002)(6666004)(41300700001)(5660300002)(8936002)(4326008)(8676002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xmN0VUcmdFbmZwWHFTY0kwQWZhRXJrcG5KWU5yaFVpNmYwRDZrUFZOQWIw?=
 =?utf-8?B?Yk5nYk13QXlWUU1uRkUyNVRRWmVWeXlBTzJhaUxvUGdhTnpFcEZhSnh5cWJR?=
 =?utf-8?B?QmJsM25nb2ZXUFh0dllCNjBLQW1JQkxjM3Arek1ZRUZua2lYTGwxVDR2R3E2?=
 =?utf-8?B?S3psUjJXN3hBakk4bXZ3eEluZWtuVklqcHFFdjRjT0RoMFNXcGl4UjhiSTh3?=
 =?utf-8?B?alJTd2NlbHFKSE5PN3E0VTVqSkVhR2FPTEhsdTF0aHd3cHRFTWpTZDZ6U3Zl?=
 =?utf-8?B?ZmNaRDVOY2ZrN09tUmQ1Q1pLZStXZUJGem1FbVBUUWxwbjMwcVJUYStKY0Rx?=
 =?utf-8?B?M0o2WGZvaEEwMDVkRWZJYzhQUjNoeUl0ZjhGWG1YVVB5emNxeUYyWkNRREZi?=
 =?utf-8?B?by9jeCtjaW1iMEFqWm9EUWdYbmJ1dStIeWZyREtNMk5ySWQwN0NiZ0RDVGNT?=
 =?utf-8?B?akVobHlkQndrN2pPVTRYanNFOHoyeXZnRWhjOHRqTDY3Mm5keWw2TWxnditS?=
 =?utf-8?B?OVNXTktldnZORHQ3Yi81elN5eUl0em1OaUp3cXY2UnVxbmNoMVJ3emRtdkE4?=
 =?utf-8?B?WGRKR3gxWFkwWDEwM0V1cTJxYXovUm1rY1VoQ3poWkhkalFaVGZMSjd3dTFV?=
 =?utf-8?B?VE43VGNodWU0elVWUUdaRWRucmZPdXBvcmxjaVFja3hLZHhGNFZNeUlhTVZn?=
 =?utf-8?B?UXVRWVN6ZjE4ZHA5UDExdHF0aUhjbUFhd1kxdG9sNndDbTFWUXE4cGpEYSt1?=
 =?utf-8?B?MktiUVgvbElnRHZ6dTVLRkR4WW5jN20reGNKTFM0N1NuWkNtdkNaSmNLWTBS?=
 =?utf-8?B?S2tPQmViNWhPSVg1bTVRNjhuY1FIKzhwUytieDU5TEJ6R3BGR0NPQnN3VWk0?=
 =?utf-8?B?MWphYTRDaVc0MlhrQ1F0QUgxV1pxM2hnNmVaNkY2d0VwUmRTL2lQVEpmeXFp?=
 =?utf-8?B?UUtaZWdiWVhQVzJ6dWkxS1d3QkRvTSt5RkN1ZWdrQjl3bWZRT3FlQ2VHZ09N?=
 =?utf-8?B?YVA3RnNINWpWbWd1REhEdGFVRURUNFNjVUZpOVVRbi9IR21QK2pOdFpMRmE0?=
 =?utf-8?B?NHpFdEZSVGlIRVdLeHpqOXNJM1U2aDZWK3NwTUhWRTJWVDVBNmdxZlJ1eHZm?=
 =?utf-8?B?RTFQOUg2NHNKZUx5TCtMSEZsSUw4NXVyWjNmWGZLTWI4ZE9BalFDRUlRZGNa?=
 =?utf-8?B?c0FFUmttSEhaMFY2MkJoTEFqQjdFVitCZzJpZ2VNbXBjQUlvVFg3eUlRcXk0?=
 =?utf-8?B?dFg1eUN0VmZRWG81T1JEK3p4MTZQaVBJOXBQbnNaUmdlQmJhTXBNc3BuVGl5?=
 =?utf-8?B?Y1ZrQnV4SEQ0d0ZwZzFTMEFZK2dBN0toWS9RcWN0WlNodFdnL0RCQVdoc083?=
 =?utf-8?B?UnhNYUZQd1Z1eXlUa0NvejZDdmlvaTdvOU1XNHkzYnRtbzZNZVdUcHFIODZL?=
 =?utf-8?B?RWVxVW0rNHpqSzhwcHJROEtWUnJxZVpISGpIUGtwUForY24ra09QelhUbFFo?=
 =?utf-8?B?VzBnRVI1eEREdVFxY1FoZjh2SHFBbXdtbWxGY1poUVlRMklKL21zb2pLQ3Iy?=
 =?utf-8?B?K1pGUmxtNjdhT21nZTk2RnIzSkFHN25nNlFhK0p5LzJaTjRBRk95dk5GM2Ux?=
 =?utf-8?B?ZG1PTFpRTTU0eGRHYWJpWEJTMnAwTWNBUjh6QkM2SDJUZ3E3OE5BTktySU85?=
 =?utf-8?B?aFZzTTdWWTdVV0R4V1RkMWZyUkRLZWNXMVFLcndMV3I1RUgvcG1xSjJSZG5C?=
 =?utf-8?B?OXBBdUZwWXUxR0UyRkQ3d1o3TVVHVk82M3hVaUZJL2F2OVFFTjdNc2ZMWjFw?=
 =?utf-8?B?aEZDT1YrL0hXUkpQM3FoS3BkN0oydWgvODJSMmRFZms0cmFKQXhZNzk2dVNO?=
 =?utf-8?B?ZXVPQkkzVHU3QUE2SWVBd1NpQU1HQTh0S3BMZ011K1htcFJaSkd0UWpZU0h3?=
 =?utf-8?B?Sm4xamVTcXFacGxXcU9wTUdnN1V1MFhoV2E2VHpCTEtQK2FuSnNBMnJ3RS9k?=
 =?utf-8?B?d0hBUkdWRWJoa3BndFp6SDVNY3VJVi91a2Fha0hLanJrYVhKa3VWSTBaeXZO?=
 =?utf-8?B?SzJSSkVHVEU3bWRZS2dYTDZVMitEdTRKUG1iaFc0d2M0L2pyYXpaQmczVXlB?=
 =?utf-8?Q?0aQSeZGyd1Qnzz00WaphDXbLC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7DlQBHPChiw1YR4bReo1v1KGMh7bLrZ766NeM8jTFIhoNCwx4O599nVNuWTCWu9JTrccE9FewYx9xjgOhj8mr8JiX6WkKkAhaz8pYXMnqTofSjuvmaNkmh/qtaC12Epz0g09nBadORzBWJh476/DW5LusrkwxIBJgSsldSleNONrC/ZEuXgcB6i/36JcvgTUaCoJkCI1xvGz7BXGZCEcfvEnxjwzWAJfxmliTPLyARkpV1NHFTYKvIcmSURYqVAa4RvVMj1I5QmAubhsD0sBpakdLdH4uNI/h8nCyCwIVx1ZDy8hKvWDkJQrg+41N00zGrSFg168gsERzLpR4VHFH1RtDDY1aaqD8+30a23iPfpMVvXFYgB+mMpkHJIqLfrAFfo9nEZqZSQFRE/lWP/yIng8B5qSARBxrA7E1GQUXj8wf5u9e1nvLfIIo4rxOuvFpwNP9iR05NJYBJoPf9TJcxa0n8pIBBRv5Ymc5iNvSPzC54NCcMJTxfsQH1nr3Mic/BjNuPldKa3hjVS1MiePovvpQDXqILUGkZO2TzNXH3wrlJVgnpG6n7OgNyY/olMRba9VkpJ95AZ68+EcjWGYBYnxKOKZi2kS52JC/gLof5VGOQ5pS5BGP4N7VcBasUMJgQX2uJB37zSzKpIw2g7hib30/Aomq6Xq/XwBL9mSpzVydUgE/G57iNX49qO36M9K4vC98rTcaitR1wo14dibiRe2fLO8yljddgHGnEtSgVFCfdUAe+wCcIkAuZKZI+HSP70m+1jLG5aY2abD7W6Jl4YC7Qv6kTCtXfzkU0kqygb9MV1DEkZS16emewa7mAJEQi7r9CxowBWdhlfvA5gaLwn2swKu7053KHI2H7bOuXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9056179c-fb92-4f82-c887-08dbcf9a1b43
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 05:21:39.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoPh0KUApzHUWNU3/tPAw0LiF4vhDa6xTriMTVUAd3dlBCk+3vbdgC3jm3LlA/EdzRKey7q3c0pQ/cPJ6ivEdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180045
X-Proofpoint-ORIG-GUID: y3YemqkcoXtSqr7WaYQZQA82JJvHO7z9
X-Proofpoint-GUID: y3YemqkcoXtSqr7WaYQZQA82JJvHO7z9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano,

On 10/17/2023 6:44 AM, Stefano Garzarella wrote:
> On Fri, Oct 13, 2023 at 10:29:26AM -0700, Si-Wei Liu wrote:
>> Hi Stefano,
>>
>> On 10/13/2023 2:22 AM, Stefano Garzarella wrote:
>>> Hi Si-Wei,
>>>
>>> On Fri, Oct 13, 2023 at 01:23:40AM -0700, Si-Wei Liu wrote:
>>>> RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>>
>>> I can test it, but what I should stress?
>> Great, thank you! As you see, my patch moved vhost_iotlb_reset out of 
>> vdpasim_reset for the sake of decoupling mapping from vdpa device 
>> reset. For hardware devices this decoupling makes sense as platform 
>> IOMMU already did it. But I'm not sure if there's something in the 
>> software device (esp. with vdpa-blk and the userspace library stack) 
>> that may have to rely on the current .reset behavior that clears the 
>> vhost_iotlb. So perhaps you can try to exercise every possible case 
>> involving blk device reset, and see if anything (related to mapping) 
>> breaks?
>
> I just tried these steps without using a VM and the host kernel hangs
> after adding the device:
>
> [root@f38-vm-build ~]# modprobe virtio-vdpa
> [root@f38-vm-build ~]# modprobe vdpa-sim-blk
> [root@f38-vm-build ~]# vdpa dev add mgmtdev vdpasim_blk name blk0
> [   35.284575][  T563] virtio_blk virtio6: 1/0/0 default/read/poll queues
> [   35.286372][  T563] virtio_blk virtio6: [vdb] 262144 512-byte 
> logical blocks (134 MB/128 MiB)
> [   35.295271][  T564] vringh:
>
> Reverting this patch (so building "vdpa/mlx5: implement .reset_map 
> driver op") worked here.
I'm sorry, the previous RFC patch was incomplete - please see the v2 I 
just posted. Tested both use_va and !use_va on vdpa-sim-blk, and raw 
disk copy to the vdpa block simulator using dd seems fine. Just let me 
know how it goes on your side this time.

Thanks,
-Siwei

>
>>
>>>
>>>> Works fine with vdpa-sim-net which uses physical address to map.
>>>
>>> Can you share your tests? so I'll try to do the same with blk.
>> Basically everything involving virtio device reset in the guest, 
>> e.g.  reboot the VM, remove/unbind then reprobe/bind the virtio-net 
>> module/driver, then see if device I/O (which needs mapping properly) 
>> is still flowing as expected. And then everything else that could 
>> trigger QEMU's vhost_dev_start/stop paths ending up as passive 
>> vhos-vdpa backend reset, for e.g. link status change, 
>> suspend/hibernate, SVQ switch and live migration. I am not sure if 
>> vdpa-blk supports live migration through SVQ or not, if not you don't 
>> need to worry about.
>>
>>>
>>>>
>>>> This patch is based on top of [1].
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>>
>>> The series does not apply well on master or vhost tree.
>>> Where should I apply it?
>> Sent the link through another email offline.
>
> Received thanks!
>
> Stefano
>

