Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF77EA04C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjKMPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjKMPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:41:38 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FA1980;
        Mon, 13 Nov 2023 07:41:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzUh3HVl6xnRZo6J6jBk6T4Vkijh/KTbFZl48oAkBmTdsz47755psnWQEQFhBth0402pAVFhQzLDxQ04CwRy+dpoHXR/2HEplvtz5S0rfFwr8YkuX+ClRM3ukvwCConSLDJ5Ni2p+nXFX2LvjcW67774SQi9aDXXtbdOQnXSCDXXUB4yLnaq9c7taF9CRQLP0lZEX18fhrjM04Iva5qU5vEZtdrL2kr/BGa4wjN6ixmhFa4GSb3+Qek0qplMxgXxmyGyp07gASR59ecTitfhx54Ymb+ywOI2VlnWOKgkdMR2VH9NSZlb3XSwaxXdJVxHq88dU4Rno1xoRMYCsxZp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TsJvQ3ytsUCQ9Hqqn6fAgnrh/AA00w/SzjqpsUWhE0=;
 b=Csa90tVVy33fxrJ9i2kXMuqloeRUG76sy1NyGSkW8WdxHr3Rm5Sps3WEca4MaCyLm3BB+1eG004nJXHFXcQPtkNahMbDSizfPhJO4WsIonbKWknNreo3OyKh583IGlSF0/q5mH+I8amTT75kBjpFirAZW4d4nq0s6afEl4uLH5qEkGUhGWq0ZGRmyi3sRoi5vgF9EidQNM1njvMKeLEA7x2HCLzpjZH//vido25+oAh0vobSV90+7UIo96la++j2SH7X24a7T++dMr4acdM12m6qLU/xJAgUtBWe8Mb1s3iiSQfBEKou9ElPNq+laHX0iUlzY16HRYmU4Ru2uHmZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TsJvQ3ytsUCQ9Hqqn6fAgnrh/AA00w/SzjqpsUWhE0=;
 b=qXFVf8DsSKAcxK6zEnJZWm2j4IoW3cYafBXmVIHBzQb6Gby8UNHH1wP58Q8Yti4WHmAplhUPVDR6Bxwl6lvhoATxaRPYAq6Baw2KV9HTkxzoAP+S8eF9pj3fUsGatTtPlile0IvT36Mo1vZGbV75p+zFzQVu7yCK4HpcWrf6VVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AM8PR08MB6337.eurprd08.prod.outlook.com (2603:10a6:20b:355::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:41:28 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 15:41:28 +0000
Message-ID: <602afcc8-e6e6-4214-b5bc-1330f0e7a954@wolfvision.net>
Date:   Mon, 13 Nov 2023 16:41:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
 <f817728d-6377-4fff-b8e8-ac0c652e5c29@wolfvision.net>
 <ZVIDPKIBLHHvgpE/@pc-70.home>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <ZVIDPKIBLHHvgpE/@pc-70.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AM8PR08MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e77338-125a-4958-b8b2-08dbe45f008c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH9bZ2cceQ44Qb1TvpZK7A8fOQPUG4yLp8w8e9l7sZ6JD4tbknwHq7i8A1K6EGChhlhKQedoOa3qjdDzlzvsS/uuL6tdfaqbpzw95Tkpwv8OFtNiJKDWm37nsCA2C3aHX6AbjslqPWxDXhu5BckdbTWgVfCR3FtkOLPAZ78WzpKc0qNsX3UL+lV7chllV9LfzDSHjYisjBNr3RrjhvhO0KMbUrA9bWfBS32x4+2fRZ7t3zMQB23alTIEZwcKcg3CcgdP6Kye3F1WLSQdnuWgpWgleKtszUAHiIAH7RCafEaNjcjeZwArZM9a2LY/iXndcK/ipz75ca6K2OSPN0hwqLd2ibu6u7sIjpF1AwVwfTEI6dixPfhv9ZsL4fAxTLUP4y9gBvPGDFTHPBnj+Tzmgo6vfdzUJ5QWZMLZLhtXWgh5xb+JOKKTcAOTDJ1+oJcv9jsEe7s1lkdYHiqdYKjWAOga6VORBYUDAGLzky4Qq8+YopWiqdBaiRix/6WZvHyIeQ6p6rs18tGV0NgL9ec4m58Br1LBoaPo8UoiwX4RspeRs75eFuWCVuOAJyiCQ4JHn09Tz7AarpEfKpkF64xOQZaqFKRu7fVGxymLt/q+4xtOpAD73NFcWU6LqTJzZVpNACT7MNzEUHdxACfm0wwXaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38100700002)(83380400001)(31696002)(86362001)(7416002)(5660300002)(2616005)(6512007)(6506007)(53546011)(31686004)(478600001)(6486002)(966005)(36756003)(66946007)(316002)(66476007)(6916009)(66556008)(8676002)(4326008)(8936002)(44832011)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZweTIycXpMQmFldExVVUVnRG03dFJUMG9sbm15WjhaNnJyTkVoNEZ0Z3hp?=
 =?utf-8?B?QVRPaDR3d2oyMWNCZTdVK3VXcjZEK0taemtuQVUzMTVabEpWOVN3M2w1Y3o0?=
 =?utf-8?B?cUt5ZFN4VTZNT0F4dnBBVVo0ckhGcGNuT3pzMnVvSzdLTTVYS0ViSHZHNEtn?=
 =?utf-8?B?b1l6NjlYditjSjZVWnFIeW9qQStRZWo0UFRFS2Y2dFJlY1NrNTZadVkxQVEy?=
 =?utf-8?B?dnhDNHdpOEhyTkRKQmRyZ3VVcFI1MURIeWN0S2dKQm9qbUtFNmVXeXVpUHZi?=
 =?utf-8?B?QjN6VjdVUWtPanVQR2JtYlY2N1JFL2h6VHZMUmpjdVJvR0pVSnZROGFEZUNT?=
 =?utf-8?B?Z3h4cURRS0l1eEw5WHRjc3JmQm4zalBaVzNBR3VJdU9IaUNCMVV4ZTQyMGVt?=
 =?utf-8?B?UGtycWxDZGlLdlpHMXlDd0d2YWJXeDBEZUFzOGJxRm16cXpMaGV4bDNiREV4?=
 =?utf-8?B?TzkzNnFoMk5zSFVGbDJxckc3SWxrb1Y0OENub2RWWjZ0Qnk4TmJwRTZOYTJT?=
 =?utf-8?B?UE5tVTdWNzdlMzE1VkxmN1dUd0NFVUxETXYrRFp2bXFlUXNkVi9xbWZIZU9x?=
 =?utf-8?B?TiszYVRPTGRENTJsajVBVURESTZKVlFYeURGT0JnVmpEZFdlWTE2YzRiRDdu?=
 =?utf-8?B?NjFVcnpoTVFuUzZubS9pbXJzV01UcnNmYmxEMll0Z2dSVTRDTCtDdnltUlV1?=
 =?utf-8?B?anBTVDRBVFlUbDlGbXdsQnZrNDVVVHowWk9CcSszWGxwVFJpQklZQ0RZU3Nl?=
 =?utf-8?B?Q0d3Wktob1gwd1hpQkI2RFhkamdSTWpOZFNMTCtkN3BrdkV4TGV3ZFR3aGl0?=
 =?utf-8?B?dG45UFl3bmljMUpIQnZlaDViRTUvdUYxVWNWUzMxa0VubDdJVFU0OVFRYVpz?=
 =?utf-8?B?dVFuN3NRL0xjNTI1U1ZXQ1MwRzFQbythQ0UwRTJoM0JLa0FDYzYxZi9iUnJh?=
 =?utf-8?B?dHdtK2lJcDdQTFhpK3QrOW9WdWlzWXE0RFgyVTNMNlg5amd4cFB2dWFnT1FY?=
 =?utf-8?B?TFEzV3EzZUEzMUVUQnpBUGJWS2MwVVc3MXY1ZFpxT0JzRk45YUtOR1VpYk5T?=
 =?utf-8?B?bm1SMExDemJjSDVscUMvN2Q4OFphS2J1MXExU3FkeGk0WEVZVkRrNFptL0w5?=
 =?utf-8?B?cnFoQTlxMitvc1dsMjVUV3hNSGZzekJ5WnRISlFaR3ZKaTgrZlBYYy9nekdx?=
 =?utf-8?B?cDhha1Z1Q0lSMUIyUEdpUjB6M0VSLzV5a0xCVXo5SXgwQTRDYUNyMS9aU0Jr?=
 =?utf-8?B?Z3FMTGZiTllaOVhjMVg3YUdoQStuSituZkcyYjBBSERwYkYvSW5LSlBvSkd6?=
 =?utf-8?B?SGNqMUpJUUd1RkVHTWdsSzBic3lXZlh1QmE4dk9FRHBFdlFhTS81Q3hjWEsy?=
 =?utf-8?B?SVA3WkhLNHhBSzFlWXFVU0JsZHZNaEovTlRMSFBPMytmaWE1NnFnQllnZEc4?=
 =?utf-8?B?NnV2QWZRZE5iQmtlT3Jzbk8yUUFBV2ttaXlSVTg2c1pGZ1lLazUxQVo5cEI4?=
 =?utf-8?B?YnZqUG1qcldYdC9GcjJGL1FvaWJMc3BUamczUTg2UWZCSEhjMjFwdFpIbEVJ?=
 =?utf-8?B?Q2VXd2pzL3JsbkVDTkdXa3FzdGpXK05kcWlGaG9iSkcrRlA0Mm51bEF2a04x?=
 =?utf-8?B?bS9IOXRUWHpaY0Q5VXNIOG5GakJCS3gya1BBYzVvUEpyTGhqS3hxdkhLMWhp?=
 =?utf-8?B?VnpLdmdYUndrRFhZeFlUQVBqMTRrOWdqVlgva3ZFYXB5eG95ZVhlcG1SS05i?=
 =?utf-8?B?RDdGSitPdGRFVFdaQmhBNm5uVjFPZjAya0dua1V4QUpuS3g2V3d2d1JPaDNu?=
 =?utf-8?B?QkVxRlhoQWxWQmlXM2ViVDVXSVhydVRCVlJxZkp5YXZWaVBDcWNhZVBLZGk4?=
 =?utf-8?B?anFSREpHLzBzeDU3VnRLUmsyZzlPc1Jic2UzSURKV1dTM0xMeUpvT2tNUStC?=
 =?utf-8?B?MENtTk1ydXhmd05hem5KbGxTc0d5eWFybGtzaWl5cjhyZXJkYVYvakE2M0Jh?=
 =?utf-8?B?ZCtiTStYV0ZwRFF2anp0NVozTlNXRGVPMnVvQnFsQlNPUVpUTWNIMjhEWTQ1?=
 =?utf-8?B?UzgreUZzeHRvQlc2bjlSbnJ0VkpTV1pjQkloTHQ4QiswenMrRndrV3F5ZENs?=
 =?utf-8?B?QXBHVWhZcjlDeXNSZStrUmkrWUNHTmhHRmp3QWZoMFUwTmt1dHBDWDlUU09V?=
 =?utf-8?B?WFJ6dkpWbHZpR0orWExSdENyQ29QcmVObWZUd3RwclNVMVJsdExuL2VKYTBx?=
 =?utf-8?Q?eVkp4egtGntQs9L3JfZfaRKNqFq+ElzlQJp79g1MdY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e77338-125a-4958-b8b2-08dbe45f008c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:41:28.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihjs1/lDyt3fhhy6einf1ArRFZcNUfo3Au15ZP+dD1SHf/a6B+2zS0p2Kh6ZbWMGhsiRfI4aiIQy2gAwQD4CaC7dpezn9qeoPuSqHgxSKrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

