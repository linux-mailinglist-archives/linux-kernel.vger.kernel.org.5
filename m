Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47027EF273
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjKQMQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:16:02 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83583196;
        Fri, 17 Nov 2023 04:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC5zTTEQkzfOlfAX/KS2XSJ1Fe55bq2xLzNbBwzm6yhiBi+5IXkXgxeQJHlizoV9gykqZYS0xk23xsvcJthOeo2ygzDpXccVfzRQYYsbExZCaeE3bHQ2gEXYH9r/IoPw5JSCZQHwCj/2K76Mi9jQPtka7TiRv4wvBWYBPLGoLo09v/FSQVOiM7GG2dfdJZO32SA5dl09ZNAYpTki9O5xpOPgOxUDE7bSuBEfO9l8X6+TPLBgaf6ahATEtQrRyFkKP5dRX7asSokbCwymyIHQLNe9P0HCKGgYpHe0g18t8qCxNFdkm5Z8seS3mIdEFJ1MiFolWfm1pZYo6JcMCiPjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oQivDRcVc2tYZ+iYZyvBx9mWvK6bp0A82dsI9N9puo=;
 b=Sqv3dmd2C4A3BBo5zOJC/r1iBc6MCIPIEcP1Uhq89iOX77mpcPl2D+dMGNvZQU8LVCoB5F7Es/0lzWMv2XQ1AAdUGlwkvlbkkwTnq/FcYfnCL/p+Bb+Y8BQkfoZiuU9ELVCJeA+eotaJT9IDUgdgASiWNp01AxMVRUv5V/P0WS/FyGxmiZC2z4L01puVoZaEn+eNhmfbcK7pE4g8kWYQnAmCscWaR++fqAlvJihErQu2cLm9I6BHIbESjmxMlkBI2FKzZoKUkPK0gyoZWqQ4kYoPwYmzSlKPB31fEGrI/DyY7atdadp73RY9alwosAK9ex6Gi3hJUWdiZvCJmQbP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oQivDRcVc2tYZ+iYZyvBx9mWvK6bp0A82dsI9N9puo=;
 b=UnZlqsnDe0yHmoXW9tf70rdwHq2rliKqqF4g+KH6xmLbhzkzPiKlkpH53PDEDaZpNgoozqiGG6uvuzgYbdkhHrqD3AxY8MmgQdn+Lk1hbQfDK1NJtKgTxb45hpv3QO/sOwOQ4Jrp3dFsJsjNe3DrsGwYw09ltA65q9IXFGZ4XtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS4PR08MB7632.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 12:15:54 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 12:15:54 +0000
