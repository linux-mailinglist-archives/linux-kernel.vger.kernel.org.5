Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E857BF9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJJLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:39:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F994
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNntjEfzPVFALLxzSeATGLVPTRmnHran1qH5efdEJ+lp33LQHFrRx9ZkXnEl3qXz4qOVDqIlLBuL7/+Yi7SET1+sVy6eHfk+cDMEYtIeQPgw1fzBfBuG9cE6PUPSoV1HmXhQ5G5TradTT5pnlzqlzgtnC+cYEE0PngQK2/abMepskoatfFLK3s4AumaSvjtZvgPrrwgIfY46XtU5qwh9sMrFMaOyXCvdiaIddKOfkxII3DJTc6eYfOOKO78pqB/5cdO7iiKleGMoBCgMot1RNZAOwHJTSUzo8c/sJOwCbqwYxL8fcUNVeLEqD/gf5atgyl8egF7hm4j17sTY9uFYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNIJ/p3l+4XPFgaLLfbq5mXqRnkQykF5TpsbfbjN0fM=;
 b=LRbX6D/miGytvw0T2D/2lcWpi3osA3tY1ZuFU43ImgGsnuagu2UQ1dNACAguvkcZrs8s186ewLYXUCyyrZrsc+h1YUmuH0fqslWQ4/YRBSDT8bkJrJQI+aMPssLRppAIdPTl8sWIGvyE3jQpU62/A/T/zVazp/UnGzXnEELqSvdWPNeT2pwXaU46UOoMiWM7tATlVUHibIE/Pvra9BI0vW1AwV43bQq7XuSA68rvr6Q2HbMVeWzgy6Oh2xyR4tEN7S+bV5+Fri3YvOg8XnWnTKIATZHW9BiZi3cbZK+WaIJCWIVdqy5gn8IefenPC9KLUBb+Yv7USeLt31ARRBXZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNIJ/p3l+4XPFgaLLfbq5mXqRnkQykF5TpsbfbjN0fM=;
 b=2TKaA9Rj0mTLfWPbwjbaUWV+tgjiiiBsTW3h99r8YGJbYv7cEdXLdLx4ZbvvTAOFkFcKowfU+9rEu3Nh/du/xGed4md0lpHHrUK71dX5td2tHziQUO1PBPSrDDj7EVyhCuOWh3W/rx1ZKqiT7jid8ZLeaaVMc3ikPVGy+NSAa4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 11:39:39 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6863.041; Tue, 10 Oct 2023
 11:39:38 +0000
