Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7EE7E5225
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjKHIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKHIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:48:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BF197
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:48:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A87r0b2028111;
        Wed, 8 Nov 2023 08:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gmN/LgtU9YnENbcYc+CahRj4yVdS/7uPfehrFoI0lRg=;
 b=ThjmLhT+k5Q2liTBZVjf8pW62s6vCG0ClxZ8weYyk0s/SIVxB34vQ8inNSfp8Y+NZUaz
 guJ6KMaMJ5TT+amXuZ68M5VyHtVjTGTj98rqztUJSf5a250efZf63W37mSTv0jG2NaSq
 YdnoRBD56JTFWvfAQysszqQm53MusFKTwx1dZV66la11HGzRWNtZHpWqCJRsgKKX3IHt
 HaBUO5h850IfsIyABuOMVyWFmOjsDK8YyZXmr5Y2egk4m+wjsEKEAL7hV3gcEZihyacO
 knGQdEwzklls0+VqsnAmgErJjDaq4KBt4n2bBikdswWZ7J9/nsAl6nU5rUr1sl2aRNV9 hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w230xvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:47:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88KHDS010945;
        Wed, 8 Nov 2023 08:47:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1ud9rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbR0+zahLcmmH9NIgTISaNxCXZvLcVsS3+F28xMptnnbbgqNiLm8CQWIxEKkm0wV+RX5ftpz/JU8zTcaONDksnx3emNIZj7YieCubcRG/IP7ETR6fm/hyf4rY0qpHQnys3vUFd0MatCIRINtBKA0AuWyPIuVUB+G+H70lbm8GvFZRqSGOT1e06WXs8nYdGhO9Z31KjeHUKlotTntaULC30vG1MMXvzIyPTK/2KxytAN+y0e/Lo1hyFGzvsUCMX79XoQnpDzY9KpJdccDldxdjUlHnuWfbAFZMYOopmOCakaYhCkK1ZKd3RNaKIDk0/Hwiw2z4AHq7dszU+o0j+vb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmN/LgtU9YnENbcYc+CahRj4yVdS/7uPfehrFoI0lRg=;
 b=f9P/eT4VxEZvQsDLYVm6/9nrraAo0XZFTddhJITNMChuXD4wz2q94O+d4Daf+/WOXqCdF7k/GNiDAYrtr1F420s7RpMhp2YJHH5h5qZyWHDVtKZWGcKTxeli+s4q4jopiu9hi+La/82Jm3VrEQprbDzIMNie/tkoprBX6oSPqCltiZ9ngbrJ5LBOgmrkmE72a31ASXHbycv4SV+b/I+wC6PRlRPVo5brU7rSQu+dlkdrIISkW811EQpsJtY2xWJ9aQ7pobus7NU7GeciOHrFa8ej8IyNdKj8DCJbj4wI4/oqzf/xwRDP7FoFkXnTYTRR6NSf0YYO20azcNyHaDnNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmN/LgtU9YnENbcYc+CahRj4yVdS/7uPfehrFoI0lRg=;
 b=rqXf0knJENqS3mRv7fj4NtvOOvg2dXZwEuxgS5MuLJL/zlvuhteb4hNDY5X31/e2D+KyRwPOYex3PEc7mul49sxzqIHuIUHvQJT9Fal9KnLj1jds4pP5iCaQwEqq/rBNy4mmRKk9wCo7SxDIwKIznM3WgNfnjuucqZyCYNqA5qc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Wed, 8 Nov 2023 08:47:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 08:47:35 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-46-ankur.a.arora@oracle.com>
 <20231107190723.2512d900@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com, geert@linux-m68k.org
