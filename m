Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC41A76B5CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjHAN0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjHAN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:26:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4035AC;
        Tue,  1 Aug 2023 06:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n09wXS3BT4LbdxIqxcz9rlGaxR9lpFpydvpLSb2wyvGrWv2KAp+MyiTxKy3zBYz+VBO/Ej5VA+5kYUtTfxcY3D5KGOxP3OTWA6nLE4BHtcHhltYYTa/oR86+GpVW9qt5Ieby/47xFgutClNCvO58JANpUj0FygaOavymEa4gFdFYYYmefgPIbp9P3YdKt+2AGbK2Vrj1ISaIaXFF34ZQj9dJEk12CiidGsGdemsLfsxjOHYbO+I+uvCLMVIinkd4AyEau795TjvLo1AEXC633O7VgqR2MqOpngUkesZm7b10vI2UEF6naUr/T1BMA1ZWGXR2iwbJUMgTg3ESyNjXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTLrcXiZhqZPtT1FsY2O5wcL/eFsvg0I0V45GRLe5bI=;
 b=gk5pZ/FiRuJd4hVHQDEW9Y/1Adzp8qoRHLF0Ke8etpUzsUIMTfGZDL6zF1kpPtpLyjNwOKbRYP//pAIbHW3IRQJymKagV85vA9U1V8HHuKLrYtYZfkIf3439aqdtb8f0gm0gsuX1WzmzLdafzy2YXmCyj4ZDQwfsYdNKoz1thc7gxMb2ZQsUvPRPhveRFkPWmumAaF06LwZy1DnxVQuiND0MSk9c3TDceEOi3xRxBIJw9g1I7zGFTKL9aVe2sJHz4yVcd/9VPTfGHd1c6qgLli6Uptj0XBHV8enhOQQxwOi50cR1lNiZvtitp7rQ9KPrIW/pMWinU9dXAKin+b6tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTLrcXiZhqZPtT1FsY2O5wcL/eFsvg0I0V45GRLe5bI=;
 b=tbMJyVWF5bwaFcm2Yy3HFf5DH9c+3/f2bHxy81kbGIABn1DazGTkGf7HkG963i3pbnv7Liryc+mCneyHooGZAi9vQrwZ8bn60YgdIpu+RHKnwLXJKwyZSePhPK5l2bcizSz9f/NQB1V9ORqaD3e6LwmBU/uX0e12IToNR94kV4PJ29ZxquSHYhmsPIQV6jXipaxrUs+JGh73UDPRqyu6Vn/1asfncBNdKtnsCTJDSizMvsdnpEVyato2w/tuNGMvQbHKWnmrM85/p+VcJqV/El6UzWT0yMxUeraQHxUEZpjrOyNzgtATvL+ruyLmDDkfynRiWBYTn6emHO2GJUmScQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by KL1PR0302MB5203.apcprd03.prod.outlook.com (2603:1096:820:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:25:43 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:25:43 +0000
Message-ID: <35713689-2b28-192c-5004-8a0ba6b9308b@amlogic.com>
Date:   Tue, 1 Aug 2023 21:25:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: Replace the IRQ number with the IRQID
 macro definition
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
 <20230721073214.1876417-4-huqiang.qin@amlogic.com>
 <7hcz0ei9r4.fsf@baylibre.com>
 <9da24c47-341b-1581-0043-a6c1cdce462d@amlogic.com>
 <7hh6pnhn45.fsf@baylibre.com>
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <7hh6pnhn45.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0159.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::15) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|KL1PR0302MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: ae568019-0d72-484c-7c3c-08db9292cdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFQ7CbsFQFgSoK3yCOdRpbG2jbq6bpNcPMXr8ecd4B4F0CGZROxS65xB5/7KC/W4YvQQdj9SgSJeLt2YTvSeC7Iip91hMpHKH4C4wpvBm6Gno4bv1JIXVN5KTF/TmQrf9eQn/CVCDgXdgyW+faH00BDoVwg+4eWeNK5tKG4d4VjygcpyqsP3R4/G1Oz0/0xqlEsT1YHyi3qaP8yTtKJ1X+tcbU5kl0jOschT9GCdmr052d8p/V7a80ilHGBxMnXnTK6A782RKzkskU2l1vUIcGiTln96uz7SgDhqE211/jsLrQR7kH5pxRnqZCNoSmoOUqkMnMZZI86uA+V4krwkFjjjunPeB3OxhR+P9ub/bgTN1S/+DYUvMq49ALjcR7xOSU4UiYkVMRokHQwSkt3/GADDOI2KEnsAUF0vkPmn3231sCxJ6bzOtAe+rNZ6VNbawZE47eh9kKfbKamBJXI2Y2xUMTITH43jNmvWMQLNEnrhb2h1spXGLn+dReaJmB2bRNwdWIwFF1Krmn+GhrLcxEtb31FVGi4sjpTzkua0vr2fpv3kzbYeL8Ci7YQ1r4w7MpHpSV7PlOTB00/JfJ+keiZtT4fiN4WvwFD8G7EG1EuHrAt1Yp8yQJQ8iUDoow/qCBoCu9URx5vQx1h+E+uiNTMlXgXdldYLtbOnsW14Vqi3BdgR5JM07yGVnOQUFNFghbTO5+tucc6w/XJqKwnTI9h+E8gntaEHz5sqGNVGdqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39850400004)(376002)(346002)(451199021)(4326008)(66946007)(66476007)(478600001)(66556008)(6666004)(6486002)(5660300002)(38350700002)(38100700002)(52116002)(316002)(31696002)(6512007)(31686004)(41300700001)(8936002)(8676002)(86362001)(53546011)(26005)(7416002)(186003)(44832011)(6506007)(4744005)(83380400001)(2616005)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtWZ2dZS2VONXlsOWNsc3o0WFh3UzRoNzV5akw4TEN2VGtpVGE2d1VYUmg1?=
 =?utf-8?B?dWN0eFV6L0FPTTVid2JmaFhDOGR5QUlZWGlJMGZURXhndUQ3ZnRNa2JmbDc4?=
 =?utf-8?B?eVRGdm9xS05tdmVmYUZtTTJoeHpuenFPaE40SHhmWTlkejQycWhnQm82Qkwy?=
 =?utf-8?B?Y1RKcU80NkozaFJtc1VkeDBRTEJZYkhiTHVQQ3NPaFJsOEtwK1IzSHQxR0lk?=
 =?utf-8?B?S2Q2bHpwRmkxMVowWW1rM1J4NTB3QlJzT05xc0xudExlUjlub1ozVGdvcTdL?=
 =?utf-8?B?VjlReXdzangyOW93MkRaa1UvVXd2ZmNLL1VTRWxTSWJ2OUJ5TitXVGlPZjRp?=
 =?utf-8?B?OERYNUc1alMyQTFrU0Jrcm93cWRjaXN4RDBuS1BnL1BKTUhWS2ErQ3NBQUpM?=
 =?utf-8?B?YjV5TnYvTGtFMml2UXRvYkhIdjBRSEQyVWxkVzJBcDZSaGJUTFM5WHRsUUhE?=
 =?utf-8?B?NklaQ0dlR21jVnREcW15RHZoYUVxVDd3QmorejBEZXRjall5T3E0Lzdqd0t2?=
 =?utf-8?B?Z3U4cHl2NnU4RnhKYXMrZmM4dW9mbVJEVmI2U2d5ZG1KWTRidSt4azZzdzc5?=
 =?utf-8?B?NmRlNXVjZ21iSjFhcndEZmZPM2ErQmdDd2Vib0VrckJsdm5YazdManZYbTNr?=
 =?utf-8?B?c0ZzZVNadSttbVgxVDV2RjRKWlUxNStPZlRBZUliWEFkQXcvVGlUbnpuWnFM?=
 =?utf-8?B?ZFlpYUhMOEIzTE9lMFlIdkhuTnNMdTYxQXJ2eG9hTFQ0c3Nvem5rSGJnK0x1?=
 =?utf-8?B?SEYvay82aCtRbm5ic2xUL2JMRzl5eDBqdldyTU55WnVZM0QxT29rdHlyc1hr?=
 =?utf-8?B?YU1pQ3crKzlRUXRMNTVVYnd1MUpuQW56ZkFwUFEyd29nWmp6ZmZYYkxlVlpE?=
 =?utf-8?B?MzRPUnMrUVZORkx1R0VwckdNeW9MYlJkRDFCSHpkeHlpVy9VNGtuUkFFSnYx?=
 =?utf-8?B?N3M3L1c1ZFRrUVBNSks0elg5WHBWdm9NT0crWXdoNFo1bFBZcjdsNkJxMkFw?=
 =?utf-8?B?bkNKcS85bm5BOGdKZG5RS29VUGtnQzhvem15cDM4KzBna1ZtTU1WV0l6V2VE?=
 =?utf-8?B?ZUVOZjZBenVlZVVNRjZucHZjWVBGandIUkRsbWpSTmNDdFNwQjFMaXdkUHR4?=
 =?utf-8?B?UGpUKzBTRTZmWUtkcHBuN0VVYTAxM1BUR3lJemJKSzR1ODdoWEJ5MTdCbFM4?=
 =?utf-8?B?LzZ4RW11b243ZjZkL2Vvai9nWFplcktveHdKRU5UY2E1d3J0TnZHYlBsczR0?=
 =?utf-8?B?cUdCQTJHQ3pSZWVLTWRjRzFYS3A4OWZHdGpKMXBoSlJITjJFekVYS1gvTk1M?=
 =?utf-8?B?QysxMDJWQmpEU0tUMS81TkgvK29DcHprVHVPUVo5T01Ic0lmTGtwVU1KblZt?=
 =?utf-8?B?TWFwckp1ejFCeGFpY3JNL1NaQ3FOVmY4Qmk5VTBhZTYyMWxRZjJHN3NQZ25T?=
 =?utf-8?B?Z0dVUllYS0REVjhJQ1BETXhkcWV0anlRdXBSUTkzMHZDRWRrRkZxMGF0R0Zu?=
 =?utf-8?B?SEhlb1l1RGtORk9rUWtma1U1RndZTlhyanlGOElkZW0wcXBHMjZuQWV0Y1Fq?=
 =?utf-8?B?MkJYbW1RM3BZUHdtZjRUQmcxRDhzWTN1WU95cG9zRk1UYVhvYkt0UjZ3Risr?=
 =?utf-8?B?R3dpRkRJTU5sSHRTTlVNZWRQMWlmL0hHTHhpMkRsbVpIQVlJdy9SVHcrVTJs?=
 =?utf-8?B?Mm90MUlDaTlBVmlBMGZUcEtOSXVrVmZwUkYyK0dYSHB1RitTaC8wK3VNK1Bq?=
 =?utf-8?B?TzFFOG1SbkNqSUkxRzg3SjAwNG9neE9QNVdsS3pDM09qampiZ2FlM3lLREsy?=
 =?utf-8?B?d2c5RHV1a3N3SnF0NjlBYXpObXM2bS9FR1ZmRndQdVJOTm8wbFVCazdabmFM?=
 =?utf-8?B?MklOYytIdVM1K1hBL1EwSnhyK2lTL1N0MWpjeDNyNEQzUyswemtmeWRSOCtt?=
 =?utf-8?B?dG53SkVSeTlGanl2ai9lc05COEh4NlRSVVJOSHpLRXNYUEYzODNLY0dHN04v?=
 =?utf-8?B?QWErUXBqQ2FVajFrYjczSWxvU0djeHRwb0hIY0ZBUTNQeGFYcHRFUGg2djVo?=
 =?utf-8?B?VGI0L2xDQXRhQmRzTXlzNlNpMHpYQVAwZ1JRa3pjS1pDK2RJK29WWFQwSjd0?=
 =?utf-8?B?WjNPZ2Vkc0dHOHJlUFRpckFLYk1uTGF5SndiV3VJWXJuUXoyUTh3WVNLZnRs?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae568019-0d72-484c-7c3c-08db9292cdde
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:25:42.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MX6lTPnIdCwRXHL3OSjK+Hso1x2UaP/Hocx/qErLNlqpxsCSVXi+0nOcyuYLsjxSPEwfKNfiuRzQXB6yHJ7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5203
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2023/7/29 3:06, Kevin Hilman wrote:
>> On 2023/7/27 6:33, Kevin Hilman wrote:
>>>> Replacing IRQ numbers with IRQID macro definitions makes node properties
>>>> easier to understand and also makes GPIO interrupts easier to use.
>>>>
>>>> Associated platforms:
>>>> - Amlogic Meson-G12A
>>>> - Amlogic Meson-G12B
>>>> - Amlogic Meson-SM1
>>> Does this mean you tested/validated these changes on those platforms
>>> also?
>>
>> Amlogic's G12A/G12B/SM1 have the same GPIO, and the GPIO interrupt number
>> is also the same, so I only tested on the SM1 platform, and the test results
>> prove that these changes are good.
> 
> OK, thank you for the explanation.
> 
> For future reference, this kind of detail is helpful to describe in the
> patch or cover letter so maintainers & reviewers better understand how
> the changes were tested.

Thanks for the suggestion, I'll add it to the cover letter for the patch v3.
(patch v2 was sent before your reply)


Best Regards,
Huqiang Qin
