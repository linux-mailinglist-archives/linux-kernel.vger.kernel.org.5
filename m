Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25938009E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378576AbjLAL0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378554AbjLALZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:25:59 -0500
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 03:26:02 PST
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80622C4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:26:02 -0800 (PST)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.56])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id D999110A24750
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:18:24 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.176.220])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2BA5810000C35;
        Fri,  1 Dec 2023 11:18:22 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1701429500.217000
X-TM-MAIL-UUID: f6fe0a3b-50cd-45dd-b495-24a33d266036
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 351D110000E47;
        Fri,  1 Dec 2023 11:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+rS4UTkfo5lBed6gGq8KYuHlqSGlTHGDbZTusOzwicOyv8d4yJFTQELQA9bkek9jx12YQ3v7J83nxCSDtJBgrC5szqN/+y4/rwokZUW/GxjXgypRQNBk+BbL6Q45/x0kDDRQQl+cx0zoVxKYdCRInv1BylGbcpcSGBPZYaTQnFiYtkPZnSVertM/6ozXvvy60T7hlWKofySLz8RV+M10yOI6m0TmEnnUKNPpSNxDhxJ2ikLQasTGmvY6zgVjVk0EMlFxfO7H9XpRrUvCvHxlTY0JNGSAme3zTwW+YrFbQiTU/1xl/EpNqlEKWOP8O8vi+BhWa2RmivgNjHfd62qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0JARNCiMGh2JxGaDZ69OfAKvOKYOjpv35R4UmLm6b4=;
 b=DPTRTDVIOHi+T9qGk/Rhsa9S2vTYSZdAZoF0VMucbabUVddriz55M+RyNHvkho1e/GklBAP9dl0FB4A9ZffWFFcPBlYRiz4TgSfz4BtIlZvHVm+K7/kMt9Ks9+zA7iXdROhL5Tyw2mhW3s0ylf8OrcIglHhKJnCObLzRSc4xPnJXvNfFVyiZzVmrxdym4t23ByRinAXesYm89kkswkAIc9fcsI6TKj4D8iZnift8nleJfZKB3YaqQGS/rWiYr2ETDwEDb+vjtejW5aBw13QW6cEAr7Blz23C+vqIgTfDBmb/xIusn238+k8Yr9btLi8QSIWcu3rBcKBpe820Ej8SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <6f49eb69-4f0c-4066-a385-042f39cff194@opensynergy.com>
Date:   Fri, 1 Dec 2023 12:18:16 +0100
Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Content-Language: en-US
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "jstultz@google.com" <jstultz@google.com>,
        "giometti@enneenne.com" <giometti@enneenne.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
References: <87lec15i4b.ffs@tglx>
 <c032b7f7-ccea-4e3d-a3fc-d772d034b195@opensynergy.com>
 <CY8PR11MB736445F103863F240E472141C481A@CY8PR11MB7364.namprd11.prod.outlook.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <CY8PR11MB736445F103863F240E472141C481A@CY8PR11MB7364.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::18) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BE1P281MB2131:EE_
