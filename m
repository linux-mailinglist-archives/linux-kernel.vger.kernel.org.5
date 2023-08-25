Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168D78883D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbjHYNRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbjHYNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:16:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B4E78;
        Fri, 25 Aug 2023 06:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fytUz5WUeUdHs2+Z3Le3BPHeNaLm/mEpvCq6hOw6atFJXq8B4R/HYE1TceEuSvxs1KtCcP8ZwqMjsEI73HOmJY9TXEQVXNOmbZG6+pODZ5o47Vm+G4wD+AJUYtvum29S7/UnTwqZUnF7cga92kmW3SPnqgErgszd6PYSLuSs/nww8teZZ0VpEGekxTugkQVyVcKbP5wvFGrcnj275nrK5QOVGTMkxNdXK0wF5+2dLVhP71bQcouC4UnJ9MdU9cAtCvI4qpPOWQnShuPhxFImv50XdwWbZkjsc40PpT35vJTn+KnWMRJ4itxFVOGTuamSZbWnETeiqZVFN/VenWf6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjp+tAdQSYhzbrfDHYjQoc3R8JaovBUaF5DLN3iNiAw=;
 b=DuwNH91ssHodiwcreYLuY/pserepIxEXzAEeyJNLWhVu/gMtUehTbCUzvIaOtow8SKmnVSdjkVQMCgFEPXQ0n0jBOaRVWot4uoptOxJIXFhlHfTOxX1hjIbytVg72BUgw/WclaZYE4wVLb+LqsxjtLUINjr2rQ3nuLxXSo2j+4bPcyn/z6jIAuEfxHogMEnLJx0ZXgG8hPH7gcEcMMuFcZAaCoysy9kNJ1e28O3znIAWrGhmwIxo5uOyPvNOLo241i7GFpWA3OM1ja55Ua+PpUV15uUgWMxvkvu11DcmuWTGPpR5q3yzp2RhGi/XZTGqRbh2LLGfRnof6Vw6H8Zfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjp+tAdQSYhzbrfDHYjQoc3R8JaovBUaF5DLN3iNiAw=;
 b=BJqAVtKcfWM8lFRwsTBEZHqHtAuzJmV7CCWgItYU10fK1em00ZTMVVJUfqW9tPvQzF471gwm2lewM8Pkn79rj1nzxsS085cxCxAu7GIXVb8GQss77QwdRA1MSD5x2lYBL3iBJdzMUIkgykql9EPPfvYWpHkMZVYVyO9kZkmxbUBTIx/B1c+uSjGWRHT+HCARjmJct6pfE+E4+Ftjvss0X8X7EtNGYSCTll/tVzAma9V6wl+C6hJWO+mVpniG4sgE5vGT75F5hHzHg86PiBToPjTvqj1hCgzstaLAldK0s/bFeORQqzyyFnZEMwRqSmyFMRNDTfj/9mFUvatjpz9Njw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com (2603:10a6:20b:b7::20)
 by DU0PR04MB9226.eurprd04.prod.outlook.com (2603:10a6:10:351::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:16:45 +0000
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::e8bd:7711:50e:aaab]) by AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::e8bd:7711:50e:aaab%4]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 13:16:45 +0000
Message-ID: <a59861f6-e138-1f37-3509-ecd39766fd1a@theobroma-systems.com>
Date:   Fri, 25 Aug 2023 15:16:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] TSD: arm64: dts: rockchip: use codec as clock master
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
 <2eda319d-bdd9-bfeb-005a-5989cf674501@linaro.org>
