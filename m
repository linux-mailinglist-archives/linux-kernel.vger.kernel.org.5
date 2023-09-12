Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503579C711
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjILGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjILGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:39:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03BE7A;
        Mon, 11 Sep 2023 23:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpWlVjMES3p2t+w0QdmPcv10aHndzguoF3F1OwoyvWfaQ2MNJOXfvr7efInwLzG/5FeVU1F3qcdWJOYnYG5RNSdThFK8OTJQx72iiSjqLGfQ8VLqza3kAGv2gtUzYvuqbgCFaeS7DYT0fVRGstGvvrUCaMcQqcBc1ski/Luyl8UKcQmgWomDMgzU885VGm4+qNBxRRCKH4fLPefzBdZBK9kD3rB2LjNBIoJOrw3RVg8MrGzxWQafiVwEdXrIAIlwCVwfxqrDxeV9MacWjcR6Mq/bbigCMoJI+SGGo4Aa6lOlh5Si/Jf55n6kfyiUznBiySc7OH4bMOxYUeabl85h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCW++eDP/Gnf9DoyRzpYy4ws4V3oEs8BTny0Ng+n7O8=;
 b=YQy5dfFPUmslJ8cKzRhnm48GzBb7ScJ0w/KwHWe3DfjX1NSdzcHB/6z8nHxbzogAX2QbC0xxd9WgiaxkkPZChU/Yy6nYffMUM0jlWHHaTVcGKKmc+/HhSvwcEtz3DpZpGkTlMQ57XNMGzMIz7Ex2ZfWJlNMJHkrQ0GmjtLnJLybquuikq5iJiHPH7XiPtsHgnYCEzuvK9xbarWJmOPqjHuOTveaigkj1wDIxfZ7e5VJiY9DBeewpdEWhR8JmxjnQjlUcMWXhD2xF51PEMJpyuoMdNZo0geyQsv5gpWi6J1PxB2517+5qitoBtAxH3Cytqqv8WRiczgAY1oAHMy1xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCW++eDP/Gnf9DoyRzpYy4ws4V3oEs8BTny0Ng+n7O8=;
 b=CtS0Ji599ziWsE/nkc/c/JVJmvhcjtmLxRY2ru/7Cr/QIQOE7TqQU5T7LUEERfL1XR5OxM2cwelDB9+lUy+VfYPVIO0cebyP6KFkEpexWULm9eSo51jESoRDVG9t4fbtY/uIgsUYwSwU3VKFDetSXSv9nco+HB41T5RDWt2WPyKe01cRthwRl2NQoe8xUgJoWsYzIikqlaCTpBoOKPwJQdgf7MO+4WUODY+TXuoffyBIxOR0f6BJatv2B2IW2eXzdaI47YOlUDDppWdIYoGLnbrZ0denWuwcybIj+PdW8KXcC9owUhxGIgJGpxKxdrJ54WSazOLRFXU3e1bkkUrtvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
 by TY0PR03MB6773.apcprd03.prod.outlook.com (2603:1096:400:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 06:38:03 +0000
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::efac:f92d:887b:8d85]) by TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::efac:f92d:887b:8d85%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:38:02 +0000
Message-ID: <076b59c0-7585-ea98-014c-cd70f92df002@amlogic.com>
Date:   Tue, 12 Sep 2023 14:37:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
To:     neil.armstrong@linaro.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
 <55cbdbba-39c6-7415-37db-97d2c35412cb@linaro.org>
