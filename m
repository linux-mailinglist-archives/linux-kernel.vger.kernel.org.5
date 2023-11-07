Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC47E4C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbjKGXKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjKGXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A991734
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmFg022703;
        Tue, 7 Nov 2023 23:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=e+4zv7VYR1UlX5N5Hx/yjD4vss2V14z/S60uvxadF9s=;
 b=MH0HRCoym72SZAN8Tu9Vh9LhzwbAgRU5qvdLEfB3A0KXa/X29pyzRJTYzT5HnYPY64ow
 3NitHrWaEZLtKWSfMthSvzZ7vrJSLfsWThzJmWqX3piUAZyO53OpyLKVtldRF5c54z7u
 VdZ3RvbqGT/kuIq0DobDDk69e1B6jEpvHKPO34ECk+SPt4/wqcIvKUIWpLx5l3+EIC1z
 jgtf6N74dgaMGiXhSXgshnIxJZuHUYPNiJdDM7kKQHa+nHUX+/HpkIK+bhuB8LLIx9L+
 K/TMkBAw1lcjpVm7BgwsENUx80c6E2g8XudJPBzB7kbMqT0vczy1NEJ23tdT90K/ybeB KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N31DG000659;
        Tue, 7 Nov 2023 23:09:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvdcg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD6u/XlDjYAr/AlZclfsW70HO1R4Pdf9SNyFpSgk9zy12mvL9ToniGe6KmMptJi5IM4eweJKCDSbuxv065C7bPmKTjY/CcnyxnO0Zb4mzrZpgcfrFruSEDeTcSRW3VBQBXZm8l3YzyiNRLnjRwCU44mZK/Q4j8ezfNo6Ww/OismXwOxExdzyrJbbPt47ZVMZUyFYn0EOa5IOqwpNELbsQDjBLelr/mw1ECOh8HLoiikUDpfGdTWEKgLkIMcfEt6DdbyhgVLtaC5zza8eJ/XarygPMaTuoyXqjnLfer7HTWWPxgjc1a4OeIki3mCzdgxzN35aylZ6H+jRtIVl2witfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+4zv7VYR1UlX5N5Hx/yjD4vss2V14z/S60uvxadF9s=;
 b=XF7av1PbQNVUuG49QD9ANOViMTD4q74ShtfgKiK1/c5ydW5Sb4JY2XxEKkwVNlUIf4/1QnOjhZD2d6I8jCyKmOEnN/XdSgQ41dcSBVCfBsLmqbkxYBnMQEgxCAYXLTmXu8uT55eH5cI7JrAf0w0FVDqtm+MeJn8fvfyK4emLkiRO5Sd2SgHzdxy+Mcz3U5Ck0F5naJ3m2mpjwnoERqi1kwti5wOxsK/h32G0TZksP6L/9iU5XQoLVji/jQLyBfYbG+F6cRYBsTYKsWIOIBhXC8ajq0hK/vUKEO+MJ6BG55wKUB6fCpTpNMFDeEsdhiTvpk/c02p6gbh0Kf+6wRYGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+4zv7VYR1UlX5N5Hx/yjD4vss2V14z/S60uvxadF9s=;
 b=JA4xJtbb1YlHwQyM9B9xspn9pzjVIMq/0yqQiPh3DZYeO8dvHyIQIatYLwAMYFBU3JCOBBwPyPpf3DdVgzOmUNGuF9vD1Y7UsXt4uHXHEmCi/IrdZk2MoT1St6dj8jCsnTjgT0w0IE08zxfpGpUv/YqvnfppfCJkqXpPQfi+vGo=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:07 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:07 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Manfred Spraul <manfred@colorfullife.com>,
        Jann Horn <jannh@google.com>
