Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E28072FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442137AbjLFOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379054AbjLFOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:48:38 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2133.outbound.protection.outlook.com [40.107.6.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7559A;
        Wed,  6 Dec 2023 06:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et0klnW8m1gzEy6AlB0prbUEwRDWAbHe3da4JJIN2FFrTISa1MqP4hSZ/btdEy7bIQd6EBt5GL1b93ER7ACra8VnA9Zp44zeHKM183lG0LXX0+ZcRVgV8Byx5Ii3pKujTdw3/Eh3FSq9N7lonoGUL8Xavl1xTc/pBxmr5hbzC56oE7dbD01xYq8UztSBBNXxyaAMW2N9waCDzY4//73f2VMfZVmgHt9vdNBWVkvIfwRkUY7OCn24WR1cXnICoyvxU4bxiZ5qlOXN8mnys6HhX+Qa8lhKxrj7EnC1Xm+IqvpL0woPzlGzrktWkQrzwm50dz3ff8exipalRKxi2fQ6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VigZe+EKE5+whZysZ5EPaOWoeArqjJb3uUGQN2nY3Yo=;
 b=WoFTM+WhJEqB7rhwApZtuQ4OdKLQU8EgEB37TLPpW60QupslfdvgO8RlZEK3zff57nR0X493+DLPd0wGzC41UNvjs7T4RSIXA7xwq1NgDQeKw1IWB+S4fECW98FnH129jX0x2AtF6lQm4dLMn4BpddoL8vInIFFeYb5ZHTsHy+Bbcj/TN4zPM862Yz6aAzUuvjBZH2Z1a9wQj1OUYScBYV2kmNI5MDaLs6Rd0FcJ7GAubifoblECuFb9wckt0ljMexiNfveilM6U/mClpo18CQhhm4Iu6pbDVMqvOIo4OHdHLfxBS8na1fHJF6/DTC78QRJ+RCoWsonWY7Sw23IV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VigZe+EKE5+whZysZ5EPaOWoeArqjJb3uUGQN2nY3Yo=;
 b=BeOnb0jNZ6FXXy0roUblZqpFS3Db4RRy4tHqDB2OaGv7tINh4XMHOu0+6N4OIgle2Quc03FetmP9eIvJ/QQb88GWdhWeP9lc1ooxHqiwqic5uQRUNrwMFMoiBoT/ZY4r3RKYEZL7lxXwOnCwa4AulX6od9Vt2ETnoPJfpijGWt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 14:48:41 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 14:48:41 +0000
Message-ID: <b6cb832f-4e20-4737-a129-493f487a537a@kontron.de>
Date:   Wed, 6 Dec 2023 15:48:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm64: dts: imx8mm-kontron: Add DL
 (Display-Line) overlay with LVDS support
Content-Language: en-US, de-DE
To:     Shawn Guo <shawnguo@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>
References: <20231130161657.556483-1-frieder@fris.de>
 <20231130161657.556483-3-frieder@fris.de> <20231206024355.GM236001@dragon>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231206024355.GM236001@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3258:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e433e5-752a-4e08-0b63-08dbf66a702b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8dkFCNU+IBjT5JXZfBrqUKZQJ3NEEy8s6jcvVbg2tXQ7oR9sfV5WZyE5b/DkDq95za3DUxhbls9k0VevlK95roUZLvqJrmFrHIH3dRcCDhITp+K7n5BD2uToMuGrZkQDDaAtB/ceP9Kqvwwp8uRzS/5PM2EzuscsoIbT4vtJtk4Kij7hABHF3n1/U1h7nDC1D3ALaRR7YVHbSAEY/nYm9Z7DMXAsZhlXxWk43POAA75bCf7Dp1BqBgsoGm8/FKtHciyOJ2waSGUw9nJ29DyCj3xFIYAR/+1JBLD7cNJCQ6s+OoFwR2HdKmp5QK6b2USuqS1DgA2Kne3N3fgm8bh05dT2ghxmk+GSzBrXJJT8GYI+m/Yehr3dWq0j2xMXnhHXtGkMFGW06PWtm7pJBHx9PGa2CPYfq9lgHIB/PrrBSpMD44m/yL6fyh63NfGXTmhycE1ftwHtgSyGFbvuylkNnFxILHb4P6kiCJ/KA+H/3msrqowI0IiN6hwC+/u9KQvEDCHsDXKiSx0RXf8++AP0jqTEdH35pJBEnI7xUC7x+gCQ8/mvMZuZk4BoaJQnS1gyTkOyE53aNqCf8FA9KCFb7CGV82yeGXv61Gdu+PnU8ssivL7LmVOdoWVTEWKoBCvPimm7QgQO9X6iPGh6RajzVJndGDQh8K+AMPXD1hy/BXvL09M3saaOMv3nOZGc6OVM8zX2MBuyzh13qi1Hgdi/LVrN3VFRsl3bJxltNEk42k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(6506007)(26005)(2616005)(36756003)(86362001)(31696002)(38100700002)(53546011)(83380400001)(7416002)(5660300002)(6512007)(8936002)(8676002)(66556008)(110136005)(4326008)(54906003)(66476007)(6486002)(44832011)(316002)(41300700001)(66946007)(2906002)(478600001)(32563001)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdYL2FKYmlJYUJwSW51QzcrOGxSKzJ0RVNWRzJaRThaOVpJZDE0N3drU05V?=
 =?utf-8?B?Z1lDNkNDNys0ekR1YWdwY1FiMnNORW93eTNiOEh0YjAzN2dqQ3dwMm5Nc0N1?=
 =?utf-8?B?WkN0MGluRTBvc0pBTTlQZmUxb0oySjVXbFNna0d4Y21hSXAybjhTeDFSRlFU?=
 =?utf-8?B?QUpZRGVJNEk2cEI2RzJjbmV3L1FabHdubXFaSTMzYVhPQ1IwcWpRaFBYamRF?=
 =?utf-8?B?VFVod04rV0duUU84MUhiNmpaWnBhY2NDVHRTVjJucUNHSlRVeVBsUGVab0xC?=
 =?utf-8?B?b0FldmZPZWhEcUNobUNXdEx3WkZHN2VqSjNDYURkRlBDNW1yOHFMK1RNNE5i?=
 =?utf-8?B?Z09SWnlwVzdPcUl5SFE1T3JJamU3OHYwdkVnTjZCR1RrTUhxNWJqRVNnWFNK?=
 =?utf-8?B?KzdOTHhncHJlZ2p2NHp4NGJ3N2Jrby8xZG5wU3RQWDY0SUlNMVRoMHVFMWtp?=
 =?utf-8?B?ZGdsbzJPeXlYT01wZTdvY21PWTB1dThwN2tTdFJFeTRJRVZvM25PdmJieHpC?=
 =?utf-8?B?UGxwMTZQdlhERkJLd3p6RnNXWjlFRVZTeC94WmRMaHAzSURFU2VKNmRqVlZj?=
 =?utf-8?B?NUIvNzRZS2VnTE1QeVFXMytab1AwTCt3ZElmbUxyRHZmU3o2bDI1MGZxWGpO?=
 =?utf-8?B?NmdNbHViU0JGc3YxREs3RnpLcVhvMU50dkhXeEJTMHBXMDlNVDl2cm1KdDRM?=
 =?utf-8?B?OFkwL0Z3ZDZNTXIrclYyeEJ4VWw2dk1GNWJTWDdySXNTUnB3eVhmNjJUeWhY?=
 =?utf-8?B?UVE1cEk3WGNIYkhKclp3dVVid2JLZjkwMitQeVVEY2ZWWGRQdUNXQllnRXJp?=
 =?utf-8?B?OU9GYVFYYTZaakp6Uzk1YlFJWDZRVkE5WjFEY3UyMkFyTE1rdzVKL2I2TlFN?=
 =?utf-8?B?aGlKTFJEMFVZOEQ2bHUzak01cFU3eEtrdVd0V2VVYTRqQm94WXFOZFR1L2px?=
 =?utf-8?B?WWdCc0tkNjdSZ2V1d2tacE1BakZxOWhIQkpQTTlJU0FmcFl6c28vRC9YTFJq?=
 =?utf-8?B?MDFLOFlsZnQ5OHNTZVN0b0ltWllNdWJPR0t2dGUrYWprSUZkaFQyREdIdWEx?=
 =?utf-8?B?azJobG0rN2JnSEd1OXU4RWtqcC9vL2t5NFlUd3JDaXNMK29lRzYrUTRRTWRs?=
 =?utf-8?B?SG9wd1lRb1FqQVhjbEZFblNTTVpWWi9zVkJJUjhONS8xUU9HTVl6RmNVNXlo?=
 =?utf-8?B?Q1pacUk0NjFxbHF3bDg4WXpKUzU1MnR6eXBYY05pTTd5aW9CQTFCUEF2YldN?=
 =?utf-8?B?S0ZwTkhnYkdqaENybHdDckhZdlNoNlVWZ3JvNEcwZEw5ZklaWk0ySzk3dnUr?=
 =?utf-8?B?Z2pRQjJUd3lSSlFuNXFrQ3ZDZm5OVXg4S2NCNW53SzZyd1RhSXVFb1lvS2VO?=
 =?utf-8?B?TWlwSmtFQ0taUkdpbFQvTzhrdWtVSjhHT01QWHNVUlkvQkgrdVNJeldadXpv?=
 =?utf-8?B?UWkwUHRzTHZWcXpsNUlkTnNGUzR4RmtVZVhrMS9xZDNSOWpVWk45OTROWFhu?=
 =?utf-8?B?UGZ1RXRZaXZPYURPVHZ3OTlSODBtQmNhckVrd3dxdEFvbXFJbUFRRlNEYThL?=
 =?utf-8?B?RVRldnZuOEVtYUFqZ3RkQlJMTEhpSllVcUZGSXZ5M2RHZDlVRDNzNlZadTZx?=
 =?utf-8?B?NFd4Y25la1hPMFF3MUNZdFdzRkFEUkVpQUQ3VmFyQktCcXdZcWU1dXQ2dTg3?=
 =?utf-8?B?ZWNDa2trRGNRbXl6c1Z5ZzRvMGs4STNRa1cvYkVxT1cyNklyNUJnT3NKcVpQ?=
 =?utf-8?B?bWdtQjlneloyV0ZkR2RHclE3MTVXOXhHTXREUjZSdlB1N2hncHBQRkpMeTNM?=
 =?utf-8?B?QTM2WHB1Y0loUkFXTjk5b0NxdkNoVS9NQnk2OWVTVkw2RC9VQ1hwbmpFVWNB?=
 =?utf-8?B?cnlyTGRURVNvdUR4SVZWQU1GdnZaYmdFaHNCMXI4WWVRRGNwclZWQ3lLL0FG?=
 =?utf-8?B?OFI0dmg1R3ROemorclJidFFxYUJxZ1VuTC9KY0phTml1SThjNDNQN2lDay9T?=
 =?utf-8?B?Y2lMMEE3V1piVENaMnZNSXdrbm1YaGJZUGtEUWV3Mmc1bjNiV2JwUmNQOXo2?=
 =?utf-8?B?bjAzTW00MXlWYnU4Snl2cG1YYXBPMEw4cnhnVHI0ZFVSUmFzeUkzcnhZaFpy?=
 =?utf-8?B?K3pvQXFTZURaY2ZSb0tnc1pmRWMvQW40eU45TjVZMVZnWnkxaW1NUG1EZjZK?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e433e5-752a-4e08-0b63-08dbf66a702b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 14:48:41.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TC8j2Caccyg4aje5j2nG70M8UedoXt7YUlDN2Kh+iGzaXzy5xHV2rIa4EYPD0fUvXEfzs/7hRa2RV4vct7xISF3JcclFBBIUxVnX1s5ZIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3258
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.23 03:43, Shawn Guo wrote:
> On Thu, Nov 30, 2023 at 05:16:02PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
>> and a 7" LVDS panel. Provide an overlay that enables the panel.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v2:
>> * Rework DSI mux GPIO logic to be compatible with overlay
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 200 ++++++++++++++++++
>>  2 files changed, 204 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 300049037eb0b..e08024797721a 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -166,6 +166,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>  
>> +imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>> +
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
>> +
>>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>>  imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>> new file mode 100644
>> index 0000000000000..c6369072577e0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>> @@ -0,0 +1,200 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Kontron Electronics GmbH
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "imx8mm-pinfunc.h"
>> +
>> +&{/} {
>> +	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pwm1 0 50000 0>;
>> +		brightness-levels = <0 100>;
>> +		num-interpolated-steps = <100>;
>> +		default-brightness-level = <100>;
>> +	};
>> +
>> +	panel {
>> +		compatible = "panel-lvds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_panel>;
>> +		backlight = <&backlight>;
>> +		data-mapping = "vesa-24";
>> +		enable-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
>> +		height-mm = <86>;
>> +		width-mm = <154>;
>> +
>> +		panel-timing {
>> +			clock-frequency = <51200000>;
>> +			hactive = <1024>;
>> +			vactive = <600>;
>> +			hsync-len = <1>;
>> +			hfront-porch = <160>;
>> +			hback-porch = <160>;
>> +			vsync-len = <1>;
>> +			vfront-porch = <12>;
>> +			vback-porch = <23>;
>> +		};
>> +
>> +		port {
>> +			panel_out_bridge: endpoint {
>> +				remote-endpoint = <&bridge_out_panel>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&dsi_mux_sel_hdmi {
>> +	status = "disabled";
>> +};
>> +
>> +&dsi_mux_sel_lvds {
>> +	status = "okay";
>> +};
>> +
>> +&dsi_out_bridge {
>> +	remote-endpoint = <&bridge_in_dsi_lvds>;
>> +};
>> +
>> +&gpio3 {
>> +	panel_rst {
>> +		gpio-hog;
>> +		gpios = <20 GPIO_ACTIVE_HIGH>;
>> +		output-high;
>> +		line-name = "panel-reset";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_panel_rst>;
>> +	};
>> +
>> +	panel_stby {
>> +		gpio-hog;
>> +		gpios = <21 GPIO_ACTIVE_HIGH>;
>> +		output-high;
>> +		line-name = "panel-standby";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_panel_stby>;
>> +	};
>> +
>> +	panel_hinv {
>> +		gpio-hog;
>> +		gpios = <24 GPIO_ACTIVE_HIGH>;
>> +		output-high;
>> +		line-name = "panel-horizontal-invert";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_panel_hinv>;
>> +	};
>> +
>> +	panel_vinv {
>> +		gpio-hog;
>> +		gpios = <25 GPIO_ACTIVE_HIGH>;
>> +		output-low;
>> +		line-name = "panel-vertical-invert";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_panel_vinv>;
>> +	};
>> +};
>> +
>> +&hdmi {
>> +	status = "disabled";
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	gt911@5d {
>> +		compatible = "goodix,gt928";
>> +		reg = <0x5d>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_touch>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <22 8>;
>> +		reset-gpios = <&gpio3 23 0>;
>> +		irq-gpios = <&gpio3 22 0>;
>> +	};
>> +};
>> +
>> +&lvds {
>> +	status = "okay";
>> +
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		port@2 {
>> +			reg = <2>;
> 
> Have a newline between properties and child node.

Sure, fixed in v3

> 
>> +			bridge_out_panel: endpoint {
>> +				remote-endpoint = <&panel_out_bridge>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm1>;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_panel_rst: panelrstgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_panel_stby: panelstbygrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_panel_hinv: panelhinvgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_panel_vinv: panelvinvgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c2: i2c2grp {
> 
> Could you sort the pinctrl nodes alphabetically?

Sure, done in v3

Thanks
Frieder

>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083
>> +			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083
>> +		>;
>> +	};
>> +
>> +	pinctrl_pwm1: pwm1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
>> +		>;
>> +	};
>> +
>> +	pinctrl_panel: panelgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_touch: touchgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19
>> +			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x19
>> +		>;
>> +	};
>> +};
>> -- 
>> 2.43.0
>>
