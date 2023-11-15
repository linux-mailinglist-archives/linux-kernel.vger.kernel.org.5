Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394947ECA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKOSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjKOSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:14:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2262C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:14:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRJcZpMaaz0FIpq5mcT4V/M7iOCsPQmpCDHlA+mKeHrULuUklvoBdAIzUhJwxmbOrDJ0Kcp/p8p7MDqJtbSfQk08Afpa9KKozWfKGcilpRlO0dP5e8S5f/4N0LL2QzR9X26xKibp9n62UVJhLT+Dt7Xf4HpDtQuf+JM26J642p2F8YxYdvqdlk6Mixuc2ojaH920Ev2oEmtTGy2YgJATSEMj4O9oraK1PhX9WMS5Smfa2iSM0hA612ctqdH8S3Ei0X9C6c8l8SE1rxPCrvd/+KZL229NqOpo0ccJ/9MGKhjRKvJuUv8AqpDUiGOyJ2zIu34v4VI1lHaN41qpUwMpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgvV54sPb8PB2pz9WOUZHqk8ZR5skzIpNc2cnqz5FfU=;
 b=TUUnm9zGNdx1MWyZ/Hv2bZ5wKss0gHi5zd84IArZtAcdqJI08fnAv222x1oQPHUI9u0xGT/5I5A4O3pT1M0yk0g2U3bwyOblXY9sHhR4b3VGVXIxWiYtmmF/n+nBYnDCdfVdcuTBNmUlaG8c6g3n7GaS+l+GKr4frYT9sVUdtJIzU36yeAb8YSFfJ4Qq96VzJqj/I59rYgrJXCpGYKg428hwnqty9hiBIXjZa0H5T6dvN22x9pvcj6qPar7VGTDIN+6875uftjiDfRUcUa5pqcupr4Av5oKU93ohyYKvWZbKCoOJcGl35hqxdD+dH49dkf58dhtCJ66tu+fzDU8soQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvV54sPb8PB2pz9WOUZHqk8ZR5skzIpNc2cnqz5FfU=;
 b=rje9hQyY8m/qNjSwg/zuVpEDnmUmuPlc6z7kicC/nfO5ahkC8H5iDIet8rt2244/Y9xkm/OWv5fbRwxArii7oOInrKCvcBnaBlsUV4v8T9CtI5aO0DBDimsUQCK19KgQaGKBU8b6p9sNd43Wgrl9b1QND6EhRAvXGwVFFIfFuLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Wed, 15 Nov 2023 18:14:43 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5588:7117:d54e:9466]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5588:7117:d54e:9466%7]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 18:14:42 +0000
