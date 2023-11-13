Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628477EA0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKMQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:05:23 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5C19F;
        Mon, 13 Nov 2023 08:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKQb0PM9/gM0DvzwImOHOpR23M3Ae5q/lZDt5H6UcPA7K7hGUM5e2ahIVnXYRWS1kuoW/rZA3j0H8I6CN45aYFhCbvhiv2MTJGRZ4pXbo5Bp0wn6FkjD3RAhdRSxbMte+JfmTIo/2okxDJq7+nXVTzVqILZcJGdVDtVYWsdRAUqRBUMbkzSzyES++PWv3kPyAyq/ZZjmG0BxqA6zozpaY7i0/wB2Sf8y2XiS2XdlUDnZLSkSw7VrpKw7EkdLxzFKyAHUFUqphbpV2mbH4kwqp3KEU/2SjtUeOiL3dfQIw8mhjzHMxgLpaUpxHYG7U9ZVzwtep4eub+ug3CoIOYMdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8jCYkD0oykyf9Ot8KtifOL+nfBZfyO/d6sGs+Nv6gk=;
 b=g1zWHeuirG94ykP8cjD6dN1gP0We+a38S+qBz8NG0XzSeqS9nKNKSwcf4s9o5q+MxXmZAaQy7CgI+rwFaci6yXkDca7oXH2NV1poMfXrZQ+Fr82NkIX2igBC9YCJ46B9l+S1HdxuITyHs9IG/g2IoSFtGrXum6FpX+4EDz7lkXHfYhXZPeuRCP3ujLIae2eZU9P/QQRECJ78A6IXXOvqBk9R2mPj/FUxud6AVwI1Xd8He9g+a2HV65RACibeQrrqevYDx9jmAGK9rkEm5hpdoDe3mDJ8Xvo+da5DgrraEKBS341zk6H7L/2M3/iLe1bnhugccd+7rHlBbF3kfkP0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8jCYkD0oykyf9Ot8KtifOL+nfBZfyO/d6sGs+Nv6gk=;
 b=HxFp0CoWclUWxP55ffP5ptsmX7YE5VrXtboPjL+DAlN9skG5AgVHeuqghU9dUS6UhpmreTRUbhLB7LsmhVNCtLvFN2u69JrQv4DEWk2AgIzRvqYPQVCVo/wdkCAIfkn9tO+9C/14UPtTPNYqxRrKOqtKO9KXC45MOTn/FMln1SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAXPR08MB6384.eurprd08.prod.outlook.com (2603:10a6:102:154::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 16:05:15 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 16:05:15 +0000
Message-ID: <c06b68f5-ac7c-46d4-bb81-dc1dbbee0b34@wolfvision.net>
Date:   Mon, 13 Nov 2023 17:05:12 +0100
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
 <4f9bc04b-81af-49ee-9818-d4cd281504e7@wolfvision.net>
 <ZVJAogJsTidx+Cg1@pc-70.home>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <ZVJAogJsTidx+Cg1@pc-70.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAXPR08MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b16bbaa-98c3-4857-73e2-08dbe46252e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F14v9si1V+kwzmqVsPC19fhAwc83dctO/Ke6Rg40Xid9nB1LQuwb6B3bnKtQmflruS4Exx2lOWKm+El+P+LxRhj5/i2T2a/0uk9YONYW6IRdusmQtZNwzTz108YaLa98Dr5lFa/yH4/22wQgeETfVD9tIKXriKkWVloDUoDE48flJRGyokWmxOMoYeDP/M5WmdvbAIqBl5JYDpXJ4RdGO0JplL9gdASgyX1s0hf8UyzeAw+dUsY70li6utZ7rMKYHdvsZYecoj/hJeiGxBuyC2m8ogYL6p3tb6SxHoRaEomB5orM2NMJXAv1GodMKJJD8zkoW88dbs7X/AlEy0bEzR6W9OKiw9WWronQiDPM0VWc8C5b28Ts4EbRv1fjVmG9duwagfh0LwczcpVPg8/7JNP5etNbYT5ttyoPsAPQMRuAAcN+6bghiHhExVzF5XmuAyRyTc9r5M8UdXEZecESE8888ywaZLTOZtIDUwEUJZjUNj4CERW+x9+f2shf3/NE+j4K99oUbbL0TLywAOsYqpUiuNFTA2o9IcNsWljG3Me5rawOk2jkkounxW5Rnbv3Oo1zLUwVpjE5EQox8E3RfyXkubn3VjDsRtyPRw2obnOXQHh4KzVLbD5FfIs+Ozkl6dtbgIK3S3EN7SsSIv+iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39850400004)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(66556008)(66946007)(6512007)(6916009)(66476007)(316002)(38100700002)(83380400001)(31686004)(36756003)(478600001)(6486002)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wit1VGh6eTZxU3FUWDJVM0F2dCthSmVIYTE3NEg0OHRJZUxKcDFkVlpOQ0Nz?=
 =?utf-8?B?eGdBTDNTSE1iVzFoVmh0UTJOaTRBVnlZeS8xSENLQzd2UWV4UUMxbU95QVht?=
 =?utf-8?B?aldxR0l5azBzWGNXeDV1V3N3ZlVabWtqMTFLZDRmTGxZYUVQT3ZSTFBSaVBG?=
 =?utf-8?B?NjJwLzlmOUZiU0dRM0FwTWcwbjFCUjVtRkdaQ0ZVaHhQeSt0QlVvbjZ1Yk1K?=
 =?utf-8?B?RnZUOTdLMnNEdHpNR0R4VDNINFRRSEtZcHVmVjJKZ1RaV3E4SDBHZFhwL2NJ?=
 =?utf-8?B?M2lCWHI4Q1V6d0NhRW44ZzljcWlSSWNUS2ZmbjNENzRqejF1ejBteWhyOVZG?=
 =?utf-8?B?UEM4eVZpcXJiSDllN3NnR1JtMGdHUzdZQ2l0cnRhS0pUSnpjUkVFQzA5cnow?=
 =?utf-8?B?VUhHcGxUMEViNW56d3VnMzhSZFpkOW9BK0RFcFpzTVduSUhSM2pFRVlTN1NG?=
 =?utf-8?B?YnNKR2dQcnBDOGtYMWZkWSsyMHdmRkxzUXowaHg5VDFraWJ6YjBON2x5bHJo?=
 =?utf-8?B?RWxJbmVBbFA3dEk3UnhYZHBKbHJSbGVTWUFmaCtSRXJhV1FFbWZic0dvYVpL?=
 =?utf-8?B?dk1kTE5pdFFxL0RTUS9EVXBrc2JXTEhaOFNrVU05Z0JHZTBhcXd0cWg4MWM5?=
 =?utf-8?B?VEhBK2wyS3pSdHpIZ3BTQ1g3dHVMWDhyZVJNNnJkOUV5eWVFZTNUVVV3eGM0?=
 =?utf-8?B?Zi93eFdRVG9laTZ6dk1VQkc1SXJVQzlzTGNWU293Q2hQRGZ4dW1RY0l5bEdq?=
 =?utf-8?B?c3NtRmxJdHVyZkhEekxVZnRmalk4MHpqSkt5MXBiaGRaT0xmOHhFL0dDaGFQ?=
 =?utf-8?B?alZWVlJjblFhcUx6TGRkcEhJRFhUK2lYTmc2dUhpdzFVU2RVSGhCWU13TTRx?=
 =?utf-8?B?NFAxcW1uT3VSSHZuMytIQ2crTVZ6UnRtS1pWc0JBMnVWSDh4VWtHY2tNdXJZ?=
 =?utf-8?B?QXZFdVlrOGdzOTIrT1dBT2locDQ1dDRwWW5BUUg2Nk9IKzdEbGFQWVBxYSty?=
 =?utf-8?B?QzJOVm5PRDVrYmdQRWVtM0lNUVJXQ3ZzN2kxQmk4WEhQc0lhaEZUL1J0UlVW?=
 =?utf-8?B?ZCtDcEdPTFMrYjNsdE1MeEs1cmxXeHB5Mm9vckdiNEtqSDh2cjNyVTFSTXZr?=
 =?utf-8?B?L3hxZnZ1L2FGYTFKZFdqS0NOd2wvVzRsRXBaaGsxR0d3YncxcjNZYzVkNmNa?=
 =?utf-8?B?cUdxTG9ndG1DcEtrd3E3Ymc0dzlxcWRWWVVlRkdZaCtJODdQTGtYY3RFM3NT?=
 =?utf-8?B?YVh3VGtFUi9yVVI5ckRxb3dYakdwbXJmbzZMaHI3NlV1OUJsUmRrbmwxSFRS?=
 =?utf-8?B?L1Q2MzVMeVkwZWdCcXdyREJ3elJKc3JlUGE2cFBDbXh3aFJGUytYdGRmUVRl?=
 =?utf-8?B?QjFCSUJ1L3lwSzQ0M214RnRVcEFDZnRjdTlsQlN4YlozM1lhTHdINnpEZzg1?=
 =?utf-8?B?K2dTM1UybkU3TUI0NDZVQXg1K1A2Vjd0VC9BVEdYemZnM0tNS3pYVWsrSGNz?=
 =?utf-8?B?eHNxK1BMTndCaytHSHlHUy9KRnFDMGp3dTVqNDhsZ1poVXNJV0hjWTh6LzhH?=
 =?utf-8?B?Wm96Zjh3L0U2U29pYUREQkJESUhqMFhkUWxJZ0NvQjF2bjZORFd1WEVZM1Bs?=
 =?utf-8?B?RmxzMGgrM2kzbFZCeko3bUVVeTZVcnI0NnRTdXF3YzVsTmE1bTM2RmRUcVNs?=
 =?utf-8?B?SjVnU2V6TWg3NGIweEVFeS9QNGNnNlZ3QWRxeFRHOFVwaUtPc2Z4M2IwbXFk?=
 =?utf-8?B?MDBIWTVHMTFPRGVUVHFZSHBpdVJWcnQ0UWVxek8rV3YyNWRRSnZQMm92WjM4?=
 =?utf-8?B?dGRvWmlXRDB3UmExbmtFcldDZW1JVm0wTndBSnNMcmdpUVNHd1A4TElFcFlF?=
 =?utf-8?B?dkF1UFd5RVhBMG1PUVRmMVVpT1Y3dHVNd0JZY01kTXBrU2dXVm1FMUwzVlE4?=
 =?utf-8?B?WkM1TWRXOWlod2djTnNHd2hCQlprRisxWDhibzg4cXQycjNzd0ZDRE1MTTZ3?=
 =?utf-8?B?YmpOU2hxMDNpb0RoSzhWMDhtYUxMZXZMcGZtcE5JUTNTZDFaa29CMTYxS0ls?=
 =?utf-8?B?SmJ1eGtCaWswOUpiK3Y3S2RwU0pFRnNnSGtQY3duN2ZKaGdtMVRXcy9SSlBI?=
 =?utf-8?B?Sk9hblZqSEhLeUtMUmEwZ0FOVkFLbXZiWnJseTZzS1pMbHRMSzNvR1JuM0Vq?=
 =?utf-8?B?MFVKdkFlVTNXZnZhNjZXVDBoVTdNZmVWOG1vSUhseGFJZ25VVFJWTVduU0kr?=
 =?utf-8?Q?Edd3wpEIz7NcEdqjwDqVQ58kjTKEWb3EkA0S+5NzuU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16bbaa-98c3-4857-73e2-08dbe46252e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 16:05:15.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKTFl/7HUjggoT/1j1wbAwowMPcwQe3L4KsbuksOQtPep6vm5Qm9RYx9HW4GQefcBv4pD7mK9MPnDJ7MnrBiYMHqXovAYxGQOU/dcITsd3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6384
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

