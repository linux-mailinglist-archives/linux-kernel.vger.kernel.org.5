Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4788778E973
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245260AbjHaJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHaJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:32:44 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E8194;
        Thu, 31 Aug 2023 02:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq1kMJHs5Nox3F/1qM4X5QO12DznxztbdG0JIlwlFkDEkaXHlGdz/WDRSdngqk0je3pZONlFtWlEjksL0zB2s1zZT+7htIe7YD/uQCsN1ktFDTmjjjZ7SPzhIomLNFf9elbrLa7w/E7SO32/qgUYjQqQb+Zj/PNI28eZFIojfRF0aq2kBOaqdFKd1aUv73KYyn/zZTOiPKARpnc4ZaxXKjzFi3YsOZY5EK+AUIbDaYx6lclqTINi2tGR76eooJZm/3t/+EwT5LorzFWf8WkYXRmQOG7ol5Q8K69rTNdw6n0Iy6S2jEq5tlv4X+daGA8YmEB/HbdbHTw8UkjMV3+YYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKWJMduiRC4y2ewoK46urdz0v0zInnKUEHxNINOAY1U=;
 b=BCRDIi21IFC68trTCuzi8XFnM8mNf/JKkh8sElyVb/dOEtP5HWZd3xEK76rx36Dc5tnX5Q/Oxi6gq4tJi4zYi4wQ//kovqW+oIAZVXKNf4zm7Nh1RAXpFcHJdduvfCGVrpxXTYV7tVzBGfh0Vefe0MOE93tcnkOM9T8cdTdAUezQjL6KCePAc0RGq4/da0ywkhtK4Yp7f9cvYmVQzVwWXxWZ0gebaYCpQkFGc8KmCBAj8zb8UaRVS5/HmUs9XoAVLkmyk6P+BcuIr2TBWu/pQqihGFO+nAIqL/E6jTtQ7H9GL0+nlaOiva96vXz8oD0CsqoYKdyQSK2GENWzME/OWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKWJMduiRC4y2ewoK46urdz0v0zInnKUEHxNINOAY1U=;
 b=Dqii9H0tzq/3PpUAPp21R31EAXHWNl1cBijOK/xtZ8Eyy77bJZ/VRHX6TXju7X4Qr9ftRql6TLYdjGDuMyNeay44E+Ip1YI1t5baPQXiPexVLrEX5J1Bs7zPR4/sRKSQLUn05W9hbmcvXklatUYQ7g8jSK2q+tHDehLuMq6q+O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SN7PR03MB7231.namprd03.prod.outlook.com (2603:10b6:806:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 09:32:39 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 09:32:38 +0000
Message-ID: <250358e5-d6bb-1941-8d93-023531626145@synaptics.com>
Date:   Thu, 31 Aug 2023 17:32:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        ayaka <ayaka@soulik.info>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
 <ZNaVQ-zxIuCpGGha@aptenodytes>
 <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
 <39270c5e-24ab-8ff6-d925-7718b1fef3c4@synaptics.com>
 <a0fa6559c3933a5a4c8b7502282adae3429e0b57.camel@collabora.com>
 <52e9b710-5011-656b-aebf-8d57e6496ddd@synaptics.com>
 <e5b416f54fb18363c88813ab3240e6f9c48081f9.camel@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <e5b416f54fb18363c88813ab3240e6f9c48081f9.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SN7PR03MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bedecc-1489-49d7-2907-08dbaa05375b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fx+2tA3OADwyQEFYwRhWGFVALrepfk1Gu9kvoAZb65MQORedXfLHLXnm/09wWxE2xO99p4EyEpFI+56bnfAgSsA1ZhYKb//pw26kCDhnfDrhoyXqBwpdlPfZZVr57NHcIBtu+lE5KIO5kNafUmaAUyIZOWaoluYovIIf6WfYVjvLdUViP8QiAclQfLx8oKZp69GRMMqjROAKRX6mxR5fNFGnOiipdOtu/ziqYReiQqtxXkgEsiJ7fV4lsvBacm+3lCOO22a9ss71ZlBTzEF/XZx+wh7atE22IEMJ0021dE2fbtzTPbS/fIuditFLmq3C25dYBAVbldv+5z34BgVppDQ2wedeQrWTrj2ngmNxF2j2u9ISNtDukrClFCXKt7UzWQXqrWYGM851hjzsudPyqnzcs0OWsX9rSuNVvCiIO/8hxyWznzPxFC84lRYt2DkpU0u8f8eAKAS/Xs64ljJjC7BTUJbHq+7E/AsvZwfzGavrFH0Ytp/6FVW3z3fp9kva3nPM/1zxGq3r77lBgZltizrSUqvvtV7SJFBDAxlC5PN6rhOReCg+FopAYFA2Q9qJrjF+kpC1pxewMzAebAkuZ+Yx+u9Nt6NRlAS76+bEpvrbv2o+bab9O6DlJ1bQ/V95+SkEd+Y6YB54CRsHu1UHYPGCdBH1qAv6UYGfQ3npxUBo7l+XHx3ki+W2/hVKb9rj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(66574015)(41300700001)(8936002)(66556008)(8676002)(4326008)(66476007)(478600001)(6666004)(66946007)(6916009)(316002)(6512007)(2616005)(6486002)(6506007)(53546011)(54906003)(52116002)(26005)(2906002)(38350700002)(38100700002)(5660300002)(31696002)(7416002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXFKU09iL1FnaFJ6VldmN1Jqa2N4NmN5ekg1aXZYQWpQT3c0ZC9pZDhWWFRy?=
 =?utf-8?B?TzlqdVFFR2tIdHEyd0FNb2JOQlMrVzEzeWJiZExWZlhVZHVGWUVvNkMwYzk2?=
 =?utf-8?B?R3pNRXhuSlI5L2Y1N2RQUnVZQ0VDbHhlMm4vd3BZUmh6WS90cE16a0REc1pS?=
 =?utf-8?B?aW5OdDR3RkJqSXdWTWJ6Uk04SjYwS0ZhT2UrdUtYSDFQMVJ6YjkrZmZhU21Z?=
 =?utf-8?B?akZrTm9xbWVLVVBFWERqLzdWMUpjamtEQ1NoeVhLZVlkeTRXbnFvcTB0a1ZE?=
 =?utf-8?B?Mll5cCtSbndscGN2aXdrYjdpNzlZRk9YZlBnZkVqTi9iNHdFSmJIUVBTK1Jk?=
 =?utf-8?B?bkZqcEd3UTZUREY1ck5DdWJ2RGJSWVN0N0wzQkhsVzlDUktEZVJkeEI0UUdL?=
 =?utf-8?B?MWk4NkVTRkVXT1JVSS84NkcrRDQxcWR2b2U2ejNYTmlDZTdWSUNKYkhtb29t?=
 =?utf-8?B?TlZZNWhiZkFHYmxGQVBpdHJJaE0xdVMxSHZBbHozMXNqTGtDSTUwcDJkU1ht?=
 =?utf-8?B?NnFUWVAvNG9MZG9Pbkp3bzRMV25xUkhTeUtDNUVnUWlzNHBVbk9sYlVqUEZO?=
 =?utf-8?B?OUZTRVl5QW9SaDlRM0NFOWFiLysvNStpUUlBRXd2T1JBck0wZHFsR2k5OE9P?=
 =?utf-8?B?MzNVRVJXalhGR1hyRzQ5citjMHA0NEowMnU1ZnllTUNYbVFvamhtb0ZsVXZ0?=
 =?utf-8?B?dnBZdXh0TmlsblJPanMxV291clpldmg5d09rbDBLU21RdWNEWjcvSGk2L3Nz?=
 =?utf-8?B?d1A4NVNJZmdiSGpCYUxVUG5YUVlQdGs4K0pGSEhNaXNkV0pXWGlpTDR5NFZW?=
 =?utf-8?B?M1ViblRxdmNNZUxOYUIrV09oZytpOUFON1k1TzdodFJuS3ovV2xtVXVEK1hs?=
 =?utf-8?B?ZXh3YWhleHBrL2VyK1JIbUxJNHZ4Y1Y3bFJ1RXVVN1JDNFJrZEFJWnBaV2Yy?=
 =?utf-8?B?b3J4OEp4M3J6SVZBZGZyMnVsUVNGL0RXc0xRaDNFV3dxTDByUXVTb25kT1ds?=
 =?utf-8?B?dEtIK2dvdUIycnZHT05kYlJSYUxCaHFCSUNucmdFVUowekJvWXVHTkxyMUg3?=
 =?utf-8?B?RnhuQjNaSEdvSk9xaURrNFYrSytBMEhLV2hyYlVoREphZzVlRnFzZmpIMXQ3?=
 =?utf-8?B?dUtQT3lVS0ZUdFFhZy9JeGlBbGRBRDl3bjExbXlEM21SdFpVUW9kR2xWVnRx?=
 =?utf-8?B?U3dINGpzb2g3VWloNGxBWWtsTEhnRWRxcmd5OW50VDhYUHViWmFmTXdJSHFT?=
 =?utf-8?B?d3FNQXViL1RpVGxvVUpZM3VIYkdVTnRGbzVBM0l6WTdTdGMvYThSRWM2QlM3?=
 =?utf-8?B?ZUxzbWJoQVFvdUtXVWJWSk1KSEJSajNWbkM1R0xUa2RuMGxkU2lzelorWEcx?=
 =?utf-8?B?Ti85a253RWtXQkp6NmxIMTRyRmd2WUNUeVVIZVR1dHBVcFh3UVZOanRseDdx?=
 =?utf-8?B?T0VhbFRUZkI3MFNXMC9oekN2TTB0T2ZSL1dvVXFmUE8zaFllN3o2Q214bjl2?=
 =?utf-8?B?VHdTZmRwRzBicElDa0p6djZZQkJZaDN3UGI0TnczL2hYOUJqMGpacWVVcnlG?=
 =?utf-8?B?UDN3OEMvZTdDdFdZdXlkd0JiQ1FTeFJrQ1JIT0dxYnVQeFZHbG05REdDMkNN?=
 =?utf-8?B?Mzl2RUFzR01wNUpERUlhOStCSUk5dmhKSVh4WXBHM2sxaCtLNkVuV1JpVHNM?=
 =?utf-8?B?Z0RKTXU3Q3RnMmwyWlFSazJqN0RwaWg0ZGd6VWpxQUxuN3M0UmpPem9ReUJ5?=
 =?utf-8?B?dCt1Yit0dU1pQVRid28xb2dvYTJYTlh0V0tTQ2hEc1RQNTJSTTZOUzVDRmhU?=
 =?utf-8?B?T1NlNEg1azhYWnY0Tjk4ai9rdWVVd3VxRG5TZHc1RGwwVnJ0T2tqbE44UTVX?=
 =?utf-8?B?VWltQXM2eW40blZZbUFXSXVMeXYzKzY4c2tqcDJFVi96Ni90T3pMTDVWQUht?=
 =?utf-8?B?Qm9IUWp5WkJhRnZtQ0twUy9oUFdvdkVPR1ZuWGw0d3p5MDNBMk0venB5Umx2?=
 =?utf-8?B?KzN6K1VyM0s0YmJhWk5rWDVScjNMK3VaR0pPdVFUUGYvc0IzeTdUVVRZMkt5?=
 =?utf-8?B?UjJzMzc0WjRHcEhQOHVjN2xkN1BVU1FDd0lVT05KVEdxZ2JiTllmOXU4UG0r?=
 =?utf-8?Q?odpdM5A4CjeYB4Gn0plWLafl6?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bedecc-1489-49d7-2907-08dbaa05375b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:32:38.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIqm29bbaVb5oFV7LDlJUDWvqjxM6/q2zyM9bHVfad7zK3nf4SVgXnYDAHmuDo8Y+MEaLuVhK1Ekn46UciArgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7231
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 23:18, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le mercredi 23 août 2023 à 11:04 +0800, Hsia-Jun Li a écrit :
>>> It was suggested so far to leave h264 slice headers writing to the driver. This
>>> is motivated by H264 slice header not being byte aligned in size, so the
>> H.264, H.265 has the byte_alignment() in nalu. You don't need skip bits
>> feature which could be found in H1.
> 
> As you said so, I rechecked the H.264 grammar.
> 
> ...
>    slice_header( )
>    slice_data( )
> ...
> 
> There is lot of variable size items in the slice_header() syntax and no padding
> bits. And no padding at the start of any of the slice_data types. So no, the
> slice_header() syntax in H.264 is not byte aligned like you are claiming here.
> Its important to be super accurate about these things, as it will cause errors
> to be made. Please always double check.
To make a summary of the IRC.
H.264 and VP8 have no such alignment to byte padding bits.
While H.265 has that in 7.3.6.1 General slice segment header syntax.
Also, from 6.1 Frame syntax of AV1, I think frame_header_obu contains 
all the thing that software should prepare for a stateless encoder.
VP9 also has the trailing_bits() after uncompressed_header() (6.1
Frame syntax) would meet the byte alignment.

We may suggest we could use the hardware write-back or write offset bit 
functions which could be widely existed due the non-alignment bitstream 
syntax of the H.264 and VP8.

With such a hardware capability, we could save a cache operation than 
doing that in the kernel.
> 
> Nicolas

-- 
Hsia-Jun(Randy) Li