Message-ID: <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
Date:   Wed, 15 Nov 2023 13:14:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::12) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dfbd00-9103-4228-0278-08dbe606bd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/nh+ewSQOpHJUnZFAlNDakS0plGC9Q0IJIHJpbN7qSumQ2ScdcoHR5++/NMggWEwyOxHYqs5MoGwVpxCtyzNiNxFaujRRR8kXhEDFSwg4bTG5S1pCyDuxAtXn1eO1fJzrixZbpKUHcBEQPe1IBiHZHn5d8SrTDN1IqwUk87ajUz3nnqoawgotOl4gmkCdVfxgt/Md3QgoS2TZzTgCDz8Ccae+czkNLbrDZHUpEK2+KeTUPui6JrsBcHLK+pb2JdqSpLZ3UoaQ5gCHqJQ2BNlCPe1JL9kl/cJ5T0/HM4wDJecaPSx6gbacUkLaY0paZceKJ4i0mszrSk8UoKHbc81TagNB/ctE/tWIYfhADDhqU3/ExW/9GW2aW4n90BfPRNNCCs1SzqAKlrPvZ2MadOHGW5dUX4OoABQeVPuSdXs07PYPZF+7hvRThe8PxtlLYP8zbKS6kb9xW7U3auKcwr691WXZml3kNxC/qfGRdQ4dU2ugYFP+HtJO/IvItYD61sPRVVGEBCkXFzPQ1LaiWkUj6kESrGb541MBTZBFpWtBVb9T2EVKu1dOnrl5pICObbtdr7NIBXaSs9QVRPpL0wurxGEnCR9sQvr8lq0qQM1PmlZjS1TLMskERlERfW0zyCPJ1rGeH243uLqEg6X0IVZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(6506007)(6666004)(53546011)(2616005)(6486002)(6512007)(83380400001)(44832011)(41300700001)(2906002)(966005)(8936002)(5660300002)(316002)(8676002)(110136005)(66946007)(38100700002)(66476007)(66556008)(86362001)(478600001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBUQnJFMUV4aU5MUzhEN2ozZzI1QzNiUlFxeWppbklEUGl2SzhDN1Z2dmFJ?=
 =?utf-8?B?UmxoTE4xSFpNclhrRkw0TGRhTlFCNURGZXpscVBKZ1c4OXFPY2NlY3dpdCsy?=
 =?utf-8?B?YkxsdVozS0J4eGRkSEFZUlh2NHFwVmlsQURnelluMm1kWTZMVWNUQXh5V2pw?=
 =?utf-8?B?SXVpTDdXMHdodGEvT0lXaXV0SXRiQzZPUy9hQjFOenk0WXk2aXdqMFNLc1dj?=
 =?utf-8?B?VmI2aUpzS3F2SVpFZkxzN1hXKzVZNG9NaGlBTFNQdE4xQWR0Nm5GSS9QdElR?=
 =?utf-8?B?UkFlQ1U1bWJLZ1VoMDJtRnlkYjJQTS91VU5QbFBXQWZCcytzU1p1VU93N2dz?=
 =?utf-8?B?VUJobzZSNS9HWHptRENSTGlyU3JlRDczL3VLS05zTmk0ekMwL3dDZitSVm1p?=
 =?utf-8?B?SHdJOHFKb3YwWU1UY09UdzFpYWpBNjNOcUUwUStQSVE3SzAxbGZkUjYwQ29k?=
 =?utf-8?B?bjhLY2JCdlljOVIrODdXS3d6TmxUU1ZveWVQTzQ0TnVZa0lYaTlQTW5kWDU0?=
 =?utf-8?B?U2ZWWGZWcys1M2RDKzRRWmNqVmlSTk1DUlVpZzVDb2hFWndNOWQ2UEN3N3Zu?=
 =?utf-8?B?MDNJTXdHUVlEa2NOZmd1M2ErdXd5akNxSFNnRHpDUGduOUpSbktwNUM3SS9o?=
 =?utf-8?B?ZndmRGFrcnVVd3pFQ1VOWSszaW1ESllGT1NjNG5RckJUMzgvajlGMDFkZVlB?=
 =?utf-8?B?YnZUTHlSK3FtbzJwQUtTZ0RjMUpWTFlVZkhmUy93d0Q5VE5oQkFQamxGbGNY?=
 =?utf-8?B?YlV1M0tEWU1PeHZXYTlnbXFYbTFWczIvQnhScFFtWGVYYXlUa1hEUmxmblhq?=
 =?utf-8?B?alNrTjdVb1JZWVdZcTgvUTQrVk1hMEhVMnhqVklRdjBIelovVG0zb1Z5Y0VU?=
 =?utf-8?B?STY4d0lZWkRZS1E5ajlqT3Z2R29zUXF3emlmK3hVaTU4cGRBN0hGQ0V5QjAr?=
 =?utf-8?B?OGJpekYySFJPbzdHbXVoc2JpVUtZQXZNSmNobGZ6RzEzTitFSW0yUjFEQWJ1?=
 =?utf-8?B?M01qMzFZQTd2c1VXamNsOFJyNnhOc0tZWE1aTzhzWTdyRnpmVjBBaHFxaGt4?=
 =?utf-8?B?dEJZbFdKeTRoU1owRGVuanhsaU9JUU1mL0p2N0Q0ak1YNEtUNlFKZFBxRUZl?=
 =?utf-8?B?SjU4U1dqYkhNbVRvd0NmMkttUnpiUjlGbzVuOXRiS0ZnaExFM0cxY1lwamJv?=
 =?utf-8?B?U01nNk5tUUJKb3pNbmM5K0o5TlRLZVN2VHFiU3BHaEJlRTdZTVloSVBhZUtX?=
 =?utf-8?B?b2t6bUFoTVo4WWw5c2FpcHJHR2VzOFVKSDUvNHp6TTYvdDhuMzZxSTE0bmxl?=
 =?utf-8?B?ODIzcHV4L3QrNkZMNHF1Z0FCUDJtNVRHaDVnVGhGUE5HZlp2NURtSHQyU1JZ?=
 =?utf-8?B?SzEvRG5meGNBU1ZmSnBNOWZOU3FzdUJvQktoU2YyWG5DQzVwM21ja0x4S0JO?=
 =?utf-8?B?b2tRbEJHdzE3ejZLQ3F6dWEzcktmZ0Z2MjZuM0R5RVozTG1xYVJiOWdrZ2dj?=
 =?utf-8?B?VXRlcmRiQU1lTHlhcDd2eUNuelFzUVJ2WFRSbmdqeGlPOFNQVFIrTEMyUHB5?=
 =?utf-8?B?SG12aVQ3UmdXbnlPWEFHTkdCZGVkRTFvWTErOFkvRU5SeE4ycmx4NXJqQThz?=
 =?utf-8?B?RG9TVEFua2VLVDlJNHhnL2w0aHhYdENFcjFXa2duazlBTTVMNzdPWDIrbUUr?=
 =?utf-8?B?N1lhclZIblBXNjArNE5selNXMHlZMUx1OFpJMGlJUi81bTF6ejdBdUlDTkVJ?=
 =?utf-8?B?dWZjZWVpZkxhTmxJM25zRFNnSnZFODRmRDZoQWY4MStyOW1DYU5OT1lvRkpT?=
 =?utf-8?B?cnhzZy9qd1N5Y09aRG5vVm9qREpwUHJDVDZnOXkxWmxMU2RpMTVRU3BPaXBt?=
 =?utf-8?B?eWFqeHRiTXA0a3RyMnkzQXhIcTVXZGpwY3FTQ0d6YTZpNWJRYzZOa1grUGxw?=
 =?utf-8?B?ZW9mUTZVb01TY3BOUng3dUtIUzNweENQZjVvaDdGVVp6czdJbDZiMGgzdXJi?=
 =?utf-8?B?Tm1mYXNVaGRpeDlLMWZCajBFY2xwbVR3OHc2K1VRZ212dDUrVGxydFdQSEhN?=
 =?utf-8?B?amliYk9xVjlSZlVJTG9HdjdGMUhPdDRUeFkyemtHUndsNTZoSTNEQk82R2p0?=
 =?utf-8?Q?AkcvM9eYuVOlJEgfmgvJ5nJ4/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dfbd00-9103-4228-0278-08dbe606bd70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:14:42.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShWmjDv4YU0OwSuYmnirgiu4517UpuSHpwoPTZ6uEtiQMVMscQvA1/7AJlbT48KCGnc+BeQLNpISX0QFc/Jvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 13:10, Mikhail Gavrilov wrote:
> On Tue, Nov 14, 2023 at 11:03 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> On Tue, Nov 14, 2023 at 3:55 PM Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>
>>> Hi,
>>> Yesterday came the 6.7-rc1 kernel.
>>> And surprisingly it turned out it is not working with my LG C3.
>>> I use this OLED TV as my primary monitor.
>>> After login to GNOME I see a horizontal flashing bar with a picture of
>>> the desktop background on white screen.
>>> Demonstration: https://youtu.be/7F76VfRkrVo
>>>
>>> I made a bisection.
>>> And bisect said that the first bad commit is:
>>> commit ed6e2782e9747508888f671e1101250bb19045be
>>> Author: Alvin Lee <alvin.lee2@amd.com>
>>> Date:   Mon Oct 23 14:33:16 2023 -0400
>>>
>>>      drm/amd/display: For cursor P-State allow for SubVP
>>>
>>>      [Description]
>>>      - Similar to FPO, SubVP should also force cursor P-State
>>>        allow instead of relying on natural assertion
>>>      - Implement code path to force and unforce cursor P-State
>>>        allow for SubVP
>>>
>>>      Reviewed-by: Samson Tam <samson.tam@amd.com>
>>>      Acked-by: Hersen Wu <hersenxs.wu@amd.com>
>>>      Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
>>>      Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++---------------
>>>   1 file changed, 2 insertions(+), 15 deletions(-)
>>>
>>> My hardware specs: https://linux-hardware.org/?probe=1c989dab38
>>>
>>> --
>>> Best Regards,
>>> Mike Gavrilov.
>>
>> I forgot kernel logs. Not sure it would be helpful because I didn't
>> notice anything unusual.
>>
> 
> This only appears on 7900XTX and 120Hz.

What version of DMUB firmware are you on?
The easiest way to find out would be using the following:

# dmesg | grep DMUB

> 
-- 
Hamza

