Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5CC784F15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHWDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjHWDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:05:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862DE50;
        Tue, 22 Aug 2023 20:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSdDFM0zOypr8RqKixV9KQeawT+hsWXY6jQE+iKgQLztTOPp5lbvfkILDe65C0jCZ+6uo2dqd1aqH7QcQkiuBGA4V7LPjgeU+mjIrGbpemUUsa99u8aCwOQNLmNqJVCiGWB4kTab/OhSrVQAeYCByEoXWnJ3VM7qIDFyZCEL2slzWTmYB1CXQuw9+Wv+AstIV33DO8ft7lIUNqz01AFnM2Nsei94UMOLv5ZkzBsn0/CTqYOisdIuB7xJOpl+daEOJeU4uy2iPTp9wVP5Yv6P1eNXargGdoHvyKLHhUUoKlejcdBUOE0t+IvAAWQ5DImcsnbbyBZzVTkFhR3o7HMCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkWQDumyU6p/KzKqoBzVpCSn6tvkdWNmRPLG2jXixgc=;
 b=SSBGSqRj1goqEgWH2HY84zPV3aWeWEyvyX67iMp2v25mhlgpA8mdbxvDtgQbcNC5k32tmoTN6lIai2sh20SJb+jSxviOmZEMcNEVsQBgIkv2EHa7s6pVUPbfTViFHlApNwmn6GXKzEAvVKZOS55GRrMivvuP+kA6jz/9JFDL0uu4xk10ciRY1WfgJwjZ1na0rb9Rhoy0nEh6cQCigYChkjhNOHhWZBnmH8lRtlAVvmMqx6Nx3AxpVE+bIVEVqYqaowpRLq1noWuYLqqO8llLUYR/A5jdUBmbBtPEVwTKmqax16BlEpXD6BSNiFnAY3gLTO1GCMwqKDvW5mvzdeUlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkWQDumyU6p/KzKqoBzVpCSn6tvkdWNmRPLG2jXixgc=;
 b=ATVdaOYWJaocCWKCXOg+oK4aHWzGXwpQ1GctAoGYPutJbgiP4NwvDMhBlqNKitfEBX9OgvZjQAHKBBBG6JA86a46cVaFSS0+ijxaEenz01A1QRDkgycLzc3HLjOsbBz2mfy8fDQ7QUiDQgVs8Xk0icfKPLUKaUz08j8R4QyPeTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SA0PR03MB5530.namprd03.prod.outlook.com (2603:10b6:806:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 03:05:24 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 03:05:24 +0000
Message-ID: <52e9b710-5011-656b-aebf-8d57e6496ddd@synaptics.com>
Date:   Wed, 23 Aug 2023 11:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
 <ZNaVQ-zxIuCpGGha@aptenodytes>
 <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
 <39270c5e-24ab-8ff6-d925-7718b1fef3c4@synaptics.com>
 <a0fa6559c3933a5a4c8b7502282adae3429e0b57.camel@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <a0fa6559c3933a5a4c8b7502282adae3429e0b57.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SA0PR03MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 53606918-f34b-4dab-ea5f-08dba385cb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB8hIt/EDrtUvVnWozWntolL12eZ6yNNUoio24q/HrTjErLzP6qKKckFfvVQxm8cW2mI72kdX4KLiup+7ChImzKTti2kbOyCfV87BUDWYehKUkSwWN+8QvR44KYojey0eAV0iTDxY9peNZnMtvI9Ur5+kcC6mkQMtZ/6nLhFb9QK+Vvpu373r3ogu0IajkWT1JqfSTQ9dJ8DZETdw2Ro1NHcE6wktiA31x/yu3DiNeQG0aQTQw1d+51aJTzncUpq9HQAL0ucklja3FRB8I3IL7WuHmVGQi8g/FBNrKsvUyquYXUCLXkb3joXRTv1nY+NIT5UDMR8dfkGQvNXjhBCd16dnE/gLRnFqtee51ZEhcT6C3OwiS1v9p2kLZc6VkOdsaUuTtiQ1ZFKdFdRMwLduBEEgzZAxe4Vj5h5kE9HSQWGyRXR1VigEqEVpvTrgs33mVNqTmUdtRLE5p2up3W1mvLsO5+fhqUGOBVmbGL3ovYAjkMQCo3cYqlO/TJbKcVqp5pN08fp7d2ng5JtDww0zfTPTHz++aQukV9J2vZG45h5wutcdLA1JVEQuEmx0VQIlRHj704oX8dXK0OK8KHfsDhrKiCPl3U2HnAYxFH6XLwVR1Q90yrTtXU8T9JRtNyiiikL0fMsytF8TybyHChQoHityMtUeRFEpQ8pO02cRMTITH1pvAesqbQyAnZIBc4q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(66476007)(54906003)(66556008)(6512007)(316002)(110136005)(8676002)(4326008)(2616005)(8936002)(41300700001)(36756003)(478600001)(6666004)(66946007)(38100700002)(6486002)(53546011)(52116002)(38350700002)(6506007)(7416002)(2906002)(83380400001)(31686004)(86362001)(31696002)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdpUlJoTHVPeWhxR2pCb05uRHRSL0prV1k2WWcxdWpXcVdzcTVjTDgwZ0Zi?=
 =?utf-8?B?SjcxQjlORTk4UzRjeHR3NFZYUHV0a2hFcUhWWlo1bkQ0QnBsbjJ3RzZvM1Br?=
 =?utf-8?B?QUQzTExzRlptbjhzdkdSY041OS90Z0hENHRScWNlamhoMzlmV3B1Y01ZRkhn?=
 =?utf-8?B?R0RUNEQrYU1lYlkyS1hpSUp5dnFCeCtWd1VKUm9OMUlhcnFmVUhRSkE5S2ky?=
 =?utf-8?B?VVhCajVDTi9FUFcycWhQd3M3NE1RYXNCMXg0aERObHV5MkEyVkJ2R0syTEZw?=
 =?utf-8?B?WUN3SWxqbkNDS245RzdBbnVZaHdTM25BRHlUaEU3ejBlODhCU2cwa01jaWtR?=
 =?utf-8?B?Q3ZDWEpLTHo5VFFONjJKUXBpbTNGVFRFNkQvTnQ5TGl0VWtIc1ptVVI5TXBx?=
 =?utf-8?B?Y3FYY2Q5Z2xXOVRhdnhMT2xCUWZ5SkhjTEx1UkkrNkJadHpvZGh4cC9nTnF2?=
 =?utf-8?B?aEhWOUVDaDhyV3NQRllhbXBEK1N4YzljUHVzQnV6N1cva2tMajdrR0Z6Yld1?=
 =?utf-8?B?THJ2TmdTdEVIdWFENEUrdU9yb3pDVElUbFJOQ1lvT3Z0UHV5NnZSV2p4eVFO?=
 =?utf-8?B?Rnk0Mk1tWTVXMnFFZUtSRTU5N3RVTXdDbWdDZ0t1cWJROWRpNzBPNWhLM0k1?=
 =?utf-8?B?UzBZYzFWTGpzc0RFTE53R0hNL25KMkdPREdtcnUvKzI4aERKemdwT2JXS0Fr?=
 =?utf-8?B?RGlQZExMcWRtVlkrUll6Q2pBOWxzbjdvbE8xakV3U2tnRlVQMUpFVDl4enN2?=
 =?utf-8?B?eU92TnNZZ0ZzRXZiaTZvbG8xR0R4MFZsY3J2WllTRlROYnQwZDRyK0dKcTIv?=
 =?utf-8?B?cE9kWjIyaHRWeUU4akhLaHE1WUgzV3NsekpNSEluT0ZXcFIyREs3VVJSQmpR?=
 =?utf-8?B?blhqZnl6eFpROFNSOFI4RlREbEJCaUJYZDRhekxJL3ZXRW1UL3V6UkpkRmdo?=
 =?utf-8?B?b2JkNDhadGpNdmJTZE84UUZZcE1kbFY4S01jSEp3emNyM1RXekh0Zkx1RXZP?=
 =?utf-8?B?TVhKYWtFcGJjVjNVV01mN2t0UjNIdFVGYXorMUl0eVBMWUlBRFVDL2QwdVpv?=
 =?utf-8?B?M2tLMzJ1QWEzNmZuUERUYW1ROW9sL0RBSVFaRWxNSFNtM2d2NzFmMGVOVCsx?=
 =?utf-8?B?ZUgrYVlmT1NubkdoOHQ1NjVtYlFjcDZncElCaGxrNnZkQXJpYlBMbHNJcEJE?=
 =?utf-8?B?bG5FODBKRWowR0laaWp3SmZ4OEU2ZGxLTW41eHV0WGplRjBWNU80TGtudUVN?=
 =?utf-8?B?cGFRcnJEbGNtbEYwQ3J1SjlJRnFwZjBkNXN2bngwaUNXMFVUSnlGQTRmZDZu?=
 =?utf-8?B?RDZaY3QxTDBEbWhVTW5XM29rWEpNNVAvS2hERTM5SG1mVUFLb3lieUkyUktR?=
 =?utf-8?B?TGNFWitvNjN6dHlPYjIyOXdkNGUwQ09EcVJzTHJXam5KNFVZVEVGODNaYzVu?=
 =?utf-8?B?alFWQy9EeUlOVTRPZ1lVWVE1QXk4bUtOL3RyQ2J4ZE9zd2VvaU9EbklHNWg5?=
 =?utf-8?B?YmlpZGI2eHUwYnhSMkFkb0creDNMSUN4eVVXVVhBdkdqYXVCTjFoaTVZV2xs?=
 =?utf-8?B?R2tpdlhCcmZlWmtPK25xZkx5TFVPSndSNFI2UkpHS25ZUlJmb2NrdVhZT2RX?=
 =?utf-8?B?ajVoejFPVWxacUF5UHo2b3llRnF0VVdGVjZKNk9wTHI0ZDdvMks4V0FYaUd6?=
 =?utf-8?B?cExxa2daQWhNNXIzYk9lT1lZV2Eyd0g0ZHlHa2RaN05vS0VjOWRNdWhCVzBk?=
 =?utf-8?B?TFEzUUd2eEQ0R2Y0ZWt2d1B1Z2RVdmE1V09JcFZUUmhsalhnZk1vczZsTEpy?=
 =?utf-8?B?Nld4MzU1cDdUTXB6c050WDNlWVZpSE50aTRhRzVUZENmWWY0eDl3enR2a25V?=
 =?utf-8?B?SE5kVkc0eC9Fc1BNWDhjYTU1RE4rR1o1UW5YME4xZklBdGsxSkNjMUUvQkNE?=
 =?utf-8?B?Z1B3ZE5YbHloYTVKK3FxS25UR2l4WW9QeXpIT284T2tWV0tFNGFMUVlNQytC?=
 =?utf-8?B?U2hOdGZqQ0cvZ1BUYlRoeFZXMUNxRUswNXphMmE4NU5SQUFnYXZCa1JUelVo?=
 =?utf-8?B?UStwT1gxaW1ha2pHcndpUGp0UGx5UTBNdG5kc2lnRmhTc0JVdmhibENRT2E1?=
 =?utf-8?Q?3wokwVlAGMGdPwRDdgaJ8Rlxr?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53606918-f34b-4dab-ea5f-08dba385cb1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:05:24.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AV0NFOuE0ABw+ru57COSxwtUmGfV8ZDBRlQ3J2hY/BzliCnHcz5MkU8rjW4Cnp4ahvF/xqzMqHnt5U8FJWH/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5530
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/23 04:31, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi,
>>
> 
> [...]
> 
>>> In cable streaming notably, the RC job is to monitor the about of bits over a
>>> period of time (the window). This window is defined by the streaming hardware
>>> buffering capabilities. Best at this point is to start reading through HRD
>>> specifications, and open source rate control implementation (notably x264).
>>>
>>> I think overall, we can live with adding hints were needed, and if the gop
>>> information is appropriate hint, then we can just reuse the existing control.
>>>
>> Why we still care about GOP here. Hardware have no idea about GOP at
>> all. Although in codec likes HEVC, IDR and intra pictures's nalu header
>> is different, there is not different in the hardware coding
>> configration. NALU header is generated by the userspace usually.
>>
>> While future encoding would regard the current encoded picture as an IDR
>> is completed decided by the userspace.
> 
> The discussion was around having basic RC algorithm in the kernel driver,
What I am thinking is who would use a basic RC algorithm in the kernel?
We are designing a toy algorithm which all hardware could use, while it 
would introduce a complex structure to make the userspace work with it.

Vendor would need to try to fit their model in an interface with limited 
functions.
> possibly making use of hardware specific features without actually exposing it
> all to userspace. So assuming we do that:
> 
> Paul's concern is that for best result, an RC algorithm could use knowledge of
> keyframe placement to preserve bucket space (possibly using the last keyframe
> size as a hint). Exposing the GOP structure in some form allow "prediction", so
> the adaption can lookahead future budget without introducing latency. There is
> an alternative, which is to require ahead of time queuing of encode requests.
It sounds like a fixed bitrate RC. Then this RC algorithm would in 
charge of selecting the reference frames?

Suppose we are talking about Hantro H1 which people here are familiar with.
An intra frame would usually cost the most hardware time to encode and 
contribute a lot to the size of a GOP(fixed bitrate).

If we ignore the inter frame, that would lead to a bad quality image.
One case here is decide whether I would use a previous intra frame as 
the reference or just the last frame
Userspace should be able to decide when to request a intra frame or 
reencode the current inter frame to intra frame.
> But this does introduce latency since the way it works in V4L2 today, we need
> the picture to be filled by the time we request an encode.
> 
> Though, if we drop the GOP structure and favour this approach, the latency could
> be regain later by introducing fence base streaming. The technique would be for
> a video source (like a capture driver) to pass dmabuf that aren't filled yet,
> but have a companion fence. This would allow queuing requests ahead of time, and
> all we need is enough pre-allocation to accommodate the desired look ahead. Only
> issue is that perhaps this violates the fundamental of "short term" delivery of
> fences. But fences can also fail I think, in case the capture was stopped.
> 
I don't think it would help. Fence is a thing for DRM/GPU without a queue.
Even with a fence, would the video sink tell us the motion delta here?
> We can certainly move forward with this as a future solution, or just don't
> implement future aware RC algorithm in term to avoid the huge task this involves
> (and possibly patents?)
> 
I think we should not restrict how the userspace(vendor) operate the 
hardware.
> [...]
>>>
> 
>>> Of course, the subject is much more relevant when there is encoders with more
>>> then 1 reference. But you are correct, what the commands do, is allow to change,
>>> add or remove any reference from the list (random modification), as long as they
>>> fit in the codec contraints (like the DPB size notably). This is the only way
>>> one can implement temporal SVC reference pattern, robust reference trees or RTP
>>> RPSI. Note that long term reference also exists, and are less complex then these
>>> commands.
>>>
>>
>> If we the userspace could manage the lifetime of reconstruction
>> buffers(assignment, reference), we don't need a command here.
> 
> Sorry if I created confusion, the comments was something specific to H.264
> coding. Its a compressed form for the reference lists. This information is coded
> in the slice header and enabled through adaptive_ref_pic_marking_mode_flag
> 
> It was suggested so far to leave h264 slice headers writing to the driver. This
> is motivated by H264 slice header not being byte aligned in size, so the
H.264, H.265 has the byte_alignment() in nalu. You don't need skip bits 
feature which could be found in H1.

> slice_data() is hard to combine. Also, some hardware actually produce the
> slice_header. This needs actual hardware interface analyses, cause an H.264
> slice header is worth nothing if it cannot instruct the decoder how to maintain
> the desired reference state.
> 
I don't even think we should write the slice header into the CAPTURE 
buffer, which would cause a cache problem. Ususally the slice header 
would be written only when that slice data is copy out.
That is much more easily that userspace wrapper handle this.

> I think this aspect should probably not be generalized to all CODECs, since the
> packing semantic can largely differ. When the codec header is indeed byte
> aligned, it can easily be seperate and combined by application, improve the
> application flexibility, reducing the kernel API complexity.
>>
>> It is just a problem of how to design another request API control
>> structure to select which buffers would be used for list0, list1.
>>> I this raises a big question, and I never checked how this worked with let's say
>>> VA. Shall we let the driver resolve the changes into commands (VP8 have
>>> something similar, while VP9 and AV1 are refresh flags, which are just trivial
>>> to compute). I believe I'll have to investigate this further.
>>>
>>>>>
>>> [...]
> 
> regards,
> Nicolas

-- 
Hsia-Jun(Randy) Li
