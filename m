Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3E7A35DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjIQOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbjIQOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:34:07 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FFD12C;
        Sun, 17 Sep 2023 07:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGm6VN8KJ2YlCCuR2bavVMy0uXytYtObgswkZYmCLJ7ynTkZIeKqQTlobM4g0PmqybG4FnQytqhpR6PsHR7fVQhr4k30Rb+kw0g4yWLModNPxt0amuS09zIb1ZsbRo9z9Mc82nBap16GuFuMZl2iPAz9sk2/M5B+L0tSda62896COEm/fQBMFpNxrb7OOlX2m5yCxxlafcYSpn/PoU2qglw3ydGmnhZ4IU9dNrsDouX2vNh/Ay0oZxQgv8cQ2CYDLlYSsEXzU2reddXBC+ZN3/NzrkmpR1H4D1vLizWpYCtZX8/1lwkB///LYSneBfRsixyZsYSv3KOIyxmVlIdwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgR9UMUcGm9szNMvmhzxw3HZGJUt3O4dQ+QS05L85dA=;
 b=DSMsTlaYYS8Q1w5x+trbTJ+tj9I3AtBDHHcWyebam0nJHMvOkhRiMDTrc8IWYBo0aJUwFWUXXfCVn0CFIYQXUDRPLvypTqUnBcXyA2JfoldP8Yz1CNUYqGmMgFMhGZrFlcitHS3DhBApeZOttruUA1D1QBTgZd5l320SNFMwrrc0H5GrHGvBvnMID1ywrmMfyb2ejAwdTwk3YLvdqBfGQKm3a4HorPahtD4YAKEUQfBMXvyHSxAtiqy89BviHJNgdBPCURknH3HvlS+r+coyRHJggmTKJLkMUWJZ+fE0g67iygAr6F9Sp2QO/MgddImACp6oVxoTlwTQeGnTTkkMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgR9UMUcGm9szNMvmhzxw3HZGJUt3O4dQ+QS05L85dA=;
 b=eauOMxzINuW9CvhgYfmP43CrM4GZw0J6IblqGhiYhY3BIrQThQysCk5QRCN1ICBE70YEEokLoS92YWIN/RMSQiAumcI5hzonEviqR90b24TcYJ0jaTq89JWe0pZqzb4S7YBpXku+Pg1sPcVraNnFu4iT4MqutusGxUGKYK9LyVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Sun, 17 Sep
 2023 14:33:59 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6792.026; Sun, 17 Sep 2023
 14:33:59 +0000
