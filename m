Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6241A778391
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHJWVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHJWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:21:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F39271E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:21:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AL4bLA022015;
        Thu, 10 Aug 2023 22:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=0EsOwNzbmMQ+ixhyPeBs19bNUjmhm4gn+OwQJpuqZYY6eSiAVXa/ETTJptczqwZrqjlZ
 n1jfRBWKggUL9LDUW7nJbIUlCOfvOm3uls1U5rjmTsT2sHjm9Lw7hh2qn7y/rSRjybRc
 526Q/wmFq3ZaevZLcy29/oOQjphMYH9YCAClAnuqECSFXdsFLoM136iYn6Kjt4tXKr/p
 aRTvtf9qMhHBSoo36uYPf1FbmPPklO7MDIaczhACLV9Vxr1v63z/yMVql6emig3uBcjt
 l32Af865Nk8CZSmETd8PKmYTvAWCqZ8Jm+pQsK01NMeGaJmJcetXc4RzAf7AFy5Cm51c nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efdccxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 22:21:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ALrI9L007688;
        Thu, 10 Aug 2023 22:20:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvg3usk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 22:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPwogHaqHpCLrEKUFQNaXX8fWgD63xtuIpITj5B4hK1IDwETN6AUlSq6dS/GlHp1F3kvJNnYCe80s4KpnxdSCgrxgv3n4nOKBfSwD8e400jRIB8mKj4qrkqM4sQGlEfUM1yLDF2mqRrOo0w9St2per/4X2NQ9mwwU8VMTF+vchiP7MZzTGwmPDDBiCJwvc7hDevcOkQTTo4DDofVZkxGHwej2IYwspnB0SUytsxD057HJ/AlWrV05RQKkdlXtwMrWeMUkN4Wr3K+euTH5vaGjPCge93Pm9GXLr/olvVHk9tntV9GQKHk/w64lXuii8OdO++E0ZlpA6AeDir/YZ43Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=WLGZRSHcGrinvR+9pHKYZijqTBHQKAkjhmpYF74n3yHQhu1AK9riHu8PoL/xEXdJzcMXUoIaeEQJgo7+wpu6H1IurFIWCpQcFT8UZtpPCwzxHHdxm+vsWWLyipJm9vL+WRKRKyaXs2an21PiTcST8Q0C0SPOlgRVjSDplJiktSc0bxk06dcxXJrRZlpcUH2qgpHUqJ619VHKtC1FpJfdH9Re08UWbL2Q89E12ycxWW3U59d0ne/eFPqRojAJvJW30C6OLyD0Ywq/x99vDkkhb99jCPKe8v+HnK75iR7V4qR6nMp1Ykc3eudU08AdlxsNsVGcXiLhPziwpE0zwgaPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=HTRh26tIb6i7bp7J9vXESJXM65ShLXVI8drqGL/pdp62XB24vRrTzpGXgDs7LEY66RLsO2JbcV9f2vZ1TXcnDaQVI43KfmuGmMlI98Pk4haiajHgcYY3nGHo/SV5K5aIE32jhj/sHpXGhrMaO4QIQhd2q1W8a4VTkwZkBKHMmCU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 22:20:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:20:56 +0000
