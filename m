Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3ED75A833
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGTHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjGTHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:50:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03D2127;
        Thu, 20 Jul 2023 00:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfscpqY1KdaJzdpFg2dD51i28jejAchXsIy+B7o8qcJeAVmzEar0mG4A12BvQAAgNZ7e9A8xHxUxj92nSbg+3NLKkywVFCDFbT3FHBZdnUWWqZ2EELE5ycOaObrnsgkCC69kfJtIh6ujZvgE6jbucq847hyo5u+y5LwpxCWO/A7bmh+FI1+ZDzw2v0dkn2TjkudYi5QxVACzcyOwTcYMr8dBNe6sxmz9jyq4H6M8BQ+G2n2DxhUrJCf+J1wEPbbdSYCDcwjNl/skxG3GDk2y5sxAHByjPOsbogwNJ9AGhqYl04ZZNuMphlvVQ05gFJxp93cY+thxTdI9UJ+GioDXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBcNocvS8340hbmyzz2o4MXYDEF+Ix58Vshz2zyH2jw=;
 b=e2KKveMuSWUOEKd6G9xCJz/Y2hH0z54GNzp8dkWilz94Du+mJ6Vk/u+IDO82cfLqh7N6VIaBsl3bQ+oO8t8LSzWNo6ECoWkAgPMUVDedgE9aydg1dl+DhQWeH6uWqpqFDYo8hB1N9cPsrklJQdn6IOA02OKs3v62KfE2ZwYHVsPuynLkKtL7iuWDsiLV6faqsYEiS/tWMiMll3iwF05Ita6R4C3GxC9HYO3DYcQFDigD0AjbYDj6kawgmcSBZF5M922j+uPactryYKc5iqfCksJ+50Z3KmVfYlYzr9Uy+w6C+B2V+soYeqvheDEToSPLamuJbvMoil4gVEAq08QE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBcNocvS8340hbmyzz2o4MXYDEF+Ix58Vshz2zyH2jw=;
 b=IkOQhZayz756OBrmq/MoFYab8niD4srtICB0auuxkN8CS2+/LqDwb2j6sEcqoLcNvaofiFK9uHRhDg4OSglH865rn3MBc/t0bM1KrACc21Q+/kQlqNDz/WB56K21JaCbJsSOlRucLSwcWCLjcb8h/vT4NyEmISIO8zDxoC2SZcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAWPR08MB8957.eurprd08.prod.outlook.com (2603:10a6:102:33d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 07:50:52 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4fd7:91a9:a92b:295a]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4fd7:91a9:a92b:295a%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 07:50:52 +0000
