Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C717931C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbjIEWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIEWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:04:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC30E6;
        Tue,  5 Sep 2023 15:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNcCU1dKnNxcoK41XlUEBdzzsJzJFhl6/4J1qtdPplhBqmlOhKrW8M46clrUZZtgSifSFGX7uzFF4DxDRnrdukR+X2z/w0yZqK2UuKnqFJVFZmAHjw1r2LDeSzrlXCf1Gb7woQCHEwaGIbRk7SxThRDsuXLmuxUHKi4DmEAj9H5QygGzVCRfBH2OMj+GyzqMcyG7r9vBDl3Q4XCCOxrvsBn1PMoiq1APfRcschz6+WqZYBtDaCZg+fwlhrrIM5UarZ+LOUM8A9+KsuppdSgoJESNdxvr46++BSC33myap1o1FeplH5WPX9Ema5m+aLOzGkFkOh+JTfhQIRit+xICdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFMDGAvhtWuJX5wR2WXJf171ZYND3syZxkm2gRpG9bo=;
 b=az86mWX/mQbk2J1LizfGWMKApmL2cFjPScvuoNrj2T1vcQNQvC6S5WaRu2/ap2fUUgyX2jutMFRrY5/6ZldGInQpXzreRMY+OFlGOoOiqz/JLubLAMZxtYRj3r7W2RqReA1PRN/SD/07FyFkPuY5I69shHWjgGNWuaZSqPO53aj/0HRESMSq2ChN33gD+KWtyEWCnc+wHm+i+ldPYnVDXbCwl8aXxwGirxtMUF313P1ObMZU0cFJ7GfWImShJ2Sn26FLMM1d9xygtlUSa6Yxuo78HQkKgaERW54+ViVOXQeAj6a2mqfe1/257BgZBwD+1DLsEMJbObZSS8N62CRZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFMDGAvhtWuJX5wR2WXJf171ZYND3syZxkm2gRpG9bo=;
 b=DHop+2mTBbLKdNGwjsFKjFw/+wDPz45+T7yrVou09iCTiORjn2X6oeYwSukH9arXGhsU7GO9sVwP1KpyeoQFvKVkJS8Cic6SBYHymPFcH61br/ZbGCOhateDHyW+s29VqjnU4pifHK5ptFi9dAkW72HMcJLigFXueqpRutpr8c4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS4PR08MB8094.eurprd08.prod.outlook.com (2603:10a6:20b:589::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 22:04:01 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:04:00 +0000
Message-ID: <08130247-1ccb-1233-3feb-a60e6c0b3610@wolfvision.net>
Date:   Wed, 6 Sep 2023 00:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf8523: Convert to YAML
To:     Fabio Estevam <festevam@gmail.com>, alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230905202827.67212-1-festevam@gmail.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20230905202827.67212-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:1::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS4PR08MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: ee151bc4-5a3a-474a-353f-08dbae5c024d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLKOFeQI9XyQaaCwKJ13l53/ylkCA6YgBs5EXUbcdUEQ+n+fb+UgWbjRSXioB71tZ5Vtu9+ij49x9z7W9hw1hoGbCXj8ZSuT++lAVEwD2qFkb8EYw8fD47dKiYwfNmocNyPj3kNkfz71T3LNowUBVOwRT4AB9eI8PFnPldDvT9+6y0t+kdNKqWkaE63HkXhT1XDx/D0Pcd2zq30q3VqXxMhl+/Xs+YGBKS23VAk4xAuReUpuE2nzT7UOIRskdE1jv4Xt/nHXSculCKUw3B5ce6PgAwEbqu80xyt7DgV6JuoG9I/ICDwyZaVwRB1lx7kwh3xlTGoPN6MC80ycZ2FtCQdkw2ERL1H994qzBnu1rsrZCHwQWxeWiE33NsLTRbg1810dTV5QzmA9BcRloQoCAnjXyjtdI9K+UfFK81kayJOa/vCov0rgonLSwtYdfZThBMeuYmwpdMeE5+I8mjW4DobkV7eCWJZ+vBG7LxSFUb5yds8O2AJ2+HKhUUpGtkGL8aUgtl3Vt8r8t9fuk3Tn3ZjoXT1EXyS2XybPdd4j68DvN8i1Wg3XRWdhVj+FD6Lv+4yd7fdnTM/K8zJXXB30NpDgv1CpRhkH6MKHqVEMwAoAJnwSCNa+3NFym7smUzi3USgmHk7KYx/zjlnkYz+5/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39850400004)(366004)(136003)(451199024)(186009)(1800799009)(8936002)(8676002)(31686004)(5660300002)(316002)(2906002)(36756003)(66476007)(66946007)(66556008)(4326008)(44832011)(7416002)(41300700001)(6486002)(6506007)(6512007)(53546011)(6666004)(478600001)(966005)(2616005)(83380400001)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FmbDQ2eEtJbDNWSnFUemRtWmg1UzAycFgvK0hhMDNIYzNpVEI5V1RJRUly?=
 =?utf-8?B?bEJQN0VmQURGaXJKV0lFNFpPUmVYYjBiMWNMdFpEcm00WUYzR0FkbEo0SVJ3?=
 =?utf-8?B?NHU4WFlqL3R1MFdUMmEzcFNHMnZOV1hGR0t1aGExbHNDRnhFOXVacHVGcm5y?=
 =?utf-8?B?RFBKUURkSkhOSjF6cTZSaDZWL1dZVGMwNUUvR01KQWRyckI2Vkg1Y1VOWHdQ?=
 =?utf-8?B?eW9maGVnWldxU1psc29yMjYwZkxWLzdpMURRRDdXeVh5MDdORkoxUDlaeTJr?=
 =?utf-8?B?eDhPb3hQRTIxWXFBSU9LOGEyRzJhU0ZDd2JaNHVXc2IvQVFHZXJEcXhtTHdB?=
 =?utf-8?B?WkNwZ1dGcXZ0dFNoVS9ZeENiUmZZaHB0ZkxOanM1ZmxEL0ZycFl4K1pNZXZx?=
 =?utf-8?B?RzhoNnNkV3lsYyt6dFRnTG5lYmNuY2lFTnlGK0hWUUI3TDRtMVQ1aFVQV2RR?=
 =?utf-8?B?cUU4a2loUmNvSS9JZ1dFMER4R21UamdXRmhYOTlXT0ZueTVaMXQ3RjhGTFM3?=
 =?utf-8?B?enVlb0lnR0xFODluUXJmRzZjK0VITmsrbnZOTFphbFFTTDBxb1l4cXlMalZr?=
 =?utf-8?B?UXFlcmowTTRhSDVOYXRVRDkvcDNaZmNkUVVSdi9YVkV1d2h0djI0VWxsdmFt?=
 =?utf-8?B?dFhxeHp0aC9xRGppbW1UWmIvSU91b1FzV1ZncXIyY1l3OFVPVW5uNVRDcHgx?=
 =?utf-8?B?N1ZualBVS0JNNDhzYVRhdzVJbHRkZXo0UEU3QzRSL29tbzZaTU5obTA4ZWxs?=
 =?utf-8?B?ZnEzQ3NjS0EvbEFZa1BPWE5kcG1GUHRhRHlkLzIyZG1zVDJMS3dxOFArVnBE?=
 =?utf-8?B?cFprRS9VTVNVN0p3Mmdod09HOXR3amQ4eHdYa3o2K2pDWmZGdTlqVW00MFJU?=
 =?utf-8?B?NGVRUEtUSjEzOUN5dHRQR1pZc0FDQUU5L0RQVHN6YUFPd2plUm1kYTVyWVhQ?=
 =?utf-8?B?Z2J6WHZrRFlLeEtVRmNXbDFKU0tjcEdVbDZSaFFOeVBVbUkxZHM4QU1LVWhy?=
 =?utf-8?B?K0lZd3o4Yy80bGRXNk1RdEZIQ2R0NUpwUHU5bUhaazM5L2Rlb0tvT0YyU2NV?=
 =?utf-8?B?RlhWcXNWTTVmK3FjLzhSNE1FZWhjdExpUC9sZUM5c0ZPakRpa0U5REZNMnVI?=
 =?utf-8?B?OHgrME53N0lKT3RzYXdVWkExYk1rN1oyQWUyUHd0K1hoMFBDakhwRCt1SVhK?=
 =?utf-8?B?R2xGc3dVNm01djNsY0s3dTJsOThubFZTZC93Umk2YjB4YWhNNG4xaXdPcGo0?=
 =?utf-8?B?L1ZsWEx1a3pHM2dNK0Y0RUhpZHc4enNDVHEwNUFmdGFvcC8yQ0daVUExODB0?=
 =?utf-8?B?L1UxTTF0ZHIwdXltTmVaMFlCSzI4Nm90bHN3TEdkUVc3NnJ0RTUvRHpMS211?=
 =?utf-8?B?YndGVUcyQWRrdU53L2lOK0JtaGNMV2I3MCt4QUtYTm45M1g1MnViSEdweVBH?=
 =?utf-8?B?dU9NYktPeHBqbU8xMnJiN201REduQ0tJd1VFTnFsL3dqVWZvdTFFVTZzUUVI?=
 =?utf-8?B?VThrcVFOaDZocjN4TEh5dFJpanhodnpPb3ZmZjNJUmhRZ1d1TUM2U1NmU25k?=
 =?utf-8?B?bzFWZGxSSDAzcUhDZkJwQmphSTd6TUhxTTc3R2QwVk96c28wd1AzSHNMdks2?=
 =?utf-8?B?OTZKcVpFekp2RXNnRU5rdnBKbGFOL253R0VmVXFQOVUvWDhPOTFMdmZyYWdO?=
 =?utf-8?B?aGtCb0dVOTVQRGdQUUN5WHdjOEFSTmFXWTAzbHVaTGdJWE9jcWlhTmxoUjh4?=
 =?utf-8?B?M0lneElHbHloQlptSTc3MGRrT1hoNjQvZTVnU3pZbVFQaGVkOUVzVWg5R25R?=
 =?utf-8?B?eXVTVnlJejFSNGU3R0ZveWYwdTA3YTRGMjRuK2xHTnJ1Y21BcFFuNmQwcWU4?=
 =?utf-8?B?Z3B1QnhJQXhPZGFBbG4wc2dRN3lCVkV1YjN6cjV2T1R4eElJUE1wV016SnR3?=
 =?utf-8?B?aUdKZFhNSHZ3OXcwSHZLZHZpQ05zOW1WUmppMmZMUDlFODhnUndnNytueVYw?=
 =?utf-8?B?VTIyWkJZVDFwV24wNFV2TDM2YmkySzZqblVaaUlrd3VlRy9zakFsbW91azZi?=
 =?utf-8?B?N2plUi85UEZrQ1VsNEJubE9MZHM3NnE0T1pmaGZ4WndScGtrdFUycVlvYmo4?=
 =?utf-8?B?ckZHK2c3d0t5NnZ1bjVtd2wrM2k1MDN4QW5PRGZ1N1N4QzFqc1doaElQZXVJ?=
 =?utf-8?B?TnVHY1ZJK25CUUpkNUNxUjB4WVRCbkgrOWJNUzA3RGk0eldYS3E1WVBsQlZX?=
 =?utf-8?Q?XkMkrATJ4HIlwCODJHGm7WVMwASXR+lixnQomeC6N0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee151bc4-5a3a-474a-353f-08dbae5c024d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:04:00.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H04DpHqLddbXQXghnJpCsuCzIvZ9FE5H11al9im1YNVgKnu7QqzReZD9i1HdeYqHid1EYXd0VzB3mZm1wHJ0PEX7uqS5co8URepwaYS7+n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8094
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 05.09.23 22:28, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert the PCF8523 bindings from text format to YAML.
> 
> The YAML format is preferred as it allows validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Add the default value for quartz-load-femtofarads. (Krzysztof)
> - Pass unevaluatedProperties: false. (Krzysztof)
> - Fixed a typo on Sam's email address.
> 
>  .../devicetree/bindings/rtc/nxp,pcf8523.txt   | 18 --------
>  .../devicetree/bindings/rtc/nxp,pcf8523.yaml  | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> deleted file mode 100644
> index 0b1080c60f63..000000000000
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* NXP PCF8523 Real Time Clock
> -
> -Required properties:
> -- compatible: Should contain "nxp,pcf8523".
> -- reg: I2C address for chip.
> -
> -Optional property:
> -- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> -  expressed in femto Farad (fF). Valid values are 7000 and 12500.
> -  Default value (if no value is specified) is 12500fF.
> -
> -Example:
> -
> -pcf8523: rtc@68 {
> -	compatible = "nxp,pcf8523";
> -	reg = <0x68>;
> -	quartz-load-femtofarads = <7000>;
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
> new file mode 100644
> index 000000000000..8d17b89fef5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,pcf8523.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PCF8523 Real Time Clock
> +
> +maintainers:
> +  - Sam Ravnborg <sam@ravnborg.org>
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,pcf8523
> +
> +  reg:
> +    maxItems: 1
> +
> +  quartz-load-femtofarads:
> +    description:
> +      The capacitive load of the crystal, expressed in femto Farad (fF).
> +    enum: [ 7000, 12500 ]
> +    default: 7000
isn't the default value 12500 anymore? it used to be and the driver
still uses 12500fF as the default value.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            compatible = "nxp,pcf8523";
> +            reg = <0x68>;
> +            quartz-load-femtofarads = <7000>;
> +        };
> +    };
Best regards,
Javier Carrasco
