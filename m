Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E37800551
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377795AbjLAITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:19:18 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA31711;
        Fri,  1 Dec 2023 00:19:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqz9jbBQTtMm6OuepP2cgt+LIwHBEeHJqXW4ogL02T7DvmIt3Mdd10mt/hXk0hivka8FT/vdGEJWh7AvAQCsodcrUik9SYDO91jajcfixKw9wCCtF1NmrLA415ru1uyeQgdRvEfRHpGZ1koZ2I4lPGLzBYVfnyTr1KggS+UEGjwPzpatLoTOPNwsYAP7BEkn2OdjEVVso9CRWqvtoqX8wuCZRJ8YYnrcY1eSEdhBKt1O91rHFEQ7fdmOQjohnImNpNz5WBxCO84/vWoV3LllajcXHIHrfFYuBTzU74xbE8dfCj0lrr5dq5jdutQUWrpGcKsJWDM9xmklgk7ixo5ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhIWzq0ZgDaJnXxEKR1shV0PL38ogtsiL6DdY9UGgaM=;
 b=CmXEd3Eab2YZ4rPkCNPOqxHmt/LAewTr/gdK14Hk/zYpvHeKZvj69OpG/rmRJhJn1oWI7/WNGzYLxemaj9JzyijFAmDolB4c6YZ1kmrEgCTGGTCwYy6yHSg3EH9lHsvY5PjI/zPragzr+Ld3sXo+mDqUUnV0tDCHQIjwUhidvJQDyoHT0yezT1M+7rCjLAAJlRkMDikadHHpFCoMc+kiggs21cMriTTIftufibYtEwyyPMh8Y/1WXZFk9dXjy9uCLoJWlS9nAEn5qIIz9nMDF3DlAsKz91SPIgvVrcmuCjfZoE+YsO7OCKW65+WGXfUtvndaXFKkNG0m+1nwjyIHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by SG2PR06MB5406.apcprd06.prod.outlook.com (2603:1096:4:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 08:19:14 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 08:19:13 +0000
Message-ID: <b3629c57-efb6-4459-e931-e160a47bca4c@yunjingtech.com>
Date:   Fri, 1 Dec 2023 16:19:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 1/3] mfd: Add support for UP board CPLD/FPGA
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-2-larry.lai@yunjingtech.com>
 <ZVOABz35C8KmGrrk@smile.fi.intel.com>
