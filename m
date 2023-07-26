Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC97628DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGZCtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGZCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:49:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A1193;
        Tue, 25 Jul 2023 19:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za5yMn9+Tnpl/h1GlhpC23YZ1mZUKge8bu9fh7aIp+FtlnQ+gCVgkBjzuOVk6cJCmhjoHdcZosezafBjW82zwpAKYd/w9wRsXH1Wq5nzjrcL7hAY1S9T21wHtEEkBol0ZuyRiZLbOi+xyEYDShKmoP9Em32kRo/9vk52xhl8y6uXFw7jPGtlxLRgU9lADPuHt1JsWxegQIC3zIbAfLshj4TfCESTqNkAJKGTXIcNPAdn+xFbbopNdbFkZlzeD5rRKVrj/wpRdqPT38WIYTqjRX22X8J9OJO/lbtBy8tDbTy+EIA7JDPVIRiSQYbYwZBZqybnMrHuH8+lMIYMWD3KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdN1xxEgjQvw8HjG860Xw/kxeWnHQ4VxQeWsk8sOUw0=;
 b=QKXcNnl+PR31IyPPn6Ky2d2uIvpGnX2cG6dL0h31wt4TLehseppKY/m97CCXBvPzosqbQheQqjdSJxbq96zoKlSD2GCNqNaps8juyWi75h4n30iPkpRlVdHq6iqLDRIs7nS4fGgnyi4YtGEg4LLVkUq8gX4TQBKIRYEROnv+JBoADHwCvQqx3zVPrt4WMD+93K6V1OinBsRO470HGc9B3+ESB2icXD1N+mbYz2rCQm4kK5liWLzqLlihqK/suIlHXBZDuDdLw1dNrn9egs95YkD7FwJNe/Ys7FLD/TygYXFb+uTbqiTfs+za2sVtvUp4hE42Mmi/ezdyXbALwGwzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdN1xxEgjQvw8HjG860Xw/kxeWnHQ4VxQeWsk8sOUw0=;
 b=CxjD3efYuTINJFhITJVCvUAUjmuimRkZ1zzxt/P2iNXDuQeNfeiv3jQAIEGCEHfl2veoRmumlxcxozPY1HQA+JGHHNpYac8HhC5BvqdynTZFpkBI3RGergetkSWOGe0guq+0iCGfnH8CvB5SJ8GNP/fSpc+M2mR5yp0bNwjrvwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:49:39 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:49:38 +0000
