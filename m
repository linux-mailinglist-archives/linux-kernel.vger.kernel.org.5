Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A97D1A35
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjJUBGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUBGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:06:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805CFD45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:06:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L0Kq4K001778;
        Sat, 21 Oct 2023 01:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=QKAZMD4BN/RfhE+GJKy2pleCZLpCrS0gwPrjpnbIDek=;
 b=KdbOcV2/wFbTm/uabdfPb5/MlaoLpXnfjbY4Kc3H0fBXdk7ka10vpb+E4+UkBaNHcLmD
 TUoWXZJgr3tTzvAUiVRTnlbBA5AtFLyfHaZP3Q1yCU15DwPMIgpDU4ByUiYUWCW6v1Lw
 bw4yaVZ7UdCzkTZJoj5vqYjl23kpVU6RtX2QeJapGqJZ87+g92mFRB1+nsP5+vAHRPm2
 IUwDqHsINwJd/sC00trF1unQTjyzsvLA1/ZINGI0UZCn9uCIn0hVhgUBSZGVDDlPY2k2
 Firf/snn7dhvdRPN+RI81R4EcJ7SJz1ZoMxPHu/0jleVF7r6/XmIoEx3ABXS6+s7lraE eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwdaxau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 01:05:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39L0wmlI012697;
        Sat, 21 Oct 2023 01:05:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw6pfxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 01:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuIFUWE/4CEGulXiaajXpFs/oPHR1ej+vYeg4Ju+mfvvpeyGQUL/Y+zOWqrhVr0JSz/YTHjaCzSj0BeeiRQ5MYeT4YYjI0hlKg54ECTVily/QTNhijb3W5Btfj4ukwFXyhcbhdjoPGVxy5axG7uzp1nnnGM7DLxQRTHBNoVlnQB9FDhUaHCv7Umvw6hOxsujBHq4AxPSDUD8c0TOFZg+22RHC98Z5amQWCZ61EiDnRS+J6YDVwrLs0+0npAtjmeuX22Um7C7dBcb5r9dwOcaGiKU6cyLvGBMGDeKSE0mCvF1NLbdtGdVKI7ykpxCpDKBvwJOnf7j7dlOCADgDWuGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKAZMD4BN/RfhE+GJKy2pleCZLpCrS0gwPrjpnbIDek=;
 b=XXzEtYuXTzGNhEU6ONx/4Px2Pz20rjLcHvtWgm1fkVSi+tuE3L0uIvBs7YuI7Oqn+BOF40aPAAQd3o1uthcrCWphVdd0hXiyxeN2DfnSTJbNBzUtXzWm/1lTjK0unXAkHxom5lJz2+of4a2rZk+NTE7wTh1vvqEZKFI15TzDhdsO465J/Gq4cYZBNbynpYzZ5PHHkOD5Qupdl15y87qBHUPfIFPmx9F1NAvS1LXnrQccUSE/4zNZsza7DoayK8BseYipKZY97JhJG+BR4wCP8HeZqNYD4f0RdwEPVy58VNGHWtjny0YLH8QFkXuoD8s7B73arUglZzpBE3Wk0f0W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKAZMD4BN/RfhE+GJKy2pleCZLpCrS0gwPrjpnbIDek=;
 b=ci5js/Y2Z2TaUghn+TNpVezPMihJZkKksbsVIw0UI7gEfLdJHpWHNARFj3r2bP5xJJ3/C55HBfbuV8EBv+bXIKAYArOX1UEI2ChbBSg/L+vmL9yDBCaaZhjLO2RZB+378uf88yKuFoTswrQRE4y/0lMVfHQNfFOOGql5vaDI7FM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6766.namprd10.prod.outlook.com (2603:10b6:8:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Sat, 21 Oct
 2023 01:05:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4f38:c0c1:ac6d:f024]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4f38:c0c1:ac6d:f024%4]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 01:05:25 +0000
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <8734y74g34.ffs@tglx>
 <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
 <878r7wlx7d.fsf@oracle.com>
 <ea5c18ad-c25a-43d5-b2ef-ec64117dc38e@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-reply-to: <ea5c18ad-c25a-43d5-b2ef-ec64117dc38e@paulmck-laptop>
