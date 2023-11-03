Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB417E057D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjKCPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:22:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2074.outbound.protection.outlook.com [40.92.52.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE411B2;
        Fri,  3 Nov 2023 08:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Nl2TRMYSCcrhdMi0sTG6f4C7t5qh8+V8RuaGOVqlD7UMuvBXFIrqypk0lGufXotr3cbQfZrJLc7y6KqttB70VzW+VKP3ZJaINvoLrMToFSSaEket3kXjHaJAWS9vuaJijcJQbZ5eqjMqADg0zprJlb21FdTMZ0EYIkzVp/nx68H/b3KEOjC7ekTfYXGJK3A6+UzEinjKitvbX7nKQ0k/qBy9xHD098zEAf3Bo7h2/rp3rv7wKujok6xwgzKkOaVYX/kt7rG9njD6e0jlkV5yTWKxrq0Lzn4RYHtAtbdLKXwQoJBS+VGTWTypudjMJnf04xGSmfV+fimC4okZ8VZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s07GJj0xohj7k67Moqvk1YfVm0rcmdlGXiUQoLNw7M=;
 b=C65jLIHAfvkmu1cG/xi1Qkmk0klt53DcLjVy89HUMlj2bPUvCfB9S6kJi01TUdAPmrOLpVTd1eF8uA/X4ECRxUHOR2D4UtrFWk+F2zDo8oHOBEiEdflt3BiZrrusEK8P9Wqp0NjmVYvxrvOjqNHD1FQyfUwvZLlFZWp7rl/bAIMYyPlDN9LagwD0tO/k9uBqtUcVnsYLLWgIe0AYwCVX5QuGd9B0VgHienBMOqnmgYs1y6n8MNN/10Uw2i0VykVwaK7zHeCmEhJ1Pgl8gGd5DhC1Qh6ny0VwPDKqGrTbnTFCa3FokU/ireiBibUlJeeHFPTu87llygCX6ccD4sE9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s07GJj0xohj7k67Moqvk1YfVm0rcmdlGXiUQoLNw7M=;
 b=MBS0mHDauB0fgAxhaRCtZGutcxeF1bulP8aEFu4XXk4+rMtG5c8MwUgiEbYd3kwRulAqoWSLeWDgmm4NQn0aPvxrxGodB9qDyYLOkngIiGXYvTdcjbUelVAUD+mcjUeMLpDY4CYA8T57u/ulWKjmnc1oNP7rn5RwH0fNUFT8ldRSFjATZ4Qk1/0xhwrDG+lWvJeVFwHmOuE3yqdUkG/9DPMJJefnKgpn/njD5TMi9SFeCxP1tTvORreOujQuHz1ISli0Q2JJ5sE/4ZCy8r3W60kEXmOEAzPvX3U1GVFaHFEbSGCHi7IfrMH9AI1Yo10St3InUaXzR2hd6Q2lMm1R4Q==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4300.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1af::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 15:22:45 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::d870:7910:448d:fb6d]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::d870:7910:448d:fb6d%6]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 15:22:45 +0000