Subject: [RFC PATCH 70/86] treewide: ipc: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:06 -0800
Message-Id: <20231107230822.371443-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::36) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a39acdc-a74f-4b56-a18c-08dbdfe68b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67sYNLUr9GcqGGEGR6e6inROk8JB8QB/vU9y1Cj4yo8DICoh6nj6HFb1e7yNY0d+h8QkFdPJ1EnRHy+3AM/Cnn84Q4Mx7Y2Xx86vBya1Qi3YFy65Z5YLbBTNGHdHWWY09mJB6Ztxd1Nb5EI/TVDQ87G5HjVmG9DjNlmOLlkqiDgnEKoo2+ey04WjiR61Psr0TokBIGHDSS4nEsnAEbH2gb+88gpRu6hz75Mt36vy0mQwtZkOdWPB7frEmeFv3B6nA0Sb9MgKQosB5yH5NsNq+v3VVJBeQbfbpLQH2MDUlJhscq8ldlB/5TDDJpHAxaEOs7u2vrq8krhppk+BK1oExeRywI/AyuQ3NP+N/+SQxKc8ppajyt3NaBrPC0LxePdos1/bgkjm2q48hgOHw7K+AnhkYXaS4hzMTVZAsOMhhIH57GDkyg9ihptJg7UCKrLrFYBoA4GSQ0iaVsHNerT93zXqDi7mT4Gd23B2Im2uwwfaUM7co7WitQUrFkrhg1LK3HTYW4Mzpz6ao83nSiFAoubgONTi0SQSTWToDxOZK4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BiwhxQ420BiPPR0xiVv2/tYF+aU1vmlyFai9QBoY8LQcVCzs2DV4eg2J+QLB?=
 =?us-ascii?Q?Jn2omzbX9sQnKmodzOD0wqR7v24Ld8d/5lt+IIAb8eZq132/3IfHADuj0aXS?=
 =?us-ascii?Q?QeJKGfC9feJH6uU0z62mZhaYnZEDNLzk7VxNRgIQOBCnVQXVGbNAV5Bo+BaH?=
 =?us-ascii?Q?yEhAmAh9H28XtVzUmnTtAGAropXvsZC+Mt/jB39uB3ABe+1+RUwZLhYTSKJ8?=
 =?us-ascii?Q?q/lwvr7yqYeqvIwWFZCcDEzmwwjdCTh+JhwEPfLgqMyqo33aWaJQyuxVUVrP?=
 =?us-ascii?Q?sEPvGWJg6p5r27t2K/niO8uqeChApgTQHAGqjyikhV3z9z/d/EmlkdEYffPM?=
 =?us-ascii?Q?gdNHk8yqvO26K7YE82shBLcHVOa7pM+MOjWKfjLNzTEBQ0lwJG3oZ2ap/dO2?=
 =?us-ascii?Q?ldusNfjQyIjAOJV+10y5FN05+1YJCjHqPfkZGTrvXcsfjYdY5OjWyXBcU5cC?=
 =?us-ascii?Q?XepOLuBVOPu7f7TYdD1AoLKIN3Ng5yFt51ZkoQI5E9jlDp01vpLJZBtPsx3O?=
 =?us-ascii?Q?SKLrQoa7RlnjmZQ5lKgqTzMq2EZGZEL9J7XkBPr6DxuX3CDckGPxxXzNG+TF?=
 =?us-ascii?Q?rLY5Z0DMeNe1XoEAei/Mvo45NXn+q/mWGYJ2Zwm/YZtHILfLvaJ9lIouvG0Y?=
 =?us-ascii?Q?JZQDlnBwI8LQJGnA5nwnzU5QU8EAXhIX4bcc+YpjNWi69MrIz6pXNv0tO8aU?=
 =?us-ascii?Q?P/v0FMajok6NyrthGAik5VOAiOQlM983BTuIdjf3naVXS/FjBPmRK6nLG2f2?=
 =?us-ascii?Q?QN2uMaNofWiKl7KMSNsY+E/Q9ks7VwsB8bwfaFle3CjfXlLOSTDdYx0wStBu?=
 =?us-ascii?Q?b6KZqgpdghgbj4OsXerCfoIeNJsA+GwqqUzDThNENrMw76nPAbdqIbIWnMEP?=
 =?us-ascii?Q?X3FtCBR7tbxD9qPeTQVduB1PXWwL1fQjzsXyfoGGo8nYFZqYM+D5fM2lVaXV?=
 =?us-ascii?Q?DSk0MJoj1h91j2onqqUOr6sI4q+E0pYcOz6G5IgmwBYRz9QA3oLEXELwAUDX?=
 =?us-ascii?Q?PCwCSyg+3pJR70WGyavdqsdxYbmHj+J3Qpm6lwS6Fms9kW8sL9EuF+NL5Wmf?=
 =?us-ascii?Q?0R2GQsKR7wE60OEl51r5fgL0pBrA4huDz/wWIooh4gTK3uTMrl9cuQv/pqbu?=
 =?us-ascii?Q?Y081qf3CfH5aP3q5PQYLvtbha3Ewt5V5STfji3nDP+NNdckdDBG0erqJ+WqI?=
 =?us-ascii?Q?acy5tlxFO48OpvfFdv1V7rihl7Ri6TPow8UwlBDB1oOFmCjG7WqCY2JvHWbT?=
 =?us-ascii?Q?rec3z6/AAO34FDUL0BoL0VMTMBqO0oZNQ6h7Tiq5b0HrzSQu8X39PuCv/bxF?=
 =?us-ascii?Q?mCrgP9CvAVzIleKmjRm+qEYoW0ka81v1EUyd7dhKCsmOOzjiG4LBnpY5lZqO?=
 =?us-ascii?Q?ePBACZUcDB8RnYLTfALpBox+U2CU9DsvSKe/ewY7T3RRXhGYJzJZAATvGslP?=
 =?us-ascii?Q?q/eCYnPUpnX7orSdA1xwzXnUs+IFdtZH8WLvFitig/a04vxehF+dCc5i8GT2?=
 =?us-ascii?Q?qwly9ZIch+szsqqc7AN+UmHWgnbcFDoPxvO+4wdNr5Lv8xlGwlt0L4Q2EUrA?=
 =?us-ascii?Q?6xCfuidltoq7gsFCfbelAb0HNu7gwnvLlCj+yWVzW+kOJ8OFPxMHnr409RLK?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lvNmhT8UU9HV3WnZdPbTDoCMYosl5uoLpyd+qZiZVwwgcubaiFxsagRx/kfz?=
 =?us-ascii?Q?gPmjW5bACCk2IQgkCJImwswXwDKgWqBg0Sa2YUw1uQvmGO/QaI/YP0ZsPZeH?=
 =?us-ascii?Q?j9gDVJx7u97FCJ87otME9R5QiFL2AxbhC5s+fw9MLqlc2UYdp2tg/dWM8IDy?=
 =?us-ascii?Q?MjVA7v1sSXT5WrLcPCLLylEOoogPiX3fi0NTANqDjFlCRSAL2XSv3JHHZ+jm?=
 =?us-ascii?Q?IcA08jKWbjH/luh2G6/AItaqjHf+xAJawMbWtvg8S1sv/6c9CYHJSkigHY9c?=
 =?us-ascii?Q?0jf370eVAaDbdqQxu+TCgk27rNWLL6Jvnjk9Cty5mxfHV4XTt2hTvEt38CkL?=
 =?us-ascii?Q?Kin33OzDOIe22ieuoShDuCNUhJ7z8ZbO+MKWGot89LYvB5X1kqGFebAtaUWx?=
 =?us-ascii?Q?Ueasj/ExOEKMNFsdzn41RpjxXRUz1isad4YP0LvcSFqJig/gjBPo9PfMPclG?=
 =?us-ascii?Q?56Q6+cA6IQ4y3U3g3mTGD3BvQbxCUYX/bDPktBS07auwwmaaX7CqX6a3Pc7V?=
 =?us-ascii?Q?709yise9vIUK8/TGfJLjz1fDb3oBs89eqGcHYlyZNHl/sSfHvw7SUhLh4IYG?=
 =?us-ascii?Q?WzQ13MAc/9FyhkgGb3KnCo5KjqCLWAG2vx4U2hk81c2dQA9HierhERXaFkQb?=
 =?us-ascii?Q?nV+X4TdORbRdhJWJM/IzBPBqbJCiLs3IoIIXMlTrDaYTYxPCiuhTWwLtJGjq?=
 =?us-ascii?Q?W+dxDsbcy2K2ljQzu5kDrhKq1EihSJm0nFQotdUghc7MKAC+seKuvmxfKuM+?=
 =?us-ascii?Q?CnoUgTJuGJcRYmlYqcr/i09vf/XsQ+O9EQa/q4D+0jTmIOUQpV/f/YpeXgds?=
 =?us-ascii?Q?HBfVvTZkWeJzkR1Og8qFAaW4xuPxjQNkZH631Oi8SlvIR5Dy3nyeSmQIwBhc?=
 =?us-ascii?Q?uba5pstn+AnMZkCAxaciCHAIo0T+DrH0EsFNOrZKluuFYiiXVqA5gJMV2A79?=
 =?us-ascii?Q?ZYvmMT+Tfb92kMXG7jYHd1l1pdDbpTbM/5UOTID/xcDnbnsyJ/TE78kBn89N?=
 =?us-ascii?Q?kF1YmqPLQ06K13N+ojIJ3jfuLiEGGV0ilrjSSQcclNoJvDsbO1t2wtXTtsC3?=
 =?us-ascii?Q?bF9uKbSdxrPX76254vK3nZNWHME6YMQ7AtOWpn47NfcNfRUooj0eZ8xdW0MA?=
 =?us-ascii?Q?MMPgXwheVzJt56lsTXn1Y3NCD5BjTCvM+D6EvmnJ94KiTeW+t7jR5B4FTkpG?=
 =?us-ascii?Q?L3IKe4JKEbL9rZ2Ud1BG9vvxr/RxV8NZHcZ35ffrvD5OAdi/GTFfwymZ0geR?=
 =?us-ascii?Q?Eh8MVBMLkJLzbPOft/Apo1RrKYQtbHQDCi8sl8495juk1+xHS6N5aq+Oxtkb?=
 =?us-ascii?Q?fdyUE/XBFVZOeU1SYzvsPFhT+Gb8350GQT2eDJF0/QSLjwnB+P05uDcIT+bu?=
 =?us-ascii?Q?l2ANcdtBJ/JXWyul/dScDpvk0vXbn8TST06QuoH0UgB+Lesr2wnrdjEsyOWx?=
 =?us-ascii?Q?I56ecmh7R+vU5hCxND6AHsjQNG5xquw5AITQ0Nl70sdu61htZfOPoOTutknp?=
 =?us-ascii?Q?y7JrAuNGDnEd7uzX3pi9KyH5vRqdaIzqbBvLau52CjTddJ1zRdPKQlRNcYJH?=
 =?us-ascii?Q?3Ivik44P73NXVJ57IFvaOMxSEU6Z9hyJ5j9ez+0HmdvSdT8qKDavR1gHeLn3?=
 =?us-ascii?Q?nL6JbR9HIW4d+seknwClpQ1qGLaOHpf9DwGcUVuWk/p6pE57sjdZyVmUU5qg?=
 =?us-ascii?Q?R58nhlhKwT3ycmoMTTrYkk+JKG0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a39acdc-a74f-4b56-a18c-08dbdfe68b09
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:07.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MEch8ecFh4HeNg33Ct4s36+ZLMe1t0SuQTKRjg4GG8JVCH6SF2iZSR4Hu874kCGvubN8VTOOPFATtrymsNNUdVxFhreR89J8keUZb59QX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: C9IHtMc2wAq6gYbN3RiMg5Y7H7mH9JjU
X-Proofpoint-GUID: C9IHtMc2wAq6gYbN3RiMg5Y7H7mH9JjU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

