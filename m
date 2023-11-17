Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07187EF27F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjKQMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345949AbjKQMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1AD51;
        Fri, 17 Nov 2023 04:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5IhOdNj+yKTvXiL2M2uN5FufGNGreT9mzkbX16SAEkRS3k/2KETIuiGqnCNF9R2ND4i9HaT83p39Q/qys+lm3f2Cv+SN6NvA/Qb/dwPakJLu7s50R8Z0GM+DT0VR/mAjeUz9P/TDLChc/dhuM2VVMetvXpYwG8r3OwTzIPHfG6eQgNvJZMKmHvjo0uxrRBhktMHoGf9XHVuQ/ixaeO/RI4tGDLDcLaFv0AuwXv/1LDcJiXBqsZWgrhqcsbSUpxbfA2vfLWMBj4zbDVKgqR5tONtCCis6S0SMtBFfpyhlGhxcowEys8RIgbIXlMwCaNzK8L8WBbay6PBvbt+UJcV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDFlZafxIXciPkTWKyM+/TrkPiqLR3mnmij9iofiTOM=;
 b=A/CE592/VspTqr4zZW2Y/Ky9qLvy7bmE0T6WVEqfNO7dq2Q7fJEn1T1VXWkWpo937dZKI2gyartGA8/DxGwl2x1BvFzB43C0xbmklRKKhF4gawLnvHl270fQqy3cg8mA8Q5k1u+z2TMBc/+WsXYb4XnS8/gXUSuN+INZ61Vbc56IfM5y2llJG5n6L66NgjESV6qkhYB91rLzhPSk+nrI29zvSVrByBMqpOL9H/jo2HvvjBck8lHK+3cd21NEI/HdMaLsdsyZkOZK+PmHWprXH+xzSzvm+vo1pnqAC3em1sf7KvnzFuhuM0xp7AQtBM7a8knGqljcKrHIix1QEJSdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDFlZafxIXciPkTWKyM+/TrkPiqLR3mnmij9iofiTOM=;
 b=Lp9RS8uwZndD95VVYKQvs1anK8r+sL7zhF4tuWYyvtT4miD4QlZ1yyU54qeAN0VXevoDNl1mIq95PVbQAgJ8kg9Q+SqJC3BOccdwpq9e0OsEiin/4NCnbh9G9atXUsUV6JCJFHSpmiQ6xqbf5m7egyWc8wYXjNJpqlSmZt1avHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV2PR08MB10381.eurprd08.prod.outlook.com (2603:10a6:150:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 12:18:07 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 12:18:06 +0000
Message-ID: <ecac085f-b957-4c96-8e45-63daf8a70904@wolfvision.net>
Date:   Fri, 17 Nov 2023 13:18:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] arm64: dts: rockchip: Add the camera interface
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
 <3566c176d1ef5ae93aa54587a14ccfa80974e872.1700132457.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <3566c176d1ef5ae93aa54587a14ccfa80974e872.1700132457.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::42) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV2PR08MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d7aa22-b9ed-4d4f-4add-08dbe7674169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew9gSYG+dDhB3uyloAMbUuougoi+qlK5t1xAekGNg0NejKBsLCox/l80NxpFCplH6Qlth4MjxbXwG33V8zPEPbJ14rjIAGqi9mwDxIh6GeNtL9+l159hfRISfPza6ivAjF1HSEPFuS7Ot9/SbbZujaOQCxepqXqJH/mtIQVdkNS+vWDkzGh44sq2txkDYscKWBtEZowekGXVKKzJ9WNF7S3enECpr4c1ZBt5YmG8g0v84UU2XrHTMKfDJiQHN0ieSnB4gpLXWB6ZD3m5PmrqnKNt1QKJv1WUWpYTchnxaNyWFjLlr5flJP2lUPp7kMEkwlLdrYr7+/4KNeEcA5o4Fc6E0hzXryvMDqoNEsjUJpy1t34D00KC316pcnWfeCMiXKjINL8Wnquyte4DRhZ/wDxAt+7ipO76FZvgRICy0L2R4obttVh5LAzlwWyXiJakV6zb06ZSFBTd2iUFyfQseOh1K+ShmmvnGbABo7UM1vStVOeBxzgH6i7IK6mQnROHmlJmsf58qeIHX4hYjFCZ4AkvWoBpkL537rfkSPsW3bEEwIPDeNoiGuseY7BDuaz1qvIL/64YW1Wm9Yg5Ts61EGvfu4xpS5yQT1OnRqD+HOg/MEX616+vlIqSYmuNlXfnL3uaIaYjA6F24Cvf8JfPBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(7416002)(2906002)(36756003)(316002)(8936002)(44832011)(6506007)(36916002)(66476007)(66556008)(53546011)(6512007)(26005)(4326008)(66946007)(31696002)(2616005)(6486002)(478600001)(38100700002)(5660300002)(83380400001)(86362001)(8676002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NPK0MrWmFUNFNsY1QxWUxtOEtYMXNiMUdtY05DSVVMdE9vRDI1aHpiWFZM?=
 =?utf-8?B?aUFWdDVZVHRVR0pvbE9wbGNMWmpidVgyVk1oS3RkZFV3SEJtL05Da05KNFpK?=
 =?utf-8?B?SnNnalRPL0hrSElHN3FFTTFQNEFrekV0ZVQycEN4WVkyK1dqaUxhMTc2K2R4?=
 =?utf-8?B?elVVU0x5YWVtaHZLNkdmSjYzTVJMbStQSGI2YkNVdTdSWVZtdmgwTkE3cnRr?=
 =?utf-8?B?dU1TT1huUjZPUG1BUFRBczU2N2E5RFdpMm1pZDJCeFRXT3VKaGRvOVAwcnpv?=
 =?utf-8?B?RklvUHI4WFJrVC9aa3N0Z0E5TVZ6RmkxSjF1dlZKQ1FYdFlqV3JldlQya3FF?=
 =?utf-8?B?VFJoUjNqQUovRWtZZkExRnpocGd6SWcwdmNBbG92cnhVU1d4YmpRcFJkNjlS?=
 =?utf-8?B?Z2taTCtGQm5jWGYvcU9CT3lPSjJKRXNteVlGWUtrR0lBZ1dlcG9CZnRFTWRv?=
 =?utf-8?B?R3k4c3kxbTNHL0gvRHk3b28zaVh3eG0wZTB4WFc2UE55eHpKUHBGWWpHemJ3?=
 =?utf-8?B?T0hRblE5cUVHbTZ3bkJNb2N5L25FeDBmaXVjcU03TW9JYTlzREczcnlQYXZo?=
 =?utf-8?B?K0JXM2EvVzRRcEFteUtOYkE5b1VmbTR2byszT1d0R1laQlhmSVlFMlE3Nllj?=
 =?utf-8?B?QmlJNWE2UHBtNHZ1ZVEyMjBXZENXR1NDb2YrQ0hUY0dsQnNhbmx2TnlLVThh?=
 =?utf-8?B?TElQY2R5cGl6alZIcEhSRXNNU29OY1BGdFFtNTRobnV3WTNFUmI4OVJ6cEZB?=
 =?utf-8?B?b3o0cnlFeGoyRTJwa20ycWNmV1U3dHZOVjlpTVZTK0p3N240S1hwcVhLdHhw?=
 =?utf-8?B?VFlmem9haW9SM1dVcklYLzlFUURsT0NDbzA1M25JZDlxK1owQWJRWWEwUWY1?=
 =?utf-8?B?Ky9kT3ZKRFJNOEtFQW1lVXdXTm1GNUFkTEdNb2tHK3k3VTA0YjNleENzZ2s3?=
 =?utf-8?B?MkxsdklZVmwvQTFGb0txWDRSczhJeXA1TytTNWdRRi95Qy82N2lQZGFFOXFy?=
 =?utf-8?B?UENCTHprcWhHOWhSUEt5bjVHaGpNNXp6SEd0Z3RSdU9jUFVWMm1laW5NM2hl?=
 =?utf-8?B?dXRuQmc2dnFNYnNiaVBvZUYrL29ldHRrUUJTQklXRWFrNjZhdm1hdTg4d2ww?=
 =?utf-8?B?c3N4bEVSbDN2TXBMc2ttUE9RTkV0b2NiVjh2MjNYU0g2b01PMS9xZUJwbFRt?=
 =?utf-8?B?VmpvR1d1NFFNY3Y3T1hmYkx4MjZtdXFxVkxvcWhJTHJ0R3dEMXFuRnNsMGpW?=
 =?utf-8?B?S3dDWHQ3UHpNWDA0SFRFdlJHVzJLSUFKRFJRYzZ0bUhxVGZFakJ3ZzlHaUpF?=
 =?utf-8?B?eU5pV0dLYy94aSt6WmVybWNRcXd6Tkl6NExHSHk5SnZzMEdJL0h6a1BNakxH?=
 =?utf-8?B?R3cvZTNGRDFPdlhjUWw0MzZBZTVKeG5FS3Nid2R4Y0J2alIzcmVtK1phREI0?=
 =?utf-8?B?S0ZWTFIvREpOenExQ2hFK0xDUUNqM2xVSzY2TThqRDFkTnVFNXNNSzBWNjlR?=
 =?utf-8?B?bmMyZDNTOXIxcytvdzd2UEtvNjFGRFI0aGNJNzI2eFVkQUpGcUsya1oxdDYv?=
 =?utf-8?B?dUtlRjJ6ci9HT3ZhakwveVBaZ3RmZjJvOHl4RlAzT29YbVNkdmdYZ2ZRMGN1?=
 =?utf-8?B?dFJBTHg4VDF1V0FlSjFXZ3dwMmZJcGFBRjFlNUlzWk5Oc3krSVE3eHJRVlVr?=
 =?utf-8?B?QzJxd2ZVc09ZSndCR0JwK25PZERiWm8yQytsQ2pCSWcxNUF0dWJESUFWVHBK?=
 =?utf-8?B?blBjWFhlVk1MTGxrWXkxeFoxelBBL1hvdmEyYlRHemcxWjhxUTR4YkEzeU5H?=
 =?utf-8?B?V3BCOWZTcWF2UENyc1UramY4YnRQQXdxaHk5VHdFNnR6azhBSW1JVnorU2Js?=
 =?utf-8?B?clpUMzV1WTF4YnBZUE9HTGgzaGp0MDJwaHBSTlBueTNmR0Jsd1Nidmd0YkFR?=
 =?utf-8?B?L01NeWwyc2RTellxc0pEWlN3ZWsrNXV0V1hUbS96eTh5YzJTa0srb20vdUdD?=
 =?utf-8?B?dmY4YVpkTTYzQUN1OGN0VFZ5WVpHaGt5aUl5LzdhcjlsM1pxc2JMR0N5V25E?=
 =?utf-8?B?OFZaeUYrbjhtT1Joa1lWNXFVUG5EQlJ5R0RqWnFISjg2cEp1K1FiRWRrZVAw?=
 =?utf-8?B?Z01PeE1GWG1BK3ZTbTN4akFRN2wwekVNUk13Z1FsNDBzc3BsU3RvaHhwSXAx?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7aa22-b9ed-4d4f-4add-08dbe7674169
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 12:18:06.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flZOehDmzBPNrllBhdgKUlYPt5oWnSM3WhsBLR9okGVLSTFAerUFCYLKvnt6G6cQIQU1lcPxGbRz3CGawv/uup6FqOlZwcSi64ABEvmLTNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB10381
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
> The PX30 has a video capture component, supporting the BT.656
> parallel interface. Add a DT description for it.
> 
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

> ---
>  arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 42ce78beb413..3a4e859e5a49 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -1281,6 +1281,18 @@ isp_mmu: iommu@ff4a8000 {
>  		#iommu-cells = <0>;
>  	};
>  
> +	cif: video-capture@ff490000 {
> +		compatible = "rockchip,px30-vip";
> +		reg = <0x0 0xff490000 0x0 0x200>;
> +		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +		clock-names = "aclk", "hclk", "pclk";
> +		power-domains = <&power PX30_PD_VI>;
> +		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +		reset-names = "axi", "ahb", "pclkin";
> +		status = "disabled";
> +	};
> +
>  	qos_gmac: qos@ff518000 {
>  		compatible = "rockchip,px30-qos", "syscon";
>  		reg = <0x0 0xff518000 0x0 0x20>;
