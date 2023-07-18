Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A307757A02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGRLC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGRLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:02:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47519E77
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:02:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IAhwKl011418;
        Tue, 18 Jul 2023 11:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uT8QaJnJoQ5wyFhBoqsvznDvZWIvZETF3DUvPt1T3Ko=;
 b=uq52vLpZgWClwajDPRWjxrR+Bi2ubPVHRlDb7fRelgTXDQjdJ09oLM3+5fuTxgTcutnu
 PZ1+4WOKRIKHhyhrIOGaoC6U6Iy7MbHc1LbkA7mtR84rWI0Spuu6vnjbse+m4yCPCEFi
 wdeHT7bOE4RAq8oO6Hcx3n7K5Bed1M0EgEOlZeaGg4K1pLy0t0KC0zz4kHPBGd/bSI+9
 AX7nTrzXs1Jh0RIhlzZN41UemOyPzwLFaYt+CxPubjAThLHyhZRcRCrvKbbKnV9f4cCC
 nXjuMjaovlwsYCXtzgkOhJOYpzpEXinlL+KRSLqy69/tDX+cbgz3VQaSjYS6UVVeqzd3 Gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run784rq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 11:01:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36I9Dm33017387;
        Tue, 18 Jul 2023 11:01:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4wdvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 11:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZhbVPa2TsCGgLYgOS6mal35g4YyRlqoIwmlTMq7vDyCh2o+PfEX6K50Ydl7exIr7M5YyKNUkaSVewGTXH+zs5hKSs/Aa/vp7kIwHzqPzPBvm+xz7HgO1GC+NqM1ueZRK7IMw8QHDonWJaHWlwu6uIjaoZNwAw21BDpt6IAn0On1on0sCOItB94Oz0/VSaVfnrKZ5UT3UXHB4FVmdb3lNT9IjkIHidl+DUx8XAWghWOM3+4c2FlKriF9HP879G72nI+LDgwqkZ6RqcaEabZVvMF1RPy+ESBf69qwuOY6Hcl51R3Ob2L/U4vVJvJxySHlxl+fYFhF1DMqxn0deTzuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT8QaJnJoQ5wyFhBoqsvznDvZWIvZETF3DUvPt1T3Ko=;
 b=dMBpWdG+OiQBomBeLLwu4drvhExOtmtdVwsMT1yet7ozSSjfqv07nRC5jPawswOqrVthemM0RuU8FZ7+8elV0KiHxLHXZXHIDUlOMCXvvT17H9VVTOUKdkPQHjr5rgX3HIaYtp0ABkqIblDeU5PzpLw5pJO1DM8z6XjFxIu40idvxOjZ/1N51VtjedjQ5bQZTkkDnMS4QaQ6/5Thzx5F0PuiZq5pFyPJZc6aRP2DoxPbB5uXvjzKDhlKZYn6tlMpBX6C1z2Yt7ndb9SKU6EUHHxkzQFz0gv0C+WnFZpddrozwPAn27mP0vF1lXlCqbHU5sfCCGhKW/Z/SblL/0svbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT8QaJnJoQ5wyFhBoqsvznDvZWIvZETF3DUvPt1T3Ko=;
 b=qfluah03J9LrvNp7R4ncYnKcf4PVvH7a5R7WvBYOZVPEoi5h0rnpn93sfkAYG2zArbf37AlV3NVO3p/9ke4jkfFd0l2/uRUrRQ5UgAZ3nsN11hfreM0QwELfZPuKiHS8cTdeBiriXsx6XfTOBy8Hl0pWrTffDlZC/ELo5rdE1dc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB6176.namprd10.prod.outlook.com (2603:10b6:8:c0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 11:01:42 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2cd:1872:970d:7c4e]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2cd:1872:970d:7c4e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:01:41 +0000
