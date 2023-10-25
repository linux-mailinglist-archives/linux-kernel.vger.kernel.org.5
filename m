Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD047D6CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjJYNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjJYNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:12:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D9111;
        Wed, 25 Oct 2023 06:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESjOixrF8xE1o4innKiLS3NeyOFmiEeJai1UE+U5VJSxQzI5EqUqvmYzSfzSoMHxRCRy1YyqcPpM9dj8gE3XKQkPy9vecUnHYnQmvp4zl1uOKaWiohVXoUmmEXLVrwX0e8XS8iFQJnD+kPGNV+mQB0VGixl1hnGY9IL0DKA6eP1KnH0INPNLo8KSg+EWCK+n0nzDZ+SSHVIsVFiY0L3vLV1A8l7GuxWZKMBf1znU4ppEAA1CApwEEJtd0wpsxDtr5tfjGWBAxRYBGs2wwncmpOJBmYDfCMglk0XbeIn/rT8jQcOswJh2blB1YwWlnY2+Ja8M9G2998AtjoU+NGyNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO/wvLvFgZOSltfJzlHYVZYZLacswJX1nlYq9Kqiud0=;
 b=cBdjmrcirvVq8qRkTEOr62FEC8fvPrdcNivx3FCNAEGpTK4dtXhla/7vRk18tMBAdiJvkfCYOFL7qnHh9p+BJRpyTaYD3TVoswsUlpIPYMKzbJJzQ5/kN5eQzwFe4Woj8NvPaaacM58Q56VWkJ2ntxMTO2Yv6FQywPyYZVX2VXIecqgU489sRwG/iGgMyDXdUAfWGBr8RRzhpfwa6aETGHlHxoEMgApj4/nVKNcfVIR5SwUQquil486tzuLvQhAcQCMyOI0Yjr6RRbo+IVq5Vv+N3DFEwBELwK1vZfPKxk5iyKNkz2gepQDxblPS4UY9AOCQQjHYrgHoTZ3CFnONBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO/wvLvFgZOSltfJzlHYVZYZLacswJX1nlYq9Kqiud0=;
 b=Ull6uLCTK31eQOzC51UhOlDFH0kaDEcelkxNC7e1q+PnX8h+vyVOlXBmOefKInNahKuopFIABPR8pWmYwhnLVLnPOS9DQaBE0xhPiQRlJV42EaUaGCA+mfEsB80UMqiOWkI2XpCLVQAXTrlDDaj1wow2AIstfCKrwgvlA74Qhv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB8408.eurprd08.prod.outlook.com (2603:10a6:20b:55b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 13:12:06 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:12:06 +0000
Message-ID: <fcad0e6b-e12d-42a6-b2a3-97f5f0aa3afa@wolfvision.net>
Date:   Wed, 25 Oct 2023 15:12:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <ZTFMR7PlcQXpeoQO@aptenodytes>
 <11cccad3-e665-41dc-89c2-5ddc22b1e2fe@wolfvision.net>
 <ZTjVOAPnXEj9LgOE@aptenodytes>
 <5438a194-7349-4a20-84d0-efe88b7ab396@wolfvision.net>
 <ZTjl0xJMTqZfO2Xf@aptenodytes> <ZTjvBgxtMh1YZbYm@pc-70.home>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZTjvBgxtMh1YZbYm@pc-70.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f20195c-f24f-4b3f-f73e-08dbd55bfcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndP2Uk1unDU8aBJG2S1R6D8TWxiIRt3nBwFt54evUA6CqwQmFz1TuMIAn5Ck5eekrHj0RrY4ZDapWNIU0X1lxQMSPU4lNh196ijXAME6ncCIJYJkvzS1d0kJWI7D3Hi3O9GyPBaS+KZohxLRQlFc6BYFrhGVLHkWK45F8oIuyiRXxUfIESj3EJnz2qhwb/uJ7y7QKa5tv8Us7nIh0c0abOwtTSGCNhgQjObA/Qm/wQrhi5G54034z6O7YX1S5PiqJHWjJEV2q0cvUobPkl+IOG3fnj3zu82Pd4EKVHs2GaIiB0waWHBfa20ManRZxM7nmLnsBUM84RgFFhgmG8Y4ehwll94wq/TT86tTrNZX7lTvunBGlc5HH/9RCwfpfg8wxRShd32sJGK+Q+dv/7reLad27npnaX/P3LQUgeEb8dWSt/2FX/HnLl/7kqEB2Y7z5OAh83Lx7KeNrVkXWTKWle+4kZ6fniNLuwNbwxMLYtAK2JF3RAl6Ao7tmldZaHrxaN9JOBH8iEZahJVdKwXNIVZnWqmgohFAWbJjm2ws8nZZWmD7kg5vcguzunEwaZ2l+2L8B6U43zvS4CgdSwuP6o5Em2DhtQpx26FVRxQPYv7LbYHEwEwp+Vdjil0Z9s8J8lXs76wanOwc/8xvGo6TiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(44832011)(2906002)(86362001)(38100700002)(41300700001)(6666004)(2616005)(66946007)(66556008)(478600001)(6506007)(110136005)(36916002)(53546011)(6486002)(6512007)(316002)(83380400001)(66476007)(31696002)(5660300002)(36756003)(4326008)(8676002)(7416002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEp1SUVOYlJ4Zk1wdE1WMG1vcW5BZnREcVdmSjhLUEdycVhDV0RwcGNkUUNC?=
 =?utf-8?B?S3dqUjhVZXZaSGxMVzhhMUFTaXl2QjAyM0htc1FKeUVzTzJnMXdSWDg3ajdE?=
 =?utf-8?B?bWliV0JGY28raWNvQ2xJdnF2Q1FMV1lUQTY1T0p1MXB0emUweERjMXJEayto?=
 =?utf-8?B?MTVvOFJXVmEwbEhFNWlVcFVRM3Ezc0p5aDJRcnpNa09FOUIvSkJidnljTW9a?=
 =?utf-8?B?SUhoS3dhSHlIeWpvTEpRVXlFdVdTSFdicGc5YmNzcDBRcWVxWXV6YVA5SkRr?=
 =?utf-8?B?dzZ2ZnhZcWlzODYrc2xnb3FOUDdCZHBMaVRZb05GRmdsNzA5MkdYaWduU3Yw?=
 =?utf-8?B?UlBuMlc1UFVyTTVWYm5Db2JWOG50c2ZrV2NVWG5UMi9sd2lXbWlwbnp3d200?=
 =?utf-8?B?OHhzazd5VzBtMXRTVVg3UWhoeTJhTFdzSmU3UkFrRUE3SkE2MWU1NWVRQnhX?=
 =?utf-8?B?VnA2SkFya2VCdWs5TEl0eHZlZVc5Q25MY0FMQzRDamF3TWZ0VUFITEVwMmRx?=
 =?utf-8?B?WXY3aEp4dkh5ZHRKN1p1bXFERXAvdmlqM2txR0VGRE84WE1oWCtOb2hBVFZq?=
 =?utf-8?B?TlVST1JhN3g3UzBlcHM2TlUvWEoxUlJncUg1czl4T0JFVllmYUZVL1IzVHp1?=
 =?utf-8?B?dEhDcWcxa0hubElLL00xM0hTdEdmR1pEVVdyaVVueTluM2xCWFdKMWNIdE5m?=
 =?utf-8?B?WHBqeDFoRVY3c2VKL3VHL1pIVk9PUHZ4Z1pqRmNiQ3dzK3lwYlpuRm1Mb3g5?=
 =?utf-8?B?bnovV1A5aFVzWlN6ZktBaVBkNSsySVBzMGU3OVJLUFJVUHk0djM3dVNxbXUy?=
 =?utf-8?B?VXVDZTdCM0hXSnR3Z2crb3cyR3hRVGRWMlZoRy8xSFEyUmhlUENSSTFGeS91?=
 =?utf-8?B?OUZ0ZkdxUkVtRmNEZGFYb0lrTkJKMnRRcDlZWXNPN3ZlQWhEUjR1STdtelg0?=
 =?utf-8?B?M01IQWMwMEZwcWZ5dnFIclFMTTZyemR1aUhteTBOZ0xVamdMNWtyV1h3TzR0?=
 =?utf-8?B?d2pxdUdmak1xdDdOR1FrMGdLU3pxVEc2UVRrV0FQNlExR1VkY1l1QjBlMlBz?=
 =?utf-8?B?Y0syZlZiRE9JbGxUU2lndmd5Z20va0F0cmJ1d05PdDh6K2VKanVON0U3djdS?=
 =?utf-8?B?NE02akY4dFIvU1NwckJRZEFLTnp2d1FCNWhkS0tFNUV5bGowM1loZ0piNjhk?=
 =?utf-8?B?aitwYmN5NTFCbFdidTZockNuOGVaNjY2aklQQUFaeUY3elNnZ25TVitBTEVh?=
 =?utf-8?B?ZWtnVnBJUlNDeXU4UHI0ZjJQZHNnRmgzUnFOeW1EdlZIUGR2MXpjTHlveXpx?=
 =?utf-8?B?aTdUbHB3M3pSbmdpaDhZU3RJRkJERFcvZTFYcnBYQnVZUzg5azFienRNeUQz?=
 =?utf-8?B?aHhhWXBPemtRS2FQbE9NazZPR3lscGJHbER3YXdsU2R2R2xvdk5kOW5KdnVz?=
 =?utf-8?B?Vm9WMkJwVDdsbXlPb3FmMVE4MEsvcEZSejV2RXBKdGtNRlNZdmRhWlBmYjA5?=
 =?utf-8?B?SGM2dTBRaWVRNXBsYXE5QzVNeTMrWEhEZGkrdGlYTE8yTzZkOTZyWkIzQXRl?=
 =?utf-8?B?NlQvcm1td2Jma1J0dUFtLzd2SVRvbDk1M25GM3JsWE9VSTZuaXRUVlVPT3Rh?=
 =?utf-8?B?VFp1MVNORm45bmJDRzhpbHV2YVJKSHhCV2tNbnY2ZWpOQVJNSm1ET3FUc0VY?=
 =?utf-8?B?eWMyVmQvd2Y3TGlxZkl1NjBXbERUZk10Yzk3TzhiVEFvblhxdUtwQnRVSVRs?=
 =?utf-8?B?OFVaRG16SUc3QzNpb0FsQ3RYQTlPNTRMUEk0N09pRlZjakoycDZya3dOa29q?=
 =?utf-8?B?STRCWXhlOVhuYXJVTGFHUXF5b2x1d3FCd3gwRWVhRlk2SFJka1ppSDN5QXNB?=
 =?utf-8?B?cmh2N2R1bWFLcnNoSWFFejc4OTBYUmlmeXMrM2dBTVJhVlZQS2tudnB0SWt2?=
 =?utf-8?B?ckNxVTN3VWZOb2JmSExZMXo5b3dGaHVLaTQ3dFBYWFdLWDdVRWw4UXRDdXNE?=
 =?utf-8?B?aTdpeHg3T0RDWDRvTDhqczlvNWZmZTlsdS9ROXBDUHI2WFBTQmFZV0lQL3cw?=
 =?utf-8?B?ZzA3WmRsSFRwdHc4dnRvT1lPc21Uc0x4Z3paYVF2QWFvVTdTbHlQNjN1bXYv?=
 =?utf-8?B?UWlZaFJST2haM1RXdEp5bWpneERNSFFFbTBXUjFZeVdIb0laQmpZZ3JDa1Mx?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f20195c-f24f-4b3f-f73e-08dbd55bfcb0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 13:12:06.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERUYb1rsIEzPUi4MeD5kxwvd8zeKWhAo8BZYITD2h4366ODX2cxRb7VyobTcSaHusQAndcvO5S3k4JbAp/7HMsHHsYHCvWpJxPyJt/CTcgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

On 10/25/23 12:33, Mehdi Djait wrote:
> Hi Paul, Hi Michael
> 
> On Wed, Oct 25, 2023 at 11:54:27AM +0200, Paul Kocialkowski wrote:
>> Michael,
>>
>> On Wed 25 Oct 23, 11:17, Michael Riesch wrote:
>>> Hi Paul,
>>>
>>> On 10/25/23 10:43, Paul Kocialkowski wrote:
>>>> [...]
>>>>>> Here is the detail of my research on the concerned chips. The + at the beginning
>>>>>> of the line indicate support in Rockchip's 4.4 tree:
>>>>>>
>>>>>> - RK3566/RK3568 (2020): CIF pins + VICAP terminology
>>>>>> + RK1808 (2019): CIF pins + VIP registers + VIP_MIPI registers
>>>>>> + PX30 (2017): VIP pins + VIP registers
>>>>>> + RK3328 (2017): CIF pins + VIP terminology
>>>>>> - RK3326 (2017): CIF pins + VIP terminology
>>>>>> - RK3399 (2016): CIF pins
>>>>>> - RK3368 (2015): CIF pins
>>>>>> - PX2 (2014-11): CIF pins + CIF registers
>>>>>> + RK3126/RK3128 (2014-10): CIF pins + registers
>>>>>> + RK3288 (2014-05): CIF pins + VIP terminology
>>>>>> - RK3026 (2013): CIF pins + CIF registers
>>>>>> - RK3168/RK3188/PX3 (2012): CIF pins + CIF registers
>>>>>> - RK3066 (2012): CIF pins + CIF registers
>>>>>>
>>>>>> Note that there are a few variations over time (added/removed registers), but
>>>>>> the offsets of crucial registers are always the same, so we can safely
>>>>>> assume this is the same unit in different generations.
>>>>>>
>>>>>> Since the RK3066 is the first model starting the RK30 lineup I think we can
>>>>>> safely use that for the "base" compatible to be used for e.g. the bindings
>>>>>> document, instead of px30 which is just one of the many SoCs that use this unit.
>>>>>
>>>>> Once the name of the driver is defined and adjusted in v9, I can try to
>>>>> give the series a shot on my RK3568 board. First attempts to do so
> 
> This sounds good!
> 
>>>>> basing on Maxime's v5 showed that with a few modifications the DVP
>>>>> feature works fine. In a subsequent step, we could discuss the inclusion
>>>>> of the MIPI CSI-2 things in order to keep the driver sufficiently general.
>>>>
>>>> Nice! I guess there will be a need to introduce a variant structure associated
>>>> to each compatible to express the differences betweens these different
>>>> generations.
>>>
>>> Indeed. If Mehdi and you suggest something, I'd be happy to review.
>>
>> Well the be honest the scope of work on our side is really centered on PX30
>> and merging this first version.
>>
>>> Otherwise, I'll try to come up with something reasonable. IMHO it would
>>> make sense (as a first step) to have the clocks and the resets in this
>>> structure, as well as a sub-structure that describes the DVP. The latter
>>> consists of registers mainly, but maybe supported input/output formats
>>> and other things should go in there as well. Also, downstream code has a
>>> significant number of
>>>     if (some condition including chip_id) A; else B;
>>> things that we should probably get rid of with this variant structure.
>>
>> Indeed I think we want to try avoid that. Another common option is to define
>> capability flags to represent differences between generations in a more
>> practical and clean way than explicitly checking chip ids or so.
>>
>>> As next step, a sub-structure for MIPI CSI-2 could be defined. RK356X
>>> will have one of those, RK3588 will feature even six of them. So we
>>> should add a const array to the variant structure.
>>>
>>>> Note that we will also probably need to convert the driver over to a MC-centric
>>>> approach, but this is of course outside of the scope of this series.
>>>
>>> That would absolutely make sense. What is missing, though? (I was
>>> wondering that the driver calls media_device_(un)register but no
>>> /dev/mediaX device pops up.)

Sorry, had a false memory of this. The media device *does* pop up.
>> Switching from video node-centric to MC-centric is more of a semantic change.
>> In the first case we expect that subdevs are configured by the video device
>> driver and userspace is not expected to change anything in the media topology
>> or to configure media entities explicitly.
>>
>> In the latter case it's the opposite : the driver should never try to push
>> configuration to a subdev and should instead validate that the current
>> configuration makes sense.
>>
>> Still, I believe should be a media device registered and visible to userspace.
>> Mehdi could you take a look at this? Do you see a media device in `media-ctl -p`
>> and /dev/mediaX?
> 
> Yes I do have a media device
> 
> media-ctl -p
> Media device information
> ------------------------
> driver          rockchip-cif
> model           rk_cif
> serial          
> bus info        platform:ff490000.video-capture
> hw revision     0x0
> driver version  6.6.0
> 
> Device topology
> - entity 1: rockchip_cif (1 pad, 1 link)
>             type Node subtype V4L flags 0
>             device node name /dev/video0
>         pad0: Sink
>                 <- "tw9900 2-0044":0 [ENABLED]
> 
> - entity 5: tw9900 2-0044 (1 pad, 1 link)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev0
>         pad0: Source
>                 [fmt:UYVY8_2X8/720x480 field:none colorspace:smpte170m xfer:709 ycbcr:601]
>                 -> "rockchip_cif":0 [ENABLED]
> 
>>
>> Cheers,
>>
>> Paul
>>
>>> Best regards,
>>> Michael
>>>
>>>>
>>>> Cheers,
>>>>
>>>> Paul
>>>>
>>>>> @Mehdi: If you could Cc: me when you send out v9 it'd be much appreciated.
> 
> Of course I will :)

Cool, thanks! Looking forward to it!

Best regards,
Michael

> 
> --
> Kind Regards
> Mehdi Djait