Message-ID: <325aaca0-ccdf-1843-4ab8-03bc94d3ea98@oracle.com>
Date:   Thu, 10 Aug 2023 15:20:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
 <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
 <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
 <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 906112e0-604b-45a4-80ec-08db99f010fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm+/e/PIRpv56kEKuAKgYp4zzV6uZ9/afKJ54lTQsQJVCX58XLcqtqEOQu07ymvSTyQc+EiIqK92OOc5udhlHuldFCEaXr3e35C9nhS+nbSbxvkXHSXO0Kg3PIB6qVv2Ls4oa7pPpyQxNNeVvy/tDuyNs+G995VagLfa4cslQ2EXKfSJyZtHKI3pzuaNMf4ZAHPfZephEt6Xjaj5IocO901qCWKk9uypQ9SEgKRIuaLoo+6GYeyzZb6wC3dyOH9zl5khnHgftTVSJ+DnlFVuU9nEZeJB9oiR0I7vxzwJ5zh8VZjwg8a2+q6jB7LpfoOSn/Tptw2g2/Vamg0Y3sv3aFGxmSrLnFiXAl0H5hvRBINYKWfD6EcEk6viqhiJmCUxfayxeZGmpOaZdeYfHqCG1X64WqWAHJedinanwTm0FS6bmv9p93aY0WRZd07ZKYb9BXnIX99JMkm2KUb9qTuebWrWqvnE/7Hm5GT+GOiGY25Jhifs+/DUjcy+54eh0RhScpJ59DJcx/7E3rtJa0fZqlIotogPMOGlW2hMG+lT6ia3eroaK9u4nYDyaKDlgpynfMDEWSWZ3y5b7cYVSdrQPGdRgcRGARJO31+ccd0mmmEiJrKddcbPQrhNK+B1wkjakhpaAi2Xh3GqmHDCfdhxpR6+BxrfvoI2NgdH8+Up1Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(366004)(396003)(186006)(1800799006)(451199021)(31686004)(54906003)(26005)(38100700002)(53546011)(6506007)(6486002)(2616005)(8936002)(36916002)(8676002)(66574015)(478600001)(86362001)(31696002)(66946007)(66476007)(4326008)(66556008)(6916009)(6512007)(966005)(41300700001)(316002)(2906002)(30864003)(36756003)(5660300002)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxHVWhQVEx6NmUvaW1JMWpCMzdSRWcrQjRyR3EwNDhZSmpqcEtYUHZaNTBs?=
 =?utf-8?B?ZXQ3czZyQXpSdThJSTVCdy9RNjVQUmR2L2tod3Z5Mk42VHdyV0tkOXhSYTRa?=
 =?utf-8?B?Q0Jzc2kzbng0U2VsZlU2K0tzWG5sakU3WTBIa1lXbzMwdHBMVkhRV1pzWTQ3?=
 =?utf-8?B?bXNzVjVUckNONWRONW01Q3JiYnRWUGVoYkZBOEFoMnloS2gwblBPWFdzT2dI?=
 =?utf-8?B?NEJWV0h2NTNSbkcvZVlpbE1qb2cweTlYaXJ1N1FheXQ4MG01azNXZSt4SlV6?=
 =?utf-8?B?emR1RmF2MUpaZWYvTTBOUTBDcG5IeGhCek9CVjI4ZjZGOWUzVEdrcldYbFJu?=
 =?utf-8?B?WnVHdmJDUGF2NHpmUlVyMXFQR3RsUmh6MTNXejVVV3Jhbjc2NldWUW1LcVor?=
 =?utf-8?B?RjVjZVZTcXFldjN6NGdsZlczQTJ2MGIzV0JRanhqVVMzcmtXOWNFazlGRTJW?=
 =?utf-8?B?d0tSZ1dqbEJkcElBK3JaeklGYzB0MTc3QjJ6TXpZUXZNMHAvNDdKV1U3VEhI?=
 =?utf-8?B?RU56NHo2WGlUcUtCcWNlQmNadGxydjhaK3E4ODQ5bGJ4TjlvWk5TNGxlTWUz?=
 =?utf-8?B?WEVZOXNxOXFwd2RVNmllQndGQVI4Qm92YU8xeVFVZHpwdTBIaUdMdWtYdTBq?=
 =?utf-8?B?ZG1XZzdnelBmWm1wMStKZ2Z2VjNqNHJiWDgrcitKdjRNQk1wYWJEM0tycDQ5?=
 =?utf-8?B?TmRYN2RtdFQzVTJ5VVc5YjREa0psdE5OWTRKeTBhSWJBdVZzd1RoektkVlc1?=
 =?utf-8?B?YjdvRHZSOVhjdjlaMjA5V1hLbTNLaTh6S09UaWh1bU41ZHdCaW9XMXhwZ0Uw?=
 =?utf-8?B?UlpzcHBod2dDMzVoSmhsa0JJQ2NQblJWMTNCNTRoLzFtQkVrZ2VsamhyYlZO?=
 =?utf-8?B?L2ZkdE80S05NeWJZWnZFT013ODlEMGc3UVROQXA4NHowUTRZV04rRkM2Unl1?=
 =?utf-8?B?akp0Q3JDcnl2UW1Ddk1TTkYzbmxMTUtHaTdUYXpZTzY0MFhXQTRkQ2RucWpl?=
 =?utf-8?B?Z2JmOTd2bnhQUHN3d0RJS3ZpNVVXUmxETUw5SXZRRENBMWEzaS9YR1l3SmNh?=
 =?utf-8?B?a0cyOVF3NHB5OHhGMG5PYVBkbU5UYVhzMGltemlDY3B1QlFHT3hFTWl1dm82?=
 =?utf-8?B?REFJQmxvZ0VUYk1hYTFHdmtjTHUvSXJ0VW9iUGU3UXhqYnVXaFJvWml2RFZs?=
 =?utf-8?B?UnArVWEvV2l1QmgzMTlSbEtSejBtd1dXLy9xUS8xNkRmSURpRjMvRU1nNUYx?=
 =?utf-8?B?elB6YUlmZ3g2OHNjS2ZxOGN6NEdnWDFwWmJxL2xDdy84VmVheit3WGNoTUs4?=
 =?utf-8?B?L3pDcHFuYWdGeFdrbmozU0N4d3Y1LzZ2ZWZWUVFLTU03ZGpobE8wWnNZN2ZJ?=
 =?utf-8?B?RUNwYStiTkdBOUZieWdsdkVUK2cyWXdGWnhqeEowWSs0d2R5NnlWUG5Wem9n?=
 =?utf-8?B?VW9oNlY2bXpEUDNyV0tPVjk0Y1JuUlNiaXZEajRSWlQ1RUlVdHp3M2VzV1lI?=
 =?utf-8?B?RUV5VnIxS2pWSHRrRGNxb0U4YjM1bHlrdkNqaHVMK3dDdGtoTjNPdjduRXBT?=
 =?utf-8?B?RVVuc0FkUUFqL2NNdzFnb09SdTlpeVJVa21yQ3U0bTVIclE0eFNXRU1IT3BF?=
 =?utf-8?B?RzZTMHdiQmdmUWhlbmlSaTJPb3lOZXBXNXFHaHpqOS9IQTh4NWFsT1IrdWVC?=
 =?utf-8?B?akI2a211Qnc3VEd2UGJpWmFWWndVeHU0OGxmZ00wKzluNEllU3VrVmNTM0Fh?=
 =?utf-8?B?QTVKS21Qd0tNbE9henVnMUpHZlkxeGttdG9FS3NtdkhnRGNkKzJzbTU2NE9w?=
 =?utf-8?B?SERrSDd4bkozRHV5dEZ5VkhkWlhJQzhhcWRHY0d5VWorVVlVZzlGVUY4c2dI?=
 =?utf-8?B?Mm9QRGxXNFZ5TEt3REt5Q2NFRUtyY2ZnTElLdDY0VFNKWmQwY3ZjMHRPNDds?=
 =?utf-8?B?Q0E5NGw4YzdRR1hNSjhtb1NlVXR0ampERCtDeUNrdTVSV0hnZm5EaXFIM29J?=
 =?utf-8?B?MDU1OTJOdzlOWXVMTnNvZnJBcXViVGluRUpSZStGWnZpbFJKdFpoRnhNR3hv?=
 =?utf-8?B?NjRaK0Y3bnBxcWRsL0MwNWpsZ3gzWWRxT200MGJHR2IxOXNnVHA5Q3hEU3pk?=
 =?utf-8?Q?c1YaWUXY6jtqNpeUyyzd7N0y2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWRxdGl0RmVRMitpT3crMHBBa3Qrd3JMZVRXWGxjVC9xNjB4blhaTVdNeStp?=
 =?utf-8?B?c3JPTjg1cHJQZ0RzYjE3dCtnUHRpM1BySmovNjErYUxtSDBhOHZJRVhNQVpT?=
 =?utf-8?B?S0RjVnRXNytSakczNnFxaUVkSlAramNhcFYzdVlyZTFKTndLRWFsaHdaaHBD?=
 =?utf-8?B?ZCtDVjA5QkU1UFNudEd6VjR1aC9ldjduc2M0UFRDeWMrRklseWloTGNJdEgy?=
 =?utf-8?B?NWNTcmQ0djVtU1Y4c1lWbmNqQUxkUzhiY2Z1NVdDenh2YnpYTUlXRVlYWEtt?=
 =?utf-8?B?ZzZSeXJFbEplSWE5MEJhcGx3WkZsTFJMbVpLU0lJbkFtVUR0OFFubk9uL2Z4?=
 =?utf-8?B?T1dtbW1MZlg5ekUwQThSREpZN3dhTk1vcVNydnM4empaUy9VVE5ONlFhdUdQ?=
 =?utf-8?B?eFFSeThxRzkxS1FsZDUwb3FYZm5KRFNZMk93QThXc01WY1R5V3plTTNBaVhN?=
 =?utf-8?B?WEFHZXFTSXF3SWhOQmdkMitqRE91dWZMUDI3OERkVUszNmx5N01kalMySzlk?=
 =?utf-8?B?VDFMMjJVVTE0VVJyRmVSU080L0wzdDZFV3FDRjljYU9LNGtFSUJ5MHUvL3dq?=
 =?utf-8?B?NnFvdVpObzBjNHZpVlRYUnByZURiRU9KQUhWZEpuSGhlTWZSSWF5OThtTmx1?=
 =?utf-8?B?R1FwTDlOeU9NaHFPSEdvT2QzejY0ZkI5b01BNHJIWkNwVnorUURELzVPMnhP?=
 =?utf-8?B?ZVU2SjVkZktwZXpFbldSWVpINGhVWGRTdDZhbzN1eUpubnpUQUFqQ2tNK0hy?=
 =?utf-8?B?aVVQbC9yN2tVRHZmVmd4RVlOYlMxVjNYRVdyN0ZlLzFkRC9RYm1IaXRqMG0w?=
 =?utf-8?B?bjk1UmZrVzV4UnRveDI4akdtRkpwWWhxR0dCdHJwWjBUdWdvdTJUYm9WQXF1?=
 =?utf-8?B?eVJha3I2RDBuSFUwZ3RvdVFVZnI3aHNNYmVnMEtYTmNYbmFDb1VXVHhJcTBR?=
 =?utf-8?B?Q2t5djVPT1UySTlFVkxkSnVyMlF0WTRPaTQ4RHpmRWo0RVRWRzdkVEc2L0xZ?=
 =?utf-8?B?cFhxY0xkZWYvVzM0TTV5NWVQRFA1MEkwaWJjbFFtY05wakJDdzJvaTFZTzlz?=
 =?utf-8?B?bTVVT1VFWHhLZTdaQjhNSjNMUWhsRW1OT0crOC9sZWdpUXdQMUkzSzlqSHN2?=
 =?utf-8?B?K0dnQkxObW1SeTMvdUtPaXhobjgrdG13SXN4K1A4a1VJUUlRNmlpdnJIcE9N?=
 =?utf-8?B?ZktKcllQamVKdWt6T3BicjkrWVpxZWJBcXBud2ZHQXoxSGFJVUE2ZVFYb3By?=
 =?utf-8?Q?jdEiFJtUO+/XV8+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906112e0-604b-45a4-80ec-08db99f010fb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 22:20:56.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLoUmlHhlHScgdwX5ZfLoQEr1YjotSvA6bJQPEeD2vk+4vmbokglak6nxIWtC/QpspF8aLSCyqnEL2vJZNwkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100192
