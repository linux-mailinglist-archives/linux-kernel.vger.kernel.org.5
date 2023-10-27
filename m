Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32C7D9D30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbjJ0PmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0PmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:42:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2129.outbound.protection.outlook.com [40.107.249.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D81CC;
        Fri, 27 Oct 2023 08:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM9c6vqf/uUIKhaOI21g8aJj3oT6AvXUxLM/yH+a6AtUdKPnmNBETe8bN8Ec6Uu9I82qUgCswp/r2usGOiuRfEpsMt05RIdnw8wNlTo7zL1Y0+EHdarngZhei5VgMSXn6u4FZLjN/ItDUJT/ik1LKOQHG6CCWeLvsFpeB2+xdsnuBK4Mu1HKuCrq4K+MbWaOvMt+wDdUHI2QDlkX/5Q/44Kr0hUy8a/1dqONTuYs4OcCLZlpHviQII6bWR7AbRDnYwS6nuzHtz0RL4NeR9mc7I+kSALCGDH21FkB5XAqjLYFArdHVIAh4b+LG9j0JT5zkd3tEgzpsLf9PcVhHhtumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bE8D/xQpBD6Cb7rVv3yNAnYx8OOP4OPikFfSBnkLeA=;
 b=Ww4W4XVLMkFTQVWb1cDi92EChvrTUeUlI0/PGfjYorD92mAsRdxN94GbYxS5K00sao+X/E7RTmSdtpAblUXwdgpuV5PFVLmYd6bz/VV2d328wK09obegUTjPZ4hdyrbz1anEhTZvyzT16fjSnZo1j1ksxnhju37NaEdDXSv9Fr2/SSDxClCPO6ZQSPOcfy2tLTjTAo96LGgvLvnSONvLZ0wiLNpX54UtjPeTz60+kgxn+YAfXUhBAYuAuHzU3KPliZ3GCoUQDyXkWcT3qP80q2EZ8n+QGTFzqPtZVsD5Q0+Cats89o2y5KIwm4bCoKQoQsv6Ocxcq34bsp3etCR/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bE8D/xQpBD6Cb7rVv3yNAnYx8OOP4OPikFfSBnkLeA=;
 b=AxRaucS36EzSTv4CcWzpbV+hQ0ZZ+nXuk8rMwG6TEucB9OHGdyMYphFL/g+ccv2QVMRJPhhpQR+/wBBkwUfOZDtvjiodUhnrNHC3A5nWky99x82zl4dmFio7R7Cd2pf5ajC0iwDtwgWLBxekukeeAmtM8e+vnJNUFPj9NS5Yzs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB3PR10MB6884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 15:42:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 15:42:10 +0000
Message-ID: <142c6d0e-04a2-4e1a-b0e4-a06137d9a035@kontron.de>
Date:   Fri, 27 Oct 2023 17:42:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spi: Add parameter for clock to rx delay
Content-Language: en-US, de-DE
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Stoll, Eberhard" <eberhard.stoll@kontron.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net> <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
 <DB9PR10MB8246A77EE4E7140E845D82FAF1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <20231027144646.577210ff@xps-13>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231027144646.577210ff@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0031.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd09bb0-7a7e-41fd-28e8-08dbd7034857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHQUm4F1qioYsCxY6q6dIwMloNbqW4HTvrNtAY3YhXJvC0KNRforu+PTIOFVbk2DeeGbFpqfqQA5+YPY+8Dt84w0Br6H/wAKNEATkkBZ9r60mseZmcdVdW6/Gw09NFvkHEDIwxvhYjVjkL4pycva7SbzheNwRSOvq4SISL4bYFcVn5HGUJFKnoRY3GeVaDIcvv7bhFYtRJLWwyLp4C+pOJEKZm9L921C6Wefn7SeYkV66U4IJ4feOQQuT3gBiVVbMvdtmeORXLgurucjnFTTOyPMYZylBw4cvBm2gN2qwI9h7NUZ2EU+dUtDtyOLiLMacy0xKEujU2p3mVF5XUFB0EPWNxzd9+WVNFpzdxIbSMh/V+cjaMRODpW1T5DiZw8bqBGcyzMOnv9rPHIB4NBlZX9Dg6uz0IqePOFIS++I0we6FxyIqszFArjOTcDd2rc9yzd1NYenVRRbAWPqmqDrP5q+aVuuHHrdB4x+PB0MRT8J5xsGppPTX5XlFm3H8jTUsyTURCpn23M8Af4/CK8OyFzQ906MkHp7FJPcjg9T9DQgADj0vt1xl/GPt5yS+PBrbQrEpW0uL1Gwd+wokTp8s8+dE13KCZFMjSvGk5un+gkTKzAnVGSSq2L1bgIatnfweRFWaewnqsuFkIum5nvB0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(2616005)(41300700001)(44832011)(5660300002)(8676002)(6486002)(8936002)(4326008)(6506007)(110136005)(66556008)(66946007)(66476007)(54906003)(316002)(6636002)(36756003)(478600001)(6666004)(53546011)(86362001)(31686004)(38100700002)(2906002)(31696002)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmszaFlUYm1jMGVOc3VtWG1JTHoxNjRvVmRHdWdlbWMzOTVrSWJ0dzFpNE9F?=
 =?utf-8?B?bnpTUUwxQURXOUVRalhiYWgyZUN0SUVsS21POG1qMFlQc0RNTFR1bXpkK3B2?=
 =?utf-8?B?eFM2aW1yUWlKMlczRHpRb1lhNEJtWEtlQ1U1SVpKdXl2eXBkRmVyN1NyNXVQ?=
 =?utf-8?B?OHo4bVlhNmI2VjhycWJDRmNHME1idStmWW1qdEM4cHphdTFzbFBya3pVTmZG?=
 =?utf-8?B?dk04MWRVYzFCc2NUb1hnMVA3Tms1Z2dzSjRuL1g4WWZCaDVlNHl2Vnlrc084?=
 =?utf-8?B?UzR1LzlrWFBGYml5SmhRUzVnc3BPZjh1WVNCMnBBQXY3UEJUY1cxNngvcWVo?=
 =?utf-8?B?TjcxeG5RUnBlOFhYajdvYWsxekhnc2xYeCtvdndyUGQ3Q3Bhc1pmSXE5Mklp?=
 =?utf-8?B?cnVnWHBaSzR2a0hlMGhlSC95aTJpc3NMS2NweWNDd3ZDdVYwUnViczJGUkNm?=
 =?utf-8?B?alZMRDlCRVByQmJDV29JSGVXRFdtWUc1NEN4ZHp1WGkyR3V6V3lpcEo2M2h2?=
 =?utf-8?B?L21DUk1GSEZNbnN0K1dVdnU4cDFWbERlMGpDa1h0SEFySGdxMFluUmhpdWJC?=
 =?utf-8?B?NmprbE1TTDN0d2pQYlh1aUd1UERZTFhQNEUvVklUWHhkYStXdnlSVDVsQWxv?=
 =?utf-8?B?bUFtYkVYbUVXWW9kbklVYmVvd0RXZU1Da1ExVllrcElqSnBtSEROMXhQaThU?=
 =?utf-8?B?TWMzTnRseU4rY3lFTURmMXd2bkF1eGtxUnA5QTR3TW11U0dORHBleGdMaEsx?=
 =?utf-8?B?TEVqbHcwRU9UemxXRU1kT3RiRy93NE1LTHV0eG9GMmRQbWNsb0wrR0ljQ3JH?=
 =?utf-8?B?STFSRVBTamllbUl2TVZKTTBFS2gyUTNDWlhEWExPRlJDcHRLUW5Ha0poVEw2?=
 =?utf-8?B?ejY5R21Ram5pbWgxY3RYZzR5V0tkTUhVV2VCRnZxdDRjdjdheGhTSzU1WHgx?=
 =?utf-8?B?VjEvaEc4VDE4ek8xd0E4b2QyNFMrdXVYakFoVlBIRkFlbzZaYUllTzM1bzJI?=
 =?utf-8?B?eG1kVnRudTByRkJHTkRFQnMzbmFBMThTckN3TjgxcmVXS3V2MGErQ2ljWkJa?=
 =?utf-8?B?QU5UcUEyT0x2WVVZV3NZSnFQNUJ4UFZLclQvWlovbk02RUt1NEFNcCtSR0k4?=
 =?utf-8?B?UXg0TE95SERjcWRaZnE2TVpXMGtOMExSYkRGRk5EU0hLempIRHFkN2Y3aHlW?=
 =?utf-8?B?Y0V2TzF3ZDQxRFFHbzdNY1NqRTBhQ1ZmeXJNcUpIRGdPZFZMUjVyQnNhVE1n?=
 =?utf-8?B?R2tOMTNCT0g5NWc5MW9KVEk0NkFWQWdYZXZzRkVuRzRoelhWTkVBeFhWQjJW?=
 =?utf-8?B?K1ZiR0w0T3JDeUVvNHpTUWlQNDZCY3RHKzJyTzFLbnZvYy9aWkJhZk9kYUNL?=
 =?utf-8?B?ZW9DM2ZaUHJGY2xlMGJZZlg3Z3hiVS9hT1VlbVVZTExpcTlqTkw5R29VNWts?=
 =?utf-8?B?VmxsbFR4ZllSRFJ1U3FRTXVENDI0V0l1akMwNVlWWHE1RTFCZXNZdjJHV2dJ?=
 =?utf-8?B?VzQ2RnZ6RGxPcll5SVlXM040a040dTl3STU0cGkrSWgzb1BmS093eWE0b0tD?=
 =?utf-8?B?dEFwbDhBNkR5QW1YWEVJVGdJWUNDNWREa0tXRnN3dmZrZlozRUJ6QzVzNGNs?=
 =?utf-8?B?dDRJd0pxWG1sak9VZlFFWE12a0xQN3M1VkNYNk5LL294YUtxa05IdmNTZGRp?=
 =?utf-8?B?VnFnN0liYmZHc0hDamxEUWN0R3EzMkoxZlVxV1l2YWhISDFiOGpnczI4WkJM?=
 =?utf-8?B?NUFIVFpZM0oza0pnMCt1T2dvZG10QThvcTU4TUVoUW1OWGJtTGJFSG94RjBM?=
 =?utf-8?B?SFNwbTQ1a1ZIaVBBNzBTNHRtaE8vWGhpTkxsb1ZTS25tNmQwS01sNjNzVG14?=
 =?utf-8?B?dlNRZXB6WVhrS3BHcStWREFxRDVIaG9IVzU1R0JkU0lTNHprYThJMWFkWEl3?=
 =?utf-8?B?QUlGblBGRU96bFVmN245dHNPNEF1ZFRXZ0puMUwwMFNpNExYSmhibGVtK0pi?=
 =?utf-8?B?aGdPRVYvaG9LYWdQempsb1Z6VzhWQkVsZWtZVGN4aGtxUjc3NVh6MTJEZHRK?=
 =?utf-8?B?RldKNU9FZTBNY1czVzFPWmZNRVF0M1ZxQjY5czNrY241d0g3VVMrZGd4V2ZJ?=
 =?utf-8?B?Q0ZVdlhHU25FV09lYnNyNVhKU3d5V3dRY2dIL0tiZFZ6MXg2b0UvbWFMU01z?=
 =?utf-8?Q?R1N5X8tcQIneRCQmZWI0AWA=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd09bb0-7a7e-41fd-28e8-08dbd7034857
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:42:10.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVHXzw8GU+xixD/Srvl3hoEuTpQwQDOxomF1ySZtk3/xSBjuu5rNbnobeipLh2yJWHfwZenqT48kwef7tgsGnzQnPWctP+aEbdov9ht2ETI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6884
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 27.10.23 14:46, Miquel Raynal wrote:
> Hi Eberhard,
> 
> eberhard.stoll@kontron.de wrote on Fri, 27 Oct 2023 12:41:23 +0000:
> 
>> Hello,
>>
>>>>> Can you be more specific? I am wondering how big the need is.  
>>>>
>>>> In our case it's a QSPI NAND chip (Winbond W25N02KV). This device
>>>> can operate at 104MHz SPI clock. But it also has a tCLQV value of 7ns.
>>>> The tCLQV value limits the SPI clock speed for this device to 2x7ns
>>>> (if it is not adjustable in the SPI controller) which is approximately
>>>> 70MHz.
>>>>
>>>> Without the ability to set the tCLQV value, the SPI clock has to be
>>>> limited to 70MHz in device tree for this bus.
>>>>
>>>> In our case the Winbond W25N02KV chip is a replacement of an
>>>> older chip. The older chip can operate at 104MHz and does not
>>>> have the tCLQV restrictions as this new one.
>>>> The new chip is mostly is better than the data sheet and meet the
>>>> timing requirements for 104MHz. But on higher temperatures
>>>> devices fail.
>>>>
>>>> In device tree QSPI NAND chips are configured by a compatible
>>>> property of 'spi-nand'. The mtd layer detects the real device
>>>> and fetches the properties of this device from the appropriate
>>>> driver.
>>>>
>>>> So for our case (boards containing the old and new chip) we well
>>>> have to reduce the SPI clock for the entire QSPI bus to 70MHz, even
>>>> for the elder chips which can operate well also with 104MHz.  
>>>
>>> So, to me sounds like device tree source issue. I.e. you need to provide
>>> different DT(b)s depending on the platform (and how it should be).
>>> The cleanest solution (as I see not the first time people I trying quirks like
>>> this to be part of the subsystems / drivers) is to make DT core (OF) to have
>>> conditionals or boot-time modifications allowed.  
>>
>> We don't talk about device tree modifications on boot time!
>>
>> Currently the SPI NAND chips are not fully configured in the device
>> tree data. Today a QSPI NAND is represented by an abstract 'compatible' entry
>> of 'spi-nand' in device tree. Which can be seen as something like a 'spi-nand'
>> bus with autodetection of the connected chips.
>>
>> Therefore there is no way to reference a QSPI NAND chip directly, it's
>> auto-detected by the framework. There is also currently no possibility to
>> set the tCLQV parameter for a single SPI CS line.
>>
>> Some parameters for the SPI NAND chips are already provided only by
>> the fitting chip driver (e.g. flash layout, banks, variants of the command
>> set of the device, ...). With this patchset it's now possible to provide also
>> the tCLQV data for this chip.
>>
>> IMHO a autodetect system does not make much sense if you have to provide
>> parts of the chip configuration also in device tree. The framework should
>> detect the chip and fetch the operation parameters either from the chip
>> itself or from a chip driver which provides the required configuration settings.
> 
> Yes, if the information is discoverable, we should propagate it to the
> spi layer so that the relevant action is taken, from the most desirable
> to the less desirable:
> - adapting the sampling point
> - lowering the bus frequency
> - refusing the probe if none of these solutions are possible

This approach sounds reasonable and I guess we can try to come up with
an implementation. But it will probably take a while as this will get
quite a bit more complicated and we need to dive further into the SPI
driver framework.

And we need to keep in mind that this might cause perf degradation for
some users. I don't think there are cases where the clock can't be
limited and probe needs to be refused, but maybe there are some special
cases with whatever SPI controllers are around that I can't think of
right now.

Personally I think this is acceptable as the alternative is to continue
to use the SPI NAND chips out-of-spec and take the risk of instability
and data failures.

At some point someone probably should check all of those SPI NAND
datasheets and see what tCLQV values are documented there. We already
know that some Winbond and Toshiba chips have relevant tCLQV values
specified.

Thanks
Frieder