Subject: Re: [RFC PATCH 45/86] preempt: ARCH_NO_PREEMPT only preempts lazily
In-reply-to: <20231107190723.2512d900@gandalf.local.home>
Date:   Wed, 08 Nov 2023 00:47:33 -0800
Message-ID: <877cmspr6i.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D1A.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: ba43c41f-5f51-4b9b-cca4-08dbe0375a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAaLmU9o+EXTMxwJykH3zXSEK4rLZy2THwSzfG8XiHUFXmYOCSfg8kGwxnFx/YIx5rAPn0PnaQjhP3uAHTzFjK5gjUoYc/gt8PZRvSHJj3W/YEyeWF3TMXwPzP8zxVInqS174bvUO8TD3BYxl8uWQQA9iQNC+wO9Nufby5z5iSYQvsttPmXnbzhHlPOBBGVHW8+gRlkZdpN88tLUmAGFj0cLoQ1WcQTjZE+Jv0vCp0ZHZTjQxUIQ6sXImI1DiYwwmpTdIJZGPfLMVSdfoDrbNC7p0rDrKS7ccC140KzIcYI0Y4MmTV3oXMpuAIHp4Esevg+uw+qaNPvFLoyyBh78z4MoTI3wMIQ7z/VrMVv8AfqWBPSMsHWARDjnQ/8lCBCtIsHqkGpIguuV4HxNLhETSbxZqaKt87xlfnV2g4GfcRu/Yj1+38vtV8YnstnPeyA6Aci3IHqj+msMFhS/Mz3LRJny4yJOPvPXR9j/X9oKkS5t5ep4M7yvHaIBbSbXu8LvCkZD7QsohOyEU1qJI4MYkDiF7SnLFbmGHByvrZ+yfB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(4326008)(5660300002)(41300700001)(8936002)(8676002)(7406005)(7416002)(36756003)(86362001)(26005)(966005)(6486002)(478600001)(2616005)(6506007)(6512007)(66946007)(66476007)(316002)(6916009)(83380400001)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cncDddQyiBY78HQ4GxkKat3vyE/Uc6pihncS84cZrOHoYwwB5bLS4AWTOqqA?=
 =?us-ascii?Q?n0QPB8M4tXsOifBLFUplRaAJ7CM/4zhqK0tzNdjq7p1YRsbBxGqRYNFa/hDS?=
 =?us-ascii?Q?e7cyZluEeXE+/1hgjR3pYLK7424Vuqe1K26ACloTDgXRbZV51GY2Y9+8MJrt?=
 =?us-ascii?Q?1DWihSn+zKD00UaiAT54l9+lDIpOGYlGqktdX/QpybTI3zblOt4S9wL2ieVg?=
 =?us-ascii?Q?n3ZO/0ITo5rFwgTUbbiYcTGYcHeapFQdJbx7BSvxCZiaf/60U6/AUbFN7U8l?=
 =?us-ascii?Q?YDkre/DGvOLzDi04Dqc8Xmzi1vUN3mUoKdwyKuAlKJOReNbALrOszUSWdsLP?=
 =?us-ascii?Q?wxEH2qVqbVinDbLpwwyUZ/KzjuQJj9oV909cp5g6nWwy738QKyY0YHqvZU44?=
 =?us-ascii?Q?YbGc/nJuVezDzJ/cPR+3AzL+16nt621xY6NB6BMIgcWD1aKobL/3pVNk7aLa?=
 =?us-ascii?Q?s7zmryFy3irebSJiZtIoVwdR6G+bdQltdx9Oe8b/9tW0fcO+hQqy7rHd4o0y?=
 =?us-ascii?Q?48iwEWBetCxAiXYQuvK+BYvXefYmgwdxHGIxzQgZeYaFatm/CAHrrbaVrklf?=
 =?us-ascii?Q?+CzoRVvbjiBXOEYPs1YoScDvVPe5sY86he5yTMpMv89NwbFQpslp3cilH6L8?=
 =?us-ascii?Q?jw77cNJk5djBAVMcd8l1DzQYGWE+RP9FlHLoBQpeH7iz3tCN5oIVFI6RcDym?=
 =?us-ascii?Q?jMgeBtiQ+aAtddy1nkQUvQX5jKV1HYZWIRDl23KJb5r9/4MqZx4HaCcLjhY0?=
 =?us-ascii?Q?Y+3Sx2U6U7/LQsnRFTgKOTt/zDUSmtRv39lMM0AP3u//uytdU7tH+dz7+Rhe?=
 =?us-ascii?Q?aERYpfv0HbQ9W2y+a6M0BzEC3czQEVqS3owkdqMDSxQj7TI3afKr29NYnIil?=
 =?us-ascii?Q?TnvW7yUFzjOeleJ6ve8ltFwtOwSaYsHr1Ld95w7YG++R0SXROt+ZfHWSX9wF?=
 =?us-ascii?Q?i2eM98Xoj5cuuDLXZLzENtdHYn2PoH8YbVrowGkKdY3RG8bsaxeaBzLkWFQ2?=
 =?us-ascii?Q?X2aH//uaStQN2icyJHrKQ/bV+zFpPxBuT1e+ejGw9niog4r3PT68DiUaZHUQ?=
 =?us-ascii?Q?I6L5HaBjKdFafKYnlc4qV63r79rvBVXcuN9r4c/nud4T1CHTsl0GEor+iHCk?=
 =?us-ascii?Q?o3Kl56Uxuc9RfxgIL+qMHE9sZOU2Gyfvz9keVQQUIaNVui7Ukom9Y4f8MKK+?=
 =?us-ascii?Q?3MZQIbPqGL0m5C4LBO6mvHhoBay7MSNCTj7G/tz8r1sGcBSiAJdjl7I13NNk?=
 =?us-ascii?Q?b7sRbNBTIGiwFQjzCqF2Vt1TznUdFvkPA3lGX2rvGh0dBv4HqS8Ll07uM9JM?=
 =?us-ascii?Q?1hGGVLMPxQPORKTs4oS1DRDAuvrosyCe7XVW1EHJrC2ZWRlKx60CNG8DldEa?=
 =?us-ascii?Q?2k6ByG8VPvaI//QtJrqUOdAS/CYeHbuofvmPP52d71K/s8b9OKr36cRKNSZw?=
 =?us-ascii?Q?+RTYNvW6QglWJqafxJsQwOrsDm7UuqrwQGtVIKCq+DqK5Uin1CC0gb/kqNQM?=
 =?us-ascii?Q?CEOarvGHrbc9aFl8+Wfio9QVy4maFMklqhWMbfJFzc76fsaheiU1YJwqVcuH?=
 =?us-ascii?Q?F1ZGarAY5KoTsWRd2wbJh9KMUn9XZ6AiphYvwuujWY8XzjgC93MmTKcrcEJ/?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?g7MiomzI5eHWCeB3qzaBQbyxftJnJwcUOwx8wClJfPloGdBh6j2C9AkoV6HZ?=
 =?us-ascii?Q?wQfo3cZE6dXRbRBE9sG7z3Q9yTImnQqKdmT/XB3OUTbelOz9t5pDHXjmhFea?=
 =?us-ascii?Q?X2XtOhwC3UAFPp3dl+QNCfWTz97Sy8HidS2Gvag6h+NhFqNdiSU9fY505uk7?=
 =?us-ascii?Q?1v/2t5/VlSNDPRfhljs8iwXaWuCsVztBeKzG5vxtLnWWoiheqMVxmILIpKYw?=
 =?us-ascii?Q?NkCghA0LEmTUWrRTlGD9ixGOLJuNctoV6nQFMD2s9o1L3RdYTMdwDdnkO47r?=
 =?us-ascii?Q?g+nShgQ32T6eB1ukFsf6A2T8DKiRsFwBrciXNl2SCiJNC/SeYXfMH+hlPVn1?=
 =?us-ascii?Q?6ab2EulvUBcub4GRziVcIk9EiDRMLhOqtUakuQ1CQky2bKU4ljX9dQG2G4rM?=
 =?us-ascii?Q?pnhwXI+ebiY4TzG30Znn4vKsBTqAoX6t2Lex6vKHtglCepLz2HY92O8wE6Kt?=
 =?us-ascii?Q?p7OzpBJWwFNMdWwM8SwPQDinhydFHAE9H6EK0XS3/7H3NzEzgRu1svSTDAp+?=
 =?us-ascii?Q?QLInj9M2qyPA+vLFSKd06dNrWcE8oYvKGDa3O7pKdV08r8MhI6999vtvh7Vl?=
 =?us-ascii?Q?9lU39iXe0t+vUVbIFYJQT7db9FfgJU2LRJY9bbs6zRm4ElX1O/5poKHuXqV5?=
 =?us-ascii?Q?KIlet5WxgSwj512hsCzeVg1zrCVlktSygXDiTFGb3qtjRrXS7cgrax31rVSu?=
 =?us-ascii?Q?4hTzQeHakdIpHAUxmkstoisfLeq1HEn8wan8kbs1BwyVqLbN6cFdoItuBfQa?=
 =?us-ascii?Q?9nraHCRkjioOyXI3POsRTFqjksLlg8Std0DHGjzX2xXNnFUobVwGkpLHzGl8?=
 =?us-ascii?Q?OXnYLRr1TjgPvSU9GnXlKdDRdBf3NRbEFIcluCYfjGP08qPR5cT8Qo6Iulmt?=
 =?us-ascii?Q?VR2MBL1nwHaOUEScU3tnmygN+yxhSLLFb6DQc6YTUuh1GE1MrJ1gVku3EJgz?=
 =?us-ascii?Q?nwRWsfnOE/tFkPJmfVgyOWNwsmRlh2950lsPQr1jWYpmZu6aEO22qluhs2bL?=
 =?us-ascii?Q?DM421Aoi5KAl4JIU5JSk7YCS9d5UjVzcMZXbPuJ0KwshIzr1OFzQLLY/o5dd?=
 =?us-ascii?Q?LkEEYPu0IFlERufyTPj6DBzJnY07htpTE66fSmBMdgfC5tKeA6FDpVVXorEr?=
 =?us-ascii?Q?4x0QvIMFWYSU72rWdzocWibh4606axB3EenoQ9diAnde7PEGx+/KyGMcQwiw?=
 =?us-ascii?Q?OT8N7CxAhYAfJ9YwJdvW2BTcPf8Qmxpzq6Eo2YDaGOj8KvZZNCu4AgFCm5Pw?=
 =?us-ascii?Q?sPf8+AGwEVUPidmMxG074uq5mfh5zdOPqx9c8vu8uSQ+qD1VyM4qYOggF/2B?=
 =?us-ascii?Q?1UzTEhziVZp32lvnFTYpHBmI/zzWWEyoxjA1mCzPEGEo26fQWeI1RnuTAk7V?=
 =?us-ascii?Q?QW0a2+BEjIVXmnJNZx+V5DE9lXSOTeZByLK6SbMbVEh2gzbs8l31G+AysvKE?=
 =?us-ascii?Q?8nn67rfCD7DqcKl6ldJTi1HVekMVkIHK228jBQE3MbnzOJzDd0FgeqGl06FV?=
 =?us-ascii?Q?KtnwqT+/OFrmF20caxmkLMq6xfIeZDl7NnlNmUycx+44DWGxPQYDRxRM+Q?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba43c41f-5f51-4b9b-cca4-08dbe0375a82
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:47:35.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uRRQgTYREVbd6aF7lnNaBRrpf+ZEFQ4UlDxifLE8X5tyWmt2ciKvUum+8N7mqtkHsAefO/GWUP8urfMgXqwN4+bp0S0mBIozMA7I5IMVUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080072
X-Proofpoint-GUID: TlKOhtl0L8jTBPHJRdL_0iDOE4CWF4Yo
X-Proofpoint-ORIG-GUID: TlKOhtl0L8jTBPHJRdL_0iDOE4CWF4Yo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue,  7 Nov 2023 13:57:31 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Note: this commit is badly broken. Only here for discussion.
>>
>> Configurations with ARCH_NO_PREEMPT support preempt_count, but might
>> not be tested well enough under PREEMPTION to support it might not
>> be demarcating the necessary non-preemptible sections.
>>
>> One way to handle this is by limiting them to PREEMPT_NONE mode, not
>> doing any tick enforcement and limiting preemption to happen only at
>> user boundary.
>>
>> Unfortunately, this is only a partial solution because eager
>> rescheduling could still happen (say, due to RCU wanting an
>> expedited quiescent period.) And, because we do not trust the
>> preempt_count accounting, this would mean preemption inside an
>> unmarked critical section.
>
> Is preempt_count accounting really not trust worthy?