X-Proofpoint-GUID: jutxMMzJbqRzwEKcICQtzwifD5GErJGh
X-Proofpoint-ORIG-GUID: jutxMMzJbqRzwEKcICQtzwifD5GErJGh
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 8:10 PM, Jason Wang wrote:
> On Thu, Aug 10, 2023 at 8:40 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/8/2023 11:52 PM, Jason Wang wrote:
>>> On Wed, Aug 9, 2023 at 6:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/7/2023 8:00 PM, Jason Wang wrote:
>>>>> On Fri, Aug 4, 2023 at 1:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 8/3/2023 1:03 AM, Jason Wang wrote:
>>>>>>> On Thu, Aug 3, 2023 at 1:13 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>> The mr->initialized flag is shared between the control vq and data vq
>>>>>>>> part of the mr init/uninit. But if the control vq and data vq get placed
>>>>>>>> in different ASIDs, it can happen that initializing the control vq will
>>>>>>>> prevent the data vq mr from being initialized.
>>>>>>>>
>>>>>>>> This patch consolidates the control and data vq init parts into their
>>>>>>>> own init functions. The mr->initialized will now be used for the data vq
>>>>>>>> only. The control vq currently doesn't need a flag.
>>>>>>>>
>>>>>>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
>>>>>>>> split into data and control vq functions which are now also ASID aware.
>>>>>>>>
>>>>>>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>>>>>>> ---
>>>>>>>>      drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>>>>>>      drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>>>>>>>>      2 files changed, 71 insertions(+), 27 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>> index 25fc4120b618..a0420be5059f 100644
>>>>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
>>>>>>>>             struct list_head head;
>>>>>>>>             unsigned long num_directs;
>>>>>>>>             unsigned long num_klms;
>>>>>>>> +       /* state of dvq mr */
>>>>>>>>             bool initialized;
>>>>>>>>
>>>>>>>>             /* serialize mkey creation and destruction */
>>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>>>>>>> index 03e543229791..4ae14a248a4b 100644
>>>>>>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>>>>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>>>>>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
>>>>>>>>             }
>>>>>>>>      }
>>>>>>>>
>>>>>>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>>>>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>>>> +{
>>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       prune_iotlb(mvdev);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>>>>      {
>>>>>>>>             struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>>>>
>>>>>>>> -       mutex_lock(&mr->mkey_mtx);
>>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>>             if (!mr->initialized)
>>>>>>>> -               goto out;
>>>>>>>> +               return;
>>>>>>>>
>>>>>>>> -       prune_iotlb(mvdev);
>>>>>>>>             if (mr->user_mr)
>>>>>>>>                     destroy_user_mr(mvdev, mr);
>>>>>>>>             else
>>>>>>>>                     destroy_dma_mr(mvdev, mr);
>>>>>>>>
>>>>>>>>             mr->initialized = false;
>>>>>>>> -out:
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>>>> +{
>>>>>>>> +       struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>>>> +
>>>>>>>> +       mutex_lock(&mr->mkey_mtx);
>>>>>>>> +
>>>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>>>>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>>>>>>>> +
>>>>>>>>             mutex_unlock(&mr->mkey_mtx);
>>>>>>>>      }
>>>>>>>>
>>>>>>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>>>> -                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>>>>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>>>>>> +{
>>>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
>>>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>>>> +                                   struct vhost_iotlb *iotlb,
>>>>>>>> +                                   unsigned int asid)
>>>>>>>> +{
>>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>>>>>> +               return 0;
>>>>>>>> +
>>>>>>>> +       return dup_iotlb(mvdev, iotlb);
>>>>>>> This worries me as conceptually, there should be no difference between
>>>>>>> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
>>>>>>>
>>>>>>> One example is that, if we only do dup_iotlb() but not try to create
>>>>>>> dma mr here, we will break virtio-vdpa:
>>>>>> For this case, I guess we may need another way to support virtio-vdpa
>>>>>> 1:1 mapping rather than overloading virtio device reset semantics, see:
>>>>>>
>>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>>>>>
>>>>>>     > Conceptually, the address mapping is not a part of the abstraction for
>>>>>>     > a virtio device now. So resetting the memory mapping during virtio
>>>>>>     > device reset seems wrong.
>>>>>>
>>>>>> where we want to keep memory mapping intact across virtio device reset
>>>>>> for best live migration latency/downtime. I wonder would it work to
>>>>>> reset the mapping in vhost-vdpa life cycle out of virtio reset, say
>>>>>> introduce a .reset_map() op to restore 1:1 mapping within
>>>>>> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we can
>>>>>> move the iotlb reset logic to there without worry breaking virtio-vdpa.
>>>>> It looks to me we don't need a new ops. We can simply do set_map()
>>>>> twice
>>>> What does it mean, first set_map(0, -1ULL) with zero iotlb entry passed
>>>> in to destroy all iotlb mappings previously added, and second set_map(0,
>>>> -1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but
>>>> doesn't do harm) apart from vhost-vdpa itself can do unmap twice anyway,
>>>> this is supported today I think. Why there'll be such obscure
>>>> distinction, or what's the benefit to treat second .set_map() as
>>>> recreating 1:1 mapping?
>>> Ok, I think I miss some context. I agree that it's better to decouple
>>> memory mappings from the virtio reset. It helps to reduce the
>>> unnecessary memory transactions. It might require a new feature flag.
>> This I agreed. AFAICT QEMU would need to check this new feature flag to
>> make sure memory mappings are kept intact across reset, otherwise for
>> the sake of avoid breaking older kernels it has to recreate all the
>> mappings after reset like how it is done today.
>>
>>> Regarding the method of restoring to 1:1 DMA MR, it might be dangerous
>>> for (buggy) vhost-vDPA devices. Since its userspace doesn't set up any
>>> mapping it can explore the kernel with that via CVQ?
>> Not sure I understand this proposal. The 1:1 DMA MR is first created at
>> vdpa device add, and gets destroyed implicitly when the first .set_map
>> or .dma_map call is made, which is only possible after the vhost-vdpa
>> module is loaded and bound to vdpa devices.
> So what happens if there's a buggy userspace that doesn't do any IOTLB setup?
Then parent driver doesn't do anything in .reset_map() - as the DMA MR 
is still there. Parent driver should be able to tell apart if DMA MR has 
been destroyed or not by checking the internal state.

-Siwei

>
> Thanks
>
>> Naturally the DMA MR should
>> be restored to how it was before when vhost-vdpa module is unloaded, or
>> if anything the 1:1 DMA MR creation can be deferred to until virtio-vdpa
>> is probed and bound to devices. Today vhost_vdpa_remove_as() as part of
>> the vhost-vdpa unload code path already gets all mappings purged through
>> vhost_vdpa_iotlb_unmap(0, -1ULL), and it should be pretty safe to
>> restore DMA MR via .reset_map() right after. Not sure what's the concern
>> here with buggy vhost-vdpa device?
>>
>> Noted when vhost-vdpa is being unloaded there's even no chance to probe
>> kernel through CVQ, as the virtio feature is not even negotiated at that
>> point. And it is even trickier to wait for CVQ response from device
>> indefinitely when trying to unload a module.
>>
>> Regards,
>> -Siwei
>>> Thanks
>>>
>>>>>     or do you mean it would be faster?
>>>> I think with .reset_map() we at least can avoid indefinite latency
>>>> hiccup from destroying and recreating 1:1 mapping with the unwarranted
>>>> 2rd unmap call. And .reset_map() should work with both .dma_map() and
>>>> .set_map() APIs with clear semantics.
>>>>
>>>> Regards,
>>>> -Siwei
>>>>> Thanks
>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
>>>>>>> Author: Eli Cohen <elic@nvidia.com>
>>>>>>> Date:   Wed Jun 2 11:58:54 2021 +0300
>>>>>>>
>>>>>>>         vdpa/mlx5: Add support for running with virtio_vdpa
>>>>>>>
>>>>>>>         In order to support running vdpa using vritio_vdpa driver, we need  to
>>>>>>>         create a different kind of MR, one that has 1:1 mapping, since the
>>>>>>>         addresses referring to virtqueues are dma addresses.
>>>>>>>
>>>>>>>         We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
>>>>>>>         supports the general capability umem_uid_0. The reason for that is that
>>>>>>>         1:1 MRs must be created with uid == 0 while virtqueue objects can be
>>>>>>>         created with uid == 0 only when the firmware capability is on.
>>>>>>>
>>>>>>>         If the set_map() callback is called with new translations provided
>>>>>>>         through iotlb, the driver will destroy the 1:1 MR and create a regular
>>>>>>>         one.
>>>>>>>
>>>>>>>         Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>>>         Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.com
>>>>>>>         Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>         Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>>>> +                                   struct vhost_iotlb *iotlb,
>>>>>>>> +                                   unsigned int asid)
>>>>>>>>      {
>>>>>>>>             struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>>>>             int err;
>>>>>>>>
>>>>>>>> -       if (mr->initialized)
>>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>>>>>>                     return 0;
>>>>>>>>
>>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>>>>>> -               if (iotlb)
>>>>>>>> -                       err = create_user_mr(mvdev, iotlb);
>>>>>>>> -               else
>>>>>>>> -                       err = create_dma_mr(mvdev, mr);
>>>>>>>> +       if (mr->initialized)
>>>>>>>> +               return 0;
>>>>>>>>
>>>>>>>> -               if (err)
>>>>>>>> -                       return err;
>>>>>>>> -       }
>>>>>>>> +       if (iotlb)
>>>>>>>> +               err = create_user_mr(mvdev, iotlb);
>>>>>>>> +       else
>>>>>>>> +               err = create_dma_mr(mvdev, mr);
>>>>>>>>
>>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
>>>>>>>> -               err = dup_iotlb(mvdev, iotlb);
>>>>>>>> -               if (err)
>>>>>>>> -                       goto out_err;
>>>>>>>> -       }
>>>>>>>> +       if (err)
>>>>>>>> +               return err;
>>>>>>>>
>>>>>>>>             mr->initialized = true;
>>>>>>>> +
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>>>> +                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>>>>>> +{
>>>>>>>> +       int err;
>>>>>>>> +
>>>>>>>> +       err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>>>>>>>> +       if (err)
>>>>>>>> +               return err;
>>>>>>>> +
>>>>>>>> +       err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
>>>>>>>> +       if (err)
>>>>>>>> +               goto out_err;
>>>>>>>> +
>>>>>>>>             return 0;
>>>>>>>>
>>>>>>>>      out_err:
>>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>>>>>> -               if (iotlb)
>>>>>>>> -                       destroy_user_mr(mvdev, mr);
>>>>>>>> -               else
>>>>>>>> -                       destroy_dma_mr(mvdev, mr);
>>>>>>>> -       }
>>>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>>>>>>
>>>>>>>>             return err;
>>>>>>>>      }
>>>>>>>> --
>>>>>>>> 2.41.0
>>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Virtualization mailing list
>>>>>>> Virtualization@lists.linux-foundation.org
>>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