From:   Zelong Dong <Zelong.Dong@amlogic.com>
In-Reply-To: <55cbdbba-39c6-7415-37db-97d2c35412cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:404::16)
 To TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR03MB7240:EE_|TY0PR03MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b98148-04a5-4c06-1afd-08dbb35ad03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: At5gx/ifrrjL37wk9JbttZm+8JZWCeU5/S48XzQk27zsthgsgbpclzgi0ngdLV2XQ/IbOnKm288MUl7nDbr5/sW7n56VxkdMsjeXuQFzBw8QlVtS4t29RFEnWEmCoWAnVWHni1cwunNHdrjaksT9sbUCnSLLT9o4x/yB8+geG6PcLdDilg9jsWYfptZDUvlwCuuAx9RX4d4eNx3rFQjne20C6yXtyAf9a9rFUKuS0CcNrwMXlyLqSGKdSSqNggxNqoGBiY+5BCjHdJaW7Zqb3QHuZNFlHAAoDNWqDAtDlANGQOgZk6fIVZ+Gp4zQ44Adoq6G771f1T6zzjmOKGGRXNxCxh33tLbVmniTlNm5oEpYl49w53mKy0XiFT6S2yAshSPe4j8LTGAbWCk/Wxkd2xAtOfstFIr5K60+XSQkRTPUX0Nw8SfnM//TVZh8tAF83hp0SOa+LHNZFh/znjSXt6SAOH33moNS11r8ofFj5r49rQbwMpGfvFqyF6KzU4XunzW+huZLkqSxujyxoDcGqLrtEOBBrxPGaYwPuglqemE0mWINNmBWMdUopomoH8vVnaU3qcsUh5w/wsXRxpMgt23ITUK9DhXCBMi/4v3C6hnZ7dL8d33vz6Cr56lkav6HbyDoPONX5ywi/rS6UA7C58nynVDxQk0+fGMZLJZFZJtHLldHnvUPSa+yF3IBAsdinW9UYNZi0re9WhtjcPf2eM0mlZsPIVm3MJlhyiPGyCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB7240.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(36756003)(107886003)(4326008)(66946007)(110136005)(8676002)(8936002)(478600001)(2616005)(6486002)(66476007)(6506007)(41300700001)(66556008)(53546011)(6512007)(316002)(26005)(5660300002)(6666004)(31686004)(7416002)(66899024)(31696002)(86362001)(2906002)(38100700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NkejNlNE0weE85TkV6Sm9Xdy9NeGZQTGk0cGl1L2FsR3E4M0tMTkEyZHNr?=
 =?utf-8?B?TlcvYzZPNnB3SDVkSzFyQWh2WGNlU1BrVDVwVEVqRmliMUJOWUx4Y2pXdEp3?=
 =?utf-8?B?Ykoxb2hPM0xEY1BBNlpQNWU2M0planVONzNURm5ISm1KSkxMRFF4eldVakU4?=
 =?utf-8?B?dStQM0ZadEtaUi9COWVFMUF2ZFRLVDBDUURIY3Q3eE9jSTMxYStKMmxKQ0RN?=
 =?utf-8?B?OGNXeTRlTDRhR2pEYkY4b1pucDMrM1o0bFpqZ3V2amdaSHh1LzJuWjROaU1B?=
 =?utf-8?B?MmxPOXNVRlF2ZXVtQm85dmRxVXZ0ZGxJYzUxR2ZKa1lDMVh6QVhZY25WeEFB?=
 =?utf-8?B?UXVpdDZjUzBGeUN2MTFDR2pIbDYxdzNxejZpVjhmeHRCVU9aQ2FzeWpta2ZC?=
 =?utf-8?B?a3dVU2VtYWRLOFg2aXZjZFRYUDc0cXhsN05LcFR0dmlEZ0FkRW5wbmJTeDMw?=
 =?utf-8?B?L3J4SGpKVm1yN1FxSFZ3VlVvRHl1L3V6aTVjQXlCdkJ2dzNuNzVDWXpEbWgv?=
 =?utf-8?B?K0UyTjlkcVhuUFZyeTVkR2JkN0x3MXpXcXhPWEdybUNYVFJxdncvME5HdWQr?=
 =?utf-8?B?cmlHc2VnaXh6Q1pwRXVpdFlNR1BvVUdvVElRVmYxd2FKNkpSZU1sQ2JQQkgv?=
 =?utf-8?B?YUpETlBCcFBLUGdWTUk2YUROYUJzblVzNWxnQXpXeDRCdGJsNFlwbXJ3R2h1?=
 =?utf-8?B?bldXaERBKzMrZ0FvNU9xQmR4dDZteVJhUDc0b1R1ZnVvcjlFMlF5NG10SHJ0?=
 =?utf-8?B?MS94MU9halpNZkFDbXpOcnUxb0NUS05Jd0diMlVSWDJHdlovcjY1WlE3aUVH?=
 =?utf-8?B?a3kvOGJoS3VvNC9xbHV0eFFBM3Q1M3k2SDRXTTBHbE52Zjd1YXUxY3RGMnRm?=
 =?utf-8?B?NnZSczFUN0RXREQ1MCs2QUNXdS9tdHQybXl5bG1YR2hYZ3YwTW03WkRKYVlJ?=
 =?utf-8?B?R2lHNWIvM3IxZC8zaWZ3UEhKMVl6V1pjR2JSZzVtTmpvdGpUdlkrQmFWT2Yr?=
 =?utf-8?B?ejhueW9uK2Z3VDNNZUNxcHlKMEloNjZoY3NaY1lpL1JsSis5WldmeC94Ly92?=
 =?utf-8?B?QjhpUVBMb0djMWo0QkVNcmNqUmo2V2dnOWRFNmkyQnhWNXcyd0ZPVElFVXR1?=
 =?utf-8?B?YmVqZEU2d3dSQkhjTDh5SjRCWWFVZlBjWTkrTzJmWmlWWFQ5Y2YyUG5PQUtk?=
 =?utf-8?B?bXM3U21CVVk2cEZTcFp5Lzl4Q2xZSmNIZXlERUliRGN4SjNFdTZWREQyc2Z5?=
 =?utf-8?B?OVpwdjI1dmx0UUV4citwQWVaYm5DWmNJYnFFZHdNcTdPSTFVckdRZFRTVkFH?=
 =?utf-8?B?SlJhWm9FU0g1U2thU0pBQUgrcnFBSjVzRWlQNkVnU0JweFVYdnRaTndxK1dh?=
 =?utf-8?B?L0lYbTBNV0o1MDRvdnpjbjNLZEtpUDF6b2RWbjY5OTFISlQwZU93dkN1dlIw?=
 =?utf-8?B?RmR2c1cvTzY4RFJHQVNlMGNJVUg1ZytLSDhHMU1oMGUrODdqZllVTXBlMjRh?=
 =?utf-8?B?a2lsWmkyQ2lDNVVrSVh1VC8ranppZXhnYTVtRXZuRTRNVitYUzIrTUJzaGNH?=
 =?utf-8?B?SE9Od2pWQ3BNVEZkQ0JKeUx6c0d3S0pmeEg0Y2xuOWhKNTU4Wjh6Lzk5cGlR?=
 =?utf-8?B?Yk1mOGs1YXhQMktyYkhjN0N6VnNXdW94RlRyZ1Y0Q05KYUVmeHVtN0xlQW12?=
 =?utf-8?B?N1MzYUFBNFFFWjVPT2g1WXpqeHY3OCthN25PaVUyUmk0ZlBRK2t3b3BGM21C?=
 =?utf-8?B?NDkxRUpMbHZjZlduMDdNYlIwam5jbXNqVVA5SEtvSUcxMWQ2L2loQnpWTDNi?=
 =?utf-8?B?dTVvUi95cnkzYXBIQWc0dHlRWlpPeTJHWEJNODlMV3BLcTAwb0U4ZVBYZk9D?=
 =?utf-8?B?N2h5d1UzZ2c5MGM0d1Q4NFZBcmFDc2NOM2l4RzlEUzM3SEsyMzdEVVBLWnpv?=
 =?utf-8?B?UHNYZXNUNnNmSi96ekcwYTBBaTVYNERUU3pmTUpMRzVLQzd1a1dlUlZGYXlo?=
 =?utf-8?B?RWVjKytheS9QNVpab0F6L3I2S1BNRnNwd0hHNjJuck1raDBIRTFjUWNEZ29r?=
 =?utf-8?B?dTFoLzVCeDlkc3ZpRXdONmx6ZWRYYkhQWjBGck5EcmszM242ckYxcVJneDFk?=
 =?utf-8?B?NHZMV2VneTlaTzg3N3p4U1NHLzd4dEdKSzRlS1lvY21HanRlTGU2K1o1cGV6?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b98148-04a5-4c06-1afd-08dbb35ad03d
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB7240.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:38:02.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLYMbbH9STp+G7nm4lVvqtuzhzhFQcwlyVjjh6TsuMm3CTBEqAwLuGNbrcyf1BEzBncuVcF/2TsI7sO/83bikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/7/31 17:17, Neil Armstrong 写道:
> On 28/07/2023 17:49, Philipp Zabel wrote:
>> On Mi, 2023-07-19 at 14:09 +0800, zelong dong wrote:
>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>
>>> Add new compatible and DT bindings for Amlogic C3 Reset Controller
>>>
>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>> ---
>>>   .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>>>   include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>>>   2 files changed, 120 insertions(+)
>>>   create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml 
>>> b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> index d3fdee89d4f8..f0c6c0df0ce3 100644
>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> @@ -18,6 +18,7 @@ properties:
>>>         - amlogic,meson-axg-reset # Reset Controller on AXG and 
>>> compatible SoCs
>>>         - amlogic,meson-a1-reset # Reset Controller on A1 and 
>>> compatible SoCs
>>>         - amlogic,meson-s4-reset # Reset Controller on S4 and 
>>> compatible SoCs
>>> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>
>>>     reg:
>>>       maxItems: 1
>>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h 
>>> b/include/dt-bindings/reset/amlogic,c3-reset.h
>>> new file mode 100644
>>> index 000000000000..d9127863f603
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
>>
>> Given that this is only included by
>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
>> moved to arch/arm64/boot/dts/amlogic ?
> 
> Maybe I missed something, but since when should we move bindings headers 
> to arch/xxx/boot/dts/vendor ?
> 
> Neil
> 
>>
>> regards
>> Philipp
> 
Hi,
It's been a while, how will we deal with this patch ?
Should we let this patch apply first? If Amlogic reset bindings headers 
need to be moved to arch/xxx/boot/dts/vendor, could we apply it in a 
separate change?
