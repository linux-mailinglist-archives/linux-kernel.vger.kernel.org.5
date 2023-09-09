Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A0799AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjIIUGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:06:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7493312C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:05:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389Jiw3D019560;
        Sat, 9 Sep 2023 20:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Q7snCupmCnachINuqPlqBeO5HFlSxM32577Vznl7O04=;
 b=zTTlM3AioU9Cs4sqx+Vq679wor+gkEN/69pKmfTQlpJVSaUrebscsfo9+HxfKqMBDnu1
 p2HxqkDDHBTtBvjC9qPDjnyptdEJyW08STj0fUp++3MQOxifsntA12hcApHmjyXDRMol
 XwvNlG1oEX2UXDQqa+umwlm+0akCzvUuuUd7kocVcGSZWYU1IlNC3fpGBIeT59kzuQJW
 P9+Y6c0LtVeBHt+3698q+Pt2xfYNQKFb2Yt78j8vJ3ozwMMroTcRIJ2wamw4y8WubW/c
 HGlQKVRw/lzgpHvNuTULMwdhwWlrxH65Di82V9Ed6s+JchPzBjh3RrJhrbcTMVauIFzn ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0y4jg0rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 20:04:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 389HxXrA033080;
        Sat, 9 Sep 2023 20:04:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkc1u4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 20:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grQ1Sa7zHC5AlQKmr8anJzQh8/QA3cgLuLWAutIEkoYz8/GfZXktwEvgIyxbJu6YItaJ72VBVloJ3tp6/mB4Re7wBqwF3j+/Up60B3EZJfDWZy7ZrVqMfbFZIsX/uwsaEz+a223HJ7AOcojMiW0V5k34qD28AJ2WlWo04lAaJF3+iY9FnJ1u7JgfbB9qCPBE1bVMOAxWa9yiXBsCxcPC70fN+vMGeV0IUwJXys74SXYoSRplugRrRk/+KiwAAx81A/0Os8WuClP/5UuLVktG0G5WATNorJ9bpXPxJcOvdy1ja9bwfsoB/0mh7gs68aDl0ZlcywZc6CnIzLjNgWnRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7snCupmCnachINuqPlqBeO5HFlSxM32577Vznl7O04=;
 b=bKKahZxRBx1Ttu2/bvi5SetuDWoyW7SzZvB4kWUqkzyNT+BELweS74wNC1yyzqmWujb8TyD1SPz8ZbinuLHHU7LYqlh49QsIPP4qHJ01QY6x/N9ayg44sIWFcCwEYQks1CDFQgQyQ4gfmQAdMofoEptQx/nx3we7pKoHS8O+s0rodCF3QTpcPLUwhBuvH38iMBANUH1lrNP7RXJ4cPQd+7YicOi3QvQUW1kiPNHX7yaYKV65vo89TzdQnHc8bBvC7ko+lT42ZczBhwVYbByA4m4zPHob8nx3xxRMkICoSdRMXb3prsq/d4W5d44EN4+cnIhCWJsqBRUZXkfZI+/tuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7snCupmCnachINuqPlqBeO5HFlSxM32577Vznl7O04=;
 b=bnYbUrDwQlqsom/1MyOIfkvHLMULhobPTQHLiVlMS5w9mJw+CGclZRz4swx+lr8TrfQ6NeZfJ5Pb3ZWzYZ2WYje/3Kqpe6O8VxndQIeuIjvQnuC8sMLwcuAJp5+a3fI3nFR/aCM35R+xdcSHsCzKG0NZRtqcV3dLqOKnZvD+nKc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4297.namprd10.prod.outlook.com (2603:10b6:5:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Sat, 9 Sep
 2023 20:04:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 20:04:53 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
 <20230908225018.GB32012@noisy.programming.kicks-ass.net>
 <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
 <87sf7n6ea4.fsf@oracle.com>
 <20230909091104.GA2771@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <20230909091104.GA2771@noisy.programming.kicks-ass.net>
Date:   Sat, 09 Sep 2023 13:04:49 -0700
Message-ID: <878r9f5d0e.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5fd19f-3b12-40b6-8098-08dbb1700846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiQfs4zIY221YZDqidpva9c5x9oFRmPv42VYbN9BmJHFNulVAYfasfXHwfj4ijfsmpnjkz40hxjlv5GO9nRJfmVAux60C/nr7UdoUHzXyhMgOaCI8fcfUfLkhp7sywNWJWRHnjDAAbTw2CWsu1HgVxKriuX5oi3OG8KAn5dzG5gZiSE33T7SXIN/s3ZI0g23nDwySGnbvAhdHErCEfM/ED/WMcVvcpdSffCIlhLyXf2btuzg8EPUoR4hxpweVc6JR3Tk3oo89LJe0VU5tNFCub6saValZLjXdE/A4skTV50qN+1mjaMgN3sRp37eYme4aw+NrIbgOtes01LP6i4vrguiDCXo1ZVcKzzg3D9vfXDOtzupDaMYF5CkJA4JjO451wbkYR+QdhTiNya6Jxs6mWEWHhdzDcoZOz6A9gwYLehXo1shM1g4GGX+at/QydquONPBKXKYsBtSlk3Px9dABOdi0wyA5tqjbfvOBdQRZVSSEWwy6mcufenR3DGCd35gyefxvDxclJkpkskSk+lmrHKXyduqYy88EBZzPOypna1SrhsOjlVZNlpS4XWgX+km
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(86362001)(38100700002)(36756003)(2616005)(107886003)(26005)(316002)(6916009)(7416002)(41300700001)(2906002)(8676002)(4744005)(4326008)(54906003)(66556008)(66476007)(66946007)(8936002)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBEZYx78hVenK/iqvZ9tKgUMQLPapWhal7Kg1XjDgqAmOC18hZ7j4AsVe11H?=
 =?us-ascii?Q?Q2C6+i4kh6cj9CIAygK1iURJcIsUZ/19x30cCjWnCrGUVy5ZLi+q2UGqc5kN?=
 =?us-ascii?Q?ctJLdB9+7VLCfma6FvwUN//cM5r5UkACVM/A/qYcBZL2jbR+FynKafHS9o+b?=
 =?us-ascii?Q?JBVBE7EUXvQ4jb/xDkdeDUl1Co5GWhy+rrrrVfacMxj6fy9ljn3FVFpeKmkd?=
 =?us-ascii?Q?+OpC82OLeB0hZJwBM9gmImJq07KpjHsumRtOvPYi5YAxX3/MC1wh5gzcNLNk?=
 =?us-ascii?Q?NImcCc/J0WwK0+QQS4ZXq90rcNEax6F0gYzfnCfVHsBzaj4LHhxCPesuKGvg?=
 =?us-ascii?Q?Q8OeeEuHT39nUQsolXvGKw6muo1o4c+jz7ThK+eQWMELa1UvayRKIczdtBhm?=
 =?us-ascii?Q?QpawkpWpBMjPW/8wU5xhllwmO/yQXLgrSrO+5TW82rq6jkmvqFT8JzJ8BIAF?=
 =?us-ascii?Q?peCnctEhPMwimZuNrJI94CiT4WaRkWkepWIr8yWmK/JNmPlOMjxBwvwJ1byR?=
 =?us-ascii?Q?pWM8AfH/WcfHlqp7cgX8Yq8tcgnVZtWyn+UwT4u+uCIjwl9DgoHUO2MAfhps?=
 =?us-ascii?Q?ItmAAfVM7wzMYef2XT9d7QcdysborHknWP/MIDLSoQDfj1ivb6jRiOCHVQYE?=
 =?us-ascii?Q?St/52xVDuN2rGGOtWP94MdozxUW2Lvi6JSNBf0v8X3glPpYwA/qCMvHF/E7q?=
 =?us-ascii?Q?L+XFfnEdHTf0sA2P5GLWF1G6bBWjEj0yQKxbhJM68eoZ3WNq62dRgu1WGhsW?=
 =?us-ascii?Q?wQ0xGJLDKXD72RfGVNR/vbzhgRuAxzU/Rb4rq2jGPJy/IycVVsgYYmnA5t1u?=
 =?us-ascii?Q?XbIC/VQBlYg8AQ5/3aA77VaHyiVETdVt5k51Z+VdOHjgHA/TujqACfckYp+N?=
 =?us-ascii?Q?5eQh+V8RBSYuCuPzevr5jpFifFnDBeHql6i7s+f/Q9oXv8WXDU03sB7a2/fg?=
 =?us-ascii?Q?tFFHIwMAaYiLGMqgdrvnZ5JnIAjr5teW6gaNUuWpesABrWQToo/mNaMzZPo7?=
 =?us-ascii?Q?0xLQlhZjH/1m9bpEaG83m15ywYJtAvWGJ12QTUF+rInWdFrNRXYiofC2BaQx?=
 =?us-ascii?Q?QCYZh0h25d88weLSCaqwhVT9AJ0ZmDHg5MixZcwigsyIECM9mHYEzC7PqS43?=
 =?us-ascii?Q?rcjiZ5HI/XJMk5ODqXZaMByuYy4UnpHu2Dive7uaGG6qx2Y+YhXo7JjE7hjW?=
 =?us-ascii?Q?u/VMmmxEJtreRXqtlVXw85iCLptuVlhNkebwBc2RCK55Yf35dQmHjN8+IqOO?=
 =?us-ascii?Q?MA+f+ki6Ki35GsF7TJ4MrZQYJif5j/ICPNXqSETi7ffvuQo6CXw39hkp5n/B?=
 =?us-ascii?Q?6JGaszkOaTBhL4253/SA763rDAFcKoJJfkQZdvWoHg1N2/bvFTKAemIaAz8E?=
 =?us-ascii?Q?aKlzjr5+wznr2vI1Wa2fr5WhNnN7pp9/viL648hFJZoGybxD9C+BIM+c4WSy?=
 =?us-ascii?Q?J77UeTxzz+jJAdllYAa2i1LkGxqon2jBdDwj0FpzVrcfrAiszH4mwfm8SBEQ?=
 =?us-ascii?Q?6La4jEvrmyn6u1dF+Fp+xhtZPxdlL0ZrFc04evG8Tt5uf4c9NYo5M+Cel/MN?=
 =?us-ascii?Q?FPi3qDpK8z5hnzkwQY4D+joSmd4x5yrzNvPXhUt1TLH+x72EFDmdu4KxI9PR?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ob8CTX2iO9VQCqUCIz5iY6/q8N/LF2/wufYaPeyPQGBPeo1SzImK0B1Cd1cf?=
 =?us-ascii?Q?C6bhHvJ9jErpBK6mydA6YMTMsYIIvPNK5Rnb0sZ/dzx3q2bzlONFI52+HlNc?=
 =?us-ascii?Q?DFAVGse0hMprJrqyH+owMpE67vPoDLPCxDaYNjvgUhkxVLwW++u/imWmXwck?=
 =?us-ascii?Q?TsJ0L1MqmwjntbWmYzhndZBOQijZ9Obx4txD3lni/mlRX2u1lVTk0SXzQnvp?=
 =?us-ascii?Q?RkfFmb+si6zSIIDzN2CI/PcERLluhyXQHDccqcye6CEj76sKqR1qR+Bfygq4?=
 =?us-ascii?Q?SPuls23a8RVYabjUYzNyI16Zmn6qvwbfh311zl2e8wgVgxgSjabrwVJklcSt?=
 =?us-ascii?Q?AT1KSETWMsXi9nSNHWZfh4lGkCep00HnL9vBOXQ71gZABYosDibAp65QWoQt?=
 =?us-ascii?Q?pKKlPksi8fXIaWOjXYyxN5QBFj2UkEicgoADQ7Q+LyPonMdl46ULahNAR74a?=
 =?us-ascii?Q?LPfyomCxddkaeuJYewJn6I/1zKqhwpYHXLztdvz1ZbXt48S1eBhj7m+4vIFM?=
 =?us-ascii?Q?+WnTyF03r+z8bLEoMVjTVwvvsajkhLUswKO5f5HB4Zo6exwkAEUKzT/heITw?=
 =?us-ascii?Q?KzDHN1X2mlYLh6OVXhN45mWA5rsSlxWoBDmSfwQKJh4EU9d/Nc+0ECZ7U/pK?=
 =?us-ascii?Q?yUPqG1nyolubTeL/eAKcca6Z+W4CQIwx2pQOdyfnv9Hw2Ermjz/PuGJDst3+?=
 =?us-ascii?Q?W8FjPiNIvAV84DOEFcqvMF7JmJgmq0sVhF89SsUQtIW8ZnjgV8miQXPZgq4V?=
 =?us-ascii?Q?zu8CkPJBWKRZYiYpOp25ZE+otNOsAyQCnc+jMhNXUhzqdsFHyddNKaziNig3?=
 =?us-ascii?Q?o3kBrN7nZzoZHDcGR+tf+/nyybA3c7C3vzbwHGyEzl4s3E2ApUZVhcc7KTlH?=
 =?us-ascii?Q?IeDrybyjLaMHjsvGdjVa4Vo2WwFbdkAmJBviRKY79lUnPsR0Z+mFxzEy8VzH?=
 =?us-ascii?Q?DnVOqq3lgtLLPDzj559zYK/z3zopEopGFeaJHbMJOcPdrI8AdtyZK/pcZeNC?=
 =?us-ascii?Q?pgu2azITWDGX4AK/ljONN1aX4Ua07LVzgQfR4iUMMeeXlhMYVs2JTLXz25/2?=
 =?us-ascii?Q?OViQqzF48fSOEVse5ESklJ+vhyHMvp5dKdr+VKr9OlssWWlDHbZifAKwDu4D?=
 =?us-ascii?Q?DEieJiGUjmE8XE2mBAng1PEmLaQ3bgkhvGJ+g0D+T4p57rXEumfRXXE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5fd19f-3b12-40b6-8098-08dbb1700846
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 20:04:53.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/K6TBSyp3z7+kvCj6BRfrGPhwV1Czkr8z/3sm4WW985cLJpvn3rKzsTRBn+ZQdx+WM4JBO3k65beQvc4dvh3Gl77uIL1VpgH7R2aFDD4+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=463 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090185
X-Proofpoint-ORIG-GUID: qcjMijoCgzKMR7i-GPJ4akb3btCktSwO
X-Proofpoint-GUID: qcjMijoCgzKMR7i-GPJ4akb3btCktSwO
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

> On Fri, Sep 08, 2023 at 11:39:47PM -0700, Ankur Arora wrote:
>
>> Yeah, exactly. Though, not even a single context level, but a flag
>> attached to a single context at the process level only. Using
>> preempt_count() == 0 as the preemption boundary.
>>
>> However, this has a problem with the PREEMPT_COUNT=n case because that
>> doesn't have a preemption boundary.
>
> So, with a little sleep, the nested exception/interrupt case should be
> good, irqenrty_enter() / irqentry_nmi_enter() unconditionally increment
> preempt_count with HARDIRQ_OFFSET / NMI_OFFSET.
>
> So while regular preempt_{dis,en}able() will turn into a NOP, the entry
> code *will* continue to increment preempt_count.

Right, I was talking about the regular preempt_disable()/_enable() that
will turn into a NOP with PREEMPT_COUNT=n.

Actually, let me reply to the mail where you had described this case.

--
ankur
