Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1577E5351
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjKHK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbjKHK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1011BE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88tia2017962;
        Wed, 8 Nov 2023 10:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=EIFXZlGnlchghP22xF/aTsUM8TM8QNzyg0gfm5l/so4=;
 b=Ur75Fs4KRWvnjlMyPwIGc2t5VNZvYT1hW2ii/E0bGKsu6bunkGNI9W43SKxN3H7zUhR+
 pGWZ/aoZ1qlWBtqws960M3yUvJWea/mmid6Wgj7Fbq8roO5S5+g8Ok5LPngS9+IrQkmI
 +eWQtlB9wdAqT6vmhrAyqy83oI+Sna3MED1XsqM5HEqZa3ED7crcd+S7MMgBhHxs2Egj
 djNvch9XLIMdG+z/S3R2NU9o8yirVU8841bEoeYFP6qItaRz8fW4D/0b6VL0tdso/VMm
 fSG8YjuqHON66x89kdxjk0hARHCFIcTOcuNOn2Sa2xyztnVgt3J7YXVDEZwcGBA3x8tO qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2315w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 10:26:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8A480C000672;
        Wed, 8 Nov 2023 10:26:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xh83c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 10:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2/nRhKxoHzHPB1vCeuMC/JLyz3fpC2ZL+BRHlsQXo+TWUZKzgXcbQtnHI5EtCrP5DDLGavZngOGK77sSKZnbX3EUKKccJLyR6xk39JvAET/LlC7k7WC7/UlMBsAPt3tnuC9at3T78ZLm71h4Ih9d/2V6J1qJoz2d6oHYEwDWlJqq+VweZ2Yum7ACY6KY5vm5xUtEuOIjP1ZxlLNHqILkMNuqXM62NausqQl2lMVLnRbuEezQosYEHcl8rWEQ4UGaPUXvPluNdkba2j3+3n6eKH7g3O60DQKkFsLxPB/clvHJYnFZ0sde2urQPbgo79kO/pPxWIafQ0bjDfawwBshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIFXZlGnlchghP22xF/aTsUM8TM8QNzyg0gfm5l/so4=;
 b=O4/X56c66KnqxUUv4jWCBgWS7yECg7HcDZa8Owwnobz9SvVlLgGSOKDt6ohAj9aATBhSKTkFlg11NiYlelJ5dmqPPAUJw2c0M0c8a0PxPZaIIco1Fzu+PiJ5PyMljyRhPz0qjxt7EBhkbvITBCaaphoOPxyiiFRx5BoQtsibau+rw1jVrrOijngJzqKrUTHRcQ/BouKJ9EQj7zx1SUQnK1mHYFlmfB0F0ARoqdZJdY+0f77tl1ONQ8bGITpBG9H8OwxmIx3m8cb51COd05htAO0x9b+sMqgfOX12AH2xQJj3bfIIsylDudKgpjwi/HfLxxWXMALuVkporr7sJ2HrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIFXZlGnlchghP22xF/aTsUM8TM8QNzyg0gfm5l/so4=;
 b=ddmc7MyLG7c+bYO6M9Amf7L5RmO4DXBT7L3JzPl6dnwCsnx8o96lfwmHYAN8hCY5fOVBAZ3EZuHvTT5874hiBNuXSe9NuBpcNtZISAea3cQfPGdFiZiMvwySFcBIb+jeGiqBfILv+/1nnEA0HId/vpAFjPcIvh6f1kd/lNd5eKA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4726.namprd10.prod.outlook.com (2603:10b6:510:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:26:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:26:39 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-42-ankur.a.arora@oracle.com>
 <20231108093645.GL8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
In-reply-to: <20231108093645.GL8262@noisy.programming.kicks-ass.net>
Date:   Wed, 08 Nov 2023 02:26:37 -0800
Message-ID: <87fs1gk0bm.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e095152-3031-4f8f-7e2b-08dbe0453155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3ba9kBvgw9jkH4sI91MlIH0DjlOZVWY2gIE/QlgQ0gwh9XkPBrSfmsSQ3cIggnbutQfnO4tqPw7SSkOkXw+cYUuYQ7Ixt5a/qqcIQQM6Bzh1pm7dM4DMQQvIQ+FZLkIPLvtaCp0MB0cD+0uQz/9ECMg47I8yRr+tMwGv68GtO5vjy5i0xPO85PLa0TfUx1o2cHjGiq+iybP4eXw0NvL8uZRHwcGLEzIO+Z3NJddS93ZkQG7/URVaxA0Efd6L8BbwxCGAuZ5VqzgZsOdAmplKS1Gx0bVZ8hZi43CzBIVOsIJf4dec5o9NmBv3i8p/yQEWRGIBCGDDGKw7rhNQn3WdntGRZG9/M5xcg6ZxyN70RmEnCX698FRK7vZ7xunhu+OfVzyNe5oCAmtoZByoqJxtrAIFnMVhZM/xzLyyXMma4yJ//Fl6g6IX0PVOggxSxUWQSCADQ4NOe8YyzqZ9XxuG5u2pKRTUPlV527Sd6suKj4Uh2bN+oPyeVZOM90251xj/gKD+05rH7v45c3E79AM7UxkVANkp9I3RzaxkmklPbEptV5pplFZXqtO0UmO5OXH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(26005)(4326008)(8676002)(83380400001)(7416002)(7406005)(5660300002)(38100700002)(2616005)(2906002)(316002)(66946007)(6916009)(41300700001)(66556008)(66476007)(86362001)(36756003)(6512007)(478600001)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z9Gv7nnNn3N5NoQEL/KYjxv4f+5BJ8UDiqmh+902EWcTRT+DDo17A/zjbdwt?=
 =?us-ascii?Q?hVhUJCAtaxIi8G1Hs4W/EB81/PLWl0cegz9eQMH/pATyF5TqjfA8cICPvMAL?=
 =?us-ascii?Q?4N9OrIAPHw+10YFxgFUeLLMlt+ZNyGQoGGqI6u7zeQ3LsvxiDe0pvKHwXftS?=
 =?us-ascii?Q?ACOsimPYvyQHwMpkl2m3yOnV1BlaxVYxohbG5eNf0R9q0C3h3Sl7U84BURCw?=
 =?us-ascii?Q?mKeuEVIzA7TkZGyb/Buk+IxBGUlm2ABXoVXt67fMuP0+kloprWGxoO1cBEGX?=
 =?us-ascii?Q?D4mh5nSomWRQuIZUQcp6O6zeVJTCDBj9s8a5kjAOsvu5exGCU4hmgk6pK3MP?=
 =?us-ascii?Q?pS6iwSO1asZyz8fSCz0OIQwfd7AkXXkfoZuv9oTdatmWx9iIU+zkV9qD8G0p?=
 =?us-ascii?Q?8jBF/hYCZfDwJRrvcYuIVSqwm+gJ6Z75KN065w24nJZHfmc3ffaqUTc4GHE0?=
 =?us-ascii?Q?9joOCot9XZX8Tv10XNnlDu4zVH5Bi39PWOxej/1xrh51MSMHXUr6DxKDWwqi?=
 =?us-ascii?Q?Ju0KG/1v1Yy6xhdUZYb89/HZRi9DqrU2gBNRhtS8FmStWMGIZ3mm/N4/nD4E?=
 =?us-ascii?Q?VyDGkqb2pHKKD4EUeRj9vo0TpsPgpAj25Y3/B1YpjH7auDbo08jIOELIe/51?=
 =?us-ascii?Q?nq3XZPz9z0cXfbmoCK/bq/THqbFVoHvOAQsAGb1dRkdPpoSqXM3wKMrV9kMH?=
 =?us-ascii?Q?dCetWnJaFiK9LKObmWJ++98yKg1fyx7nvlg1C0XEYcT6NmtJxGkPeTePMr5l?=
 =?us-ascii?Q?0hIYDCBK6bAb0KyNxsT3wyVqBupciZlVEwbIe1l1ix9am0vYc3BfdtTr53IP?=
 =?us-ascii?Q?s1eY0LtIB7dGGlAEmLtzZIqNhZ3aNx+lJWVCddWjweMsV6JVm/WvUhe9U8DV?=
 =?us-ascii?Q?D5v7K1MTwKr7nNbbiehPMU+bs3KaAR10zkGNG0KlbPs4NpT9bLbF42oK2c7H?=
 =?us-ascii?Q?gfDXzZAK6YDZjI+y5apVYx0fZTbV2uK4Dsq3KJpXgYTwjfFYnkaXG21ErOcj?=
 =?us-ascii?Q?xvtDCELLzSVJo38OEkLX8P50mGWOxFKBpwrxxlLKsfmUKZtr+b30rq5TdXBo?=
 =?us-ascii?Q?np2VBwjD9pl08PNshoA1tXXXsI644klxwsMFNfe3Gw2Lfu7fOpw8DA+UJZec?=
 =?us-ascii?Q?N3AwiVDrVNJckI2QfJrA240wrfWN16H1zbQwUB+vLY1G8YYTO9yl/zduUmIu?=
 =?us-ascii?Q?WLqB7Ie4ZQ/ala0zFzck4+TBV+BwhpvrcJWEays4EkyPnhkuycCEvA2w+jgm?=
 =?us-ascii?Q?9koI5ox9wQGsls2KXOPaJE0sThdxHoibX8IHaVpTceIWGzq9rB5Ya0y18pbE?=
 =?us-ascii?Q?o1JFiNdz7YZ7emP4jUhLtKXe2MiurvYpNLL/WTrgHrMOGvT6nVJp/YVQsIDu?=
 =?us-ascii?Q?kshfMOFAdzAglU6sWFOqU6A/HDWMLU8yaDtT4cJrjk+WT/Xno/e3IIEuj7tD?=
 =?us-ascii?Q?6tDl3aw+JvCGUuiMdsQm5I5G5vB/vKcBFZQGm/W8qPc7+wVCVA5ldAdR8LvL?=
 =?us-ascii?Q?ReZtN6FwDYDTNdhGofN0/o1EGtQHypwKkoYekP4c+sSD9ww6DVNfQ7HtVKEi?=
 =?us-ascii?Q?PWCovenuM1imDErMEuWw54l+DW3ZAwoMOgi5cAmPFGMrgQ4TKiKzid2wd2zE?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yjGpFrrI/l6smb3s6o2dhqHkyE1MaPhQ5dJhZBagvfJZbEK+gKUEDKa5xy3X?=
 =?us-ascii?Q?94TR4gX09J7XG2FEUTKXiDcx0X29LNGiyL/5F24Yw8LbaiGHLZAQMkfcdt53?=
 =?us-ascii?Q?Wo7fqWYT5Q8fjyGfxsFyVmaCwWvHZ/oEUQOEjhMI6CFND7Mi/cbgZGm4F96j?=
 =?us-ascii?Q?Uh6iT8U6RhL50/ZXVWWWaM2e9Pd1lgS7tnv49C2jHwUVa9HyWhE1hYV174mA?=
 =?us-ascii?Q?fHzSgel2T1MKr5gIaQprABcFv2FmxTBBJUZtDttSi42rWvPqgQ/3MAMLqb9Y?=
 =?us-ascii?Q?kTYc/43YQUybHSLyu/EW4NTnAgVapwzXQIenxDd3SMeoQmLYJIyQuvmHp8Yk?=
 =?us-ascii?Q?jl5QApMUpGXl5YSjr4vbOPaBH4YsPIwDwmkFH36ck6/NoS/IsMMCMeOQhY4O?=
 =?us-ascii?Q?Yy7DAQwpawARD2BN+2bpnxK1Ikr9RWXcfimCqE87v4b6KSDBMhX66N9T4rnQ?=
 =?us-ascii?Q?HAYsrCwIjlZQ/OoCByKwRtYHNLZZ09jBS/NpvLUtuNs5t9izhbZMlzx7ICoT?=
 =?us-ascii?Q?CReV64Dx6g88Fb1BY6E+EVtb/LMNMppqTiW1ucCYoJ3bLUBLuHJiQ0RYu6sq?=
 =?us-ascii?Q?cKpY6m4ZyyvvMqO35yGh5K0566bEtpGKIRfzCZN1t+9UNT28Nyd5kiFzJ5Bm?=
 =?us-ascii?Q?XIkCMqJjLjvNe7RHZJexNuEkOMzKP810DoICPYI1nCBEBIx10xcML/OZyLbY?=
 =?us-ascii?Q?coxmklb4QtvkUkpHYQ0+ykZ4lfaTK1odfyBTRM9JZV3yQfnGfjJYxCpep4j/?=
 =?us-ascii?Q?mCeiJ3J6LHpcoK6m+IvJoNyAPTY+q5CDAJ7gcgXfVCYdLCKpF0+cUJcYX7EF?=
 =?us-ascii?Q?/EGoMEHq1zdDevmGu60I5AW46P0wEkmWroJHT1e+AlM9cp6F+OqeIsCx/YLp?=
 =?us-ascii?Q?xKPrT5eZIOrK6bkQltKAfmEQlfGHSTYbUFHAfFxaB3p63NKZz74i9MsrD1EK?=
 =?us-ascii?Q?8pBVsiuOjwHexPjST5wOD5Z6j/JNfl+VTGaCpvV2Pkw/2DmUIfgS23m1QfSu?=
 =?us-ascii?Q?x5NaA4nt4oA+ZD9ZF/RQ6ij2l8Ha6eRueDaSzcnVck9N+9T0EQOGx/0Mjjk6?=
 =?us-ascii?Q?aGGpM6QLtyfDxhTxeTpn3poOvKf7EQBPfoB9oECfkpus7ZaVHs2bfiZGnX8j?=
 =?us-ascii?Q?cazLkz2bjUUVVfujKZz691Lgiyp2ARzoVDoNrBaIfDMZRPrus7axiJ4iRIRd?=
 =?us-ascii?Q?iDJqrVBf0z27bro8+ICePXR67vLa4fe2Uif43oUAJgGJZ22t1R8gUzskSunD?=
 =?us-ascii?Q?Xn7jeMsz+PK7veuaeQqsOAESRmlPJOGGK2zwUe8Ic9jPwAbysF8x2LxrGMpl?=
 =?us-ascii?Q?035ikJOHsdnjqfz3Qp7NS+WEn/rDuY70NUSGfhu6c4qnj/S8lRKGHXVDhYVU?=
 =?us-ascii?Q?lVPXl2DOBSci403z21hf0FJx1ZNi5j00IVx4motNuB+mGXRFJJJKm0alwtP0?=
 =?us-ascii?Q?GR1RdR9fFZmPvbHz2gSrZGutS2pQ1rCOUj4m9BdSLTdB9YCahXzOt798lnEq?=
 =?us-ascii?Q?ZVoX/rdiB+DUleB+XNu8PGSputaf6aCrKDZDdPZoW+XO6DJPdTEQqcKV4Q?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e095152-3031-4f8f-7e2b-08dbe0453155
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:26:38.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHRwS7fTkhdDQVeDoIFcczqMdmru55nvFF7oZ4on9GHVsjXCqOdqdcWv03SkT1SOaCzuvPccoWNdYpUOJcpd7eEcJquZAhSFOPreprYfkkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080087
X-Proofpoint-GUID: 2n_3HqAW0yFxlPCAK7UxZGPjwXUwV7Wk
X-Proofpoint-ORIG-GUID: 2n_3HqAW0yFxlPCAK7UxZGPjwXUwV7Wk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Nov 07, 2023 at 01:57:27PM -0800, Ankur Arora wrote:
>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1027,13 +1027,13 @@ void wake_up_q(struct wake_q_head *head)
>>  }
>>
>>  /*
>> - * resched_curr - mark rq's current task 'to be rescheduled now'.
>> + * __resched_curr - mark rq's current task 'to be rescheduled'.
>>   *
>> - * On UP this means the setting of the need_resched flag, on SMP it
>> - * might also involve a cross-CPU call to trigger the scheduler on
>> - * the target CPU.
>> + * On UP this means the setting of the need_resched flag, on SMP, for
>> + * eager resched it might also involve a cross-CPU call to trigger
>> + * the scheduler on the target CPU.
>>   */
>> -void resched_curr(struct rq *rq)
>> +void __resched_curr(struct rq *rq, resched_t rs)
>>  {
>>  	struct task_struct *curr = rq->curr;
>>  	int cpu;
>> @@ -1046,17 +1046,77 @@ void resched_curr(struct rq *rq)
>>  	cpu = cpu_of(rq);
>>
>>  	if (cpu == smp_processor_id()) {
>> -		set_tsk_need_resched(curr, RESCHED_eager);
>> -		set_preempt_need_resched();
>> +		set_tsk_need_resched(curr, rs);
>> +		if (rs == RESCHED_eager)
>> +			set_preempt_need_resched();
>>  		return;
>>  	}
>>
>> -	if (set_nr_and_not_polling(curr, RESCHED_eager))
>> -		smp_send_reschedule(cpu);
>> -	else
>> +	if (set_nr_and_not_polling(curr, rs)) {
>> +		if (rs == RESCHED_eager)
>> +			smp_send_reschedule(cpu);
>
> I think you just broke things.
>
> Not all idle threads have POLLING support, in which case you need that
> IPI to wake them up, even if it's LAZY.

Yes, I was concerned about that too. But doesn't this check against the
idle_sched_class in resched_curr() cover that?

>> +	if (IS_ENABLED(CONFIG_PREEMPT) ||
>> +	    (rq->curr->sched_class == &idle_sched_class)) {
>> +		rs = RESCHED_eager;
>> +		goto resched;

>> +	} else if (rs == RESCHED_eager)
>>  		trace_sched_wake_idle_without_ipi(cpu);
>>  }
>
>
>
>>
>> +/*
>> + * resched_curr - mark rq's current task 'to be rescheduled' eagerly
>> + * or lazily according to the current policy.
>> + *
>> + * Always schedule eagerly, if:
>> + *
>> + *  - running under full preemption
>> + *
>> + *  - idle: when not polling (or if we don't have TIF_POLLING_NRFLAG)
>> + *    force TIF_NEED_RESCHED to be set and send a resched IPI.
>> + *    (the polling case has already set TIF_NEED_RESCHED via
>> + *     set_nr_if_polling()).
>> + *
>> + *  - in userspace: run to completion semantics are only for kernel tasks
>> + *
>> + * Otherwise (regardless of priority), run to completion.
>> + */
>> +void resched_curr(struct rq *rq)
>> +{
>> +	resched_t rs = RESCHED_lazy;
>> +	int context;
>> +
>> +	if (IS_ENABLED(CONFIG_PREEMPT) ||
>> +	    (rq->curr->sched_class == &idle_sched_class)) {
>> +		rs = RESCHED_eager;
>> +		goto resched;
>> +	}
>> +
>> +	/*
>> +	 * We might race with the target CPU while checking its ct_state:
>> +	 *
>> +	 * 1. The task might have just entered the kernel, but has not yet
>> +	 * called user_exit(). We will see stale state (CONTEXT_USER) and
>> +	 * send an unnecessary resched-IPI.
>> +	 *
>> +	 * 2. The user task is through with exit_to_user_mode_loop() but has
>> +	 * not yet called user_enter().
>> +	 *
>> +	 * We'll see the thread's state as CONTEXT_KERNEL and will try to
>> +	 * schedule it lazily. There's obviously nothing that will handle
>> +	 * this need-resched bit until the thread enters the kernel next.
>> +	 *
>> +	 * The scheduler will still do tick accounting, but a potentially
>> +	 * higher priority task waited to be scheduled for a user tick,
>> +	 * instead of execution time in the kernel.
>> +	 */
>> +	context = ct_state_cpu(cpu_of(rq));
>> +	if ((context == CONTEXT_USER) ||
>> +	    (context == CONTEXT_GUEST)) {
>> +
>> +		rs = RESCHED_eager;
>> +		goto resched;
>> +	}
>
> Like said, this simply cannot be. You must not rely on the remote CPU
> being in some state or not. Also, it's racy, you could observe USER and
> then it enters KERNEL.

Or worse. We might observe KERNEL and it enters USER.

I think we would be fine if we observe USER: it would be upgrade
to RESCHED_eager and send an unnecessary IPI.

But if we observe KERNEL and it enters USER, then we will have
set the need-resched-lazy bit which the thread might not see
(it might have left exit_to_user_mode_loop()) until the next
entry to the kernel.

But, yes I would like to avoid the ct_state as well. But
need-resched-lazy only makes sense when the task on the runqueue
is executing in the kernel...

--
ankur
