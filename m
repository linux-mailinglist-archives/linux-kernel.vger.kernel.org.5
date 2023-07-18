Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EB757517
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGRHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGRHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:14:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363BB11C;
        Tue, 18 Jul 2023 00:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMzqwWurJF8NnDB3yDSM2PWYSvzU5TGfpDc879w6fXRVQjb83dFzdeRikdBWnBrnZgwyWvowDM7yciYBZUpoQCO4lJYo/+IpF47C45vyRo+r95lbkmPArDKQMlJky2AlMKmAh8dpB8xkAWpvigoIqQNel8nhiFe4BrknZ42l/vDMM9DCFoAfCj2mObhmvx74FUKTGhm/yWDza6147Sx41baon2kWPTsvIf4MUrzfZLuUqSC9tpJfeNw0YiWOTmDuN41SqS47wGr9Bpn7b6z2Ss2IcJbygS1GZRzXkpw721MURX/8lHIVJZgZU3Hqyh9J41JJxwVvFD34LF41i6poUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/eBHhM54lM0ZC30/Ceryilg0g11gmGuvHRwQ2LWuFc=;
 b=n31XlGqpeZ1YJ9BkoI/fWG/VlAuZU965gvbrxmSh9pJ+tlcEoiGrxwUeG79Sfd7zTNTUMSnzNzv3/zSQRLRpvDSwxgRR2FnQGdklLQ8uVI1V4T0KcMsX3//j3W8HkQ+DhykRtB4/HZlSfop+S8z6loyGqfmHBkZCx5TXzkVAUjHUgnT/s6LSY0KkaH8FufZEZOR5EGL/gZWpMbJ7uWMAvcq2FSL6FyxypmMn4Nca7LBic6mYAFhkOd0n3F2IdFK2LfDm/2cvN+3sJOUhGXk7L3Bp6WImSyD7Rc7yfFG5qoLqbhj88o7kbe7aU4ZqNXUn2ZOBUE/T1qLKlHLKk9GjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/eBHhM54lM0ZC30/Ceryilg0g11gmGuvHRwQ2LWuFc=;
 b=IfdWArK4tswdfupX4KGPt/99x6R3BP8yp17RB3bu9su6ibZB+7QIXWbd5uRbrkODTJdc/2d+04HuSRPYE08mYA3El5fXaBPwT8mgvXd6GlUBhvYbD+STOLeSYXNi/z+tgjJkJXdW471BhGrwHLyN8H3mwAZXVj2MmsPZUc+v5fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 07:14:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:14:29 +0000