Message-ID: <c15805b0-261b-114a-c29d-b63f00dd8da4@synaptics.com>
Date:   Wed, 26 Jul 2023 10:49:29 +0800
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
 <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
 <ZL-8yBhWWChKBDHM@aptenodytes>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <ZL-8yBhWWChKBDHM@aptenodytes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:510:325::24) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BN9PR03MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 331417df-3ba1-48af-1f00-08db8d82f3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBqgNe3MnFokTgRFYmDDE0yoftr0MlqLIBpji3NeNPUDUPt7A/rmowm4kwxLACkrGYLFXuuanI8S27TN6+BhW5wKWiytfL5byCQKisADiA8CCRvXuyMfPTnH0SEMPnogvRATbuNZ2yyAs8Bu3jmaaysjziKiiLiAsBiTW6WlFmuiTIw3l0rb7hTJ83nkBz6tZixmCTlkxQWM+5yyxJdA0wgqDBasqEL8hw4vGdZ5VfmhrNeIki4q+CvtPm3/4zSkYMD13odhEAZtkYUsdFq2nsw9ehJLEeDlNVQs6gcoONMYeP4K7vctXG8Nl8obvStTsibUKYvSSLDytkeoFoMiqVOAAUJR68myZvftAPmTbj9cdQVWwx/noHztRnCma5U4EfbjfbF4RZt8bKYVNSTY8k4ljeLpmsgBW0hYBKc80U7MDVxA1AVJOafWRvJNFXJKHB0fBQCtr6W9ZcfiVDHVB/+ske9kLxCEPb7R4e5iVgSZuH40HsSOzhYpVIlboEcx8fZG05BQGoRXdo/mHV2wDnlwM0SIlkZ81htupgIjw/DRs5MHDD1Ax0kYbL1XjIKXCB5fS/ew4yQK/h7bmJS2hRX1Y10qgxXTsJSHXi7Lm5366gjS7iKK/aufQxoxn0qGoqfQ9flbFm5nhwWqoaXnb76/lW783ZrdvN4sCsBHaoqn/aL1nbDHEI74ZszXfd5vsQfbX24C/wW+83YGAY267A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(966005)(6512007)(52116002)(66899021)(31686004)(186003)(2616005)(6506007)(26005)(53546011)(66476007)(41300700001)(316002)(38350700002)(36756003)(6486002)(66556008)(5660300002)(7416002)(30864003)(38100700002)(8936002)(6916009)(66946007)(8676002)(4326008)(2906002)(66574015)(83380400001)(31696002)(86362001)(54906003)(478600001)(6666004)(45980500001)(43740500002)(240264003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzN0SldVYW9pNVEwMSs4d1E3K0NYd0hnVHNpUmtFajRURjRNVHBJbnQvcURa?=
 =?utf-8?B?R1YyR3VJQUJYa0duY1FZZVFlV3ZiNU9nL2tma2lpdmh3S0sxYnl4bWU3dUc4?=
 =?utf-8?B?UlZTY3ZyMVdWeDFBWGJNOWYzWEJtUXVXaWk1RHBWVjFWOUY4NTk0aER3SU8x?=
 =?utf-8?B?Z3JUT1ZKbFBjb3F2b1ZYU3V5SG11ay9CR3JTVmZHd0xaK1VOL1dYL1A3Zlgx?=
 =?utf-8?B?UkUyNmhJT21uUGNzT3ZIQnUvMjl2SWYxWUVFc1FDVWZVbWN6cStkdkFsSUxR?=
 =?utf-8?B?cnUxaTY4aE41cGdXRmJKNFVqcHFJVVdYelROaEhCSGJRUzRFRGU1dkZxOXFV?=
 =?utf-8?B?aHQ3ZVlPRHIvMGZ6Yk01VE1mVnY2cUszZkQrRFhGUUQxVDJyY0FJeTBNM3FW?=
 =?utf-8?B?QTVFYWJsL1dNRzdCS0dyTWljeDdxa2JFUmQ3L096YlJFa3krUVNaYi84MGZD?=
 =?utf-8?B?ak9OTXpBemd3ckN3RURsTThzNExrakczYUg3REc5a2NIVWppVU01UUd5ckJW?=
 =?utf-8?B?NzlRL1VRTllJb3JsS1Z1RDM2TkFMUlF0amxKY1FJb2dQOVF2ak1icjN2QkY4?=
 =?utf-8?B?NFZsaEM2UWVyK01saHBCUS81N2lKa0xNQlp6YVk5REN1eFhFRXVPVkdHTXAw?=
 =?utf-8?B?OC9CeDJKenBFMmxVWExvRzdscitLWU9jKzJVTzJOek1mSmxBNnJod3ZOZVlR?=
 =?utf-8?B?b1prWTNEbXAveUplc2llUWJSMlA1U0llWEpxOERWemFKczdSVnJpdjFRaHhE?=
 =?utf-8?B?U3JkQjc1RERtV1VkNURucDJySlVxWnVWZmpqbm5keW1GL2YvVjhTV1NBLzZE?=
 =?utf-8?B?UmVyUzJEbWR3WmZERkVJUUp5UVA4RVB5ZHFibUx2N2tFS1l1REEyTURMSnVk?=
 =?utf-8?B?dUkwZW5XcnQ0Znlab0Q5WkJzYlB1Z1RSM2M0SE82d0xYdENnQVp0ZXVFWkZs?=
 =?utf-8?B?VXozenQvUE9tcVRFTkhScXdERmhHWTU3RzFoRHBVZjhlVW5PeStlcWtVUVpW?=
 =?utf-8?B?TzB5MnR3MUx3aWo1bEUvb3JucHRKRmNreVIyVUV2OVM2RkR3VjFRNGlLck9S?=
 =?utf-8?B?VUlSeGpQaXI3K1UxV3NSS3ZmK05wUUV0bSt3T2NsdnJmb1hWZzlSNmJwamhv?=
 =?utf-8?B?QzJLT1FQRkpBSmRMTGhlakx2TS8xSUlITHFGeWN1alpqNXUwV0pubzQ1TnFu?=
 =?utf-8?B?OE9Cclk3aWRRQ2hubVkzOUNTWDFlVmVubTJIandDdFFQZnpoR1VxUlpWWDYr?=
 =?utf-8?B?QkVDZ002TnNQMnNGc09kNWcxK2RJYzQ2cVFnb0Rjc1BVdEFkWGdNOUtRQlBO?=
 =?utf-8?B?V091S3VvMmtoT3hZSlh4SGlUQ1h4UDRjbFFRZkxJZ2dDYTdVdFJrKzF0N2Jq?=
 =?utf-8?B?SzdxZ09PMVNtWUVvcUZLU2ZrbjJxMk1KZlJ4YkdDVjNYaXNGRmtVcHN1dHNG?=
 =?utf-8?B?RmJEK0VpQmx3K2tsL0piVDUrU2lSUmI1ZmVzcFpSVFNLV1BUVFMya0ZtWWl6?=
 =?utf-8?B?RGxVR1BReWdwY0wrYnRscFZKL0JLdWlsZklucDh6ZUJIRCt6Yy9LWUFwMWdm?=
 =?utf-8?B?RjY0N0JHMytaMFdpUWsvWTJSeng5aFJNRVZjYWRxSHV0dURXRFpxRHk1U0NT?=
 =?utf-8?B?THBBczhkNmV4MElIWHRqdW0vRUxqKy83V3FWQ1B0Q1JRS2svTXRXT3pSWE9q?=
 =?utf-8?B?dXNjVWVxK3lncFdkeXM2UkxmZkNYOWgweFNqKzlLUkFGbmEzVk5TUnFlQUIr?=
 =?utf-8?B?Vnc3ampaWlMvTUtMcmlRN0xKOHZjWnI2NzZRQjBDSEl6NmF4UWh6b05oYjA4?=
 =?utf-8?B?STkxZW9MdUNMenNqZ3dHU3Y4TllKbW9RYVpydElyeUIwSGZVbVh2bHgvR25K?=
 =?utf-8?B?YWhudEhyMXMrZ2svVk14bkNkQmE3bzNWa2NVREo4VUZibVdxdVhPYWl0SEw0?=
 =?utf-8?B?WG90blJydytOaWFUSTNsbmcxZWltL092aEVBU01Ya3N6WkhlaUI0VXlzOU1N?=
 =?utf-8?B?TUZxS00rb1hKenl3OEZIc2w0T0RZSGhYK3FqalpGSUM3TjhUeTlDK3UraGZP?=
 =?utf-8?B?YUFqSDVMUzdoSWkramRoNm1SMFJ5bW9vak13ZXpWcVE1ZkJvNlE5TWdjeERv?=
 =?utf-8?Q?cU/CMpey+TeVjaACpdn2lSF1T?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331417df-3ba1-48af-1f00-08db8d82f3bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:49:38.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEx6zbZ7wh2stKrVPIGSrXKsIokLIthI2magh4dpmv5O1DASmTEw1XyGmGVigBA0IEeicS+WR0KgmLr3Vcztwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6204
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 20:15, Paul Kocialkowski wrote:
> Subject:
> Re: Stateless Encoding uAPI Discussion and Proposal
> From:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Date:
> 7/25/23, 20:15
> 
> To:
> Hsia-Jun Li <Randy.Li@synaptics.com>
> CC:
> linux-kernel@vger.kernel.org, Nicolas Dufresne 
> <nicolas.dufresne@collabora.com>, linux-media@vger.kernel.org, Hans 
> Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, 
> Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Michael Tretter 
> <m.tretter@pengutronix.de>, Jernej Škrabec <jernej.skrabec@gmail.com>, 
> Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>, 
> Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> 
> Hey,
> 
> Long time, good to see you are still around and interested in these topics 😄
> 
> On Tue 25 Jul 23, 11:33, Hsia-Jun Li wrote:
>> On 7/12/23 22:07, Paul Kocialkowski wrote:
>>> Hi Nicolas,
>>>
>>> Thanks for the quick reply!
>>>
>>> On Tue 11 Jul 23, 14:18, Nicolas Dufresne wrote:
>>>> Le mardi 11 juillet 2023 à 19:12 +0200, Paul Kocialkowski a écrit :
>>>>> Hi everyone!
>>>>>
>>>>> After various discussions following Andrzej's talk at EOSS, feedback from the
>>>>> Media Summit (which I could not attend unfortunately) and various direct
>>>>> discussions, I have compiled some thoughts and ideas about stateless encoders
>>>>> support with various proposals. This is the result of a few years of interest
>>>>> in the topic, after working on a PoC for the Hantro H1 using the hantro driver,
>>>>> which turned out to have numerous design issues.
>>>>>
>>>>> I am now working on a H.264 encoder driver for Allwinner platforms (currently
>>>>> focusing on the V3/V3s), which already provides some usable bitstream and will
>>>>> be published soon.
>>>>>
>>>>> This is a very long email where I've tried to split things into distinct topics
>>>>> and explain a few concepts to make sure everyone is on the same page.
>>>>>
>>>>> # Bitstream Headers
>>>>>
>>>>> Stateless encoders typically do not generate all the bitstream headers and
>>>>> sometimes no header at all (e.g. Allwinner encoder does not even produce slice
>>>>> headers). There's often some hardware block that makes bit-level writing to the
>>>>> destination buffer easier (deals with alignment, etc).
>>>>>
>>>>> The values of the bitstream headers must be in line with how the compressed
>>>>> data bitstream is generated and generally follow the codec specification.
>>>>> Some encoders might allow configuring all the fields found in the headers,
>>>>> others may only allow configuring a few or have specific constraints regarding
>>>>> which values are allowed.
>>>>>
>>>>> As a result, we cannot expect that any given encoder is able to produce frames
>>>>> for any set of headers. Reporting related constraints and limitations (beyond
>>>>> profile/level) seems quite difficult and error-prone.
>>>>>
>>>>> So it seems that keeping header generation in-kernel only (close to where the
>>>>> hardware is actually configured) is the safest approach.
>>>> This seems to match with what happened with the Hantro VP8 proof of concept. The
>>>> encoder does not produce the frame header, but also, it produces 2 encoded
>>>> buffers which cannot be made contiguous at the hardware level. This notion of
>>>> plane in coded data wasn't something that blended well with the rest of the API
>>>> and we didn't want to copy in the kernel while the userspace would also be
>>>> forced to copy to align the headers. Our conclusion was that it was best to
>>>> generate the headers and copy both segment before delivering to userspace. I
>>>> suspect this type of situation will be quite common.
>>> Makes sense! I guess the same will need to be done for Hantro H1 H.264 encoding
>>> (in my PoC the software-generated headers were crafted in userspace and didn't
>>> have to be part of the same buffer as the coded data).
>> We just need a method to indicate where the hardware could write its slice
>> data or compressed frame.
>> While we would decided which frame that the current frame should refer, the
>> (some) hardware may discard our decision, which reference picture set would
>> use less bits. Unless the codec supports a fill up method, it could lead to
>> a gap between header and frame data.
> I think I would need a bit more context to understand this case, especially
> what the hardware could decide to discard.
> 
I known the Hantro can't do this. While such design is not unusal. HW 
could tell we can't CU that we could do inter predict from one previous 
reconstruction frame, then it is not necessary to have it in its RPS.
> My understanding is that the VP8 encoder needs to write part of the header
> separately from the coded data and uses distinct address registers for the two.
I don't think Hantro H1 would do that.
> So the approach is to move the hw-generated headers and coded data before
> returning to userspace.
> 
>>>>> # Codec Features
>>>>>
>>>>> Codecs have many variable features that can be enabled or not and specific
>>>>> configuration fields that can take various values. There is usually some
>>>>> top-level indication of profile/level that restricts what can be used.
>>>>>
>>>>> This is a very similar situation to stateful encoding, where codec-specific
>>>>> controls are used to report and set profile/level and configure these aspects.
>>>>> A particularly nice thing about it is that we can reuse these existing controls
>>>>> and add new ones in the future for features that are not yet covered.
>>>>>
>>>>> This approach feels more flexible than designing new structures with a selected
>>>>> set of parameters (that could match the existing controls) for each codec.
>>>> Though, reading more into this emails, we still have a fair amount of controls
>>>> to design and add, probably some compound controls too ?
>>> Yeah definitely. My point here is merely that we should reuse existing control
>>> for general codec features, but I don't think we'll get around introducing new
>>> ones for stateless-specific parts.
>>>
>> Things likes profile, level or tiers could be reused. It make no sense to
>> expose those vendor special feature.
>> Besides, profile, level or tiers are usually stored in the sequence header
>> or uncompressed header, hardware doesn't care about that.
>>
>> I think we should go with the vendor registers buffer way that I always
>> said. There are many encoding tools that a codec offer, variants of hardware
>> may not support or use them all. The context switching between userspace and
>> kernel would drive you mad for so many controls.
> I am strongly against this approach, instead I think we need to keep all
> vendor-specific parts in the kernel driver and provide a clean unified userspace
> API.
> 
We are driving away vendor participation. Besides, the current design is 
a performance bottleneck.
> Also I think V4L2 has way to set multiple controls at once, so the
> userspace/kernel context switching is rather minimal and within reasonable
> expectations. Of course it will never be as efficient as userspace mapping the
> hardware registers in virtual memory but there are so many problems with this
> approach that it's really not worth it.
> 
I am not talking about mapping the register to the userspace.
The userspace would generate a register set for the current frame, while 
the kernel should fill that register set with buffer address and trigger 
the hardware to apply the register.

Generating a register set from control or even fill partial slice header 
cost many resources.

And what we try to define may not fit for real hardware design, you 
could only cover the most of hardwares would require but not vendor 
didn't have to follow that. Besides, codec spec could be updated even 
after it has been released for a while.

>>>>> # Reference and Reconstruction Management
>>>>>
>>>>> With stateless encoding, we need to tell the hardware which frames need to be
>>>>> used as references for encoding the current frame and make sure we have the
>>>>> these references available as decoded frames in memory.
>>>>>
>>>>> Regardless of references, stateless encoders typically need some memory space to
>>>>> write the decoded (known as reconstructed) frame while it's being encoded.
>>>>>
>>>>> One question here is how many slots for decoded pictures should be allocated
>>>>> by the driver when starting to stream. There is usually a maximum number of
>>>>> reference frames that can be used at a time, although perhaps there is a use
>>>>> case to keeping more around and alternative between them for future references.
>>>>>
>>>>> Another question is how the driver should keep track of which frame will be used
>>>>> as a reference in the future and which one can be evicted from the pool of
>>>>> decoded pictures if it's not going to be used anymore.
>>>>>
>>>>> A restrictive approach would be to let the driver alone manage that, similarly
>>>>> to how stateful encoders behave. However it might provide extra flexibility
>>>>> (and memory gain) to allow userspace to configure the maximum number of possible
>>>>> reference frames. In that case it becomes necessary to indicate if a given
>>>>> frame will be used as a reference in the future (maybe using a buffer flag)
>>>>> and to indicate which previous reference frames (probably to be identified with
>>>>> the matching output buffer's timestamp) should be used for the current encode.
>>>>> This could be done with a new dedicated control (as a variable-sized array of
>>>>> timestamps). Note that userspace would have to update it for every frame or the
>>>>> reference frames will remain the same for future encodes.
>>>>>
>>>>> The driver will then make sure to keep the reconstructed buffer around, in one
>>>>> of the slots. When there's no slot left, the driver will drop the oldest
>>>>> reference it has (maybe with a bounce buffer to still allow it to be used as a
>>>>> reference for the current encode).
>>>>>
>>>>> With this behavior defined in the uAPI spec, userspace will also be able to
>>>>> keep track of which previous frame is no longer allowed as a reference.
>>>> If we want, we could mirror the stateless decoders here. During the decoding, we
>>>> pass a "dpb" or a reference list, which represent all the active references.
>>>> These do not have to be used by the current frame, but the driver is allowed to
>>>> use this list to cleanup and free unused memory (or reuse in case it has a fixed
>>>> slot model, like mtk vcodec).
>>>>
>>>> On top of this, we add a list of references to be used for producing the current
>>>> frame. Usually, the picture references are indices into the dpb/reference list
>>>> of timestamp. This makes validation easier.  We'll have to define how many
>>>> reference can be used I think since unlike decoders, encoders don't have to
>>>> fully implement levels and profiles.
>>> So that would be a very explicit description instead of expecting drivers to
>>> do the maintainance and userspace to figure out which frame was evicted from
>>> the list. So yeah this feels more robust!
>>>
>>> Regarding the number of reference frames, I think we need to specify both
>>> how many references can be used at a time (number of hardware slots) and how
>>> many total references can be in the reference list (number of rec buffers to
>>> keep around).
>>>
>>> We could also decide that making the current frame part of the global reference
>>> list is a way to indicate that its reconstruction buffer must be kept around,
>>> or we could have a separate way to indicate that. I lean towards the former
>>> since it would put all reference-related things in one place and avoid coming
>>> up with a new buffer flag or such.
>>>
>>> Also we would probably still need to do some validation driver-side to make
>>> sure that userspace doesn't put references in the list that were not marked
>>> as such when encoded (and for which the reconstruction buffer may have been
>>> recycled already).
>>>
>> DPB is the only thing we need to decide any API here under the vendor
>> registers buffer way. We need the driver to translate the buffer reference
>> to the address that hardware could use and in its right registers.
>>
>> The major problem is how to export the reconstruction buffer which was
>> hidden for many years.
>> This could be disccused in the other thread like V4L2 ext buffer api.
> Following my previous point, I am also strongly against exposing the
> reconstruction buffer to userspace.
> 
Android hates peoploe allocating a huge of memory without 
userspace's(Android's core system) awareness.

Whether a reconstruction frame would be used for long term reference(or 
golden frame) is complete up to userspace decision. For example, when we 
encoding a part of SVC layer 1, we may not reference to a frame in layer 
0, should we let the hardware discard that? Later, we may decide to 
refernce it again.

Besides, I don't like the timetstamp way to refer a buffer here, one 
input graphics buffer could produce multiple reconstruction buffer(with 
different coding options), which is common for SVC case.
>>>>> # Frame Types
>>>>>
>>>>> Stateless encoder drivers will typically instruct the hardware to encode either
>>>>> an intra-coded or an inter-coded frame. While a stream composed only of a single
>>>>> intra-coded frame followed by only inter-coded frames is possible, it's
>>>>> generally not desirable as it is not very robust against data loss and makes
>>>>> seeking difficult.
>>>> Let's avoid this generalization in our document and design. In RTP streaming,
>>>> like WebRTP or SIP, it is desirable to use open GOP (with nothing else then P
>>>> frames all the time, except the very first one). The FORCE_KEY_FRAME is meant to
>>>> allow handling RTP PLI (and other similar feedback). Its quite rare an
>>>> application would mix close GOP and FORCE_KEY_FRAME, but its allowed though.
>>>> What I've seen the most, is the FORCE_KEY_FRAME would just start a new GOP,
>>>> following size and period from this new point.
>>> Okay fair enough, thanks for the details!
>>>
>>>>> As a result, the frame type is usually decided based on a given GOP size
>>>>> (the frequency at which a new intra-coded frame is produced) while intra-coded
>>>>> frames can be explicitly requested upon request. Stateful encoders implement
>>>>> these through dedicated controls:
>>>>> - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
>>>>> - V4L2_CID_MPEG_VIDEO_GOP_SIZE
>>>>> - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
>>>>>
>>>>> It seems that reusing them would be possible, which would let the driver decide
>>>>> of the particular frame type.
>>>>>
>>>>> However it makes the reference frame management a bit trickier since reference
>>>>> frames might be requested from userspace for a frame that ends up being
>>>>> intra-coded. We can either allow this and silently ignore the info or expect
>>>>> that userspace keeps track of the GOP index and not send references on the first
>>>>> frame.
>>>>>
>>>>> In some codecs, there's also a notion of barrier key-frames (IDR frames in
>>>>> H.264) that strictly forbid using any past reference beyond the frame.
>>>>> There seems to be an assumption that the GOP start uses this kind of frame
>>>>> (and not any intra-coded frame), while the force key frame control does not
>>>>> particularly specify it.
>>>>>
>>>>> In that case we should flush the list of references and userspace should no
>>>>> longer provide references to them for future frames. This puts a requirement on
>>>>> userspace to keep track of GOP start in order to know when to flush its
>>>>> reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, but this
>>>>> could also indicate a general intra-coded frame that is not a barrier.
>>>>>
>>>>> So another possibility would be for userspace to explicitly indicate which
>>>>> frame type to use (in a codec-specific way) and act accordingly, leaving any
>>>>> notion of GOP up to userspace. I feel like this might be the easiest approach
>>>>> while giving an extra degree of control to userspace.
>>>> I also lean toward this approach ...
>>>>
>>>>> # Rate Control
>>>>>
>>>>> Another important feature of encoders is the ability to control the amount of
>>>>> data produced following different rate control strategies. Stateful encoders
>>>>> typically do this in-firmware and expose controls for selecting the strategy
>>>>> and associated targets.
>>>>>
>>>>> It seems desirable to support both automatic and manual rate-control to
>>>>> userspace.
>>>>>
>>>>> Automatic control would be implemented kernel-side (with algos possibly shared
>>>>> across drivers) and reuse existing stateful controls. The advantage is
>>>>> simplicity (userspace does not need to carry its own rate-control
>>>>> implementation) and to ensure that there is a built-in mechanism for common
>>>>> strategies available for every driver (no mandatory dependency on a proprietary
>>>>> userspace stack). There may also be extra statistics or controls available to
>>>>> the driver that allow finer-grain control.
>>>> Though not controlling the GOP (or no gop) might require a bit more work on
>>>> driver side. Today, we do have queues of request, queues of buffer etc. But it
>>>> is still quite difficult to do lookahead these queues. That is only useful if
>>>> rate control algorithm can use future frame type (like keyframe) to make
>>>> decisions. That could be me pushing to far here though.
>>> Yes I agree the interaction between userspace GOP control and kernel-side
>>> rate-contrly might be quite tricky without any indication of what the next frame
>>> types will be.
>>>
>>> Maybe we could only allow explicit frame type configuration when using manual
>>> rate-control and have kernel-side GOP management when in-kernel rc is used
>>> (and we can allow it with manual rate-control too). I like having this option
>>> because it allows for simple userspace implementations.
>>>
>>> Note that this could perhaps also be added as an optional feature
>>> for stateful encoders since some of them seem to be able to instruct the
>>> firmware what frame type to use (in addition to directly controlling QP).
>>> There's also a good chance that this feature is not available when using
>>> a firmware-backed rc algorithm.
>>>
>>>>> Manual control allows userspace to get creative and requires the ability to set
>>>>> the quantization parameter (QP) directly for each frame (controls are already
>>>>> as many stateful encoders also support it).
>>>>>
>>>>> # Regions of Interest
>>>>>
>>>>> Regions of interest (ROIs) allow specifying sub-regions of the frame that should
>>>>> be prioritized for quality. Stateless encoders typically support a limited
>>>>> number and allow setting specific QP values for these regions.
>>>>>
>>>>> While the QP value should be used directly in manual rate-control, we probably
>>>>> want to have some "level of importance" setting for kernel-side rate-control,
>>>>> along with the dimensions/position of each ROI. This could be expressed with
>>>>> a new structure containing all these elements and presented as a variable-sized
>>>>> array control with as many elements as the hardware can support.
>>>> Do you see any difference in ROI for stateful and stateless ? This looks like a
>>>> feature we could combined. Also, ROI exist for cameras too, I'd probably try and
>>>> keep them separate though.
>>> I feel like the stateful/stateless behavior should be the same, so that could be
>>> a shared control too. Also we could use a QP delta which would apply to both
>>> manual and in-kernel rate-control, but maybe that's too low-level in the latter
>>> case (not very obvious when a relevant delta could be when userspace has no idea
>>> of the current frame-wide QP value).
>>>
>>>> This is a very good overview of the hard work ahead of us. Looking forward on
>>>> this journey and your Allwinner driver.
>>> Thanks a lot for your input!
>>>
>>> Honestly I was expecting that it would be more difficult than decoding, but it
>>> turns out it might not be the case.
>>>
>> Such rate control or quailty report would be complete vendor special.
>>
>> We just need a method that let driver report those encoding statistic to the
>> userspace.
> Returning the encoded bitstream size is perfectly generic and available to
> every encoder. Maybe we could also return some average QP value since that
> seems quite common. Other than that the rest should be kept in-kernel so we
> can have a generic API.
> 
You just throw the tools that a hardware could offer away.
> Also it seems that the Hantro H1 specific mechanism (checkpoint-based) is not
> necessarily a lot better than regular QP-wide settings.
> 
Macroblock level QP control in Hantro H1 is very useful. For FOSS, those 
vendor special statistic or controlling may not be necessary, while the 
real product is not simple.
> Cheers,
> 
> Paul
> 
> -- Paul Kocialkowski, Bootlin Embedded Linux and kernel engineering 
> https://bootlin.com
> 

-- 
Hsia-Jun(Randy) Li
