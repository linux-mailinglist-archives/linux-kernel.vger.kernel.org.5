Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F27783BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjHVIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjHVIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:30:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB0CDA;
        Tue, 22 Aug 2023 01:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeSxWShJnkSrR3omdgMqfcnEt+EFC6fHXB57S6GGGH55/Ey7fAaB3m0OgSHuc46A4QYMCve9UWF5zodBmXb7Bj+Bhn6sthPLInRg+7Pc8thIhENnRuXQz0YOhdeVyKhr4eWtongOa44L3NdJUvg2QHABysTrtuUeuFdBxbsx9/iIb6pkcCnNCus8r3dgu38drvjFwaIunV2ZgoadN+nbQL+hQn9A1SzGK4g4r89Eis4Hzf1OSNPxRbbZouW8WpsBBRiB4oDtD+MQcPkabdI1oGbiUZBSNEtb9rFtt1IGjgE7/VnRWjdhod+WuxzygjdExQTTS+INJVoA4rZMS5MP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR3FFcUerhqJVmeeSvMiPEJU30rFgICiVqWob78ApsA=;
 b=a9DlmfX4Qn0EtfXWKBCV1iRgTJcol594YVY+0v3lYED0lcPE+eOFbgszJfYBYlNAwc9v309MeCz/5nbi+METO37EGo+nAYjWnsGA+B65xN5xs5y+WTT8SNOHaTJNkjqrZD33uYbhYs5rdj1NYkJbiQ4KA55Q5oK7IeaLWM8j/lphs8Mz2dAfxf9hu+BVn+UQXjHlg4b6Pdi04b5LOxq5/P0GSuu/yLQwF2kJooDiaAiQDWxpo4pHxjuWT7cQ+ZefPp2vHaN9RcFQSOwNaId8I/pGKSzY0w4yIuXqAKK6OmYl7Vlvn4lEF5WnCXiznc6ytvJNs67B/uI/FROHuCu2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR3FFcUerhqJVmeeSvMiPEJU30rFgICiVqWob78ApsA=;
 b=lnAIfaJXnApGUU+yzxyVXXNFG7hH+t0CWq2vg3osih87XiI0cl+dwENdbW65/pzQHdnfnToeG79OUVcLTaCrCJS1q5lKeDlj4Rwqqx36dyNvWZE8a8/WBhwFp51PZwL28YkXbCBRIaV9gUWPK7W6JQbxlkInDyicXckEl26JWmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SA3PR03MB7489.namprd03.prod.outlook.com (2603:10b6:806:39a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 08:30:45 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 08:30:44 +0000
Message-ID: <39270c5e-24ab-8ff6-d925-7718b1fef3c4@synaptics.com>
Date:   Tue, 22 Aug 2023 16:30:09 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SA3PR03MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8f9384-762e-4d21-edec-08dba2ea140d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pG6kdDz5/dMJNcEhOAIUy/6sGgcH9X4AMzI2WNRcECKh6Jy3dXDOfdEMCY3ioUR5/uZ90GzBjQUqbS9NQb/8gxIV5N3d9KPXQTTxeFquxdIXjux0JTuoLDQlpR9LVB2NMOBSTv2UBb1oKRxUUInnQcG8YSZi6PRI8oQfrXr9Ve9lpwH2mKhOMfzNZs585b8ZMK/3gGmVXWR0yN4+hZRM6NgLXUE1S2M5xGbNKkBlhvjUEVTT2TJlxm+HQBOp3v40vnU98dg+FetJt7W0gJL7jXnVh47hBIZTF0Gq94wEK1Op5cDlqqvfG2PXOIw0ECQMOX8+XLL8wn1HfbxcURJ/s4KD3lwVmwLqYIPp8yUQGWVBe0LF2Ufg/Hmtl4YEwAAs+sX4UQMjzs9rzsGvgw4Q4Sk1iz5f95MNCPcUSk4+TWdqxd7xy3EWbD5zyN2PwJsAoDOjeyDDsO/vvkdP+5cv70M3rF8Xc1bs6ifC8z21EPMA+8KyZozBJA8+WdReXT+IPP4sC3jXsJAMLp1jJaubf6mQuvSobOxORyIMlGIJ7w+TyhoyqJQqHO0i6cJNgYJ9CVAcvq1fKDyljqVEXLaTgFSvbNHCaos4t+NVo9lKJ7FtsCqNvkMN1vVy1dvdSTAmVcNlyc3MNMacXDPZ6BM5S73vCqacCBkvCjfk3HNlhWQqfnYpuNxxKLDccaTJBrkp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(6666004)(6486002)(53546011)(6506007)(38350700002)(6512007)(52116002)(38100700002)(31696002)(66899024)(83380400001)(66574015)(26005)(86362001)(36756003)(2616005)(66476007)(316002)(2906002)(66556008)(54906003)(66946007)(41300700001)(30864003)(110136005)(5660300002)(4326008)(8936002)(8676002)(7416002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1dtaG1ySTFYMXpqQVFwVy9YRGZDclBvZEovU0VONm5kSEdPNGIvNkxEUG11?=
 =?utf-8?B?WVVFejZFeE9wbFUxKzFITzFhVDljTXRlNWdYZXhiN1VZb0Q2c29SM2swUTZZ?=
 =?utf-8?B?dURHbzBqRFk5VkxDRXB6YTNkdk10RHF4ZjAzcGhHYmhmM1ZvdE02RDZWM3pY?=
 =?utf-8?B?MitXbldHbHZCNVFMZmdNKzJVSDBENGpKNlVsZ2RUTGlQOTlrLzFXYjlnWGUy?=
 =?utf-8?B?ZTJ2TU8rOWpsUVozYVN3dlZYUXJRQ2t3V1Ric083UDRrSzl4SFN3cmVkdmph?=
 =?utf-8?B?ZmhJaUNxUnEwRDBQZ1BvODFmMjJIaG01cExYZC8zcWt6MXFPU3haL3BpWEFK?=
 =?utf-8?B?akhQRGp4Y3Q4MC9zaGFmb2RNc0EzSUtVaktLOGFpVnM5ajYwdG1wUEl1ME1Q?=
 =?utf-8?B?Qi9KUjBMcVl6aElsREZrQUhBaFZKYnZ1WVA0UTFpWXhFbGtnVXBVSHhqZGJL?=
 =?utf-8?B?SzhtVm9hb1oya0tQVXdIdVZFVmw4TzlLVGRaNHYrUmdzd2lVeUhKbENFQ0VE?=
 =?utf-8?B?Zmh4YWpSZE1MZTZoZ0ZtRXVTdEtveDlHK1N0bUdnM0hNSm80KzVmTTRWL0Vr?=
 =?utf-8?B?dkxma1JKMHpNSCtRL3M0UDdnSENNb3NwMUtSd09HNG50bGphamlLblRaZzZ6?=
 =?utf-8?B?VEQ5RzNTTGsyYUNCampHczFFQVU5aUU0S2hEdjJPQ1NnS09GRFFuTmZkdDhD?=
 =?utf-8?B?bDM4QnFyWGVTVkNaT01lbFl4UTZYVDB5bGY3S1BBT09qWmNtZnYxZXVhZ0Q5?=
 =?utf-8?B?T1NycktLV0FIQS9Ga3NpWTJWRVhzeWloN0xOYnJhQzExSzc0d0k4Ymt6U3lI?=
 =?utf-8?B?Vng5SksrVml1RHQyVlBTdVJGa0JqaThxQ3VLeGtrZHF0SjBSTTk5V2xQWUw2?=
 =?utf-8?B?TGdxSGVSeDNGaTBFWTVScjdocTVySC85cE5hZnYxN3Q1alZUeVFsK3M4VXE0?=
 =?utf-8?B?UTAzT0JYM2ZpT1hTRWl0TWE2ZnNSdVVnN01WSzNEcDI1YTRkamkvTjFGUDhh?=
 =?utf-8?B?SitNOE1kbVViUklFSnFXb0ZGUTUwTkxMUzZxU0U5R28xTEFnTVVWNmJWcGtC?=
 =?utf-8?B?NGtrUm94QXVRL2dJaElCV1Mveks0ek5PVFZEeG9CVy9DZFk3WE1TZ2Vycmkr?=
 =?utf-8?B?RlVxdDdEZkRWbzJNTFNUaTRCZ1BpV2xNTG9uenZQaHA2UldjODR1b3Q4amhD?=
 =?utf-8?B?Uk5hVTNHYjNmeHlYT1lEbUw5dUpjbDk0Q0taMGlvWU1KMmlyUktCRnp1aGht?=
 =?utf-8?B?cWNhczBhbVhucURhYVVyWWx4a3NpV1NJZTZVOEd1UWFhaVhITkNJcjd5d2RO?=
 =?utf-8?B?Z0lWeWJhT3hCVnJPajBxdGl5cEx5YXltNmJjaDEzVmZxK3NPUFlLZjNBZFYz?=
 =?utf-8?B?Z0dEZnc0akJ3ZFkvVGl0MDM2S2dXQjc0YXV6V0xLRVlNWTdrSXIvNVFSemxF?=
 =?utf-8?B?eUZiQVVWSlU5ZFhDWVhHdjVBd1pOck1DRzhFTHRndmMrVFRxalhoMUJFNGZk?=
 =?utf-8?B?cWdYbkZ6UTVvZ2YyZEdLRkg0WjVZT0lueHZFbUhEM0o3Q2NUZS9ubnBGRGVu?=
 =?utf-8?B?R3EyNG02S0x0SW9RcEVTOFJQWHo4dlpjMm05T2VSS0VWb3puSTlsMmJGUmYw?=
 =?utf-8?B?aXgzQkppZjVLeXhPWk5KZ1dzdjY1RjBXTThnc3VuVzl2VllEYWhGdDhNSUtJ?=
 =?utf-8?B?a2lkbFB2RkRNMjc5NWt0V2oxNUV2TUFHekZ0bjZVZnc2U0NNcGdhY1lGT0E5?=
 =?utf-8?B?ODNmTTZTWDFxNjFnWGtHY25vRGV0RWYwNmRPcWMxV2NPT0F0cmlNY21tbEZw?=
 =?utf-8?B?cjFHUURSRXRUUFkyTTFNVm0vQzNGL2tBeGVVajV5K1ZHTDA4UDVEOFJuRWE5?=
 =?utf-8?B?aDJZNkhmVUxlY21WVDlqRzY2QkwrY2kveGYwelJDalpMRm9oUm56bmNLYXls?=
 =?utf-8?B?dEdrVUc3b25LR05tQUNhQnUvWUpBQStyS2dJMms5RVNTRWdNMW52d3liUzNF?=
 =?utf-8?B?dFovdTVabmZQaXBPdjRZbzZOSEtsaW1QWWxhNWhHR2w3NjlYY0d0eTllMDZr?=
 =?utf-8?B?SUNrUnc4cysySmRubWxqVzBpRm5INkNoUUNtRndOdEtmMDlrd2xqd0N5K2R1?=
 =?utf-8?Q?cH24pl0LXc6AUhQ9WkmHbBf+0?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8f9384-762e-4d21-edec-08dba2ea140d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 08:30:44.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6t5Bz+9G7xjZJVTxjNE1TDk3m1m6MBZ/BEZxSzrlsrqAm8M6Wo0rjx7R+3bTjlikI02uGCuB6BjKYSHip482Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7489
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 23:13, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hello again,
> 
> I've been away last week.
> 
> Le vendredi 11 août 2023 à 22:08 +0200, Paul Kocialkowski a écrit :
>> Hi Nicolas,
>>
>> On Thu 10 Aug 23, 10:34, Nicolas Dufresne wrote:
>>> Le jeudi 10 août 2023 à 15:44 +0200, Paul Kocialkowski a écrit :
>>>> Hi folks,
>>>>
>>>> On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
>>>>> I am now working on a H.264 encoder driver for Allwinner platforms (currently
>>>>> focusing on the V3/V3s), which already provides some usable bitstream and will
>>>>> be published soon.
>>>>
>>>> So I wanted to shared an update on my side since I've been making progress on
>>>> the H.264 encoding work for Allwinner platforms. At this point the code supports
>>>> IDR, I and P frames, with a single reference. It also supports GOP (both closed
>>>> and open with IDR or I frame interval and explicit keyframe request) but uses
>>>> QP controls and does not yet provide rate control. I hope to be able to
>>>> implement rate-control before we can make a first public release of the code.
>>>
>>> Just a reminder that we will code review the API first, the supporting
>>> implementation will just be companion. So in this context, the sooner the better
>>> for an RFC here.
>>
>> I definitely want to have some proposal that is (even vaguely) agreed upon
>> before proposing patches for mainline, even at the stage of RFC.
>>
>> While I already have working results at this point, the API that is used is
>> very basic and just reuses controls from stateful encoders, with no extra
>> addition. Various assumptions are made in the kernel and there is no real
>> reference management, since the previous frame is always expected to be used
>> as the only reference.
> 
> One thing we are looking at these days, and aren't current controllable in
> stateful interface is RTP RPSI (reference picture selection indication). This is
> feedback that a remote decoder sends when a reference picture has been decoded.
> In short, even if only 1 reference is used, we'd like the reference to change
> only when we received the acknowledgement that the new one has been
> reconstructed on the other side.
> 
> I'm not super keep in having to modify the Linux kernel specially for this
> feature. Specially that similar API offer it at a lower level (VA, D3D12, and
> probably future API).
> 
>>
>> We plan to make a public release at some point in the near future which shows
>> these working results, but it will not be a base for our discussion here yet.
>>
>>>> One of the main topics of concern now is how reference frames should be managed
>>>> and how it should interact with kernel-side GOP management and rate control.
>>>
>>> Maybe we need to have a discussion about kernel side GOP management first ?
>>> While I think kernel side rate control is un-avoidable, I don't think stateless
>>> encoder should have kernel side GOP management.
>>
>> I don't have strong opinions about this. The rationale for my proposal is that
>> kernel-side rate control will be quite difficult to operate without knowledge
>> of the period at which intra/inter frames are produced. Maybe there are known
>> methods to handle this, but I have the impression that most rate control
>> implementations use the GOP size as a parameter.
>>
>> More generally I think an expectation behind rate control is to be able to
>> decide at which time a specific frame type is produced. This is not possible if
>> the decision is entirely up to userspace.
> 
> In Television (and Youtube) streaming, the GOP size is just fixed, and you deal
> with it. In fact, I never seen GOP or picture pattern being modified by the rate
> control. In general, the high end rate controls will follow an HRD
> specification. The rate controls will require information that represent
> constraints, this is not limited to the rate. In H.264/HEVC, the level and
> profile will play a role. But you could also add the VBV size and probably more.
> I have never read the HRD specification completely.
> 
> In cable streaming notably, the RC job is to monitor the about of bits over a
> period of time (the window). This window is defined by the streaming hardware
> buffering capabilities. Best at this point is to start reading through HRD
> specifications, and open source rate control implementation (notably x264).
> 
> I think overall, we can live with adding hints were needed, and if the gop
> information is appropriate hint, then we can just reuse the existing control.
> 
Why we still care about GOP here. Hardware have no idea about GOP at 
all. Although in codec likes HEVC, IDR and intra pictures's nalu header 
is different, there is not different in the hardware coding 
configration. NALU header is generated by the userspace usually.

While future encoding would regard the current encoded picture as an IDR 
is completed decided by the userspace.
>>
>>>> Leaving GOP management to the kernel-side implies having it decide which frame
>>>> should be IDR, I or P (and B for encoders that can support it), while keeping
>>>> the possibility to request a keyframe (IDR) and configure GOP size. Now it seems
>>>> to me that this is already a good balance between giving userspace a decent
>>>> level of control while not having to specify the frame type explicitly for each
>>>> frame or maintain a GOP in userspace.
>>>
>>> My expectation for stateless encoder is to have to specify the frame type and
>>> the associate references if the type requires it.
> 
> Ack. For us, this is also why we would require requests (unlike statful
> encoder), as we have per frame information to carry, and requests explicitly
> attach the information to the frame.
> 
>>>
>>>>
>>>> Requesting the frame type explicitly seems more fragile as many situations will
>>>> be invalid (e.g. requesting a P frame at the beginning of the stream, etc) and
>>>> it generally requires userspace to know a lot about what the codec assumptions
>>>> are. Also for B frames the decision would need to be consistent with the fact
>>>> that a following frame (in display order) would need to be submitted earlier
>>>> than the current frame and inform the kernel so that the picture order count
>>>> (display order indication) can be maintained. This is not impossible or out of
>>>> reach, but it brings a lot of complexity for little advantage.
>>>
>>> We have had a lot more consistent results over the last decade with stateless
>>> hardware codecs in contrast to stateful where we endup with wide variation in
>>> behaviour. This applies to Chromium, GStreamer and any active users of VA
>>> encoders really. I'm strongly in favour for stateless reference API out of the
>>> Linux kernel.
>>
>> Okay I understand the lower level of control make it possible to get much better
>> results than opaque firmware-driven encoders and it would be a shame to not
>> leverage this possibility with an API that is too restrictive.
>>
>> However I do think it should be possible to operate the encoder without a lot
>> of codec-specific supporting code from userspace. This is also why I like having
>> kernel-side rate control (among other reasons).
> 
> Ack. We need a compromise here.
> 
> 
> [...]
> 
>>
>>>> The next topic of interest is reference management. It seems pretty clear that
>>>> the decision of whether a frame should be a reference or not always needs to be
>>>> taken when encoding that frame. In H.264 the nal_ref_idc slice header element
>>>> indicates whether a frame is marked as reference or not. IDR frames can
>>>> additionally be marked as long-term reference (if I understood correctly, the
>>>> frame will stay in the reference picture list until the next IDR frame).
>>>
>>> This is incorrect. Any frames can be marked as long term reference, it does not
>>> matter what type they are. From what I recall, marking of the long term in the
>>> bitstream is using a explicit IDX, so there is no specific rules on which one
>>> get evicted. Long term of course are limited as they occupy space in the DPB.
>>> Also, Each CODEC have different DPB semantic. For H.264, the DPB can run in two
>>> modes. The first is a simple fifo, in this case, any frame you encode and want
>>> to keep as reference is pushed into the DPB (which has a fixed size minus the
>>> long term). If full, the oldest frame is removed. It is not bound to IDR or GOP.
>>> Though, an IDR will implicitly cause the decoder to evict everything (including
>>> long term).
>>>
>>> The second mode uses the memory management commands. This is a series if
>>> instruction that the encoder can send to the decoder. The specification is quite
>>> complex, it is a common source of bugs in decoders and a place were stateless
>>> hardware codecs performs more consistently in general. Through the commands, the
>>> encoder ensure that the decoder dpb representation stay on sync.
>>
>> This is also what I understand from repeated reading of the spec and thanks for
>> the summary write-up!
>>
>> My assumption was that it would be preferable to operate in the simple fifo
>> mode since the memory management commands need to be added to the bitstream
>> headers and require coordination from the kernel. Like you said it seems complex
>> and error-prone.
>>
>> But maybe this mechanism could be used to allow any particular reference frame
>> configuration, opening the way for userspace to fully decide what the reference
>> buffer lists are? Also it would be good to know if such mechanisms are generally
>> present in codecs or if most of them have an implicit reference list that cannot
>> be modified.
> 
> Of course, the subject is much more relevant when there is encoders with more
> then 1 reference. But you are correct, what the commands do, is allow to change,
> add or remove any reference from the list (random modification), as long as they
> fit in the codec contraints (like the DPB size notably). This is the only way
> one can implement temporal SVC reference pattern, robust reference trees or RTP
> RPSI. Note that long term reference also exists, and are less complex then these
> commands.
> 

If we the userspace could manage the lifetime of reconstruction 
buffers(assignment, reference), we don't need a command here.

It is just a problem of how to design another request API control 
structure to select which buffers would be used for list0, list1.
> I this raises a big question, and I never checked how this worked with let's say
> VA. Shall we let the driver resolve the changes into commands (VP8 have
> something similar, while VP9 and AV1 are refresh flags, which are just trivial
> to compute). I believe I'll have to investigate this further.
> 
>>>
> [...]
> 
>>>> Addition information gathered:
>>>> - It seems likely that the Allwinner Video Engine only supports one reference
>>>>    frame. There's a register for specifying the rec buffer of a second one but
>>>>    I have never seen the proprietary blob use it. It might be as easy as
>>>>    specifying a non-zero address there but it might also be ignored or require
>>>>    some undocumented bit to use more than one reference. I haven't made any
>>>>    attempt at using it yet.
>>>
>>> There is something in that fact that makes me think of Hantro H1. Hantro H1 also
>>> have a second reference, but non one ever use it. We have on our todo to
>>> actually give this a look.
>>
>> Having looked at both register layouts, I would tend to think both designs
>> are distinct. It's still unclear where Allwinner's video engine comes from:
>> perhaps they made it in-house, perhaps some obscure Chinese design house made it
>> for them or it could be known hardware with a modified register layout.
> 
> Ack,
>>
>> I would also be interested to know if the H1 can do more than one reference!
> 
>  From what we have in our pretty thin documentation, references are being
> "searched" for fuzzy match and motion. So when you pass 2 references to the
> encoder, then the encoder will search equally in both. I suspect it does a lot
> more then that, and saves some information in the auxiliary buffers that exist
> per reference, but this isn't documented and I'm not specialized enough really.
> 
>  From usage perspective, all you have to do is give it access to the references
> picture data (reconstructed image and auxiliary data). The result is compressed
> macroblock data that may refer to these. We don't really know if it is used, but
> we do assume it is and place it in the reference list. This is of course normal
> thing to do, specially when using a reference fifo.
> 
> In theory, you could implement multiple reference with a HW that only supports
> 1. A technique could be to compress the image multiple time, and keep the "best"
> one for the current configuration. Though, a proper multi-pass encoder would
> avoid the bandwidth overhead of compressing and writing the temporary result.
> 
>>
>>>> - Contrary to what I said after Andrzej's talk at EOSS, most Allwinner platforms
>>>>    do not support VP8 encode (despite Allwinner's proprietary blob having an
>>>>    API for it). The only platform that advertises it is the A80 and this might
>>>>    actually be a VP8-only Hantro H1. It seems that the API they developed in the
>>>>    library stuck around even if no other platform can use it.
>>>
>>> Thanks for letting us know. Our assumption is that a second hardware design is
>>> unlikely as Google was giving it for free to any hardware makers that wanted it.
>>>
>>>>
>>>> Sorry for the long email again, I'm trying to be a bit more explanatory than
>>>> just giving some bare conclusions that I drew on my own.
>>>>
>>>> What do you think about these ideas?
>>>
>>> In general, we diverge on the direction we want the interface to be. What you
>>> seem to describe now is just a normal stateful encoder interface with everything
>>> needed to drive the stateless hardware implemented in the Linux kernel. There is
>>> no parsing or other unsafety in encoders, so I don't have a strict no-go
>>> argument for that, but for me, it means much more complex drivers and lesser
>>> flexibility. The VA model have been working great for us in the past, giving us
>>> the ability to implement new feature, or even slightly of spec features. While,
>>> the Linux kernel might not be the right place for these experimental methods.
>>
>> VA seems too low-level for our case here, as it seems to expect full control
>> over more or less each bitstream parameter that will be produced.
>>
>> I think we have to find some middle-ground that is not as limiting as stateful
>> encoders but not as low-level as VA.
>>
>>> Personally, I would rather discuss around your uAPI RFC though, I think a lot of
>>> other devs here would like to see what you have drafted.
>>
>> Hehe I wish I had some advanced proposal here but my implementation is quite
>> simplified compared to what we have to plan for mainline.
> 
> No worries, let's do that later then. On our side, we have similar limitation,
> since we have to have something working before we can spend more time in turning
> it into something upstream. So we have "something" for VP8, we'll do "something"
> for H.264, from there we should be able to iterate. But having the opportunity
> to iterate over a more capable hardware would clearly help understand the bigger
> picture.
> 
> cheers,
> Nicolas

-- 
Hsia-Jun(Randy) Li