Date:   Fri, 20 Oct 2023 18:05:21 -0700
Message-ID: <87r0loiy3y.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: f204b90c-8668-4310-65e1-08dbd1d1ce85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6chZPYL9Th3x6Zzto8DZNXCCqCsAj9mzg1yvmmJOBivxrKMAey0KqSuz6T6XPEQ+fWslXlavJGPjepstHrdYdVSj7hWAS2eURiSnWkzLX8Ueo1fgrg/uybRUjOxnQpJ+S3KcECc29wSbDn1EB3V3vPARlMtPNnY2VbHUDCKWBJkSvdfDbzVeY+sw0MLkH64WxY3sQvu8R2b1mVgX//i7brch3H/VLVT2Hwb7WRyQrvPzt1kfuHUuJ4JzA7sEQ4baNOgzfvVvf44mSPg4xYERaPw4WE0byV3Bm6NnMAvEfRhUuvTSBxtHUN0mXWPPNgXmmF2tCixgeUK6c4UonMcS78MP24fMBM/U+vn4NOgxdrJcjj7gOkohxzuKrgH/F/9I8OZgPyTr1rkjSTS4ePVbFwmYJpkVxec6zDjCTbdyY5gGmTuzyy8wdLwnTnCkuqHIlINbmFrHKQ5LfZsFFmcLNPurawGep4VpbggetU3FeT6ZjS6X4IHxmGRzfXj0brSEKxfpiM5scxzXb31X8j/rdCeYxNLXg7RJIxtWILtccKMYtwN+j1h9axMQcVRo9iaovRKkKZPwBLZvyCu7KL29CePNWKSSpzzWO+CAkJp5kHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(86362001)(4326008)(38100700002)(2906002)(7416002)(5660300002)(26005)(2616005)(8676002)(41300700001)(8936002)(6486002)(6506007)(316002)(6916009)(6512007)(478600001)(6666004)(66476007)(54906003)(66946007)(66556008)(83380400001)(36756003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAlOcd1N6KFraUvQx/Brf0W43J5cfr/mKyZ/iNmYTL1cYnLAiGXEP/ugnn++?=
 =?us-ascii?Q?BoAknwUc0oUn3z2zEZ3aRLwU21fd33xsvFkybpz3pBly3/1H/a5TUIxlJxRk?=
 =?us-ascii?Q?btZXyCcTOxdjcsbXdI2w1RBRl3JeVZTjdNpPDMT+tBLpd/FuM/uy6chWUhZE?=
 =?us-ascii?Q?/TsHHrV62XkSQhleHscLGCTSzQ9U6zMT0I76xwM1FaPK6kbQqyLBn6v69ph3?=
 =?us-ascii?Q?mvkgCtkMSrccGEbIcym+3w8xRWHfWZC7GoufJ/Zdiym1HAkwMx//qU+E11QU?=
 =?us-ascii?Q?7QMCJl5OAcyTUS8gcZ7xxEQGNZz6IebWLMoKGTJ8uovuhJqe616TpfK282Mj?=
 =?us-ascii?Q?/QD2ZUcZ/bwR+aO+ev9Ai7GiK9r/3/+qdiBK8KEybpi6SNAQXLYP2/xmTV7o?=
 =?us-ascii?Q?LNfOHA+CsI1Dppq1ivkDp3ot6qPewHbcg4j5mCtm3EdGdZ6uia8uoJ68u4uq?=
 =?us-ascii?Q?tMNs+sb2fVpyy2sea+Ay72j99XGwH9nqUZb6hi5znL3SeYnXcOAYDT3OK9Ub?=
 =?us-ascii?Q?kErv6bRAcOT4dumLjEneqLRNga87UrfOIvYYwuYnU8UxwrWC1qBCdNSu+umJ?=
 =?us-ascii?Q?QqewPWGjjzfwBQGj6I0hiONM5vP7pUa6ZutHw5RaTFnXAC4utwKuDCUdfbou?=
 =?us-ascii?Q?LFQ3E9w7MExoqhUks+GpyRKfgwmWyJG54yvAQT5Rwhv/jUklrIDmIC/HrreA?=
 =?us-ascii?Q?ETlwnTlGbgK5ME3SuOC49R3bbe736O3IbDwwa7FuSuTFIEcLp/tSqUe3lZ2Y?=
 =?us-ascii?Q?h3qXrAI1LBglFQeff7EBobVsbvmwKCvadk0qRqsIY1/1Om2qTW3ev34F57FR?=
 =?us-ascii?Q?GMkZAe6KojLvrOrIRryDFHsR9mcNZpLtbFSCRahHfiAxUrBvQuWy45roVeuj?=
 =?us-ascii?Q?71d/v0+I6sghrY0x31lrvOgkKhOpOmmhOUVndDXYd8Im6tP6kYhqxqVnQNKT?=
 =?us-ascii?Q?tEW5ntxZnTvuEgn3fa1n+SRZgY/J2/vja509goKjM2QJlfMZ2J19bmv1VuFz?=
 =?us-ascii?Q?231MEyN6uP6A3noZuPYD813iw0Rtih5vLmGR0KbCUCciA7+LVGzfiiHhXhf2?=
 =?us-ascii?Q?8/jvXFNBFwl4R04BsN+BCOHqzqBkN1fmbA2KtCL1gO6DBmXn0UsiKALoBh1o?=
 =?us-ascii?Q?Tqamnx3evSRjyifQILGFeg5jJOqyj/5XA8Txcf34VCpMsSHRctkSeH/3cOKA?=
 =?us-ascii?Q?B9RnIkoRXrrC6oZiNEdMSCxVzP9LPpdm7jKN/eqEiRmixZxlT/MxS3NVk6bt?=
 =?us-ascii?Q?XfmXsJmmpez6TGLAZlqwsZgrBSrOsU1IMHaCEKkJWXQpWapTDyP5iIEP2OfA?=
 =?us-ascii?Q?GPp/EIHt8SolLLFelXa/uZKrS4wAtczSPvp0jIFwow8uqodrsbaAYwowf/s8?=
 =?us-ascii?Q?8E3EvakMG+IVB3L+hG5re92H3vvuEQod78r+wOl4de6Tbmxfj0m0SKaMb+vi?=
 =?us-ascii?Q?/goGmQcor4gPw7EmOkwcs1d2XZzsNniBig9JK87uSNIs1wvXOhJWRfTF71Y5?=
 =?us-ascii?Q?5+E+3e0JkVU98NB6gR2anB6t43tIId4Tn4W9UAmlxrH07yVDQPc37VFl2wVl?=
 =?us-ascii?Q?ufRdERjt+as0ws+P9K0I2BVgE7fAxo3o2Z310Run?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RwbbyNKjEMw40GxnoJiX4Ul2zfNbWOnxFhZs/eHObaz27JAd3FAUjc5F0Hxo?=
 =?us-ascii?Q?JLmofJuYl513tnN92FIGuQro5+npQu9K0IkIZFUJqNPmBvAPKuJEi+Hi9gth?=
 =?us-ascii?Q?PiI/45wKoMa1iFU9evKjTEak8scTFYHSHmy2p9KJp26UxhT2m13iTgriN4mN?=
 =?us-ascii?Q?YEax6ZLtuWhzwoo11GBvm5TnzFLMCJ61y31pKtHZcWOCnOlhx0lYN60KLUPU?=
 =?us-ascii?Q?6DvuBo/DqDmFro6GxugaS80cmh3URTqjh7jmVACXTXsP0rQ+MG7DilTXZPTv?=
 =?us-ascii?Q?TPh16CaE48zN2wOyBeMC8NQPzaJpsy9I4F6FjbcTGzo8YMBCHE/4BJBWedYG?=
 =?us-ascii?Q?gvHob/xTYvI9iZ7ZfJOdX0C/LSkG3G4xz+7HInljNvD9k9hkzbKFQSJdBoWa?=
 =?us-ascii?Q?NFpYMCuQAy60xUlRq4Z8SwHR810CG4t9cGOvjdZ1tss8ACQXnwfSJH+wE/Yw?=
 =?us-ascii?Q?hWPy6F4BmQpKbWey81YSqhRQyE5j4d1DBYADYm55r9Bcs1gVu1VanleY7B4O?=
 =?us-ascii?Q?YSYa0yCQ4MzrqaSUa35jzhhg4EwCRQTqr+iHQbvEh6Sm1FPcdsBMYQjH8ubr?=
 =?us-ascii?Q?zMJmlX4XgYNlD24e+WWbqkNDmGma+HLySRbdAtkPnIiNXnbwvCQkNqQtyWKo?=
 =?us-ascii?Q?PRwF5DO6I2cdUqJ5otj9u8MQ1ZZzCkBhrwLzYIbyHIOdkdJst2EUF/idmfwi?=
 =?us-ascii?Q?SbH00+NEMYER4JZWo89dsl1dsomblOj8hvYcbgLVXHsLWapUWxQl1bfIzrPW?=
 =?us-ascii?Q?hStAgIm4rrpaDA4XhW3S/Wagf27zzxnJTKYP+4yddhO+rmeZGAEuGZn6KThb?=
 =?us-ascii?Q?kSbcC92R1NIh5iozYYLyX3fCEAFhHyfwbwjQvqi5rwzqs+0kdyNYKg4w8uSw?=
 =?us-ascii?Q?mO8qhLO/4u0sSqB1JOTQ9X8VoB9/nYy9nK5aSepmwJ5Qu8cmemEPvSjNVPGu?=
 =?us-ascii?Q?Ccz/vOoRu5ErD0ZgYl6CMSFkGZKJgQqMEJWlju7pBPGv9J7JZjUcErrPzYCw?=
 =?us-ascii?Q?bwV6CGqni6Ldw2udk39M/A22RFrLEyUjYTC3ByWxqlxOV+nVTftBeclslo+X?=
 =?us-ascii?Q?BvCLjNa+T7rZaCCnJfDZMpf6YtCqiznG6PUAQzd5OdhjthbL/bmocMFmBFa7?=
 =?us-ascii?Q?TcLydXhZoxdQwahDL4CirSHXB7Ee3SZPS9uyvLzjUbY/ghbr+lvHGgpvkRvR?=
 =?us-ascii?Q?StGS/VyRFQMnMCjIo6RYsquago+xKouDw/sl7cypS10xTocdXXMaBpE1mGMC?=
 =?us-ascii?Q?AUXOePqCtrwnVoMhnF6a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f204b90c-8668-4310-65e1-08dbd1d1ce85
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 01:05:24.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DRF3GpdOTAhBC8xUcjeQzNTWiBR+vKPVmnOnlUUIZVTtXnHAS//P/vxeya0Mja2oP6pj7bd/JxQ89tLHbuiY4pI7YOc6/p4CB0ixBiC8IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210007
X-Proofpoint-ORIG-GUID: HDcEAC1SfSy0InMMsSo4clLs9uOWXdd6
X-Proofpoint-GUID: HDcEAC1SfSy0InMMsSo4clLs9uOWXdd6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Fri, Oct 20, 2023 at 03:56:38PM -0700, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > Thomas!
>> >
>> > On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
>> >> Paul!
>> >>
>> >> On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
>> >> > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
>> >> >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
>> >> >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
>> >> >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
>> >> >> CONFIG_RT or such as it does not really change the preemption
>> >> >> model itself. RT just reduces the preemption disabled sections with the
>> >> >> lock conversions, forced interrupt threading and some more.
>> >> >
>> >> > Again, please, no.
>> >> >
>> >> > There are situations where we still need rcu_read_lock() and
>> >> > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
>> >> > repectively.  Those can be cases selected only by Kconfig option, not
>> >> > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
>> >>
>> >> Why are you so fixated on making everything hardcoded instead of making
>> >> it a proper policy decision problem. See above.
>> >
>> > Because I am one of the people who will bear the consequences.
>> >
>> > In that same vein, why are you so opposed to continuing to provide
>> > the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
>> > is already in place, is extremely well tested, and you need to handle
>> > preempt_disable()/preeempt_enable() regions of code in any case.  What is
>> > the real problem here?
>>

