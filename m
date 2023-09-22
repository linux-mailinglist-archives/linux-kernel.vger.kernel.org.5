Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04497AB7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjIVRfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:35:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2B99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:35:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGNj3M002149;
        Fri, 22 Sep 2023 17:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jeCqi22iBRROwxq8ZbHYlZ+uawhjS0FukejZoS+7tYg=;
 b=C79krR+J8XT1keFD+vAtGMVm/JEd04hT15BWh7wbqvE7QmIYmK/56oX2OOSkUlIT0exO
 Bdfasd35BIEEdusiui5qmLnIuUBaO3rM6eHXhzdiQF8xZ6QvOeKBsWNblD2p7iVqRI33
 1dOY14wDps962ruM+RWESRnclbUxyQYV67R2sPYp4mxOcJzXWW5L8a47vZplLgHCzxJ8
 e+djyqZb8rSMp7AT18aa7TzMfFBNWls2pAqHmDc0LuhJtyglcPlgwY9hrWPmhoAP81s4
 7yxfqOXxyaklpEIJkm57JvDAh78viRKWv7f9jPsVrPVCN2goBulSBtzYccu+jo8EsHI9 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt02cen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:35:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MH7cqS016785;
        Fri, 22 Sep 2023 17:35:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0vcugq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+FKkyqDuB6E3/y+By+re/ugjyuAgdlisxHHNixaHl8AMr7dr219Dp1aQxFfo+pEXgItffRyB6MF4Cn0y5wJn+NgXmRbO2rH29EPwvFjyD643lFOB9wy6fqDMgfuBVuz+OwHW6Y7IsUb0h9rRIf11Bhfnt/rhB43cxBEt91eQZDOR+qm6RzUpbsHk7AapvF5hwZ7X1Lk4wSt93eiza+z8hSo+28ERJCk6Ymy2klY/japmEkp/b8MjIKTKGlb/CWBzMvpp9yNcFPha4Dkwu2nQbUtIwXCyijlX2F2OtwnnUbF7BQO+nAj7a5E/Gw8ICZmHOTpx//fNFeDQpflW00qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeCqi22iBRROwxq8ZbHYlZ+uawhjS0FukejZoS+7tYg=;
 b=VqohDGIdJiUmggyZP4sRHjAloP84ijRV0wGmmiMhdpgyt7xWOpAAopOFXPoMfDR0q/RXZiOGo4BbjlnkaQ0UrLIxQv8n5RfjoWH/fj29LtdypheQ/0VNCWmfw9MgbMtr30LUN/PL2gZ6ii5s31tRajIs+zwJEa0r9YhEkhsPtNrCDPS/OoUkRLrc307TLAfK8gyufqTRGS+swzVZisZp9g85ib0yKj0qfCd22MleGfChIYiiWw8Ug/fJvUDMU+tTFcqYSxt+ufYCwLp+83Zt0mBUFsc/P4YQGFec+0vfDVQVGf5cvC3rlXR9UdkSY4HU0ulAxuDnXlFzwCUcC0FkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeCqi22iBRROwxq8ZbHYlZ+uawhjS0FukejZoS+7tYg=;
 b=DJAvRwXlZ1xYg0J7Anvh4VUG4N+bHk21r2X/MszjFcTSqdCfKR7QmKvsMFd8il2Td8wSunX3M9w2IZV+XY0s2k7uhRZj/sQz4VQxnR7sfORbpZagRvv/Gy8O0JfcYCsGYMspwNF1nXfRjxKUCfQbFOyKYl1+AekVs+f+CLDI45A=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:35:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:35:17 +0000
