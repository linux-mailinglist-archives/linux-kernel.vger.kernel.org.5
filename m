Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B108117F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442389AbjLMPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442563AbjLMPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:45:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADE115;
        Wed, 13 Dec 2023 07:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSX9Hv+iZxUr1jxOiwvkufUsloMoCG/UxirrSxVGnt6XGqXC0maiwcqavNLBPJMOFWR/Liu07ynh+BaN5rk7FyXnQsGeYInB4n34u83mcV95lIT2l7H0zZOJYsGlx8jfyJFwk+GLe7+s84Pc/o1ua705gzNNYL2V7VzOy7lYZHSSQuJQpvF3ZWP8Od2INUOaM/izY9xh64478qGIreCxOjiXYKX4kfDchiQbFJQM0JrJkGHey3fkcS1iLSYdbxX9TNykWZ2N1O+GWDw/gYpm2BieaZ2NWRAa2JQUD9NhXdPwpwz5vqQwacZIrbb8mHKdqgpP5WkgtGbNb8iTWkQMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEsWw15tK6MEIjvQ1n1aqLJs7SMA2Bi4s7R2D7YQDyc=;
 b=Tsqov2BfIrMowlxRFP7zKHr4vD97vsrIzREPfeq7O7efZlGKzb+YV6U45PtxLPOYo1OYE99FlqWDxPQPglYZharBzRztKRUCj5lc38fEp0kuB+1bEsneLSJrSTcyL6DWzZmAbXWPPDFJha2M5UAkAligCjS1qdPDVNZM2TW0g4KWtoyIX/3h0yU+hf6oQmZnxSb7xXcbpNADuT+EjB2Uuk3ouV3E0vVxoquh+pOVihiDmxTLQTWuOZIiK0JRCF8l5R+rFLsbnBNjEzL+n3D/hESrmiQxFp0gWz3c8NvaxLtciS5O2ltBhJ2tucu9ePM+NT2cCsFhj1068T8kRzTTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEsWw15tK6MEIjvQ1n1aqLJs7SMA2Bi4s7R2D7YQDyc=;
 b=o2OQjLgrgA+eA+EXqvcw4XNA/JVbmtHDn7bIqRAC4DmP8L+Axk7K2t8Ik4Q5gfdEISiyqZ8FxbASpRkvis1sjmbEtuo6fTUdt0Z75VI5tzbbuAdgkhP2Tu21imU3Qyuf6fMHPwVKOy8mpLQoeF9YEKaYTThBShbPFqu+/3AqBMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:45:25 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:45:24 +0000
Message-ID: <e128d826-0a62-4e7e-b8d3-2a7d2ef30f62@amd.com>
Date:   Wed, 13 Dec 2023 16:44:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from
 arm to soc
