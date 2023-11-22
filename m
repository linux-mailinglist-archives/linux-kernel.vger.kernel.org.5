Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4357F47F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbjKVNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKVNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:39:55 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09784D5C;
        Wed, 22 Nov 2023 05:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDlYFyFkitlfEpSR9vfg/m6MFD1fKFpql4rwKqOJjeMEtTywcbjQfWuffRUrAVMiDitGG8zFzr9GL6Hqhqd+gYjLFjR5XIeiFvuI3Wi3hdWCfir7v99DRciJzbXwVx9jXth6LZqbnlZdY3Uqt/nNX0dzWiquPfLInZCIOMErRPCbKsuheE3a8SpKlJzM3vcvxpWu8HifdgtGw4qBiAbefAupdet/JFTmFk4z+6jI7kegNGbVbV83d3WZ7kZ3XtDhJXIrCgA7ZKCxbqzDzi4e3Ls0b7wCExqePesan4aHKlzTVSY7ub4AJU7i/eQbBGVr+QLrlOAZ05orTHHWb6MBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtdYOdCiYP2cb3Ohof6ccfOMbawRf+U9hP18gukFsXw=;
 b=SM9/sMHjHhpEfa+PkywFfQpAi45xic5iTthxaA/oOESQKFcl5ErMdMTQ6icIOFZLR37Bno+guhHX8zzre1xISAlCM7SEF7dOlW/dd47m40D/ILzzlzIQWZvR1Mul0jCzS81VB+efg4j+m68jZyrk8Y8zuqKfqHbAyid21D8p8WdNCKErRxVFHm9W7EyHMgmaCeZRaST6dQK5kYfjE/CzyoeyaTC6Tbgl0TGOjnFd5Edq72b257VWk0HVbrf2A0UR10qBGBhG2lHyWk0NkzyO6TJTuMJ5UWzq+ZXe7inusoeyzWhy0Er1grhK8IRO6xFOe8q9Vuh5IrbGx5C4krZxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtdYOdCiYP2cb3Ohof6ccfOMbawRf+U9hP18gukFsXw=;
 b=C08xxQAUYiFdx+5744JWQiEkivD//CpexucZb9iDqJSQ9tmtNSb3DP8JYYU7z4/vP8XCBPxpPc+KvEYFGpf7Qn95qYLfhev/DBamD1OIbsfEeMafsqqwR+yCHv0J3fuHftY9wZJFnhK3DYZCwPVOHNUWYzGkHfRa+1FFCWrHgXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB8283.eurprd08.prod.outlook.com (2603:10a6:150:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 13:39:44 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:39:44 +0000
