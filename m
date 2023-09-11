Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC079AF49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358569AbjIKWMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbjIKRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A312A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BChU5R030218;
        Mon, 11 Sep 2023 17:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6F+PLoOQXbZboOIXkw+RTCdZk9o/Yog7zyanCqEubJg=;
 b=Xl2bNOmrwjwDE2pbxVhUTA9t9HTXgh2/8LtDg2gTHhz/mhM2Z3qso1d1m2EDnT0QKzmj
 dAtWZzcQWAxgBgj3UZWcJ9gkxU2eTBjpbXY+3RDt1lTQx4KF0r0GjXEMrfOPYB7n/BFf
 yy1NdIOmJnftnDeWTFRV96vsZM8zE9dpuL/EYqvzi4/m1cPgnQaqXv9+0O2xUR8nJ9n2
 PSXYThx9AJU8Ed9G5of+Xr3zZokKC0dhJsMwzENJRrqCmscVVIKvXi1zVPjpvWnDfOcR
 8L5xXslOqfqM5QqdC+tm2YCaDZSG2vJuasqHnWQEY4ru1ARv36l3G52sLtkorpNB+uZO Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpat1nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:04:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BFvLqC004349;
        Mon, 11 Sep 2023 17:04:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5585uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCRVuFvQ+c06lz7sBEQxL/V5IqDx+DBNNpOs6fFvzR1rZoVzvyJYoFzOOEL11E+Z9yZZP4Hcl90FQMhOqLD9GB7077dOyUbGZzAhIFbfFSt+xvJUxMEUsNkB+HSLE24jhH6R13SIClTSevcx5MPceWpTn0v5gM3xqTT326p4+eUbYUhY3gMIAPcojQx0heZFkz/2PFK10ynU3bQJFnp1m5iAhA7rDPpweZ0MQm/ppC6p2ToRdoETVWFv8RFtIQRuESmMcRP4w67XzMQU6rcGS1d/gKxGCsNyFhuW86nXey3oIp2g///HYsMmMTQbhmXTq56dZRuMTlznQF+Mzf0X/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F+PLoOQXbZboOIXkw+RTCdZk9o/Yog7zyanCqEubJg=;
 b=kORmlVCI9VahvizjXN8J0qhK1MByLIp8/8S1BNUazqn94Ilv23xib8dI77YRfiLmuWOSc5Oj8P4prCobgBpM1VCP7a4XTJmBu9QpFAA3Khd+TUl5NGzA2nOgeqMrFDgOz4zhwVEiwI8SZkkBgWo/x3sy9lyuZ6TfIcTr/pOxmmgfmLkLfUySjFIHGWc1iq7s/e1YT3VhuCV/EC81Lmur0tklLqhq2zZAjkZCaisgxMz+bc8GKcyNt3mOTEvUsblyImP1EScsZlY1VNCwAgSMYzi+51l+RtGH/4qxmBgclhDLiw2qTNX59ZJQE+agcXZlamIOcaytHrSnE/8XihrJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+PLoOQXbZboOIXkw+RTCdZk9o/Yog7zyanCqEubJg=;
 b=GjsfFQ9UA6svYU8u5ZXovkTkQZN4xI+pZgbsUec2Exy2LsvogBEshkMxMdDUVgpM+pukOCYxihRPPJ599jf4DKQ0v8RaFT/vDfIZoG/LYsHNDZOCqqD6E9F8x7W1XMxO3HACTxPmz9SP0T5SadjzBE08wJZ/QVpLa47RIbTc6Zw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5255.namprd10.prod.outlook.com (2603:10b6:408:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 17:04:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 17:04:20 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
Date:   Mon, 11 Sep 2023 10:04:17 -0700
Message-ID: <87h6o01w1a.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dbb2a8-72db-4315-1a56-08dbb2e923fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mSpdhV3ROP1gqmsleYM8iVKYmH20s/o0xsKH7omkFgS/VpL+/LyVnRJoAtMcviW5fxXh9yNlXbTCGMPy8gpUw72jHEGgjT4Eit/iw+aKzQz6GsM0JP81RIeql3tP2kxD8yjtUN1jyO1wZlh0+pXENNwat1FdZG0lmDepPS235McyeR2lVjFvZxDcCpOt0bp1VNp947ASPE6WCgulIXg/2XnWFwhftgR984MqaeNNsnbw3CpIXEAVaqJZ6JWkXw3I1Ihz1pushdA8rM0W9xNfE5dZL1OYgYN/wu+IVrNIRbXXTX9GVsuDTdhTpTtetiyH/AqZSAFInjbJSbkuo5kLbfrX1cDCJ+URy/1x7EUG2C4/KDUhc+zXx8Y0XjC62Vm32uSw7ndGCr6JM967YuCVa2NhIgRLbZEdtyrl/D1O2iL8gcLEfbjBb8jCiRIKOIpWzcTRfqdSm7XlZphPRChASnAUM9/76ujHWXqOO1fRGokTyncseFHLORE6347xNRx8bVMhxxqwyFENVnJtulfMWKQcTmQizR0TnSl4/AEv55lwIr1bygvhnqTvqQQPvGk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199024)(1800799009)(186009)(66899024)(83380400001)(2906002)(6506007)(2616005)(6666004)(26005)(86362001)(6486002)(7416002)(6512007)(38100700002)(478600001)(36756003)(5660300002)(4326008)(8676002)(8936002)(66556008)(66476007)(316002)(6916009)(54906003)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6BQO19vbX5X76zB24TSLauB75sgnbI6yRkp/nLEBo3uSUi+G7mBSViGnm7f?=
 =?us-ascii?Q?74jxZoB8VnoyKalYgirXvmdlErypdYoVLOwqSjB/00lkVkC8vXjBivaXogfo?=
 =?us-ascii?Q?UbmucJdJ1X2HbEI3/gIIR5nr2cIVOzcdt5DCe7br7GgB/tXKZLyGSBLDRj1H?=
 =?us-ascii?Q?WLaa5fH/djGYe7I2mETPfHkczA8aVbqFrLPpFd/QNGsBwN4jnnJDU7JALLXj?=
 =?us-ascii?Q?8xvWkDYpgSS03A1RdCxFyGFDNjy/QxPSOmBLQSlwlIAksrbqKKP/tTart+Ri?=
 =?us-ascii?Q?y1z2Wa14mBZCmG3+6jgtir1clMuwvdiFTkDx9WBUpA6qB2aGC6+V2AY4zI02?=
 =?us-ascii?Q?JdS4mVYkkJf+xaELknTU2s2IYEWylKXf8lfB3uW+EhSjiwmI7xuX+NJAejC1?=
 =?us-ascii?Q?SAFvwZj96nRzX9n47bmqnMJ0Rbl47/yORN3kkSSPlFkfz5S5p3JbVfJwD00/?=
 =?us-ascii?Q?eISxfP51aaXyvaygH46wKW+P4D/haJmcDgaZsobyh00lyKht6b1zMgXlKjl4?=
 =?us-ascii?Q?wcjSIqTBtJnSZtxoAMjrPnbkpWg+1Zg0h0gYJGiGYDaYMY7s7YCBx4vVyvCT?=
 =?us-ascii?Q?QCkpHSV1BJ1tH/Lgj7dqtWAeksC0c0mGtkMSNe3KDv6TQd0Rw8MFBfxxw933?=
 =?us-ascii?Q?tEM6uIgpwBWEYp4fE1oG/gDhXTjhfpIsdlarRQsPuK8Uw3TfAUzDWkUMM5fH?=
 =?us-ascii?Q?esq7lKhrG6N4b95b51/x29ZmDrEXokBzd9RSXvOP2rP+f7DaEc5Yy2wOM6nt?=
 =?us-ascii?Q?KOK+qIeZdgLKKHZ4f9r218AWcDrWrYYKtiyVr/1vKUlmttL4OG0clk+uC8SV?=
 =?us-ascii?Q?kig6YZRCn2XwWdN2tAArrAl39Osam/ZuhDLSECmKzEgdfvBsAtZovc6tXKcu?=
 =?us-ascii?Q?YMTmKGvu4pn1I6B2aiAMaSzJR4cOKoj2pffFnlr8BeAaEBuaKAmJgTj//97l?=
 =?us-ascii?Q?9KE/xYEo/h58Xn1EWyHwZvh39TATpv8UwUZaw79N9f1I+ejg/ZwVzuY82TMT?=
 =?us-ascii?Q?cwj/WEdRgL38YCbJwnYgZNZhXbzRvalbVAswMOvzNHBWNKxN5JGKItBVw7Lg?=
 =?us-ascii?Q?uQF2sW57eqKRxZd7Rk5m+cIxIavnFbLOzyD4K7rdVu75P7mlA6ZrlOzFT5j/?=
 =?us-ascii?Q?ad8+nTyot269IpdvITKn+4Jo654M2gEt8qqlvuC8/QDyk5lSjgxxgN1CKVTK?=
 =?us-ascii?Q?g2j8j6RmbLuSuqCCBC/1eH1FPxnrV8wCTJZCsEW5zyJxxscfZhU5obPoROdv?=
 =?us-ascii?Q?alnl0Rh2lVwKzVJW0Viuk0Q3QFmXsNq34t5dCm7TXnFHBI8yHewbGlxJwhKB?=
 =?us-ascii?Q?nBbiMyxqwxvcuEpaBCFWYOU8Bv+vB6fr7/2Wed1VZkNOAOD6NE2aK/VCWngh?=
 =?us-ascii?Q?mJMYlnxuzQ1PXt6QKTjApaCJfNaHiCBLGXoOkzczvr40RZeWbP7VVdiTXx31?=
 =?us-ascii?Q?6DWqbXBiPcF/YhDtYnxWlGpXna3NUQqbaouZCtnDXK+AWm8IaJqFyIjSyQ6E?=
 =?us-ascii?Q?SKqPWWJL+BSFyU/DzNiXhyk4mdK8zqxgkfrUoT7tQIBZJr3l0/oisqiUq+Ez?=
 =?us-ascii?Q?4tgqESf6PIAjBgOfcb1zGes66tx/iqWtBIbx0Hsv4yMWh2vIFHZrBN1n/iUc?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7Vs3XHXRRVqKC0clmQecRPLQutbwId1UCTbw6FY/3C6rK5TkfNeKGLVAxnWi?=
 =?us-ascii?Q?Mva2nYlk3ZeI7iqUPBim7KCyyvAM6PqvDQrwe2llFPPvV5uaV0+/COUEEQLM?=
 =?us-ascii?Q?j21Cxdf+vkYODbrXIR9dYBxwnhUHLyR8uyZk2ek1HnFLFrFBi+ZbWPZGpVc0?=
 =?us-ascii?Q?ctRWUshkNDVsC0AIQbuCSdUwat3G+g9KydnW6rjFfKr4V4zm4xL3jEN8MDGm?=
 =?us-ascii?Q?xs4N2jmWI+sEcUaz62fyBxFGorgyaJ8M/QFAM0D6scElBUv7RTKLmC/pAiOW?=
 =?us-ascii?Q?dlprCbpW0mzSsku9BwXJ8v0njnI+f2MKApV4rPVptwONQClMmN8AHm57peG4?=
 =?us-ascii?Q?X6bsekiCm9Uzy7NhFpDkZflVwxdnZ3NdL0aNPMTj8ajt5ouTsYaH9ArNuj7h?=
 =?us-ascii?Q?jwbRcBCbWao+BCyXc5rEkJAMZRLr5BUh5CxUyTi3nkv92ZfCTWjHdwuM2XdV?=
 =?us-ascii?Q?jO/XHHxC3SGoJNGA7krmiU85zYdigjAEsRbci1+qryfg7HllR/GL2dhsIr9R?=
 =?us-ascii?Q?E/dAUz1N9UlhCSPuzXc/wZQsxKY7iekgdDQNposApPzvTA80+ijuoE2pgCtT?=
 =?us-ascii?Q?YRoU/ctKCdnIMDB905zG/4l0y34zMWjTCakAJ78xejybQHrgxSEjAZn0Tzb7?=
 =?us-ascii?Q?/gKonbsNsezID9xdKHvX4bbO31ByltALuklhyRls7velZq+EJXMUM5wcpbkc?=
 =?us-ascii?Q?IO4+k5zoii0QdvFmobuni8uk1gdcT3nQjrcQeeGPO47YAGQR2esiTg3wrKUE?=
 =?us-ascii?Q?+hcmm4CogltYNMFuu3uaJSNaSn9taz84OAkcMfs+WbqSA2cKPgkI+xuWVHwW?=
 =?us-ascii?Q?OcroTPJlfHm/8SHeqwYzSaktwbjSYqumoVogWepYdf480/GhmBQPU89N5Id+?=
 =?us-ascii?Q?gIp7GtzTkTqpBmDdiH+x2NMY1vGrQqm0a3czWZk5PDOFAsWroQWpOwltrY8e?=
 =?us-ascii?Q?tyAg7DxbJDlWBv+/yc6b3gkw+VLGpTCFs5WT440W+/J39ftUd0i/Gh+AnQ2R?=
 =?us-ascii?Q?7bSNHOFWFV9mehptOhuLxHOeFziXeN9zEM7v6QFbSMIMIPeHRd4Ntm6a7aDi?=
 =?us-ascii?Q?gxM0vf4eSwi7Wo4fxAMJA+hV4ka3EJUQTTe1XM6S9DvJXwtBn90hcQv2UBzs?=
 =?us-ascii?Q?G6c4tsXrehysnAP3w73ItIqtVaaRbyjpaQPyfxx9typSfHXTRjwUD6zq0Qnh?=
 =?us-ascii?Q?HBuhRWNzXi8/F8GcwCp1Ddnug3jAis1n1QG7uQm5lHqs16JX9PVTHofgENE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dbb2a8-72db-4315-1a56-08dbb2e923fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:04:20.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODCjqPyg+SB3SNiEHNa9j5vqz4nYF8qBGlOlLMmsT8syl2cWtD+qw3kI8Yjw0XdrhzQK8LoDcdMPDY6x3jnpSsuNVowKRgXprsOUl/I905U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=783 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110157
