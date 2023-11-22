Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8453D7F4682
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjKVMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbjKVMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:43:01 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F4D1AC;
        Wed, 22 Nov 2023 04:42:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrdeGY170kaQE257N3ia51YahDhlop7A6UGYvpfoz7fg0gaQDxtZkH0yYJCPD0NhJlZzLexYfhUjEtAalgZVf2dRJ2nQnAcngjfN2QhZLNInM0SbelPb3mKlZwqw0jEEUhWU0to19N04L6vjiSmkXS5gWCkLwJhn/2QXFa3HY6jhH7nguaPj9jHhWVO4RESyqHoPzgprxZfFniHyAe4PUGENYKz2nauS0gRM3I7tp74Fe4ZiAPIGrwth4HiTCVp8CvBqLLugbmtW00vlkDKJl3dkXxk7hzeAwbh77ieqHHtT+uOeCTsHd0PCUbM6zHo/EjVQQDaiArfHcXNIkqJcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw9nDk05ibDyx0nDbnTFrtCbzaNjXmmQZ5uv0GBQsxU=;
 b=Q2FOysUkbRE9TgNEFqqedMLdwwGj3ZWWQeMJ5CVIoBiumEsqNw9YDq0IHXgoDpgJwkTaCXQwXCMVSNBPz/sf5iG4TvH2HNJ3pGVaqNaagAwHXupRLMGoUzlDgCHwlj5vdLii5iTTD1WcNOaMSYMPuW4QbbtVMqygQdR66KVk/RNSofjhoka1r6I2wj6Z05c2Tvr9Umcpdawtc+6L7X8LDhTm4lB6ckjYGRpcFyXOAoUL2Yy45cWHbWK4+ZrUyS7+YjgRwzpFwVs4V/f11I9YzHPsiank6UburroJAxXQB/k7hkoAVTcCiqjSg/B6uMbw+yHRkdxYv3abv5mcZ5zjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw9nDk05ibDyx0nDbnTFrtCbzaNjXmmQZ5uv0GBQsxU=;
 b=SuQBbuacWXQXEgtvb5IFM3Ln3AKR4KSGkcviFfh/5F3m/m0DWa7OYoJ1GCGHl483SLG7fChllLW76nt/FRd4IgoI5MMUbEqNYQm6qIDx36XYRgEmEbO4D8oPBr1yJ+MRFXkJskPfuXWRhCJg7WcceZN/8ktTuL+DQVh7+ELXOCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB7448.eurprd08.prod.outlook.com (2603:10a6:10:36c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 12:42:53 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 12:42:53 +0000
Message-ID: <9570dc1c-a437-46d4-95e7-1f3dd399e458@wolfvision.net>
Date:   Wed, 22 Nov 2023 13:42:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>,
        Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
 <ZVz58b0r4gtxyVQy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZVz58b0r4gtxyVQy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0040.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::29) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: f00b9656-22d1-44cc-3a12-08dbeb588b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbpklOylQg2WL2Fql3oiuttENwvZYYttf+QL/I+GRgYv3tgJsLCB2uI94zoFyYBpfYWiZb8JCzzU59pgueZrAsQdYr3k4Cko9YzpvuK59wQRrhp/xPa4GiGvEJnKv968TesF/ZQhTgbpmEYoxg2Xc27BeRlM6BlqW+MJQzlK3GDSY2G9BLsycpXqngWp1McvRpB9ahokpKR771kCx6+jS2yHWJuW3XeUbJ0pkQ0I4mk6EgDutic2K+utLKE3gBi4Ghf3icgWeQb9fs4bO4bhIvrxCjJ0VHtQgN0quWFEWPgFU90ZtOC+udZCd6rmCbzHoZVBo5HfC+t9eP0fieu2kUbyplhQYycfwhoxSisxFl/KyIytjdvTXHxHWeIJwErplNZNCCypxpwCZo6LHyuG69jcfftUVf5aEl23UXC2CE/LMlvMjSnubCpLWB2NIg0kK5EN/x+I8n/Kd0jMzR2mGNfTxPGhWvLFg6QfF1/9DX2GsCe2eMkWaA1BeOXBq9U/5CFS1pF9gPOwXt3ImfUQGJbPaMukP1lsjbjRYfZwWrtGLD3friJOIMCUiCIrhGUi4xbbNHux3DZkXKmSdacxUFp0QI+KyAkGOsI/QbTiXCg2pGANs0sZPFgkmd8ljuqAERp5a27ODsSadXZU8kUnwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(41300700001)(2906002)(4326008)(8676002)(8936002)(316002)(5660300002)(86362001)(44832011)(31696002)(36756003)(31686004)(6486002)(478600001)(2616005)(6506007)(26005)(36916002)(53546011)(83380400001)(6512007)(38100700002)(66556008)(110136005)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWp5K2hLMk1NczlvL3Y2dWNDTVVKVVRyNkp6STZndDl6V2NkTU5ja1F3b0ow?=
 =?utf-8?B?Z1hLNHBpMGZ1V1p1dllXT2pONnMvUnVyMnB4UFhQNGV2OCthSVQyQ3FJdnZk?=
 =?utf-8?B?MDQraXJXbTQ4NWxxZ1ZPWnBwUGFiZWFnK2x1M3RUUWR1emhoSnU2OS9EUUZH?=
 =?utf-8?B?YTllM0laNkxrM1BYWGRlc3dhU0x2VE5xL0JZRUQ2ajZtdVAvTkVud250VmNW?=
 =?utf-8?B?Rk9CV1pOZjNRVUtwMHB1ckduMDdWb0RRbXI4SDA5M3hISkYvOS9ibjlRYWVV?=
 =?utf-8?B?SEgwT3dtaStOM1VYMm5iQzZZdE9BRnA2VjVkekdsVmJuZUY5ODlrSWhQTTdH?=
 =?utf-8?B?bE5sZGJCTDJGQWlWVDlQZWJXczdJTUdRanRacGFuWkVWU3hXaG1WU3VRc1Yx?=
 =?utf-8?B?VDVWZFZCMy9HUGwyQnZXSHlObjJyUTZNNnpObE5Yd2V4azRsNTk4Rk5mdHFk?=
 =?utf-8?B?N2haTFVxZEhvSWVmdGJSTnh4V2hFaGY3MW9RQmZyZkltcFo3UGFEMnZBSWEz?=
 =?utf-8?B?NmJhS1Q0dlZGWHdrUktCQXF6VWNlMW4vTlQ1MkpiRTFjVlg1akdaQXRmMStx?=
 =?utf-8?B?bStwQkNpSFF2VEEyUzVhSVh3TTdienNSMVgzdzBaN0ZpUFRSMklYUStBeVNJ?=
 =?utf-8?B?b21qcnFOdzIzS2VkV1hHSUtFSXo3VXBGS2xLYmROT0FQUFRQZ05RNTNJMkRs?=
 =?utf-8?B?NjZQY1BibFF4dEhuQnpFYlBlMzBGVWh6NW1ZZG5pTS9zYVFCRXE4Z1NpMGUx?=
 =?utf-8?B?dXYzcDNhREZHellMdmZOaTBndytwbmk5U0Rucy9MRVM2OG9pWHJDSmNjUm5G?=
 =?utf-8?B?ZTd0STBVVlV5azlMQkVGeStQL0E3aVVFZCtxUFVQZWNiVFlkV3VESEpOTFU2?=
 =?utf-8?B?aVNYZXJHSzdqUFI0WG1WajlwVmJwT3dvY3E5RXJpQnZpalgwLytIY3RSQkpV?=
 =?utf-8?B?RCt4WDVLdEpHWVRJendmRFlvdTJjcFI4RG9YUy9pSnZhM3VVK1hZYnk0Q0hO?=
 =?utf-8?B?YUZaQTVRTEl6QVNqOEtkVUo1Q0U4aW9DTXFNSkFyYTZQUzNwYkVjdmtxamZU?=
 =?utf-8?B?TWFIQ0xZSXZlSmhUQUdDa1FEWU9jU2FLeEs2ZlJZU2FVN3VObDVUR2RXcUtW?=
 =?utf-8?B?enFGZ3pFVTRkd0Q0bER5YkRxeVFQcExJbm9wM0Fmam9FNG5ZYlFKZ3Y1Sk1v?=
 =?utf-8?B?eVFEVG9uZHNKbThwQmVXK0MxTmhJWkhJdnFLZzJ5bzl0SFc4T3lsYlVsYTZ4?=
 =?utf-8?B?RGYvbnZESXhWNmtOMWtEMnVYV3U4RGxNKzR6Qi9lbTQzckpPRWtJYWY0cGov?=
 =?utf-8?B?RkVTb1huUFFjeVMxbVNvMW9kajhZenUvUG1Bc0dzUm1OY1QvR01ycjdURWJz?=
 =?utf-8?B?LzN0U2p1OHVxUk9wTHVYUUk1anJURkNkWkdhTHY3aFd0bjljYkFRWFdLbWpJ?=
 =?utf-8?B?MFZ1c01RSU93ZGt2bHYxQUkyajFlaTlhcm5pam9uRS9PdG1yRnNHcHdvYXVs?=
 =?utf-8?B?MjIzRGcreVVaUDVLelFtZXJ2VHFHdVlUbEhXNlczVnByaXUzODl0S213ZzE5?=
 =?utf-8?B?SlhOeVJkbjBFdzVLTWpQWHh3WFN2U1BZNHgxUzhmSXU5QmJ4diszQjJYNXNR?=
 =?utf-8?B?RHA2d0VrNUhSV0tJU0d4ZXhhay9wbUcrTWI5alRsT3gzeEpMTGYrMEl0UTl5?=
 =?utf-8?B?ZlNjRG4xUVFTOFZiZ2E0TGhNS1pBc3dUcW95czFKeWVFMHJYWnY1cGQ3TTU0?=
 =?utf-8?B?Y3hVSDBmOFpkZS8wcmZWRERSU1pxQS91a0ZlN2xsN3hBSkNPYzh6TTAvcjl2?=
 =?utf-8?B?NVVjdXRoUUlSanl4K1A3YThjdC9iMzhiWTJEUXV1YUdESlF1Q2JLQVpYZGRP?=
 =?utf-8?B?WnA1YUY5ZktLbnFiWWlwQVVEMjRZOEZTbTYrd2F1dlBPZTdiZjd2YUVERUpO?=
 =?utf-8?B?ZVFoTndkbkFKWEs4bFpVeTN0bTFVWWNMcjNKVy9odFdDQnpMN3Q2UmxBcUhC?=
 =?utf-8?B?R1lacG16dVR5MndJTThYbC9WVFJXeVRDUUNNOTY5Rm9QSlR1TzU2SSs1OEtj?=
 =?utf-8?B?YlR2YzNJVEhvTm1FMXFJcUZSWUduSDZBOVFta0NHUUpoZXdRZ1JNV0lTVkh5?=
 =?utf-8?B?eG5aWjNINXVvTmNHcFFPaGo3VWRNYUhuajJoZURmMmRpR2FwejEwVkVHMmtz?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f00b9656-22d1-44cc-3a12-08dbeb588b7d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 12:42:53.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6Dt0dgYMFDouZxpG1LGSAZe2coQKFzMXQjez7Eb4nTAnFoyOaRmh5Zski/m8bhDO9ZfG+Rt0tCvAATXwt7h9YM/RaoE8SKSE6WfNSTuRyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On 11/21/23 19:41, Tommaso Merciai wrote:
> Hi Mehdi,
> 
> On Thu, Nov 16, 2023 at 12:04:39PM +0100, Mehdi Djait wrote:
>> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
>>
>> This controller supports multiple parallel interfaces, but for now only the
>> BT.656 interface could be tested, hence it's the only one that's supported
>> in the first version of this driver.
>>
>> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
>> but for now it's only been tested on the PX30.
>>
>> CIF is implemented as a video node-centric driver.
>>
>> Most of this driver was written following the BSP driver from rockchip,
>> removing the parts that either didn't fit correctly the guidelines, or that
>> couldn't be tested.
>>
>> This basic version doesn't support cropping nor scaling and is only
>> designed with one SDTV video decoder being attached to it at any time.
>>
>> This version uses the "pingpong" mode of the controller, which is a
>> double-buffering mechanism.
>>
>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>> ---
>>  MAINTAINERS                                   |    7 +
>>  drivers/media/platform/rockchip/Kconfig       |    1 +
>>  drivers/media/platform/rockchip/Makefile      |    1 +
>>  drivers/media/platform/rockchip/cif/Kconfig   |   13 +
>>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>>  drivers/media/platform/rockchip/cif/capture.c | 1120 +++++++++++++++++
>>  drivers/media/platform/rockchip/cif/capture.h |   21 +
>>  drivers/media/platform/rockchip/cif/common.h  |  129 ++
>>  drivers/media/platform/rockchip/cif/dev.c     |  302 +++++
>>  drivers/media/platform/rockchip/cif/regs.h    |  127 ++
>>  10 files changed, 1724 insertions(+)
>>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>>  create mode 100644 drivers/media/platform/rockchip/cif/capture.h
>>  create mode 100644 drivers/media/platform/rockchip/cif/common.h
>>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
> 
> Just a logigistic comment on my side for now, sorry :)
> What about use cif-* prefix in front of driver files?
> 
> like:
> 
> cif-capture.c
> cif-capture.h
> cif-common.h
> cif-dev.c
> cif-regs.h

What would be the rationale here?

IMHO the files are in a folder named cif, so adding this prefix seems
kind of redundant.

That said, if there is a good reason I could live with cif-*.{c,h} as
well, of course. My only request would be to agree on something ASAP.

> Thanks & Regards,
> Tommaso
> [...]
Best regards,
Michael
