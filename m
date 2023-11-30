Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A67FE679
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbjK3CDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:03:48 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E4D5E;
        Wed, 29 Nov 2023 18:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtA/AMozm94S04TL1+Vh/fDbQ/2PeJxLKwtz4cEINymK5qS4aOCR9HcuVgzE8b2C6CDJ/wBveq+soq5x3wOydKm/m4HzaQZ6Gx1V/sWyr3eS0yWyhwQjEoX/ziqerruMa/Pfhw3jE6GV5OXrmvmqiUZFYlM+JUK+D/699vtTcUhGJA2PXStXYsgKvB6sMncDpPfPisY9EkdfGo7ssmRti/+yCHFiA8zlm5AwjtqhnlIxwRC1pHJkmzQERrujEGpI+u74qZha7/tohdFQUXxPp5cwNqwS/JSZbGiudAKXmAfsoxjNbeNl+0P7m3MrXxS3wPaQbTO9rugDmG6aFm060w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZwEptnBlbK/lXAR6SUXezeV74Wb5oBnQo4qiSMbChg=;
 b=AutdjaqoHSq2JHCxG2fid9rL0D5aKpu39/mqzLlo3SYUXOZtrbQbmSl9GO1kOn1QgTjd8a/3Kn07EQchpJplVWp7tB0tNYvK4/8biymxqWTWr1pg6S6m51BiLWoa37d1qGRuQdC4FK2GyjKlt1qGUgZUDkrW/8o323/Jv0rCbWQWBeDUv1Hsfud7zKpqNFlCSeTdnJ+v1X97WOzXYX7IMXnvv9cczFR8setliPbdj2lh38YOU/eahiLtAvplzaLsVluNDG68tagtjdnBHribbMRZn3t2W5iSBPhQhddRsVqdsl+5TC0/hYFJdLGbvoP4N/XCX1VH+pD5r0NCf0Axpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZwEptnBlbK/lXAR6SUXezeV74Wb5oBnQo4qiSMbChg=;
 b=UGTMMhMlPv3KCVxSj/oH+qj+wUo2XHYKJVcLUdMqwBZlfkSasGg6i+F0eF1tT6vhIZIs1KeYpMgC0pOLjKM+mnBgtho3S2f6pUkdPO2iHMtPc+r/uaimydjF01v+unyNI3XxzS66Elf1eecIo5fKdUNJ/fvMpE2ovtb8TPtxwbsXnnM6iG/Teuzy4y2P/FpxWP2jgyrBzMtHusWKPp6Y90Gp15N5FqM7kjFLokfS/+tn95zLEnwk6qvUaogqX1G6ofBgBdIIm6ueSUV5Nd2DB3Bsf0b8Ij5C9uvREOUaRRQbhJAgTfFKH7yXGAVG5pAOppcgom8E31Q7pYIrUljdlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7418.apcprd03.prod.outlook.com (2603:1096:101:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 02:03:46 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10%6]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 02:03:45 +0000
