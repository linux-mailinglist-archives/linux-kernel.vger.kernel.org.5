Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B241766576
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjG1HiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjG1Hh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:37:56 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC42D51;
        Fri, 28 Jul 2023 00:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM3k0NZ4NxB03FnoE0GKCHGFJtXHwmOZ/7sfg5QnUNIrgTkqXcpHCdShsRqG4prmtbX5srhI7K7ZRScOdn6YDRJZ61rZKX3glQJpFZOCddTr7eqITgB0++/lpi+9oEjlyT6MdcDwWmccKOCAUcnrgeQYWF1NxmTizi7xp2cZHaPOsda0yymYd7p8WYkE0FMQzlZm5NeTcjZho73o741WR2Epwm/gYI5uVd+RCVgr2CwnNPDpv2yVHFe69kYqGdsXcLHpNWOYRnWTMoSPJZnzJpVCGHwHYluxviBqswSRTvHdiJ3tLAJYoX/yy5Gc2ZVRs+sXaYjRFKcv142W76smMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3AklJUVaz/y8r8N7DtTkQ9hAmFbgEwjE+jPL2iYRZk=;
 b=hJ+lqcCmclylumjfwZ9ja/sI+7EYcAuCVa0UIlYQtfk05Bfbj+M1xjyKRzJTRv79p38yW3SuRjcYgx0hkSr7c3wDVqS7NAbDScw69OIOmRbUan2bAU9DmYs1ne/iaywdSgk00GvYP9U7mUW4UXmlHOu2XWLCc1NlN+8iW/S2MCF2wBXBKtXGHoBiAbc/gyjGfvmFYKVLU4KD0dNe/iocKsE+BpV1P2AR7SXG+cu6/8ksHDRacfYcInkE71BnYkB5VqQPVt5yjLGSdtfW6YCxjgsxSgHq8xeODUQVGdfiQZG6L69aaygW/afm0m+PzgKSnExGgmY5UpGgewWbD7cRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3AklJUVaz/y8r8N7DtTkQ9hAmFbgEwjE+jPL2iYRZk=;
 b=l8Ym2wZPQL/gU7tRueSEBKPoS/DB9Hx5xyti9Col7G4/nCw1Vjr+/FrbJQ6Md61m9HjCfGryFXKPjJ992O5PXf8YJ0hxb6UA4sQwZ+Twd8N7XQYMcnQsPDb8ZtBuoeHiCSQtxTKVammh+lP3+IU5yceJrFSl08gBjSw8EoTynpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ0PR03MB5822.namprd03.prod.outlook.com (2603:10b6:a03:2ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:37:51 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:37:50 +0000
Message-ID: <10ad26e6-b2d0-d0e6-40c8-2cc70613188b@synaptics.com>
Date:   Fri, 28 Jul 2023 15:37:42 +0800
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
 <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
 <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:510:174::10) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ0PR03MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: de7a26b6-200c-4bbd-ae84-08db8f3d8be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cW7LIejGHsOUzXZD7TKK2EK+3ixf2atX+gkKUQZxTq9LfGy1/aiB8wxsdFjsD5JC3EZd7eItPOahhKkaUDcdQIF934cTX/qpcU+t8E1YxJDHjWuJEU8ryDp4mw/RsrSi9GDUB+nF+2dmIC/fQ5bCpVhHAt4aA01t3v+++g8mwDkJM0bkjihTnbG7sRLcTo/wC/FBvW/DxytvVV1A23LDNptAPD0PiD56S/1EaAs+AHwOOe+/w+8EmT2uOFevJDNyAVr5z9JGh5vJgKyL8MVR1oAX2H/ezjqzmdhG9REHWdcT5Tw4OtyQeN51MFbhUH8chgykuuUd7aW9tvdzQpPWD++0Ofr0JP325+4GvAWSQLiXo6kvuMZF9NMb26gVLmLQP3lpNIUN/PKnUcq7FH0rksvtCGzN4s5Le5uQTy9vXUnwde5PVgBpr36LhbooA/LwsCu4f1h/N4/muqNc5q/2sh07sQE329yaj8ijInoEUdQvG3LVDNNCu0WoQZORVYJ/MxuG0FDHUehe/ToNpJI6ZV912vdt9MmTpv1XrJpJB4eKqHVareIvgycsoFqTfzwbV9LivPU4hcEb1TF4SoXCYF0Y4EoiiQbSEzZAnhZwFHlvyxJRW/F5W7OcpYS7yyV5MJ7Ei5aCiOA+I2zcF7RRN7/UYRS7RpbIY3C5IXAiijIuqoR8KvOHtSq+ELAIwrHJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(316002)(66899021)(2906002)(8936002)(8676002)(7416002)(5660300002)(30864003)(41300700001)(36756003)(31696002)(86362001)(6486002)(6666004)(52116002)(478600001)(66574015)(26005)(6506007)(53546011)(186003)(31686004)(2616005)(66946007)(66556008)(83380400001)(6512007)(38350700002)(38100700002)(66476007)(6916009)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGU0SjVleTByQnR3M0plZE05bU5WZXFOSlp2Y2lHcFFGSjNqeUljb01aOFlV?=
 =?utf-8?B?WGhtbDRBbmxSVmdUWDNUVU1QVm9qd0tKOVRQM3VvQVRZTUVkNlJCZ00vU01P?=
 =?utf-8?B?SDRWTm9hclRZM1cyUEJrUnFlVy9mamw1R3NoQzVkZk9GTE5ia0poOHVXQk1x?=
 =?utf-8?B?d1pUZXpMUktuV1RGb1FPckc0NkQ2N09rYWJxQkJuVDVpdDYwWnJmVXNmYkJm?=
 =?utf-8?B?b3VvRmJZb3R1S25QRllWR3FEN0VpcjdPZXplYnBodVRqOUNJR1pqMGwvY1Zs?=
 =?utf-8?B?WmRZRnpKQ3h6eVBsUVRTV0tHS2dhZE0xbnVkbUlQU0dGUzQ0MjliOTJzeUQ0?=
 =?utf-8?B?UjE5bXBDSS9ZcDE3T2ZBYjF1ejF2MGVqUTI2dUJlZGdhdXdpa1kxeUNkczVT?=
 =?utf-8?B?SDZuU1o4Y3ZrUFh5dWJpZGdwWUdjUGRmbDM2c1dkMEluc0ZmS0FPN2VBTzd0?=
 =?utf-8?B?N3lsWTVKUUFVSStyaEVYd1hld0Z6d0wyMDZKUkFDdnZZU0lDTDZSd09SUS9M?=
 =?utf-8?B?aU0wUGFFVkRHRmNRajRRTU5jWDlkblJOdGNuZ0IzZlczalJnRzRRNmFoNDA2?=
 =?utf-8?B?dURwU1J5Uy9CV3ZROHRSNUVwbUo5RmlLM3RjSWV6SE9QcjdwZlhwWEYwTVFS?=
 =?utf-8?B?MjNWVkRvVWdGVWU0bEpDZ0pMaEZGZDdPMS9hR3RZeHNTUEtoUlhJeEplazNC?=
 =?utf-8?B?QjJvWlltcmVVMWlhbGxZd01WR1dyVlBUL2ZJL0FZUWhPYkhnZWRZaENpR0pR?=
 =?utf-8?B?N29lSXVmUGF3QWg2NUx1V2VrWnNoZXNrd2xnbVBIeUVEWXVTWjk5QWhGM05Q?=
 =?utf-8?B?TDZvTnhQQWNUaTNqdXBEUm4wckErK1J2cDBITmtyd2J6WHRsdDNFTmJrdkw5?=
 =?utf-8?B?WTB0dHFqQ3hRMmRONUlkb2Jvd3g1QjB0dnQwS1ZvOTBXS1JOSFl4UzEvWUhR?=
 =?utf-8?B?M2ZhWTFYVVJWQ1l2Wm1BcTU5N2JmRytVNTkyUzd5Y3BKUlI2ZWZ3TVVPUWJY?=
 =?utf-8?B?QnJLam00eFpJdjNjdExyUVVJazVJak0xWDBpR09uYjdIdmxYaGZoNXduaysx?=
 =?utf-8?B?aXRRbTBXZkNMNU9tNk4rTEllOXRhZWcvN1Frb1BISUpPKzJvckx1VzM5VU1i?=
 =?utf-8?B?TThsY3ZXSCtMVS84ZFk0UUQvMmVrOGZJN3J3L0JHMkE0Yll0bzB2bjNvR0wz?=
 =?utf-8?B?ZHN4YWFXSzV5eTlveUdMNllEQnNUU2kvTEVsMml2YVB0UTQ4Um1teU05aDZn?=
 =?utf-8?B?Zi82MlFHeHhlelM3dFVxY3B0NFJVMDYvQWdDRmdrQU1SQTNFZUE1bEhldUZ3?=
 =?utf-8?B?ZDkrYkJRYW9OY1lpMTg2elNJYnNlTHJoeTlBOTNDYmZrbTYyL0xjNGVuSUJU?=
 =?utf-8?B?YTlZanV6MEJTVWk3SU5XQUF3SE5PWTl3UmNUc1FzQjcxV2JvSlp0UU5oVysv?=
 =?utf-8?B?N1dBWDVQVXgwUThsZHhMMElwN3ZXT1lmdWdIdWVRcnFiN3FCZFlMeENLd2hu?=
 =?utf-8?B?Rk5OaTkvNHhGdWVNYmtDWXhPRVI4bzlRM3B2QnZKdDdwNTlBSXF4RzhWcWk4?=
 =?utf-8?B?MENYVFYvNnQ0QUwvak5kdW9kd0hRVko1TUcrZk43amh6ZUgzVExGczNCRWV3?=
 =?utf-8?B?MUExMm02OHkrbHhZOUc3MVRHQ2FmR09tMmZSWGdOZEVJMHh4b294SEZHVjEv?=
 =?utf-8?B?U2d3azFVSmVzUzAvSHl1cENlZ2dEYXkxTUlzaDJTa0lkT3RrMklGZVZRSEkv?=
 =?utf-8?B?TjZjZHFMemtudnBXNGluSko3bWpIZEphRkpSSFVvNUpUVzV1aHJRd1VlMjlT?=
 =?utf-8?B?TytBaUdDQ3ZVaVZhSkRVajdCbFJhTDg3bWZRMCt0aHd3ZHd5UDAxSGx3K2VU?=
 =?utf-8?B?UGYzVE5SQXgva0VxUFVOSmJjazBBSzc3Sm9xWEJ4SXVjUC9xN0RUQ3hEU0Fz?=
 =?utf-8?B?aERuZU1Ra1pZeVFqTXorOXVTTmFSU3Q4RmQ4V1hTYlRoY3dUWUI3M3RrNzh6?=
 =?utf-8?B?LzdKbTBTeSs4TEJTY3R3Y1JHdExLMmdxSkxXTktPQ0NVWjZhTUthdmQ0Zkw5?=
 =?utf-8?B?TTM3bnliK1MzSlI1dHBiTmVsRkhNck5PWW84aDdBVEJPTStRc2JFRHNoSVJF?=
 =?utf-8?Q?xaEjSwiyrV2L0Elso46jbBkjL?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7a26b6-200c-4bbd-ae84-08db8f3d8be1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:37:50.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0fbGy2tBZz67bbB0GnNXmDKaIplPGrGzg+Cq9P7Eggs6nSbYmm87BB26+0mSngoQr7nP1CTum1cbdV2xKb39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5822
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 15:26, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Jul 28, 2023 at 4:09 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>>
>> On 7/28/23 12:43, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Fri, Jul 28, 2023 at 1:58 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>>
>>>> Le jeudi 27 juillet 2023 à 16:43 +0900, Tomasz Figa a écrit :
>>>>> On Mon, Jul 17, 2023 at 11:07 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>>>>
>>>>>> Le mercredi 12 juillet 2023 à 09:33 +0000, Tomasz Figa a écrit :
>>>>>>> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
>>>>>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>>>>>
>>>>>>>> Many drivers have to create its own buf_struct for a
>>>>>>>> vb2_queue to track such a state. Also driver has to
>>>>>>>> iterate over rdy_queue every times to find out a buffer
>>>>>>>> which is not sent to hardware(or firmware), this new
>>>>>>>> list just offers the driver a place to store the buffer
>>>>>>>> that hardware(firmware) has acknowledged.
>>>>>>>>
>>>>>>>> One important advance about this list, it doesn't like
>>>>>>>> rdy_queue which both bottom half of the user calling
>>>>>>>> could operate it, while the v4l2 worker would as well.
>>>>>>>> The v4l2 core could only operate this queue when its
>>>>>>>> v4l2_context is not running, the driver would only
>>>>>>>> access this new hw_queue in its own worker.
>>>>>>>
>>>>>>> Could you describe in what case such a list would be useful for a
>>>>>>> mem2mem driver?
>>>>>>
>>>>>> Today all driver must track buffers that are "owned by the hardware". This is a
>>>>>> concept dictated by the m2m framework and enforced through the ACTIVE flag. All
>>>>>> buffers from this list must be mark as done/error/queued after streamoff of the
>>>>>> respective queue in order to acknowledge that they are no longer in use by the
>>>>>> HW. Not doing so will warn:
>>>>>>
>>>>>>     videobuf2_common: driver bug: stop_streaming operation is leaving buf ...
>>>>>>
>>>>>> Though, there is no queue to easily iterate them. All driver endup having their
>>>>>> own queue, or just leaving the buffers in the rdy_queue (which isn't better).
>>>>>>
>>>>>
>>>>> Thanks for the explanation. I see how it could be useful now.
>>>>>
>>>>> Although I guess this is a problem specifically for hardware (or
>>>>> firmware) which can internally queue more than 1 buffer, right?
>>>>> Otherwise the current buffer could just stay at the top of the
>>>>> rdy_queue until it's removed by the driver's completion handler,
>>>>> timeout/error handler or context destruction.
>>>>
>>>> Correct, its only an issue when you need to process multiple src buffers before
>>>> producing a dst buffer. If affects stateful decoder, stateful encoders and
>>>> deinterlacer as far as I'm aware.
>>>
>>> Is it actually necessary to keep those buffers in a list in that case, though?
>>> I can see that a deinterlacer would indeed need 2 input buffers to
>>> perform the deinterlacing operation, but those would be just known to
>>> the driver, since it's running the task currently.
>>> For a stateful decoder, wouldn't it just consume the bitstream buffer
>>> (producing something partially decoded to its own internal buffers)
>>> and return it shortly?
>> Display re-order. Firmware could do such batch work, taking a few
>> bitstream buffer, then output a list graphics buffer in the display
>> order also discard the usage of the non-display buffer when it is
>> removed from dpb.
>>
>> Even in one input and one output mode, firmware need to do redo, let the
>> driver know when a graphics buffer could be display, so firmware would
>> usually hold the graphics buffer(frame) until its display time.
>>
> 
> Okay, so that hold would be for frame buffers, not bitstream buffers, right?
For the 1:1 model, decoder won't hold the input(OUTPUT queue) buffer 
usually.
While for the VP9, we have a super frame and temporal unit packing for 
AV1 which break the current API requirement for an AU in a buffer. The 
hardware would trigger multiple work for that(that means multiple irqs 
ack for a usual devices).
For the encoder, it is a different story.
> But yeah, I see that then it could hold onto those buffers until it's
> their turn to display and it could be a bigger number of frames,
> depending on the complexity of the codec.
> 
>> Besides, I hate the driver occupied a large of memory without user's
>> order. I would like to drop those internal buffers.
> 
> I think this is one reason to migrate to the stateless decoder design.
> 
I didn't know such plan here. I don't think the current stateless API 
could export the reconstruction buffers for encoder or post-processing 
buffer for decoder to us.
>>> The most realistic scenario would be for stateful encoders which could
>>> keep some input buffers as reference frames for further encoding, but
>>> then would this patch actually work for them? It would make
>>> __v4l2_m2m_try_queue never add the context to the job_queue if there
>>> are some buffers in that hw_queue list.
>> why?
>>>
>>> Maybe what I need here are actual patches modifying some existing
>>> drivers. Randy, would you be able to include that in the next version?
>> May not. The Synaptics VideoSmart is a secure video platform(DRM), I
>> could release a snapshot of the driver when I got the permission, that
>> would be after the official release of the SDK.
>> But you may not be able to compile it because we have our own TEE
>> interface(not optee), also running it because the trusted app would be
>> signed with a per-device key.
> 
> Could you modify another, already existing driver then?
> 
>>> Thanks.
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>>
>>>> Nicolas
>>>>
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>>
>>>>>> Nicolas
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>>>>>> ---
>>>>>>>>    drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>>>>>>>    include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>>>>>>>    2 files changed, 26 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>>> index c771aba42015..b4151147d5bd 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>>>>>>               goto job_unlock;
>>>>>>>>       }
>>>>>>>>
>>>>>>>> -   src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>>>>>> -   dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>>>>>> -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>>>>>> -           dprintk("No input buffers available\n");
>>>>>>>> -           goto job_unlock;
>>>>>>>> +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>>>>>>>> +           src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>>>>>> +
>>>>>>>> +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>>>>>> +                   dprintk("No input buffers available\n");
>>>>>>>> +                   goto job_unlock;
>>>>>>>> +           }
>>>>>>>>       }
>>>>>>>> -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>>>>>> -           dprintk("No output buffers available\n");
>>>>>>>> -           goto job_unlock;
>>>>>>>> +
>>>>>>>> +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>>>>>>>> +           dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>>>>>> +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>>>>>> +                   dprintk("No output buffers available\n");
>>>>>>>> +                   goto job_unlock;
>>>>>>>> +           }
>>>>>>>>       }
>>>>>>>
>>>>>>> src and dst would be referenced unitialized below if neither of the
>>>>>>> above ifs hits...
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Tomasz
>>>>>>>
>>>>>>>>
>>>>>>>>       m2m_ctx->new_frame = true;
>>>>>>>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>>>>>>>       INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>>>>>>>       q_ctx->num_rdy = 0;
>>>>>>>>       spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>>>>>>>> +   INIT_LIST_HEAD(&q_ctx->hw_queue);
>>>>>>>>
>>>>>>>>       if (m2m_dev->curr_ctx == m2m_ctx) {
>>>>>>>>               m2m_dev->curr_ctx = NULL;
>>>>>>>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>>>>>>>
>>>>>>>>       INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>>>>>>>       INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>>>>>>>> +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>>>>>>>> +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>>>>>>>       spin_lock_init(&out_q_ctx->rdy_spinlock);
>>>>>>>>       spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>>>>>>>
>>>>>>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>>>>>>>> index d6c8eb2b5201..2342656e582d 100644
>>>>>>>> --- a/include/media/v4l2-mem2mem.h
>>>>>>>> +++ b/include/media/v4l2-mem2mem.h
>>>>>>>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>>>>>>>     * processed
>>>>>>>>     *
>>>>>>>>     * @q:             pointer to struct &vb2_queue
>>>>>>>> - * @rdy_queue:     List of V4L2 mem-to-mem queues
>>>>>>>> + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>>>>>>>> + *         called in struct vb2_ops->buf_queue(), the buffer enqueued
>>>>>>>> + *         by user would be added to this list.
>>>>>>>>     * @rdy_spinlock: spin lock to protect the struct usage
>>>>>>>>     * @num_rdy:       number of buffers ready to be processed
>>>>>>>> + * @hw_queue:      A list for tracking the buffer is occupied by the hardware
>>>>>>>> + *                 (or device's firmware). A buffer could only be in either
>>>>>>>> + *                 this list or @rdy_queue.
>>>>>>>> + *                 Driver may choose not to use this list while uses its own
>>>>>>>> + *                 private data to do this work.
>>>>>>>>     * @buffered:      is the queue buffered?
>>>>>>>>     *
>>>>>>>>     * Queue for buffers ready to be processed as soon as this
>>>>>>>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>>>>>>>       struct list_head        rdy_queue;
>>>>>>>>       spinlock_t              rdy_spinlock;
>>>>>>>>       u8                      num_rdy;
>>>>>>>> +   struct list_head        hw_queue;
>>>>>>>>       bool                    buffered;
>>>>>>>>    };
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.17.1
>>>>>>>>
>>>>>>
>>>>
>>
>> --
>> Hsia-Jun(Randy) Li

-- 
Hsia-Jun(Randy) Li