Message-ID: <0a503489-ae6f-3299-6d4e-f14350f1ecc0@wolfvision.net>
Date:   Thu, 20 Jul 2023 09:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: rk3588s: Add USB3 host
 controller
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230719174015.68153-1-sebastian.reichel@collabora.com>
 <20230719174015.68153-3-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20230719174015.68153-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0189.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::6) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAWPR08MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 733e0582-ce7e-4da4-363a-08db88f60a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYPdWxPJiEBs9u777/vAbeguhp13uafUzizQTGlBZNRnZ5OLKpOaGXq7bqoxLtqks1kd2urIU0zc7vkl4RkHGVQWUs5U1XpgfpSAhJUDa/Hrg/j9vP9zK47f/Zq4BGF8XmOzx8YZb56h/iyC6m9nJe/MsmFydLxM1eTS6ZxvDt6cfioBDVV65bWqhOkrSmfqLWe4T/txTV7QjsRDY9zQ/sf0KlpkYaHZ4APesKtyVGQWBMJ58jkPKGtBO8oedtk3rOnFxA1X6wvirsteccbStJVrAd7EkDgDkL6FeTV5D95eum74gWrnkPyStNHCwJKCwoZxhoUmqQmEQ62tmSoal8jc+/3dPjvGLucSQvSiNcBo5CfXWJwFx318scNDjsRdmG1N4GUSCPOFZYOd+j13VP+u/lq8pSsYSepro4PL+olXyJlnw9E/QC6Tgco/FW/XJ3hIgYolONbVvwVmiju17lqW0rwf15g9LB1V92GKvVinscP/aluNKyq+aT1g3q6/OSDqqZv55jZm9db8QJSlsQdXn8PMbA8odYX24r4JYLk1eYVLd/q+m6ZJ6VTfReh2AElcSgQRFPHcGTvpbEJbRkS6O3sLZK9jaj23CMHwjURsGZy3MCoSJejPX14UC8MkpE84DRNnvhh2PL5wKe5n9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39840400004)(346002)(396003)(376002)(451199021)(110136005)(54906003)(6486002)(478600001)(6666004)(2616005)(53546011)(38100700002)(6512007)(6506007)(2906002)(44832011)(4326008)(7416002)(5660300002)(8676002)(8936002)(66476007)(316002)(66946007)(66556008)(86362001)(36756003)(83380400001)(31696002)(186003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUplWjZiS1hnOXFhRVR2d25QaGZCcVdsVUlPZHU1TnVZcUhqZmZKSldKeXhD?=
 =?utf-8?B?MVV1RU5COGFwWDFsUjcxczN4M25uazJKb01NWjgvcFZ0VS9sbkNIcVVmVnB5?=
 =?utf-8?B?cFdWUkFnVUNGWHkyVmFDdkNvNFF0ZEEvcE9SV3NWOG5iWm0xV2YwU2dSNTVT?=
 =?utf-8?B?dElMNjhhOTExYzRqS3pvNkcwYnk3d2VKb094eEQrcFBKZEI4T1lCdGJtMVlT?=
 =?utf-8?B?QmJFdFBqOXpnZWk5eHBSTDZMQi83TGp0QlhHRTM5SFNlL0tQeUZDdmV5WUpP?=
 =?utf-8?B?aklJTFYya0haNWUrdVhIb3FJZzBBblBmM0J4VWtUc2c0S0lyR0N2OWRobGc5?=
 =?utf-8?B?SmxiYmpVRC9SWDkwS2VWZ1JHdFAwYUNzMklUNTA4cE9hMXVtQzl1ekUvZHdQ?=
 =?utf-8?B?bjFSVUN3bVJEa1pQemdLcFZQMlRIcU1NVy9VbnJkdGVsc1poVmxrSUVhcFRo?=
 =?utf-8?B?a2pqMURCMk43S1FnaFF0eHdVNnUwUmsvdGdlVGhwaEloamhWZ1d5Q255MVhN?=
 =?utf-8?B?MHB6S1F6SWd6S1d1UTR1a3lWOXd5eXZQUE1iOVNQYXZKVXREM2lCSEduM3FF?=
 =?utf-8?B?VkpQaTFob2VaK0s2d3ZmMUJnYVpEaVFNbk9BMVQrSWJsWjdET0Z4VWdqRFEv?=
 =?utf-8?B?Tm5vN0hHRkRzeDJ3aURDNWpEek56RFFNVDAwR1gyTG9WRFVDZ1VhV1F1VW4y?=
 =?utf-8?B?cjBkTi9jVlUvNkFKekdjZVRIV253c05LRlBNZEhwRDJVOGZTTG5pQmJaZURO?=
 =?utf-8?B?clhzMnJmQWRDTG9VM09Gd3M3by8yNEdyU1gwazRMemQ4U0E0d0FVbUpOQ0w3?=
 =?utf-8?B?VVNvT0dESmdxMG1GZEpSbjhkMTY3T0pLNk4wcEk3WWl4Zi9hM0dRMzBHSTcz?=
 =?utf-8?B?aDUzZ05RS1QydlEwM1B2VW44bDZCY2RXekJVTVZ6aURHc01QdURGcDhBMHZS?=
 =?utf-8?B?N3NRUExJYmlZbEI4T2lFdGM4c0dRZ0gvK2REeGpmZS8yUzlnQnRVVFdPU25r?=
 =?utf-8?B?UzF1Qnk2ZjdoRm1GbHZZV05sTThkNVRWaEJIYlFsWHhuWVRremJ2MG1KaWpo?=
 =?utf-8?B?cDAwcGE0S2daMVcyTU5kQlExaDZ5NE80UGtkbGw4d21yNW1scWZTTlVnL0o4?=
 =?utf-8?B?SkhqNk8xTWpUTjArM3h2RGhtSUxFbk1PL2xQZnF1Q2hsYTIxVStwNmtzb3Zn?=
 =?utf-8?B?Vkhuby9takx6SUFxb05IVVFTaWd4NU1zM2dTYzZVYW1iQTBMRGtIT29IZWpS?=
 =?utf-8?B?N1dUUVJ2R2REck91OUdHNkdOSEdoam9DZGhFZzJubWlrQ2wxZ21tbCtlZVIz?=
 =?utf-8?B?ZDQ4S2FTM0lReGFlRmlHU2lOS083aWo5dWk0YTZoS3UycDR4Y1VmbFMzOFVD?=
 =?utf-8?B?akZubTgyeDNnVXRMbnFRamo2QlkxSG9aVXhRZk05RUdJdnE3UFNZcGIveEdG?=
 =?utf-8?B?cGJWTStLZGRjN3BScHd4bEl2L1AzNUd0YXdYZEpYMmdrcUpHRS8xdmJpK2R1?=
 =?utf-8?B?SEp6NU9aWWdML1lsRm45RlI0Sk5nWkFwU1B0Rll4UVJPaVc2bERrSUpxa01l?=
 =?utf-8?B?UTB0SXE2WTJWaVN6N0x5ODhaUXVvbnlWK01PcFRpa0hoUVVFYnZkN1pKQWls?=
 =?utf-8?B?Z0VEd1dUb2h1aUdGVTRuMSs0Sm5vUHlHN2hCSFMvbGpjV2hPcEVRa0x0bXFl?=
 =?utf-8?B?WDFkdmRGWXJoZ2Nqamc0VnVLUk0vS1NqaWZZUVpqMVpZTkdUVHJuTytyMFVF?=
 =?utf-8?B?T1JYclgzekJaNUc3UVV1Sml0VysrSkxBbUhuTGlLM2V1eklnTTdrMFd5US8v?=
 =?utf-8?B?Uzl6dUlFTWFHTlNMajRRbWw3SUQwQ3ZyMmdZVzBXV2JLNGFsSkczWU1semVY?=
 =?utf-8?B?NUpWektxem5XUzMyTnMzbWgxeDluL0hKa2tqRzRYd2tqOFgwZm5QMzRQMXB3?=
 =?utf-8?B?dC9CUkZOQm1MOFJyNURYLzFSVWNKd1RNR1MwblBvZXRKS0JGWTJIZHlONUow?=
 =?utf-8?B?UVJ2dzJyeVQxZHhHbU5mZlZWYkJ6Q0ZUdEhNdHlacExFUmNQd1I2R1RpUjlI?=
 =?utf-8?B?N3hiWDBLaFNCZWZ4YVVVU3QrQnFYb3EwL0F4MGxKelNGa3J3d1gwZFNBeDZo?=
 =?utf-8?B?SE01aU9Ya2dwc1JOTXg5ckpXc2phemU4TkJ0ekNic1V4ZSt1SnJVTnZKNGpB?=
 =?utf-8?B?WWtmWlRKR0dVODMwOC95Ni9JbnMvVVg0RWdVV3R5cFllSlNERGVXSlhCdzZJ?=
 =?utf-8?B?SVl1cjl6dWo1WlUvaVhkT1BVYWNRPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 733e0582-ce7e-4da4-363a-08db88f60a60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 07:50:52.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2XlsHccjvu6dCxoGN8BfViCkWCjt/G9EDiNxDs7BK9xtVbf+dtG1ztZ38W2l1SAwxaABeLVIegTNfRX7Q16tDDkVad1osishHOTs1YNlE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8957
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 7/19/23 19:40, Sebastian Reichel wrote:
> RK3588 has three USB3 controllers. One of them is host-only and uses
> the naneng-combphy. The other two are dual-role and using a different
> PHY that is not yet supported upstream.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index b9b509257aaa..416581dd3bb5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -443,6 +443,35 @@ usb_host1_ohci: usb@fc8c0000 {
>  		status = "disabled";
>  	};
>  
> +	usbhost3_0: usb@fcd00000 {

I'd recommend aligning the handle names with rk356x.dtsi:

usb_host{0,1,..}_{e,o,x}hci

I saw that your USB2 series follows this convention already, so let's
stick to it here as well.

> +		compatible = "rockchip,rk3588-dwc3-host", "rockchip,rk3399-dwc3";
> +		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
> +			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
> +			 <&cru PCLK_PHP_ROOT>, <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> +		clock-names = "ref", "suspend", "bus", "utmi", "php", "pipe";
> +		ranges;
> +		resets = <&cru SRST_A_USB3OTG2>;
> +		reset-names = "usb3-host";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		status = "disabled";
> +
> +		usbhost_dwc3_0: usb@fcd00000 {

I had the impression that the embedded nodes were out of fashion and the
preferred way was to have one node with the

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

Again, try to align it with rk356x.dtsi.

Thanks and best regards,
Michael

> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfcd00000 0x0 0x400000>;
> +			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> +			dr_mode = "host";
> +			phys = <&combphy2_psu PHY_TYPE_USB3>;
> +			phy-names = "usb3-phy";
> +			phy_type = "utmi_wide";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			snps,dis-tx-ipgap-linecheck-quirk;
> +			snps,dis_rxdet_inp3_quirk;
> +		};
> +	};
> +
>  	sys_grf: syscon@fd58c000 {
>  		compatible = "rockchip,rk3588-sys-grf", "syscon";
>  		reg = <0x0 0xfd58c000 0x0 0x1000>;
