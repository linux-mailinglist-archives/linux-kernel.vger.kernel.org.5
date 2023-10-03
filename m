Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D847B5F11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjJCCck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJCCck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:32:40 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2086.outbound.protection.outlook.com [40.92.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C7BF;
        Mon,  2 Oct 2023 19:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOWkXhdOYL1SpcMiv8wZxR2tHtiSrE6GPm/67LkCOE5tG7cNwbBNwsMXEcTwhKbzWfftp+v07IlcbQvQBRf2VG4XHFLCWfd/+nKRO+4wx57/LyqTMIvUR05wLhIFDnneZ2GQv+AkFgRZ5G6Rs8arBk98AVaWZvmPCGekSjd1y6aXB+HaIa/WCKN5JKp+YKlzQfluCCqYt1YY5H0QKpl9xj1y7mXnYzbrunSJcexYtEI+wRDeN5PWds7Us2QsSt07EPwmo1IKftBQKI1gUODaA6nKPszNkJECYYz0YDoB+LLc+sDXd3aTW9dQk4XvAdTSZAqGAP+p/tp6hqZu5jJE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srtYqI5fxWdxWnt69NGrVgg9OFCl1KuDtkCOprzXcyU=;
 b=jHj8bxsPsNGw6MO4W6vhXoxALtBbe34rgE7J5Z5ri9UL1Tsea/y2DR7PDHDuEI7ISrmx0qum6kGucCTDKHpZrPjuyanE6ztjIxAkLs/iqS3xgmJTvrUC5/Z2baUTqKrU81F1aBfB37zV3ccUcRzmMzYcKlQpWB4IN/JxzNxH1ZD3neTcPs+sRA5VfmKvft7MyP2YTisOUjlKcfMfLeimmwypPXKiQriDfSKTnZnbN76VUZNq0nPHzUfHz1d9upK5O95DFLZKXy1LTgdOi+VK+3KJ0ilO4pUXsbpN5NlAs9it4SEU3BzHo3sHlqex9uAld7ytHI9ngcjte9SQRoIyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srtYqI5fxWdxWnt69NGrVgg9OFCl1KuDtkCOprzXcyU=;
 b=E/4cq891jW+dV/owec4JNTu018eZfBbrnI2boo4ysez7zY8g2v3p9zMirwjKj5EqpqvsYlH1uvVmnwl5nbFywLVhniy1NyvzKGZ9eG7EkskYvT1XM777Xw04N7Qujpg6UNDuV5CCw9fVxgFVhJcymu8G5jyiFN4tCDpkaU6cTtIbAnaT4GKjXNJRmMQTKjxppl6F0LRoSXsSwiB9yNoJqllzVh7ywDNvtfk0waB6YL5yCk+JhN9Iv9P/4WuJeTT7jpkM3zQzeleW9IuMOLaA3ACGoIxzbdNBQOyEJKljQJuDGaiUoWzncSrYTBAgkvNmIHiIfiKuRnKIQSQv21yURQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB1631.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.29; Tue, 3 Oct 2023 02:32:27 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 02:32:27 +0000
Message-ID: <MA0P287MB03323A58B068D400E8225E80FEC4A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 3 Oct 2023 10:32:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add Milk-V Duo board support
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20231002-slurp-anime-a2308245174e@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231002-slurp-anime-a2308245174e@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [k3J3NN7BTkwyO6A6E6lh92Npy4x5GQFV]
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <caacf3ab-1391-44ef-b023-95ac5c01a981@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB1631:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb12ee6-6bdb-4bf5-2063-08dbc3b8fbf2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeJ8FwXjxZXWE46Xmgg7HItErrs5T1RJ1Y6/jhlGY8duiV8VKkcR0MnoRCDxoHibOX7/a476gfttLfCnqGiLKL2Ei3v28NN43MJrkpsKQ0FtkYNBFW0++A3moSYkKv+QnUWKBSUE7GfLZ1k/+bcp4WCoWGJ/b9xlCq8Ltls1MMB2qDQkPCSDVXxbG7uldUkkSYumR3IpHJvzFFtKiZS+JTqKVkMmG0SPYpA12NihoT6dQv3AK15CnPVYi6p9zWZRkB/BwzvL6VN8ohjIR5PqPEsklwzGCw6AFSkhbE9jpwV8BX0aQly5ZW8UxpWjibzzPKlZC7oL9ZQ+tLIe43hzJgJ8LyD+iOPlSTerHN0gvL18ck0U09kkSaTijp1pTmErs1ZMq6IAT4of7u6U+uiZT1O973nTuX5jv2E71zFOIh1Vz054rDtSDiYfNsLg+4pdFVH8imeTtBRK035yZ04zUnHnvqgho4Vapa4D0UObekXS35CpAcbrBzehqCHiKfhXOtuAQemypStSkg93kZF5QE6Qx7Tb4RBE4C+Ru+Mgoc4bxcHe8V9wQhv/P/qjy7udfuuhdMElcY3D3J3xerCzsDvq+VHamX7QOaY94LK4YPI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVUrM3laM3B1bXlkaE5tQ0Rud2QrMTRXV0hzR3gyeUlQU3V2Qk5lS2JOcVpE?=
 =?utf-8?B?RmV5b21QYkxzdE1mSUhFY1U2VWJVaVphblRzU1FvZW1oOEdudlY2d2VHc1l1?=
 =?utf-8?B?Y3hjNEtZZWMzYmsyVU1LWFhtbVMzeUkzcU1tR3JySmlZRk1oZTJPT2wwVG80?=
 =?utf-8?B?RTYrOTVkaXg3d0JkalU0eTBJQlpyeXJyWUUxOVBNOTBFNlNJOFlUZFZmTEhL?=
 =?utf-8?B?Wlc5ZnA3NkNscloyaS9QTU94VXRZb1pjQ3dyRTdSWFVtL0grQyt2VjZQVkZD?=
 =?utf-8?B?Y0k1L3RVS1FKeUlKV0Q5cC81cFZJL2hjbWdMM1lHM2pGTGZuSDU1WkRNczVj?=
 =?utf-8?B?NHFROEhYSmE5ekhSV3BWQ3N4dnZ1VytGSXFHb3M3UWxBMjd2VER4RU1WaHRB?=
 =?utf-8?B?U2pMd1Q3Nmh1RWk0c1l5NzJENXo1YkVqWjNpTVpDOTR6aDFmMjRxSks2YnBR?=
 =?utf-8?B?YSsvMk1zUFdxdlJLUlRWM3BUS3RRTUsxUGxJN0V3N0hDSEt0SHBKRTFmYWR2?=
 =?utf-8?B?RWs1aGtqeXlneEFMSVZmQWFDVjJDem9MVktuZldhTFR5S3QvVEdjSVZUbmdF?=
 =?utf-8?B?YTdVMGsrS1pURUg4c3BCOUJJOGVTTU5yazNQTE9HSXcvL3JBS0RtU1Q0Y0xy?=
 =?utf-8?B?WmI0NTRINVI0eHY1UDFsbHlWdVlpOXNOVzAwdGVuQm9PdjFiN3kwVE14VTNm?=
 =?utf-8?B?Rm52L2VwZTJkbnZCYW43SDlRdHZJaUorYmgrV2xudG1LalBhUXRzTGJsRm90?=
 =?utf-8?B?SFpWclg0WUlyZWJPZ3ZWTTBteitKb1VQcFVhL2Q3bktLMmJIR2VQdnBQWnN1?=
 =?utf-8?B?dTJGbkhsSGIyY1VjTnhObWp5YjVPRjM3V3YrSmJESFpFTUM5a2pFakkvaXkr?=
 =?utf-8?B?cEM4WVRvdWUvWjJGV2dUSjhIZ0g5ZHo5eGsrbU13aExOQmtKdExWNm9IWnh6?=
 =?utf-8?B?Tk81N0xPQlN4eG1QT2pyMmlwN01RU2dxOE1ZNXEzSmp4Y1NsN3JJODJaRUJH?=
 =?utf-8?B?NTdRSDRBa2poYThSeW9vS1M3dElXMGxaK1J1TFBqaE91Q0JMaXdvbGRCc29v?=
 =?utf-8?B?Q25LN2x0UEtPam41M1RRY3Y1WC9laCtkd1NIMnJXTEpSakltUDdVeFNKN2VQ?=
 =?utf-8?B?VHJWV29HNnIvbU1CNFQ3KzZiRzFWS1RjMW9ZMDhrSDE5YUNSZGs2aGxuK3RU?=
 =?utf-8?B?YjVJaXNPSXVjWXFrcDJpNytrVWxQWWNobi9jMFhncDhTaEhQd2FtV2VZWDN0?=
 =?utf-8?B?cnEvMXIwa0JQR3VPRFVlai9qZkhOM2VvTDJZMERGeUVCWnJPc0k3cmV3bWhD?=
 =?utf-8?B?bG04MjdUQXp6Rm1LT09ibjU3TmRrbFVKbkh0U2VVM2NUczl6QmR2QVJmSjFw?=
 =?utf-8?B?dkJqVVhqOEtnZWZQdjZkYktmUDlQcWV1OTRlcmx0M3AyM3dpTUl1WWZIb08w?=
 =?utf-8?B?WS9DcHNRYmN3RWFRUEVvL2RjY1F3bWJQQnBjR29EVzNvTDFTNFptb3M5bEJh?=
 =?utf-8?B?QTVZT2pKcm15RmdoeWNZSHJ4S0VnMFdRSUdYUEp2djVmT1hlNUdRWlVPY1BY?=
 =?utf-8?B?SE5FMXI5djhlWXFvaVJnRkhjcERka20rOTRpOFFvK3VnQmRZdUkzVHBOcHR6?=
 =?utf-8?Q?mUifHyW+sCHRaXOUYI/tKOsZ8VzT4kHgjS/hDDWoV4Ws=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb12ee6-6bdb-4bf5-2063-08dbc3b8fbf2
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 02:32:27.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1631
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/2 20:22, Conor Dooley 写道:
> Hey,
>
> On Sat, Sep 30, 2023 at 08:39:32PM +0800, Jisheng Zhang wrote:
>> Milk-V Duo[1] board is an embedded development platform based on the
>> CV1800B[2] chip. Add minimal device tree files for the development board.
>> Currently, now it's supported to boot to a basic shell.
>>
>> NOTE: this series is based on the SG2042 upstream series for the vendor
>> prefix and ARCH_SOPHGO option.
>>
>> Link: https://milkv.io/duo [1]
>> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
>> Link: https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/ [3]
> Other than the comment I left, this seems fine to me. I'd be happy
> enough to pick up the pre-reqs from the other series & this one if one
> of the Sophgo maintainers acked these patches.

Conor, just FYI, sophgo maintainers are located in China, and they are 
in National holiday vacation these days. I think they may reply to 
emails later this weekend.

Thanks,

Chen

>
> Thanks,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