Message-ID: <2f1571a6-014b-4b70-9135-306cf9014238@solid-run.com>
Date:   Sun, 17 Sep 2023 16:33:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] arm64: dts: lx2160a: describe the SerDes block #2
Content-Language: en-US
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230818111016.11271-1-josua@solid-run.com>
 <20230818111016.11271-2-josua@solid-run.com>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <20230818111016.11271-2-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: cc063328-4887-426d-cfac-08dbb78b2139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3B9fcbOeLKVvmmPGKK5I2xmXHPE1bQxGvaLUJFcsbV6Eqcpf7lA47SPgnJ75lcvSXh+gHTpSNqoHGoQpmmsS+HLYpgbVESkwEJ+1jfEsA0b36CsqnHExFione+Q0zt0hr0Lm5k8VBnWNBsnWl0FXzyoHo5M1BWKXL7RcyDHnMc31aDTwrbsgkkDAJ6ILL9r4QzT4ErZKSq919LSatFnES5vdyv7EPNXxHPfOjkYIKpZwBXFqk33i8K9CCh812E45HGZhXv7C9sdeTVpv+47baVfjQ7ibteLFWonmLKOZnnGW5Ti6MLlldX/B3wMzMRKLZT1tHZUHIGsl1TWUAVedjdVDPBHpU6lj+oU86Wsf8M7tOPY6teuJnQu1anDzNQtELBDiTkIIz22GM8Iin94XE7nVDadau9mA5wpB5wYKk61VM/Kc8TIDIMFD4s2e0oO/Mu6n/GpNwLVNGrcPNzhwBLUDYE5Peh5NrXGvvKu1t7kGfZx+lKV8s6IBOp2bxcoa2VaMUF26yBTpi/W1FYyDxHHbsqfiEHopFsZadWrFxSQ/NYStkfLebxCwwzF5p/X5E+akRi4SPsXChDsksMvcHWmTFh+x6nvwrWGWBxkyzwp0PWfXrfHEt1RpHTpu0EcK52RcNwL6IJwlEMzNa40XOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(366004)(396003)(376002)(346002)(451199024)(186009)(1800799009)(6512007)(6506007)(6486002)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(66946007)(66556008)(66476007)(54906003)(41300700001)(316002)(2906002)(5660300002)(8936002)(4326008)(8676002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2pDQUJIZjNCaS9UL3J6OHh4S0FuUzBCcUVjOThJS0V0b1cwWW9oQ2lWMWl2?=
 =?utf-8?B?OTNqSDFFMkFndzQ1Q2UrYUxrcUFoVFFTNzBjeXBwekNYU054Q2lCbm5pcEVa?=
 =?utf-8?B?TUJNYldGam84QmxFZkxaand2UW1NN00weHNXUkkxeWJMWnhWb2tiZndQRnIz?=
 =?utf-8?B?Vi9MZmlJVGNZL2NrOXZOZ21KYmtaR1VGbFBaN0RSUUV2Q2pZVWRzZnhDSFcz?=
 =?utf-8?B?TkMrY1V2bnlZT0pFenFvei9OZUE3Q215N0tocXlPdWd0WHN1MGJaTWVCd2th?=
 =?utf-8?B?V2VhdkhveXpybE1TQXZJV3hzUytXNUYyTDQwMktEZERTVnY5bjVncnQrNnN5?=
 =?utf-8?B?Z3F3ejVPWW9RWHM4NzBDSTV0d29aaHg0S3BwYVF0UjJkeEM3Ry9iUnU0bHRn?=
 =?utf-8?B?a1J4YVVMZUlPNUkzMUlrN2g5bWpQbjhXam9GekpTbThCQ3hlUFV4TnNFMW9N?=
 =?utf-8?B?MEdwb0dKUm9RZU9IZDdSWVZPU2pzQXZZTGYyMmZ6M0VRSjVSR0xzQ2tXSzRy?=
 =?utf-8?B?bmtkWGZ6c3JHUHBVVXRJRVpGU3ZXejd5eWlYM2hudU40Mit6RStCYnloT2hL?=
 =?utf-8?B?U0lVWHlCeWhmbUZEeDFjWTJWTkZJejBZYXZFVVp5VTNhRDNhYkJ3VU9mY1hJ?=
 =?utf-8?B?c1YzR1lrUy9qbFFCVEsrMlhQRnJLbWx1eDUyZERveFhSMFZsTnFESnVIK2Fl?=
 =?utf-8?B?emRrT0xiaUkybUp6ZW1wMXZ5Vy8wQm1ZcW1XWlpNaWlHU2JyWW1CMDA4ZG1m?=
 =?utf-8?B?VCsrUk45Q3VpdUdES2FKOGI5N0NnNlgzK3djWGh6S0hXSWloS0ZlSnF4TU1k?=
 =?utf-8?B?SmI0d3o4Z0FDNjNlcVhvMTdxRzlNRTZDcHd6cDQzZUtkUjl2eldCbGF5aVpO?=
 =?utf-8?B?Ry9RTzRaMHMyOGg0V0FNUGwxQzkzVTBmblRuVnd0MCtSQUlaV1VPaHo4RDIw?=
 =?utf-8?B?blowRlFKeWtLZUh6RkhGWW1XVjA1OTZvdzdqdmZsbCtzQUZneUc2NkNkRSt5?=
 =?utf-8?B?Z3pqcEtLQlM1bituNldHbklpb0hodlpOZkdBRUEreG5qb01TWkN1UURibXhW?=
 =?utf-8?B?WUt6Zko4RkxMTkpUa1JJcTNWYm1MeGgzNlhCMkQ0aURxOWwxSGdENW9hcGVh?=
 =?utf-8?B?WUU5WDhGMlJNRyt4eVZvWXdDZTBzczkyZEZLdEc4bzFpOUs3cmsxWFlGSFJN?=
 =?utf-8?B?VUcrVTU3QnpLenlTY0dTYlpOTS9naW01UFlqTmhyaHBvbTFZRVhZWmJWc21P?=
 =?utf-8?B?NDJHdkI2V1B6NEZoRytjU1RqY1ZQdXBZUzVuUlRweVFRSDdibUxtV01mUzRh?=
 =?utf-8?B?MXVjblFOZkdMbXd1aHYrMXZaUTk2dUxXSFEwZWlkVFljZElXVW5ma0ZBbXUv?=
 =?utf-8?B?RUdydXhFMFZITDVoeC9raUo4Mk0yOTMzeXhjVC8vSnprc2lKQnlOVTBCanBQ?=
 =?utf-8?B?aE1paTBFWDBuL2J4eW9GV3hvcWdNSTh0N0ZCRmEydXBpak5HL2dHVDNKN1Vt?=
 =?utf-8?B?U3dwTFM0UitRUnJoTG0wSzJlK3JVdHlkMmVjR09ZS3hyclRwQXJRMElOQitX?=
 =?utf-8?B?c2pyQVlxNklRVkMyYUxIOXQvUldaOFI1dWRkbERQb1dOcnRGZk1PV01GL011?=
 =?utf-8?B?SEZmRHdGdFM2MFNvVFNQaTRlVXI0Z2FYeGVET3lMQ2lxYmhzSHI0RDBpUlhS?=
 =?utf-8?B?MFlPMzFTZFlzMzJXQjJaaGdWVE9Nck5SbERtMkg3ZE54MWZMdGZqdHdVYWJX?=
 =?utf-8?B?amhReitzV0kvaUd1OHVqcE04QlR1bitRaThZZUJiY1RzdURFUGR3KzV0SVY0?=
 =?utf-8?B?elB6cU1GQ0hDTFdEMFh2OGcvbG03UnYxZnhPN2huNVc3cnZmdTdndjUxVUpO?=
 =?utf-8?B?aFRiK3ZIeWdkdisxd0krVFdOQmRJVWlUMUV3MDh0WDRTcUV0OGdxcm9Ubk13?=
 =?utf-8?B?UHd5Yy9yQlo3MmZGdWl0eHNjT2xrb0Q0OWVqckhBK0hCblhjcTZ2R3hVUno3?=
 =?utf-8?B?MjA4VTJLVmcvQUpSOUhTcURWd3hnNnNhMjF0czlIWmJqcFlXRUowUFUvU0xQ?=
 =?utf-8?B?Z2dtL0IwUnJiV1IydjlMaXNvWFNROU5lS1A5SWdZSFBvR2ZZL29rMFJaZXZ2?=
 =?utf-8?Q?/JETCZp4V/ZbByc/CGzc3jjRv?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc063328-4887-426d-cfac-08dbb78b2139
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 14:33:59.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI/pnLioOagdwYF/3pe1D3C6hhng13JLa9rWlw9p71uMwNFhG44se88ngriY+pdhvMZSSu0/QwSdsaVnwhedgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is one of the patches in my series that hasn't received any 
feedback yet ...
(apart from Krzysztof correctly pointing out commit a description 
formatting mistake).

Please note that I intend on changing the new serdes_2 node to add 
status disabled by default.
Since the lynx-28g driver currently only supports network protocols,
enabling it by default could interfere with configurations using those 
SerDes's as PCI.

Am 18.08.23 um 13:10 schrieb Josua Mayer:
> Add description for the LX2160A second SerDes block.
> It is functionally identical to the first one already added in
> commit 3cbe93a1f540 ("arch: arm64: dts: lx2160a: describe the SerDes
> block #1").
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> V4 -> V5: expand commit hash reference in commit message
>
>   arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index ea6a94b57aeb..2e68c05181dd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -626,6 +626,12 @@ serdes_1: phy@1ea0000 {
>   			#phy-cells = <1>;
>   		};
>   
> +		serdes_2: phy@1eb0000 {
> +			compatible = "fsl,lynx-28g";
> +			reg = <0x0 0x1eb0000 0x0 0x1e30>;
> +			#phy-cells = <1>;
> +		};
> +
>   		crypto: crypto@8000000 {
>   			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
>   			fsl,sec-era = <10>;
- Josua Mayer