Message-ID: <431375a9-4f62-419c-9ad7-90f3cf892181@wolfvision.net>
Date:   Fri, 17 Nov 2023 13:15:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS4PR08MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6301f74b-1409-49d3-ec01-08dbe766f273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOsTpeuoFL/kxAti3e73Aq8HeARraw6udUzRX7qJwA+XpQ1xXwr2mc1XY97BUYhsM5e+d9rgXob7FrDAYbIVbciQk5BFpUDQC2kApGnKKnp9I7iWx8t+yCZIwL59nQyKC5H9zQiV2tF3s2TpbbXTWJGsdP053SG72LXcPd7G2vjYoGtF8kTkiIPhSh5E9uNysg+NyOgmgHWgxq7Gjud1+MXbxbc7OmVQKgm5d4b/20b/7k0ajqGZuKXwgSPjdTHTMEhO554yXsk2IJYXgJeGWlKOYGysS5HNi32Si/PFS6nDIUjYLnTVO52R7e2CW8dPYs8TPiaTE/D6125zooWlAXN7mTTbvNwkpmckNwu4rSVnqEUAcDM7XwFyux1ir6bIEUKeH2ybxmtQq9dydWgkPI2OSaphlBZlxJGKfKiU/vE/yKk+2L9gWpttedAM6PgEWyTIeETuknqPklB79JjgRDDJZUfGVOeCf/0GvDh2DEV3MCCP6X5pghwSQat+JC+o9bkqvUeO4PG3DCFizkR7wFfJzGFbtC+162lUshS3G2A9Iv8T8X53XpFUI+p90Q8/96ozn1mpJqI60Fv3qRSPL1mFz1+4pwqynxgt5E1F/iG9H3YjUcFFGaKFgd+yaByeHrApW7BDouKEL3N07z8raA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(41300700001)(31686004)(38100700002)(2906002)(83380400001)(5660300002)(7416002)(26005)(86362001)(31696002)(2616005)(53546011)(36916002)(44832011)(6512007)(6506007)(966005)(6486002)(66476007)(4326008)(478600001)(8936002)(8676002)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXUyWXR3U3FOUEd5R0lpTFIvaUtjakNLY0RKMnAzNlV3c0VtQUZPSFJyU29R?=
 =?utf-8?B?MUxTQmE3MmRYeGl3bjBtQkMvbks5WEpBZlB5TGd3ekc5MTdJUnMzdXl5NWk0?=
 =?utf-8?B?TmlyNjR4dkNqei9ac09vYmpLdWpPazZmL1JUU01JRVgrMDROZ1ZUcHpaQzVu?=
 =?utf-8?B?SkcwemxVbDdoZmlmN1h6cWZ1ZExEN3A1WnhmQnFCUjYwUUVUM2pMYkFxOFd1?=
 =?utf-8?B?UE9uRS9iWFZzQjhkMnBYS3FFa25OOC9jemxDS0ZFeGVibG9PRmVKZGxWeFIv?=
 =?utf-8?B?MmdJdTB5c2dSRnU3NGJGLzcyOGdhcWdNejduTmFrTkw2VUp6TjluUWt6Z1VH?=
 =?utf-8?B?RkJzUkJJU2hKT1lkNmFsQnJhVlk2d0RmRU5XeDQrMFJJMFVpNmprMG8rb1Vi?=
 =?utf-8?B?RGtlUmJ0cTlpQmhwaTdIb0VhSjJLaUZzQ3E4bmtTdFNVSjZMc0Z1b3NFd3ho?=
 =?utf-8?B?Tk8weHFmUTkwSEFKWXU5UlhUc0IwSnYxbTRHVmNqdjJKeUl6QzRWZXFSWFkz?=
 =?utf-8?B?VXJwaWRJaEY1RWdNVklrbjhjYTZJTTQ5Mll2NFIrMnRXZ3BjMEJ3OU9ZZ0JU?=
 =?utf-8?B?V21CT0NvdzJGVzFzQ0dTZmo0eTVweFVQdmY2YWU1QVdrK0JNOTZqaVpMRWdn?=
 =?utf-8?B?Wlg5d3pCalRNVEJVejhMdjlWWGFzWUtvR2JEd1BjaW5KRW0yY2tBSjc3WWhN?=
 =?utf-8?B?ZVJFaGowQkRBVkdTNUdMbHNRT09IMWhkTjhSd3NxajFvdjJsVFNaU2JxSUZU?=
 =?utf-8?B?RDhXUmxTV1V6Z3RCblpabnUzUG5iRkMzaUQ2VGhQR3V2MUh1a01mUnJPM3F4?=
 =?utf-8?B?MXJnS2U2ZFhqWVJKenJpL05lejdWMDVxWmVFcmtaRnYycmMwaHpwaFB0MlJa?=
 =?utf-8?B?YTZid2pQTzd3V01jRGF4YnFvYXFRSGl3TkNIRUNiK0dPVk5CUnZ3WHlDSlRu?=
 =?utf-8?B?ajFjNjBZeER0MjBpZmZ0ekZzUWRpclJaODRqN1BGYkJmMzNXQ2tVeDJOS2hk?=
 =?utf-8?B?TEoyaHJCTEFNeGJwVksrM2tEdi9aOW1vcVZWMzlzaVBvUmNTeHRCeUwzOU1s?=
 =?utf-8?B?Wm1qZlZEcElSbkJMVlpkQUNoRnRld2daSTZ1QzVrMVNCQ1BMOVBjSEc0OGtV?=
 =?utf-8?B?Q1g3dTVMMWxNbzI0eFVkWkZrY0h4K3ZxdVlKT3NwMkwzQW4wUmM2Rnp0YUNJ?=
 =?utf-8?B?ODF5c3lIMWxJaThBcHRySzBpd0Era2srSHlXaW1zdjZxZnBiMDkxQXBoQkx1?=
 =?utf-8?B?MVBTUkFDeHcxYzVpdVFLaHo5Y1djcy9vdDd3TXZPTFNnUVVJVHFMYzZXT2hU?=
 =?utf-8?B?YmxuYUNHYlM4UENnckNEUVY5OVlMTEF6MENnT0hWVk1wOHhQNnNxaTJwanpP?=
 =?utf-8?B?VUtaUDJOWURldmhVVm5KcWlKS3JOcnZZTkJHOVdCN3BPVUtSckh2Z2pHbWJG?=
 =?utf-8?B?anFaaUU2Yk0yY2RwRVdmWVhVYTQ3Ykc2OGhWUVo0UXRLZEh6MnZ0ZE1WUzIx?=
 =?utf-8?B?dS8wWkZjRlMwSDdGWVRQaXdhUnVoRWJDaSs4eFVIcEtrK2hEUjlYZUFWTGdD?=
 =?utf-8?B?dG1uRWxMY2lPV3I2T05CWlkyS0grMU5XUVdjaGNVSTdacjFJNGpXNFR4Y29o?=
 =?utf-8?B?ZGJSNjRENEFNaU5hajNjWFU1c0FJVnNQem5GekIxbE53djJMQ0VCOGt1U0NC?=
 =?utf-8?B?RWw4bzhROVUvUGo3d1dzZVAyTW5XNDd2SDh2c2QvV29pZXQyMDZVb2wzZWhm?=
 =?utf-8?B?SHhtNnlVajV0Skh3YzhtZGl2MHpaRXd0cDUrem5tWG5KRnFaUWdLelo1N1pp?=
 =?utf-8?B?ai9WeER4d0ppNE1hNnR2dVZzWlRjanNLcUVVR0gxRHNreUJDcXBwVklqVFhK?=
 =?utf-8?B?amI0WnU2NWNyUHFoMFl1MVB0NldzWWtpOHlLYm45Ky9MbExaU2R3RlNlUE83?=
 =?utf-8?B?TmFoWThWaFk3TGhXYXY1cDRhUElpend0VGdxYVhCOW1tWVJBdUt2TFhRM3RG?=
 =?utf-8?B?YnN4cW5LdGdlMEF0WFVsODQzSThHelZ2QzNvQmZUN1JFTXVJWFNTQ2xEVEJC?=
 =?utf-8?B?NGpxNFJzOUQwTGZSMDZWN21MZ0dnYkVJZ3lJek5XMGV2YnhBZnIrWDZpZGtQ?=
 =?utf-8?B?WGlLZmt0NkxPWEJxakpvc2hjNFZRNkw4NWd4YzdPRWtyQUdDNE8yMVlrMVlz?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6301f74b-1409-49d3-ec01-08dbe766f273
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 12:15:54.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upzMZj2DQ3bBp7LPBSQD5+JbLhsADFUc0rBy8bVDHXS501AyUh2iXCwk3Wvyq8ydIWChIg4uX/dX4NBMlVm+7cTLSnlvDr99qt/CQziHSvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

