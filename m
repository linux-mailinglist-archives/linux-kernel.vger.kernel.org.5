Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475457F150E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjKTOCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E792186;
        Mon, 20 Nov 2023 06:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3yX3gdDa+o/usFXboNbk46a4sdCNejl+DuNptpZQgF2FUBqHwCBjjHiTLf8VJwt5sacgFur8CP4hBMX5OzvZnn9yWfT0nFxDnxxgz3A8KFMiW1lu8GsBEs25BMBlC5sZwKWvNUj/Hl9PIdiBqCzkbJ4W6uV1b7K6ZFUaa05W63LnmSbzZ/FA0RLufJForo/jBodCfzwlOC9FgcuznoExFhaI3A1aMpzuSgb4sbNHS4EsZPRwVMIP/CeP6ngV/n7V+D0zPJ7fLq0Ed6/tkzk2iNrNAoZFr2xue5+vjE7W6bD7sUMvP/58s/lmRMnJvUeD02va9HJCLHICzF/pA07nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywHs5lUYJ2vNER7J2nVzlP9QBmdtjX2TGPM1D8q7vbI=;
 b=Dv4Ox/yFpmwyKDrNi0uxqJxAla37X1yg3C2+U+81CyR+hwYaaS5FckqtuBEbRyq+zJTvXyNrrG0x1+iOjyddPuSwexmoamPatlF2usNfWuHmRa9wqtRGcS3nTT3MuyD5IxzI6aysrBGGcRLi3wI93W2SUkhOPBLOYOFnySt+cPF89nUgDoNRcf5r6jRqIvh8Q/ogOhCwOitzkQuIFpBD0+PN/hVoXaQelCat7XRtLYan8MPvmnZXq+h4XjvmqcmbkzakZj6CaozSq0FWEcnocNlrufWpSI1k4QpsvxkPGyT4CPKG2zubEVqogIxajuSGFv1YoLl5biZr4DlOGSkxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywHs5lUYJ2vNER7J2nVzlP9QBmdtjX2TGPM1D8q7vbI=;
 b=fwkYtCBWf/frkB+b69/U3XqNIIVVIJtPZvUlgcjrlssTz/bS3CPckE4wPmtOjNw0bOId9gfUGoduTKUR0GHAUmiKbYuuzqr28taUKkLdHkSGLUy2xjzpgPOkdrcmcmBEeCS0woAO2tBJuMqBekBMwWAmIHQ+8al9I0+dz1xtsRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:01:49 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.021; Mon, 20 Nov 2023
 14:01:48 +0000
