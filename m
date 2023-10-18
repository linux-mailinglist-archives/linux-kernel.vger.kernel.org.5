Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7004B7CE898
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJRUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJRUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:16:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326B119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:16:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp754019570;
        Wed, 18 Oct 2023 20:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/20DLez+E1h9aE4lmA/MOalxVRgdkkCt4g/xFQb2gY8=;
 b=xkMcB65V5g9rqc2aefCGqxBBVV3fgzSmK5KX7xJ8lH9ZDN/OIScX//NnfwDm3I+NHBYl
 tCD7XNJA4Jl05GiXru8AB+FHY1kYReO1yufwMGjJFQ9U0OB1x3Plscg7lVfeb/e4E4Rk
 qAW6eR+qrTArV2pCabnEEDsXZnjRxezR05nV5BstaRvzsmNB/xp0jmHCHCEa/Kml8UY1
 Xfi5EPFog1vQwn9RUmZRzWWexiFmL4BY3pRj2G0Ol9Frfr5QAHHSF85lWKAxpes5j/XX
 mvXRUrbu0uhDeZmgyFqpa6g5dwrcD//D9kJwQOhR351y++zxlTj7LdMtTa7blFddeAbf Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1gf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 20:15:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJU474009149;
        Wed, 18 Oct 2023 20:15:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0prttq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 20:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq2D8euZFnxExraQ5o41om15CWMUuoD/9G02GLOs62c4TXp8lQ+rqOKW2WIepAdSNZonxsjyFphNLYYnGuqKrZFTmvZJdObub/yIP/+YOe07oF4iP3Shnj0d80JqudLpls4IO2iWIKNpTqYUFWIBe4vkCehG1G6ZIMlWXcyYrVpmgLqZjLL8bSf+Mdswnsx3j1gBX8rRRBMaUxq7mnlPDdTglM0aGnqTHKtxMpTu+UVRY30xwBy8PMYbwaDgsq5DeOiKgMjMrZ/l+rJw467RoWaeMos1+kBOAUg4Mx/+yDXTPPZ6ICx9MigD/lZve9OHKIRlgD1uxzTSLT2XStqRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/20DLez+E1h9aE4lmA/MOalxVRgdkkCt4g/xFQb2gY8=;
 b=doat3j6LE4vkTHpDDCH2G+9jtCNs99ynb1cJXiPuq2eMTzRj/+aFBWIjL2wjr3ywA4ohROFUyR8RIBCLSxF51g9XqHBIHzbrRepPd59rvIqDrsVAO095j23k1gKFNa/vSSq2xWZw5f3AzoRvm3ZQmPBhiG2J3R2bT1Hl/nFwkomqTazMhtTXcEomnl9X76NzcdBR0FgGc7rpiRBkPWixN6qLtI+xTKMfp7ltLamfiMyzwF6bpicDZtc5I6e4kCworqrP6t0ibiQ/moRK5AbyCYZ1giEm88vGJ41KSJeyler+TqvPxp2yNfM4XbW/rr/jW7kttgSK1uFRXIyG/o3ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/20DLez+E1h9aE4lmA/MOalxVRgdkkCt4g/xFQb2gY8=;
 b=Rb57myVYPreWu/6f3q9yPlv0s+S4l1BJL5QM/7Wv2Gt7F/e4fo2zDWbhYjE/po7JiGSzp5xexq7VbZRZ6NpTsqc8RnEU1aqFnnCuKUnDMTrEr0spv4FWPxeHNYNkeDTEJkinBVLWgKd32b6H1TFl87lWyVsCAZk+J7PFGrJ0CJE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6752.namprd10.prod.outlook.com (2603:10b6:8:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 20:15:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 20:15:30 +0000
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
Date:   Wed, 18 Oct 2023 13:15:28 -0700
Message-ID: <87r0lroffj.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eb8e8d-3160-47ad-b2a4-08dbd016f9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6Fg0zkHQmXcKRb9TjL3GCXALt7VFGb0BlyEhpAVP4is/xTZFlz2brfjDGGcBP7yObLa+p4Ly9XwkR6aajf2sw9IO/TVb4ySOmvHWCNsroLLG5tjHzQFx/X9xLg0Cd48zLFKCft6xrDqwut3pAQnB6ydDUeSnYB54/8CGWOoJSmEIP+lH9KMm6F2PANeE7iBpBNN2jeK+WiXQaCZPKOhEv6uASyNv7LDDokS5JuPSjMIg6qUnT0xdi7pgJgBF0FDYXzmWO9o8wogAZKlK0aEWLyFnEWq5Ng2KFgiy5OvmFQNeI8FaXcV8kFyEpfmylH8KneI/T3hU83AtnleaKkzrfUtsy/RibmZRF340abrobTB+66A5OunGDkL9eGsXhIUwqyOhgUAiY+6IXdI6r3+lQIhQCGG6t1CiEB9mXR/VtwsytGyIuX/lVv2hc8ETBrcctxGBQYCO7+dJk1KD1JNCfWYALXJIhViNq81BZ7xQIGfxaEJOWo/KrbpZjekwrFEKHoll1NAhs6tvHdCp+hUGMLGsM5yJJ+c1IOWgJbdBn9sWZC+I04vHxAMvwzBSrZrk193CYvRlp5KOb2YobchA6/7p6E64AZWYGDJtmqnqQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(38100700002)(66899024)(83380400001)(41300700001)(7416002)(54906003)(66556008)(8936002)(86362001)(66476007)(8676002)(4326008)(5660300002)(66946007)(316002)(2906002)(6916009)(6486002)(6506007)(478600001)(6512007)(2616005)(36756003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/XOIEX7b5G8rZwC/x606jL/68N6I+CGwo+ShTJ1gJcs89wbvmcutQxI4FoA?=
 =?us-ascii?Q?nlDTmj/nWM2E2mdxatLdhaLqTLPgH9ln3vN5hiykgs9pZhaMqbXDLJVEjJdJ?=
 =?us-ascii?Q?jQxYKOUUftB16Tr12P0yJ3DUj1mytR4njNjlRQCo2MfyOyHO3g1tDPVe1EvM?=
 =?us-ascii?Q?gqodnsU1NAhCCrLARB85bvbVqKj6KNL+4YSziE/QFWk8+fTUJtaAdEBIuZ9q?=
 =?us-ascii?Q?15yKZx/W/BoNFMcniIrHgQ42AK8cvaSYG2PQMObFVSiBxp/N60GEavT2tFF1?=
 =?us-ascii?Q?5EfgVOY+S11FocY9pQ69fWGqO8ss3cDbQhUbDLd1RtTD00zGrFlOmt7l2KeA?=
 =?us-ascii?Q?Qz0A4lm1WI9/Txhw96033QgnAxd/9DcNUPyV9FEn36QQHWPRt1eJP8IGBFTX?=
 =?us-ascii?Q?lCrXObTJ6Qa2t2yTKAr30fjdoCxIx6xTZ4QIHpSIDbYUsDvRUWPiY1/Ereax?=
 =?us-ascii?Q?xXumYvdEL6z4iqFloovGhO+2mnDKrIz5I10Zyy+WwNDIgwNSNcZuSRiewVTN?=
 =?us-ascii?Q?MPipy7wqMVK7afgleqmKBFWyTspv1zS0kdLXMtPsf+NXygfwjxAV8kXQ+7ue?=
 =?us-ascii?Q?gE3EB7QXeBHPz+YvBiuFp0k2sLTemIFw4yGydseIsq6J70H5y7iBLS8+h/xp?=
 =?us-ascii?Q?2Lu3F4A0v4AuvKce84wbfF/RlXndJJQs3zLYxEo4v2E0GZKK6u7fUbRZ9Rbb?=
 =?us-ascii?Q?RoL0nlsQ8v+HeN034+eKXmjVGYQNGf6dxzY2Zk9beb2QULwHSBtggQhe0a2h?=
 =?us-ascii?Q?cCuBEF6ZF5SIBx4E6Fxm9TckYmWmDe28JKZqX9nb3FHhHDIW9Opsu6xH+3sj?=
 =?us-ascii?Q?ydXhlA2ligeJuCQ1x8gIpCxcz5pns4KuIiPhF14gKbEGoUghSCEV/kVurBia?=
 =?us-ascii?Q?AFzQYo12JqOjMJKWtqUlSeruF5qW0lb8O//ZaW2Dlx/4IBiycubV71Iee0dN?=
 =?us-ascii?Q?yBcO4qXgQVXRvm/XYUTSrpiUDLjpkhHvuY4XjoMEcsGWigAbdoXwRu+hPBKM?=
 =?us-ascii?Q?pZhQlC4KG9R6znynUYJWWF+PQdN+9+2Ala73HrHUtNLUEjhQAFdZo2Tkyi0E?=
 =?us-ascii?Q?M8itt/6Oq+oebrAyX1FwcLI27sbT1eh9+4hT474FbtoZ/Lspl6sLO/uuo8Tg?=
 =?us-ascii?Q?b5nRTvIhc94U70YBL21qkGYi1sdkZYm6ZvTHu3ZZMfoGQoASnYRu5IfkTgWz?=
 =?us-ascii?Q?GM91jsrjh7+n0GTfZypzjor9a4CeODlf9aXzypWrpPO56okUHCn7IU4sG8lU?=
 =?us-ascii?Q?2QRgzQT4s7FbfUynzR3Ok7FDukKhRHQQJqBTj4xdHU4Plx3kVu9YlTNAwbWO?=
 =?us-ascii?Q?49v9yUbEv00wbfhuvvevXRHssWx6jZDiYKhiddrKaZDSMKN1yHvJAcfs6d7F?=
 =?us-ascii?Q?bRP8qGquZq9Ja4LHPWun4Arn5R1VUYLLpGS3BCq8dHa5F1z4wQAkQJwgrjY6?=
 =?us-ascii?Q?Dc6/1M8QmLlfjwhqn7Hkafr6xCz9K8pXxO0bDbHb7YfkzAxWVphXpt2Qto3g?=
 =?us-ascii?Q?eO7xbji2as03F9omvMKTk73by+xhNecPN8/awUSo3xR2IULOTJPZtHbdWlhj?=
 =?us-ascii?Q?p6yss6+NGG85FETSsFehDcVYSEeOgitQSM0OZl/q06H4gAE3cAsrQSoN9rOP?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NM4rtAqEP1v92z0NmaE4k/5CLGGdiqT5yRO2rK2az4Ndk2Qn4/sopRH+Wcf9?=
 =?us-ascii?Q?zYSYvD3cOmomIvZDRy5gCBgu4/gEjhftjR6JQRhgfEg74amyALW/DgBleloL?=
 =?us-ascii?Q?kApX9JJMU/F6raV83/jnL2bV2yrEKaDF3I3lRPnIYbBhNT4nQfmWda/NaSDM?=
 =?us-ascii?Q?i8k37X4bxtTWcn64SXSxAbFzlabA+XlfshPhNpGUzh7bBZhWVgB6TWleBVHt?=
 =?us-ascii?Q?Mdu0pJi5ICD6YAVIN6O0DZ6Z2bl107xsDSIGK+jPzCEgGdla1fJHo7uIf801?=
 =?us-ascii?Q?Q8yyka65wCTujC8QJip2shgO3WRKSfwqYwnS4hA04+Znva5qKGo5yYbivkTH?=
 =?us-ascii?Q?wVpkRXtdalfJAr/sgSiivLPCHhjtr2Hg6GnK0OKAmeS7f8T/dwepxtfp0cMk?=
 =?us-ascii?Q?F1KE2oJ62Fh0Q2lwHR9nDq1Krcf4l6CtjwzXais/Pm0m5WMeixQZc1+vHnrG?=
 =?us-ascii?Q?SxFkFDpT4fN89jTSSTENnyEEVvXlPWTvpivUFkWE6lXWZ8abHeUcee5Ju5AC?=
 =?us-ascii?Q?Vd/w8MZRSHAXrSvuIVfRtgTJXmm1Pkzrp4eVK+zcPsb6KVxr+IGtSR1p3xgN?=
 =?us-ascii?Q?CqLqgbzXXqM477lbsRp/MyVr14db4zFhv18ftfWIekHGkKvyKQBjUu4fyBHj?=
 =?us-ascii?Q?81b9TCW9mDdXI6AwA5JwHMuEcV/nmKg7YimQBbJEbfEl57KY2f1i9JTrJp9a?=
 =?us-ascii?Q?6pOZaUDFAE/jdKkRyic7PKjKJYHqvD0+yPsjvcgCWaRzrua/K6jQOZBIQpYh?=
 =?us-ascii?Q?W55tR1aPY1ulVeQivjE3F0+9ZRiWntAF396u05RhdLvxCi1ar01sAXrEMLjM?=
 =?us-ascii?Q?IyY9wSIVkN+n4x2cyhkZXUDhOlSEUJEiHqwJJl9TloWMXhFNCPnpU5N3i9il?=
 =?us-ascii?Q?5eZwPS+u49+LwzWdaag7RKuY8/VEq0ByO6pj2Zu02Z3xTnlDIbiG7q84Vjjv?=
 =?us-ascii?Q?qV+qsvDZXVT84cbWjAAI3qzJ2MYrFx/SchXbGgjiScb+UOJczDuemqywXXP/?=
 =?us-ascii?Q?T43X1DmOKy/jC+uI+z8k95YUEtbVr9L+JlrDb0DRksicvH/Hg5Xoo92V7V3g?=
 =?us-ascii?Q?/UIIKtUqMr4e+QXjGgzD72lu5uWsA5K1TR3MWuas7jgX3XHu6GhQxGBkMsIA?=
 =?us-ascii?Q?JHxlocr8wzqgHkOoo5nylUyQApazvKrnCKNGoukBxrcGIjILF2d2wVlqHzkD?=
 =?us-ascii?Q?2TvaaZ4gqiQehJ09VymsUI51j7onmA8QmjE29LG4Xcr9Nrf9wxZm0ojrqYlB?=
 =?us-ascii?Q?JCmeXWYpYYzzEGBOuc2E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eb8e8d-3160-47ad-b2a4-08dbd016f9b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:15:30.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYRCclLOoR+lCv4Y13ALwUC5EPd/94583Pixe7UMFRzdmA3kiWWCZhzGbb/sfokVoQzzqAUso8GZwNiTlH/O1h5QuIY4i2IPfi3gbi/hNNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180166
X-Proofpoint-GUID: Hjx0-F8jD2AY43Y8vV5l9ddD4WRI-YZt
X-Proofpoint-ORIG-GUID: Hjx0-F8jD2AY43Y8vV5l9ddD4WRI-YZt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
>> Paul!
>>
>> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
>> > Belatedly calling out some RCU issues.  Nothing fatal, just a
>> > (surprisingly) few adjustments that will need to be made.  The key thing
>> > to note is that from RCU's viewpoint, with this change, all kernels
>> > are preemptible, though rcu_read_lock() readers remain
>> > non-preemptible.
>>
>> Why? Either I'm confused or you or both of us :)
>
> Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
> as preempt_enable() in this approach?  I certainly hope so, as RCU
> priority boosting would be a most unwelcome addition to many datacenter
> workloads.

No, in this approach, PREEMPT_AUTO selects PREEMPTION and thus
PREEMPT_RCU so rcu_read_lock/unlock() would touch the
rcu_read_lock_nesting.  Which is identical to what PREEMPT_DYNAMIC does.

>> With this approach the kernel is by definition fully preemptible, which
>> means means rcu_read_lock() is preemptible too. That's pretty much the
>> same situation as with PREEMPT_DYNAMIC.
>
> Please, just no!!!
>
> Please note that the current use of PREEMPT_DYNAMIC with preempt=none
> avoids preempting RCU read-side critical sections.  This means that the
> distro use of PREEMPT_DYNAMIC has most definitely *not* tested preemption
> of RCU readers in environments expecting no preemption.

Ah. So, though PREEMPT_DYNAMIC with preempt=none runs with PREEMPT_RCU,
preempt=none stubs out the actual preemption via __preempt_schedule.

Okay, I see what you are saying.

(Side issue: but this means that even for PREEMPT_DYNAMIC preempt=none,
_cond_resched() doesn't call rcu_all_qs().)

>> For throughput sake this fully preemptible kernel provides a mechanism
>> to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
>> NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.
>>
>> That means the preemption points in preempt_enable() and return from
>> interrupt to kernel will not see NEED_RESCHED and the tasks can run to
>> completion either to the point where they call schedule() or when they
>> return to user space. That's pretty much what PREEMPT_NONE does today.
>>
>> The difference to NONE/VOLUNTARY is that the explicit cond_resched()
>> points are not longer required because the scheduler can preempt the
>> long running task by setting NEED_RESCHED instead.
>>
>> That preemption might be suboptimal in some cases compared to
>> cond_resched(), but from my initial experimentation that's not really an
>> issue.
>
> I am not (repeat NOT) arguing for keeping cond_resched().  I am instead
> arguing that the less-preemptible variants of the kernel should continue
> to avoid preempting RCU read-side critical sections.

[ snip ]

>> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
>> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
>> CONFIG_RT or such as it does not really change the preemption
>> model itself. RT just reduces the preemption disabled sections with the
>> lock conversions, forced interrupt threading and some more.
>
> Again, please, no.
>
> There are situations where we still need rcu_read_lock() and
> rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> repectively.  Those can be cases selected only by Kconfig option, not
> available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.

As far as non-preemptible RCU read-side critical sections are concerned,
are the current
- PREEMPT_DYNAMIC=y, PREEMPT_RCU, preempt=none config
  (rcu_read_lock/unlock() do not manipulate preempt_count, but do
   stub out preempt_schedule())
- and PREEMPT_NONE=y, TREE_RCU config (rcu_read_lock/unlock() manipulate
   preempt_count)?

roughly similar or no?

>> > I am sure that I am missing something, but I have not yet seen any
>> > show-stoppers.  Just some needed adjustments.
>>
>> Right. If it works out as I think it can work out the main adjustments
>> are to remove a large amount of #ifdef maze and related gunk :)
>
> Just please don't remove the #ifdef gunk that is still needed!

Always the hard part :).

Thanks

--
ankur