Message-ID: <0ec5f56e-6b55-627a-39c0-ff0a1680794d@oracle.com>
Date:   Fri, 22 Sep 2023 12:35:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: c6786419-a262-4260-4c8b-08dbbb924971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XPSSEOfg4PEywCpjYt8fEF8gumkYZozLAAySHfB8wQ/gENOzrZnwovqdnX/JQpxEIKqXLh1Kc6GdvFNFKka/Erl4RtoFdHrf+MZhgZjcb5NV+9deHEEOUlU2THOrnpWnK2cqfWIn0vP/Y3tTvT6RLBSKSukqlkGQ/pL+oLtmR6sETOeyJL//9OcNS4fXa4Bo6XkXR0SEtLXKZ8fg+U8dkYn8Wran/SySpDP/x2OrW+EjqYZhCkHMPKt5r+Go58LcQyLVaAfz+dX0JdFSMp/Odl+z1snnnI68OsSXa/HAiXnqsat9Ixs8iBE/Ia6YazrBZsgXt6UtpGlVjfPBM6Q1Z08XaH9pFBZniKo8Qxw3OEcie2VQaKWtzceNkF5oDDxOdECB/wAdU4jzbEid/vckXni83tmO9P1XYxyZz0qxCxRWyIIhZpmIGObuBG+v7M5CneV5J0S0cqBSQUhVXhj+L9WY4MjFcfpZN9DhAAfZfLZ7g98fsrPQAv2DMTXqITJDHLnHn98xuZdK0i/0JrRDjbkdhm2rvfqvIUAut1CaWOJ30j6/72bjJShquMs4dHAV++qabctwoLe7PyzvCSWQ5Go6jKbfpuSRgHXPfHePey6ry4kzbC0w+4oX+bcuDk6nQBw3kHR8vjb1fTUgSpB+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(31686004)(38100700002)(53546011)(6486002)(6506007)(36756003)(86362001)(31696002)(26005)(2906002)(6512007)(478600001)(83380400001)(966005)(6666004)(2616005)(8676002)(8936002)(4326008)(41300700001)(5660300002)(66476007)(66946007)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNrZ0NOSXdaLyt3YnQzTHUzL1c5b2cyd1JOZnV5THRBVmlLYWFsNGlJOVJl?=
 =?utf-8?B?b09oQmFHMUJ4cmFNRGhsYTNERHgwZ1l4MnFzUzlHV0N6ZFQzeWJHK1BlcTUw?=
 =?utf-8?B?QXNsTzdtbllGTVpJU2R6TDRldnR2aG9jblpKelAyUklQRmZNT0h2K2lSZzdr?=
 =?utf-8?B?dU1GSHB1VnlMaFl1ZDZXQThWaUVydmI3dnVpTlFvY0p5TjRMUkpkbmFUcmN6?=
 =?utf-8?B?SGtQbFJHSkY0T2s3aFpIRzZSTkFnTnZFZU4xTklHQkI5RHpJVVZQS1AxT0JZ?=
 =?utf-8?B?N3REdHE4aTA5UjFnbTFBeWJWMjI0NG1tVDZFRWc4cHZHMjd5bjd0bTZqUTQ2?=
 =?utf-8?B?em9kZDc2dlNvbHBWRTIvNHJ4aXZFK0ZjUmNuZUNSMXNDenkxN2s4VklaVjBG?=
 =?utf-8?B?VWY4d1JvekhRRzdkbEhOeEJZTEhYak9TNk5Oc0RhNzhybmR1SUk2QjJ5YWdp?=
 =?utf-8?B?MitibDVuY1RLalh3V1pxVWR4LzJZQzFBWU5MMEhLSzh3ZGV2U0RUeDlsK2JT?=
 =?utf-8?B?eXoveXE4YjZRWXRsZUZzeWcxVTlzdmZjTm9PZ0tMTGZYdnl0d1VVR3F4Rmty?=
 =?utf-8?B?OEw0Zm9nKythbjBFWmp2Z3Z3YjFOVk1uZE9XeXI3UGlqK25tLzNuUFVkMTU2?=
 =?utf-8?B?UVJUVFEyVDFmU05hT1BDak1ib0FXSDZaTG00NlY4VEpzTStHSW5uTnJIejFP?=
 =?utf-8?B?OTVYaTcvR1B4UGpWSEVZa3UwdytaTEJMV2tpRzk0M1cxS1FZeVBTRUhabzMw?=
 =?utf-8?B?bTRjdkV1WmluRDZEdlljRnI1M21RSEtNejdkK2hlSXp4YlNKM1VoWUVoTmpo?=
 =?utf-8?B?M3ZVUEQ1V2YySW9pYVNMVjI2OVRVMFEzME1MeFJLdW5zekc5WVJmSUt0dFBY?=
 =?utf-8?B?cGhMNWJER29ZUUdaRWFJUmloajlHdThpNU1peVI4ak0zNFlhUCtzU3hZdkk4?=
 =?utf-8?B?RU50dlpLZ3VYZGx4WDc4dDk3ak0xckZRNUxDWGkzNXNtdW5Ld09EbGFqQVlH?=
 =?utf-8?B?enF1UjVPZHh2dGJJQlI2NmlHdDV4MkViZHRoTEhYcUlSUFQ3bnBjM0JVUzYr?=
 =?utf-8?B?SlVBc3htQTR6aG5VMG9aY0FYTFl0WnVHeDVWcFEzaW1tVzhRWmdZQm9wQW0y?=
 =?utf-8?B?eThMSTdiUHMrNmxja2xPSi8yTE11Wkg2SERCUWQwaTFTRUpnVVJYVWlzWDNY?=
 =?utf-8?B?WTRrdjR4QXppYXRHSE5JK0Z2c0RtdWpJbUdjVXpTQUxZSGd6bmpzZG56UlJ0?=
 =?utf-8?B?enBjQVVUN2pnbHppVmlvV3RHYXcyTDU3bjdONUtWOStrTnQwV2dJV3p6VCtV?=
 =?utf-8?B?Ymo4Y0dTVlFzWjhyZjRsK2VPNDc5SzhjNGYzaS9RR29vWG92TWV0clRlZXgz?=
 =?utf-8?B?aTJvd1M4bzNpRjZlMEJtcGl1VjA2cDdveVIwWm1ERlIzM2VhUmxPenBhNzIy?=
 =?utf-8?B?NmtCSGxHN2FVTk5nbWVEbzd0bG1XWXdMajdTc0ZxSk5POURhTHQ2a3ZqcFFi?=
 =?utf-8?B?RVFxdUVFNXFLZy92RDg4UlNFNFZWQWZzaUc1b2loZEVvNkxGVndCeG4waWw2?=
 =?utf-8?B?Um83LzZLSTlMOHhCRzVjbVQzTUJEeEpDMDBRM040c1Zqc0YrVGFUd3NLRmJa?=
 =?utf-8?B?dmtYbi9oZmhzNmRSSlBFR0l1UTNVU2pQZk02UlRuOHBPL0N1KzIzWUI4Smlo?=
 =?utf-8?B?eGFQNzh1aSt4Y043Zy9sdTJXb0RCTEtLQ2dWYm12UHBLSEVMQjgrc2h2djUz?=
 =?utf-8?B?MmFzN1I4bVY1NnVYTmNZVlNPckh3dktYR3BjK0lmWGc3VFkyY0I0L3NoWFNi?=
 =?utf-8?B?Y1ZIamREVWpGVWlQR21qZTVuM3hubGZ6UGE5SktId0JBYUpFZGhWV0ZRaGts?=
 =?utf-8?B?WFhacTd1M3pQVlhFaWk2N05MeERVRzhsUkxuUTBxU2szUytEdzYzNnMzeGcr?=
 =?utf-8?B?Q1dQdnVxYnR4RUpPb2pUNlM2ejJ4Wk5tWFpnTERoQjVldkFyTEVvMVAwRzBH?=
 =?utf-8?B?QzkxTXBQMDFJSTlTSmwzalV5SzRnU2VCZkQvWHozNTR1SFhXQlVNYWJsZlJj?=
 =?utf-8?B?VHRaRUdXUlJyaCs2Smp6Rm5WdXZWY2hBUkFFM0FhdVBmTDd1bHgyVzJldTIx?=
 =?utf-8?B?Qk54T25PNGFtTkVUdXExKzN1bzEvRXI3TlA2eFFXV2k5bXNYTVArUnNkK1Nj?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UXVkRi9KN0Q0cTF1dEprOWJacE9DdkQ0SEFwZmdmSW05eEVxTGxqblg0SDlU?=
 =?utf-8?B?N2gvK1NGbXphZlR5WXRIdXFFNVlnK2YzemZqVE53ZmlGOTdoVTZaN1hSVjRG?=
 =?utf-8?B?RHRzcTFqV2FlVDhJUFYzS29vMzhYWXNlWXBaRlBzMW5SV0hvMmZNbk4yZkt3?=
 =?utf-8?B?T3FrUTlCam9HN0dnMVJPcCs3cjE4VWRHY1FiN29aQURuQkFNM1N6eTRCL0ZS?=
 =?utf-8?B?RUVYK0RGeUhNek54SEdoQmxmR1dzcHAyNHV6R01UVHVzRVppKzMvK0FWY0Nw?=
 =?utf-8?B?cHppVUN3ZnBPaU5yTUNTUnZIMytxVmlzK1RQRE5kbWwzWDhtSm5nSXcrQklE?=
 =?utf-8?B?UklNREhHaTNlb1dNMkdVY0dzSjhieENFUmVkWG5udjFoY3ZGd2lhaHFYcHlX?=
 =?utf-8?B?NkUxR3BiaTduQmhHWUJhWEVScjY5N1BhWXh5Z3BiVWF5bjhMSlhOWEF2Sy9G?=
 =?utf-8?B?YUwvMDhMQ285M1Q5NHRwRjlUQnd3dnNMaEFHU3hFRVpyQUxrenVUMDBoUC84?=
 =?utf-8?B?SVVwRUNGRnd4aVhaZEpLbWxNaUFuNEFkZjBOTkoyMnpzNks0YVBHVFpaNlQ5?=
 =?utf-8?B?Q3VDNTdaRUxYYUFtbjRjOUVxZ1FTZmt3VGxFQUZhY2pTWDV3MG1ZM0hsUUV1?=
 =?utf-8?B?Sy9DN3RSR2pXM2UyWk9QZFJ2NnBZb3JvbEFKcXNFeXJxYUZzWUVPSnRlWTVw?=
 =?utf-8?B?NUNPdVpyRzh1TzB2bkl0OENLY2E0aTlFZUNpRDREMkttU2hFN0RXenZubG1Z?=
 =?utf-8?B?WHhEMEdmcXQvaE9ML0owM0dMMmYzZkFOc28wMndGV0FPd0JXeE9rQ3pZWUJh?=
 =?utf-8?B?aWtMTnRsYTlpTnAyVDJQeTNNeEh0aXlWbXJ2Vnl5aU42bkdxZzZsd2loUUls?=
 =?utf-8?B?WE5MampJTmZGSmlWZFUwNjFGMEw3bnZmOTFpYmQ0Q0cyaW8yQ01zR2tVSUIv?=
 =?utf-8?B?SzRQR3dmSVgyWHBYOVFPbUYxK3VsWUpVOHpkRmthUEFhZ0ViLzVJZEsrUkV2?=
 =?utf-8?B?NktRUU9xeDJRSGQ1Q3RZNjdRajJGQTNmRFRLMTJGdWVFTGdKeWlDRW1HalVH?=
 =?utf-8?B?L0cxcVlqUmN2bStwcXlpMld3ellLT2lNUUFQSGtyOHFwcTc2cEJWNzBPQ2cw?=
 =?utf-8?B?elBOWjd6Y08xUW45MTNlRTlRSXkvWDNHMHFORVdVK2dTSXpuNHVPcFZHTUJl?=
 =?utf-8?B?aWRjRk1YYjAwMi82ZElkTEJmcGp6VFhvbXhLM3AvNDJxNmlNVGdSOCtzOHIw?=
 =?utf-8?B?VWk0VDE3ZVNRcVZGK0J5REJta29ocjV1Tno0dE1ETlBmbUdKZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6786419-a262-4260-4c8b-08dbbb924971
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:35:17.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txN3wxg1gpGdpQtc9jg3Hhea0TaQFV7ZxZMbYFtm9a6qJVxnJHduK+e593i/cY+heJfcmQC0kwzk/pgkCLdcrUtU/oEfsisF+iNfnFUrsl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=808
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220151
X-Proofpoint-GUID: WE9P_h036LAAteAKXVvYW3LDxE1kHhfN
X-Proofpoint-ORIG-GUID: WE9P_h036LAAteAKXVvYW3LDxE1kHhfN
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:28, Valentin Schneider wrote:
> On 21/09/23 17:59, Eric DeVolder wrote:
>> The design decision to use the atomic lock is described in the comment
>> from kexec_internal.h, cited above. However, examining the code of
>> __crash_kexec():
>>
>>          if (kexec_trylock()) {
>>                  if (kexec_crash_image) {
>>                          ...
>>                  }
>>                  kexec_unlock();
>>          }
>>
>> reveals that the use of kexec_trylock() here is actually a "best effort"
>> due to the atomic lock.  This atomic lock, prior to crash hotplug,
>> would almost always be assured (another kexec syscall could hold the lock
>> and prevent this, but that is about it).
>>
>> So at the point where the capture kernel would be invoked, if the lock
>> is not obtained, then kdump doesn't occur.
>>
>> It is possible to instead use a mutex with proper waiting, and utilize
>> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
>> mutex then avoids all the lock acquisition problems that were revealed
>> by the crash hotplug activity.
>>
> 
> @Dave thanks for the Cc, I'd have missed this otherwise.
> 
> 
> Prior to the atomic thingie, we actually had a mutex and did
> mutex_trylock() in __crash_kexec(). I'm a bit confused as this looks like a
> revert of
>    05c6257433b7 ("panic, kexec: make __crash_kexec() NMI safe")
> with just the helpers kept in - this doesn't seem to address any of the
> original issues regarding NMIs?
> 
> Sebastian raised some good points in [1] regarding these issues.
> The main hurdle pointed out there is, if we end up in the slowpath during
> the unlock, then we can can up acquiring the ->wait_lock which isn't NMI
> safe.
> 
> This is even worse on PREEMPT_RT, as both trylock and the unlock can end up
> acquiring the ->wait_lock.
> 
> [1]: https://lore.kernel.org/all/YqyZ%2FUf14qkYtMDX@linutronix.de/
> 
Having reviewed the references, it would seem that Baoquan's approach of a new
lock to handle the hotplug activity is the way to go?
Eric
