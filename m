Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F917E4B56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjKGWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjKGWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928D1BDC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpNh004902;
        Tue, 7 Nov 2023 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aimXOP9BDsvF0+TWIwejvrXImnlnRYq+8BzSM1firg8=;
 b=Z50LL1F9ShsDRZePiyL3wK/wOBpsJk+LqXeEpJ1teVHsI26robeakI6ZcP7tYhzfCMQH
 EvOzfiPnhHMV1wgucvnRWemqjkNFjBZxAVw30SRHs8GggSZYxKpD1rPXcpTcMaFxsoMY
 j4lsstqXm7xgBXWCamS961T6EGUo2FqO56zEb42zP+ADH2XC5hzDRolxb5IpIsUTI9pC
 LAVs93MIqtqx21KNHo5V8lCW3SOih1NbJZZGbueP1J9D5+LXtGgIeChRd61L7PPUL+rw
 Gt4878hfCs/dqPFnIcDASK2mgPMwLJnedLRdZEgjEc0RzQWO0a00ZpS+5h4i6Siaz6MT OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g2ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJYpj023973;
        Tue, 7 Nov 2023 21:58:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241fpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T46e/6KqlNzWqVwFvV0El9OUHC7F8r/SmjRiJzesLEJZ1cYvKsqcjnOsvCMSmiWbDieEaSy9+EeDPbjStrnTPjMZ0EcNWdk38Ocr1n8DWq+B14F2gZmEcer+FjbB/m44FELoZH3u+GdRPBxH628gm/sE/KNW3dmc6NK/+t5eNFjrGNaqQbsiCdGjw86t+Dj9/SSLTwfjW3AuF2AeOWV3wOs8i0QebY5Rai9WDmuZaTP+e6GpmH8SAJO9yGS9sOwE5pyjZ+RAPqZaDZh1wYC1pDZUQCgkn/njkxrwkl988VGwel/eC97rQ/uSI8a17kxlTN2fgIA0iVtBTZHoJPruvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aimXOP9BDsvF0+TWIwejvrXImnlnRYq+8BzSM1firg8=;
 b=CedbGH2yRQx2PT+JEqopNrYr4XMs3CmCIRs6b/iEvPV4H/6oakIBEA+/tNGHan8qxMp7I2KiKqB++oeB47GKrjwSwdiiHCF9OeY+NgK8XiH+7beT2ZsNSffqv9p1MS9oYU3rHjF6PuONLWOWRSR2wsZW1Wqs+2sjjrFWRlTTh7yl5TKsnQ/ghx41JMNWL4HizKNWNHSs4bWE9BwztUkpTFnTvqwH+s+ycdGhVWbMSwZhQzK0k0JbHuXpZKH2wFMuEM7YNomWoYCyoX0RWfKaAZedd7FjfQ6ePZQmn29UMokGpk8Ya8FLTu/FQJIA4tPMDA17sBG5VAPyLy9xWSXN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aimXOP9BDsvF0+TWIwejvrXImnlnRYq+8BzSM1firg8=;
 b=rIfwYZIEzDi+CYv9JDtfFNu2cIwZpcJhnQ6d4zzA+SVQJxqo+KtrxA8ju7z33xY9HlJLyinq8vV2ifPBzm0SgiLO6v0N1apAUsbeo12WiiMu6Okd5ezSJILRdar0mJakYqujbTV04Sjyi/1C5RPcSxtpZddQV9ShduaWiOdaKwo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:52 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 23/86] Revert "sched,x86: Allow !PREEMPT_DYNAMIC"