Content-Type: multipart/mixed; boundary="------------R30R0KSuTXrEe2P2evgWzt2J"
Message-ID: <d11eea99-6e93-6af4-87aa-2e7f1c6ae83e@oracle.com>
Date:   Tue, 18 Jul 2023 13:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
 <CAHk-=wiXp9YLB6wHOmc4rBJbd7j0gHgHZPHhUSPe-SAjJgmABQ@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <CAHk-=wiXp9YLB6wHOmc4rBJbd7j0gHgHZPHhUSPe-SAjJgmABQ@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::8) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS0PR10MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 40aaebd1-96aa-4d64-d594-08db877e5d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5HBoLxb3fLRmjUr8/trrLVkrkkmbCpWiUbIicJwP8t2z8fbeiAQy5dma9KEt/+FV/YfczJWrMtcb80rr5qSxg2sRCsdk9Kzlna7/D9AjB6Y96JznPsZ2KxX0hF0+CZqkmEv2lPZ4VVvzQdgluX73ewqY7/Z2lRgZrnjx4JF6QyKIH3nR3L8NtbzjioISXPnGr+WQy5E2vX/MVa7jEpe+T1T6+BtW97orYhz/IhI04G3FhYB0f/zYg8qn10thIqnTZWM8mI5wauhflj2lCrqI+orELzBoNUnvOZ1pbLSPUik23OfZgdeWGrQJawZXSfbqG15UAVYjHZIwlACRO+Lyu2JN3C5539LwWIGfJUc8mB2ncg2ViXzUQf4WIsBau0DcymXuKJuuGPK4SMgYgPxiYtKpE4tKkDSjL+NvLnRMaXASfAPsv+Wf9AkjtyaYVranJSCG1x2zAn16SH1+abITQOGgDm4vFQvMQbfLR1vtOX8YRUby+M9nM5m7199LC+W8R1XENc/VUUVoWjVqsWKqkWK4v/LFxv4t06ybTROTixjYaQsiEs+WbMUhVDa9qtsEgQwP69vzf0MDVHPhShsSfeDi1J7PgwRB2GAAg9SB6Ff/50u5NgT1C4PgR2G3glbMXfrX7S7nfVj45i3BPtddw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(41300700001)(316002)(83380400001)(53546011)(186003)(6512007)(31686004)(2616005)(26005)(6506007)(33964004)(6486002)(478600001)(110136005)(54906003)(6666004)(66946007)(4326008)(44832011)(38100700002)(66556008)(66476007)(86362001)(31696002)(5660300002)(8676002)(36756003)(235185007)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzhuU01ibmFKa0NranFVenVDQnJMTlcyYnQ0TXYrNkNzdSs2ejc5Y0ZNMyt3?=
 =?utf-8?B?cWVhbzU2aVBrYWRKR3U3Zy92cFBBSXBkSzl6Y1NFQ3JOaWlOMVVVaWZtek5L?=
 =?utf-8?B?RXMyRkVldndraUtFWEJLbmRVRUtuSG9ib1pnT3BLdWIzcHlkR2lkY0dRUVZJ?=
 =?utf-8?B?MXZhQUVKeDBsSjdNeXJjMXJud1FEdHMzckVQTVRyVUdNTzEwNXQySUNCV0dG?=
 =?utf-8?B?VTYzaTBBUnN0OXR4cEtXa2twMG1IQktJNU9RQ3RpcnhTM2FXSmhYSjBvTXAz?=
 =?utf-8?B?Mk0yTk9CbmwrL3ZZOWxSWDRrdStMUjR3eDNLYWdtNm5rWkVnWEV0eUdhd24z?=
 =?utf-8?B?SkJhZTQ4UEh6TTFXa1IySHpqMGVnQ2hKVjhSVytJekhQSGZRM3dDd1RIV3Bm?=
 =?utf-8?B?OWcwL1RZWHVqallCZ3l4OCtINnllUTlzYzZjb2lJVHc3K1laWmpIZldMY0k0?=
 =?utf-8?B?cmJJem0yRUlPYzRnTjdBbThOWkpHTWVhem4xOEJ2MWJIdGMrT25RQnZRUjI4?=
 =?utf-8?B?Z1RybzE2Wkd4a1ZpN3U2UlYzM0lhMUtwT240ZGtHL0VKNEpYaTJpa3k1cU94?=
 =?utf-8?B?bkxZREZXay9kdWI1bUdNSExaVG4wY3hEMzVIa1hUUGVHUXRJMnVidVUyNUxF?=
 =?utf-8?B?NU1XUXVXcmNvS0NWUHR3b3hFMjZtNHd4ZG9pUVZ4TUFRZDBOV0NhakVGcWxD?=
 =?utf-8?B?bnFjT2Jmb0kyYVplZWNkREdnemYwUkEzRnphWXlhaE1FN1VORWhWZGRhSmcv?=
 =?utf-8?B?Zkw2Q2NBUkxmVlpWNXpzUWE3OWtmam5PV2RBbnBUM3hYMWpCakF3ZWNRVm5S?=
 =?utf-8?B?SFBJaGE4bUN3NG5TTG8xRDRubE1HNzZ4azY3QzZQOEJETmt3WVdKY0lGZUFn?=
 =?utf-8?B?TGE5SU1paVlPeVpwMHFBZEZhNHhvYTFaR1JtcU1EU21IeVlybzNZK3MzRFlG?=
 =?utf-8?B?NUMvQXJmdnpqRmpKblFEYXY0NXRpZkxaLzJuOTZBbjZmN1diNi9CY3ExaUp4?=
 =?utf-8?B?dHNyVlFRdnA1Tm9xeUZSNHJPd2JWU1BwWnlOYVErN25EMHZtYXFjRjVJWkhW?=
 =?utf-8?B?TFR3ZnF6VExjaDY1eDVZS3hMbGxsUVQ4UGtNcGM1VW9ZWGFuYlhCam5pUjA5?=
 =?utf-8?B?Vm1WTjNIVkxyN0dKN2hQWkNJbUNFZDVFVHoyK2hLYjE0SHJwMmFxZkJDTGFE?=
 =?utf-8?B?VllPdS9nVDU4MytMUzJ6dy9VSnVpcGpmQVFMckpNSndxczNNazBnVmFPb0pq?=
 =?utf-8?B?Y2hCMnZwQ3pVMjJOd2Q5bjIvUFJtRjBKSWI4aFZRbDRsWi9uQnFURUlTeWNq?=
 =?utf-8?B?VGlzSDVBbEFKMWVMNzZkRWVjQ2dNSC93WXZKSzhxSmpuN0o3MWdESDFYS1Vs?=
 =?utf-8?B?RmVuWmtjaTAwaVdlYkw1N3J1QmlmNGhIZDdUQStBWHFaZmpTYTFIMlVyWW9j?=
 =?utf-8?B?ZW1DT0RCUkNjZWlZWjI1Mjc0L3Q2VU9reloxcHE3ckZCdWxCWXh3N3dFVXNm?=
 =?utf-8?B?TnBjZGxvVXFwTFg0OHNJMzRyQkQ4WmZ6anVEOUxuaEdSYWlWaFhpRXQ3TDI0?=
 =?utf-8?B?KzY1OFVpNmU0MW9qa1ZsaUxYQ2RKcllCNDF2Mm4rbzhPMXZNcTRMVVh6VUkr?=
 =?utf-8?B?Mnp1UnczaDg0dWFiN1pibUVrSHpIR1NicVg4QTJjS2wxMGJmKzJlVXEycXNo?=
 =?utf-8?B?Nm9HSktxWGgyajhJWHo2TVlDOWtiVHBTTDJybkdPZHFwdjh4TktvR3NmUGNp?=
 =?utf-8?B?TCtxRmwzamx3YXNlN3FQdWhjK2JicXY3elZvNTRoTllaaDFNTERsYlE5YzVv?=
 =?utf-8?B?bUdkcmVaY0pwaHU2eWs3bHp2MmgrOEFzaE1VYVlFSlk1L0NXei9HK0t5OHBp?=
 =?utf-8?B?MXd5THQwMVI4VmRLT0RpNnFCM1MyT2hwemVmaE4vZWFtNnpMbkd0TGc0WjJm?=
 =?utf-8?B?enpNVUNYOVhlSGZRU0J5QWgxS01iS3dUZ2JGK2FWTkRwb3BtbWVzelhwaFpl?=
 =?utf-8?B?dlE5czRqdEg1eURBdDNsUUoxcE95TXc2T09BeVpPZ1lIbDBOTHViT1Y2UFZY?=
 =?utf-8?B?eThKVlpKbHhKZUhXK2xjaWYyY0RMd1hLY0hlQWJuelJRNHk1ZkNta3VyNlg2?=
 =?utf-8?Q?LQlRgnj3q+HTq4lhAGZoBZSi5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ekFEYTdwczFFNStrbzlYWFpxV0ozSUo2V1MyNjYrU2dSSk5GZGV4ck5YZWsy?=
 =?utf-8?B?eGMxQnd0aWk4UmRBUlJNYmRhUEVnbXNwMDJGQjcvZzFWeVQ2RDNCMEZBY0M3?=
 =?utf-8?B?N0ZLOVVKTVVZNkFNR2poL0UrTlZYT3RXNmJsOVI1MU4wb1FaemlhaXRROUNL?=
 =?utf-8?B?WG9UOGU3d3JyNnJmOWhqdkJhUVM4OGFnSEJyT0xoM05Mc0NpeEViZnpSYnVp?=
 =?utf-8?B?OHdLcUFPdEdjYXNLWkM3UGR5d0ZXL25zTXpxVVNtdXgxdjdDR3BhZ3NPb01D?=
 =?utf-8?B?NjlqSWRNc2l1Ty9TN29yRDM3MWRaS0h6WVFraVBDRTRtcis2T1NOb1VpVWwr?=
 =?utf-8?B?ZkZHWCtzL0prT1o5dk9kUnByUmpUUkZqNHZ0QSt4R0xWditFTXhZMlE1eE5F?=
 =?utf-8?B?QlNiaDlHMlBTYkttVEdGeUJGWVowZE9FQWwyVzAvV2c2NXpNM3h6UUMvelpz?=
 =?utf-8?B?ZStUd2IwTTluVjkyaENZRmRQQmVUZ1ZFd3BmcStUa1ZORWdFUVNKVUNoRGRn?=
 =?utf-8?B?Mzh5QmFxZ043V0V1UDM3OG9sdlJ3UzVMS29STHVVZzlqY05OcVgxeE41azF4?=
 =?utf-8?B?ZEg4VU5FM0xIQU9KNEM3c2ZPQVVWejNHVFVXdWlraU83eE55eEZlSEtlbG9Y?=
 =?utf-8?B?T1RoR016ZkZoWjJyNVB0SVU4cEV4ZnVLeUt6cFE3SzhvZWI4RFB1bjlTbU1l?=
 =?utf-8?B?cUNvQmJ5eHpZZDM1bTB1OXBzTnowNXNVT2EydVQ4ZUc5WFhlY0ZEVmRlTWkv?=
 =?utf-8?B?NENDSVVIT21LTFNsRWxQamxBeE50b2V6UGdSMSszUXdWdUFvSHpKb2lVb2Ri?=
 =?utf-8?B?SlNUSjRWc3ltbmpSQmpaZDNFSHpZWW4xRnkwcXZLd2VUeFlKQlBMQkpQTzhB?=
 =?utf-8?B?bkVnZ1FMTHdoQk9BT0FEd0NZckNVSXBxVUo1K3RVOW1NN0dtVDJKcjNpTDQ3?=
 =?utf-8?B?V2phSEZyc3RtOFRHSVNCeTljMmw4VVJFanhScnRra1o3OWNsZzNSc2c0UXJS?=
 =?utf-8?B?UGZjTEpQL3JpdmEyVHdUYkp2S01abm8yRlFheGtWZm1jaUlNdUU0V0FlcHFv?=
 =?utf-8?B?aXNjclQzTE5HV2tsOHUrMGI2eU5TdnRLbFJrRW5xNWp5MXdLZWY3SXFNa0RU?=
 =?utf-8?B?UDlQUjBoSnNsRkhoTjE2UmYrRXQ5V05BbDA1UFV2TmFYZ3BEbFV5NzMreVNU?=
 =?utf-8?B?Rm1xaXpYMSszcGMwNzdSYXVGSk1MQ0ZFTHh6bno2bkJpVUNHV09Qb3NhbXU4?=
 =?utf-8?Q?ARQGEfWJd23lfwN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aaebd1-96aa-4d64-d594-08db877e5d8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 11:01:41.7424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu2KpwHmgifmp1eOQ2aBE+nQ+OhRsk8iS406TJGArPv8cdw0rLzOioLraRnPfiNV9/g7UeKK8HezzKdEE0GM9uirEQOIwhNDmmOX6KEhd+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_07,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=826
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180100
X-Proofpoint-ORIG-GUID: tM8Z0aXtKFsfZICwUoEYCOv2HQUCa6e9
X-Proofpoint-GUID: tM8Z0aXtKFsfZICwUoEYCOv2HQUCa6e9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------R30R0KSuTXrEe2P2evgWzt2J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/16/23 22:39, Linus Torvalds wrote:
> On Sun, 16 Jul 2023 at 11:42, Borislav Petkov <bp@alien8.de> wrote:
>>
>> - Mark copy_iovec_from_user() __noclone in order to  prevent gcc from
>>    doing an inter-procedural optimization and confuse objtool
> 
> This is painful.
> 
> Isn't there some way to mark the user_access_begin() itself so that
> the compiler doesn't move it?
> 
> I've pulled this thing, but it does seem like we're chasing the
> symptoms, not the deeper cause..