[ snip ]

>> As far as I can tell (which isn't all that far), TREE_RCU=y makes strictly
>> stronger forward progress guarantees with respect to rcu readers (in
>> that they can't be preempted.)
>
> TREE_RCU=y is absolutely required if you want a kernel to run on a system
> with more than one CPU, and for that matter, if you want preemptible RCU,
> even on a single-CPU system.
>
>> So, can PREEMPTION=y run with, say TREE_RCU=y? Or maybe I'm missing something
>> obvious there.
>
> If you meant to ask about PREEMPTION and PREEMPT_RCU, in theory, you
> can run any combination:

Sorry, yes I did. Should have said "can PREEMPTION=y run with, (TREE_RCU=y,
PREEMPT_RCU=n).

> PREEMPTION && PREEMPT_RCU:  This is what we use today for preemptible
> 	kernels, so this works just fine (famous last words).
>
> PREEMPTION && !PREEMPT_RCU:  A preemptible kernel with non-preemptible
> 	RCU, so that rcu_read_lock() is preempt_disable() and
> 	rcu_read_unlock() is preempt_enable().	This should just work,
> 	except for the fact that cond_resched() disappears, which
> 	stymies some of RCU's forward-progress mechanisms.  And this
> 	was the topic of our earlier discussion on this thread.  The
> 	fixes should not be too hard.
>
> 	Of course, this has not been either tested or used for at least
> 	eight years, so there might be some bitrot.  If so, I will of
> 	course be happy to help fix it.
>
>
> !PREEMPTION && PREEMPT_RCU:  A non-preemptible kernel with preemptible
> 	RCU.  Although this particular combination of Kconfig
> 	options has not been tested for at least eight years, giving
> 	a kernel built with CONFIG_PREEMPT_DYNAMIC=y the preempt=none
> 	kernel boot parameter gets you pretty close.  Again, there is
> 	likely to be some bitrot somewhere, but way fewer bits to rot
> 	than for PREEMPTION && !PREEMPT_RCU.  Outside of the current
> 	CONFIG_PREEMPT_DYNAMIC=y case, I don't see the need for this
> 	combination, but if there is a need and if it is broken, I will
> 	be happy to help fix it.
>
> !PREEMPTION && !PREEMPT_RCU:  A non-preemptible kernel with non-preemptible
> 	RCU, which is what we use today for non-preemptible kernels built
> 	with CONFIG_PREEMPT_DYNAMIC=n.	So to repeat those famous last
> 	works, this works just fine.
>
> Does that help, or am I missing the point of your question?

It does indeed. What I was going for, is that this series (or, at
least my adaptation of TGLX's PoC) wants to keep CONFIG_PREEMPTION
in spirit, while doing away with it as a compile-time config option.

That it does, as TGLX mentioned upthread, by moving all of the policy
to the scheduler, which can be tuned by user-space (via sched-features.)

So, my question was in response to this:

>> > In that same vein, why are you so opposed to continuing to provide
>> > the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
>> > is already in place, is extremely well tested, and you need to handle
>> > preempt_disable()/preeempt_enable() regions of code in any case.  What is
>> > the real problem here?

Based on your response the (PREEMPT_RCU=n, TREE_RCU=y) configuration
seems to be eminently usable with this configuration.

(Or maybe I'm missed the point of that discussion.)

On a related note, I had started rcutorture on a (PREEMPTION=y, PREEMPT_RCU=n,
TREE_RCU=y) kernel some hours ago. Nothing broken (yet!).

--
ankur
