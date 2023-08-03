Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1513A76F1E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHCSda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:33:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A92D43;
        Thu,  3 Aug 2023 11:33:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgBEu011560;
        Thu, 3 Aug 2023 18:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uOcnvQPq7fvxdLqB+NSlDC7TeqCctD+4NPNx3UOZj7Y=;
 b=TZdhYzoWExTCcRforVrKAEbBnqD3nZQ7gzaI5NqmBUVREpskUIyWNpM2PZKfS1PoPD6n
 MPAA1WG+901jK46ok3TGelLM+WYbnnvBBlG+XRG9vo26Z8cHBIkDpvnHIDD0zJO/ZwlX
 o6N73cYR/Du94SWSgSMJYj9sjOq6mPbauFmoOu5PDfJ3F2TphrtffSrswHW1Z7VF6oaB
 uXbYk+UjEllHP59qLRUqCFEL74FxYudAq2wYy4nBxPJTalevZgxdnmq/BjyXT3YXkf+A
 90dv5WnxBrpOkCPHGrquLvkJinbkEIOWH1sIr2on8Auy2up5SUXdkQuxjUkXbGT0TfMU Ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbvbk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:32:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373H71mi020534;
        Thu, 3 Aug 2023 18:32:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7a2ft0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo/jzle1tuhiAKB8WK51QKK43MeHah9slY2v9sGo1dugwZCQjT5H4D+lAQLfqY6ZnpJSrlgmiHC/0UQZBtd/7c0DYvnaf3nQK54eSuns+eKCsTd4dvfF/c9vT40Kql+jKulpZNB7AE8Od0Kmpj+OW6lAaX8b3B8Q4YtrcPt7MsUxDEEUShRYX+/syGDl3ObYB/5BNfa4f3qOv87TVx97xrrHMw1vGeakNf7YwkT34IyXfs5Pv8ZNXBBMxU4c25/4z5x2Zo14TSY15qGml1m48bz6mfE7PUsSDqEA1o+5ekuOOeuAYSXmbZNSZf7McfnvS0+sbTm+/WIcAmnBP/imaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOcnvQPq7fvxdLqB+NSlDC7TeqCctD+4NPNx3UOZj7Y=;
 b=gxuNP4Pe/YTYp7ug+mkOnh7JzicQW0cO9oLjq4+yJLhzMbF8sOlAKYR1Rc1MNY/6ABaf98mNzQHSwQ3HXopMOFLzpKUqC4STZ8VeJDLlW529i2+S19CmNwABVu2sHrACVGiUF2bR2PkUmMuXkwbp1iMozMQ6LfG6SNuo1Z2oumSUuxZ2QGCJ0rQ7Vg6Hvu4w/SQXq/HtD9KeQ5hV6sm9lcNa2bl3BONY6aotfu5X/UaAevCs8PnAp9tFQram+EQZl5wJrfHZ3T3LTLlFzpkp3EPkIiTd0YzXx51yoOua+eueC44C3m9Yine9HICiafOLyRGObrUIY+Fr/uhJEm74EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOcnvQPq7fvxdLqB+NSlDC7TeqCctD+4NPNx3UOZj7Y=;
 b=Y3OYIoa8GUrdv7sD2S1pf6wh1sXau80i4KfpEDYy85yKDIqUui5YhjdHKRlvJZsh4adDCQ3obpTA8WCMjifOFot8K3OeEimG/zSHPxOZebh6bgDZrjLOI4+m74u9ywwatfHWcfkFYmot3SRyn4ASueGT2MraGw2OsvW2KUyNcJ4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 18:32:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 18:32:32 +0000
Date:   Thu, 3 Aug 2023 14:32:28 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v3 6/6] mm: move vma locking out of vma_prepare and
 dup_anon_vma
