Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38AD78E95C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244374AbjHaJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHaJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:27:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F220194
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:27:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0DixL021831;
        Thu, 31 Aug 2023 09:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=O70Rcc/Hc4QwgT+4Wzv0orTrkHXpWUkzq1Qm7p7sXM4=;
 b=pUmxUUMBZ5Ae9B6h5ghgriS/Au2vYjQh2ZLERFU+N+2Iw3ZugWb2vI+BPJbXU6lLwSs1
 IJMA7H0QVj6N/KXqsQvF9+ZZFSkLuf+O8FChkKt7q8vVLvFlJexGuEjqszDpxPAKPxiw
 Pzw06HaJmDmYEAsTMs7sWYqJGtelUrAvJftmuoD+s5jgBpXkGCznelaseWSMk4TKID1H
 ySUaSTBopv87SBBb2mT7hSj/jxj3Cx/AtImQaTBoOdQEGITKWaEMyTDs4T6/TQlRBQ5E
 QXSzFFTDHHbMJm6/iLHRq3KWNBAXj+SrJDNLUtdGgXsyQq9CtRKSlQCeSbHzEj+vaAEj 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk9drw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 09:26:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V7lI4w000518;
        Thu, 31 Aug 2023 09:26:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gdrs5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 09:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/oKdyBDoShDrjAbX+lePH38svKvcGIHoROJXgvaeCSCHIU2ibuNxhfUJAuapQGKM9pscNuk0H+C2rulaADKAgOdPPQtvMahJX/aAjpJtnCIplRY3cUdZDjvjinrsI8I9eMXXcreQZBFC0aNv85Wu+6y2bZ/4wgY8omVJ4oho4ERaOrnM/zqlroofiTQ9BeyFMjZhIqhO96JeVX0FlZIGNHAVdGGWfq324qRMLcZMiHtkRVkB6oW2iQkX5pY00/eFD4PoJI2zTTaIDCSIwuuvQOLiuR1whIrCnJxQI3N2QzEykJAv7vfjPs63Ix+TSLqUAIQlCjGi6LC2N8PzSLfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O70Rcc/Hc4QwgT+4Wzv0orTrkHXpWUkzq1Qm7p7sXM4=;
 b=dPX1o7Cz+b7ROpuxJRY5p/l2zPgmLyLGQLtRwGqKkz6qyHExBX43uypY6vFQD5oGUEO3FL4S/WtUuHUxexy6Zloql9msJy0W47hCjKQqyWKDZLtMpmCMp4/8D4RSKJa0coGdmgyVc7ici6wFvdiLdKL3+Yf7Ta2MTsP26FqC1wFGdf9F6FpFxBBpxM+Fzl1JIsdH8b5QitIOzP7yf5GeMGc2AL51fLPHap6WmFd83BNKuwWvLttB66x2McXsL137LvRwxNmnuPvpw+ad/WAoULUZAn/0url0/HZlZ0qnfXCYa5ZcopBXE1z+1XNPA5DHBU3zCQRZSs7XrsCbPiRtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O70Rcc/Hc4QwgT+4Wzv0orTrkHXpWUkzq1Qm7p7sXM4=;
 b=XmVNAnQBXcwBls2rpza4rrLUHvSUMclAmFv9xPRsdB65fnzCS7/PzAr0FIu60icEENaeXIOYGRTxgLWo8yDBTTY0tYVidouyzVat8EmkbzqsznCaTqemOkzjVYwDj4qbmTU72LiBWST+mr1ydtwdmwX2BQyJ1Y9shP2/6q/kEMQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA0PR10MB7665.namprd10.prod.outlook.com (2603:10b6:208:484::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 09:26:18 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 09:26:17 +0000
Message-ID: <5ddb085e-c134-4dee-c2f3-50534ce28294@oracle.com>
Date:   Thu, 31 Aug 2023 10:26:11 +0100
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-11-mike.kravetz@oracle.com>
 <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
 <e20692b8-ae64-b2e9-4177-062bf0c937ba@oracle.com>
 <254b1ef9-376f-a47b-ee54-ea34b40b3f72@oracle.com>
 <70844AE7-794D-475D-A660-F02EED4BA301@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <70844AE7-794D-475D-A660-F02EED4BA301@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA0PR10MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c8be36-cce6-47d7-018d-08dbaa045457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so0dl0vupFE6i+Qv4XzBzo0nd+cga9wx+6za8dOAEiLEbKFE1HhYgzOl0OW2w1W5ctnJZsjOqglBQQNtZkvAqqN5XXiq0KrvsnAZULGxyshPJJ4ISTC8sXw/Mw8a+AXKBtO4NSE34RGPhxyIqBCWaKe05Amp6TqHC3DwG/pkF8/GE5wpac0IOtDnpj/7AslGY7sJL72XPCaV0ZFzEEHTP0JHNyb/71motuj8yXhUkfUfloh1yr+CgoMjcW4MOa3c1qOZjXuHnUasWQXrTaHDPwhy8YLN44q8Mp9mmUsvGQJgn7vG2fUvxL07anX9LGFxI7ZSvpm+xqkAnTvARtgGtPbc/NDAbhsWidirPxPR1RlfSUdQ3hAFTc5xJKm+FaxbiqRrYM7JV8gO4BzEldwaTLN1E42/zEEw/JjJYWepUFMvGI+KoAgwVtNXaCpusx0d0GER5PROwWK3uM5h8kf1lhbKGSn0lwrDyzL7qFzSv6dHlrLyTeXMmkDwDfQfoo3hEXqO4OXylyZ+GKBBnhKCLkJk4VbQF/da8f7YK6P4n9Lqbb6Q/4d8vKVOCRjTFki4hlXBz+yo+fmgGFnsqjMykiEbqOun8OK3fM+4cqpejQUb7Ze6Tk//JtMHNaa1C7Dj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(6512007)(38100700002)(41300700001)(316002)(8676002)(4326008)(7416002)(2616005)(2906002)(31696002)(86362001)(5660300002)(83380400001)(36756003)(26005)(6916009)(8936002)(6666004)(66476007)(6486002)(66556008)(66946007)(6506007)(54906003)(53546011)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21ueWlZRDRtSlN4ejdvRy83OWsyVFo2RjhTcEtNbHcvRWdVN2kxMVBTdzRt?=
 =?utf-8?B?YW5xbzVhRWsxTGRnMmk5VEg0NmFHN2hnZGNoaDB3MXJKQmJvcUlHQzZnYVhj?=
 =?utf-8?B?enExcTA1OUlZRTVBOGxsZVAxVTN2UUU5RWlDWU16dEFNUWU0TER1ekdCbGd2?=
 =?utf-8?B?aUFELzV2d2xWM1h6NktzdmpiaXFTK3l2bktudk1YT0o4UUprNW9lWk9SVUFP?=
 =?utf-8?B?VUNNbldHUDI1Vi9pSUIyNnVlbkFvczBZWWlZVXlOWE1IRFQxcnVUbXNRWVlC?=
 =?utf-8?B?cm1oT1JudGF0SGhnaldyMFdOOC9EamdNcTZoa1VDb04xRFFER1Z3Y0JkclBJ?=
 =?utf-8?B?Zzlsamg1SFBvMm8xQ1J3NVFCU1R5ZEx2RVJpdTcrRUVRR3J1d1lja0trSlNT?=
 =?utf-8?B?VFpQakZ2S1B0M2JOeXJ6RVd6cnBXUGpKYVZJcXUrbEZ5eEFoQTRxblJ3bVJB?=
 =?utf-8?B?ZGp0azUwQ3dWOXVsdjZQcXVmSjNCMFNwcEtwSUc3OXZaOXBldDBzY0R3dFBz?=
 =?utf-8?B?RmJmZEhzMmR3YU5TR3I1TktHNm9NN25kKzJ4TG5yclJMQ2U1aU5RUkRZVDJE?=
 =?utf-8?B?T0tuVWZBVm9ubjJpVVNRdnEzZzMyS3E3MVE3MU5Pa0VLZ21BUDdhNFFvU3ZC?=
 =?utf-8?B?ZCt1U1hIYXU5akJNaTNOSVIvRmoxZDNzbXV2UEtlU3o0dHhOWEI0WmNMS2t2?=
 =?utf-8?B?dG0vQXVSa1o1V1VlQkdFdDhUZXhtVjNBdTM4ZVNFWTJaNE43eW00MFI0ZjRD?=
 =?utf-8?B?YjlEc05Mekd4bGR2S252UitxQTh0K1UrUm9jdkg4MXpQbnBnMHA1WTBtSWU4?=
 =?utf-8?B?ellYR0FqQnBqNHlDL1R6ZitMODRhUkQwUk56Sk55RTllS0ZaWFdiWnQrMUVz?=
 =?utf-8?B?VTc2MHAxemZBc1FYOW50eVFhbHZ5SWV3RmJqOWxscnQwVGQwcVNvSHlxeGJ5?=
 =?utf-8?B?Y2RDSHFVZE82bjJnUmNYNGdCeG9GK3FHMGRCcUFhZDQwUnZMenVMajlVUEc0?=
 =?utf-8?B?bDFIZlRCNDcvNzhqR0o1dldua296T2YvU2dsT1F0K3lhVTcrUUdQRElibllt?=
 =?utf-8?B?K0czMFZYckltQllyR1ZmYzRISDlCc21hQThnMkd0enhGRmFQbXBYek0yRGxx?=
 =?utf-8?B?bWZnOFpVZ2dVSm1yMjRMT3FLVFFpQ1JGK21nVW9TcVR5cDI4cWM3c25CUFdC?=
 =?utf-8?B?TGExK2E3MEU5Q28yaUJncVNDTmpqdmREVEJQZnVvS3J6K3RDZmJLUVl3MDI5?=
 =?utf-8?B?SWpOcGhSUnM2bDdNYlBBYlR4UzhKNjBhYXMvNzFHbHByMzh3UnlkMm91eWhJ?=
 =?utf-8?B?OFFxSHY2UUFKaUt3blJwMmJPY2lOTGdyTFV6US9MZnd6TjdXQ0w3VzVjeDFH?=
 =?utf-8?B?Z3BralNwajFYcUVrM3RBdmo4b1Y4Y3ZJSVNxT3B5Q05iV1U1bVlqMlZRbEFj?=
 =?utf-8?B?cUtKdEs4eVBjZG9weDY5MHdJUTZsUzkrWTRna1dPMzQ2V0RoMVRBTjJZSG1M?=
 =?utf-8?B?eVU3Z0FHVTRQR2ZhSnh4RXllaUQzYncrYkpXT0FpNVNSWTFkeWxXajlyZllp?=
 =?utf-8?B?d2ErYlp6ZXl0Smd3K3poemdGMWJGMzVsSWVVVEtpSGZ0VithVGVkaWNyTnZo?=
 =?utf-8?B?NlRvUmdPdlV5d1RtUVVBRVpzekNJK1ExcGxVaXVRS2dVMVE3NHBRbHp5WGxw?=
 =?utf-8?B?WExVNmlEOXVRVzNYb2ZBdWk3TjdhMWVwNUJnNlZvY2NveWY5aHpSZHdkMzhR?=
 =?utf-8?B?U1BwZ21GRCtRc0xnQzMwTnhnaU9lQWFMM2h3bWp0RHdFNmJvVERFZ3FSL1c5?=
 =?utf-8?B?cTVwb0VIL01KQzl0RC8rcXJSdmM3cEdxYmg3aHNZWWxnMWUrS3VmR3UzQlNJ?=
 =?utf-8?B?S2dQQlNZMkY4Uy9HM3FVTmJHVitQSE9DblVGeFMvUjdyVXZ1Rk9NQ0lGUHpj?=
 =?utf-8?B?YXFSQjAwWFRoMEhNS2dnaEhIQWg1bUhpU1NoVlNhSEtBcEszbXNPenl5ZmZE?=
 =?utf-8?B?aWJjNWRVRE8wZGxvdEJZT2g5TWpHMEZNYWluTzJxd0k2TVJudlZ6VEswMjE0?=
 =?utf-8?B?ZXFpZEdydEhILytrWnd6YVdSbHlSakhFY082Z2VvZ2Q2cEUyWkFLWkNrQlZh?=
 =?utf-8?B?NFE1NVdBbjAvUjNlTDVHdTROTDVSdTVldTZyRklTNFZmRi8xaDh4c3ViRmVB?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzdlN1A2ZEljYUVQd2hPaUIwLzdOblFsRmRaRStBVUc3Y1RKcVJrSVcxblBy?=
 =?utf-8?B?M2xkL3doQUlJUTZVNTdRRDY2WFR1V2lldkVmdTIzL0ZVRzZVSDRVRHpHL1U3?=
 =?utf-8?B?TXM0azZ0VVJEamZuSnhtZDgyS0FROUJyNm4rVVJhWlQ0WFhrK2VDU2p6eEFH?=
 =?utf-8?B?TFErVjhobUNxUkRSNVRDN1FZd0Jib0dWS3BDYXlORThtRmJhSHVoMVdqaHlz?=
 =?utf-8?B?ZGhIZ2UrLzF3R3pRc2NVcVFBNTR4WUxoVVFLSm84Y3pOc2FnUGgzZG0za1Fr?=
 =?utf-8?B?QTlOVDBqYzFCWG05M1RiK2c1L21KLzd6M2JaT1kxUmswcU5LVHl4VXRkNzk2?=
 =?utf-8?B?ZDBJRVdwV25UWkc4OTRKOXZ1VUN1eVMyWmlGci9DZFFlemYzNUZsaEJGOWdZ?=
 =?utf-8?B?WE8zbWZaL3prL283aG1YUzNsZDhJYkkyN3lyYXYzLzBRa1R6QkhUMWZsaGJN?=
 =?utf-8?B?c0UwY1pkVzJtZjdIamc1bTlWTkVPSTJjYVF0THp3Wkk4cndyTmlLcUh6VERW?=
 =?utf-8?B?Z1l0enUxcllOMGU1QTNHNG0yWkNYYmNhaklUNWs3cG1TdXBqZGliUmVEMFJ2?=
 =?utf-8?B?eEVlRUpVcGV4SFo3TkR6SWpWZER0V0E2bjgxWGdYZWk1Rm9HeWFkZU42RFMx?=
 =?utf-8?B?RjBIUHBvS0ttZW5Qd241bmtPbHNIbU9ObUV5QiswWlR6VjZUMXNYVWdyRDdt?=
 =?utf-8?B?enQrZUFaZG5xMitFU3hybXZBSEg2T1VCeXV6OE5PaUluWnIvL0tueUhQdjhN?=
 =?utf-8?B?TjQ0OXE5SSt1TmdnUnI1V1h4L1dvTWIyWE5FdXRieGZjRmd0dGtUSE1sVTJm?=
 =?utf-8?B?MmljSGR3a3ZWa3hHcEp3NnpqcmhZY0UyY1NvTHZ4eUxjSlpjVXpwUEFraXEx?=
 =?utf-8?B?dE9LSnY1TVFXWjJObzhDWmhRVXE3MnVuUGw1Sy9NYzBzcXZSSS9DZjM3N3hC?=
 =?utf-8?B?RTlXYWROdngzdlN0Y2Y5T1FZRU1mMkVlc1pNRk5CNEJHaUx5WEtoVXJ4bGpV?=
 =?utf-8?B?Nm1JWWtjS0w4bi9QNFhDNFJFSUNSbEdLRkVRbHp3RFNrUFM0ejd2TXNsNnZy?=
 =?utf-8?B?cTdrQmw2ZXVaRkNuQzgvK0dVRnN0R3NWMlFzZjhvcjVkbjhGaTYzUzcvYitN?=
 =?utf-8?B?aXZwS2JsclRyZEJOd0dvY0hFS3gxVkNJL0NiOCtFSUNhMVE5WGtmU1prQzFT?=
 =?utf-8?B?ZXpXc3Q0YWtZRHM5amwwWjRxbklsMmg2RmJ2QmVBNGdIVFBMM3E3RmNranBK?=
 =?utf-8?B?bG9NbkFIVy8weTRFZzJreEtSYkpWOGwxeno4YUJ1Z243RzFqbFlrOFhhZWtB?=
 =?utf-8?B?NEw0RHdqL20zcEZKWC8xamsyRzRYSUh4VXUyUnZTaGR1NlE1S0VEWW50K1Bh?=
 =?utf-8?B?K2pQRHhQUmNLYXZmdkhsSGphUkNzMlBFeWZnQ2JtZEppcUlrUVIzZ1RkeTlS?=
 =?utf-8?B?YUJJOWg1aXhmbnRDVWpXSmRZc0Z5UHB6MXlmejFVVVBISVRmMzlTdjloMXdZ?=
 =?utf-8?Q?nYbC6ia4KRKJgZ3Ee+LRVG1j+FU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c8be36-cce6-47d7-018d-08dbaa045457
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:26:17.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb28K924HLxxxGPo8GckJoyu1qphJl+mp62cx4CPls3kVbRBq2kHol7EzZA0CkhKtVO9rFSJYA9WRrE/I26dhGR/F3f6aO7U+Jz83/CKOWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=964
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310085
X-Proofpoint-GUID: O-KH8rEBAwIV4JDFEYmE3GcPEmnyasFh
X-Proofpoint-ORIG-GUID: O-KH8rEBAwIV4JDFEYmE3GcPEmnyasFh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/2023 04:54, Muchun Song wrote:
> 
> 
>> On Aug 31, 2023, at 00:03, Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 30/08/2023 12:13, Joao Martins wrote:
>>> On 30/08/2023 09:09, Muchun Song wrote:
>>>> On 2023/8/26 03:04, Mike Kravetz wrote:
>>>>> +
>>>>> +        /*
>>>>> +         * We are only splitting, not remapping the hugetlb vmemmap
>>>>> +         * pages.
>>>>> +         */
>>>>> +        if (bulk)
>>>>> +            continue;
>>>>
>>>> Actually, we don not need a flag to detect this situation, you could
>>>> use "!@walk->remap_pte" to determine whether we should go into the
>>>> next level traversal of the page table. ->remap_pte is used to traverse
>>>> the pte entry, so it make senses to continue to the next pmd entry if
>>>> it is NULL.
>>>>
>>>
>>> Yeap, great suggestion.
>>>
>>>>> +
>>>>>           vmemmap_pte_range(pmd, addr, next, walk);
>>>>>       } while (pmd++, addr = next, addr != end);
>>>>>   @@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start,
>>>>> unsigned long end,
>>>>>               return ret;
>>>>>       } while (pgd++, addr = next, addr != end);
>>>>>   -    flush_tlb_kernel_range(start, end);
>>>>> +    if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
>>>>> +        flush_tlb_kernel_range(start, end);
>>>>
>>>> This could be:
>>>>
>>>>     if (walk->remap_pte)
>>>>         flush_tlb_kernel_range(start, end);
>>>>
>>> Yeap.
>>>
>>
>> Quite correction: This stays as is, except with a flag rename. That is because
>> this is actual flush that we intend to batch in the next patch. And while the
>> PMD split could just use !walk->remap_pte, the next patch would just need to
>> test NO_TLB_FLUSH flag. Meaning we endup anyways just testing for this
>> to-be-consolidated flag
> 
> I think this really should be "if (walk->remap_pte && !(flag & VMEMMAP_NO_TLB_FLUSH))"
> in your next patch. This TLB flushing only make sense for the case of existing of
> @walk->remap_pte. I know "if (!(flag & VMEMMAP_NO_TLB_FLUSH))" check is suitable for your
> use case, but what if a user (even if it does not exist now, but it may in the future)
> passing a NULL @walk->remap_pte and not specifying VMEMMAP_NO_TLB_FLUSH? Then we will
> do a useless TLB flushing. This is why I suggest you change this to "if (walk->remap_pte)"
> in this patch and change it to "if (walk->remap_pte && !(flag & VMEMMAP_NO_TLB_FLUSH))"
> in the next patch.

OK, fair enough.