Message-ID: <19358871-009d-4498-9c13-90d5338b1e9f@amd.com>
Date:   Mon, 20 Nov 2023 15:01:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:118::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 02115a79-0e25-4215-23dd-08dbe9d13d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /E04uk1V/qJzTEnwBkPnzzKhmXlqwuJzpZwEyhH3FNItR+4r/JCIBW96ECpy/HE9kJDHWR4pG+uMG4AqOG5W5aIH0W8JQ1zJR68DmIODfHt+FwS66bu05O9tCOAtqLT0yqjt1N6OPOk0ot0f+A0EL8oOVj+TYOzPHSXhT7VaaqjrNA4a+YdQt0zoTIt2Zn9s8+4H38xeiWHPnOEn7CCQFKexcXsNV4RlkIWNDPHX/6bQv3noFK1AqrbGuXTM3iaEivj1jxGi3FSDKC7dhDSDKstMqj1dGodSS+8glGtSoJN98eodOXTrotEHfj2rKV8/XfuGuYS4wS3LAoOZAXMsih8WpEVjZdaA8TfmQgkib+8I5mp5k32SG+yEjkzHggpnUdSzSdyTCPMhoPX9UhM6pCT1sOypPV+F/QtjzoJO36+K8d1TRfOcVUjLmYMBuHYHU1Fs0KTyyU5wduhF/tWs0MgxFOdQsYAcxlEUzq+f8Ly9L2goRXwPDdEC+MnHrjHby7/pVCUqvUU8D+L+xTHQEO2p/euw1Q7Wnv2bRZjcQu10tZcHcE3kQymGTeMFqZngXzcLrK/F829HVAkNrB38eGMCODQ6PpWuh0Abl3J+d0afzej/TphDrBXbkiG5ge3U6ORFWMWDTecNnr7L4aVcoqZ0aRXm6B8/Ky7Vbm2HPsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(110136005)(66556008)(66946007)(316002)(66476007)(54906003)(26005)(921008)(8676002)(4326008)(8936002)(36756003)(38100700002)(41300700001)(44832011)(31696002)(86362001)(2906002)(5660300002)(7416002)(83380400001)(53546011)(6506007)(6486002)(478600001)(6512007)(31686004)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVzZTh1UFlPZXcrTTJLNzBtM2JqY2kyUHdwQWdnNm4vRWpiT25PczRYQ21P?=
 =?utf-8?B?VEVoUTZKRnJnM1FkNmpISFhFVHBDcUVDNHhJbWRYSEpWVXFEbnl2blNBY0VY?=
 =?utf-8?B?N3JSZjFpVWgwU0ZLRi9paDZVOWNQOGptaUt5VGhrdzhTTDlRWnNMOENLZWRo?=
 =?utf-8?B?ZnVhZnFjK2NJTEhmdkRZQXlmSHBmdTh6cHpGV0kzVEw3aGpJcEhrSVpudnVm?=
 =?utf-8?B?TTBvVGdmOCtxVWxUbndNWVhISTVMbVN5R2FpYVIrZHFBcG5TSys5bW5kdDJC?=
 =?utf-8?B?VHZ6RmRZb2xydkp2aXZjMG9IRWkrYmk0cnZqaUhMVnhzZUYxcVNUSmNBZDNB?=
 =?utf-8?B?R3VoY25ZcktTNklUU0Rpc0I4Si9GOW1DUXk4cXk1bTRtUWpQUG1IemZka2I3?=
 =?utf-8?B?bFBDcDNHREE4WWZLeFA2L2pnV3B0bDIyczdQSWlIM3FjajJGTEJVOGV5Nm9s?=
 =?utf-8?B?elpZUktxR0ZWQk9iOWs1WndTQmRXZ0M2UW9pMFl6eitZdmxya2tjTUhCL1lz?=
 =?utf-8?B?K3BSS1QrVTkvUVh6N21rMC9WeEtFQ0xoRDJvcHFSY1krUWY2R2VhaWVWYjBF?=
 =?utf-8?B?eHJwUE9GRjhvOVVZTlhXMDRYRGRBQXFWTlJPQnhuaTVDdk9hSEM2dFM2eDJT?=
 =?utf-8?B?MXdNdFozeXlqbFZNc1prWjJ0Y3dET285NlJHc0NKbXlxT1NSdTNYQU5xM3NJ?=
 =?utf-8?B?TjlvakV0Y3JjdkphMkZGNjFmcmNoN3BOT2krVnUzNnhjVDZKckI4cTY4SEZq?=
 =?utf-8?B?cEE4WitVZitlNWhlSlVnR3JUbVNKV1Fta1hadmhkVWpyUTdzb1JyM3JDcVhv?=
 =?utf-8?B?N0EzTHJLMG94ZW9wUE1XdmVoc0ZwVkJuVGNKQXZLVXRpdDNoNTVMc2YyTlVi?=
 =?utf-8?B?Q0s2bzJ0RUd4V29Kb05DaTJDSW11SGMxaHNvNVdHMkhxN3FaRk9WUHhqdVZ0?=
 =?utf-8?B?MFpNaXl6ckNCejlmSGkwU3p1aWorVkJCT0pRNmRyUElRbXBZNGZJc0lmdUdN?=
 =?utf-8?B?T1pIblRybzl4bkdzK0RVYlVibCtPWEZ2NXE0QVQrY1ZaQWt5cnAxVGpqYWNm?=
 =?utf-8?B?djgvRWtDd09nWWVkR21BeEVqS3F1N3Nsb0ZKSW5JVzY4VkxrOHcvME5ldHFw?=
 =?utf-8?B?bGFvbDAxa3pHOXUyU0RxWHlRUExlTDUrMFUyMzhHSXlyblRYMEZrQjVPUWpC?=
 =?utf-8?B?Wm9CczQzSGMxU2hEWUI3QzdYQnVKWWtGVXB6WUhNaFVwMkhWU0NhWE00bWF5?=
 =?utf-8?B?OHNOamdPdlBJMllPTWw1QkZ6Z3pncTNxajY4eG9aVHVWSlpLNHhlYjVKVVJx?=
 =?utf-8?B?cEJVcWFTbjAwQTZreE0vNDZYL2FKcWFHQ1hyWDFtdENVcjJCM0QrMmZScWF2?=
 =?utf-8?B?ZWE1YWg5c0dqZlBNUzV5ZW9nRWIxMGJvZGNsNmxCY1ZtSzJGNG1IejJWSmZE?=
 =?utf-8?B?UVJFcmxleTJuSTZEYVBkK1l1UVl6QWo0emJIQjExVFdabHJiVW5NLzJ5RWlT?=
 =?utf-8?B?QXI1elAzS0FHa2psa1VuM2pRemNLYzVpOEc4WnhrK0FQNEsyVjErSll4UmFB?=
 =?utf-8?B?UlAwVHFmWnV2VEFlZmVVVlNYMjM5OTIvckxnblQ1ZFFTUm8yV3lMSThVR04y?=
 =?utf-8?B?TDMvSVRVQlp5dHFkL0pYQ0FITHRHYTlJZGZ3a0hBSGdFNVNLOXovM21Dc1gy?=
 =?utf-8?B?bk9FUWhJNGN3bWhqNDhibWw5K291Y0RvSDV1M3NqSG0xV3dRaGpBWGpPRmN1?=
 =?utf-8?B?T05aRXZoR1ZqcU5WTldUYm9DT2hTZ3ErN2lmVlBmQ0dkeFRseGNiWXREODNt?=
 =?utf-8?B?QWZsQnlTbkQyUTg1a1l6QkE3QTltSmVNWUhUb3E4UFJUcUVEdnFCUGtPNnB4?=
 =?utf-8?B?ZENZOWRiMlNmNytPTkdUT3N6RnEzMzl1dHpUWkF5cm5UZDVJVUxBUSs0S3BG?=
 =?utf-8?B?c1pRbTkzdUp3OU9xNVlqUUVCSlRNUUZxS1NwanFvWHlzTVp2Lzh1aWxDcmQ5?=
 =?utf-8?B?Y3VWL05EWHJ3Wk1UaDlNNm5iajAwZkFnc0xXSm9yTzVpQ2ZhTlRRem5Yc3Jw?=
 =?utf-8?B?QktyVmhMZ2FTNG1reTl6RTB5U0JJZEZ3QXg5RjFCR0dnL3NQM0tHWUNocGVr?=
 =?utf-8?Q?877gjzmsNDz+u/Bm2M6F/5ZJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02115a79-0e25-4215-23dd-08dbe9d13d09
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:01:48.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsFkLtGyCJAJgifIvQihC3kIdPdsqZmEHcscVeQr7r5g7lF6YFzOPbPoy/IrK4U3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 09:40, Krzysztof Kozlowski wrote:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.
> 
> Cc: Andrew Davis <afd@ti.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Merging idea: Rob/DT bindings
> 
> Changes in v2
> =============
> 1. Hopefully incorporate entire feedback from comments:
> a. Fix \ { => / { (Rob)
> b. Name: dts-coding-style (Rob)
> c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
>     Konrad)
> d. Ordering properties by common/vendor (Rob)
> e. Array entries in <> (Rob)
> 
> 2. New chapter: Organizing DTSI and DTS
> 
> 3. Several grammar fixes (missing articles)
> 
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>   .../devicetree/bindings/dts-coding-style.rst  | 163 ++++++++++++++++++
>   Documentation/devicetree/bindings/index.rst   |   1 +
>   2 files changed, 164 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
> new file mode 100644
> index 000000000000..cc7e3b4d1b92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -0,0 +1,163 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _dtscodingstyle:
> +
> +=====================================
> +Devicetree Sources (DTS) Coding Style
> +=====================================
> +
> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
> +should be considered complementary to any rules expressed already in Devicetree
> +Specification and dtc compiler (including W=1 and W=2 builds).
> +
> +Individual architectures and sub-architectures can add additional rules, making
> +the style stricter.
> +
> +Naming and Valid Characters
> +---------------------------
> +
> +1. Node and property names are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * dash: -

device-tree specification v0.4. Chapter 2.2.1/Table 2.1 is describing much more
valid characters for node names.
It means above description is not accurate or DT spec should be updated.


> +
> +2. Labels are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * underscore: _

based on dt spec uppercase is also valid char in label.


> +
> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
> +
> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
> +   part can be padded with leading zeros.
> +
> +Example::
> +
> +	gpi_dma2: dma-controller@800000 {
> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
> +		reg = <0x0 0x00800000 0x0 0x60000>;

Is 0x0 recommended or 0 is enough?

> +	}
> +
> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.
> +   Alternatively for some sub-architectures, nodes of the same type can be
> +   grouped together (e.g. all I2C controllers one after another even if this
> +   breaks unit address ordering).
> +
> +2. Nodes without unit addresses should be ordered alpha-numerically by the node
> +   name.  For a few types of nodes, they can be ordered by the main property
> +   (e.g. pin configuration states ordered by value of "pins" property).
> +
> +3. When extending nodes in the board DTS via &label, the entries should be
> +   ordered alpha-numerically.
> +
> +Example::
> +
> +	// SoC DTSI

Same comment about /* */ as was mentioned in another thread.

> +
> +	/ {
> +		cpus {
> +			// ...
> +		};
> +
> +		psci {
> +			// ...
> +		};
> +
> +		soc@ {
> +			dma: dma-controller@10000 {
> +				// ...
> +			};
> +
> +			clk: clock-controller@80000 {
> +				// ...
> +			};
> +		};
> +	};
> +
> +	// Board DTS
> +
> +	&clk {
> +		// ...
> +	};
> +
> +	&dma {
> +		// ...
> +	};
> +
> +
> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. Standard/common properties (defined by common bindings, e.g. without
> +   vendor-prefixes)
> +5. Vendor-specific properties
> +6. status (if applicable)
> +7. Child nodes, where each node is preceded with a blank line

Isn't the order already defined in DT spec in 2.3 in chapters?
compatible
model
status
#address/size cells
reg
virtual-reg
ranges
dma-ranges
dma-coherent
dma-non-coherent

Again I am fine with whatever order but I think we should reflect it in the spec 
too. Especially status property is for my taste too low simply because you start 
to read and then you will find that IP is disabled.

And are you describing all properties starting with # as standard properties?


> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +Example::
> +
> +	// SoC DTSI


/* */

> +
> +	usb_1_hsphy: phy@88e3000 {
> +		compatible = "qcom,sm8550-snps-eusb2-phy";
> +		reg = <0x0 0x088e3000 0x0 0x154>;
> +		#phy-cells = <0>;
> +		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		status = "disabled";
> +	};
> +
> +	// Board DTS
> +
> +	&usb_1_hsphy {
> +		clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +		clock-names = "ref";
> +		status = "okay";
> +	};
> +
> +
> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.
> +2. For arrays spanning across lines, it is preferred to align the continued
> +   entries with opening < from the first line.
> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
> +   should be enclosed in <>.
> +
> +Example::
> +
> +	thermal-sensor@c271000 {
> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +		reg = <0x0 0x0c271000 0x0 0x1000>,
> +		      <0x0 0x0c222000 0x0 0x1000>;
> +	};
> +
> +Organizing DTSI and DTS
> +-----------------------
> +
> +The DTSI and DTS files should be organized in a way representing the common
> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
> +and DTS files into several files:
> +
> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
> +   on the SoC).
> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
> +   entire System-on-Module).

DTS/DTSI - SOMs can actually run as they are that's why it is fair to say that
there doesn't need to be DTS representing the board.

Thanks,
Michal