Message-ID: <793eaa1a-c836-3f0d-7443-b2165a9c6ab9@amd.com>
Date:   Tue, 10 Oct 2023 17:09:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/6] sched/numa: Complete scanning of partial and inactive
 VMAs
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20231010083143.19593-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3b9660-cf5e-4fc7-2bb6-08dbc98595dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lA9p73YgkFzbVDc5JKWQHzrY7PuqTVuoofZ4g8wEDS6G7hRKWbcGlwt55T2fp1x6qfuT5rGkvmk2XHQjWHbfvV0HdVtgw7AaOb2qv8/HJUc7IZPX+5O2DdP/TsaWYGG7I2C8DxE6BNmnnZA1kADRe9c5mvdAI18bYuBmFy7bBDOJSoXa1YaU2c2Fpf00e9aEOPWdn/zg/WXzZfzI2RA0HSxt1DADhu/xU4IIW2ofXhc4ASINyecTW5cAc2uSkja9seWC8d20uFZHwfwvI5i2RpJv6Y2kQHlcxLb3IKuq/Own4Xb85l3qFjLAvRTbuYHx4OeoOKnZZrLBEvXnAoH6C2WZYff3QWs5p2qgsM76UwJGExdoDEvQNzU1VbxlRwRO7TCzI8vkjKYIq40WP+zlnq1wtOqCmz1xBkWWF2Il2W0bXFO2iOr3DH6xApHj65TQ+iG9bA07TXEojVBNW22YbY7w+UYnkTmTuOQfUoxpo+Su36VpKHQuILe6rcSTD/RtsRWi08FD1LIcIiTYFZqoUrqe4ySlKtcc++tlPDQLpo6tSphUmJSBMu8BOrT+SicvxU8wo79qWzzDBdldbJWhrbgjEkeV5kCMCRDV7jqQSJOONFXmO206GiYTgOUz31Cf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(83380400001)(26005)(2616005)(53546011)(31696002)(38100700002)(36756003)(478600001)(4326008)(6506007)(2906002)(8676002)(6666004)(6512007)(110136005)(5660300002)(8936002)(966005)(6486002)(316002)(41300700001)(54906003)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdTZmJnUWVsREtwRHJoVDgxdStCb1YzZnpWOXo1WnNzZ3dMZHlLM0dEMGRP?=
 =?utf-8?B?SGllcVFkSHVid0RjRSs2ZnV6dEFxaGNxL2ZpZFRRVk9jS3ZvNG4za3FXaXp4?=
 =?utf-8?B?ZisvWks3SHptTG1DNDIxNy9pb1FQS2xjallRQVBmTThyWS9IVlZPNFYzT3Nl?=
 =?utf-8?B?WS92Z2ZFOTNXMW9sTDN0WHBUYWNaZTMrUXNHWC94SDh5c2Y4Z3R6S1I3ei84?=
 =?utf-8?B?Qk9uMGxFTkpPWDdPZTBxSGhBSkY2cGQySk55NGlENGZhUE41WEJ4VW92Z3Nl?=
 =?utf-8?B?NXdaS3lhT1hQMHhBRm4yRnM1RTRDMHFqbmdVazNubTZ1SHpxSmhKc3ZuUEI0?=
 =?utf-8?B?YlpiTmxLNEFjTnYxak5RcS9IVGVrSzA3WGdEZFRwTFJDWkUwVGJNUkdUSjN6?=
 =?utf-8?B?WktwSUxKQzFsY0dTeXVKQXhwKytqbUMwUU4wZDU0Q1B0S1RCa2xMM1ZRMVRx?=
 =?utf-8?B?Vkk1Y0lqWHJSanJvY3k1VmpHWE51Vkg3QWV0ZkRBdmNpVUdzYzdwS3lFWlBU?=
 =?utf-8?B?ZFJLSXRaRjZKSkxUMUpnQ2dsRkR1WHppUHVocFZvalM1eDY1S0JabDFVcitK?=
 =?utf-8?B?aXdMZy9wY2J4dVV3R09aczdoLzVTc1cvWkg2YWFiVW5kQnBjY0lwaWNvVzJx?=
 =?utf-8?B?VWtsWU9TeHpFRk1BR3drRzlCZFYwbHNRRzhHWThZK2NXR0NxV000L01PZzVx?=
 =?utf-8?B?TjZ4c1J4NW5FcnJOY0wvUGdmejdUcUtQNlJBanNSTk16ZlAwdy9xNGxCdEV6?=
 =?utf-8?B?eWRjK0puT0NjWVpZbFhmUEdrWkYyTEprdEJYZ0JIRzJCQWlwNUdiNC9HR1hG?=
 =?utf-8?B?azNaU0NxSFlQaEhacTEzUWNKS3hIUXJoVHBlWnpkR0thU3JjSUpQaW1qSkYy?=
 =?utf-8?B?NHlsM0VVRzZqbjVlL1BLVG1nTG44VVdxOFZoeWF6RC9QN21hcmo5RkxHSXhS?=
 =?utf-8?B?VU9uWmppSGxlalc2QkF3Y3BLa2FrMmM1VTBXQWhNLy9KQ2piT2RyUlpZR0NR?=
 =?utf-8?B?RTJkenZEOUN0cW9udUlOamJGam1Ic28zRStITTZiR00yL2hmbyt0NVpLN3NI?=
 =?utf-8?B?VVpOSlNZc0hDclNwNm9sbjBKYU9PelhIWnpkRjVtcUtqNVJiZTI3K0RkdWEx?=
 =?utf-8?B?dHcrWkhOaUdHdEV0UEsxem4zYjhQYmE3M3ZiK3daVnZ1NDBMeXBZd1JiWk80?=
 =?utf-8?B?a2xnSkFHakxlZXI3SUNyRENnTUJ5R25mMTZLc3RtUDU3Z0hFS1hpbUZoblNV?=
 =?utf-8?B?VU1GZGU0ejEwYnp2VnZMeldWL3Fab3Z4MmhlV1JLL2pMUThRRzAvSXNEQmpn?=
 =?utf-8?B?NEVWSEV2R3FPNUhGdllWQUVOamIxNnUwV2Jack9KdXF2aVF0RmduaWh0dklQ?=
 =?utf-8?B?TCt5OU05K0xzYmthUW9ENWFvMTFxWTRqQXRGYTR3NUFRQURYQVcybXRrN1hC?=
 =?utf-8?B?M2puZlRKbHdTc1kydG0xbENUSURncWhhN1h6NDc1N1cvbDF5U2VUT2IyODh1?=
 =?utf-8?B?enhnVG96OTZoSk5jVS90eDhLRk0vNVFHOWxMNHRrNDIxYmZ5bUptdFRZd2tI?=
 =?utf-8?B?V1lraFdPdlhWakdNdXJUSThsVHhlNFpaT3RmUTFUOVFOTkI4MUg3SW5oVmJ5?=
 =?utf-8?B?eUZlbnN0eTQyMU5pWHdnU1BhZGRBYWNnRmlVM0QyY0Z2S1BXRXkySlNzRmRs?=
 =?utf-8?B?VTFnQjUwN2NPQ3k4UXlTSEcydkFiUG9uam56RjdER1IxSUw4ZTRQQ2x3SU52?=
 =?utf-8?B?bjhudjRwQ0hIVTFCcG5xVTIzamdGT21lNVB6RUxadzVHejNnRzVBcTdqdkJt?=
 =?utf-8?B?Mmw4bTRnWEFudXJpTUtTSXIrUlZWeldlZHMyTTZIRk93ZDIydkN4Um5SUzdU?=
 =?utf-8?B?dXZLTEhDYmJOaGYwRVozNzBnaVJKcHNmQy9GdHRIVldEd1BXUkxwT0o4a204?=
 =?utf-8?B?elpQUjJGU3ZDN0ZONXhwZlNwZzlkSU9FdUFtQy8wN29lRFIyV1p2QjhnNktP?=
 =?utf-8?B?VHBpcWdTK1NRSVI1MXdGai9EczROTi9BY0x5eDF1SEgycWl0VitTcERNT1k2?=
 =?utf-8?B?WFB3YnU2ejIrUVJDRWNZdlJwVUFkMTFML1huNGdhc1pYcm9BRWVEUTNBQlMy?=
 =?utf-8?Q?YSLh5LseNojiyNUz6qqQVG1v2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3b9660-cf5e-4fc7-2bb6-08dbc98595dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:39:38.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELxTAyCEeOx/VKSeZ/eyjXoa9kIZtQalu1Us8tEDsne5wPRLgaxQeiKFziti1RWTL1vjfV2pA538G7kENJKLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 2:01 PM, Mel Gorman wrote:
