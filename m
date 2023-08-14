Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14E77C2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjHNVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjHNVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6154E7E;
        Mon, 14 Aug 2023 14:46:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOivx031613;
        Mon, 14 Aug 2023 21:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SI47Vd0g71oVaznA2nGw/vTbAaqtW/I2nz+wVkPK6Yc=;
 b=qTOYKnIymjtoj85Vc2FYa1U0kgLAAkV2HbgiB1r9724pGEcFuahkQLCjXQHwjMores+Y
 ZhO7wKAnS/zw30rXN4bpcmN1gOOI0C8SNFEJkx8GsD0vOVzeyFOvt5DYPZ35n8edFCxS
 KHUJLfg+UJXq/gm8l3pB/hP21nGgeogDQCvU1wxEtFLN7804irjAr/fWLfvNl8Im29lG
 5/NriOGDE9Rh0PVnT4KEVbvkTuIbbKezNvjHSO+5WWQwlBT+li9XU67BSE0F3y2i8/fe
 MhvYJ4prPcettXpGGqFA/10CK1L63ppflJKjwf3VX0ZgTgvMRatgaW6gkvKy74XCxJFn qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3143ngj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKAhFW027528;
        Mon, 14 Aug 2023 21:45:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rdwxg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmwIasIKajseEMt5UDrLXGJiRicBbN4tqiBG/BuPWqjkRTNguVAXvXOlqFaC17Tokn9mtomQPAFB29lkTMxXaTVgnLbC2kiUGsPsab7KVkDMFu6/ceBwg+3eI71cClryYNp0jLD82k8zY4iebPL4h1R6FIWrDqvHYKDCupy8Q4aC+itU+7K308kCdU6y6LamLhtkvTgAKp84OCWwUNBtvILvtU9FiCPAa3CAAn7mwY6WnqjVKX2bUzUjabvkxNS2t57xah3iJwogJ9WbuieCm4bfTkxhKSUP1ZbI179kJhdKZ4Y3UzP+va/ISmbwzVLb4wcGYietbT6TKu2XHEqNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI47Vd0g71oVaznA2nGw/vTbAaqtW/I2nz+wVkPK6Yc=;
 b=ax08vFDsYCkGTrXU5WKwdt7VJfohy750hd227WfLCx52aGCdo56bezSOUBGcPqmkMEqP3/Q1pkWjWihSivn25pkwk94TMecpOMZKothr0D82DvKLCGAH35gAtUSkQEEZWFtYKAjycLLQToJbVpw6D+CxpQ12tmTXiPhPEh0n6TYApqBWuU0WCd+V06gr04aTV8tZ/ksikOVJOr5J8lIx5VRJVyBON5fe0O043tGUifWE5nt9OtU6yAJPiR6JGVhurJRs0i4Z4tKpHfuXoLPM3ie9amo0HS85T/GAwMiV5m6Qm86frxQVloq4OK+suexMdOUu5TEdMwYRJIGTNUGAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI47Vd0g71oVaznA2nGw/vTbAaqtW/I2nz+wVkPK6Yc=;
 b=hh86bfQwOPBy/pD6NgydvodCq5kcmO8gDkFtjoEqpiD0Uqg650UOg1bhv0iSRB61ymVsA74Wkq52Fh/9g1jRTQL62aRYera+UGDNsc+i8yzlfx1RH5WE1FED5SdYwtYEksWat0F1F3SVP/WfAycz3nEC25G84GtHCoLtr6DPKgE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:44:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:44:58 +0000
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
Subject: [PATCH v28 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Mon, 14 Aug 2023 17:44:40 -0400
Message-Id: <20230814214446.6659-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bec7a01-5a90-49b4-137d-08db9d0fb471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C+Md5SM+IWI8opsFq+2Uo/OKLhfFp+XTMvQ0ZyP1sWzRIP/RDIzfQXkVktlYfbRWv2nJrhEVNbDSzI/N2Q3zEBF3KGVi0QMZ12QkRjkR5q1sqpKW5J+vRj2if14ma9J6K5qpOVfCRdb8Tqs5dyZMFBlINhHwA7ztoqDUrHGvPSAzH4JoU0+qCF64tKPf4m83mNU23cCVD7xieRtjKJK6FwyX8iHEBcVWUoGNnt7BKT8tJ3S/wkmqriE2n/E62ajMa6/W7RsIkSb7qCttqGH+gsMdpZCEB8EkhFyE3UySGmQza6/H0FFyK0P0xHx+2XilKwQ/NfZJrB54Rrsiwsy2xAcOjeEsyQs2GXezXSV17/MXPLjiOUY1HFR+nwXbxBHNf9U+2aiv39dPCeyjh4lWTZJgy5AuXTjpRSpTJk5VCEo43a+G8LB2hpn8/sEo7YMI+wdgYcjEhssDMao3aHyakK/KNshRWKLfhl3UuD5PAznOhgqDEN/s61jQgq2dI2YO+NSbcTWtflTFNsYSh5OgSMHKKWX1aOEyGF1itGMl89t1qxxHIid+UFtqQF6ZNMT6rb3vyX+8BaYYTYTkUf5E9P0KzCAMF85rsM34tBIY3kITmEqKWPs1rDrQge4uEzr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(921005)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(38100700002)(2616005)(30864003)(1076003)(107886003)(26005)(6486002)(2906002)(6666004)(7416002)(6506007)(7406005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/T3EGlo8fSoO3u63x1EBgjvzdqygk95XqDgSdJF2ACX2mGrucy+ABrywEaE?=
 =?us-ascii?Q?KXDnPmx9dwrqlr3KaQOgewguhMEc8o+j29iwjkSlGZ/iPAPrEqLrqfpKNN10?=
 =?us-ascii?Q?gJhEXAyqZbsXorMRbSY5dY1PEs+xbI71lgGpVUVTGQaA+cOmxwS+LAYgqnoV?=
 =?us-ascii?Q?2yFEtQYYwP8bW3kII1PlCoxAPU54ymzoLpoSoTpdPjgraHL9dHA+Nz9vl0oP?=
 =?us-ascii?Q?cM0XvY2VJ4Wpzqtdh35J8pl6LPxR3IgzwVaNM9fcb6LgsLbtHjFOt6vtsHUc?=
 =?us-ascii?Q?INJR2aOqW4Tarr1diTIBHlJEU0/9TWCrSIb/evG6iaZDIuBe7hVqYSXo5hNU?=
 =?us-ascii?Q?fxjFT290I36gmwi3oG5JCNr5f3CTX/dw8Rd9qo7iWS/ArLQkGoYPrCcajV2Q?=
 =?us-ascii?Q?eLrQ/XAz+8k0mSr0i1I7jLzo/CqlFSCxPeF7NfKu1Z1ywPUKemCB+hk35W7F?=
 =?us-ascii?Q?T0sFUaGjWXbVLETgdE5Y1xmDpN2EqFXYZX332rusTsp8cm+A4lPYIiFjO6Db?=
 =?us-ascii?Q?dOxzxP1gfNF4plV6HEu6ToU1VBYQxvqq4pd+jTGv/aHUk2PDDonJEtz6R6lP?=
 =?us-ascii?Q?DSAeZwbseFhYOcSP4Yr+M9doNOhJOhASmeugY8CTb+denjqROsLaNM81UUCZ?=
 =?us-ascii?Q?Qc6gfLuXlFPhXl2lBFzAVlQYCutc4Jzp8LwiFdJorSoobaQDWBevj6rkjvet?=
 =?us-ascii?Q?L0oaPzG7p/Pe4YJ+BOXlErmqPktKvYOOd7/mRr/TKvld4Taz3LkGg9yRCVHg?=
 =?us-ascii?Q?6TmpDO2jM35ZIQ2LYRr2NYhHd9DTv6Jx9BHJFDpR3mdgyEKWfxcR8HhyjCBM?=
 =?us-ascii?Q?Se5rPH4wQhm83c5iHhMpMZpzwD8L0kRpRoBmVCrZVvc2v0voWE+yEd6DCwsk?=
 =?us-ascii?Q?jHTmtzHcI/pjwPKesf/kbajVa3nLamWyYGc4PpjCj6vJvzpTlIJLnx8BLsZ8?=
 =?us-ascii?Q?NRzLvPS5/VsXG1tF29J6lKUol4fWLhqwFhVclK87QXhkGfzrZEt1gQE10tF0?=
 =?us-ascii?Q?dEMCeMIh8XI7Ie6oRCqmKgTgqHMcsp9Sayz/sJa5LTPOJr8zICLXyM59yw0H?=
 =?us-ascii?Q?LFIZYhrUkLIYU5/kCormi1ooFFc/lXWUIbeg9Pe2LF5fVqhByiYRXP4y7Q65?=
 =?us-ascii?Q?PtiSZohwoYHYMIAkWPnOGOzEdTU2ZA9S83G49+45vdS2WHnCaDGqem6ZtpfY?=
 =?us-ascii?Q?lnfnAlPnMdzziG0YMj2gBuKqxZh453Ut7qLpb/ms1qI5DGZI0NO1izfWh52W?=
 =?us-ascii?Q?/l42aO03SJSJsN8GjTcJgDECuLNEkQlhM7T7JwdJURM/l3l7CdLFrD7LXiKV?=
 =?us-ascii?Q?6fKlaHyskIgU2p1FC1vEETkWGj9NhKA3IdTdtG/UD6n5OhPVl1yi0MgmwFEd?=
 =?us-ascii?Q?vaiarzUMgT+5xwKXvrwPpbk07nX5xKil0ZqQoeyNAEajqNsiQ+5GYllqoMx3?=
 =?us-ascii?Q?KxyWY2PK17xbOgTddDaa85d7h71Nk3eqYCHHC5JosG8pqub/HwqxUrj1auM5?=
 =?us-ascii?Q?7DG3b2EBCosbeL45iPXg7+y+Om5HBFCx8G1p+CX9JDP3BQuti/Z8eUwLukP+?=
 =?us-ascii?Q?TVJ2WbTZxi+jmm+ho+4ozGeoZOV10BX+MyCAZ+op1Lky080SQgmShVdBOtIh?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zCXF16dm2nYtgp3z+yhWUlnbFwgmws7YTm6n3m4pkBQAvMSFvh1tGQA+wRnz?=
 =?us-ascii?Q?nfNMahOywg+c96mPhxACdD/DyYyIXdzgLkDVLF7qFHsPKoHjAojfFvuIsjoo?=
 =?us-ascii?Q?lc/mPXOmxGWIDoLySFF2RQcDXzxufproPXCcN/wEZWntd93+A++ZRiVaCafF?=
 =?us-ascii?Q?evnLSYVvC/pOhKg4Ig36aHYkbYlIku8mXJ7ia2YbqW5bg4iUXEcxbJIE9V8a?=
 =?us-ascii?Q?EszGBzPgZ7zJKh1I6GvHJa1D2muDkva4LB1lSeP/pFIYteJRxsFyNkyjGZFd?=
 =?us-ascii?Q?XiQ/wAthCvINUqkboAfH4qfH+yQAMxN5o4d/ko1VHA35+QZcSvFntp5ynI3+?=
 =?us-ascii?Q?USn09QsvR437TIi53HKmUTnt3wjPVRJKC0NI0UYANKX1WeVqRLc191jFX06f?=
 =?us-ascii?Q?riFD/UgDrxrLdoM6NzEQkf5y4wjtqTW3XobuebHblW/k9GWpe6KOb+tVciOE?=
 =?us-ascii?Q?ItBUexmA6JcV0/Yxj6Jj2QueZFLqFQusBFUvXXgVoHlapRPuBchS7d5ge/7h?=
 =?us-ascii?Q?VCNZ7SmFrwklbZIlKizK54KWdz9OlEW5iN3MwusFrYw5BOmYKXikf93xcVJE?=
 =?us-ascii?Q?oVAL3VTJU26tKkkbNuvYWq4qw3cXfgMiet/ZGTW402zB/DhoSFO+FZjN6V7o?=
 =?us-ascii?Q?Eagm+KAGHUNmAZ2IluFp7MsDhfiEW0I3hcu+AXcvfNs+ReV+w8RivVoU8XGK?=
 =?us-ascii?Q?NDyiQcVGUYEjk9rakvCenPpc3f9wxPJVx1NlSysZ4lZN6vpkqjSpox1o3YxU?=
 =?us-ascii?Q?8GpckW5iA3byaZDgDKpxlGZ+Akkk8KPNUk1OnMu4pHZAs7tSwwIzD9TLFZuC?=
 =?us-ascii?Q?ehyk8UXdOxrpc8jAcjBaybvg5Rv3aBS9BjtT3v9m/IBHdkgg3DyihLnDdQMZ?=
 =?us-ascii?Q?FZy1/6N2jlEu4yXmYAEg7Mq01PWaShFkztTNW2v+fR/mWvsxtYiYTChESsD4?=
 =?us-ascii?Q?G3iT08ozKx7HDfk91kG5sX2ma9sNxjORfUYYYzmb6OJYqBhH8C/7/unaR5IA?=
 =?us-ascii?Q?PyN32ryRA7BhnoLEtkRyzyM+WvfdkqJ6gdY2XWqoJ/Gt11SOxGsf2HsDjxwN?=
 =?us-ascii?Q?c2o2vIIqeib1hWe32erskVaO+BFQdXsoxnAU8dSauoMy/wB6LUx8uTeACJ6s?=
 =?us-ascii?Q?laIXSfTAvQqAyGO798PelBaby1MOrkjSzqfONtpsUlrvecgpXGLgqCv5mn0X?=
 =?us-ascii?Q?afAlcM68D3ZVFgCzdiULujxxODUC1CcRAvn9bWQ4K0YVrJ8K5wqzlVH1aWlO?=
 =?us-ascii?Q?xo6Yl3214SHxhdSeVfiWzkNGfKIC7FffKVWVgfdLyGvN5AGAJFv1fW53bqXM?=
 =?us-ascii?Q?x78DCuTagFnXO3+0pzDJEow0zBWo7oSzo/Nunu4+7MtIWwCXmaAA1rih/gLQ?=
 =?us-ascii?Q?hpjVNaiKxd/tL09sSWYJYPv0ZPbNYPgxakIht+0VX1uJQjFFQ+sgX7wp7Ubg?=
 =?us-ascii?Q?HOyMASANZVo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec7a01-5a90-49b4-137d-08db9d0fb471
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:44:58.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgcN/HoyqntxaItrtCcuL3EE7STnncNifFCBKvTLWL3kqz1y2+0EdNx4Y9re3PVggT6ZvyFlpxFNpuF3LA5Gi9fC0cxgXFHxTh2Be9aML9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-GUID: 8IFLzo0RoaUPwJvY0G1e4hs2kqB8RFwC
X-Proofpoint-ORIG-GUID: 8IFLzo0RoaUPwJvY0G1e4hs2kqB8RFwC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   7 ++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 197 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 1e48b1d96404..0c06561bf5ff 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -104,4 +104,11 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 struct kimage;
 struct kexec_segment;
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index fb4350db33ff..df395f888915 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -345,6 +346,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -475,6 +482,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index ff72e45cfaef..d0a9a5392035 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -113,4 +113,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 336083fba623..40388ad51034 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
@@ -733,3 +736,142 @@ static int __init crash_notes_memory_init(void)
 	return 0;
 }
 subsys_initcall(crash_notes_memory_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4ff564bbd8d8..9dc728982d79 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -274,6 +274,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

