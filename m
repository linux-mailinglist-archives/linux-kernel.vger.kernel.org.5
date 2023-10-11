Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6F7C4903
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJKFHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJKFHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:07:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B598
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htt/hxkPVhLAiBsgWVduIi0hBsaWgqRlOUEEAPaYXJn9KRoan/mrhzLFh7K6uzTEdIjjib/I8LVOTE5/4wduOfgg0BUm12FTkFc5EDSA/34E+7+9rnzkJIqCt9VnHGE5ujCqojbBMT7hCT1QA8eWgDNvpJWJejP2i5Pzi1TBLa7XaLPe2Xb5ynuXzvh7wvLgKKrBngJsfwxc2rXMkxwO/lZi0ctpPQhh1gTL71kMdTJPjgFF46mcQFJ6Bo0CnalKJRHvFtTRf1LYLS44ZUppIsfBNZEa+PfCyka/6gavaUARSISMwVoo9I3Fcu+V8vSg2w3CudYoCYYRCtwQo92ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjtauk6sJu+63kYF7rj5wkrRtSuvUVToS7hkVy/yn4Q=;
 b=VVasoDtjEhIviSHua3bgQsiMQgfFUV5RUzSVZXqDTgw3sCXntdGKGI5IFsOnH/K0TyQQ4Rw0gZRsz0zgnmZTrEtuFjEA9YBSSAhQHOZUtW7VjOaynu0GsfAbBeqvsGyssNn42KnglA8eg6VFGUWX5ZxiqXjcM/XxpBJEgq0pGwW7NR0qXf2ckwY7qsPRLhFowGlE+qrw53OYGE6I02i7LMpv5BQjAYFJFVGQ+pIrEQ8P6G1zCD2tQmzD455QNu9WlPqAIoO0+0Ma0iJJb1LGnWY2mf0FO9WEU54z8pBON2nyJCyyRc/YF0fSWcyQp1dh2h9xwLvH5agRDRfvfDiK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjtauk6sJu+63kYF7rj5wkrRtSuvUVToS7hkVy/yn4Q=;
 b=lizAasKDVhZMRSYn9oJvSBsutXEpJZsFJSnSY8nE8HPedGUknYFcnrqbxWS7xJ31/K1SKbDZUKjZba+q9XYSvGpKr09VKdwo6+2t+oCgw7HdjB+LqelTkmDfdHoDu92t0DYKMaTnk1PL/wO1NdC4O2MdTtMXtCoQ5P89JEHKtc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by PR3P193MB1039.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 05:07:06 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7%3]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 05:07:06 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] IXP4XX MAINTAINERS entries
References: <m334yivh1f.fsf@t19.piap.pl>
        <CACRpkdZ+7YFYNPXuiFU=JRZYOia5V+145dpRrLN+LTuHE5RuUA@mail.gmail.com>
