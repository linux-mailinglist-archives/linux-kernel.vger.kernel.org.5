Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C1755D41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGQHo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGQHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:44:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49938E7F;
        Mon, 17 Jul 2023 00:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCM83N0OdRME3S0PH4DiAvVSAE+F4NRCVpGoZOatAUdEXDNjrwFY4OdFnQsYcwhpOwyG2OxyfvFKGa2F3vgIH9Vhew1nGqZeU3GMkovB9evHaMgnQKkziMVT46VyLPPx3MjXvXJdAfUJMYFhGZbCj8Rb2idjHglGFhWyqccvHh8xJCtw50K/JVsjRi3AnHA3iRpMrREfWCL0t+RVgICeRc4vKo+Qb7MIRRfBjiQnig0zi5+qd459bg5aRraGyqJfvUdH8MiJajgPpHAuZ52kCoE5D2fv9+uWwA81GCB1ULErBe8yri02xFKenk3iz6OUeoGqGfMz8kqVLIQDA5+tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/afaGT8QIX1t2AYEHl+FLQKoyzhLbVbAh/CtmJIwSU=;
 b=f8kh7/fsJo0rezv84NH5reQdTayckY8uoN02WgOJtR0SdyWW8k+2zlsLX3G4bNRKYvLHm7i4dDo83KmNlN7zYrqd+v3E1De7WPWe3JXO68mo5n+gaGTu150Qvead3XnJh/LJ8J0gdroWay8iNJJey6XhI0o22Qs0siH4uYdmevLCi/TdSrJ8RU1D8KtiU9D/TLEShtNiB4mOr94fXsGz0U1MZMyqs1l4AnOhHxXIzzZ8RyVRHAc4ACSTjBvrJgE491dHv7DNpYdqv/fT9fhMBC1OhuljNqxeKRm2UElkWIrLhUQ3GQs1nFmYEpuBNzfIZgbQgrbUanYd/ncBeWjb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/afaGT8QIX1t2AYEHl+FLQKoyzhLbVbAh/CtmJIwSU=;
 b=jLfuZYztg14WrkS3SW13k4A23p6c7T+XFMOruIoURp0JcxKTmV4ROD/Et/F5JTY7sSaUaWWfB7jQnTbI3nEOvu9GUPn708iNceE1xepwEG3AiYDwwNxJHFr8lmszWWlPbCXlB7IA9JUyCv4/jkM+OZaZbdG/FUSFArGYfHdXcLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH0PR03MB6114.namprd03.prod.outlook.com (2603:10b6:610:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:44:30 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:44:30 +0000
Message-ID: <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
Date:   Mon, 17 Jul 2023 15:44:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com>
 <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com>
 <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <20230712104801.tgawhexpm53ocgd6@chromium.org>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230712104801.tgawhexpm53ocgd6@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH0PR03MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b58903-52c4-47dc-6644-08db8699a764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE/g+HZxRTg6xcRNGrRZKdS+9OgRGquFxSfyyBSuQOYFk42uIEZCTNnAzcfODvvMFrLhIovlcOvtW1RG8b9zqyM5yUn4mxctCVEowodJfk8ryUYoVEAkBD3BWzWEy0R01KkVgqUjTgYh72ny1Fm9PFhm3qy1aCUOcywEEdS7/Q8bUBfSoIjai4NxuwLUTLDwd3GdJoD7THXCjQYPkvIsQRA8Hlct/JrOHcgrbbBRTQx6BoGRLFqQUIqFOF4pIrg2UxC7uamB5ToqMcMew6n5ezDdpIkMs+uGlc9eQm/DcMPjzthoUuqWZW+WPltMA9zhGYS32wC5BovXWmZdvFVD9tgc30YOZe7TLxoPwB+XZp+nTXI6RrDebmADVUbphcrwF06s6bSoQODGr42u2qognqEMOHZhvqKpshWpn1DAbLSbCFSOb9i5gOQwYUaijWiGfhbQtLNy4DR6G6WxzIzHSCyl6GNVSFIb5Jj4AW5kE/GSXFvW9dsfwDVTZ4i+mqd8UiMOdu17qmV9BXSB9PACl42NJC+dtK36HS3n2aqABW9lWZpnXcVZUyykGh2HPFR1de6MswKd1OXDiZZNkj5KnVFSSh+2fbvjI7VilXhQGIcnfcOnIIpvaUR61s5+DVYjuzs+KNNF0kFhsOHMJleAeBcpV1ztYDf3EYnuqlcD9gAlgXD6BHSp8VXYKcgPrpez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(478600001)(6666004)(6486002)(52116002)(186003)(53546011)(6506007)(36756003)(26005)(6512007)(316002)(2906002)(41300700001)(4326008)(66556008)(66946007)(66476007)(6916009)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(86362001)(31696002)(66574015)(2616005)(83380400001)(66899021)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCt2ODNuS0xsdFRHV3A4MTl2aTJtZVd0RzcyMWtqayt5dmwyc0txTnVQSTJj?=
 =?utf-8?B?Q0NhZ3p1SCtYcCtGZjVnR1dqYy83VTRoN2NVQ2ZVTk9CTlBuMndISjFBZ0hH?=
 =?utf-8?B?Nmk5YXRLVEZxTnFJanQ0cmsrTkh6Q0NqSnZJVzJSdC9taDZDekFMQ2lLMk81?=
 =?utf-8?B?SWlYaG84OGNlVUpMR05pRGJVK0RubGJWa1JOTXZMUTZVMG5NdGtnc1dDdHNW?=
 =?utf-8?B?MWtnSGJ3bkcrLzZEcngzU0VkV3p3YkJkZC9vUzNBMlAwUlV5VGtCWjlGRGxY?=
 =?utf-8?B?cnF2SjJ5bnFacGtHRjRHc3NaaVVBSGJQSmtaZ1JjY3pkMk5YUUU1YVo4UGhm?=
 =?utf-8?B?MzdLWXJvTC9SU0svUU9kakpOcE1CZElRV29HcFdCNzdJNklNOGxlV3p5ZlUx?=
 =?utf-8?B?ajZlVFhyYlpKRU1CUlQ3UzJMYWVhak1Wd0pQYkdDWER1MUFIeGd1SVR2elZL?=
 =?utf-8?B?YjBMRUpGUUJ1WDJLeFM3S0xYNkVQUEJLTXpvQmQrT0lUbHd2OXpLSFN6Rmtj?=
 =?utf-8?B?MlhuM0hrTXI5V1BxV2dDVFZHelNXbEsvYlA1cXoraUM5end4TlljWXBqZitM?=
 =?utf-8?B?ZDgyeW9PNUNNU3ROcHYyR2xUbm00dUNhQlkyNUk0MUZjZ1dRQmhNaFhCcENh?=
 =?utf-8?B?THk0UWN2U05rcUpMMTJNc2IrbTdjSjZ4bmlhcG5BQTlNVHUySGxOeE1yNUNE?=
 =?utf-8?B?SEFMZXZkOGtqTk5xbTBQWjhmaU9xMmY0Nmp0WC9TclRFM2VXeGpVZi9ldENX?=
 =?utf-8?B?RTBLb1Urem9YZmc1TmhDV28vVlZEZGlBWER2aDU5Rmthc3NIeDNXakJFanUw?=
 =?utf-8?B?dXBRNUNyUk5Pd0h5QmdWc3ZURm9OUm1ZSE44OFJJd0ZTUkZ4YUIzZ1k2VTdN?=
 =?utf-8?B?VTN3SEhVTEd4d2NzRUhyL09xb2ZJU2t4dGpWalZucFVXL3Y5emNqempmQ0g5?=
 =?utf-8?B?UU5MNC9pNnR0R0tOU2NKUmtac3Z6eTNiMGhFcUcyblZhOGpTSUJYZXE2amlk?=
 =?utf-8?B?N0xJYndBSkd5R0NERjh0SVhZbnFDdDZFRVdOUUVPTFFxT2JobG5uMFQ2Q3N2?=
 =?utf-8?B?bFp5QXlxZlIzVWMwWUNERnJDaUhEa0l5Z2drSTNHeUNFSVVVZXJ5UDNpUWM3?=
 =?utf-8?B?djd4NWRHekJHSW5GOXY3K0JqRGkvcVFNV1RHSFdPVkRZLzdULytiTmZTSXFI?=
 =?utf-8?B?anJUdDNWa1NhZVcvQ0FzK3lLMkhqdGdFNSt4eXBDVFNCeENCWE9BZXV1MXZ1?=
 =?utf-8?B?bW1NZ1BMNUJzRzNqOEFPWHY0aXdNZzIzaHlncXNqWjhrMWI2WUhGUEhCSFpw?=
 =?utf-8?B?TExsdjdobml5QmpGRG1hTHdRNTl0Z1ZDTmc1dFB1S2hRUHN6Qy83SUN6VUNu?=
 =?utf-8?B?RzR0aXBRcXJ4a24weEozcmxwSmNUb3l1Q3kwbVA3S1BhVzVGY25wczUwOENQ?=
 =?utf-8?B?VStEWk1zaWVRdjNqVVFBNE1Cc1c5UzFMeDI2amlJVWJtS2pTZUFsTXk1alZo?=
 =?utf-8?B?WDVVdWhjYzNpcVQyTGlJVWhoRDRDVzcxSE9Uc0xVVVFoYTltOHoyZ3gyNFhX?=
 =?utf-8?B?N0tYWmZ2Nll3bE1sQktPRzkzLzVuZGx2RndpSVh6UWJ3OGpvUk42RnpuZE9F?=
 =?utf-8?B?U1prYVRValU3Y2dZYi9IOWdtZTV4aXJhYmVUSjZGWFlJand0WHl5VzJQTE5J?=
 =?utf-8?B?emhiRWhnSVJCREhHaXlOUnpEZ1hXYXdmRno5dXRueUlCQzVCV29RVjRiT0U5?=
 =?utf-8?B?aUQySjNRWjFFY1hva1lyeGFFMC9kaytSNnRsa3FKUmZWSlYvZ25sZFpCbUl5?=
 =?utf-8?B?STJhRGV0V0N5RzN5L2tYcTZuVFR3dTBCS2xjNjZEVTJyYU0vNzJPa0hwemVS?=
 =?utf-8?B?UUtVWXdGODNNSmFld1NITW5COGNOY1pUQ0FWY1ZtQlBUMDBGNk91bjBMb3ZT?=
 =?utf-8?B?TmFBa1JsN3N0aitGR1VxZndHYjUxTTk1R29mRFRqM1NhL3R3ZjVJVHpSZWtF?=
 =?utf-8?B?cFQvdlBlV3hHY2tWZVhNRkh0bjFDMU81Rm5HWTdCMjNmZVlxZG1UUU40TEVI?=
 =?utf-8?B?NUNGWGs2Kyt0QzI5Y1c1MXVENUtwLzFTc0pSWnpPdW9YYkprSWdwQjduYldC?=
 =?utf-8?Q?PmgFcwWHYXlDGqqL+kV9zb/te?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b58903-52c4-47dc-6644-08db8699a764
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:44:30.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00srzRhDr3sKHfVs+62dkYeI3ltBg28gL9AUx/xeSqB0n7uuKlBgoeWvXEcDGIyt6eqx9xaRj0r55A3mDcI9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/23 18:48, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
>> On 7/3/23 16:09, Benjamin Gaignard wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>> CAUTION: Email originated externally, do not click links or open
>>>>> attachments unless you recognize the sender and know the content is
>>>>> safe.
>>>>>
>>>>>
>>>>> After changing bufs arrays to a dynamic allocated array
>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>>> more reasonable.
>>>>
>>>> It would be hard to iterate the whole array, it would go worse with a
>>>> filter. Such iterate may need to go twice because you mix
>>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>> Here I don't want to change drivers behavior so I keep the same value.
>>> If it happens that they need more buffers, like for dynamic resolution
>>> change
>>> feature for Verisilicon VP9 decoder, case by case patches will be needed.
>>>
>> I just don't like the idea that using a variant length array here.
>>
> "I don't like" is not an argument. We had a number of arguments for
> using a generic helper (originally idr, but later decided to go with
> XArray, because the former is now deprecated) that we pointed out in
> our review comments for previous revisions. It wasn't really about the
> size being variable, but rather avoiding open coding things in vb2 and
> duplicating what's already implemented in generic code.

I just want to say I don't think we need a variable length array to 
store the buffer here.

And the below is the reason that such a case could be avoided in the 
first place.

>
>> And I could explain why you won't need so many buffers for the performance
>> of decoding.
>>
>> VP9 could support 10 reference frames in dpb.
>>
>> Even for those frequent resolution changing test set, it would only happen
>> to two resolutions,
>>
>> 32 would be enough for 20 buffers of two resolution plus golden frames. It
>> also leaves enough slots for re-order latency.
>>
>> If your case had more two resolutions, likes low->medium->high.
>>
>> I would suggest just skip the medium resolutions, just allocate the lower
>> one first for fast playback then the highest for all the possible
>>
>> medium cases. Reallocation happens frequently would only cause memory
>> fragment, nothing benefits your performance.
>>
> We have mechanisms in the kernel to deal with memory fragmentation
> (migration/compaction) and it would still only matters for the
> pathologic cases of hardware that require physically contiguous memory.
> Modern hardware with proper DMA capabilities can either scatter-gather
> or are equipped with an IOMMU, so the allocation always happens in page
> granularity and fragmentation is avoided.

Unfortunately, there are more devices that didn't have a IOMMU attached 
to it, supporting scatter gather is more odd.

It would be more likely that IOMMU would be disabled for the performance 
reason.

>
> Best regards,
> Tomasz
>
>>>>> Remove it from the core definitions but keep it for drivers internal
>>>>> needs.
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>> ---
>>>>>    drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>>    drivers/media/platform/amphion/vdec.c | 1 +
>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>>    drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>>    drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>>    drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>>    include/media/videobuf2-core.h | 1 -
>>>>>    include/media/videobuf2-v4l2.h | 4 ----
>>>>>    8 files changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> index 86e1e926fa45..899783f67580 100644
>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> @@ -31,6 +31,8 @@
>>>>>
>>>>>    #include <trace/events/vb2.h>
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>    static int debug;
>>>>>    module_param(debug, int, 0644);
>>>>>
>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>>> b/drivers/media/platform/amphion/vdec.c
>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>>> @@ -28,6 +28,7 @@
>>>>>
>>>>>    #define VDEC_MIN_BUFFER_CAP            8
>>>>>    #define VDEC_MIN_BUFFER_OUT            8
>>>>> +#define VB2_MAX_FRAME                  32
>>>>>
>>>>>    struct vdec_fs_info {
>>>>>           char name[8];
>>>>> diff --git
>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> @@ -16,6 +16,8 @@
>>>>>    #include "../vdec_drv_if.h"
>>>>>    #include "../vdec_vpu_if.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>    /* reset_frame_context defined in VP9 spec */
>>>>>    #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>>    #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>>> @@ -10,6 +10,8 @@
>>>>>
>>>>>    #include "hfi_helper.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME                          32
>>>>> +
>>>>>    #define VIDC_SESSION_TYPE_VPE                  0
>>>>>    #define VIDC_SESSION_TYPE_ENC                  1
>>>>>    #define VIDC_SESSION_TYPE_DEC                  2
>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> @@ -15,6 +15,8 @@
>>>>>    #include <media/v4l2-vp9.h>
>>>>>    #include <media/videobuf2-core.h>
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>    #define DEC_8190_ALIGN_MASK    0x07U
>>>>>
>>>>>    #define MB_DIM                 16
>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> @@ -10,6 +10,8 @@
>>>>>    #include "ipu3.h"
>>>>>    #include "ipu3-dmamap.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>    /******************** v4l2_subdev_ops ********************/
>>>>>
>>>>>    #define IPU3_RUNNING_MODE_VIDEO                0
>>>>> diff --git a/include/media/videobuf2-core.h
>>>>> b/include/media/videobuf2-core.h
>>>>> index 77921cf894ef..080b783d608d 100644
>>>>> --- a/include/media/videobuf2-core.h
>>>>> +++ b/include/media/videobuf2-core.h
>>>>> @@ -20,7 +20,6 @@
>>>>>    #include <media/media-request.h>
>>>>>    #include <media/frame_vector.h>
>>>>>
>>>>> -#define VB2_MAX_FRAME  (32)
>>>>>    #define VB2_MAX_PLANES (8)
>>>>>
>>>>>    /**
>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>> b/include/media/videobuf2-v4l2.h
>>>>> index 5a845887850b..88a7a565170e 100644
>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>> @@ -15,10 +15,6 @@
>>>>>    #include <linux/videodev2.h>
>>>>>    #include <media/videobuf2-core.h>
>>>>>
>>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>> -#endif
>>>>> -
>>>>>    #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>    #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>    #endif
>>>>> --
>>>>> 2.39.2
>>>>>
>> --
>> Hsia-Jun(Randy) Li
>>
-- 
Hsia-Jun(Randy) Li