Message-ID: <20230803183228.zreczwv3g3qp4kux@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20230803172652.2849981-1-surenb@google.com>
 <20230803172652.2849981-7-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803172652.2849981-7-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 830fb91d-cc29-43a9-52a6-08db944ffffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOgTwVcpY5rybGv3l5lD1cnbyVwK9Mw+tQNR3K9OkdXZBxLgerZY0ST3mSEFOdqmlsSOZ8tkFWTvisA7XQgPH0E0kc/YkwJamifklBAs2FFIRByIA0hGrpNf5vr4f7rNXp9Q93wsw1JV8Yvm4t5C9felChsl3lX/h9SyWJ2aa0tSNF/7y0leScdpNxR6pI+CjFx2KW6PLpt4o6NJrRwqDvK9aj3EeP6adcyv8d4vOhE8AslAj/ycyfr90K1XLs7bSNuJtuS3+8BYJXNXHsatgM/hX2X/aNCxCb3M3VmaTbyLrnW7DGqa7nfVUsuLk1RPkdRUWVyfsYJuE2NLR+MlaAvLwPadkbxdeKs/jWM0lK8+Rv+CkPYyX3vuQdLD19p7q5XdL2EpkN9TYb5/nWM/PEHk2mKkklmaSufZs1Qi0+edS7qmEXAMxPFMbNPS5B2g691VbILoix0Y4kA59SFJG6XEOIeGwqp0/io9vtU/sXNymSJIIWOWbsHBT77CB3eUirMzcy/Kxq1gmWUohYuPI6XmfAXq0sZNHOMMyssS9QFnINx39JxG1JXFx5jlDr4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(6506007)(1076003)(26005)(86362001)(33716001)(38100700002)(316002)(6916009)(6486002)(6666004)(478600001)(9686003)(6512007)(66556008)(66476007)(4326008)(2906002)(5660300002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQYUPo5pU1ERX4JqjJLq5NXLJGKJrEmi2F/y0H3sqHmtVjMHMFB5M3aSWrHr?=
 =?us-ascii?Q?DE2SetI7647ujw6FHDbD/wf8sPG3QxpY1NkcgsVBucElHYnhcpqM7m78IemL?=
 =?us-ascii?Q?1kqVql8yZn5bZIpzyw4dEHMIU8N0aqoiZaYmLMNZckdFockaEgETC1HgwTA5?=
 =?us-ascii?Q?BBZKia026SdgLCbiKvCErIdC3LGHZOXp/qWRk+if2Fjs9hF/PWPvo+qO2c/J?=
 =?us-ascii?Q?0vknNn/zURwh8d3qQ6ZiYGeFSObMv1g38qUXN4VnNqGWzuOAeJlPb/X8U7KX?=
 =?us-ascii?Q?KVDuFZEY2TRfovRm9w+3SzxviQIOc00xzRsTlQnOA4I+rZyodhVwuRYWs2gm?=
 =?us-ascii?Q?xgWWA4C6mBK07ANxkQ7x6gtISvlvnZrw1EOXPY3YHvx6PxCa65woBl+6plXh?=
 =?us-ascii?Q?Ju4M+uhc6SoUbKvCI/J25YEYGxts0ULAdoLaSjT8QUPxh36L9xugcQKQfRUz?=
 =?us-ascii?Q?8TrzghczC16P7BHFlWARJcnVK/82lyFa0a8+1+dC+Rx5G72AflQfYtcjreUd?=
 =?us-ascii?Q?bsATCK7uYKvMFWDRSAS8SFnGCvgUOnoBKYp8/aPplVq5zIrtkcMZ7Ql1zsKx?=
 =?us-ascii?Q?HhxehZhz+Jfol/PI3/4IZko+PGAAbfuxvQThcAhXN653ZpcxnwXiHgcQj754?=
 =?us-ascii?Q?Bl8GqEbkZ21knM6psYAVJQC4eBgzsb1YhUwkRHvV9uoNR96mJpkju3zYijmH?=
 =?us-ascii?Q?jTJjiHbhzdOL4OisdfXP8w62aTxAgPgFWjX5m+5MYjheYmwTrdXj4/8Nhtes?=
 =?us-ascii?Q?S3pcZt+OF/T1PJ6bcxWPCsan+c5PiysfGSmY+x6FGiUKBKd14ZdgXNqHLjBD?=
 =?us-ascii?Q?yLzV+AQh0U03RnbesOgKaFmebHq90ELhf04zE+MWSWxwN073ZwH4ExtwGOLH?=
 =?us-ascii?Q?8G4AmxmTnkYiGNHeOSBy36OTgAUkRBdtym5jrgQgmClw1FKFfJGONfLxIBbm?=
 =?us-ascii?Q?3gxq9tAC6pkPPJ0+bzS9lzjj7upia0OVzVOSdC4Ganj+m6UwInlSFaNjouPp?=
 =?us-ascii?Q?oBtEDiQaGgu7M70yFQQ3OEuQAXTW5IjGznDHG7nsz10Y7Q56bokky+umJImw?=
 =?us-ascii?Q?empvVWXU3hcjmXO/NbXe5ZkQTtOfQXkDo0bxk7iZlMqBbbfeIxKZ75Aebvxw?=
 =?us-ascii?Q?ffdPNyw2Z9qTsUp9Xev8IXFWz2hQp/E04v/J9LGJgaAzxLTew4CRdvOH4xMl?=
 =?us-ascii?Q?r11TCZXXS77ZZzdRN8CP5loxFNPwbXjp99LeJXc+xF/9zqpx7ZJvwzBOypxB?=
 =?us-ascii?Q?X1cgQM/BYRI7xanryS4r37z2QNIns/nKpZGmchUKBGSRz8YWxtbdPs9x4VC0?=
 =?us-ascii?Q?Vl6x6naOMfP+vE4MYJmkS/f1wBjsINZVr2dfEdmVbxsHv6CHYjXxRHDudZP5?=
 =?us-ascii?Q?Jkr1XlyENsp50QTkX/FCICG9j+orK9IyhKhqGNDtsUsz1hlce4RgqwdmOfKo?=
 =?us-ascii?Q?5VtWTMSYBOzScZgE0QN9HTgsiITIXIrBvFKISD9jMYnk8Q8Bm3TYoTItv4JK?=
 =?us-ascii?Q?8aAnBUUk2Oco+w0nFKCnKGP9pFuEGArQ2sfA0jiR4rYX4AviKMy2UIExOmGX?=
 =?us-ascii?Q?vXIsqquhnPdDPRXd1x4cM+tciyfOTPkVDz9+bbKbGj8k3ylgYS6BuhFBBprK?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NLl9lpqcC3Vo2+dNaFTHv1aelU+2Be1PK9/UHHa6disiew7+6b8S9paYMVsb?=
 =?us-ascii?Q?FnG9P0r4L5kgBA8o+6Ssi5cdHimWLObRfjewiwMo/GOVjksm+e2RqaFDLrgY?=
 =?us-ascii?Q?Ypzb7pPrZwS+qMU0wCqSZ2NyFJzgHsKGG5kW3j6avMr03pr3xg83UqQJFKUu?=
 =?us-ascii?Q?VxBtZ+BDW7q7688xyqbsEEIFc4ywnUzjui3EgTSx4p+PTe97zIchkLfv/VBq?=
 =?us-ascii?Q?LdcrUcJkK0FmoyY3cOp8VpeJ93xN5EAQUk0WyzwWRFBqz+DnDLJ4A1lHuOm3?=
 =?us-ascii?Q?kCh5QHAI6pp4EhtDVpMtIm7CrVfEIcrIxGaDRyCNHimVnRCiF99CgOpuhO7p?=
 =?us-ascii?Q?+eCJKYbDE+FigGAprmE3u4/5oqwB55SKWA14m8YR5KE9gqTlVacLd5+GgGpx?=
 =?us-ascii?Q?wlqt6llmRl/pLv11NYdLuekzOP+ROz00+FZBUIwAe69xLT1MH68h07Gfz20l?=
 =?us-ascii?Q?ufLaQn8aAISCNLemFPUC3AZWmM039Ah7zdzJl52VsoTODyOeJc79LJgDyebk?=
 =?us-ascii?Q?DC1BSJOfi56zMdxZO273/FprIc4Xj9WW+Xqgi4RyyCuzoErE+dDHh+fnTlI2?=
 =?us-ascii?Q?YJX8NRQUxjAmrHEh23u4nCHo6QtY5hDouLqGdv5ald1R9IP1dAQESlTlxQx6?=
 =?us-ascii?Q?Px0z8lSOBJcokgMFWIxELnNpVnWN8ltQjceyccdsfoWxYNAWyJF0mWCiOkuR?=
 =?us-ascii?Q?f9CkdKpgWlW2N5wToBAZrY2Qv/o1NZe4QB93rP8faDsMZeb1ZSvl2LG45h5X?=
 =?us-ascii?Q?83lPi4Uvv29wHRMux7RDf6P/MEmBD8obyqzp0c+65omAH0QkuCQOc3ATiGvB?=
 =?us-ascii?Q?wQobUFZm46VpAYQpL+uUWSkC8WnwXvS9RZ9+dhBL16fgYi8Cf6oOwpWmuV/c?=
 =?us-ascii?Q?UDdhgDHqc4io4ZqIt8iRNPEDvVyICR4vKEVKDz59jlju6A6lRjGm7L9re/IQ?=
 =?us-ascii?Q?mHXJLxaAtONq09uzQB4Zll7OF5pNYkoPycR32i+P2hNs7jRI4yBGYEvwoUCt?=
 =?us-ascii?Q?hm3n72hxuY37epoQuR5R3Oe/OEHTAr2DoEnLt8/RJi9vfjgkGFi+sr/X6k49?=
 =?us-ascii?Q?rzZz0vg37jzH4jEH045N3HVcsanfYqlEEHMYkTWd7bTCul7UJ9mYggj+9kYs?=
 =?us-ascii?Q?3EllgLWDJbywOTgYIfaFZGDO6M7QUUNZyaywGPyLEfNnGygQVMhi7GA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830fb91d-cc29-43a9-52a6-08db944ffffe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:32:32.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geiWpxtOGKB3SNn/HrNeUJ66uC0qcy1t5vjylespGuUGka1XiTPQEMnN/zbsRhD+xWDFfG/nmG7Hym7rTy5S3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=884 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030166
X-Proofpoint-GUID: fR5vtwMi3dN7DgR5xa5mxWpAKIy6YOLp
X-Proofpoint-ORIG-GUID: fR5vtwMi3dN7DgR5xa5mxWpAKIy6YOLp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230803 13:27]:
> vma_prepare() is currently the central place where vmas are being locked
> before vma_complete() applies changes to them. While this is convenient,
> it also obscures vma locking and makes it harder to follow the locking
> rules. Move vma locking out of vma_prepare() and take vma locks
> explicitly at the locations where vmas are being modified. Move vma
> locking and replace it with an assertion inside dup_anon_vma() to further
> clarify the locking pattern inside vma_merge().
> 
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 850a39dee075..ae28d6f94c34 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>   */
>  static inline void vma_prepare(struct vma_prepare *vp)
>  {
> -	vma_start_write(vp->vma);
> -	if (vp->adj_next)
> -		vma_start_write(vp->adj_next);
> -	if (vp->insert)
> -		vma_start_write(vp->insert);
> -	if (vp->remove)
> -		vma_start_write(vp->remove);
> -	if (vp->remove2)
> -		vma_start_write(vp->remove2);
> -
>  	if (vp->file) {
>  		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
>  
> @@ -618,7 +608,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
>  	 * anon pages imported.
>  	 */
>  	if (src->anon_vma && !dst->anon_vma) {
> -		vma_start_write(dst);
> +		vma_assert_write_locked(dst);
>  		dst->anon_vma = src->anon_vma;
>  		return anon_vma_clone(dst, src);
>  	}
> @@ -650,10 +640,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	bool remove_next = false;
>  	struct vma_prepare vp;
>  
> +	vma_start_write(vma);
>  	if (next && (vma != next) && (end == next->vm_end)) {
>  		int ret;
>  
>  		remove_next = true;
> +		vma_start_write(next);
>  		ret = dup_anon_vma(vma, next);
>  		if (ret)
>  			return ret;
> @@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_prealloc(vmi))
>  		return -ENOMEM;
>  
> +	vma_start_write(vma);
> +
>  	init_vma_prep(&vp, vma);
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, 0);
> @@ -940,16 +934,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (!merge_prev && !merge_next)
>  		return NULL; /* Not mergeable. */
>  
> +	if (prev)

Maybe if (merge_prev) instead of prev?  We will write lock prev if it
exists and won't change with the current check (case 3 and 8,
specifically), with this change case 4 will need to lock prev as it
shifts prev->vm_end lower.

