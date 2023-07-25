Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF577606AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGYDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:33:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B761712;
        Mon, 24 Jul 2023 20:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrnKR7wpn9MkJKYj31CRnbfFtst7pwvWPsTXOxCTyqvoG7UiU/JjlrFXwmaAnfyh+WnEK6OOIWCdvbo7XHonT9mofFTi2ybVFQ//yZ/afMzAebl9udnrnpkLTwTwx9I98D1CXLVNpjUzqW3+3orrtRBZ1B/PbJvvWd2Py9MlTlLh6JZtC+0ekXA3HLYmBraVZ5ndFL4zxx2V3C6NqJ03a3ioUMJZuwBqJIZgKG5Ly6IXraTfBZz6gcLiGyJGcK9mC/r56qvwe/iJLk0e1rjLPRQ4oCaEFY5zB3mReJKm90ZNgb6uf+nbKBGTnEAdQ0HlJkTiJ35IjQ6INc1gg5Xlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IRrB4bpk9qkuAoiveK/Q1zdgfAokNxfK2kTQN+J9rM=;
 b=IE/d7KNlgeHfeipHs01fln6OXD1T40kYPIL33wxj71BN8jzrTIcw1eDHt2Ucgk8tQQQee9Y8UEzDJka2qO1qcf89TpS3k5kqBonNrQUwsQ5chWhDV3JahWQSIlVA/7AVphtYCiKql1lU2g3/8afY5D4JwmwsMzIi2J1QmheM5+s61zG/6lAu4AtkvGYOmKd6MhQqdd28qPmuHm0fGpRjHvvm6i456MGsUIIOBtkVHfI7L6mdFwou3jx7xNNw3MynQAvfGC4X9p+8zoNwwvuNLx7hl42tz0RAMOOH3ablImZBCQAEgu0Wiv5NZ3mWEr8La7Fs22BUDjKzrOkyjbO+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IRrB4bpk9qkuAoiveK/Q1zdgfAokNxfK2kTQN+J9rM=;
 b=HxiZtel+SdhuT5kuc8EW9crBLhxxm/cbOFpG5w+CWBfQFWeBjDCL+vAKBgFk6M07AjfGkMrOi/9mRcAzfzL8J/TenGYlF5QjkxiHZIE7+QOu0ri2sMAF5vhALzcr9Xjd53+zmr4H+6F1CFrf+PDNL9zoZKWLczEkgmcVYRnA0W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BN9PR03MB5963.namprd03.prod.outlook.com (2603:10b6:408:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 03:33:49 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:33:48 +0000
Message-ID: <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
Date:   Tue, 25 Jul 2023 11:33:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Content-Language: en-GB
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
 <ZK6zjaJtulRSrn7P@aptenodytes>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <ZK6zjaJtulRSrn7P@aptenodytes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BN9PR03MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a432fa-da33-4981-6f18-08db8cbff500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrddeaVdCAkHYC5ecYaDplJbhYDshHNcRKgRIdWDrBukjNGNVwmU21FOWqdAS+b73zHpJ0QWe9+vilkN3pvx8If3Uce8ahl4J7u69OxtT+yU6IG0PeKceaM1TTcIHMowgFHhQYxEfnA8ED1mxKH2G/MoiO0KMCbsPEr/ODTlIPjiv8eb2c0H9oJ3sOmwNcvRJkZ9WoEEnZILBZgq7Ad8o5G3yQcKPx67aVylQfHIQ0R1fsFK8GKMG+U/TKJpHcsFO07QsJyvjmHhbt8VM96pGxGfiZBxF9oAflneD2NYlDtrz2V/WzJZMZJ6eWqBLSFBbYIuYcpmTWJeR/hRJ4CeQg3DzA0tUw7ptWyxXtr5BCNglwN/P+63kvUuOveLSf+he4E6+4QX0QELEAg8TYpi5UbePvlnIsv0JIax7a3R12DxMms1u/Qa/lJrP6K2DRi+1t6p+aLaGp7tk1W09eZgNYZthXkELPrJiyAuUB5xabbX4AgcDj+a1yNYG2ElJv8JqcFTzyB5B/c69cS7MOkrjdNWhF0HnhcrvQp4Qfsf5aoXAMvpJHsRT5LrUk6Ke5ZNQenPYDR8ymXXDyK1lU3Ijoaa4taNvs+4ea3IVDpQZnH0PI3TakmbH1pRTFrQaziWcqA+jJ+y9Au6yzI39GHyu+oBX9z9/nzmTepFRzVwsxgrj+Oh5aowb2NqmhnWjS+uegt1tL8LGZCuf2P0V3AEDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(31686004)(30864003)(8676002)(8936002)(7416002)(5660300002)(66899021)(41300700001)(316002)(6916009)(4326008)(2906002)(54906003)(66946007)(66476007)(66556008)(6666004)(6486002)(6512007)(26005)(52116002)(53546011)(186003)(478600001)(6506007)(966005)(31696002)(86362001)(66574015)(36756003)(2616005)(83380400001)(38100700002)(38350700002)(43740500002)(45980500001)(240264003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNScnFyY1g3M2NINUVLTWgyaFVLODNSdjdFZkx4aFJXdnJMdDZpUVZwSVpN?=
 =?utf-8?B?NVQvMWhENjlaTjh1dHd5UmppeEhBU1NKdkNSRjQweSt2TjYxZTV0dnl6Vlh6?=
 =?utf-8?B?THdVZXdVREZ2clVUQlRBbmhsT3U5cnhIbnFPN2U5RlI5cEVwYlhuM2tiR1NZ?=
 =?utf-8?B?OXJBaXVaZU1aeXhsUzljd2lsVktoYlU0N0VDUUtZUGMyS0h0OGpZSmtLT0tN?=
 =?utf-8?B?V0JSbjdQTUlra1RSek9LTTIxQTNMSUxhQklob0JsUUhUdnAyUmRaWkl1ZXo4?=
 =?utf-8?B?SlZrWkxxWVp2RTM5U1lYekFsUm1jTndEYzNZL0ZCd0wvVTkxWXBzV2tkSmNR?=
 =?utf-8?B?VFlhc3JxV2d3Vk9rUDZrc0h2b3A2VU5JeGlXNnZkd1RjamlIRnBBbHlMWDRh?=
 =?utf-8?B?NmFSeW5UdXRzQlkrWlErSzVPb1ZJaFF4eituUTlBbVRUc2VTaWZ5dW5DYWtZ?=
 =?utf-8?B?WlVONG5SeGtOUndUQWZ6L0lzZkRkekQzazIyNm9FTklCdWhTM2oraWlKK2xk?=
 =?utf-8?B?d0NrWE5ZS1Y4V2FJeUt2b0h1ekFsbW5NQURsc0hjc2dyeE5tTmExWUFYNHV5?=
 =?utf-8?B?dTFXdFV6MlRyT1ZNY09VcmxuTFVHclVOOXl1RmFUZXNLRGpYOTNISXFmNUhS?=
 =?utf-8?B?ZDh6SGJhVHJsN1ZuV3hvbU1GclVhSGJzOEJtV1l4c1NTOTFNc2tkVTdkaFoy?=
 =?utf-8?B?azhiS25yTy9kcGVJNFVmK0Vmb0s1Skh3enFta21ha0dXb1J3WVkwQlhVdDRT?=
 =?utf-8?B?QzhQWGVnZVlsN2lXaVo0MCtzdWljbmR1blE2aTNLb1poQ1RVMm02SnpIWk51?=
 =?utf-8?B?VlNmTjYvU3dTUUFtbW0xcHRLRFQ0MmpXNjI2dVRoRnJaT0lYVEtQc3J5ZVdo?=
 =?utf-8?B?UXlydSsvM0VDbjUxNUl0cWY3TktMM1kwZWVEem05UzNMenI1YytQNTI1b2Zl?=
 =?utf-8?B?SkVoNGpXNGtrMzQ3VGl1WnFhUGRNVERGWlgvbVdpcUtJME1zT2N2KzhXcXBF?=
 =?utf-8?B?b3VJbTRnd3FOZFppN0pQMFBpM01UWThzeHN3dStvQXkyR1BkbzZjWVpmMmMw?=
 =?utf-8?B?MzhXVmM5WjIrTy9pTG9VTEQxRG15eW1IalJnbEZDZ1ladE1rbjdlODdVTUV4?=
 =?utf-8?B?d0tyenhFUm5NeU9sVkJoTkkvN3ZYRDhiNEJXSllxK3pMREpyV0RMSGFnU0hx?=
 =?utf-8?B?aXBKajltVzI0Y1ZzOSt1Tmx5WERucTZrRnhia3hYZEpGN3F4YVRjSzV2UEhB?=
 =?utf-8?B?NGhKRHZ0TXpOcERCdmRIemJDTG1saTJhNVR1cElPeGFVVGZLMTNtZXdoSkZj?=
 =?utf-8?B?SmtTWCtmcURzUDNxTjdiUjJXRmtMeVZUUnlwNzlnNzJRTTdiWS9VMGw0bGxq?=
 =?utf-8?B?QytpbmlWa3Z2cUdZNjh4di9wa3c5dElxbEs3M3g0aEhFcDB6eEFON1ByYjhK?=
 =?utf-8?B?aXZZV0tIQVduUDc5TEZBRnMrVHRlNzZFbVRsV2tzQXM3SjJtTUdiZDBGSlJo?=
 =?utf-8?B?ZitwNEpPMFRyWkF1SnlYWE5oKzdtNDJxdFh4QzZGOW1KRFc1RDFPS1Y4MGNx?=
 =?utf-8?B?WGQxNFdOOGgveTJjMEo0Sm44RERQeGZFYUVyQnNpc3lWNmI0RzQvZ2xNd2Mw?=
 =?utf-8?B?SmY3Q0JRMWQ4MHFNWWMrNmZqSTdQRDZ5czd5SkVxd0V3STNjVXVsRFZpc1dr?=
 =?utf-8?B?UTg3NXgzY0oxQ0toNTZkSXAyQW1TTWQwT0NPajR5dUl2U1JCSUZSS3h2S3Za?=
 =?utf-8?B?TitxTmgwcjZCRHBpRytUYi83aENXbVhSOEw3aldjeEk1OWxBRnpTL3l6MVB5?=
 =?utf-8?B?VVh1VDduNUcvK0lTMlNIS0tIR003TWdDYVdtL05nVzlKZC9JNU5rczVpamRr?=
 =?utf-8?B?QTAyK2VlbExlVkZHQmlXU2FBR0ZMYm5kRXNFRWQ4T2RHL2I4WS9wd3NjNDg2?=
 =?utf-8?B?SkVnVkR3SFZKWjVoSW15RzJFdGx3OFBwWkxPWG5QbTd2L29FMmhhWVhsYytP?=
 =?utf-8?B?eHVrR1VTWWh2UEdYS2tka0RMQUM5WW9RbXNsajArTEV2ZE5ieFpMVHp2cXhO?=
 =?utf-8?B?VEtXTFJrM09mMlZYamIzdWhUbWU5TlR2Tzl1UlFwOEhLS09yMG00WXMxaDdn?=
 =?utf-8?Q?IiKmXPHYboLCadFLoz+iLYRQe?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a432fa-da33-4981-6f18-08db8cbff500
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:33:48.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QE9FIAd2ChcoNJIMHuKAuw5lWUS8eqnAw/3YlUF7jQEIkZzj7xrao5gYHosDHohJ8E8GV/dIb1S+opOM67Ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5963
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 22:07, Paul Kocialkowski wrote:
> Hi Nicolas,
> 
> Thanks for the quick reply!
> 
> On Tue 11 Jul 23, 14:18, Nicolas Dufresne wrote:
>> Le mardi 11 juillet 2023 à 19:12 +0200, Paul Kocialkowski a écrit :
>>> Hi everyone!
>>>
>>> After various discussions following Andrzej's talk at EOSS, feedback from the
>>> Media Summit (which I could not attend unfortunately) and various direct
>>> discussions, I have compiled some thoughts and ideas about stateless encoders
>>> support with various proposals. This is the result of a few years of interest
>>> in the topic, after working on a PoC for the Hantro H1 using the hantro driver,
>>> which turned out to have numerous design issues.
>>>
>>> I am now working on a H.264 encoder driver for Allwinner platforms (currently
>>> focusing on the V3/V3s), which already provides some usable bitstream and will
>>> be published soon.
>>>
>>> This is a very long email where I've tried to split things into distinct topics
>>> and explain a few concepts to make sure everyone is on the same page.
>>>
>>> # Bitstream Headers
>>>
>>> Stateless encoders typically do not generate all the bitstream headers and
>>> sometimes no header at all (e.g. Allwinner encoder does not even produce slice
>>> headers). There's often some hardware block that makes bit-level writing to the
>>> destination buffer easier (deals with alignment, etc).
>>>
>>> The values of the bitstream headers must be in line with how the compressed
>>> data bitstream is generated and generally follow the codec specification.
>>> Some encoders might allow configuring all the fields found in the headers,
>>> others may only allow configuring a few or have specific constraints regarding
>>> which values are allowed.
>>>
>>> As a result, we cannot expect that any given encoder is able to produce frames
>>> for any set of headers. Reporting related constraints and limitations (beyond
>>> profile/level) seems quite difficult and error-prone.
>>>
>>> So it seems that keeping header generation in-kernel only (close to where the
>>> hardware is actually configured) is the safest approach.
>> This seems to match with what happened with the Hantro VP8 proof of concept. The
>> encoder does not produce the frame header, but also, it produces 2 encoded
>> buffers which cannot be made contiguous at the hardware level. This notion of
>> plane in coded data wasn't something that blended well with the rest of the API
>> and we didn't want to copy in the kernel while the userspace would also be
>> forced to copy to align the headers. Our conclusion was that it was best to
>> generate the headers and copy both segment before delivering to userspace. I
>> suspect this type of situation will be quite common.
> Makes sense! I guess the same will need to be done for Hantro H1 H.264 encoding
> (in my PoC the software-generated headers were crafted in userspace and didn't
> have to be part of the same buffer as the coded data).
We just need a method to indicate where the hardware could write its 
slice data or compressed frame.
While we would decided which frame that the current frame should refer, 
the (some) hardware may discard our decision, which reference picture 
set would use less bits. Unless the codec supports a fill up method, it 
could lead to a gap between header and frame data.
> 
>>> # Codec Features
>>>
>>> Codecs have many variable features that can be enabled or not and specific
>>> configuration fields that can take various values. There is usually some
>>> top-level indication of profile/level that restricts what can be used.
>>>
>>> This is a very similar situation to stateful encoding, where codec-specific
>>> controls are used to report and set profile/level and configure these aspects.
>>> A particularly nice thing about it is that we can reuse these existing controls
>>> and add new ones in the future for features that are not yet covered.
>>>
>>> This approach feels more flexible than designing new structures with a selected
>>> set of parameters (that could match the existing controls) for each codec.
>> Though, reading more into this emails, we still have a fair amount of controls
>> to design and add, probably some compound controls too ?
> Yeah definitely. My point here is merely that we should reuse existing control
> for general codec features, but I don't think we'll get around introducing new
> ones for stateless-specific parts.
> 
Things likes profile, level or tiers could be reused. It make no sense 
to expose those vendor special feature.
Besides, profile, level or tiers are usually stored in the sequence 
header or uncompressed header, hardware doesn't care about that.

I think we should go with the vendor registers buffer way that I always 
said. There are many encoding tools that a codec offer, variants of 
hardware may not support or use them all. The context switching between 
userspace and kernel would drive you mad for so many controls.
>>> # Reference and Reconstruction Management
>>>
>>> With stateless encoding, we need to tell the hardware which frames need to be
>>> used as references for encoding the current frame and make sure we have the
>>> these references available as decoded frames in memory.
>>>
>>> Regardless of references, stateless encoders typically need some memory space to
>>> write the decoded (known as reconstructed) frame while it's being encoded.
>>>
>>> One question here is how many slots for decoded pictures should be allocated
>>> by the driver when starting to stream. There is usually a maximum number of
>>> reference frames that can be used at a time, although perhaps there is a use
>>> case to keeping more around and alternative between them for future references.
>>>
>>> Another question is how the driver should keep track of which frame will be used
>>> as a reference in the future and which one can be evicted from the pool of
>>> decoded pictures if it's not going to be used anymore.
>>>
>>> A restrictive approach would be to let the driver alone manage that, similarly
>>> to how stateful encoders behave. However it might provide extra flexibility
>>> (and memory gain) to allow userspace to configure the maximum number of possible
>>> reference frames. In that case it becomes necessary to indicate if a given
>>> frame will be used as a reference in the future (maybe using a buffer flag)
>>> and to indicate which previous reference frames (probably to be identified with
>>> the matching output buffer's timestamp) should be used for the current encode.
>>> This could be done with a new dedicated control (as a variable-sized array of
>>> timestamps). Note that userspace would have to update it for every frame or the
>>> reference frames will remain the same for future encodes.
>>>
>>> The driver will then make sure to keep the reconstructed buffer around, in one
>>> of the slots. When there's no slot left, the driver will drop the oldest
>>> reference it has (maybe with a bounce buffer to still allow it to be used as a
>>> reference for the current encode).
>>>
>>> With this behavior defined in the uAPI spec, userspace will also be able to
>>> keep track of which previous frame is no longer allowed as a reference.
>> If we want, we could mirror the stateless decoders here. During the decoding, we
>> pass a "dpb" or a reference list, which represent all the active references.
>> These do not have to be used by the current frame, but the driver is allowed to
>> use this list to cleanup and free unused memory (or reuse in case it has a fixed
>> slot model, like mtk vcodec).
>>
>> On top of this, we add a list of references to be used for producing the current
>> frame. Usually, the picture references are indices into the dpb/reference list
>> of timestamp. This makes validation easier.  We'll have to define how many
>> reference can be used I think since unlike decoders, encoders don't have to
>> fully implement levels and profiles.
> So that would be a very explicit description instead of expecting drivers to
> do the maintainance and userspace to figure out which frame was evicted from
> the list. So yeah this feels more robust!
> 
> Regarding the number of reference frames, I think we need to specify both
> how many references can be used at a time (number of hardware slots) and how
> many total references can be in the reference list (number of rec buffers to
> keep around).
> 
> We could also decide that making the current frame part of the global reference
> list is a way to indicate that its reconstruction buffer must be kept around,
> or we could have a separate way to indicate that. I lean towards the former
> since it would put all reference-related things in one place and avoid coming
> up with a new buffer flag or such.
> 
> Also we would probably still need to do some validation driver-side to make
> sure that userspace doesn't put references in the list that were not marked
> as such when encoded (and for which the reconstruction buffer may have been
> recycled already).
> 
DPB is the only thing we need to decide any API here under the vendor 
registers buffer way. We need the driver to translate the buffer 
reference to the address that hardware could use and in its right registers.

The major problem is how to export the reconstruction buffer which was 
hidden for many years.
This could be disccused in the other thread like V4L2 ext buffer api.
>>> # Frame Types
>>>
>>> Stateless encoder drivers will typically instruct the hardware to encode either
>>> an intra-coded or an inter-coded frame. While a stream composed only of a single
>>> intra-coded frame followed by only inter-coded frames is possible, it's
>>> generally not desirable as it is not very robust against data loss and makes
>>> seeking difficult.
>> Let's avoid this generalization in our document and design. In RTP streaming,
>> like WebRTP or SIP, it is desirable to use open GOP (with nothing else then P
>> frames all the time, except the very first one). The FORCE_KEY_FRAME is meant to
>> allow handling RTP PLI (and other similar feedback). Its quite rare an
>> application would mix close GOP and FORCE_KEY_FRAME, but its allowed though.
>> What I've seen the most, is the FORCE_KEY_FRAME would just start a new GOP,
>> following size and period from this new point.
> Okay fair enough, thanks for the details!
> 
>>> As a result, the frame type is usually decided based on a given GOP size
>>> (the frequency at which a new intra-coded frame is produced) while intra-coded
>>> frames can be explicitly requested upon request. Stateful encoders implement
>>> these through dedicated controls:
>>> - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
>>> - V4L2_CID_MPEG_VIDEO_GOP_SIZE
>>> - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
>>>
>>> It seems that reusing them would be possible, which would let the driver decide
>>> of the particular frame type.
>>>
>>> However it makes the reference frame management a bit trickier since reference
>>> frames might be requested from userspace for a frame that ends up being
>>> intra-coded. We can either allow this and silently ignore the info or expect
>>> that userspace keeps track of the GOP index and not send references on the first
>>> frame.
>>>
>>> In some codecs, there's also a notion of barrier key-frames (IDR frames in
>>> H.264) that strictly forbid using any past reference beyond the frame.
>>> There seems to be an assumption that the GOP start uses this kind of frame
>>> (and not any intra-coded frame), while the force key frame control does not
>>> particularly specify it.
>>>
>>> In that case we should flush the list of references and userspace should no
>>> longer provide references to them for future frames. This puts a requirement on
>>> userspace to keep track of GOP start in order to know when to flush its
>>> reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, but this
>>> could also indicate a general intra-coded frame that is not a barrier.
>>>
>>> So another possibility would be for userspace to explicitly indicate which
>>> frame type to use (in a codec-specific way) and act accordingly, leaving any
>>> notion of GOP up to userspace. I feel like this might be the easiest approach
>>> while giving an extra degree of control to userspace.
>> I also lean toward this approach ...
>>
>>> # Rate Control
>>>
>>> Another important feature of encoders is the ability to control the amount of
>>> data produced following different rate control strategies. Stateful encoders
>>> typically do this in-firmware and expose controls for selecting the strategy
>>> and associated targets.
>>>
>>> It seems desirable to support both automatic and manual rate-control to
>>> userspace.
>>>
>>> Automatic control would be implemented kernel-side (with algos possibly shared
>>> across drivers) and reuse existing stateful controls. The advantage is
>>> simplicity (userspace does not need to carry its own rate-control
>>> implementation) and to ensure that there is a built-in mechanism for common
>>> strategies available for every driver (no mandatory dependency on a proprietary
>>> userspace stack). There may also be extra statistics or controls available to
>>> the driver that allow finer-grain control.
>> Though not controlling the GOP (or no gop) might require a bit more work on
>> driver side. Today, we do have queues of request, queues of buffer etc. But it
>> is still quite difficult to do lookahead these queues. That is only useful if
>> rate control algorithm can use future frame type (like keyframe) to make
>> decisions. That could be me pushing to far here though.
> Yes I agree the interaction between userspace GOP control and kernel-side
> rate-contrly might be quite tricky without any indication of what the next frame
> types will be.
> 
> Maybe we could only allow explicit frame type configuration when using manual
> rate-control and have kernel-side GOP management when in-kernel rc is used
> (and we can allow it with manual rate-control too). I like having this option
> because it allows for simple userspace implementations.
> 
> Note that this could perhaps also be added as an optional feature
> for stateful encoders since some of them seem to be able to instruct the
> firmware what frame type to use (in addition to directly controlling QP).
> There's also a good chance that this feature is not available when using
> a firmware-backed rc algorithm.
> 
>>> Manual control allows userspace to get creative and requires the ability to set
>>> the quantization parameter (QP) directly for each frame (controls are already
>>> as many stateful encoders also support it).
>>>
>>> # Regions of Interest
>>>
>>> Regions of interest (ROIs) allow specifying sub-regions of the frame that should
>>> be prioritized for quality. Stateless encoders typically support a limited
>>> number and allow setting specific QP values for these regions.
>>>
>>> While the QP value should be used directly in manual rate-control, we probably
>>> want to have some "level of importance" setting for kernel-side rate-control,
>>> along with the dimensions/position of each ROI. This could be expressed with
>>> a new structure containing all these elements and presented as a variable-sized
>>> array control with as many elements as the hardware can support.
>> Do you see any difference in ROI for stateful and stateless ? This looks like a
>> feature we could combined. Also, ROI exist for cameras too, I'd probably try and
>> keep them separate though.
> I feel like the stateful/stateless behavior should be the same, so that could be
> a shared control too. Also we could use a QP delta which would apply to both
> manual and in-kernel rate-control, but maybe that's too low-level in the latter
> case (not very obvious when a relevant delta could be when userspace has no idea
> of the current frame-wide QP value).
> 
>> This is a very good overview of the hard work ahead of us. Looking forward on
>> this journey and your Allwinner driver.
> Thanks a lot for your input!
> 
> Honestly I was expecting that it would be more difficult than decoding, but it
> turns out it might not be the case.
> 
Such rate control or quailty report would be complete vendor special.
We just need a method that let driver report those encoding statistic to 
the userspace.
> Cheers,
> 
> Paul
> 
> -- Paul Kocialkowski, Bootlin Embedded Linux and kernel engineering 
> https://bootlin.com

-- 
Hsia-Jun(Randy) Li