On 11/16/23 12:04, Mehdi Djait wrote:
> Add a documentation for the Rockchip Camera Interface binding.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml     | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> new file mode 100644
> index 000000000000..580ed654000c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip CIF Camera Interface

May I suggest "Rockchip Camera Interface (CIF)"?

> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description:
> +  CIF is a camera interface present on some rockchip SoCs. It receives the data

s/rockchip/Rockchip

> +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> +  by AXI bus.
> +
> +properties:
> +  compatible:
> +    const: rockchip,px30-vip
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ACLK
> +      - description: HCLK
> +      - description: PCLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: AXI
> +      - description: AHB
> +      - description: PCLK IN
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: pclkin
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: input port on the parallel interface

In more recent Rockchip SoCs this seems to be described as "DVP
interface (digital parallel input)". Maybe we could use this description
here as well?

> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                enum: [5, 6]

Not sure whether this is possible, but if we could use the
MEDIA_BUS_TYPE_PARALLEL	and MEDIA_BUS_TYPE_BT656 defines here it would
be way more descriptive.

> +
> +            required:
> +              - bus-type
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/display/sdtv-standards.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    parent {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        video-capture@ff490000 {
> +            compatible = "rockchip,px30-vip";
> +            reg = <0x0 0xff490000 0x0 0x200>;
> +            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +            clock-names = "aclk", "hclk", "pclk";
> +            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +            reset-names = "axi", "ahb", "pclkin";
> +            power-domains = <&power PX30_PD_VI>;

Sort alphabetically: power-domains before resets.

> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    cif_in: endpoint {
> +                        remote-endpoint = <&tw9900_out>;
> +                        bus-type = <MEDIA_BUS_TYPE_BT656>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        composite_connector {
> +            compatible = "composite-video-connector";
> +            label = "tv";
> +            sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
> +
> +            port {
> +                composite_to_tw9900: endpoint {
> +                    remote-endpoint = <&tw9900_to_composite>;
> +                };
> +            };
> +        };
> +
> +        i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            video-decoder@44 {
> +                compatible = "techwell,tw9900";
> +                reg = <0x44>;
> +
> +                vdd-supply = <&tw9900_supply>;
> +                reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;

This goes before vdd-supply (alphabetical sorting). No need for blank
lines between the properties.

> +
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        reg = <0>;

I think reg property goes first, then the others. No blank lines between
properties, but one blank line between properties and nodes.

> +                        tw9900_to_composite: endpoint@0 {
> +                            reg = <0>;
> +                            remote-endpoint = <&composite_to_tw9900>;
> +                        };
> +                    };
> +
> +                    port@1 {
> +                        reg = <1>;

Same here.

> +                        tw9900_out: endpoint {
> +                            remote-endpoint = <&cif_in>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

With the inline comments addressed,

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks for your efforts!

Best regards,
Michael