On 11/13/23 16:28, Mehdi Djait wrote:
> Hi Michael,
> 
> On Fri, Nov 10, 2023 at 03:33:34PM +0100, Michael Riesch wrote:
>> Hi Mehdi,
>>
>> Sorry, forgot one thing:
>>
>> On 11/8/23 17:38, Mehdi Djait wrote:
>>> +static int cif_subdev_notifier(struct cif_device *cif_dev)
>>> +{
>>> +	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
>>> +	struct device *dev = cif_dev->dev;
>>> +	struct v4l2_async_connection *asd;
>>> +	struct v4l2_fwnode_endpoint vep = {
>>> +		.bus_type = V4L2_MBUS_PARALLEL,
>>
>> This is surprising. I had to set this to V4L2_MBUS_UNKNOWN, otherwise
>> v4l2_fwnode_endpoint_parse would yield -ENXIO, which indicates a bus
>> type mismatch. Does this really work for your (BT.656, right?) setup?
>>
> 
> Yes it works.
> 
>> I think we should get the bus type from the device tree, right?
>>
> 
> I am looking into this.
> 
>> Thanks and best regards,
>> Michael
>>
> 
> I assume you have a "bus-type = <MEDIA_BUS_TYPE_BT656>;" in the device
> tree definition of your endpoint ? This caused the mismatch as the
> v4l2_fwnode_endpoint is set to PARALLEL

Yes that's correct.

The documentation is quite sparse here, but I would guess that the PX30
VIP accepts parallel data without embedded syncs (=
MEDIA_BUS_TYPE_PARALLEL) as well as parallel data with embedded syncs (=
MEDIA_BUS_TYPE_BT656). If this is actually the case, I think we should
put V4L2_MBUS_UNKNOWN and let the device tree decide.

We can be sure, however, that the PX30 VIP supports BT.656, so I guess
the safe approach would be to use .bus_type = V4L2_MBUS_BT656.

What do you think?

Best regards,
Michael