The deeper cause is that the [code generated by the] user_access_begin()
and user_write_access_end()/unsafe_get_user() calls end up in different
functions and objtool doesn't like that.

If you are willing to add another helper function that also takes the
label argument, you could do something like this:

#define user_access_begin_label(a,b, err_label) \
         ({ \
                 asm_volatile_goto("" :::: err_label); \
                 user_access_begin(a,b); \
         })

The asm_volatile_goto() isn't a real goto (it emits no instructions),
but it makes GCC believe there's a potential jump there and prevents the
compiler from splitting up the function across the label and its usage.

unsafe_get_user() already takes this same label as an argument and the
user_access_end() call is where the label is defined.

I tried first to avoid changing the uaccess API by defining a fixed
label inside user_write_access_end() and always doing "fake jumps" to
this fixed label from both user_write_access_begin() and
unsafe_get_user(). However, you run into trouble with functions like
sys_waitid() in kernel/exit.c that have multiple user_write_access_end()
calls.

You might think that you could switch them around -- define the label in
_begin() and fake-jump to it from _end(), but that doesn't work either
since _begin() needs to be an expression and labels defined inside a
statement expression are not accessible outside that expression...

Anyway, attached a proof of concept patch that fixes the objtool
warning, but I didn't even do a full build test.


Vegard
--------------R30R0KSuTXrEe2P2evgWzt2J
Content-Type: text/x-patch; charset=UTF-8; name="uaccess.patch"
Content-Disposition: attachment; filename="uaccess.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaAppbmRleCAxY2M3NTZlYWZhNDQuLjEyOWJmODIzZTQwNSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNTU0LDYgKzU1NCwxMSBAQCBzdGF0aWMgX19tdXN0X2No
ZWNrIF9fYWx3YXlzX2lubGluZSBib29sIHVzZXJfYWNjZXNzX2JlZ2luKGNvbnN0IHZvaWQgX191
c2VyICpwdAogCXJldHVybiAxOwogfQogI2RlZmluZSB1c2VyX2FjY2Vzc19iZWdpbihhLGIpCXVz
ZXJfYWNjZXNzX2JlZ2luKGEsYikKKyNkZWZpbmUgdXNlcl9hY2Nlc3NfYmVnaW5fbGFiZWwoYSxi
LCBlcnJfbGFiZWwpCVwKKwkoeyBcCisJCWFzbV92b2xhdGlsZV9nb3RvKCIiIDo6OjogZXJyX2xh
YmVsKTsgXAorCQl1c2VyX2FjY2Vzc19iZWdpbihhLGIpOyBcCisJfSkKICNkZWZpbmUgdXNlcl9h
Y2Nlc3NfZW5kKCkJX191YWNjZXNzX2VuZCgpCiAKICNkZWZpbmUgdXNlcl9hY2Nlc3Nfc2F2ZSgp
CXNtYXBfc2F2ZSgpCmRpZmYgLS1naXQgYS9saWIvaW92X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5j
CmluZGV4IDNlNmM5YmNmYTYxMi4uMzMwOWJhZDY5ZWNhIDEwMDY0NAotLS0gYS9saWIvaW92X2l0
ZXIuYworKysgYi9saWIvaW92X2l0ZXIuYwpAQCAtMTcwOSw3ICsxNzA5LDcgQEAgc3RhdGljIGlu
dCBjb3B5X2NvbXBhdF9pb3ZlY19mcm9tX3VzZXIoc3RydWN0IGlvdmVjICppb3YsCiAJCShjb25z
dCBzdHJ1Y3QgY29tcGF0X2lvdmVjIF9fdXNlciAqKXV2ZWM7CiAJaW50IHJldCA9IC1FRkFVTFQs
IGk7CiAKLQlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKHVpb3YsIG5yX3NlZ3MgKiBzaXplb2YoKnVp
b3YpKSkKKwlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luX2xhYmVsKHVpb3YsIG5yX3NlZ3MgKiBzaXpl
b2YoKnVpb3YpLCB1YWNjZXNzX2VuZCkpCiAJCXJldHVybiAtRUZBVUxUOwogCiAJZm9yIChpID0g
MDsgaSA8IG5yX3NlZ3M7IGkrKykgewo=

--------------R30R0KSuTXrEe2P2evgWzt2J--