From:   larry <larry.lai@yunjingtech.com>
In-Reply-To: <ZVOABz35C8KmGrrk@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::20) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|SG2PR06MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dabd11-32de-40e8-b06c-08dbf2463393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6/XWfF0BFqb2yqEx34Y+GJOCqUX9sGIeJGKt7NPbjxUmBVq07erYP4Ev4uO44797a/4jy4/3VoJCInRoNlR3HwzRgfxfPbPQvfI+lGn/LHRYnzKU6Cqu2Fk/j8jl9gMGBUqptaWxXonbjCH1NWPFtVxzmYch3YM3Fxitu4fvoAuCdBtenaLNcirfEfmB7cSyA5zOHVkJveEI5FRXAFLAWu+AfUfUZ3yo55+Mpy+ChuQtVBFNGTV8ZH7nmwOpodiil5HlLBxGyVlEpki4k4dcAvdeOUzXNLnOsNq3Ybu4sK5FnGfwGVtYCZRd2dzGWDKIlJ3hu3mzyrptNnc4b1Kqi0R/c+tHREIvVWH1llEKo08kxxlQi05RHNVahV9lyP9AeWENnw/p1QfH82ZhchZ94srLslvN9K6XexKX9i4bj9g5tESXKW1N2dLg2ISRPPSF70wCgv2IiF40CJxL9wnNzzrWC+tl801ngGI750wDqm2P/Sh7513SGrFk9zDgYeq0marp2U3W1YBK6vpY9FxblObjad+FQsBLJoB3/lIqYMq/YEB0ricL2CvGA1wlRB/OrK+CYJuhbi5H5h9QuITMfJWK7ULOSlJ1GvQDSbpjx+PDdarwgentlGFV9iJJ/HBtHvmZ71zTDodJNXgj8hY3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(107886003)(2616005)(26005)(6512007)(478600001)(31696002)(36756003)(86362001)(5660300002)(38100700002)(30864003)(83380400001)(2906002)(53546011)(66476007)(6506007)(66556008)(8936002)(316002)(41300700001)(8676002)(4326008)(6486002)(6916009)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJENTJkMWJhM1FpQ3ZDZXViMG5DWFV1VWh6SXNRVmNlanhLZ2UvUXJmcjVH?=
 =?utf-8?B?bFNCWG5weEFPa0dvNDJ2dGlPUU5sRVRZVHNKREE1bVVLZGQrMXhDM0ZDYXk0?=
 =?utf-8?B?cEtzdTVUWlNhZFBKcjd2Z1FNd2NPeHVEUVdJTDBibXRQTWFMdWZYY05kTFNI?=
 =?utf-8?B?QmF4WTNIazBkb1FhQmJxbjFoVkRvbm8wbk9SQVhlcW9rV242T2c2bjliQlZP?=
 =?utf-8?B?bEl4RGRhOVZSVGxiUGJxY1hUTEUyT1Z5eXFrajIzSWVodGxobnByRTRxOWZX?=
 =?utf-8?B?QUFsMWVKYk1DaDhsTng1d25NL2V2bFQ2M1JkWGZ2Q25hcjcyL2hyN1BWRmh3?=
 =?utf-8?B?VXM0bHNwY3BzdkZTMWVaZjdRVGJMOThOaXNzdm13VVZHeUNpbnB1M3RFYjNa?=
 =?utf-8?B?Rk1zY0RWSEU0RDlNV2tsVzU2VkZCeHRDOW9SNmgyVXJjZVB3SXpVa2hseE00?=
 =?utf-8?B?dzgreHROcWhhSlAvTE9RN2E2SWFMbDFWOWk4WWRUbW9xeVJ6NmlEdUp0Q1l3?=
 =?utf-8?B?cTh2T0V0STlMUk5YZ045b1A4RGxGMkpiY0NNOFNvYWdsU2YxOGpGYmFZQ1Nr?=
 =?utf-8?B?Z3FRc2g4bUZQR1FGMllkMjg3ZmZWbEJGNWFjUjlNMDBFYkxFdGhpbzhmeGFw?=
 =?utf-8?B?K2Q5aWRxS3QvVlc0MUJrRURJVnFEQkhxQkN1RTNYRElMcWR6ZHN0QzBPOWlP?=
 =?utf-8?B?bGlrZll3MENqZnBXZXBCZW5XNU5KMEFPZ3JoMXEyQ2RZbzdQbi9RWFc2bktM?=
 =?utf-8?B?c2tWRGZ2SFpMWlhaYlgwOGNYQzdRWEVtaERkK05EbWdTMGM4WXR0UUd4YStH?=
 =?utf-8?B?Zk1CcFpZZFE3cTVSRlJEQUZVcVA4OFFKa21KNlpmTXhwUHVzQUQ1azM5bGxp?=
 =?utf-8?B?MFBiY2ZRQkFlVFpOVlhaZHJBbk9UUmltbjNrWlp1S1pWYzNtWHcrWS9jV0Rp?=
 =?utf-8?B?VjlJTWFDb3pBOWxtWSttc2d4V1hPYldpNWRieDhDa0p2Q215c25hRmtheHp2?=
 =?utf-8?B?S0VySWhtYmRGZ05Ga1VKayt2YVBNWktJMmdESTBodnMyeXB5YUR3dlhrdlZr?=
 =?utf-8?B?Rk50cVNHWlhOVjNpcm1kc0NZeHNsTkhJWVZHYzVUd2N4elVpNlpjMnZkbEMr?=
 =?utf-8?B?MFdsUzhvczVOWlVDMmJqb29lVzIwU1J2UldHcm9RZk83TVl1c1lXVjN4R1B1?=
 =?utf-8?B?Uk5uOEJNdEVLbUlXd1JWUDZFa0JsS3RjckVURHI1YlFwTHVjYlFsMnRsNmhr?=
 =?utf-8?B?TUdJRzd0b2JENE9zZkNVRk0xa3o3bUZFY1J3K3BPbWlTMXhaQVdkWnBIM0g2?=
 =?utf-8?B?QkJ2WGlZVFZ5NkoydzgxRHZBczJTNFZ5eFlJTU5uWUtPazhPN09EaUN0NUlB?=
 =?utf-8?B?cHllck0ydS9PUDFndWlSaWQwUE5HdzB4VkpoTzFZY1A3V09JTDhjRGJRTEpo?=
 =?utf-8?B?a3l3QndCamRqeFBEQk5scDJwd2ZmT1k3ck1FYjNQTmV5UlJ6M0IzUGZ6Ukg4?=
 =?utf-8?B?SC8zdVFYdW85ZVhDaUtmRTFQYmdBbnhiZmtlcGpDdE5LZkU5ZmpjekhpTitS?=
 =?utf-8?B?dXNBb1V5SmlhM3dkTWdYQXFWSGJCWVNzemlXU3B3azhZVFhTZUlJUmY1dm9v?=
 =?utf-8?B?UlhBaHd1Zm5ZSTZOb0pFZmJCQjh6OFhmTDJZQ2RodHJ5ZFhRU0xxSGlSa25p?=
 =?utf-8?B?SkhsVUpLRFlydTFVT3hXaGs0NTRVdTliZGgzbWNRU3NVR01Pb1VYRm1KZ0Z4?=
 =?utf-8?B?KzZwTytNS3R0cmhOcHJCNGxkRy9iaFBLeFpBdi9MMUZ2NWRQNHNROW4yK3c3?=
 =?utf-8?B?aWZpd2RVeEN1WHk0cmRiSkQyOXVzRlA0MXJSZHRFQ0p3dzNaTmY5WThYc2VB?=
 =?utf-8?B?U2l0RlVkUkJ0TDM0dlV6cFc4Z29ZWmJCZGdIS1Y2dHQ2K05HbVlwa1djSlh1?=
 =?utf-8?B?NGV6NXJLN0N4WEFWY3kxYyt0Zktldy93djQvTkxxMDlLQ0NUcWZuVzNORkJ5?=
 =?utf-8?B?c1JOTGh2dEJ5T0hKdTV4OUtUTEk5UFJWRnZ0NDRRK1JGZEdkbWhpbUJWeC92?=
 =?utf-8?B?NDhaVENhK3ZsT3d5VjBQaExJc21WeWIxSWxBWFVYQTZiUkZ5eVk4VUF0ZHJT?=
 =?utf-8?B?eWhMbkhLN1Z4NWVNbnN6QWJGVWk1QjlpMjIrb25GWFQxdzVacDZJekpBcU02?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dabd11-32de-40e8-b06c-08dbf2463393
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:19:13.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw7W5Nq/mv+Ixi74pGo1PYBi72dDqgJm71+hwkzR2s3yac/88GtegfUCyRSiS31SXVI8tybJrimh9KpQGTKCO3nfnZFlS/dscSDH7q9sE74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5406
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,
   Sorry, replied Gary's mail again for plain text format & mail client