> NUMA Balancing currently uses PID fault activity within a VMA to
> determine if it is worth updating PTEs to trap NUMA hinting faults.
> While this is reduces overhead, it misses two important corner case.
> The first is that if Task A partially scans a VMA that is active and
> Task B resumes the scan but is inactive, then the remainder of the VMA
> may be missed. Similarly, if a VMA is inactive for a period of time then
> it may never be scanned again.
> 
> Patches 1-3 improve the documentation of the current per-VMA tracking
> and adds a trace point for scan activity. Patch 4 addresses a corner
> case where the PID activity information may not be reset after the
> expected timeout. Patches 5-6 complete the scanning of partial and
> inactive VMAs within the scan sequence.
> 
> This could be improved further but it would deserve a separate series on
> top with supporting data justifying the change. Otherwise and gain/loss
> due to the additional changes could be masked by this series on its own.
> 

Thank you Mel for the patches. I see Ingo already took to sched/core.
Here is my testing detail FWIW.

SUT:
- 4th Generation EPYC System
- 2 x 128C/256T
- NPS1 mode

base: 6.6.-rc4
patch_v1r5: Mel's  Initial series with prev_scan_seq = -1 fix
  Link: https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ 
sched-numabselective-v1r5

(May not be relevant. But I did see number was even more better for
thread_alloc, so ..)

patch_v1_r13: current series

numa01_thread_alloc
=============
         base            patch_v1r5      patch_v1r13

real    8m46.557s       8m29.040s       8m38.098s
user    599m6.070s      268m38.140s     404m52.065s
sys     3655m38.681s    3794m10.079s    3751m36.779s

numa_hit                394964680       396000482       393981391
numa_local              197351688       198242761       197008099
numa_other              197612992       197757721       196973292
numa_pte_updates        1160            790360          812
numa_hint_faults        755             729196          553
numa_hint_faults_local  754             410220          263
numa_pages_migrated     1               318976          290

num01
======

real    18m26.691s      17m31.770s      17m33.540s
user    4501m40.194s    2148m7.993s     3295m57.897s
sys     3483m11.684s    4764m57.876s    4215m35.599s

numa_hit                395473956       395813242        395000242
numa_local              197776626       198188480        197983594
numa_other              197697330       197624762        197016648
numa_pte_updates        1447            4625319          7142774
numa_hint_faults        1390            4947832          10313097
numa_hint_faults_local  1288            2758651          5354895
numa_pages_migrated     102             594803           960422


Thanks and Regards
- Raghu