X-Proofpoint-GUID: yJVcamvrNA0LgeRQzeVNFlgg29OiEm4v
X-Proofpoint-ORIG-GUID: yJVcamvrNA0LgeRQzeVNFlgg29OiEm4v
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Sep 10, 2023 at 11:32:32AM -0700, Linus Torvalds wrote:
>
>> I was hoping that we'd have some generic way to deal with this where
>> we could just say "this thing is reschedulable", and get rid of - or
>> at least not increasingly add to - the cond_resched() mess.
>
> Isn't that called PREEMPT=y ? That tracks precisely all the constraints
> required to know when/if we can preempt.
>
> The whole voluntary preempt model is basically the traditional
> co-operative preemption model and that fully relies on manual yields.

Yeah, but as Linus says, this means a lot of code is just full of
cond_resched(). For instance a loop the process_huge_page() uses
this pattern:

   for (...) {
       cond_resched();
       clear_page(i);

       cond_resched();
       clear_page(j);
   }

> The problem with the REP prefix (and Xen hypercalls) is that
> they're long running instructions and it becomes fundamentally
> impossible to put a cond_resched() in.
>
>> Yes. I'm starting to think that that the only sane solution is to
>> limit cases that can do this a lot, and the "instruciton pointer
>> region" approach would certainly work.
>
> From a code locality / I-cache POV, I think a sorted list of
> (non overlapping) ranges might be best.

Yeah, agreed. There are a few problems with doing that though.

I was thinking of using a check of this kind to schedule out when
it is executing in this "reschedulable" section:
        !preempt_count() && in_resched_function(regs->rip);

For preemption=full, this should mostly work.
For preemption=voluntary, though this'll only work with out-of-line
locks, not if the lock is inlined.

(Both, should have problems with __this_cpu_* and the like, but
maybe we can handwave that away with sparse/objtool etc.)

How expensive would be always having PREEMPT_COUNT=y?

--
ankur
