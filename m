Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A47664D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjG1HJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjG1HJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:09:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D135A0;
        Fri, 28 Jul 2023 00:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzVKtcDfeJllnvbbj2i8CSCC2NDiuHxOOvY46EFOes0+cPzE6VfpJx/QFx8MpKK5HkZbHB4xPzPVCz0BEuHvj5LMMyBRXaT/RrVSreke85lOQED/jt3RiOhudwOLguHbStAyg/WmwzZsFsuwUUqraYHnvbdjO8m0ufbaOq4dhiHZb2S2gHDE3oF/nzac2bWXkqZy+eZJGl2QCqN7zQmoWTrjxNt7Wkp0/p+0hQ66EobTaO3Bz1Knz6OZFvPlYPn6vtHnZOEyqafUVDzhOkArhLS7osThpxhbg/horSOE+ldZhAANWwjC6/+paZdHPppbRharW5AssCbuyMxaDczofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlZZwWae9FkrzYTIpFY3SsiOZmZFbQssEE+iNSMibS4=;
 b=lPO4XCZH/GDxZR3yBFZSu35D1yqRds/J8EQoDQOSwMh1x1TspAjloLtBw8VQJwECkiiO3Y4MJE4qTTtP+1DzWhCe7by4ZWi1knQ3Xzatlyn04Qw4FYcMDPjOO9QsCoH2pfHftAaDyuBvGb5BXAqgvvz+OoScsSwWwMFqFWx1AFh9AY1stkftcSGSjwouswxrOVRloQmlpdwFkWfZ9xBAogGwc9CnjmfAkmW0N5pU3apixVMAvmObXpFz2NdO5Twu3l/Y2WVXqH+7EIw/ZM3AOAzqOdkRhFn0a3SK48LCuT0cpQ+EMaXl3h8vBegE5CMxARW4+n1dkYwSrUbZkLtGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZZwWae9FkrzYTIpFY3SsiOZmZFbQssEE+iNSMibS4=;
 b=IsAptjqcB8tnv6NZJKe2PcjHOzR825k4SYbqRWXoNOmLTwKwvnKKJwdvKG4btXXgBnaFk3a2NfwQOovMIA0jkC3lPwXqAIoVY0qCl8FwbPIsCGa5yVBZUY6ste/qlkIgGTx008BxpnsWMEaqYexgIqzGRay+HyvBRZsC3QYgWOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6349.namprd03.prod.outlook.com (2603:10b6:510:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:08:58 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:08:58 +0000
Message-ID: <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
Date:   Fri, 28 Jul 2023 15:08:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com>
 <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
 <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
 <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
 <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: e87302ab-1371-4d10-50b7-08db8f39831d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL6DXXu9uwahaT5nCtd8kZ4OSbuSZvSyWIPE8e6gtnvUPQ3Vwi93QIIJnsDngOp1XrH8UB2p+QsDescbNwV0LXNacNT1ELiajWIFWs3EGL6i60LKEwjS+vHobEA5p0XMx+DDCf/JkRh6comcHmFBQrIY/vi7wsnfymXzhBJa+hBGqoxBgXbMPiElOS5ncvhCkE2NjKHdTdTJpee1cDAZpfJ5e8uEmGrvUvxAf4ztLo6i9AjyxYQu3/8t8rw6PPmEKfVtf5XhUvwWVs9cHwcXbQpItSXvRW35NOcGC2B4tx69SxWoDG7ecySmkwbn56RInjQAJk32+Zora+k8eCqoC1/6f0ey1hKgzX5qrGVEzPaFY6qflt9v3WWB4zh4pPHFyz9N/yCXzSKTm1KCH4zgpIfeMod1Jhc1l5CV+J4oqnkccsneoh5NCFIkTGKIx3x4CJHi9KWw4vS1HQMdkW7ozTBDI5J26t39nDOduOR1f/baPv3a32tv75578FQwIznOvHOkvyd6s/VReWlY7fTpe35mT2lzbDVxqryWF+U2T6bc+/LwjoQrCemKq8KHAJKjEQDWOkJBzLWuQLFFPEmXENGtTSEp6vuYKosKKFYs2bDuGA9rrtNiiOe0qxcft5tn8/4ehRSp+oJ2oL3ej8SpqzoqnAD+URxWRTp/jvJrLU6dpLrra60txlbCxF66A7gH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(376002)(346002)(366004)(451199021)(86362001)(31696002)(26005)(53546011)(6506007)(6916009)(66476007)(4326008)(66946007)(66556008)(186003)(6512007)(83380400001)(2616005)(66574015)(36756003)(31686004)(2906002)(6486002)(66899021)(52116002)(478600001)(6666004)(38350700002)(41300700001)(38100700002)(316002)(7416002)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRnVDZic05Cc0YvL3NMbmpQK1RoQXFvellYcFlwV2VSQ0RrbEQrQzFkQlIx?=
 =?utf-8?B?aFVPSHRMYmx1dFMwQ0t5cm8yNzVWK0p0eFB2WTdDV0JsRFhmS0NZODZONzlY?=
 =?utf-8?B?WkhkaTJmd0o3VjVPekVqSkg3bVFLdTNtcUMybXdNdW1RenczaXRuMElMTzNa?=
 =?utf-8?B?YXZPSGVnWVFCUDdhZjc1N1FLOWM1UEljME5oMzJWcUhxcUhZemlLYWRCODRq?=
 =?utf-8?B?dTMwRGxqeWkwWXhVWFNzLy9TSDMyUWo4Yy9heG9WbitlUUVybCtsTy9PUWwv?=
 =?utf-8?B?RUFjYm1JdTdhVkRuaW53ckQrYlJIVng3c3A5V0xLZVZZSlVvNDUvTEx2Qkhx?=
 =?utf-8?B?OEQvVHJBR1YxRXpud05UNmVCVmh2aVg4YXp5K3RsL0RLYjM0c0FPQWxneUc1?=
 =?utf-8?B?M0hlS2lVRmgrZVVWN0hvQUdRelROYzJodkpkemorMXozeUpnMmNOaStVY3pD?=
 =?utf-8?B?ZTFhcFg4OTEzSFdjckN6Rm5odThXZ0dmVVNZOVVjWEtEeU5RUUp4cjdjcHc2?=
 =?utf-8?B?UzZnZGU5WHlEaHlBcXVxbDRMRTNwSFREZ1NKbldTU0JBZTBqWjIyRVJKUVlB?=
 =?utf-8?B?aXY4WWYyRzdsU1JjUnl5ZHVKaFJMekMvMFRrdGJQSS93TEQvTkxDcUVsNVdJ?=
 =?utf-8?B?Y2FSVHV5dUV1Tjc2SkszaEdNWE56NmlXbXZWUW9nT0VYOVhFU3VwMDdoVnIz?=
 =?utf-8?B?bVg1U0Jxb0JXb3NhOHR4MkVweVBLUVZBbDVlbU1GMzRIUTBLWFBna21jWmV3?=
 =?utf-8?B?eE83WGpEdTk5R1lhekVZMG5OR0VlRllHREhtSld3SDRKT0ZKZ3JGemhNSkJy?=
 =?utf-8?B?ZmM0Z1B5KzFMdGVPMy9kc0gxQk5vdENvSytiY3FjODdzWUdoTkpGVU5SaUVs?=
 =?utf-8?B?Z2xnKzUrTUZQRWxubVNwMnM0cktod0crY05jWXNLTXluMHNqZkxYdEpFT2lT?=
 =?utf-8?B?K1diOGFaVlF4eXlybEJJSEU2ZE9jbGFiOTk4aGg2NkRISlFaUHR6TzZob29n?=
 =?utf-8?B?cis0cUNidFE3RVBUeUJrOU1CQ0dxR0hQOW5BN2gyR3VXamhXc1lpQkg5SUtS?=
 =?utf-8?B?NFZieEphRWFSMFNXSDUwV3o4TFFpY2NPYy9xLzFzdjFZakVJbHptSWdNblp6?=
 =?utf-8?B?emphS0dsdlhLQmN5Wi9rQ2ZEZGZDWXk1T2xkVGpZcUNLcEFRaVRGb3NjVGZp?=
 =?utf-8?B?Yk1YblV6UXVjQmpRNDA1ZXJkZzRiNkhaRm5lNm5HWFlpNVlVSFU5UlgxSXFw?=
 =?utf-8?B?MytsQXVDd2JGZElKSGlPdGdHdENDeVdycUx5VTFpK0NJT0dNRDZpZkZJZUo0?=
 =?utf-8?B?cm54VEE3ZFRzOHpTSnNESVpwSEgwM3NkZFpXbzhxeEtUSDVQOFNFYU1adjda?=
 =?utf-8?B?ZlRlVzBMV01XVmplUmF4Nkx3TVl3YjVib0NheDhrQXg0OFJqbUJ2Yk9NOEc1?=
 =?utf-8?B?YksyUHovQWE4MmR1WlQwK0NPWVRXWmp0emdUUGVtS2ZQQTJCQW9FOTQvSlBR?=
 =?utf-8?B?OEw5R20vSlNOeU1KRFZ6WUduQ0hrUGlVMnNBTmhpWDRkQzVFZzVGRi9QdkVo?=
 =?utf-8?B?ZUxLdlNpOXNwT1RUS3pQZ1NDVG9qb0tWSDIxTXNqT3ppeFB6Y2tlaEZleTlG?=
 =?utf-8?B?dzVHazZzMEE4eVEyelpwTCsrOGgzdE4zaE5aeEVEQUY1STR2T0Vtd2I1MVIy?=
 =?utf-8?B?TXJuRW1yeGlBNStpYmJnK1ZSUWlJdkZmMlcxMXk5aVdDeXA4WWx5bDZ6aWJq?=
 =?utf-8?B?NDVEWWVmNTlId1hHZXAvdTRkLzIzNWo0VmxtdXFLeXFLK3Mxb3dVMURhUjNv?=
 =?utf-8?B?QVgyYmVsa1ZkbzZlcWdNOE5qYXhZdnhYYk4rekVsWCt3bDlyVUNPNEhDdDJH?=
 =?utf-8?B?dy90VTBCMWVlbFUvOFFaSXNXY2d3bjh6ZVZCazA2c3lwbUI3TnZXYnNwcU85?=
 =?utf-8?B?d3ZpV2lyNWZGSUhIZWJ4Y1N1ZlgrS0dyTFZyUGsrY1lyMDExYmZUOFc4TXp3?=
 =?utf-8?B?VmxSRlZXYVJSOGpwSmVlVFoxR2hqbTJzVU5YZWtsUjBVMHRZVTljK1habXV1?=
 =?utf-8?B?S1hrN0Q2WkZvOUJrUGxmZS9RZHpDeVdZYVVEdGltODdRTklhMjFhckViU2tD?=
 =?utf-8?Q?F6GpVAO35EB+js2OluuLXiqvn?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87302ab-1371-4d10-50b7-08db8f39831d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:08:58.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnrmYAU8YgF35+z6xSlkXz8XIbXnDz8P8+unNFT2wawg5OVxxNEZcWgt85PMKnWjvTXKZWgV1p5fdoLcHnWaAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6349
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 12:43, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Jul 28, 2023 at 1:58 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>
>> Le jeudi 27 juillet 2023 à 16:43 +0900, Tomasz Figa a écrit :
>>> On Mon, Jul 17, 2023 at 11:07 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>>
>>>> Le mercredi 12 juillet 2023 à 09:33 +0000, Tomasz Figa a écrit :
>>>>> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
>>>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>>>
>>>>>> Many drivers have to create its own buf_struct for a
>>>>>> vb2_queue to track such a state. Also driver has to
>>>>>> iterate over rdy_queue every times to find out a buffer
>>>>>> which is not sent to hardware(or firmware), this new
>>>>>> list just offers the driver a place to store the buffer
>>>>>> that hardware(firmware) has acknowledged.
>>>>>>
>>>>>> One important advance about this list, it doesn't like
>>>>>> rdy_queue which both bottom half of the user calling
>>>>>> could operate it, while the v4l2 worker would as well.
>>>>>> The v4l2 core could only operate this queue when its
>>>>>> v4l2_context is not running, the driver would only
>>>>>> access this new hw_queue in its own worker.
>>>>>
>>>>> Could you describe in what case such a list would be useful for a
>>>>> mem2mem driver?
>>>>
>>>> Today all driver must track buffers that are "owned by the hardware". This is a
>>>> concept dictated by the m2m framework and enforced through the ACTIVE flag. All
>>>> buffers from this list must be mark as done/error/queued after streamoff of the
>>>> respective queue in order to acknowledge that they are no longer in use by the
>>>> HW. Not doing so will warn:
>>>>
>>>>    videobuf2_common: driver bug: stop_streaming operation is leaving buf ...
>>>>
>>>> Though, there is no queue to easily iterate them. All driver endup having their
>>>> own queue, or just leaving the buffers in the rdy_queue (which isn't better).
>>>>
>>>
>>> Thanks for the explanation. I see how it could be useful now.
>>>
>>> Although I guess this is a problem specifically for hardware (or
>>> firmware) which can internally queue more than 1 buffer, right?
>>> Otherwise the current buffer could just stay at the top of the
>>> rdy_queue until it's removed by the driver's completion handler,
>>> timeout/error handler or context destruction.
>>
>> Correct, its only an issue when you need to process multiple src buffers before
>> producing a dst buffer. If affects stateful decoder, stateful encoders and
>> deinterlacer as far as I'm aware.
> 
> Is it actually necessary to keep those buffers in a list in that case, though?
> I can see that a deinterlacer would indeed need 2 input buffers to
> perform the deinterlacing operation, but those would be just known to
> the driver, since it's running the task currently.
> For a stateful decoder, wouldn't it just consume the bitstream buffer
> (producing something partially decoded to its own internal buffers)
> and return it shortly?
Display re-order. Firmware could do such batch work, taking a few 
bitstream buffer, then output a list graphics buffer in the display 
order also discard the usage of the non-display buffer when it is 
removed from dpb.

Even in one input and one output mode, firmware need to do redo, let the 
driver know when a graphics buffer could be display, so firmware would 
usually hold the graphics buffer(frame) until its display time.

Besides, I hate the driver occupied a large of memory without user's 
order. I would like to drop those internal buffers.
> The most realistic scenario would be for stateful encoders which could
> keep some input buffers as reference frames for further encoding, but
> then would this patch actually work for them? It would make
> __v4l2_m2m_try_queue never add the context to the job_queue if there
> are some buffers in that hw_queue list.
why?
> 
> Maybe what I need here are actual patches modifying some existing
> drivers. Randy, would you be able to include that in the next version?
May not. The Synaptics VideoSmart is a secure video platform(DRM), I 
could release a snapshot of the driver when I got the permission, that 
would be after the official release of the SDK.
But you may not be able to compile it because we have our own TEE 
interface(not optee), also running it because the trusted app would be 
signed with a per-device key.
> Thanks.
> 
> Best regards,
> Tomasz
> 
>>
>> Nicolas
>>
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>> Nicolas
>>>>>
>>>>>>
>>>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>>>> ---
>>>>>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>>>>>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>>>>>   2 files changed, 26 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> index c771aba42015..b4151147d5bd 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>>>>              goto job_unlock;
>>>>>>      }
>>>>>>
>>>>>> -   src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>>>> -   dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>>>> -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>>>> -           dprintk("No input buffers available\n");
>>>>>> -           goto job_unlock;
>>>>>> +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>>>>>> +           src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>>>> +
>>>>>> +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>>>> +                   dprintk("No input buffers available\n");
>>>>>> +                   goto job_unlock;
>>>>>> +           }
>>>>>>      }
>>>>>> -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>>>> -           dprintk("No output buffers available\n");
>>>>>> -           goto job_unlock;
>>>>>> +
>>>>>> +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>>>>>> +           dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>>>> +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>>>> +                   dprintk("No output buffers available\n");
>>>>>> +                   goto job_unlock;
>>>>>> +           }
>>>>>>      }
>>>>>
>>>>> src and dst would be referenced unitialized below if neither of the
>>>>> above ifs hits...
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>>
>>>>>>
>>>>>>      m2m_ctx->new_frame = true;
>>>>>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>>>>>      INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>>>>>      q_ctx->num_rdy = 0;
>>>>>>      spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>>>>>> +   INIT_LIST_HEAD(&q_ctx->hw_queue);
>>>>>>
>>>>>>      if (m2m_dev->curr_ctx == m2m_ctx) {
>>>>>>              m2m_dev->curr_ctx = NULL;
>>>>>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>>>>>
>>>>>>      INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>>>>>      INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>>>>>> +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>>>>>> +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>>>>>      spin_lock_init(&out_q_ctx->rdy_spinlock);
>>>>>>      spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>>>>>
>>>>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>>>>>> index d6c8eb2b5201..2342656e582d 100644
>>>>>> --- a/include/media/v4l2-mem2mem.h
>>>>>> +++ b/include/media/v4l2-mem2mem.h
>>>>>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>>>>>    * processed
>>>>>>    *
>>>>>>    * @q:             pointer to struct &vb2_queue
>>>>>> - * @rdy_queue:     List of V4L2 mem-to-mem queues
>>>>>> + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>>>>>> + *         called in struct vb2_ops->buf_queue(), the buffer enqueued
>>>>>> + *         by user would be added to this list.
>>>>>>    * @rdy_spinlock: spin lock to protect the struct usage
>>>>>>    * @num_rdy:       number of buffers ready to be processed
>>>>>> + * @hw_queue:      A list for tracking the buffer is occupied by the hardware
>>>>>> + *                 (or device's firmware). A buffer could only be in either
>>>>>> + *                 this list or @rdy_queue.
>>>>>> + *                 Driver may choose not to use this list while uses its own
>>>>>> + *                 private data to do this work.
>>>>>>    * @buffered:      is the queue buffered?
>>>>>>    *
>>>>>>    * Queue for buffers ready to be processed as soon as this
>>>>>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>>>>>      struct list_head        rdy_queue;
>>>>>>      spinlock_t              rdy_spinlock;
>>>>>>      u8                      num_rdy;
>>>>>> +   struct list_head        hw_queue;
>>>>>>      bool                    buffered;
>>>>>>   };
>>>>>>
>>>>>> --
>>>>>> 2.17.1
>>>>>>
>>>>
>>

-- 
Hsia-Jun(Randy) Li