Message-ID: <TYZPR01MB5556902EB8800164FE460D4AC9A5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Fri, 3 Nov 2023 23:22:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        yinxin_1989@aliyun.com, regressions@leemhuis.info,
        briannorris@chromium.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CAPDyKFpqCkxD9LmFqRM_AaEie0pbgFEsLTYmoj71pEr78+OssA@mail.gmail.com>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <CAPDyKFpqCkxD9LmFqRM_AaEie0pbgFEsLTYmoj71pEr78+OssA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [OGBCUR1kPoODALTAZI1HKLlO3Bz9MvLm]
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <67a9127b-0e69-f528-44bd-307436320008@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: e47a38cf-3064-4de2-96de-08dbdc80bab2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYbBJaqiytFpei9rd8/7KxbcuevHBpDYWsC508gufjUtXJoL8sB6R6UCcN5PhBwaFP5aQYFHxkImlZhtZf0dSXDYAs1077Sc+561es+kgBqHDZYIUZxtLpA0tpDaRiIqJMwP2jn4UuadFyAZ0I0WTiDow+E7uOanPgRiR9wySgZppI5FZvMNAbe6bNdKA28iH8Ght3l6KCa6jP8ZDWc5PIt87FmkmlfvVA/uvyo6boOTxGf3WFbRszbKixkeDurXybqeHKEXGWmrGYCji0dJ/tNvpZc9yo5my3YpS6P3vr1qllkiqzuXGxsbd6lEhw5IdEzmlPcMvSyl0nZmxTRctmwd5aUd2kfvbKGkeFjkJaBw9nlaOnVTqmdCaLOt7/pYHNTp2bPeKxUsjMpJwASw5Ttf2SGM1kSUvBdSvlMyddX9NH7GuO90kMSTbMwhtzmbksCgpBODzOnn39rVTwy9lcHisrghEnjQSuqCfCNoo1I5ide3HWRPJgqjrh8Q2NdyNETvP5qyT3GNFgEYr/R3aAPGyuDGJqr7zaXyrUXZidHcQlpv6pZmMmSVyP7E5qIf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWR0VDZVTStuSlpYbGZRZEQ3MGVrc2l0M0dvMkFKMXg1aHNROU1oL2E5RDlF?=
 =?utf-8?B?WU81OHdaRjlrNHBCUDl3YUhXeTRVcEp3OXdMalV5RDc2bkxMN1hoQUVjMzc2?=
 =?utf-8?B?M2dPRmJ6a0xYYXNyMys5bFhMMEJLbFJIMUpSVnphZStIVjRYakZYTjVRRmpq?=
 =?utf-8?B?eWRwNkJlY3owRWZlbUlCM09CT3dzUFp4dXJUK2JFOThTL2tvcVp5QXBnOEZ5?=
 =?utf-8?B?UC9Xd01OeUovUkxOa2hnNTkrdG9zbEVFUSt3WXlxTjR0bUZlMkx6RzZnUlhp?=
 =?utf-8?B?M0FMTHlGQXR1RDI4bTNhZ2hoaUFKckRzZENkK1QxREZsTkF1QzVON1JaaVln?=
 =?utf-8?B?ZlJBRlV2bmZUMHFHY0dpK0VWamZiVlNFam5rUTFuOU9ldGRiUytZNlEwV0VW?=
 =?utf-8?B?bFUzUkxRRjlOcE1SU2JKTHg0ZmhrbERoK3gvaW9DdEx1UyswaHVmTGhHMzZr?=
 =?utf-8?B?U0ZGZDVhS29uRW93dWw4NUo5bzBnK1ZFZjZOcDg4YzZscllsdjVod2lET1lv?=
 =?utf-8?B?d2dQTjlNZ1Joakt2L0lnNis0dk1IVS9mNHpTRjVmejN6Yk1CaVhjN053c2Qy?=
 =?utf-8?B?bW5UajNIb3pKdzB3eUJId3ZFWTBFeG9EV2hVWURmMmY5enRhNk5vcU5PL0Ry?=
 =?utf-8?B?SVhrMFNlSEV1YXNvbGlzSVhPMmd1MlJVcVFsRjF2KzVDNVFPN2M5NWZvdkhh?=
 =?utf-8?B?aXk5NkZjWVhycXk3RXFrd2RWZHlVcGM0UFdpeWd1N2pOcGVxeWdkYUR1UnNt?=
 =?utf-8?B?Ni9icktzYk8yRzVWSll4WlNBTUdWd2JVNTFHUmo3YTJpdTVwdzJvbVNVa1FM?=
 =?utf-8?B?RWFkRXU2SjBqekdFVkR6Ti9oSUJxVjQvY2dOTVBuNGg1QVNCcXVrRVRqU1l2?=
 =?utf-8?B?VjZZdDlJam5tZHVuRjArYjBkdmFqSjl1L29ZZkd3amRpeTh6ZlZaR3hBOUQ4?=
 =?utf-8?B?Ni9MZzA4dGRzZ1RYN0NFcSsvcDhqUmVOM21xTktDRDhpaDFIeE5rckF5VHhU?=
 =?utf-8?B?NDhFVVI3UVgvWGUrRzluM0ErRFBxdVJuR2lsZnJNNlhFdmFMRy9KUmFYU05k?=
 =?utf-8?B?enJKdmYvUkFEOVdMaVBGVVkvZGFlRU5qWlRFY3NmSFFBMEdVVVBubmxleXdV?=
 =?utf-8?B?U0pxZkdRSHo1SzZiL0YzUGgwdzlabnVLN2JkN2JISG5TOG91T0tsTlJLdHlW?=
 =?utf-8?B?Q2xZQWJZK0JTdEZ4Ync3QkFrSGt0YTB6L1d0eEMrbmhpMmtnbTJHTzNmTWd3?=
 =?utf-8?B?Q1drRGRVMVJxdTJ0UTVhSmhaRjJ3ZVAraUpwNEYyd2Fpc3FtZzZaalIvL3Bx?=
 =?utf-8?B?am1kcUUrZTI3NnZLRGJQU3pXZHA3MUxnK2d3MDRjSWR3SThjdWZSRm1ET0lT?=
 =?utf-8?B?dW9oVTZCR3Y0SmlzQjRJb3J2SUhiWndIVTl6NkczWmZ0K0VRQVFXMnQxOU5B?=
 =?utf-8?B?NWtEalFCZVk3d0l5VVpsM1BFR3RSc1dOVGE4aURMeU1seWpndzdDVmp3UkdT?=
 =?utf-8?B?SEFvL3lRR0FWS09sdGhWUU1OdUg1R1ZkMmtNdGd1eXdON1RlQkFpMkxkeFRt?=
 =?utf-8?B?NEZUM0VOOUZ4OG9ncGJrTXJuQVFQM3Q3d2pTd2JieURnZi9ZR3poZ2w4QTNT?=
 =?utf-8?B?RTFDZDEySXAwNTVjdVZDWTczL2tQVFE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a38cf-3064-4de2-96de-08dbdc80bab2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:22:45.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4300
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/11/3 19:15, Ulf Hansson 写道:
> + Anand
> 
> On Tue, 10 Oct 2023 at 18:44, Ziyang Huang <hzyitc@outlook.com> wrote:
>>
>> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
>> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
>> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
>> Then we set rx_clk_phase to 11 or 15 which is out of range and make
>> hardware frozen. After we send command request, no irq will be
>> interrupted and the mmc driver will keep to wait for request finished,
>> even durning rebooting.
>>
>> So let's set it to Phase 90 which should work in most cases. Then let
>> meson_mx_sdhc_execute_tuning() to find the accurate value for data
>> transfer.
>>
>> If this doesn't work, maybe need to define a factor in dts.
>>
>> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> Let's give this a try! Although, rather than queuing it as a fix for
> v6.7, I am picking it for v6.8 and adding a stable tag, this should
> allow it to become a bit more tested first.
> 
> Kind regards
> Uffe
> 
> 

Yes, I think any fixes better than now since it's broken and can't work.