On 11/13/23 12:06, Mehdi Djait wrote:
> Hi Michael,
> 
> On Fri, Nov 10, 2023 at 01:50:01PM +0100, Michael Riesch wrote:
>> Hi Mehdi,
>>
>> Thanks for your patches.
>>
>> The good news first: with some hacks applied I was able to capture the
>> video stream from a HDMI receiver chip via BT.1120 on a Rockchip RK3568.
> 
> this is really cool!
> 
>>
>> As a next step, I'll clean up the hacky RK3568 support and submit them
>> for review.
>>
>> Still, there are some issues that needs to be addressed. Please find my
>> comments inline.
>>
>> On 11/8/23 17:38, Mehdi Djait wrote:
>>> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
>>>
>>> This controller supports multiple parallel interfaces, but for now only the
>>> BT.656 interface could be tested, hence it's the only one that's supported
>>> in the first version of this driver.
>>>
>>> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
>>> but for now it's only been tested on the PX30.
>>>
>>> CIF is implemented as a video node-centric driver.
>>>
>>> Most of this driver was written following the BSP driver from rockchip,
>>> removing the parts that either didn't fit correctly the guidelines, or that
>>> couldn't be tested.
>>>
>>> This basic version doesn't support cropping nor scaling and is only
>>> designed with one SDTV video decoder being attached to it at any time.
>>>
>>> This version uses the "pingpong" mode of the controller, which is a
>>> double-buffering mechanism.
>>>
>>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>>> +static const struct cif_input_fmt in_fmts[] = {
>>> +	{
>>> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
>>> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
>>> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
>>> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
>>
>> What is the point of this csi_fmt_val field? If the strategy is to kick
>> everything out that is not explicitly required then this should be
>> removed (and added at a later stage, if needed).
>>
> 
> I can remove this but I don't really see the harm of keeping this.
> It can even save some time for the person adding the support for CSI
> later.

IMHO removing it would be more consistent with your approach to kick
everything out that is not explicitly needed. I also think that this
approach is common practice.

>>> +		.fmt_type	= CIF_FMT_TYPE_YUV,
>>> +		.field		= V4L2_FIELD_NONE,
>>> +	}, {
>>> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
>>> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
>>> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
>>> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
>>> +		.fmt_type	= CIF_FMT_TYPE_YUV,
>>> +		.field		= V4L2_FIELD_INTERLACED,
>>> +	}, {
>>> +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
>>> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
>>> +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
>>> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
>>> +		.fmt_type	= CIF_FMT_TYPE_YUV,
>>> +		.field		= V4L2_FIELD_NONE,
>>
>> What is the difference between this entry (in_fmts[2]) and in_fmts[0]?
>> Similarly, between in_fmts[1] and in_fmts[3]?
>>
> 
> Between in_fmts[0] and in_fmts[2] is the order of Y U V components:
> 0 -> YUYV
> 2 -> YVYU
> 
> between in_fmts[1] and in_fmts[3]: the same thing:
> 1 -> YUYV
> 3 -> YVYU

Of course. Apparently I was staring at the code for too long. Sorry for
the noise.

> [...]
>>> +	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
>>> +		      CIF_FORMAT_INPUT_MODE_NTSC :
>>> +		      CIF_FORMAT_INPUT_MODE_PAL;
>>
>> This seems to be an oversimplification. How can one use BT.656 here?
> 
> I don't quite understand the question. This is used to configure the
> hardware, i.e., the INPUT_MODE of the format VIP_FOR
> 
> bits 4:2
> 
> INPUT_MODE Input mode:
> 
> 3'b000 : YUV
> 3'b010 : PAL
> 3'b011 : NTSC
> 3'b100 : RAW
> 3'b101 : JPEG
> 3'b110 : MIPI
> Other : invalid

OK, for the RK3568 VICAP the table reads

3'b000: BT601 YUV422
3'b010: BT656 YUV422
3'b100: BT601 RAW
3'b101: SONY RAW
3'b111: BT1120 YUV422
others: Reserved

The PX30 TRM states "Support CCIR656(PAL/NTSC) input" and I think
CCIR-656 equals ITU-R BT.656.

I think in the end the mbus format needs to be evaluated first. If it is
BT.656 AND if the subdevice supports TV standards, the decision between
PAL and NTSC can be made.

>> (Aren't you using BT.656 as mbus format between your video decoder and
>> the PX30 VIP?)
> 
> I look into this. I will probably need to add this.

I think it would help if your device tree example in the YAML
documentation contained the complete setup (vip + video decoder chip).

>> You should not assume that the remote is capable of any TV standards
>> (this statement holds for the driver in general).
>>
> 
> But this is the support I am adding right now, for cif with a SDTV
> decoder capable of TV standards. This statement will need to be 
> changed when support for sensors is added. 
> 
>>> +	mbus_flags = remote_info->mbus.bus.parallel.flags;
>>> +	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
>>> +			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
>>> +	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
>>> +			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
>>> +
>>> +	val = vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_val |
>>> +	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
>>> +void cif_set_default_format(struct cif_device *cif_dev)
>>> +{
>>> +	struct cif_stream *stream = &cif_dev->stream;
>>> +	struct v4l2_pix_format pix;
>>> +
>>> +	cif_dev->remote.std = V4L2_STD_NTSC;
>>
>> Not every subdevice supports TV standards. Is this really reasonable?
>>
> 
> For the support I am adding right now it is reasonable but for future
> support it needs to be changed.

OK then I guess I'll need to change that in my first batch of changes :-)

>>> +
>>> +	pix.pixelformat = V4L2_PIX_FMT_NV12;
>>> +	pix.width = CIF_DEFAULT_WIDTH;
>>> +	pix.height = CIF_DEFAULT_HEIGHT;
>>> +
>>> +	cif_set_fmt(stream, &pix);
>>> +}
>>> +
>>> +static int cif_enum_input(struct file *file, void *priv,
>>> +			  struct v4l2_input *input)
>>> +{
>>> +	struct cif_stream *stream = video_drvdata(file);
>>> +	struct v4l2_subdev *sd = stream->cifdev->remote.sd;
>>> +	int ret;
>>> +
>>> +	if (input->index > 0)
>>> +		return -EINVAL;
>>> +
>>> +	ret = v4l2_subdev_call(sd, video, g_input_status, &input->status);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	strscpy(input->name, "Camera", sizeof(input->name));
>>> +	input->type = V4L2_INPUT_TYPE_CAMERA;
>>
>> Wait, we are a camera in any case? How does this fit together with your
>> video decoder setup?
>>
> 
> Yes the video decoder is attached to a camera.
> 
> From the kernel documentation:
> https://docs.kernel.org/userspace-api/media/v4l/vidioc-enuminput.html?highlight=v4l2_input_type_camera
> --------------------------------------------------------------------------------
> V4L2_INPUT_TYPE_CAMERA
> Any non-tuner video input, for example Composite Video, S-Video, HDMI, camera
> sensor. The naming as _TYPE_CAMERA is historical, today we would have called it
> _TYPE_VIDEO.
> --------------------------------------------------------------------------------

Huh, learned something. Thanks for the pointer!

>>> +	input->std = stream->vdev.tvnorms;
>>> +	input->capabilities = V4L2_IN_CAP_STD;
>>
>> Not every subdevice supports TV standards. Is this really reasonable?
>>
> 
> see above answer.

OK. I think I can submit a series that makes the driver more general
based on your v11. Looking forward to that ;-)

Thanks and best regards,
Michael