All calls to cond_resched() are from set-1, from potentially long
running loops. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Davidlohr Bueso <dave@stgolabs.net> 
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr> 
Cc: Manfred Spraul <manfred@colorfullife.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Jann Horn <jannh@google.com> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 ipc/msgutil.c | 3 ---
 ipc/sem.c     | 2 --
 2 files changed, 5 deletions(-)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..d9d1b7957bb6 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -62,8 +62,6 @@ static struct msg_msg *alloc_msg(size_t len)
 	while (len > 0) {
 		struct msg_msgseg *seg;
 
-		cond_resched();
-
 		alen = min(len, DATALEN_SEG);
 		seg = kmalloc(sizeof(*seg) + alen, GFP_KERNEL_ACCOUNT);
 		if (seg == NULL)
@@ -177,7 +175,6 @@ void free_msg(struct msg_msg *msg)
 	while (seg != NULL) {
 		struct msg_msgseg *tmp = seg->next;
 
-		cond_resched();
 		kfree(seg);
 		seg = tmp;
 	}
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..e12ab01161f6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2350,8 +2350,6 @@ void exit_sem(struct task_struct *tsk)
 		int semid, i;
 		DEFINE_WAKE_Q(wake_q);
 
-		cond_resched();
-
 		rcu_read_lock();
 		un = list_entry_rcu(ulp->list_proc.next,
 				    struct sem_undo, list_proc);
-- 
2.31.1