> +		vma_start_write(prev);
> +
>  	res = vma = prev;
>  	remove = remove2 = adjust = NULL;
>  
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> +		vma_start_write(next);
>  		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
>  		err = dup_anon_vma(prev, next);
>  		if (curr) {				/* case 6 */
> +			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
>  			if (!next->anon_vma)
> @@ -957,6 +956,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
> +			vma_start_write(curr);
>  			err = dup_anon_vma(prev, curr);
>  			if (end == curr->vm_end) {	/* case 7 */
>  				remove = curr;
> @@ -966,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			}
>  		}
>  	} else { /* merge_next */
> +		vma_start_write(next);
>  		res = next;
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
> @@ -983,6 +984,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_pgoff = next->vm_pgoff - pglen;
>  			if (curr) {			/* case 8 */
>  				vma_pgoff = curr->vm_pgoff;
> +				vma_start_write(curr);
>  				remove = curr;
>  				err = dup_anon_vma(next, curr);
>  			}
> @@ -2373,6 +2375,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (new->vm_ops && new->vm_ops->open)
>  		new->vm_ops->open(new);
>  
> +	vma_start_write(vma);
> +	vma_start_write(new);
> +
>  	init_vma_prep(&vp, vma);
>  	vp.insert = new;
>  	vma_prepare(&vp);
> @@ -3078,6 +3083,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (vma_iter_prealloc(vmi))
>  			goto unacct_fail;
>  
> +		vma_start_write(vma);
> +
>  		init_vma_prep(&vp, vma);
>  		vma_prepare(&vp);
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