Date:   Tue,  7 Nov 2023 13:57:09 -0800
Message-Id: <20231107215742.363031-24-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 31da503e-3f01-4761-9e15-08dbdfdcba9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqvs+V0fH50c1poNIXaylWVIagXey6k8YfleUVlmPrHY7xbkVOOzEfS9HmwZXXdgNdAc7o2dbzfU9lGhwxukKLpSsL1imYBexnC1VWCXRWL0rTwEyEJO1howtPhXKuqUr3lryx9nnhwxAhYB+eNIF2nlSzbmF02GIaI2pzNF8Hp+ZeDFlhG+Km/jcMDqri+P3b9toD5KWoO+In2jhmfXZM0Pa1vPpU2oB2LG8FGnNRcoa5Q8kcBFJdmniybT40+7BYAkWxcKxr3GrM4WcNxQ2XOeJgWFCwgUf3cP2zuk5iZnVu4NY0iNzIOL1kzoKWIP2/4Mqp2N575DEjJ7qZAzKRJHq1+ORzgpnZkc1/0IvA24iBzCz9qIQy7c8HJPHEQNRTEmc2rW7QnhTlGsugQTeQ0iJQ9iZl7T+7qcb1nkLDP0xovRoI6uZpJzmWni8rYnKuElZ9zFidPioH6j3V4YUWsniPjfQ1vKRe1AnGd5qiAdi7BV003DQC350kYzPdNRGIU+k2A7v6jal5UufuJXOfHj9zuuBHzC0uimNIHbWxnm7VkwQelWFnz31p4RJ72n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?veJY+PpxfUXRXg3wYQf28Iz5Gp0oq57kMgM5S9B/bKIfTo+94LxG3RV6M7hz?=
 =?us-ascii?Q?IN5H21wYV56uxzR28fc7Lw3ulX7BXZ4iPBAyt74DhuR3TKUQtY1nlLQdNy7D?=
 =?us-ascii?Q?z8Gv8a5VirFgb5m/DKrbA+aK4e97toOSVETgukeRZzznYksE8SKfG2Wa+b1u?=
 =?us-ascii?Q?PTJ4fPQb60ZSbfaFw+h9bDuA6JjKus4ObkMWX+Z+uJrm0JBFTiLMXbIVSmhy?=
 =?us-ascii?Q?1deQlSdaUBdge1nPKq7E0CIFE1b40jBoKoWrIjbE3PI5TDJHF5VwNmMMY3Eo?=
 =?us-ascii?Q?1dW9l4iHpYvVLteqV9MX1KfB5bU3dAXpyj6ZxShNa0TqFY5ezvkKyjti8kVh?=
 =?us-ascii?Q?srAfr5pFHS3jpW1Fsr/uDl+DugoHyFF7eEfrdHzOgy/rWf7IhZzkfXdIHRnN?=
 =?us-ascii?Q?q06LqLbB/sr3P/Aulj5xfB+TKbXSgRyz/bmHF6vd6d6o8xvP1Xb9QLGI5Wkm?=
 =?us-ascii?Q?7B8E6sXAf1YpDD/EVLAHg34k6ZtfndpSqyhzDjwZwKRySbPB2dIOVyJyRbYW?=
 =?us-ascii?Q?1ZkQFmyJjjKDgm35r+W5Vgz7rB6o2bLNLDj2WSwmmLN29h2SfIoEo/zxzkee?=
 =?us-ascii?Q?7gyK0ICX7XZeuM2Ey3kPBNnsbhxMBHo71nm5FgM5ZietNC4dQCk2Xmux6x8p?=
 =?us-ascii?Q?56AkvGKSQsWhb657GaLvSON+IzaMl/pGTKZv7PT/5FhALPjpa4gHuGREtDM/?=
 =?us-ascii?Q?/iZeBhfsJq4k1bjqJHjbjHQhRSQIwD9efEJxhQzbSVX9pHQ7vaE+VVWLWykV?=
 =?us-ascii?Q?ifyhT4UHqkZbZQOGUnFTuOvau3Hc/Sk1ptTMZsB3eUbwYup5lsi9cRXxXMhS?=
 =?us-ascii?Q?nefUTSY+kGdMppfvVzSL4AHXtNUXdQFV/b0wHGaVFBCKV74ibh0p/i8W/PNS?=
 =?us-ascii?Q?++iOUu8udcVY1VkL1PJL4U7rUo/167RFIVDhjokVr+4LWy3SYxUkhcd3nzbY?=
 =?us-ascii?Q?SsuxSwhZgCCI58t+lgbI2wR9yG+kj2Gc/4t6Ftk4/NEiRaLnw9G+40wm0yzE?=
 =?us-ascii?Q?xmr+SRQhvPZ3IsdrPQ0ecU2VpUur4DlKDBu6zQHdcD+EdxdyQU3Su2BLjgjk?=
 =?us-ascii?Q?3Uxl2Pj14N6gU7JLVvxUHQNtFCVw7ZrFEN23t+htEr1LF7TxfQXYCW1FCvI9?=
 =?us-ascii?Q?X5z0/36gu4fyN+kE71hf9Op32EDhfKQysVnb/vcnOBseaY/D700do/qXDNB7?=
 =?us-ascii?Q?sletcPymiavEmujBXQUusiEBUZ0YbPijnZL/I2k/iW4lQtnrqSXwipLSdCKJ?=
 =?us-ascii?Q?FC6Y/i23m96eGsDkZ73z3wNjUl5QVGM+ZxzDB5odBrd70QEeT1UQwvbz3f4v?=
 =?us-ascii?Q?qDtRfKQFaxhOSqKGFQCBhOVB2kGB4ojHyWU+jJ+2HcpNjDVy3oXOltRZDOkA?=
 =?us-ascii?Q?ppzIVxAsKiv5vrXRLUzUnxuOClPaetuDP6vEbt+q93a+UhDVMVgePTRs7LoC?=
 =?us-ascii?Q?Nst93F54MwOlt/Uj/3u2fmpus5j/91yYDRrmFCdm4VBN3ej46EuLjomKuT3n?=
 =?us-ascii?Q?/TYkcnyP7/7DMPJ/SHezEO+kIkRVkUXu2wKei+Ojiud6PDI8YF6tIjGu/Keg?=
 =?us-ascii?Q?TsB63xFIY9FGry44dHJtaMx6dEktEPgxYOxgV7CJoHFlKNFmuI572CrcN3wx?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cEcStMP1JyU4NFf6Hx/79TOHXywXwaq0pH9ET3lIzBpYK3MRV8SPqwRL/pJp?=
 =?us-ascii?Q?JocVVhn0Ujm/2QB1ARk/XAS7Sdg+fLHIvxSlV79UYhKtT7i2RhE5xJYZspwb?=
 =?us-ascii?Q?FIYYPE4m0u/oiNtj5eXbgRhdYV0DSQmAHpXRUjBKQhnYwijrd441j5ZiUfSn?=
 =?us-ascii?Q?Zq68Q+XMZpbgRJ4axcixMFl1j6ZSgGyp/KjK2KRjXfxpLb+d7YJHFJWSZWiz?=
 =?us-ascii?Q?bv1gEPtFZ03P9r/25h+etr1tbXg/9qeb8SQOqdMpelV4HzkpSvT1xYtzY5sR?=
 =?us-ascii?Q?d6MWBQjflA69eW9dt+XyGo+YQyb963SQ8re2QT+dey2YOz2OuCtOwSyXhAuq?=
 =?us-ascii?Q?Rb08aA0C3gJaIoDFMrpTmPPLwiGSgcY3wORnageqsdauuvHntHtKtLUXGlEX?=
 =?us-ascii?Q?GLYXMaxBd1Lz9l8MCPNh8Ow7Oj8x21/K8vXUcONVJKV2ikIFVHZl3dBV+4zO?=
 =?us-ascii?Q?8UdriyuMKSfhTmsiEm09r2TouzSHMGf2Jb9K93syZBkh3ueKxAWjwU23R/7/?=
 =?us-ascii?Q?3Vya8PlkETldHAylQCJePeci2550+KMiRHEOUPkv2hzZkrnJtt+rYwiIgQc1?=
 =?us-ascii?Q?U1zI3cUNvLFDa47cUxGLcGeHCAu/oavy/UXcb8floWBVH5NHalEaG5l1Tgu/?=
 =?us-ascii?Q?E8jn7aTg5s7ywm/RykwUWt/py6S9C2tNE0SwQ74h7IFkLVsvbcCPmLMwU1Ay?=
 =?us-ascii?Q?m9gDpW/YU7uf0gaKG3CLDOX2Jt+P8A8HNH2B0zqbX4Y8eI0SB7bBOpopc5vR?=
 =?us-ascii?Q?BtAZYEG7BZUBdSHZ3eb3+DgXO89H4N5j+jAYE0enj6/Ctz4+nMziauWQ6PNV?=
 =?us-ascii?Q?u26z9s8tiUVsMcJ2jeFguVK49SjK+uwH8g/3WZWHH6RyR+7At2pDoFhG+vID?=
 =?us-ascii?Q?RjcinhZqTpNLWCbvOstviiaX4z/0N8MuT8qNsq3PdFa4h19/68iO/BlDznZu?=
 =?us-ascii?Q?3FR389gvtgaJ5oEPcapXTbQWWfMptDEEjkTRtShOIJRqKisQ/carmVeinEKN?=
 =?us-ascii?Q?Z26CRQ5N52Ai5MujpoFplNwHDNd0oesUsVVwcvhNhEkFZThlVGX2feFYr4OX?=
 =?us-ascii?Q?EtD3Hob7SA6Y+B6iaMkZQhHqKqpqeXh2S8wR43yM8tHa743cD60h8xI7AW6u?=
 =?us-ascii?Q?kwLR0hefYbd2sLYGWG7O8YpT9e6+SelnULFzuJmtGsLzWFfDHNxArjakD1dI?=
 =?us-ascii?Q?K+ChyOvQjHziwmbyYCIx/dJC5RHK14STSyglDMGQvQnoRAgOreXffgqlnQA+?=
 =?us-ascii?Q?IVC18on2KFdcS/ZHfmOaL09ihnyzrzIgtmVa/KFcA1MKfUY5dGbPNrKDCaXI?=
 =?us-ascii?Q?I0iw0H6FSHCqDzQ6x0BFn95yKhhh7L1DdsSBGv4mWDJG2SYakPo2lHGqRm+p?=
 =?us-ascii?Q?KEjJjkjottJiUatr/tvdavv77TOf+80BrWOdxjiG66l5fvgmRXvqyQj8fFId?=
 =?us-ascii?Q?5cb4tqhUKgMG2vWYyjlo+8iTowxFAs9EMJ1RVIauNyiYFFC/faGdFgJGOG/H?=
 =?us-ascii?Q?KsTeIASnjopluWHrObDHViEHa14x4BtYmS03Ha7mrrJW/o/lSclw5oB/9g?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31da503e-3f01-4761-9e15-08dbdfdcba9c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:52.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42KIVwHYTth/KTaHAH5EvKuflfQv26rGaUJNYykRJ0JgHQ6NaVwzoRAoS4iS4zaJFh0hyE3tD6TxqQJEEVKqqbUYiXiyawkgkS1rC3ljtM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=939 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: VtLRUQLlSyMbGvOyRv3cshKfnvrdfdNY
X-Proofpoint-GUID: VtLRUQLlSyMbGvOyRv3cshKfnvrdfdNY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/preempt.h | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 495faed1c76c..49d2f0396be4 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -111,13 +111,6 @@ extern asmlinkage void preempt_schedule_thunk(void);
 
 #define __preempt_schedule_func preempt_schedule_thunk
 
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
-
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
 DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
@@ -126,6 +119,11 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+
 DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
@@ -134,16 +132,6 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-#else /* PREEMPT_DYNAMIC */
-
-#define __preempt_schedule() \
-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
-
-#define __preempt_schedule_notrace() \
-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT);
-
-#endif /* PREEMPT_DYNAMIC */
-
-#endif /* PREEMPTION */
+#endif
 
 #endif /* __ASM_PREEMPT_H */
-- 
2.31.1