From:   Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <2eda319d-bdd9-bfeb-005a-5989cf674501@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To AM6PR04MB6311.eurprd04.prod.outlook.com
 (2603:10a6:20b:b7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6311:EE_|DU0PR04MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 57194e41-3c57-4f1d-86b0-08dba56d87c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IRwthPMe8iLlCtUWRjiXtyJkj3frfuzWXYCxQew2BCJGvIyCQvjuIrqj16S6NarlB64p7cRGwaPzwoaQV3ECedVWKY3dYEUCtWMq1DQbYI4rzTWjNbSwC3kz2/WR6MJMZMV/jm3+rH/koB2e6dF3PL4bC5lfEWNciGB9kUdajCW3mXqHY/v12SCJ5frt/4ShFrjlNdTLXkJOi8HYo51M03SitzjVwO8hyK32NJWPMOdmjwVA5lm8LKWvn1W4iWr4+bqONgW7C/fmP7AaRflk16C4gEqOiX22DutQBycJKx2WsKq2wm+I3kVfQbAOoiE0LHNNbxSs5Zj5Yg+x0H2rPqBikHZL9Miw2nReauEGtm9VaGP9r3YnnWZ7Odlt4/7PKxu2QT9ChtX6HBBjemaod1EzRQcxoJTfQu3Z27rJJ7uN87uSSfYttkHC8wJTsBYc+8kPXBJ1tcF4d2IPa6rNn0Cijl9v5BM0A5Cm2DpjNR8zO2jJdXFMUkaZvE4HFug44qptCnHyf4We4uMFkY9KBXYXPeV788NaOccX8rB7NsFvU3IWOpc4AWeoqWBEx8eWyUYM1aI68OMBEE3HS4hvUfV3m6UJ5HunY1klMQlZLLoFb0KtGZe0p+VCM2Mg64l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6311.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39850400004)(366004)(451199024)(186009)(1800799009)(6506007)(66946007)(66476007)(316002)(66556008)(478600001)(110136005)(44832011)(26005)(38100700002)(41300700001)(53546011)(86362001)(31696002)(6486002)(2906002)(6512007)(966005)(31686004)(8676002)(4326008)(8936002)(2616005)(5660300002)(83380400001)(4744005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hmbzUvV1dYbVVjaFZmSVc0U3I2WHJ1Tytjc0k3cTBlTkQyWjM0VXpYaVJD?=
 =?utf-8?B?b25UNVI2Vi9pU3NkS2paYXlvVVA1Skl4ZmF2ZEpaZHVTY0JBYnMvUlVsdXF0?=
 =?utf-8?B?djVvNDhqWjR3dTVOVjV2bERHdW9FVTZHM3I2UU02YzJVelJjNG9ya3M3Mjlv?=
 =?utf-8?B?NjZ0MVoxdWIrTG5MQU15dEw2Uzd6ODg5R1lPNlhCWStsdFBDai9xa0lQSi9O?=
 =?utf-8?B?WEdTc2U5SThKOW5GNGZCVCs3UEhKdHpCOGNQZ0FLQUdoTjJzemYya0NMd2tz?=
 =?utf-8?B?NnhZZk53aENoNVozalI5b3ZYc0ZDdTJYcnZ2Y1dHWDJkR0ltM2V1VDdIS1Z0?=
 =?utf-8?B?aUZwbGk3OU1XakNtV3BjbmtXM2ZFanhzQ2MvRHBFeGR6RFc5VWpUc0k3S0NI?=
 =?utf-8?B?MGxYOXlQWEJaNmRTSnpleStzL0FIcXJvNXNLTWI4QmQ3dEIzWHVzbzdBK1lj?=
 =?utf-8?B?Z1ZiMk5DZlRHalZhbW5BR2lxVzNidVJDTUU0R2RLYTZXb2ZFK2hqejJmZjE3?=
 =?utf-8?B?Yk4yNzlqcmtpZzAwTExBTnNSL1FmQlczdjc0UFpLT2VFcENCRkY2Z2JkeEdI?=
 =?utf-8?B?K0xRc0JqSXBkeVVyL0l5dXo5RWNoZHZBc3NPMjhMZWNua0NiU2tNOXE5NytG?=
 =?utf-8?B?Q0l6WndaTlN3Rlg2RjdZQjVEdHNDSGpVQ1hBM09ZcERmU0FYRkxMQ0JtR1JC?=
 =?utf-8?B?Q0dtUjRja3hoZGRoWkc2cmJ1aXlhOEZDNnZWLzE0Z25hSEh0L1JFUlVQeWRn?=
 =?utf-8?B?MDBaZTIrQlhoQnFXZWhVcnQvdEFuSUpsczZGeEZMYUQ3RGJmdGRGY1RreVFF?=
 =?utf-8?B?OUNqUTdubGxyZmFKOG9HUGNDSzhlVUVpNzY1dlUxdDB0RTNuUHVNYWVNakNk?=
 =?utf-8?B?OW1VZUlWQmUzMUlXVEo0d1BkZnVndTVxVzJSQ1dYNE4rS0FTODdYSTRpZnhr?=
 =?utf-8?B?enkyeWZmU3MzMERPakNGaVV0U2hNQUpxaCtLTDRuMTl5b1hZc3BkaWwvYzRH?=
 =?utf-8?B?b1llNE9KOGRxY2dwVWJJK0xUNnhtSStQMEpQTlZzZFA0YUlaSVNBU2I0Nml3?=
 =?utf-8?B?MEdIeWZacXU1enZRenVlWHd1VHovL3ZhOVVtcThNYTFEZ2JIa1V4WWJocHNj?=
 =?utf-8?B?WHpiVWN6ZjlBaGpUTnZQaURwZW1qVFJwYmovTDBaa1ZpTFJTaWZOSnFaSldH?=
 =?utf-8?B?M0k1cUQvS3RNY2huc3M5UkdjVmFYSFl3VHpnUWZjdU9YNlMxRmIxVy8yN2p4?=
 =?utf-8?B?NGVFemQ0RExrdFFuQUJzNjlxSlM3eEtDbHBDeXBoK3JhYlo4ODFyZi9oZmZI?=
 =?utf-8?B?Q0FPYTVXWFdKNjZ6emw0RTdGS2Z0U1ZJaUpHWEF2QzNtbjAvNXg2R3YzeWZt?=
 =?utf-8?B?MnBOWEQ1ZzVhNVBrSWtHN3lqTnVhbzlrRWUwMUZqWS9DRk5kRkE3ZDJOUUFs?=
 =?utf-8?B?Unh3bjhJenNOUHNoREswQXFuMjA1cCtYbkE0bXBHclNTWmh4YW1vdDExZW9x?=
 =?utf-8?B?c3NXWFJUNVVVL0l2cmV0YWhlZ25vZnhHcjFjaVhWVXNWV1R4bXhjOVNIYU5U?=
 =?utf-8?B?akVpYjh4dXBjbXE4aDJXcVp3S0pYeThyK2lSVW44VS90Yndha1RBL3F5cnRW?=
 =?utf-8?B?TkJSNU9LelBnYzR3NXFKV1MyN2V3ck0yVnltQ0xHVTYyS1BxVTl6MkNicEpk?=
 =?utf-8?B?Q2dTOUprZEVpaFloOE1PdGtJQ3c3UXRzMmsrVkxiUktiOW16UFRBR1FNbW5q?=
 =?utf-8?B?K1hrVVVqcG1uUXJmMjJTMmxwT3BpeEFybjZrQU5SU2ZXQ3pFNjdLY0FrTHhX?=
 =?utf-8?B?Nkl6eXRsejZBQ01MUFNnOTFMcElTL0JFdWdzM1F1NzMwL1ZEbFpMbzhmcWJx?=
 =?utf-8?B?WG0xb3ZpOElVdElaeW84cFdEdkZRaG1OL2xqT3NMS1JpZkJzK0I5cGRHbkFz?=
 =?utf-8?B?T3prWXNJeXJUZzRzSUwrS0dhY0lKdXZRdjZqRnF6clpVQU9ENWJmV2xCYmw5?=
 =?utf-8?B?VlczTC8raTdwWHlaUmlkazVPM3Q2MWVnRisvV2FHUGxPTmpZSm5TaXFTSzFM?=
 =?utf-8?B?c2VhYmRVM1BOOXA0MHlyU1l3UmRvMUMzWkk5MHI1S1ZHbytoK0VjcHJ4SG5Z?=
 =?utf-8?B?a3VUL2JsMzliMFhRcVN3cHBsR1hmUXJJOUFYV2pkbTlvNzlqMnphdjFPWXdv?=
 =?utf-8?Q?7heJlZHZVDc67EnfLgfGozp8SXGbgNuawn1mn4S63bNs?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57194e41-3c57-4f1d-86b0-08dba56d87c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6311.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:16:45.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX8eNyw9Sde3NpH16NkDfNkRCwm/mkLmB8+RFdxt8xt9wNsK78/pDIO4M6plaMkLF13fRjMD0rZum3CKLqMJK3PMMZ4cXDVdXSaQCA0YqA7PPf8CUHugdBf6nH9GTs1Wa4B/FqVt/fATpHxSbJCZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9226
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 08:49, Krzysztof Kozlowski wrote:
> 
> What is TSD? Why it is in the subject prefix?
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof, sorry about that, Heiko commented similarily.

TSD means "Theobroma Systems Design" but it should not have been used in 
the patch, v2 fixes that and also gets the SOB lines in order:

https://lore.kernel.org/lkml/20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com/T/

Thanks,
Jakob