Message-ID: <bfc104f1-137c-4ad8-8584-d8ca41ce3d6f@amlogic.com>
Date:   Thu, 30 Nov 2023 10:03:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: amlogic: s4: add some device nodes
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20231129092949.2103338-1-xianwei.zhao@amlogic.com>
 <be7501ce-d1b3-45aa-8415-a56cef662d83@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <be7501ce-d1b3-45aa-8415-a56cef662d83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e97e145-d1da-4864-0d85-08dbf148956a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0TPbu+oZmJUljTE/y7j7ViageqBoo4Etufca44OvlVjlAqp9psivNfbfCrYhZ6nkNACkJBZAgXUI0AX0WXdnefRpwUI/ECpYf4op1dJIIeSjmcj/aZ3A9WMcYd1OZjcixNmudajMLVTQAqC4ZscPtILpdwmjo285XHmhxfK/3hdfzGFzC4xgy4R2IesgV+1OeHRDqcEIbCmpHHitRXVA6xcW9w9PATodRJ+KB4XeZevhg6B4GT6u54Yj2r0ALAW6WTs8lsxb0b/y3Yw9Ql3sEHOwnx7ICaFX4rw4FsYtW5ivTUgbpimNCpMUBjM/Hj7/FwH3IyQc352BS7drMWZZw0ICFPWxcxnUGM6cIlOJe+1BJX8QAWbGs/i9NBcURcCphrysof6CXuwSWX5r7es5zIBkOh1ugTz2Y5C/NIx+Wu8EhDMPcTdTEe4I2uxZqV6+g89y95yQ5L8LyDPk6iy+AMpZileasxS1LhmmGvtLD7YivGf0V6DG28Xrjv2ImyBQwvzTMPdl8EiNlw30NabqTKecUrzmMVGKXRmZU0g0OeoJ+vGYiARray4DLl6kJ6+l+GbMZa9oQH05ESxGRu32YL5G2cFtiAoPQ4PbpHkLMZScCWx6IUwbFzPngV7hK96xXCawiGyq4emcpOIAQ1WtHZZ9uwaDjBFQm/Uf5AoH5OodUgOYL1xWiijw/VltvuUwXAsSR01zDxCAVCElzgsbKkO28OKpVL0uaUrD8jVDIC2KCGjK/+Iwq0iGUxnrotDEgNNS/a6vM8pvD8qU/gMxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39850400004)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(6666004)(4326008)(8676002)(8936002)(6512007)(6506007)(53546011)(66476007)(66556008)(316002)(66946007)(6486002)(478600001)(54906003)(202311291699003)(86362001)(30864003)(36756003)(38100700002)(41300700001)(31686004)(44832011)(26005)(31696002)(2616005)(2906002)(5660300002)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alp4Wm5jVlFITEVwaW5kSEUrdHEzeTV1UzkyV0RWcFVpM0lHV2IrZGN3amM1?=
 =?utf-8?B?bm83d3AzV1czaXFlZXpjZ0FleDYydmo4RU9oL0lBMFdFNlRoWFhXTGJIaE4v?=
 =?utf-8?B?WUNGb2Ivbm4valVvQVp0SnF2VFpCWjBqcHczcHBYWDM3RDBzMVlkdWdtU2tU?=
 =?utf-8?B?RVV2U1dCdnJuTUplUURCU2RzZS85ZzdDL25Hc21TdEQzbXIySHdnV1QxaXM2?=
 =?utf-8?B?K25qcUYrQjV4WWw0YVV1RzVFY2JFbGFLTUVocmVzTFpnTWE3MWxFKzAwS0Nx?=
 =?utf-8?B?ZHdRM1krSVhBUWN1eTVKUmlreWoxM2xFTGtJY0tqcnFjZ2sycFRWM1V1SW95?=
 =?utf-8?B?OUNmT3hNTGY5MkFQUzZaaDRRSjJFSXZNWG9BVWJ4OFNReXVOaE5IcmpGbjN3?=
 =?utf-8?B?eGNPajczZ0ZKWkFkVncrRTZjaE9hbmFiUlJuM2JPNlJ5UnVNRDhHNlpqZXdh?=
 =?utf-8?B?NkNZWnhtRXNNYkJna3h5UTVoTGtxL1JiRlFON2lwRHB2cUFxVEhTU0pZeWdW?=
 =?utf-8?B?UlM4cnNHb1FUTGw5azE2YnRsWnc2VllQbzdYTHBNNjhVVlVqQTJBeStZTDU4?=
 =?utf-8?B?V2pjSGhTWGllQzBPYXIxM0lUZzJPK0xlVHJRTWU3Z3ZTeHZaZFk2VFJSNFRQ?=
 =?utf-8?B?cjZhVFFJRDZqMitZd1VZMUNmNjJ4cEhLNTFmRmNiS1o3b3dwVVVOS3p2ZWdu?=
 =?utf-8?B?TGpoV1B4LzM0bXNHWkpNZXM0YXVnWlcyeTMxY2JhSXpvSjV3Z3pkb1R4bkZX?=
 =?utf-8?B?UXExUWZBWFBSZmFBei9JRm95RFg1R1kyc3puTGNXemtHcUhvYU9qdE85VllV?=
 =?utf-8?B?NDBKUnl3U2VqMUlzc0R3bWpCZW12Y2RORDZWK1ZjN0Q1eUI3bEIrMGRodndO?=
 =?utf-8?B?VFB4bEZnSWVjSlREZ1loMlhNUWpkVi9RWUEvQVNncTBZQzhCWVp6d3lERVg1?=
 =?utf-8?B?TzRQclZDdVF5QU92ZGZ2cFZORURkbXZ1OU9JOFp2cENVcnN5YU9UM2hqOTBM?=
 =?utf-8?B?UFMrNC9jOVRwYlFldlM0ZUNZU2hWTkxyTGJmUkw3TURqMi8vbnBBNUJHbmx2?=
 =?utf-8?B?R2Q5TmNQYU4vOHdCUWtPOGR0V0UxbjJid2xwczUvdnF5ZWw5L1htdFc4eXpj?=
 =?utf-8?B?WjhSY0p4UitwdjJINldIQm9vSnN4S2RrZTRDK1k5akF5YnRvaDlSNWkxK3dz?=
 =?utf-8?B?cEdxVTRMNVJSWWVsY29QSTFWSXkrTVVEZHlSQlRJeXdad2M0dTI0bnBoVUNv?=
 =?utf-8?B?NjF6M3d4OVM0RkU5ZDZVc3JlOU9VMWdFUUxabVBPSzR6ZUNXVzgydXFlYWhY?=
 =?utf-8?B?QzY0L0dQMDB3UDZUOVpGVy9MeFpUdjI4YjZpeCtCM2d4cG5zTHVGQkY0RVZt?=
 =?utf-8?B?V2FibDNDby91RVpiZmRaK3RETmFTeUZxYWJzYnc0R2hJR1pvL2hORjJmSVNj?=
 =?utf-8?B?Z1FTcG1jQjNIQjUvMHpwYXArdTNRZnQwMFRmOXVkME9FMXhDbzFUZnE4azRl?=
 =?utf-8?B?K0NwY3RrVnhVQ1FnWDM0eTNnNy94TjlYNjBUQ2lZa0FLVERJLytsTllMNEc0?=
 =?utf-8?B?MEZsL043aWRWcS9XTzFva3JHOUo0bGRPem5GWWFaTkE0aTBQYVprYzFac25k?=
 =?utf-8?B?ZlBuWUhERUR2eFJ0aTNjRFVvZEpiYVZhbElJa2I0TzkyVnBFdkZ1N3M1MjND?=
 =?utf-8?B?NXBxeXVTNStod0Z0WmdGRThUL1dzTDIzQUFaNE91MTlteVBZRndzVE5jbEls?=
 =?utf-8?B?L1hWMFpUM0FGZDgwcmVRSThsRlZ3R0VEak00dHJsZ1pLam5KRm1pcWtoM0pp?=
 =?utf-8?B?S3lDa0pyOFIxdFBJcjUrNmhzMFpSQncxMGR3cVlyNkk0dmtlcXl1OXdVZWRN?=
 =?utf-8?B?a1ZteE5Ib0t6bXpKUy9IT2NmdXowclMxelJFRDFQQ294OFlySERJVXJBZ2lJ?=
 =?utf-8?B?WVg2Tit5U0lIZ0lUZG51VVFNckovdFROYjZoZmRBakg4NHpFQ2RIOGpzYUVr?=
 =?utf-8?B?SlNvV0IxMDljZ0RKM2ZlTVZDYk5xU2krZ1JvSTVFSXBEZngrUW1EVHVPZkF2?=
 =?utf-8?B?cEk3MFFxVUFYTnBBVlhINUZMb1FiR2xYQTdtQzNkMmYxcGhNbXUya1BRL1F6?=
 =?utf-8?B?YWFIeTlxV2ZIYXVjNGVLZGZCZm5ycHhXSm0xMGVJNTBEV052MFlWdlBIRGEv?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e97e145-d1da-4864-0d85-08dbf148956a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 02:03:45.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQbYPNX+4AsQnQD2yA3c9FVkxj9sgSFQH+49qvLPZjAONtBlA2JsfzIkIyZJ9LCYvkDlLOCx03tCQ5rn2Yr7+xNILGdF8g4ezPkN0QJemXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
    Thanks for your review.