as Jones's suggestion.


On 14/11/2023 22:11, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 09:51:17AM +0800, larry.lai wrote:
>> The UP Squared board <http://www.upboard.com> implements certain
>> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
>>
>> This driver implements the line protocol to read and write registers
>> from the FPGA through regmap. The register address map is also included.
>>
>> The UP Boards provide a few I/O pin headers (for both GPIO and
>> functions), including a 40-pin Raspberry Pi compatible header.
>>
>> This patch implements support for the FPGA-based pin controller that
> 
> s/This patch implements/Implement/
> 
>> manages direction and enable state for those header pins.
>>
>> Partial support UP boards:
> 
> "for UP" or "supported" (choose one).
> 
>> * UP core + CREX
>> * UP core + CRST02
> 
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> No, this tag can't be applied to the new code.
> 
>> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
>> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> 
> Missing Co-developed-by?

larry is our consultant for upstream

> 
> ...
> 
>> +config MFD_INTEL_UPBOARD_FPGA
> 
> I believe Intel has nothing to do with this one. The Intel SoC is accompanied
> with OEM FPGA, right?

we used Intel Altera CPLD MAX V/X for pin mux and provide more driving
power for Raspberry Pi compatible HAT pins, but will remove INTEL instead

> 
>> +	tristate "Support for the Intel platform foundation kit UP board FPGA"
> 
> Depends on the above this most likely to be updated.
> 
>> +	select MFD_CORE
> 
>> +	depends on X86 && ACPI
> 
> No COMPILE_TEST?
> 
>> +	help
>> +	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
> 
> Intel is Intel.
> AAEON is part of ASUS.
> 
> They never been part of Intel AFAICT.
> 
>> +	  This is core driver for the UP board that implements certain (pin
>> +	  control, onboard LEDs or CEC) through an on-board FPGA.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called upboard-fpga.
> 
> ...
> 
>> +obj-$(CONFIG_MFD_INTEL_UPBOARD_FPGA)	+= upboard-fpga.o
> 
> Just drop INTEL_
> 
> ...
> 
>> + * UP Board control CPLD/FPGA to provide more GPIO driving power
>> + * also provide CPLD LEDs and pin mux function
>> + * recognize HID AANT0F00 ~ AAANT0F04 in ACPI name space
> 
> This needs a bit of English grammar / punctuation update...
> 
> ...
> 
>> +#include <linux/acpi.h>
> 
> How is this being used? Perhaps you need mod_devicetable.h and property.h
> instead (see below).
> 
>> +#include <linux/dmi.h>
> 
> Unused.
> 
>> +#include <linux/gpio/consumer.h>
> 
>> +#include <linux/kernel.h>
> 
> What this header is for? Perhaps you meant array_size.h and other(s)?
> 
>> +#include <linux/leds.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/upboard-fpga.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
> 
> ...
> 
>> +/*
>> + * read CPLD register on custom protocol
>> + * send clock and addr bit in strobe and datain pins then read from dataout pin
>> + */
> 
> As per above, seems like all your comments need to be updated to follow some
> English language rules...
> 
> ...
> 
>> +static int upboard_cpld_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +	struct upboard_fpga * const fpga = context;
>> +	int i;
>> +
>> +	/* clear to start new transcation */
>> +	gpiod_set_value(fpga->clear_gpio, 0);
> 
> No wait?
> 
>> +	gpiod_set_value(fpga->clear_gpio, 1);
>> +
>> +	reg |= UPFPGA_READ_FLAG;
>> +
>> +	/* send clock and data from strobe & datain */
>> +	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
>> +		gpiod_set_value(fpga->strobe_gpio, 0);
>> +		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
>> +		gpiod_set_value(fpga->strobe_gpio, 1);
>> +	}
>> +
>> +	gpiod_set_value(fpga->strobe_gpio, 0);
>> +	*val = 0;
>> +
>> +	/* read from dataout */
>> +	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
>> +		gpiod_set_value(fpga->strobe_gpio, 1);
> 
> No wait?
> 
>> +		gpiod_set_value(fpga->strobe_gpio, 0);
>> +		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
>> +	}
>> +
>> +	gpiod_set_value(fpga->strobe_gpio, 1);
>> +
>> +	return 0;
>> +}
> 
> This looks like SPI bitbang. Can you utilize that driver to do this for you?