Date:   Wed, 11 Oct 2023 07:07:05 +0200
In-Reply-To: <CACRpkdZ+7YFYNPXuiFU=JRZYOia5V+145dpRrLN+LTuHE5RuUA@mail.gmail.com>
        (Linus Walleij's message of "Tue, 10 Oct 2023 16:02:35 +0200")
Message-ID: <m3sf6hu4qu.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|PR3P193MB1039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c94e2f9-b6a2-4b34-9695-08dbca17e9d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XUs+KDeAIsvL+b+0/NWuNnDudHFp3rUEu25kqOcajx1uYYGiMUqiCTjkP6HumVHcT1mpBccI9QwlrFpzD2gdfivDQY44/ga5OECmf4JucyWqTS0Vy7EI4UXtOFQJid3fiRp2TQQddVRSRQKqdienR6NAJKR7Q15fEuUsrq2noLvJ/McIjdjKTCNWtPfaO/+duxe3qxW7qzgGWrII623rwD+2TCordVGVWcO5ZhQDr3D/36b7oDgpUIQ9qcBbrs800q27ckZs+jJUKlvtVJjXSpbg++Ha+++KtoOd70LFKKedt0ADpYB9MkpZ+NAuvo2C37hDfl4fcE78KIGQgIga4YqLY10suWkGGScfVp2C9b0hePW2++oAgqg46A0OvFKo01p2mhX7sd8eZRY1jjXpJvRlmrwqjI3pwUa9OX8pWs0vqW0T6Nq2Ev3zAx5MTgrJJnoIOsrgGxqVdi7eiKAvRwYyAPlISI/GT4bIAY3Am4Vs4VQy4MY+CpyQRHlGQbTE7P2FvfTbPmMb70VKRStPoQBgdSSaBIHW1oFb06Y0k3y7mRlKPBq/G/Uraa87ZfGkBLZixJsQDu3tQeX5ZWq4/vnygQF+jPjAZ4uFvw2cOCXp1IzGdtYLy/b5AztKe1rR8Y+jEOGi1BL5/97bzfjcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(1800799009)(451199024)(64100799003)(186009)(2906002)(83170400001)(38350700002)(38100700002)(6916009)(66476007)(54906003)(41300700001)(66556008)(66946007)(316002)(786003)(52116002)(4744005)(6512007)(26005)(478600001)(6486002)(6506007)(66574015)(8676002)(5660300002)(42882007)(8936002)(83380400001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FyQUdNdE5ycFNWTWF6SUxwa0JGZWI4VnUwMEcwUWI4MnIzWVZIRVVSNDBt?=
 =?utf-8?B?bmpMcFFMMUlwRllCaG02cVFXa05TNW9JbWRsNkx2YkozajBocGo3K3ZVR1NX?=
 =?utf-8?B?QndFamU0YVRPOFBEUDhDaUI4dVUzU1lxWTloMmhyeHhoZDAzMVdkSFZLdXdQ?=
 =?utf-8?B?bXEwQXQ4bEJMV244Uk55eE9EUndRQWhlWk0zUmZIcE8vZWl1UGNoMk93TVBh?=
 =?utf-8?B?T3NONk5KRU9LVldTMDlqQlFuT2R3VFRBcThaQ1AwMStzaG5tOG5EQ0FUVnc0?=
 =?utf-8?B?SWxGaWo1UUhlVUR0eHVReUFLOWVYcFh3ZFJWenpiOElBeTdWNVg4YkVLMGdW?=
 =?utf-8?B?RG1pbmVjUGJQQzlCNDV0K3dVM3QzOWJYK1Q5WGVHNXU5bWtxeTBSTmdQYjV3?=
 =?utf-8?B?TmkwQlpSZ2hHK3YvU2JYUE5CZDRUL0N1TjlCcEJ5Q09IaTJDRkpjekpiQ0gr?=
 =?utf-8?B?U2d5Zy92TG9VUjFyNU5xLzUvNCtpRlVHdXR4WlJ4ZlRxQkRyemh6dTR6bGdh?=
 =?utf-8?B?ODg1QlRvbVRocjZZMlhvSUhIVURnR3I1aERWTmg5ZGQ3cGVwWW83ckFodzdY?=
 =?utf-8?B?c0luWVppSy9mdThrMUlmM2pEeWJrdEw0TmZ5TE9LY0orekx1THNWOUVESER0?=
 =?utf-8?B?Qmh6WDBoNTlTN29hck11Y1ZMbFVkc3c1ajlEdUhjblhWazE5RTFpZW92UlBx?=
 =?utf-8?B?U1NCWXptMW5nUVNSQ25ibGFjeTNvQTFnTW5ZVkVHNUY0RUZqOGNodFFFWlk1?=
 =?utf-8?B?UmpUZGN3OHFRWXF2cFYzQWtiSmhlK2Q3aTNvRzhaTVlIU0k5Lyt1RFYwNm9C?=
 =?utf-8?B?TE1XQzNKYk9XMGcrNENEd1kzQkswbm8xZmFrcHUvU1IweDJoc3AyRGIwNDA5?=
 =?utf-8?B?ZUJDdEQxaGNnWUpEdmdpVkUzeURwdTd6aDZhQmZMMlFNbFF0elJJYzJDUDRW?=
 =?utf-8?B?MVoyd2tmdytOY2M3bVdHNzhrYUpXVmJVM3A3Q25SSWNlckNzZzlKV2pNbjc4?=
 =?utf-8?B?SXd2dGhCejJyckdjY0RQazUvZFlMaTBYZzVpSHdUVGtpSDRnTjdURWMxWnRy?=
 =?utf-8?B?akIvTkdscWFYeG43czJWUFk0N25VQkVtVkpwMUs0Qnp1aUc3KzRkQ1E1cFB6?=
 =?utf-8?B?SkpqZnJQVERua21wY3FGeml4aElnTzVmaThVeG1BYytvbDR0VFM3VTQySFc0?=
 =?utf-8?B?YWZnbGc3djBBODhOSDZWd1RTS2tKdys0NmlxS0JWd05KL3Uza1M3SGUzT05P?=
 =?utf-8?B?aDlGeE1rMXR6VWZlWEpZdHF0M2s2bFArdG10MVhLMHg4WHhjT2JqaWJIK05B?=
 =?utf-8?B?ZEdreU9VQjY4emhwNUllL0MxM3F3cGdPMVVPQUJEa3g3Wk9DalgrZk9YR0RN?=
 =?utf-8?B?VlA3d25FS3NTNUFvbGJlelA2WXlVWC92ZEJGUXNhQUpTcFFzWlBjRVBQaWJx?=
 =?utf-8?B?WHFqdFZBaHIyeEJ3OEdXeG9IME5ZdWdndlladUIrSUdvVjlHbFY0TlgyeGlG?=
 =?utf-8?B?cVo2bTV6Y3U4Uk4wMnFWSlpJdmhNSm1ocmNMditQYkgwaS9RNGVVQzIrTlBy?=
 =?utf-8?B?QkpHOU5sVVdUZFZjeUVDWmNpZXJ1Q2dTTVZ4SjA0K2NBSGpHemRQNStiREdZ?=
 =?utf-8?B?aU9iaVZtNVFJVVdHckRFc2FqSlhkanpjdkNtVUxlU3ZEN3kzb1d4WEE1TEFt?=
 =?utf-8?B?WWMvMVZTSTJFMVh3cWFHRXNoTnE4SGJGZkZDSkR6SUcxMXBiNmY0a2Zub2Uz?=
 =?utf-8?B?WjUyTXJPRXl2K25MWTlxMENhZENwYzN4WC9CaWVuUksvT1U1OW5ZVmdaeER6?=
 =?utf-8?B?ZmxDcXRFRElRNjkrKzJ4cDdoQ0IyNk5DdGFGWWpmWDB0REF6KzN4b2U0UnpO?=
 =?utf-8?B?clRZaWFqWGlLWnJ0L3BhR3pVVXg3emtjYis3WHNmbG92Wk9wMHErZUk3MVlW?=
 =?utf-8?B?K2F5U1BKeWtHbExyMmxHM1RsUGNPMjE4MnRPV0ZINGY3ZkswbUZyV1N4TWVZ?=
 =?utf-8?B?V2FmUzVJR1FrbHQxZVpJSzJQTUt1aWd6YmNoSm9sZU9pK0txZUxSaXc1ZlI4?=
 =?utf-8?B?Rk5ZdEdheTNZTVVKQWg2SXpVRkFQc001VTVFVDB0WDhEczVka1BSdUVOdUta?=
 =?utf-8?B?MWdFQnlTS08yRjlpQnlMNGdFaHdadjJrWVNnWmwxVGJmRm5oaE11UUN1dmZV?=
 =?utf-8?Q?FWkjqCldBLfNVFBZ5HayBvFHkjPYixrQtgbBOtKlRPCs?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c94e2f9-b6a2-4b34-9695-08dbca17e9d8
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 05:07:06.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1xTGL/1v6W65hv/D5sS0LclUAkEOR9tdOrceny7/RwcjlIdmBTG6qan/OFtAoIGHM5st8GPQ/pPnw1bH9ld4X24KueAAkOB0WMFoUUz5SMNwTcT0gLdxc26srdwB/ddlzvcHMkfpTGfPT9kB4nrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1039
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Linus Walleij <linus.walleij@linaro.org> writes:

> I'm sad about you stepping down, IXP4xx has a mean time before failure
> of 60 years and we've only done 20 years yet! ;)

Well, ARM64, greener pastures, follow the white rabbit, no, rabbits
don't fit here at all. It was maybe practical when I was using IXP425
and 43x, but then I went to ARM11MP, Cortex A9, Cortex Axx.

> I sent a pull request for IXP4xx today already, so just send
> this to soc@kernel.org for direct application.

Wilco... Done.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