Message-ID: <64c2bc47-e922-4655-a5ef-6d3aab51058b@wolfvision.net>
Date:   Wed, 22 Nov 2023 14:39:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
 <ZVz58b0r4gtxyVQy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <9570dc1c-a437-46d4-95e7-1f3dd399e458@wolfvision.net>
 <ZV4DPsL4zkDkAuwj@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZV4DPsL4zkDkAuwj@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba36cb-0e80-4506-5a62-08dbeb607cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2C5hTz1Wl79nTbwEqamJ2T5l/kd6mpuoEEt9PQ29Pzi9dwLPZmWV1hiHETvvy26OzcyD1V3l8SHPSB6JPYwN3NUZ8Gxq9Jg2U0b1PPrZurPB7l8dXuxPfeUaRLBPvdj3QIY8iQLFZWKKW6WSgDcuAq/JQAuRaQcwS9hXtz/nfB95G8xV3s4739NRfbroT2L+eSOizzDL0dn2QYUlY0S0t30pQwS1AL6y6e/DYBoqkEEBd4vY2cMN2WxAGiwF9OirkKQPhyEURKIpsCiBiyEgipWYXxwjch0LTREZzpznC0tTi+KczErlqPMa+Qsjs3O9Wx+Xo1g8BS9wq9XoH6ghFA7Ee+TtbFY2Nhj6LpV/eeM6mr2ptDGa8l83yVB6t5xdPk6rGDkKfO+yp+RSodpdnQx/Pv1R/qxOYdokjF8yAME8WhrP7NTbu9XykSZnzEN+NJEpLjro6+LgD8LDp6YsZ179uvxG7LQ6WFv8Hc/FMbuAQc6Wn17ryF8rd9bHnt7i8aqTHYAGP71gXw/jCRbq/jz1NQz1Bkveckdb+tQpwLONwI3eth14juPgkWnX85k7UiQZhregSlRcIWtzO7WrFc0mkZMWZHNj6MWvONdRjwRg5HCVYMpTZqtin87FA6YvwNzZTQkO/q9GhgRDJyueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39850400004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(31686004)(86362001)(31696002)(6666004)(316002)(36916002)(6916009)(66946007)(66476007)(66556008)(36756003)(53546011)(5660300002)(6512007)(83380400001)(7416002)(26005)(44832011)(2906002)(478600001)(6486002)(6506007)(8676002)(41300700001)(38100700002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhMQTc2V2FnQ2U1OEdnRnFuMU5zSVBVdDN4N2o1QXZpSVNpRm1FMnpCZVgv?=
 =?utf-8?B?OGtnNjU4QldZNWRSMjMreHFFcTZISTFjeWw1TUQvWjJMc25NbGdXYlpLc3I3?=
 =?utf-8?B?bzRxeE1oempEbzRQQTBXZ1p6SmhzcDdyaWFpTHRqc284TzFBSkFnS2lUTWpo?=
 =?utf-8?B?Zk1UcVQ1MU1FdVpsYkgrTjVXaXQ2Q1k1RlRQcWdURGUzTElwTGpvdVYxYU5w?=
 =?utf-8?B?RjZ1alZKVVRaYjRZNlpsczlHM2dFV1pWd1FrQmNJVDBQN0M2ZzZqVm9JR1pi?=
 =?utf-8?B?clpKVUM1ZTV0a3p6bWx3YkpyQ3NWQUI0WkI1a3Z0cXRvTW1SYlJtUHpuMk9E?=
 =?utf-8?B?MG9pL2VSckZUVWtwSlNWMjlzbHBBSGVYYlQ4Ri9WSmNadm5TcG1oYUd6TldT?=
 =?utf-8?B?b0VTTHAvbm43RExlaFlkYnJUNStRc1VldUZqSGRQb3l6bHBDd1hSOEw4YzRm?=
 =?utf-8?B?MndGR3BjTkJ5VkhIZmNtTjNrY3dHNXE4WWYwdmZJLzVQMEMybnFNNDNuenRN?=
 =?utf-8?B?TW56OUptNWFUdUZGbUN1MnVLcTFBQldkbXN1cGd0ekxQb3NVQkJjd0ZDa1R4?=
 =?utf-8?B?Qmxvc0hlVDNTcGN1Ymh1ZzMvSkhPby9IeVoydko1ZUk4dkxrM0Rpa04vZ1kz?=
 =?utf-8?B?YkQ4SW53VGgrNHBDV2N2UG0rajRRVVg0Y2Q5UDZCbmFlNXRzZDFGUmJaRmt0?=
 =?utf-8?B?OExWZXZxRTBMYW10NnZYcVZ4T3NXMzFCemJlbkpoTXd4OW43MkJNL1h5c0tz?=
 =?utf-8?B?SnhqZjNReW5XdUJHVTlsd3JFVmZ1STNrU25helFOcS9zVUlHUlVsK1I5NUg1?=
 =?utf-8?B?Vmp5bE13Y3FCTTE3U1hlUzhIUEUvZythYXpvVTZ1TXV1UkJ1WnM5b0Npb2J2?=
 =?utf-8?B?cC8wSUN4bHpMa2srQlFnejFvRksvUXBpQ2lab2ZPYU1xMlZqaVdEZ0phZWdr?=
 =?utf-8?B?b1hFVUFrb1ViRmNCN3lrVlZDV3JMRVpXb0J4M1dwaDllVE1SVUwreHp6MGNm?=
 =?utf-8?B?Vlc4TmlMdkRibDhOaW9CbWlVTm1iY29DbmNFK2tXUlNKVXdFU04zbGF5ODA5?=
 =?utf-8?B?aFRoaU92VURHdE1sQnRxcEZsVmhYMDUzdmxvUG5TN0JhV2lCK3c3OHlCT1FW?=
 =?utf-8?B?NGEvbUdOZFZpWXZhTDBVeEFWclRTWGJCTUY2dEZUTGZRS1FWM2NKMkNWMzVV?=
 =?utf-8?B?UkVDbHkrSUVEZERsejdtV3NaaUduSVZ1NGFmY0E5K0ZxaWVtNGoyWm9BOWFD?=
 =?utf-8?B?cjdHNVBZUVMzZVFraFJnOWcyS0pXV0RDc2QyZi9Zc2ZJWkpmMlNFUTZCclQw?=
 =?utf-8?B?ZlFTd2lMbGZYWjVmWXRycVpydGR1NnpSbDFINmduSW9PNXRlblRQNklhZE5p?=
 =?utf-8?B?bGpQaUwzbHZQNVZQNDYxelFtam5Fc2N5TEN4KzJJMHRwazNSZy93NG96ZTVw?=
 =?utf-8?B?WmJjZ0VqVjF1TjFub3hTYnNJd3MrczZqbzUxNXZPVjdSQ05rMjNoRGRsMXRQ?=
 =?utf-8?B?elFNa3hEbityQjByVU1YNVZ4MktxZE1nRDRGSGRRbnZVczZKTFpkQ25KMXBC?=
 =?utf-8?B?YVI4TkorSDY0Y3VmVm5VTlpOamJ5dEllM2p4SlZVRVNpeFQyS1MxNDJuQzlX?=
 =?utf-8?B?elZPSmRYTHFtWUJlWnlCbFV4eml5N292UFJNRjdtcTMxdjNrSXdlakZGN2pY?=
 =?utf-8?B?VjBZOWpHSm56dkNvRm9nZExBTTBTcGpEOW1leG1nVmc5TElVZENLTzNsYXEw?=
 =?utf-8?B?NCs3UEpudnFPQ2dqVE9DS1FFQTNxa2dWd3lhYTlSVFZVTXJzclRCTzlUa0Jy?=
 =?utf-8?B?UXVQV2ZHYXhCTEE5M0lERDdwZ2dpTFVMdXJwd1hhR1ViV0RNdUFKWnJvVUFS?=
 =?utf-8?B?YjE1aEVDRklVVFpjcWZRelJxMCthWEN4UnZkOG1SS2VmYzJIcGN3V3FKWVht?=
 =?utf-8?B?U0lUcDVudFp4TkwvYVRYc2VML1FlRW05TlNmUW9NKy9LVjI3d09qUW1iRElC?=
 =?utf-8?B?aFRCWmdiMkl1YUtGckVESG1wazF1MEtiY3c1ejFYK0ZxVUVSL3JaVzMzOFc2?=
 =?utf-8?B?a0pZenE5c2xFT0pMOW1QRHNETlozSTR1N1FwSytkbXFMNEp2bWlwb283bzhP?=
 =?utf-8?B?S1hUWXgxOXozR2Y3OWpoaGtIUGJBOGJoOStPdlVmNmFWUFVFaWdoYXZWWC9p?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba36cb-0e80-4506-5a62-08dbeb607cc2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:39:44.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Alerxd7RGusIKnVq0/jMzj8O8NJgqDgtatNym9mVVYtX6RztIuiiMfV+lJczDaRyXGIC5QM1nBy+RkfMLDCGybZmvvWww/eGo6eckkL2+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Tommaso,

On 11/22/23 14:33, Tommaso Merciai wrote:
> Hi Michael,
> Thanks for your comment.
> 
> On Wed, Nov 22, 2023 at 01:42:50PM +0100, Michael Riesch wrote:
>> Hi Tommaso,
>>
>> On 11/21/23 19:41, Tommaso Merciai wrote:
>>> Hi Mehdi,
>>>
>>> On Thu, Nov 16, 2023 at 12:04:39PM +0100, Mehdi Djait wrote:
>>>> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
>>>>
>>>> This controller supports multiple parallel interfaces, but for now only the
>>>> BT.656 interface could be tested, hence it's the only one that's supported
>>>> in the first version of this driver.
>>>>
>>>> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
>>>> but for now it's only been tested on the PX30.
>>>>
>>>> CIF is implemented as a video node-centric driver.
>>>>
>>>> Most of this driver was written following the BSP driver from rockchip,
>>>> removing the parts that either didn't fit correctly the guidelines, or that
>>>> couldn't be tested.
>>>>
>>>> This basic version doesn't support cropping nor scaling and is only
>>>> designed with one SDTV video decoder being attached to it at any time.
>>>>
>>>> This version uses the "pingpong" mode of the controller, which is a
>>>> double-buffering mechanism.
>>>>
>>>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>>>> ---
>>>>  MAINTAINERS                                   |    7 +
>>>>  drivers/media/platform/rockchip/Kconfig       |    1 +
>>>>  drivers/media/platform/rockchip/Makefile      |    1 +
>>>>  drivers/media/platform/rockchip/cif/Kconfig   |   13 +
>>>>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>>>>  drivers/media/platform/rockchip/cif/capture.c | 1120 +++++++++++++++++
>>>>  drivers/media/platform/rockchip/cif/capture.h |   21 +
>>>>  drivers/media/platform/rockchip/cif/common.h  |  129 ++
>>>>  drivers/media/platform/rockchip/cif/dev.c     |  302 +++++
>>>>  drivers/media/platform/rockchip/cif/regs.h    |  127 ++
>>>>  10 files changed, 1724 insertions(+)
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/capture.h
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/common.h
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>>>>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
>>>
>>> Just a logigistic comment on my side for now, sorry :)
>>> What about use cif-* prefix in front of driver files?
>>>
>>> like:
>>>
>>> cif-capture.c
>>> cif-capture.h
>>> cif-common.h
>>> cif-dev.c
>>> cif-regs.h
>>
>> What would be the rationale here?
>>
>> IMHO the files are in a folder named cif, so adding this prefix seems
>> kind of redundant.
>>
>> That said, if there is a good reason I could live with cif-*.{c,h} as
>> well, of course. My only request would be to agree on something ASAP.
> 
> Others platform drivers are using this pattern prefix.
> Please check:
> 
> tree -l 2 ./drivers/media/platform/
> 
> Would be better for me to align with this common pattern.
> But this is my personal idea :)
> 
> Thanks & Regards,
> Tommaso
> 
>>
>>> Thanks & Regards,
>>> Tommaso
>>> [...]
>> Best regards,
>> Michael

Right, thanks for the explanations. No objections to renaming the files
to cif-*.{c,h} from my side, but let's get the naming discussions sorted
out quickly :-)

Best regards,
Michael