the protocol is defined by ourselves using gpio pins to communication
with CPLD 16bit or 24bit data(different CPLD and firmware).

> 
> ...
> 
>> +static struct upboard_led_data upboard_gpio_led_data[] = {
>> +	{ .bit = 0, .colour = "gpio" },
>> +};
>> +
>> +/* 3 LEDs controlled by CPLD */
>> +static struct upboard_led_data upboard_up_led_data[] = {
>> +	{ .bit = 0, .colour = "yellow" },
>> +	{ .bit = 1, .colour = "green" },
>> +	{ .bit = 2, .colour = "red" },
>> +};
>> +
>> +static const struct mfd_cell upboard_up_mfd_cells[] = {
>> +	MFD_CELL_NAME("upboard-pinctrl"),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[0],
>> +		       sizeof(*upboard_up_led_data), 0),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
>> +		       sizeof(*upboard_up_led_data), 1),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
>> +		       sizeof(*upboard_up_led_data), 2),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
>> +		       sizeof(*upboard_gpio_led_data), 0),
>> +};
> 
> Why is not using LED framework?

CPLD has 3~4 pins to control LED, read/write CPLD to control these pins.

> 
> ...
> 
>> +static struct upboard_led_data upboard_up2_led_data[] = {
>> +	{ .bit = 0, .colour = "blue" },
>> +	{ .bit = 1, .colour = "yellow" },
>> +	{ .bit = 2, .colour = "green" },
>> +	{ .bit = 3, .colour = "red" },
>> +};
>> +
>> +static const struct mfd_cell upboard_up2_mfd_cells[] = {
>> +	MFD_CELL_NAME("upboard-pinctrl"),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
>> +		       sizeof(*upboard_up2_led_data), 0),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
>> +		       sizeof(*upboard_up2_led_data), 1),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
>> +		       sizeof(*upboard_up2_led_data), 2),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
>> +		       sizeof(*upboard_up2_led_data), 3),
>> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
>> +		       sizeof(*upboard_gpio_led_data), 0),
>> +};
> 
> Ditto.
> 
> ...
> 
>> +static int __init upboard_cpld_gpio_init(struct upboard_fpga *fpga)
>> +{
>> +	enum gpiod_flags flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
> 
>> +	/*
>> +	 * The SoC pinctrl driver may not support reserving the GPIO line for
>> +	 * FPGA reset without causing an undesired reset pulse. This will clear
>> +	 * any settings on the FPGA, so only do it if we must.
>> +	 * Reset GPIO defaults HIGH, get GPIO and set to LOW, then set back to
>> +	 * HIGH as a pulse.
>> +	 */
> 
> So...
> 
>> +	if (fpga->uninitialised) {
>> +		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset", GPIOD_OUT_LOW);
> 
> ...make it _optional() and use GPIOD_ASIS.
> 
>> +		if (IS_ERR(fpga->reset_gpio))
>> +			return PTR_ERR(fpga->reset_gpio);
> 
>> +		gpiod_set_value(fpga->reset_gpio, RESET_DEVICE);
> 
> And with gpiod_direction_output() it may be conditionally called.
> 
>> +	}
> 
>> +	gpiod_set_value(fpga->enable_gpio, ENABLE_DEVICE);
> 
>> +	fpga->uninitialised = false;
> 
> How this flag is anyhow useful? Are you expecting the __init marked function to
> be called twice?
> 
> Oh, it seems even __init is wrong here...
> 
>> +	return 0;
>> +}
> 
> ...
> 
>> +static const struct acpi_device_id upboard_fpga_acpi_match[] = {
>> +	{ "AANT0000", AANT0000_ID },
>> +	{ "AANT0F00", AANT0F00_ID },
>> +	{ "AANT0F01", AANT0F01_ID },
>> +	{ "AANT0F02", AANT0F02_ID },
>> +	{ "AANT0F03", AANT0F03_ID },
>> +	{ "AANT0F04", AANT0F04_ID },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
> 
> Move this closer to its real user (struct platform_driver below).
> 
> ...
> 
>> +static int __init upboard_fpga_probe(struct platform_device *pdev)
> 
> How comes it's marked with __init?! Have you tested it?
> 
> ...
> 
>> +	id = acpi_match_device(upboard_fpga_acpi_match, dev);
>> +	if (!id)
>> +		return -ENODEV;
> 
> No, use device_get_match_data() from property.h.
> 
> ...
> 
>> +	switch (id->driver_data) {
>> +	case AANT0F00_ID:
>> +		cpld_config = &upboard_up_regmap_config;
>> +		cells = upboard_up_mfd_cells;
>> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
>> +		break;
>> +	case AANT0F01_ID:
>> +		cpld_config = &upboard_up2_regmap_config;
>> +		cells = upboard_up2_mfd_cells;
>> +		ncells = ARRAY_SIZE(upboard_up2_mfd_cells);
>> +		break;
>> +	case AANT0F02_ID:
>> +		cpld_config = &upboard_up_regmap_config;
>> +		cells = upboard_up_mfd_cells;
>> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
>> +		break;
>> +	case AANT0F03_ID:
>> +		cpld_config = &upboard_up2_regmap_config;
>> +		cells = upboard_up_mfd_cells;
>> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
>> +		break;
>> +	case AANT0F04_ID:
>> +		cpld_config = &upboard_up_regmap_config;
>> +		cells = upboard_up_mfd_cells;
>> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
>> +		break;
>> +	case AANT0000_ID:
>> +	default:
>> +		cpld_config = &upboard_up_regmap_config;
>> +		cells = upboard_pinctrl_cells;
>> +		ncells = ARRAY_SIZE(upboard_pinctrl_cells);
>> +		break;
>> +	}
> 
> Drop this and make a custom structure which will be part of the driver data,
> let's call it struct upboard_info. When it's done, you will simply have
> to access constant info structure whenever you want to.
> 
> ...
> 
>> +	platform_set_drvdata(pdev, ddata);
> 
> How is this being used?
> 
> ...
> 
>> +enum upcpld_ids {
>> +	AANT0000_ID		= 255,
> 
> Why not to start from 0?
> 
>> +	AANT0F00_ID		= 0,
>> +	AANT0F01_ID		= 1,
>> +	AANT0F02_ID		= 2,
>> +	AANT0F03_ID		= 3,
>> +	AANT0F04_ID		= 4,
>> +};
> 
> ...
> 
>> +enum upboard_fpgareg {
>> +	UPFPGA_REG_PLATFORM_ID	= 0x10,
>> +	UPFPGA_REG_FIRMWARE_ID	= 0x11,
>> +	UPFPGA_REG_FUNC_EN0	= 0x20,
>> +	UPFPGA_REG_FUNC_EN1	= 0x21,
>> +	UPFPGA_REG_GPIO_EN0	= 0x30,
>> +	UPFPGA_REG_GPIO_EN1	= 0x31,
>> +	UPFPGA_REG_GPIO_EN2	= 0x32,
>> +	UPFPGA_REG_GPIO_DIR0	= 0x40,
>> +	UPFPGA_REG_GPIO_DIR1	= 0x41,
>> +	UPFPGA_REG_GPIO_DIR2	= 0x42,
>> +	UPFPGA_REG_MAX,
> 
> No comma for the termination.
> 
>> +};
> 
> ...
> 
> Also, please split by models, first you add a driver with a single board
> support and each new board addition is done in a separate change.

the driver design is based on CPLD, the block diagram showing the
dependence, pinctrl-upboard driver will check each models from DMI.

-------------------------     ------------
|    Intel SOC,1.8V     | --- |ADC Chip   |  native driver
| GPIO/I2C/SPI/UART/PWM |     |SPI/I2C    |
------------------------      ------------
            |                      |
--------------------------------------
|        CPLD/FPGA Driver            |   upboard-fpga CPLD control drv
|   provide more GPIO driving power  |   register leds-upboard
|        HAT 40 pin mux function     |   register pinctrl-upboard
-------------------------------------
    |                     |
--------   ----------------------------
|3 or 4|   |    HAT 40 pins, 3.3V     |   leds-upboard
| Leds |   |GPIO/ADC/I2C/SPI/UART/PWM |  pinctrl-upboard
--------   ----------------------------

> 

Best Regards,
Larry