Message-ID: <55014520-ee7d-1b7d-209b-e3f7bbe29e13@oss.nxp.com>
Date:   Tue, 18 Jul 2023 15:14:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 3/3] clk: imx: imx8: add audio clock mux driver
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1689322259-13504-1-git-send-email-shengjiu.wang@nxp.com>
 <1689322259-13504-4-git-send-email-shengjiu.wang@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <1689322259-13504-4-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: c4268fd3-5212-437d-8324-08db875ea05b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIg+ta9kSEulQA2IASL/O6xb13KiI8YAul/ok2H7rVm12RGh7TtfLvRm3cKlAWLHsYiEuOJFj0RT7uysFKW2NW9T/WOesVRvq3gSvxaKu3ufzcQftJ3hN0HzGSnOZg1Z/24Hq/hkfYmpyFUazBzQDPLvUoU71qbBRIEQBL/3/A3FgdIZfObxJ8XV8jg34FbQTCyvqdWs9IrxQec2IyXsKoz3dmH/zMnOvbhJ9tEa/RumgaA/EyuIPJlEIoCStLz4UDmwMwDRP1VGI1P3vMXlIIJuc3XGGA6qO9iqJ92ZVEfs8qDOUz6O5xFYQjCYakag83S2YlMbLEdGZf7Ob6kzfjxvQ6j3O5sg0p1JrpTPha8oOY7EvDBzV/m4jeHW1rBeqv33RgNfRmSVbC2YWCFu9FgAxxoO2H1egxmy2mIcl602ICvREd/tU6yV7ocPhRbDURHMkpP5YFEdvTNTzz0BBIrrp/8GeQprgzU0yHkJqRdl9o/m3QinZhWlFU4EL7gwP0Las2O2EYyvQeKjSbrWyZ0a1tYKqIxEWksw0UViMFOhU7kZGpWsQL4jLLnk0fFyAnyRwOMdGd/K5UPhCYJfzeN/B5iYgCWwmgrxWhqXbNDekT5o47/Iq9HH62er6aBV5RpXm0LMi5HGsuvNSriKzLcKEPDCEvf32XI4Qj3TxQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(44832011)(478600001)(5660300002)(66556008)(66946007)(66476007)(4326008)(7416002)(316002)(8936002)(2906002)(8676002)(41300700001)(4744005)(6666004)(31686004)(6512007)(26005)(53546011)(6486002)(6506007)(38100700002)(186003)(921005)(2616005)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STQxSi80djlQaFRFZmlrUEVmUEZacmgreERZZGgzZ3IxZ0tHUWU5QzNjUGVG?=
 =?utf-8?B?MTVCN1dmOCs2Q3JZNGxwRlBvVWRIY1U1UUl6dTRDZUlDN3E5WjQ3cHozcmZm?=
 =?utf-8?B?TjE3RitzREo0WmlFVStTMjNpY0huOXNkMlVzanJDQTJDY3ByeVFQcWRwMmEw?=
 =?utf-8?B?SWdSb295WmxKaU04Y081VzJLd1BkMUQrakFXbFdoRjZZZGJySis3YlYreHdF?=
 =?utf-8?B?NXprY0VDdUZFdStYMElZRitIVmE4OUdjajhLbW5raUNENHhGT0ZwdVNHcFNG?=
 =?utf-8?B?ZGlTdElKQlAyRzhXbGRqeXZ1NVlJOVV5amhNbVlJdjI3bWlZdmcwUTNsZWxh?=
 =?utf-8?B?c0xSdVhnc3ZyZHFJYVltdXEvY2d6SGNoZEI5MFFaWC9YL2R3UkExNmNJMzRp?=
 =?utf-8?B?dmpkclgwc0hDZ2gwdXc0L1hWc08wb2FMRDNYaG9nTWY2MDF3ODhXZXM0MkMz?=
 =?utf-8?B?cERrWUVjem1Kay8vbFk0RjVMb0lDcEd5ckJrTVF1dGpoUzNId282S3NubHd2?=
 =?utf-8?B?TTEyTEdLT3JVeUlHSW4yMTJtQ3lCbkhPc0VqNG9nbU5Xbm1Hd3lLMkZ2ZFFK?=
 =?utf-8?B?cGcvTUhHSDZ5WU1uU0YwY1ZJUVZGVnNrdFQ1RVYvWlJnWnNBRzJjVzdXSnJ2?=
 =?utf-8?B?c1hVdlRSU0lxb1l0c2J4VGFoUXk3dFdaY3YxL0hOLzV5MS9HLzduWWw3KzQy?=
 =?utf-8?B?SWQrMlZmTnlNR0Ixc2VaWnZJWE9vc1hlMU1CeEMxc3FUWFl5QUlxaWVKem8z?=
 =?utf-8?B?YWxMR1J1bVBjVGxkYW53OVNLTnpiVVF3TGVsSFJQODlHMlpkSy93SEEzRzBD?=
 =?utf-8?B?UzBrVGhQc29xTGJ3SG1BZGZhVUZPdCs5NW5KUmxaMWYyN0NvWjRrQ3g0dHpo?=
 =?utf-8?B?Vk8ycVNmTkN5VEhOMGVaY3daOGZTTzM4ViswWFlNNU1WdHRzaytTcStsa21o?=
 =?utf-8?B?Mkc4YTRQbGxhdDdIb0QxbnQ1YUx0Y2FFb3hsTmIvZGk2dXppTUwvaFA0bGVv?=
 =?utf-8?B?M1VoSm8rSjUwYVBBNG5EbEFQeDdxR2dta3UwOXB4bWE0TjVHbm54VmVMQTZv?=
 =?utf-8?B?REdKTDk2THh2OVJCdDl6d21hWVNrNkh5dTMxR2x5UUNFQWxET3R4MWVFa3ZY?=
 =?utf-8?B?S3pnYThuQTVyZkR0R3JyNkRINXhMZWovbHB4blJGTnJDR21FSlk2akZLWWRq?=
 =?utf-8?B?emg2NFh0Q0NORW9pQVBJTWlzQXpnc2l6SFFqQ0Jpa01nRHVSWDFMeWxKMmsy?=
 =?utf-8?B?QndxdDQvK1BNaHJTM2ZRNVVDa21TSW5ETk9JYUFTWUc0TEppL29wNE9jUUZS?=
 =?utf-8?B?Y0dndnAzOWt3RGUyalF4QWREWVgxVVZXbEhvamZGVXVLVXdkWTBFa2NSWWJt?=
 =?utf-8?B?Vk01bHAzbXlOb2JpVzFHWHRvYVRJM2hmSHVaMjNoUFR1RFdJYkEyTTh1NkJN?=
 =?utf-8?B?Nkl4cWp5M3hGUFBHS3V5SEdSNXBUbXVSeWNpbWIraEZJZ0Z6aGYyNWUxQ3Fw?=
 =?utf-8?B?eGRsY3B5ZjRpUWxwNlNpb1NPWFREVUFZQUZITlFlY0JYOTdoKzFJako0alI4?=
 =?utf-8?B?cnNxK1dxTzJZSG92UUZLR3NCN0Y4TVliVWhJdWNKQ0xvUWpBTm9XQnhaMjEr?=
 =?utf-8?B?MGpsMDQ2ZXZoYVRJVDdOazZXZjNSY0Z4dExYdHVmZ0JhQW1ETldEV0xYZGVU?=
 =?utf-8?B?ZzR3eXpTOThaRWlLVVNlOUpOQzZMT3R1Q3RQTHBkLzR4VXlTTTk5WFJBTmtw?=
 =?utf-8?B?QUtzSW9JSWhEUlZrQXBnN093T3ZPNzIwekdEYnB3amMxekJ0MmYyZk5PbWlZ?=
 =?utf-8?B?aE9PQzhvdmE4RVZQajJyVkVHT3dtbG9oZ2lLaWppbUFVLzl5K2VRaTI4WW43?=
 =?utf-8?B?cktwS0JCZlhuRS9GTHNEVlZaeUpWbm1ES1UwVDlibUJZVm9YUjhuK1BlQm5G?=
 =?utf-8?B?WXRmOEFNOFJMMCtHUE5FbmJiR3ZQakQ0NWFSZUttZFlzbXdGR1FLa0N6Vzda?=
 =?utf-8?B?Q0pNMUlod2NUT1Z5Q2Q3NTFPMDNnRVBzUk9KZzRxNDRKcWdwbnI4OER1dzlK?=
 =?utf-8?B?QW5CL2w0V2crWE5aOXFpN2w2akJxNFlPblYwOUc5aTRqUkkzWi9TbmJiQUZU?=
 =?utf-8?Q?SctKuzHQRnTKB/o0HT7TmHax0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4268fd3-5212-437d-8324-08db875ea05b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 07:14:29.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JOAOG0mdwhoSnSEOvQmCXzZlAHzTMJV3GgK37eplFijuvk3uxQqsEN3BapCQ49+qjU0Q6g31287XkWJedmf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 4:10 PM, Shengjiu Wang wrote:
> The Audio Clock Mux (ACM) is a collection of control registers
> and multiplexers that are used to route the audio source clocks
> to the audio peripherals.
> 
> Each audio peripheral has its dedicated audio clock mux
> (which differ based on usage) and control register.
> 
> Signed-off-by: Shengjiu Wang<shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