X-MS-Office365-Filtering-Correlation-Id: dd55b007-e99d-4c69-4cf3-08dbf25f3889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0ZSdkguOobzAE+CLZAl3teDuFNH5hHy8CCiwDYdrMJtqfGAhnCYhSzwkETJ+soizjSp0NsqhWQwQqMUr+CHx1vnB8+5vI75g6kpgvKAeUkWe9tfgLXkkx/W45JrHq/f3NovnVmwR31iPH2Cu6fBP4LxfuLX/Z5hyyzGCX9Y5w2cFYGeYsi/dHc7Ow9rE4DDbVOLxaUJsvEr8Eno5WSK3kk5Sg6zdWhpPiqsdBl7+D7HVrMAOSabqaXfoZy1ElCif72AwyCeIk5P9GiIMVBDLyt4lL7IVEKepGfrX46Y8JzXYQmNfvxMsjO4NF2W6vjqRbMejJFYfgviGk2B4hSFCU5iTP7WQDbci0+GsXBZ70nwTx9fzbk+YK7ll0RaZ4vMKcugrJJa+I03Vo0gHp9LTUtdvG9nv5LkO5OVqh+lZ3yV/mDo1kn6qXSUMzwtsX7VN3Idc4bGWryLRCM9kv7VpM7DdihRmqWEQaqqZky2k5eNgM8OKF1sVjayTivwZp249lWQapPZ9eCvVjJfzdKVn5TZJbFNugzyJY7aP8zbxtGffxw1+MiOKrBYzKzDTFBumlKvYGtU79Zs9Qo621Mb1oEFli/bXzugclqmXSu0oSegp/71aIgXfSiRILCoZzHetxNEolifizxTzMPvihoFIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39840400004)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(31686004)(41300700001)(2906002)(7416002)(5660300002)(83380400001)(53546011)(2616005)(36756003)(966005)(66946007)(478600001)(110136005)(66556008)(66476007)(54906003)(8936002)(8676002)(42186006)(44832011)(4326008)(316002)(31696002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZWT0ZKZW5DTVY4MjNtZW5JYThTcGRYdUFqcXR0c2gremZXMUVsckZ2WU9m?=
 =?utf-8?B?WDRva1NhV0U1b1BGbDVlUjFwS3BFbkowZ2d5c1A1SjE5SlJrekNMbE9tRWNI?=
 =?utf-8?B?THlxUm5FaThwRGZKRFpENzhnSTNGcWwvRHR6N3Y0NXJmcVlEYVJZenp1S29j?=
 =?utf-8?B?KzRKZkdCZ1dYM010N3RUSDlBOTN4ZlZlVTk4L1BRUWRpVHBBSHd5SlBRSXAy?=
 =?utf-8?B?akxSVVdTYjQzbE1OKytiVGlmZUlhVFFIMXJIMkdYM2tVcFQ1b3I0TmJwZHhk?=
 =?utf-8?B?ZStJUVJVWmtlZ1ljMnFteEJPK3NqaEYwa1o2bExhWFk2dFZxaUh4YmlDNlBz?=
 =?utf-8?B?dFkrbU1zSUNyVDhDS3NqUG9ycHhKTzREc2ROOUZZSldEZ3E0OFQyVmxVWUN3?=
 =?utf-8?B?eU5nYjdFRTZ3bWZMSWxPd0RMbE1IOENJYW9iVmw0UVlvbzIvNkQyckNmTEFn?=
 =?utf-8?B?NlVZdkdVMnU4dWZmcHQzaGxJeEpsc3pzTXVYckdMT0tNNnJsK2tFVHg5RlB3?=
 =?utf-8?B?UEZBTmhVSU1WdXFEakFiZjNSRmgyNEZyVFJoemVGSjRKS2lKbWxIQkg0MkNk?=
 =?utf-8?B?WnhWcTIvNU0xdlBOTUowR1RtZTFPSDZDTlIxaG8zZkN5azczS0QvWGl3SG1X?=
 =?utf-8?B?WnVxMmlkclV4TVJRSGp6aXJzcERZYU83K0tydHFDTW9LK0NrWWZyUHVIc1d3?=
 =?utf-8?B?MzE3OHlCZ3d1ams0cEZEbWhTQVprNGkxc281dkZTcXp6ZFY4S1duUDQvOEVO?=
 =?utf-8?B?ZlM5bDhVS2FwaXJ1dkR5eWV0ZlhYUVZjTy81aTMyczFiWFIvcDAxMjc4ZXF4?=
 =?utf-8?B?R0RtWDZDaUh0UWVzaXh4bE95emQ5S1QzNStDL0w3VUp2QTJGMnlMZ0dqNGxW?=
 =?utf-8?B?MTFqemhHZEhjWGV5a1BUOUtCUTZ0SGo4SmlISEdCY3BYc1VJVUxqOWNUWVE4?=
 =?utf-8?B?ZFV6c0Q0bStra0FkbVk2RlZvV2hXT0lxcFVLUXhZSnVjNHZIeXE4YUVWSDNY?=
 =?utf-8?B?VVZSS3djWGdFR3NPRnBrL005dU9zd2RSMTNNZmdpUmtucXZyT05VSWFPSS9o?=
 =?utf-8?B?aFArTmQ1cmN6Smt4eEpwUWtFdE5nSVpZNXpubUdSWktNR1hEdWJIdk9NWFNQ?=
 =?utf-8?B?d2lOYWNKVXRZQ2tiOFJJeC9nSUJFaTBJVGlMK1hhajNCTFpCc2pEaDZzMVJk?=
 =?utf-8?B?czd5empkcm5Ra1locXJUOEM5UUV5eDF5WkZYK0QxMC9KcjRZUXNVdEVNNldv?=
 =?utf-8?B?a3RhTGNqMzN4amhQTnkvQWtiYi9IcUpnQWhrdEovL2FSTE53b1IzK2VyeUMw?=
 =?utf-8?B?TmpNdWlTbUQrL0Jvd0xGRHM1UHVLblBUWkM1WUtCY21aYnJjeHhzeWJuUG9V?=
 =?utf-8?B?am4rT2l1Syt4cTB1NTg1RTVWbXk0ZEdDQmdaSGJqYURtdFNRNlA4TnNJb1Qw?=
 =?utf-8?B?R2hrYTIrQzd5UUFtd1QydU84TmhmRWs2L09KcWRsRUtlYTFxaHR3S1QzbVpw?=
 =?utf-8?B?dHhydFFSYmxDQndoYjdxM1JhMUNkeVdWVkN1ODdMT1Ywa0lmdit6NDdwZkl4?=
 =?utf-8?B?QkFEZys4WU5aZlpHalB1d2ZoMC8xc1p4blFsekNCZGl1R29lU2hTRGdQWC9Q?=
 =?utf-8?B?ZW03dWV4Tmt5d3NjakN5Y2VFbjBtVkJmMTBIVUFrMysxb1BKbXVCcHpwRW5P?=
 =?utf-8?B?cUZ1cFpiSWQ3alZsQTBJd3BMNlY0WVJkYjAxNXBZMzA1WmpqdkNpWFpGZ3FD?=
 =?utf-8?B?cThzQTdQYWFuZnM2dHJESHk4ZVlqRjkxTzRqWmUrTkEwbDkzeTRjSXNrWExY?=
 =?utf-8?B?ZEhsY0FleFBGWWR1cUNidFlURmZEWmpoVldhNHNlN3N0dzJsR2ZmZGNHUlVV?=
 =?utf-8?B?NFk5dGVGdGZHd3ZRLytMaTZpNnJ0SkR5NnNXQ1JVaFBacXpEYlZ0QWVPN3d0?=
 =?utf-8?B?aVNrYXNaU1BWZmRvazVlZWZPL3BQU3YrRWdLalFJVFA5elM0d3VRQWtaTDZl?=
 =?utf-8?B?SUFtYUYrMVpKRDY3dkJxdWluOFBveXhWUW5jckhoOWFrRlNHZlhFeGxiT0NF?=
 =?utf-8?B?WExoRDRMSmgzK21jelpLd1NYdTQ4S0RVdjVKVy8ySTlHMXRyRFZlOU5HU3Z5?=
 =?utf-8?B?YW04M0VSdXVGUFBqckFiYWg5N2Vacm1hNlVWN2Fwc2ltdWlWMFZObzZzZEJF?=
 =?utf-8?Q?VuN9S8LtCOLMxVVYeOqK7KCNT6dZMBA+dRPNfMungZzM?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55b007-e99d-4c69-4cf3-08dbf25f3889
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 11:18:18.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqKkJlmOLV0+jK3c4uq9i/cT63Us8/sxVHhXGWl/QG8Jv1KEBVZDo72EuQYLjRgpY/0UQRO7ZlZBPY/hXfdiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2131
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28030.007
X-TMASE-Result: 10--24.531800-4.000000
X-TMASE-MatchedRID: 9d2LtCNB3NL5ETspAEX/ngw4DIWv1jSVpolXqDXvwwqZs9QmGT9XcN2i
        oI/MuJyoe3qllbVoTcZ0JOJJCWSDDLcdcE+otv0mOEwpPzUVSKEZ8/pDtedih9Ex6VWGUCnySGB
        h59sE2QRBVklpeYYMCz0LCwcPcWYGfiviG5INjlBLviwaHYb1sUeRHI3muJ+LaOAduOqDeLqpc2
        mXV9zZ17r+EX/mU3pAlfwRGtUQCJavbDT/HxUFbJtnlFv6A7ohzWee1Tq8TTSsgvpEIQtg4l+J9
        aIgnPKJlCI4EOxz9u5eoXjftsK1bPRTrALVz9747hzwMwStqTsHgEx+rhLN4hxnMY5CbhsDNXzp
        ViNo0pFpM8CswneqknqI2XPNzdiJvqbLRlkQYVrkRfeYLNgoborq4+6qgmua6QhHoNZiw8COLfK
        nBtebPoGwjJO9Z+9p6xA0Ava73nBHnLDmms99+BEuOqgkm3/1mVEKSAFs7pdrU/wiTXMFxSmosm
        kzqmqYnujJdZXuvvw58Sarp97J8yUIayx+Skid
X-TMASE-XGENCLOUD: 935a133b-6110-4dc7-9511-dc1e2a7bc9d2-0-0-200-0
X-TM-Deliver-Signature: E2C55A34351CAAF07811498725D99C8B
X-TM-Addin-Auth: VQjMi+39NY+t37pDoWA5h0bFk1MqaVS9hnm4WKQwXAr2L77LfTsenFd/ufy
        I5vy2skq6XfZfVjKJ8BGLdy9MWLATAonf+Mvrip1BOdHgRiLeNnmyMI7onJqlJV/l8qnKdwHRtr
        ZB1IpkZhhIx99/sJ92K/28wqTKlERuxuZmajyP4NL/6rFK0FH1UUXODd1zzst+6Do8YPClaM6In
        wrp+yE+djqNBWZd9hiQ6MvaFpl7CfXuawzB+G2sjwNAqvoRpojNy6+hnzIv2xKuZ2XV0DvwH35n
        +m+Fik0nw9lTZAo=.33obBXZl3kBNaihBXgK7Zyu82KeVlpp7Pog8f9r6hDFf0gPdp/aRI6UFE8
        u4JzDGiGf9hN6inVv0Y6MzoXghwiWMwthvOWyQT9rh8Sc1eUsevSFP/Gb/UR8Vnp+QFB/rvDc3D
        i6aPzfL+klWLQsj9+dRXanxB7B6saIAppFAfwBbpKH+9gUp4ECBhDP7ZB5pcYl88eVwxFGLm7MR
        bGOixcyPZ0eHj8Oq0vlnlryXg1XfmzWeEKHqNQJcTN6QDdoTeLfAvP3/S+RsUCgcsVN9Ofm4+Si
        wJLy6MXf3XjSorljVvC5FlIUOLqMpXqZXy5GM0wPU64JMuK+9hHN4/4IqKA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1701429502;
        bh=4/QJFgWn5jrVpWA3BYiYNnTLvD5rBKNU8eAUKTQzpSI=; l=3736;
        h=Date:To:From;
        b=TW3ASx7Swn4oSOHGFSqaBX9XOXJ7XewoUc16ftgIuOhKl0pSetWM7f8GBya7ErRwe
         ijxdIB76oE2cn+InZH6WzjnnZapUa40Gt7Zan+4PnML+EcG2uPYumEfn7BUb63k+Nc
         VxkValuqn83g0WLxpxbX2y6HoGtBO7cY/B/Z+49uyyt+9v+NsQOOIzRg3GvF8Teq/j
         mtXt/3mhvQkLbrYJuEl9jrmpoPRti1ldyIRS/6ZguatAmq687SajXTWm/73rZfoT3Y
         Oq+oOj22neZItlNW67P6Hqzlz6S9GEQkOP2gnq0AU+i311XulliCFAms+Frip1/QHI
         QSiqAOgD1e5Zw==
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.23 11:22, D, Lakshmi Sowjanya wrote:
> 
> 
>> -----Original Message-----
>> From: Peter Hilber <peter.hilber@opensynergy.com>
>> Sent: Friday, October 20, 2023 9:12 PM
>> To: Thomas Gleixner <tglx@linutronix.de>; D, Lakshmi Sowjanya
>> <lakshmi.sowjanya.d@intel.com>; jstultz@google.com;
>> giometti@enneenne.com; corbet@lwn.net; linux-kernel@vger.kernel.org
>> Cc: x86@kernel.org; linux-doc@vger.kernel.org;
>> andriy.shevchenko@linux.intel.com; Dong, Eddie <eddie.dong@intel.com>; Hall,
>> Christopher S <christopher.s.hall@intel.com>; N, Pandith
>> <pandith.n@intel.com>; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; T R, Thejesh Reddy
>> <thejesh.reddy.t.r@intel.com>
>> Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
>>
>> On 17.10.23 18:27, Thomas Gleixner wrote:
>>> On Tue, Oct 17 2023 at 10:54, lakshmi.sowjanya.d@intel.com wrote:
>>>> +	guard(spinlock_irqsave)(&tio->lock);
>>>> +	if (enable && !tio->enabled) {
>>>> +		if (!is_current_clocksource_art_related()) {
>>>> +			dev_err(tio->dev, "PPS cannot be started as clock is not
>> related to ART");
>>>> +			return -EPERM;
>>>> +		}
>>>
>>> Ah. Here is the usecase for this magic patch 3/6 hackery. Again, it's
>>> the wrong abstraction. You want something like:
>>>
>>>     timekeeping_clocksource_has_base(CSID_X86_ART);
>>>
>>> or something like this, which can be handled completely in the core
>>> code.
>>>
>>> All of this needs some serious rework. See the below disfunctional
>>> mockup patch for illustration.
>>>
>>> There is also a patch series, which tried to replace the clocksource
>>> pointer in system_counterval_t with a clocksource ID:
>>>
>>>
>>> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fall%2f20230818011256.211078%2d1%2dpeter.hilber%40opens&umid=463c9a27-09dd-442f-8b69-49391ffc0193&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-31f616e9a1d239a660d3c4b60c2f3655ce46f5d4
>>> ynergy.com
>>>
>>> That went nowhere, but has some valid points. I took some of Peter's
>>> (cc'ed) ideas into the mockup, but did it slightly different to make
>>> all of this indirection mess go away.
>>>
>>> There are certainly bugs and thinkos in that mockup. If you find them,
>>> you can keep and fix them :)
>>>
>>
>> Hi Sowjanya,
>>
>> I am working on another iteration of the patch series cited by Thomas, which
>> would implement part of the mockup. But the scope of the original patch series
>> would remain, so no changes to ART conversion code, no introduction of the
>> clocksource_base concept... The patch series should still be compatible with
>> Thomas' proposal, though.
>>
>> I was wondering if it would make sense to coordinate the posting of my patch
>> series. I planned to post the series sometime in November along with other
>> stuff, but I could potentially post it earlier if this could help to align.
>>
>> In case of interest in aligning, I uploaded an unverified preview for the upcoming
>> series to [1].
>>
>> Best regards,
>>
>> Peter
>>
>> [1] https://github.com/OpenSynergy/linux.git clocksource-id-for-
>> get_device_system_crosststamp-v2-preview
> 
> Hi Peter,
> 
> Thanks for the patches.
>  
> Along with the patch you shared, we have verified the mockup code shared by Thomas.
> 
> Please let us know when you are planning to post the patches, we can co-ordinate and post. 
> 
> Regards
> Lakshmi Sowjanya D

Hi Sowjanya,

thank you for your response. I am unfortunately late with my other, not
directly related, patches; my plan is to post them all together until
December 15th. Is this OK with you?

Regards,

Peter
