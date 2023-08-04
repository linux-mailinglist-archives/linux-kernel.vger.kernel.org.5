Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46498770A68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjHDVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHDVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4F4ED0;
        Fri,  4 Aug 2023 14:05:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCYd1010719;
        Fri, 4 Aug 2023 21:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=sJaWF7pnSKeey37a5Z8iTxypuK002o6eMHAEnIzLK3Y=;
 b=uAQuw1u07sC9Zsb0eiiVtcjCdCevPOskeatJIUAv/TbBsv1NW0Meij9fTajPx37z897x
 cn/0aExBsUz7/6tPgDpYwXsJYwSFqdSPZEv9D1XEn0+ewAmPTRB9+H0qDGe9Pt6cqinv
 7nOEtu7XXsHo1RysfABHM5ucqQU5TB6s2WYvXtL7f+HxHyDUxuMbX9NGW6BM0o+4apY2
 Jul6RhGiNMV3gr85IK5Ph4pSMteAoX1wCjtavS5nN/9LQb4H30jYOyQfJoHsGNW6jR6N
 TmU6faSTP98MtFDiX0wu4Pi5FwX9yD3HR35/jS2M5+9IQx3RoB85mI33yv11ly+DC5NE CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav4p0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374J8tUt029588;
        Fri, 4 Aug 2023 21:04:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29nqbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyehfNdlZ0Uno0dfKksBfrdZgYYYNMTotnuEK6fMuNdF/P0bUscwHnIIAirUgZSPhrIAji6tzZ6/K0nxWp6jtCpRIXIXneV+RPDfO9cpDeSjaBJWIR+Ov0BeQVb+Vp3k3pkHg92JaIsC8ueT7Ru4sTxAUTTOAM68fHjgyUi0EWuRpuHlqNHb+gi4nauYcbnAy5oxp1DcqmR5v0usqPkOtGHrR/zsvV937Qzgv1VOj+9tlT6WL0WaZwtoofk5vaJNQ9U6mxcRFoBfnJe6AjA4n7UkMZnSEqaanUMFhyNEoUBzzuUW+qypCReSAChRUQqWdktf3+FRnkU7bwwBoCs1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJaWF7pnSKeey37a5Z8iTxypuK002o6eMHAEnIzLK3Y=;
 b=bxfyaOhJ/CW/Fusl1T2eIAilJLsRYG/1o24+Y+f0G9ddIBVLIDZs+H6GzmuMfcloxFXTJRQaRqwT+840nXcpd6FtBDvpbR5tGHFgcsXmKKeQjq4Q1sVT+brVjHMr7MwRTX2NquVOrP0y/VlpX2GsogTEZMsM6ZFGsQKvN1Y1DN8wTN82ib6AG2zxgZnSr1/vY7vnZKu+dJQOg5Hu32LwIP5/T4rK5sg1Y917YP01uqRsgB1ihlkeTh83OcUuTy3gOj2bkKYbed1jnfitTe5RHvZwfdH7bTlXQS069yfwm+i2pTZCoAhxeCsU4ud87f1PJ0aVwb551pRwmivElTHFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJaWF7pnSKeey37a5Z8iTxypuK002o6eMHAEnIzLK3Y=;
 b=zVnTs8zqgMEQDdgbnXZfLnjYPD/2+sFX7uuCzWESWmcejHVMeUQ9N4fD2DkDgaNCxFnAuL18Dm5b+N3vSuTTjWp3smZIy0lSMFZmYKCfKEhfexlrVzev4z9dOyLD7HuZR80KEY1Eq+i4tj551dRBxSj8Hn8bq+afAwFk2D4NmtA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:04:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:18 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v26 4/8] crash: memory and CPU hotplug sysfs attributes