I think the concern was that we might not be marking all the sections
that might be non-preemptible.

Plus, given that these archs have always been !preemption, it is
unlikely that they would work without changes. I think basically we
don't have a clue if they work or not since haven't ever been tested.

> That is, if we preempt at preempt_count() going to zero but nowhere else,
> would that work? At least it would create some places that can be resched.

I'm not sure we can be sure. I can imagine places where it should be
preempt_disable() ; spin_lock() ; ... ; spin_unlock(); preempt_enable()
but the preempt_disable/_enable() are MIA.

I think even so it is a pretty good idea. We could decompose
ARCH_NO_PREEMPT into ARCH_NO_PREEMPT_COUNT and ARCH_NO_PREEMPT_IRQ.

And, as you imply, PREEMPTION (or rather PREEMPT_COUNT) only depends
on ARCH_NO_PREEMPT_COUNT, not the ARCH_NO_PREEMPT_IRQ.

And this change might make the task of fixing this simpler since you
would only have to worry about neighborhood and paths leading to
preempt_enable().

 void irqentry_exit_cond_resched(void)
 {
-       if (!preempt_count()) {
+       if (IS_DISABLED(CONFIG_ARCH_NO_PREEMPT_IRQ) && !preempt_count()) {
                /* Sanity check RCU and thread stack */
                rcu_irq_exit_check_preempt();


Geert, if you think it might help I can send out a patch.

> What's the broken part of these archs? The assembly?

Not sure anyone knows. But, assuming m68k is representative of the other
three ARCH_NO_PREEMPT ones (might be better placed, because COLDFIRE m68k
already supports preemption) the patches Geert had sent out add:

 - preempt_enable/_disable() pairs to the cache/tlb flush logic
 - a need-resched check and call to preempt_schedule_irq() in the
   exception return path.

m68k support: https://lore.kernel.org/all/7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org/#t

(The series itself ran into an mmput() bug which might or might not
have anything to do with preemption.)

> If that's the case, as
> long as the generic code has the preempt_count() I would think that would
> be trust worthy. I'm also guessing that in_irq() and friends are still
> reliable.

True.

--
ankur
