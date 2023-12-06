Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47F8072EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbjLFOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379084AbjLFOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:46:27 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2105.outbound.protection.outlook.com [40.107.105.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDA10CB;
        Wed,  6 Dec 2023 06:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntCM8n2W6rxXhAPL8+RO6Ayidha9fVtl52fdhuldnZ9eEgghwBGeq2j2/JApLQjSwrQaA8F16xnp2KnFzPg/WJx8VCaPzqyneCsRKvqawOtzgqfy9/vffQjhvf6i0EyNAOv+EZPSGmXy2olR4bnRww5pZIR78AJfxw1TTRZymigOZmJEJ/YIx9cYcYWaX23IGkTDcLXkiQ3Z+Dl9TI1TZ0ijiOB3n+UqtC7rJHk3hsyQoGesN0gVoogPem3nFfK1QaQ2kJEt7Nvjxg662VuL9F9ddbxNPTEOHumVcm8AptXUS2Y2bpAla8Oh1xDU2aPwYjoExH04i+FAQN1U35lziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz0AFouyQljDxAPjRi4LFbotunmgNYn19OjUle5Tw68=;
 b=hqne6vcK05PdbIs1QHifAglINQP1hy+l9Jx/b2T2L+YIVuiXw0GCYWzFNK99NjYWvYIdTVe28taCJYDV5EknINyTOSsrGz602JTPpEK+fMjYbfsIpu8CNVTKvKZbDFXG3SM4UpSTV1LamQBH1Mkj34Rlwge6V0euRB/YCKAoKi9eumoShWPSROgAjeGeUTbiRfBYQxPudUVb8G6jjYYyarECN1CGlSYmpFYmn4mvTbIYvMLX1kp4jy0Zc0Tqyykhy+uWDt46pjGJ6JytGMO2ZfkDD/tzTTbd4Zk7mx4OSqLOKuihikmPs2DgccLEkUaGfWukxXIEbqYyOZjZWWE0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz0AFouyQljDxAPjRi4LFbotunmgNYn19OjUle5Tw68=;
 b=JRs66mlRyu+XDiOUEokkYkpBcESoYaUj7iK8niAM4A18998C1TPC2zDr8aPVah9QEzgZj/wg5Z7NHbqJ4gl2MYRtbzNDwwhVW1BiHtjgRybjQq/ETixriXfslkU4QFdSpBtBK4G1sAa6jTw+pRQ0httTPlDeuyvZ8ibWq64IY+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB7598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 14:46:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 14:46:10 +0000
Message-ID: <34c64ffb-8d3c-478e-a8be-6a26e53b33b9@kontron.de>
Date:   Wed, 6 Dec 2023 15:46:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm64: dts: imx8mm-kontron: Add support for
 display bridges on BL i.MX8MM
Content-Language: en-US, de-DE
To:     Shawn Guo <shawnguo@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231130161657.556483-1-frieder@fris.de>
 <20231130161657.556483-2-frieder@fris.de> <20231206023434.GL236001@dragon>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231206023434.GL236001@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 01abb1ee-5a39-4d5e-5f8f-08dbf66a1625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itns6dEv61z6u63DUJFxrxblM0iVugeJ0dgOUNz1xZG3YIukyEW08LfoReY0rkccM4TFGmtCoRtPXVhcv12hTwEUvahIVEyn86O5Yr9pYK30d3ykxCEISnTPh3uwQ50L2tB2RoIuyV/7UAkWgnGEQVDRI4/yM9MfByb+3iCvYOOZB/0zJDmWc1D5qQw5cW2XE6OdTFpyxSRwDMPpXHX0Ak4tL7p5WdLdiO8vMtWJ4sk7JldtYQVUMXGFjLyX41nXa8D0wn5K3p9IFLzPgJKLH0UjF9HLZ4hFRjsMdmHqVgp9BI02beeOUusadxE+RDDTIZ+Rwv92H3anuHExGC51H4XA680pCs95NKOq3FKoVWvzzLNezhmk4w/gi/G1gyppK/Oac178eGcHuCDqUupFYgfFRpN5J7xs1TQcSfZChnJdErZ++/unOKeeMf2Eda45BnpFVqZTK8ah1BaVsQ1Dfj+4eI8ULJ4XwOH6aVef9ASEPmiJd2ccTukYb09GDx7+/NFugCYJTd66RMeTVC4TLn+D0sDSsyuiLrAlKxBB1lS3+tfc93rQYvF+HuOgFiSTBJJtC7eh21W0NTQlvCzCstClJtpe6r8Hblt5ZOZZlVwdgn1fkXtFNmFvMxMA1PMPJeA090rJLDNxoEhWYVvndwPXDuwg08Sj8ZNoxHLNs5bhFt4P2W5gTdfZTVVYOIYmTBO+4UpHRsRrHXK8OykGuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(31686004)(6486002)(38100700002)(83380400001)(2616005)(6506007)(53546011)(6512007)(8676002)(8936002)(4326008)(2906002)(7416002)(5660300002)(31696002)(86362001)(36756003)(41300700001)(44832011)(54906003)(66556008)(66476007)(66946007)(110136005)(316002)(26005)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1Q3MDhCbnhlNDRHUU9UajkwTERJdVRzelhUbWlFTUdkWU9ublZPNjh2cmxk?=
 =?utf-8?B?dmdDaHBjVU9nMW40Q1VGQ0pUZnF1dDVtaE9VelVqeDl1ZEVQT0NuZVplcVh1?=
 =?utf-8?B?ckUvbVZ4Nzg4RGI1bmxUVUYvaldOc3U1cEtzbkNaeG40SC9QR3pGaTYrWFAx?=
 =?utf-8?B?YmRGdHRHTHBmUUVKZ0I5NWk5Ym5KR0ViU09FYzdkMHJYUUQzZ0hrbnhManVM?=
 =?utf-8?B?NWhmMWR3UEpabVJXKzROTzZTUTArRk0zQUNOdC9RVyt0YS9ZcldKdkdDcnR6?=
 =?utf-8?B?KzVVQ1ZMVU5sejJaOUh0UjRnMSsxWVZ5eHpkenFJSk5MWmFqZ1p6by9xcEJq?=
 =?utf-8?B?NXZMUTl0cHVERk5qdTlGMEk2YUJqVjBoc2Rna1QyU1M1R3ZYb3JBdU1aejFJ?=
 =?utf-8?B?bm9Pa0x0ZE9hREtCNXpDeGRLQVZ1Q2JnaHQ2aHVEWjVTMUE5Q0xlV3VNNG10?=
 =?utf-8?B?K3NQbVgwTUlmMjUxcWxreDB0VVBLSDdMYU9xbEZPTVhKT3BNRlhvLzV6U2JO?=
 =?utf-8?B?NHdZZ2xMakNKNXR3Um9YYTY0M3JkbkxMNnRmUjBsMTNzV1hrcHRCaFdKQ3hW?=
 =?utf-8?B?NXc0ZENOdVovdjZDR1gxZENHVTY5RzkwUm9VNUdWblZUTW40VkpXcHBreWRx?=
 =?utf-8?B?eDhyTU1IL0JzZC8zV1k4THdQZWpIVTFjMHRwbnJiRExNR3NIVGV4SXBUZnk3?=
 =?utf-8?B?MzR4WnlhTlB0K1czNklyUFFvVkhXWjE3a0VZUzlPYkthUnJHZmNQaFl0VDNu?=
 =?utf-8?B?TTRZQXBGMFFUaG9GSkxjSTBqOGxMeElpZCtXOGc0bmd0bk9YSTIzVEtpSm9w?=
 =?utf-8?B?R0Y3R3hBOVJhSzVCZzNJN3A3S2g3SWU4eWdBYVRGaGt4Z1p3aWxER2VyVW9K?=
 =?utf-8?B?WHVDTEF3am9OTXViaDU4QzNyU0E3TGE5NlQxYlVUb2NoVTVJRGlPUk1xSE1i?=
 =?utf-8?B?aDRWaW5EbVViNlFSUjAzc2M0UEhGUTd2M3U3b3U3bkJJMnB5aVd2elk3RTNF?=
 =?utf-8?B?bWkvbHVVbUVFMU1nSGl1NWJOa01JZXFUemtZRVIyam85VEpiTWp5RGVId3Yz?=
 =?utf-8?B?YXFFZzJTVFBqV0JIbWhPbUNPaVZFS3k5UlN5RXZIK2RuSjlPTWFVaFhCUEFr?=
 =?utf-8?B?ZEpUZHJHUHVZU0ZxZVhWN21WUjJtaXFVZzlDeVhPWU9mTE0yL1BaRFJiWllm?=
 =?utf-8?B?eXpGV1ZXazQ3SmJEeDllaWlqdFlzRDR3Y3RSc2hXZGMvbGtiamNOZmdqb3hN?=
 =?utf-8?B?cjJ3aXdPeWNtSitUT3k3SGM4VjZ2cjJ5MjVFVk1wRE5qYytGTEptQ2pxd3U1?=
 =?utf-8?B?K2lDQmI4aDdxTWpZQisxakJkaHlMV2U0Wjh1Y2pKM3ZyNE9CSWExd3JySVNw?=
 =?utf-8?B?eWJlbk1KK3ZGdFBwanVwcmVVMkE2RnU2WFBKQWUzYjVHWHg2NFBBeWlCTlB3?=
 =?utf-8?B?V0JoUjNhbXZvbzdHMGtyMm9iWDY5Z1NybGh1UXBUY0g4bUtydks5N0NnTXBB?=
 =?utf-8?B?dXNUYWwvOEtXeS9WdS96UEdaWDAwVXFDZnAxL0x0Y0x1RWRiY1R6cXhmcy9a?=
 =?utf-8?B?cHBTcDBDVXBKTDZ0Z3dOS0FOWkh0ckhsRDVCRW94eWczOW9sQkJwdnlXdlpR?=
 =?utf-8?B?Rjd6cysrWVg1ZGhVWUZuUkdjQy9SV1RheVUwaU5LbTlOVU5ZRkQzUG8wZElx?=
 =?utf-8?B?NWNIUFRrT25XNk8zNm50cVgwbjV1RTBFZDUzQlR1aXg5dXVSWUN2R04zNmVm?=
 =?utf-8?B?V1FwM0hnNWtyWThQV1JpTjltREtDQUptUjNITVEvZEFWWEVNWkZhU2gwUnBI?=
 =?utf-8?B?a3ZzSFpuR1dSZ1Q2MzA4YVJ6M214VkZHK1RIUFNhWlE0eDl6cFJzMzRMVHY0?=
 =?utf-8?B?UzI5VUR4RUY5S1BNQlFRVUYrOEVlMThPZ3VPWXQ1YUZPZS9yVW9mbW1WWUtp?=
 =?utf-8?B?K3VXNGZCeUdINjZKVDBiWUJZZHBKNEVrMnBGRnV3bXZRV3RUTU1zMmE5WjYr?=
 =?utf-8?B?RkszbmY5djVqYVI1MjhsSjRDRjBTRkFuQ1NSZFRJb3UrRm5pYVNDYWhQUU11?=
 =?utf-8?B?UTNCeFBISjZid25zUkRmTUFkWmdBNDZyb3ZqSDJSdWhKRThvS21SakIyYTJJ?=
 =?utf-8?B?Vk5lVzRPVzBDS2RjSlZuclhWZkI2VU9KbkYzd1Q3MTBaK3M0SjRnb0xiaGRw?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 01abb1ee-5a39-4d5e-5f8f-08dbf66a1625
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 14:46:10.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl73ErYzIItrY1G/ZNWD9ZssJtBV/lEIaT/tC5v6+stMH9jsWxa4wlQYbW4FJurLFpGb/U+Tld6kuJD0cj5wI1V3P/7UyoVnbaSsOrQnbmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7598
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

thanks for reviewing!

On 06.12.23 03:34, Shawn Guo wrote:
> On Thu, Nov 30, 2023 at 05:16:01PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The Kontron Electronics BL i.MX8MM has oboard disply bridges for
>> DSI->HDMI and DSI->LVDS conversion. The DSI interface is muxed by
>> a GPIO-controlled switch to one of these two bridges.
>>
>> By default the HDMI bridge is enabled. The LVDS bridge can be
>> selected by loading an additional (panel-specific) overlay.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v2:
>> * Rework DSI mux GPIO logic to be compatible with overlay
>> * Switch from 4 to 2 DSI lanes for LVDS bridge to fix non-working display
>> ---
>>  .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 158 ++++++++++++++++++
>>  1 file changed, 158 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> index dcec57c20399e..0fb16b811461e 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> @@ -25,6 +25,17 @@ osc_can: clock-osc-can {
>>  		clock-output-names = "osc-can";
>>  	};
>>  
>> +	hdmi-out {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_in_conn: endpoint {
>> +				remote-endpoint = <&bridge_out_conn>;
>> +			};
>> +		};
>> +	};
>> +
>>  	leds {
>>  		compatible = "gpio-leds";
>>  		pinctrl-names = "default";
>> @@ -132,6 +143,102 @@ ethphy: ethernet-phy@0 {
>>  	};
>>  };
>>  
>> +&gpio4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio4>;
>> +
>> +	dsi_mux_sel_hdmi: dsi-mux-sel-hdmi-hog {
>> +		gpio-hog;
>> +		gpios = <14 GPIO_ACTIVE_HIGH>;
>> +		output-high;
>> +		line-name = "dsi-mux-sel";
>> +		status = "okay";
> 
> Status "okay" is usually used to flip "disabled".

Right, fixed in v3

>> +	};
>> +
>> +	dsi_mux_sel_lvds: dsi-mux-sel-lvds-hog {
>> +		gpio-hog;
>> +		gpios = <14 GPIO_ACTIVE_HIGH>;
>> +		output-low;
>> +		line-name = "dsi-mux-sel";
>> +		status = "disabled";
>> +	};
>> +
>> +	dsi-mux-oe-hog {
>> +		gpio-hog;
>> +		gpios = <15 GPIO_ACTIVE_LOW>;
>> +		output-high;
>> +		line-name = "dsi-mux-oe";
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	status = "okay";
>> +
>> +	hdmi: hdmi@39 {
>> +		compatible = "adi,adv7535";
>> +		reg = <0x39>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_adv7535>;
>> +
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		adi,dsi-lanes = <4>;
>> +
>> +		a2vdd-supply = <&reg_vdd_1v8>;
>> +		avdd-supply = <&reg_vdd_1v8>;
>> +		dvdd-supply = <&reg_vdd_1v8>;
>> +		pvdd-supply = <&reg_vdd_1v8>;
>> +		v1p2-supply = <&reg_vdd_1v8>;
>> +		v3p3-supply = <&reg_vdd_3v3>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
> 
> Have a newline between properties and child node.

Fixed in v3

Thanks
Frieder

> 
>> +				bridge_in_dsi_hdmi: endpoint {
>> +					remote-endpoint = <&dsi_out_bridge>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +				bridge_out_conn: endpoint {
>> +					remote-endpoint = <&hdmi_in_conn>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	lvds: bridge@2c {
>> +		compatible = "ti,sn65dsi84";
>> +		reg = <0x2c>;
>> +		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_sn65dsi84>;
>> +		status = "disabled";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +				bridge_in_dsi_lvds: endpoint {
>> +					remote-endpoint = <&dsi_out_bridge>;
>> +					data-lanes = <1 2>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &i2c4 {
>>  	clock-frequency = <100000>;
>>  	pinctrl-names = "default";
>> @@ -144,6 +251,30 @@ rx8900: rtc@32 {
>>  	};
>>  };
>>  
>> +&lcdif {
>> +	status = "okay";
>> +};
>> +
>> +&mipi_dsi {
>> +	samsung,esc-clock-frequency = <54000000>;
>> +	/*
>> +	 * Let the driver calculate an appropriate clock rate based on the pixel
>> +	 * clock instead of using the fixed value from imx8mm.dtsi.
>> +	 */
>> +	/delete-property/ samsung,pll-clock-frequency;
>> +	status = "okay";
>> +
>> +	ports {
>> +		port@1 {
>> +			reg = <1>;
>> +
>> +			dsi_out_bridge: endpoint {
>> +				remote-endpoint = <&bridge_in_dsi_hdmi>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &pwm2 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_pwm2>;
>> @@ -207,6 +338,12 @@ &iomuxc {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_gpio>;
>>  
>> +	pinctrl_adv7535: adv7535grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x19
>> +		>;
>> +	};
>> +
>>  	pinctrl_can: cangrp {
>>  		fsl,pins = <
>>  			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
>> @@ -277,6 +414,20 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
>>  		>;
>>  	};
>>  
>> +	pinctrl_gpio4: gpio4grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c3: i2c3grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
>> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
>> +		>;
>> +	};
>> +
>>  	pinctrl_i2c4: i2c4grp {
>>  		fsl,pins = <
>>  			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
>> @@ -290,6 +441,13 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
>>  		>;
>>  	};
>>  
>> +	pinctrl_sn65dsi84: sn65dsi84grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19
>> +			MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x19
>> +		>;
>> +	};
>> +
>>  	pinctrl_uart1: uart1grp {
>>  		fsl,pins = <
>>  			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
>> -- 
>> 2.43.0
>>