On 2023/11/29 18:42, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 29/11/2023 10:29, Xianwei Zhao wrote:
>> Add some device nodes for board AQ222,
>> including clock,I2C,SPICC,nand and ethernet.
> 
> Could you reformat a little bit the commit message, it's a little bit 
> scarce
> and the style is weird.
> 
Will do.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../dts/amlogic/meson-s4-s805x2-aq222.dts     |  55 +++
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 350 +++++++++++++++++-
>>   2 files changed, 404 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts 
>> b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>> index c1f322c73982..fd349c49ebf5 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> 
> Please move the meson-s4-s805x2-aq222.dts changes in a separate commit
> 
Will do.
>> @@ -23,6 +23,16 @@ memory@0 {
>>               reg = <0x0 0x0 0x0 0x40000000>;
>>       };
>>
>> +     reserved-memory {
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             secmon_reserved: secmon@5000000 {
>> +                     reg = <0x0 0x05000000 0x0 0x4000000>;
>> +                     no-map;
>> +             };
> 
> Please add a comment before the node explaining what needs this memory
> 
Will add comment.
>> +     };
>>   };
>>
>>   &uart_B {
>> @@ -34,3 +44,48 @@ &ir {
>>       pinctrl-0 = <&remote_pins>;
>>       pinctrl-names = "default";
>>   };
>> +
>> +&nand {
>> +     status = "okay";
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +
>> +     pinctrl-0 = <&nand_pins>;
>> +     pinctrl-names = "default";
>> +
>> +     nand@0 {
>> +             reg = <0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +
>> +             nand-on-flash-bbt;
>> +
>> +             partition@0 {
>> +                     label = "boot";
>> +                     reg = <0x0 0x00200000>;
>> +             };
>> +             partition@200000 {
>> +                     label = "env";
>> +                     reg = <0x00200000 0x00400000>;
>> +             };
>> +             partition@600000 {
>> +                     label = "system";
>> +                     reg = <0x00600000 0x00a00000>;
>> +             };
>> +             partition@1000000 {
>> +                     label = "rootfs";
>> +                     reg = <0x01000000 0x03000000>;
>> +             };
>> +             partition@4000000 {
>> +                     label = "media";
>> +                     reg = <0x04000000 0x8000000>;
>> +             };
>> +     };
>> +};
>> +
>> +&spicc0 {
>> +     status = "okay";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&spicc0_pins_x>;
>> +     cs-gpios = <&gpio GPIOX_10 GPIO_ACTIVE_LOW>;
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi 
>> b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index 2344b2d741c3..022aba0f9ef7 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -6,6 +6,10 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/gpio/meson-s4-gpio.h>
>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +#include <dt-bindings/power/meson-s4-power.h>
>>
>>   / {
>>       cpus {
>> @@ -92,6 +96,38 @@ apb4: bus@fe000000 {
>>                       #size-cells = <2>;
>>                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>
>> +                     clkc_periphs: clock-controller@0 {
>> +                             compatible = "amlogic,s4-peripherals-clkc";
>> +                             reg = <0x0 0x0 0x0 0x49c>;
>> +                             clocks = <&clkc_pll CLKID_FCLK_DIV2>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV2P5>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV3>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV4>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV5>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV7>,
>> +                                     <&clkc_pll CLKID_HIFI_PLL>,
>> +                                     <&clkc_pll CLKID_GP0_PLL>,
>> +                                     <&clkc_pll CLKID_MPLL0>,
>> +                                     <&clkc_pll CLKID_MPLL1>,
>> +                                     <&clkc_pll CLKID_MPLL2>,
>> +                                     <&clkc_pll CLKID_MPLL3>,
>> +                                     <&clkc_pll CLKID_HDMI_PLL>,
>> +                                     <&xtal>;
>> +                             clock-names = "fclk_div2", 
>> "fclk_div2p5", "fclk_div3",
>> +                                             "fclk_div4", 
>> "fclk_div5", "fclk_div7",
>> +                                             "hifi_pll", "gp0_pll", 
>> "mpll0", "mpll1",
>> +                                             "mpll2", "mpll3", 
>> "hdmi_pll", "xtal";
>> +                             #clock-cells = <1>;
>> +                     };
>> +
>> +                     clkc_pll: clock-controller@8000 {
>> +                             compatible = "amlogic,s4-pll-clkc";
>> +                             reg = <0x0 0x8000 0x0 0x1e8>;
>> +                             clocks = <&xtal>;
>> +                             clock-names = "xtal";
>> +                             #clock-cells = <1>;
>> +                     };
>> +
>>                       watchdog@2100 {
>>                               compatible = "amlogic,s4-wdt", 
>> "amlogic,t7-wdt";
>>                               reg = <0x0 0x2100 0x0 0x10>;
>> @@ -120,6 +156,187 @@ mux {
>>                                               bias-disable;
>>                                       };
>>                               };
>> +
>> +                             i2c0_pins1:i2c0-pins1 {
> 
> Please add a space after ":"
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c0_sda",
>> +                                                    "i2c0_scl";
>> +                                             function = "i2c0";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c1_pins1:i2c1-pins1 {
> 
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c1_sda_c",
>> +                                                    "i2c1_scl_c";
>> +                                             function = "i2c1";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c1_pins2:i2c1-pins2 {
> Ditto
>
Will do.

>> +                                     mux {
>> +                                             groups = "i2c1_sda_d",
>> +                                                    "i2c1_scl_d";
>> +                                             function = "i2c1";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c1_pins3:i2c1-pins3 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c1_sda_h",
>> +                                                    "i2c1_scl_h";
>> +                                             function = "i2c1";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c1_pins4:i2c1-pins4 {
> Ditto
> 
>> +                                     mux {
>> +                                             groups = "i2c1_sda_x",
>> +                                                    "i2c1_scl_x";
>> +                                             function = "i2c1";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c2_pins1:i2c2-pins1 {
>> +                                     mux {
>> +                                             groups = "i2c2_sda_d",
>> +                                                    "i2c2_scl_d";
>> +                                             function = "i2c2";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c2_pins2:i2c2-pins2 {
>> +                                     mux {
>> +                                             groups = "i2c2_sda_h8",
>> +                                                    "i2c2_scl_h9";
>> +                                             function = "i2c2";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c2_pins3:i2c2-pins3 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c2_sda_h0",
>> +                                                    "i2c2_scl_h1";
>> +                                             function = "i2c2";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c3_pins1:i2c3-pins1 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c3_sda_x",
>> +                                                    "i2c3_scl_x";
>> +                                             function = "i2c3";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c3_pins2:i2c3-pins2 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c3_sda_z",
>> +                                                    "i2c3_scl_z";
>> +                                             function = "i2c3";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c4_pins1:i2c4-pins1 {
> Ditto
> 
>> +                                     mux {
>> +                                             groups = "i2c4_sda_c",
>> +                                                    "i2c4_scl_c";
>> +                                             function = "i2c4";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c4_pins2:i2c4-pins2 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c4_sda_d",
>> +                                                    "i2c4_scl_d";
>> +                                             function = "i2c4";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             i2c4_pins3:i2c4-pins3 {
> Ditto
> 
Will do.
>> +                                     mux {
>> +                                             groups = "i2c4_sda_z",
>> +                                                    "i2c4_scl_z";
>> +                                             function = "i2c4";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                             bias-disable;
>> +                                     };
>> +                             };
>> +
>> +                             nand_pins: nand-pins {
>> +                                     mux {
>> +                                             groups = "emmc_nand_d0",
>> +                                                    "emmc_nand_d1",
>> +                                                    "emmc_nand_d2",
>> +                                                    "emmc_nand_d3",
>> +                                                    "emmc_nand_d4",
>> +                                                    "emmc_nand_d5",
>> +                                                    "emmc_nand_d6",
>> +                                                    "emmc_nand_d7",
>> +                                                    "nand_ce0",
>> +                                                    "nand_ale",
>> +                                                    "nand_cle",
>> +                                                    "nand_wen_clk",
>> +                                                    "nand_ren_wr";
>> +                                             function = "nand";
>> +                                             input-enable;
>> +                                     };
>> +                             };
>> +
>> +                             spicc0_pins_x: spicc0-pins_x {
>> +                                     mux {
>> +                                             groups = "spi_a_mosi_x",
>> +                                                    "spi_a_miso_x",
>> +                                                    "spi_a_clk_x";
>> +                                             function = "spi_a";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                     };
>> +                             };
>> +
>> +                             spicc0_pins_h: spicc0-pins-h {
>> +                                     mux {
>> +                                             groups = "spi_a_mosi_h",
>> +                                                    "spi_a_miso_h",
>> +                                                    "spi_a_clk_h";
>> +                                             function = "spi_a";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                     };
>> +                             };
>> +
>> +                             spicc0_pins_z: spicc0-pins-z {
>> +                                     mux {
>> +                                             groups = "spi_a_mosi_z",
>> +                                                    "spi_a_miso_z",
>> +                                                    "spi_a_clk_z";
>> +                                             function = "spi_a";
>> +                                             drive-strength-microamp 
>> = <3000>;
>> +                                     };
>> +                             };
>> +
>>                       };
>>
>>                       gpio_intc: interrupt-controller@4080 {
>> @@ -132,13 +349,119 @@ gpio_intc: interrupt-controller@4080 {
>>                                       <10 11 12 13 14 15 16 17 18 19 
>> 20 21>;
>>                       };
>>
>> +                     eth_phy: mdio-multiplexer@28000 {
>> +                             compatible = "amlogic,g12a-mdio-mux";
>> +                             reg = <0x0 0x28000 0x0 0xa4>;
>> +
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             clocks = <&clkc_periphs CLKID_ETHPHY>,
>> +                                      <&xtal>,
>> +                                      <&clkc_pll CLKID_MPLL_50M>;
>> +                             clock-names = "pclk", "clkin0", "clkin1";
>> +                             mdio-parent-bus = <&mdio0>;
>> +
>> +                             ext_mdio: mdio@0 {
>> +                                     reg = <0>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>> +                             };
>> +
>> +                             int_mdio: mdio@1 {
>> +                                     reg = <1>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>> +
>> +                                     internal_ephy: ethernet-phy@8 {
>> +                                             compatible = 
>> "ethernet-phy-id0180.3301",
>> +                                                          
>> "ethernet-phy-ieee802.3-c22";
>> +                                             interrupts = <GIC_SPI 75 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                                             reg = <8>;
>> +                                             max-speed = <100>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     spicc0: spi@50000 {
>> +                             compatible = "amlogic,meson-g12a-spicc";
>> +                             reg = <0x0 0x50000 0x0 0x44>;
>> +                             interrupts = <GIC_SPI 183 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                             clocks = <&clkc_periphs CLKID_SPICC0>,
>> +                                      <&clkc_periphs CLKID_SPICC0_EN>;
>> +                             clock-names = "core", "pclk";
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     i2c0: i2c@66000 {
>> +                             compatible = "amlogic,meson-axg-i2c";
>> +                             reg = <0x0 0x66000 0x0 0x20>;
>> +                             interrupts = <GIC_SPI 160 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_I2C_M_A>;
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     i2c1: i2c@68000 {
>> +                             compatible = "amlogic,meson-axg-i2c";
>> +                             reg = <0x0 0x68000 0x0 0x20>;
>> +                             interrupts = <GIC_SPI 161 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_I2C_M_B>;
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     i2c2: i2c@6a000 {
>> +                             compatible = "amlogic,meson-axg-i2c";
>> +                             reg = <0x0 0x6a000 0x0 0x20>;
>> +                             interrupts = <GIC_SPI 162 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_I2C_M_C>;
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     i2c3: i2c@6c000 {
>> +                             compatible = "amlogic,meson-axg-i2c";
>> +                             reg = <0x0 0x6c000 0x0 0x20>;
>> +                             interrupts = <GIC_SPI 163 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_I2C_M_D>;
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     i2c4: i2c@6e000 {
>> +                             compatible = "amlogic,meson-axg-i2c";
>> +                             reg = <0x0 0x6e000 0x0 0x20>;
>> +                             interrupts = <GIC_SPI 164 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_I2C_M_E>;
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     nand: nand-controller@8c800 {
>> +                             compatible = "amlogic,meson-axg-nfc";
>> +                             reg = <0x0 0x8c800 0x0 0x100>, <0x0 
>> 0x8c000 0x0 0x4>;
>> +                             reg-names = "nfc", "emmc";
>> +                             interrupts = <GIC_SPI 175 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&clkc_periphs CLKID_SD_EMMC_C>,
>> +                                     <&clkc_pll CLKID_FCLK_DIV2>;
>> +                             clock-names = "core", "device";
>> +                             status = "disabled";
>> +                     };
>> +
>>                       uart_B: serial@7a000 {
>>                               compatible = "amlogic,meson-s4-uart",
>>                                            "amlogic,meson-ao-uart";
>>                               reg = <0x0 0x7a000 0x0 0x18>;
>>                               interrupts = <GIC_SPI 169 
>> IRQ_TYPE_EDGE_RISING>;
>>                               status = "disabled";
>> -                             clocks = <&xtal>, <&xtal>, <&xtal>;
>> +                             clocks = <&xtal>, <&clkc_periphs 
>> CLKID_UART_B>, <&xtal>;
>>                               clock-names = "xtal", "pclk", "baud";
>>                       };
>>
>> @@ -160,5 +483,30 @@ hwrng: rng@440788 {
>>                               reg = <0x0 0x440788 0x0 0x0c>;
>>                       };
>>               };
>> +
>> +             ethmac: ethernet@fdc00000 {
>> +                     compatible = "amlogic,meson-axg-dwmac",
>> +                                  "snps,dwmac-3.70a",
>> +                                  "snps,dwmac";
>> +                     reg = <0x0 0xfdc00000 0x0 0x10000>,
>> +                           <0x0 0xfe024000 0x0 0x8>;
>> +
>> +                     interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-names = "macirq";
>> +                     power-domains = <&pwrc PWRC_S4_ETH_ID>;
>> +                     clocks = <&clkc_periphs CLKID_ETH>,
>> +                              <&clkc_pll CLKID_FCLK_DIV2>,
>> +                              <&clkc_pll CLKID_MPLL2>;
>> +                     clock-names = "stmmaceth", "clkin0", "clkin1";
>> +                     rx-fifo-depth = <4096>;
>> +                     tx-fifo-depth = <2048>;
>> +                     status = "disabled";
>> +
>> +                     mdio0: mdio {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +                             compatible = "snps,dwmac-mdio";
>> +                     };
>> +             };
>>       };
>>   };
>>
>> base-commit: 3a5038e9c0556e51db96c2f7149d853efb886c95
> 
> Thanks,
> Neil