Content-Language: en-US
To:     conor@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, robh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0087.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::16) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 301da08f-e587-4095-2dc3-08dbfbf28585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTtf2CV4SZMFdYad0Modp4RTuNx1y6gg4ndBYjw8JRAJZhi+gU2XYL1b5XKo920UdHukejvxdbxEH8vGvMbvd6JaH3TQoyji4PRmjogSc0EVpnH/Emcm8/vNmlW5/bscTP27e/ubsd/8bQEalHEPu7LjOmkl59HZCayZFR0AUX0lfOn15UBXsGvzDfxD5r9yZDsQTzi1AAHSvU1UvNbssJ7VyJM09HVGMdYAYPqUraiXBCmvQ0oU8Cmvg09b3Z/gLkbqllnBADl+5+vajuHVokfLlT8ULYIdN5WjW5+qfOFTUNwLTno6kJtnzzzvtwzXtiIDDs1GzbEu5B6qNFSiVTJMpNVYVYnpF2ylBjYZkOmrwRCUjbm/5TsgldYOPEyNfnZIjZZDnZUv16at1z+avTw2QBm3FmJ/PD06e54fOmwf1VsNb9Co4siFKl2DVmVBDzP2vyGumgFNbsCIol68Nct+sglUISM3kYxDOtBEVLwHN5VJiIpzYAP7EupWJaSiVOBmNrjYAJlT1eM3JkttCPL5mzR5KUwG6+Ct1WfpY5/HoRuJkw+3ZfGWKa1pvRncibqZ4iPGA8N1UsywcDaAvN6gPOY0Si/Z1tTv+U3vcokQz2ucAwJ423ZonVUiSOFGM+fBUuAZhARl0lXPsvSGYngc6R6coEQSmc0JGCUrPmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66946007)(36756003)(31696002)(86362001)(66476007)(38100700002)(6512007)(83380400001)(53546011)(2616005)(44832011)(6506007)(6486002)(966005)(6666004)(2906002)(7416002)(54906003)(316002)(478600001)(5660300002)(26005)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1YrN0x0UndSajUyTkF5Tk1nMzFpWTlTSUR6bWRHOU1CaUo2WlNEbzRUcFFG?=
 =?utf-8?B?d2hIaWdRVEIzR3Q4YXlxWGdQWCtoV2VmaU9GQVpRMVBHT0FDVGlweXR6ekVh?=
 =?utf-8?B?SHM3U0pObWVLSUhJNWcrQTAwVVZVSTM5aW9vN0hXd0M5Qk1GZTJmNEc4SFE0?=
 =?utf-8?B?WmJyWVhiSVNZdlA3bXdTRExoODJLOFVreXVhY245c2VVUkVSNG5LZjlwbHJD?=
 =?utf-8?B?Unk2eWZqVlFQYjhKT2pHbDQ5T1g1RHZxV0NlbjAvM1p5S1IwdDZZNzdRUGs2?=
 =?utf-8?B?bjFwc2VaTW5wbkI5am0zT3dHenZDZDJZcTFFbFlKU3dvOEp3UHpLUktpUkJQ?=
 =?utf-8?B?eVJwUjVaSkpDWFVhVlhmcDlmQnJicUJ3eVBRMG0wSmMxY0Z1STE1MEZ0WjUy?=
 =?utf-8?B?VGl2Z3ZlakFxcWhKU3RqYjVkRE4vQUdIRC83OXhEd0FqZmc1WDNqVURidkJS?=
 =?utf-8?B?NE9MYVJmeVJqOU9uUFdjYWRhS0JrSGNMWEFDcVQvSmdFeVMza3VlSVV4TE16?=
 =?utf-8?B?WWdER3JOV1Flb0c4RWlTaTBRV2N2VzE3SHVmSnJUc2hRODRrLzJhL3crSWNa?=
 =?utf-8?B?UVlLRnJyUG9iNCtBUzVtUllkR3o5Ti9YQWtpbmJ3OS9vOXJ6emV0MTJLbVQv?=
 =?utf-8?B?Mm5JRFNsZUNJWHc2M29JTGJXby9YQW5nRWZqS0I3SmJRK0xsUkpCTTU0L2U4?=
 =?utf-8?B?b2ozaG01U1FiK0JxQkd4OWNmRmRyZFFkSHV4U2xhUmhtNUM2Yy9KS0VTSnNJ?=
 =?utf-8?B?SzZlVEk3ZWhpdk1SN0dONmJTcjVNdE9pTWROSGRtV25VSmtaUi84WU1jWWpx?=
 =?utf-8?B?WTJoNm1oTTJoSGY0Y282V0hlNTVNQnNROURiZmxkTWdzMzM1OXhablhDSEp0?=
 =?utf-8?B?eXRKMmNmWXFwQkhXZS9QNjlBTDVoRm5rdS9ZWjZJR1grUnhIRjdpZjJTOU5W?=
 =?utf-8?B?TCttMk1KWWVoVzNBQ01sWGwxSS9tMnBpZThzWGtPUTQzK2FYUUw1VFZLaHFD?=
 =?utf-8?B?aXoxZGhjMjQxcWpHbWpmT2x1b2VJNlNwTnVVN0ZzVUJJSEI4bnB1UnZ4UlFI?=
 =?utf-8?B?SC9pd08vMi96UDY3TEhqeEE1K3ZuZ2FVY1BPRFNEWGJqMHpqeUttV3pBNDRk?=
 =?utf-8?B?L1N3anhQRUw5V3N3M0hwL1F3YnJJcFVkZDlnaUUzUGU3T1ViVHVqQU1Dc1BS?=
 =?utf-8?B?dnhjaW5HYlVWR0k1YXVuQjZjWGt5ZmYyUXZUNGNrN2g1YWJ2OFp2Y0VJZFA5?=
 =?utf-8?B?ZVpqdy91YWFKR0FSMHZ1ZzUveU9BbFJsMUdGQ0FRbnlYR2VHSHQ5NVRLWGx4?=
 =?utf-8?B?UlJUSm5QblkwTjBnL0E4cEpQVGJkOXFjZEJHM25qd1Mwelk1ZTBLRlJ0ZUNI?=
 =?utf-8?B?MHVIdUtnWEF5MTlCKzJmSkN1K3g1YWltUWY3MUtPdUc3VmlnRHltOGpWRkFX?=
 =?utf-8?B?T09BTUNEZFpJYkJucWVVWmhVYWdGVmhoZ3pIaytYWVRKZzNTUDdyajhZejdp?=
 =?utf-8?B?OWloZEcyS0dtS3UvTjU1eUYwU1k2SmJ5TVh2VWJqMmhEWElVZXc5VTVjTm5B?=
 =?utf-8?B?WGZ6L2k3Ti9XanpudWxIK2UvMkRGeGVNY2dxTFpiZk1jbkdPTUZBL0tkSFda?=
 =?utf-8?B?T2Q4elQ4T3RJZXUvNWNqQXcyR05IRk4vTEE5cWJ0MW1zdFJnVDJFRENVSWZm?=
 =?utf-8?B?YUJ4NGxNN2pqbWw3Y0xMS1J6SzZvOE9mVDhpSENUTlRtYlQvSXFES1VPN0lJ?=
 =?utf-8?B?dkppcUI0dlVpb2doaDdmaEdyUDJGZHd3VXhwdjVsM3Rta2VVdFJUc3JaYzR5?=
 =?utf-8?B?N28xa21hVFVGdURkUkRER0V6cCt4MW1nR0p3VkQrZ0oweEtDdldnSjdPYjRh?=
 =?utf-8?B?Y0FPQVVOMThzTTNRTGl6ZHA2R1hrOTZrZWFoVVZnQ2taeUJPM0hSMVNTbXN4?=
 =?utf-8?B?LzB4eWs0K1RhZVFUTXpQa3dsRWlOamVuTTBvUEFkNTdyQ1U4WWhwREhvSjYy?=
 =?utf-8?B?M0ZGZkJqL3RPTmJRZUxyNWNjYzduVWpCV3BxRmI0M3hJUUNsSk5jR09GaFNR?=
 =?utf-8?B?bWhHUDNvelo1QlVsOTRUYm5WRStBamk1RVlNbmROTW9sU3FxdHEvT1Z2OXhj?=
 =?utf-8?Q?bBocpn8WhC0uRjrJLIFbfIilm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301da08f-e587-4095-2dc3-08dbfbf28585
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:45:24.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUKxAHreDkiLpA6AgWxCTKDIp8rll8cEZ6i3ecL9kyElS3WVHvlj13efAN1ehNs2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 08:02, Michal Simek wrote:
> All Xilinx boards can hosts also soft core CPUs like MicroBlaze or
> MicroBlaze V (RISC-V ISA) that's why move boards description from arm
> folder to soc folder.
> Similar change was done for Renesas by commit c27ce08b806d ("dt-bindings:
> soc: renesas: Move renesas.yaml from arm to soc").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v4:
> - s/chagne/change/ in commit message
> - Fix binding location
> 
> Changes in v3:
> - Fix commit message reported by Krzysztof and add his ACK
> 
> Changes in v2:
> - New patch in the series
> 
> Based on discussion here.
> https://lore.kernel.org/r/20231108-copper-scoff-b4de5febb954@spud
> 
> ---
>   .../devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml         | 2 +-
>   MAINTAINERS                                                     | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>   rename Documentation/devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml (98%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> similarity index 98%
> rename from Documentation/devicetree/bindings/arm/xilinx.yaml
> rename to Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> index f57ed0347894..95758deca325 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/arm/xilinx.yaml#
> +$id: http://devicetree.org/schemas/soc/xilinx/xilinx.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Xilinx Zynq Platforms
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af79..14ad00009a63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3020,6 +3020,7 @@ F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
>   F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
>   F:	Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
>   F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
> +F:	Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>   F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
>   F:	arch/arm/mach-zynq/
>   F:	drivers/clocksource/timer-cadence-ttc.c


Applied.
M