Date:   Fri,  4 Aug 2023 17:03:55 -0400
Message-Id: <20230804210359.8321-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:8:2f::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c7fafd-cac7-459b-ace2-08db952e5e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CHmvjDMxoP6h5yJH/Si5VT5Hg95Jy4lFjtF6t3aWOW0quO4cOQGGP0VGLGM9+lQi5SP1UKY8z67Z3AFGYsfcLMn0gtr76rn8ZmIW5c80Yo7UhQkANcAkT+CINwHQ/BFETkltD8E4l6ZUEv8ZK6V0hMIUPNu0Fp+EO2/iMefQzl7BLaiGpr5FjgYQNSqapL0BUDm+/dSMdR54UJ7J3UweI3sIGMdFJd9+brX862Ts+rtzKS9bgqrfkrDvtqQbkwXJ0uVleFUK4tZNwb2020TPUfY3o5nKA8xtOX7weVSCEqVnpcZ1tY7qTu3x8oXFzpq74wfldaI5j6ecvvLWx5IOnZiqGuYlSo9XSsillHRj36H5ZetF2ZWBeLTznQyv5q18POLOpx74qqDXCHZl11rCoxSX9dOkjBuibifUXaVVLwu1VKU7UfCnv335Som7HHedGpHeBp7prms3NQt87GEXmG0nnTOW5Th6Ptz94cqNr2ZcCmOWa4YW6YfDWqlvwvLBjAZDfTBbdKsbVWjAyXt2kE2PUKu+b0WlRqAl0ZMVCWmfWFknsOehUh4ejJ22wkyPftuDglB0msZ30SFcrEG9xCFfzUSiYsVsFp438ZA3Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(1076003)(2616005)(107886003)(26005)(83380400001)(6506007)(8936002)(41300700001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(316002)(8676002)(6486002)(6666004)(6512007)(7416002)(7406005)(478600001)(921005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lz7keIZDMmAzoKGlIXRkdxd6qKEl6g7IKrXfMyYNh4anwFfQEd+Q9AaxNSF3?=
 =?us-ascii?Q?3ey10klObFy5eNepL0qj7Pxqb1k/Oe8f0mM/ljyiUk2chGm3XapiAfGag4E6?=
 =?us-ascii?Q?XpOji/mDhLys1pkMMFeA+8OL1CP9cTWtEjd1Fulcx+A1umQvNrm+T6O3+Hpm?=
 =?us-ascii?Q?n07BImci6yDQziDnnDBRBQg/1eLIOCyehi/oA2PlRnUJOONTJmVDs0YPMU+k?=
 =?us-ascii?Q?5hxve57Ur9nvCK3ibujyO2c04g2xR730YqFfH/1ZZC6V5G1HJwZPBU+3re4e?=
 =?us-ascii?Q?11gRf2hwY+z3bTDCcP4u4j1lgJ5Vi/MGco8EjsaZ0fWE8PhjH+V/TjfhBsVW?=
 =?us-ascii?Q?e2PxhhvjclxN6dAYbxJWLikiuGY85wxGYucE6dR/3oPUQ/2VgfIHU9zqbbUX?=
 =?us-ascii?Q?+mL3IRN+MnAcq79vp+BgoDwsXY/sVjGOoSVm/v5XBs74Xw/KZQRJelGoNmI/?=
 =?us-ascii?Q?JeFQfzgSnvLq8yh2ijMQAXLbdDKQL71o8HsF1vi03DC2jv0xVpYuSnA0xIrE?=
 =?us-ascii?Q?H7JG9VC26MEUtdhpqYatVIhqbVQBaRNMrXjhRo0MgOSvF2S9RQ8uAZUWYlLv?=
 =?us-ascii?Q?qDv5Bl5/HU8ojXpumk74QspPNRCPKqJ7eS5w9vw7my4/FMZuv39TNzzk3sAM?=
 =?us-ascii?Q?D0fKf3tyfGEQZonBZyqQx6CI6+PO/R+LcyuJvTC5c2YCUP+t75ooNoDoC00A?=
 =?us-ascii?Q?mfwC+B+P3zZB3voEfFm90lR6E0GNfFaB4Nd4a7zxXRPcdlaE/v5KomQfHxTJ?=
 =?us-ascii?Q?5gHk8SWnBUZqsyiRZIyjjgvF/rlS4DtO8Z8nwEDfH4fQOK7jlL1bM+UD8V3t?=
 =?us-ascii?Q?7mNwFPAtPfR3I5pKz7amZKYEBgjDNP6d8k+YKg35A4BTWJPhTsyhV8CNVsD4?=
 =?us-ascii?Q?IUyy0XBjEg2DAGzvcN2NINpvrcf8hq4OBAhQb3wrCgTR+9shIwmdOOiZYK+q?=
 =?us-ascii?Q?OHy2511OEDZ6BpKMozK7qyLf16ifc7bTk2hm88f+0/zthanRNg5JSEIaTFQd?=
 =?us-ascii?Q?CnxAYeTbtJlD8hnAJsE+w0jSche6jMnojIr3MqBFroXhdVLbBJNMpVCJxzFI?=
 =?us-ascii?Q?xuGTZp/DrWpkW0Th0711aVyJxyeYJrfVK1YuAv4VcyddJw4B/gr0+g4ZB5d6?=
 =?us-ascii?Q?xfdmDxn9ov9oo4MOn5i7ycKjFN7sD6Y+hA3Bbe/Z0jNaj2Ubd4XpjQV1ziD/?=
 =?us-ascii?Q?RM/hVcDn2phNQltO/eY+KDZEJcskCiySUEJXDiZ0Bep5AUeHgXnHZ+5AgbuD?=
 =?us-ascii?Q?eO/ubd8H7zYGr9AryFaLE8Z9QEGaNH3oisqecjv8rC8oZeLlGCZpqauqux4q?=
 =?us-ascii?Q?u/KPBSiYLhCRymKiykLDqLm2MK8xV2vyMJL+mpEYwsVPzr6/u2Y5iTT/aklT?=
 =?us-ascii?Q?jZcSenTlI2Veas/DpoE17bpFV1S3ntjhLKRahw1+XcrPMcs8IQrc9RuopE+e?=
 =?us-ascii?Q?jiXqQag6FKJrxi+0YqS0C067dTc8XvuW1AWF7qMKmPYt8/OJ0RIAM9gaRGo9?=
 =?us-ascii?Q?t6N9WpxQeQU0l2/L1cDULnUztG1N6Nm6+XxhfCTNCfcysrnZ2aH3vkwrnXQz?=
 =?us-ascii?Q?Qc5/W3TXOHMxbyL7dDzI4EkjbJ71Jn8Nbk3d47VpJRkA6ZYQVo8Y8eHUKvhV?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ej4FdOcOOFy/GYYqm/AjJSYHeoMdvgkBKgq5q7p02mReDGzJSKhdjwD666ml?=
 =?us-ascii?Q?eLNtvipq3PFdNQ9AYv8OSRFNcGSF5MoodqlcTb3pUVx3/DSQdoCPjNZ7duzk?=
 =?us-ascii?Q?gPHkoXru/4bHCL23EA6dcHILH0EQfLurPDA/VyuCh2Yltg7BBdBXu+ivAX+3?=
 =?us-ascii?Q?DeI6j+e7deA88WK8iMuPeK7e1XugXDAkPkbe4vqZSjJ1Qdt9M0RUq+dmewZF?=
 =?us-ascii?Q?X6Iw0mEZ7qvsPrAhctyeroDivILtG4uQW6h2cbhzn4mWEXUoo34YlV0u8mIh?=
 =?us-ascii?Q?j+HIsF10DfKRO/jgc0m0l3PPPIqcHeyxDg0pM1GRkTM3iTwhqB7UcklorTGs?=
 =?us-ascii?Q?bETdJnBuQZuzPF5EC3r+s2MeHra8dfXtpUCgvKZAKZEIYEOF4O/bWCBklXuQ?=
 =?us-ascii?Q?akWKLCeTEFCtzGj4ZhuS7gTEvBAA+f42UQ23uk2oxosGU9+hVyHiDFH65sIJ?=
 =?us-ascii?Q?Igu6lo1xbpCq3EB/pOCoJOv9Vra8Wz7OqvDp0orwMOGJgyRqlWTdgkbk9lrd?=
 =?us-ascii?Q?nEkXEljcOyNFygzWXicPJAXy/SthPB7eW8ojzTG5dcSgdh8w8kYmvHoNFG8a?=
 =?us-ascii?Q?u/eaVLtFxHtNtzlU4L7FJ39OGaUuLn4sDJDbQAy+ZorblOOuIAkyX1ZNA5LG?=
 =?us-ascii?Q?Mn89MrpXn9of9s7R0XKiQ/I/S4OsUG1eStpFtcENGatUrGlnEb/GW2dPm9fw?=
 =?us-ascii?Q?5RcmJTybdQLLfmkjn7gyOioiieizcyO5dlOduZn0nqZBCj6x2W0PSwzBNzlQ?=
 =?us-ascii?Q?Unz4+NpfnStWOvkhNlAR/g4soOcl6y2DQk9Dztv20DIFt7p2vvGpQrbmrxRS?=
 =?us-ascii?Q?8U4P3rcjpECo/+ceJXYqk32kBtgWFG58pgkOvug12ni4VBpclNvyDuG4Wkc6?=
 =?us-ascii?Q?DKU6hwdSX6BsowCmk2Chk01FxlbtmdoWcLy0BZ0fmXUWrMxFqwDOy5IuLQQB?=
 =?us-ascii?Q?mfL3I7j8lERk21m8ZPBXbyLV3y2LqwNeZWCvsHPQGxX1dIBFlAteM3wNZU7S?=
 =?us-ascii?Q?Plzj5EVSJcDNeHx8BahGb9DWe7xVvTqZ2cXMkO3qdvL/mySnn7p9WlmsiGxW?=
 =?us-ascii?Q?QVPCIiCtx9kuRxpCx0PCaSMaECquphbJVOdhHiDmbjDrctoZLmogkv/7y9Iw?=
 =?us-ascii?Q?GUlZc1GvqI9kfkByyrhl6KUyjfA0q1WXPKyczAAq2+VfYpKqGdLJqipsDRWk?=
 =?us-ascii?Q?BOtzXDhp2DW53feHAzgn/jB+2S2ppm5W+XoY7ah+oRMY5gW8soZiIbz+1GZU?=
 =?us-ascii?Q?yXfBST6CCnzcxUBxeXgtd4wm+XwDV02/F2lpfWVS7cbeddswzzjcRshYuSkW?=
 =?us-ascii?Q?PBNxT4huaXV5IROyd+xX12LytxYrxpXXA4/SJNQX3M5qZHb4qwn12RZrncOW?=
 =?us-ascii?Q?b/M5VJJqoJvsUaRBZ6jlXmmjpJ3JESvwzi68FIm2WEGv0bF8AH4qFvIoy10c?=
 =?us-ascii?Q?Bvbu8H2TAog=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c7fafd-cac7-459b-ace2-08db952e5e46
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:18.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7QFYy2oo6Cu35HBC7hdfCoMMqTFWXvGe8GuE0komFXuLm94cZ/2qA06hFmbHKUuQ6T0V1lGr8Naqm38T5iSTclA3IWnW6xJV0T+YQHHMt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-ORIG-GUID: B0tiYUOe4J4eeVa_zPkpKabg9NY4KABj
X-Proofpoint-GUID: B0tiYUOe4J4eeVa_zPkpKabg9NY4KABj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
 .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 13 +++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 7 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index d8b0f80b9e33..a95e0f17c35a 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -110,3 +110,11 @@ Description:
 		link is created for memory section 9 on node0.
 
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/memory/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for memory hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..31189da7ef57 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -686,3 +686,11 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for CPU hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index e6f5bc39cf5c..d6d470d7dda0 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -741,6 +741,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(i.e. the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a CPU hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..c9204d69e616 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,16 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +479,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..15bb416e58ce 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

