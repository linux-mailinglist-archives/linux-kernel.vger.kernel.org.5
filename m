Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7A7F9E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjK0LRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjK0LRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:17:21 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A15135;
        Mon, 27 Nov 2023 03:17:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzFbK6/h85GiraBs2K9JrTZAR2DXtvLEUmluXuVrbBqYeRhfLuv5VgAU9BVhs+JuJark+tALdrCt871i1oCsppO3fqeq6xlji68QCDvtTqw08kgeJW28mK7u6SpEjur+yL5knbbcJQ60UAkWkNAKkWVb9BbyeI6FwGQun6vQHD8t1P33txwcCLL34SIQSA3rrpOYWOLz/97I5GO/nvpPZETs5Gz+Vmid1wpC+Oasws8LY1wbCdeqCDxVZ/MdzqmBWQrIQyhN55+Y3GDrHWWugsZNax4L0Thb0jngDy6m10CtFR8PCpY86LdyPtqCnp/CEv/K73thK68+CG1HomoQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TwUHk4aYq26hKKTWHjMkouJNcgQyt/8798Kwubhq98=;
 b=IfStxzy4HF62BF0DS4SBbUQF015Y2OYDyyAABDxd8D8+YxzGINapj5eygK4m+QKZk38OKWHGXcV2QwfhlHYbKVbGXz5dVMCuJSKnT/UL1MA9YUL7mPMuZZ2n8iNzQwWXwLAxGwapXikCttKAt7jPOFC8gj0jxjQvRldNNt5ayX8gizDI8SBU0dJAOtFfmNj6mdByAtBfOYRAb6FNrQ0aVn0JuJeX5HEDB0ZlmTTJYCYNn1xEWOwcVPEqE92Oqd6z4MzkVqINZYES7J4++2Lsgb4nshjPDmJ7VpJgNd8IsbcaMmZGh12yPxMdNS4CdRnwJiWh+dE5FFRAvPYbzNdL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TwUHk4aYq26hKKTWHjMkouJNcgQyt/8798Kwubhq98=;
 b=GGB2/ujolbREn5XmIDhFm8P0xLwiDM2jSi/dazaKJ7i9YURSg1oiY2QjDH9XmG3viea2lcjtztKgBaTkm76OKkA80k9DM+gu8lbGd1Altm551FnTi5nGbLK5IekP/JWOs413n3GDfcrgdPb+hCqojUNlCewdrMTmrYvd8oAdEjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB7712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 11:17:22 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 11:17:22 +0000
Message-ID: <158cf11e-53fa-4af8-a8a5-db18d43d0abb@kontron.de>
Date:   Mon, 27 Nov 2023 12:17:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: misc: onboard_usb_hub: Add support for clock
 input
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frieder Schrempf <frieder@fris.de>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh@kernel.org>
References: <20231123134728.709533-1-frieder@fris.de>
 <2023112329-augmented-ecology-0753@gregkh>
 <20231123173610.d6ytwlpbpcqng5pv@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231123173610.d6ytwlpbpcqng5pv@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea211e2-aa9b-4513-9ccc-08dbef3a6d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Clu/SwmGpwRH9HQf6BXgEGmYPzfj6x/iuUtwpy5Z5A52q1uDor1GLLmrEMyNZvpO+OI4LqGMYd12k+kxwZOr8LdJbgUJ2vAyjPVWJLofBS86DPbv2hayGcr0zRgX0NPyKzwTq1nbEZiJG4JrUp1JGPilgw5HmUYJvG8/RuQDfgxbTbP0PT1y6noLuJCO3oSb/QSPh6ZsSeoHbuVOG2QPQc5bc5rPt0hgVCWqnmj7apCOOcHVI6bay3XrpYmxB+mH4pueYk7L0Nqo4NNwsGEOQ3adPamWQyGVHIpyRxs7NGvCBDrq8aU1o/lsj/KANdA0MR8mNj64+kh2NVbEpYdsrSeOCWNodhB1FkaEj3+wKErgTr00TqdtkEbmeYzrc+iJaKvo5NzKYCo/WIEzyRYDJUc2MB7nYcpXX4uOfc1MjmshFkDBhdt/Pv+JpKvfnwEzM+PPMWh1+6e1AnhcOGmoNA+NtYvgCS3/Kp+rqbTIiSZE1tWvsH6j64sp1myCbpzyzug3DyX7C6tMdj1nWtxQjr/7qYOb95NdCo4b+6EeLFaPwGU3giitZ5P7PVx5r67UhDauEyz1mFQBq203G8+koaZn27O2X1f8dFNZ4IzPmgEFP9exxzg3gm3YHwBVmSD0r/6iEmpKVHqph8wHBzEpPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39850400004)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(31686004)(53546011)(6512007)(6666004)(6506007)(8936002)(4326008)(110136005)(316002)(66556008)(66946007)(54906003)(66476007)(6486002)(5660300002)(31696002)(44832011)(8676002)(7416002)(478600001)(86362001)(41300700001)(4744005)(2906002)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZSWWRTL2xpNFMyRzlkVmxNdHdSall6TzJLY3JEc3NIMTVIbUdiTTBMUlda?=
 =?utf-8?B?Q21OOHpQSmJLclAwcktRbTlYMEp4MVZYV0E0eGtNdjRHM1QzUnBvUGJhU2lH?=
 =?utf-8?B?dklLenhBRnVGaFR0eVlFSm4zUFZzTGhLMWFMUHRFeWNKL2JaTkkwRGx6bHdP?=
 =?utf-8?B?bE5WN1pkSElhZGRtY1dZYWNQM3ZYUEluNDNzUlFJNVljRUpWZ3B4OEpVOFdJ?=
 =?utf-8?B?VXl5NEYvTDFZejdSbHNyM1dFcUVKODk5RXJuV0xBWTVONzFnTEdCblFhQkE1?=
 =?utf-8?B?bzE2QktnSVVXU09MT2xjK0pmQyt6NW8zUjJuaEpJeGxrVWZBMXcrYnVNb0Zp?=
 =?utf-8?B?V1JCNHVQRGFDaTgzWFBDdjJSVExaOTh3NFJqU2lJc3k2LzNIZE80bmZqS3dH?=
 =?utf-8?B?ZGl2UlIwWlVmUlo2Y1p0Mk54SGRJdzcwY2tmdm9zY0R4SE15OWxaTUYwSmVB?=
 =?utf-8?B?WjEyaUhER0NldXdwN045dW00a0dNV082clMrck1rM1poMWNuUGRucGFTT2sz?=
 =?utf-8?B?TDQ2RmhCMU9CYm5sOEVEQU1oWG5pdWErc1RJQTJzNzI1WEYxOWMwTWF2YzRj?=
 =?utf-8?B?WlJyU3VhdmtvWVdwUVlBZTRaTEo3Z1FXU0J5N1U3RUthb1lFTVE1eWYxREw3?=
 =?utf-8?B?WHRWcWtmVGhFVW1vUmp2V0dIbkR4czVnSVNiOHJvdHpNOGxZdjZsZk96ODFB?=
 =?utf-8?B?RTl4L2JzdW9haFE4U3JPbkcrUWpRRG1sWnVFZkxMK0hCWVdJSkZRUHdTMG1K?=
 =?utf-8?B?SHFiUWlMdzFZOHNrc2R3eGN5dkl3d3FLN2w3dE80V1pBODVsOUNRYW90OFpS?=
 =?utf-8?B?ZVR1Mlg5R25LbUVucXh4UWpRM0NxQzdkUWl4bElUQm0vTGpLMHJTaW83NFJM?=
 =?utf-8?B?cDVsUHc0Z2prbUg0SlgvbzJ4KzVjZzZ0SlBLUEEyVUwyTktZa3hoMHBQblha?=
 =?utf-8?B?ZUV5QUc3SlU4UWFVNkZSVHhGWDhWYjBKRFdiYlVnSFJveHdlZ0JlUEhnSnk0?=
 =?utf-8?B?ZGVWNklyMVQzd2ppaVBXUmJ3RDFMRXNyMlhWc0I4M3VyY3Q2bE1KeU1VUCt3?=
 =?utf-8?B?ZGp2QXhwL0N5VTREd1EydW1pb04wWmtHNHhFY0VBOWYwSmt3emlhL3JtZVEr?=
 =?utf-8?B?YmNkUldLc1pHbitaMEZ3WDl0ckJYeFJPcW9aZ29sUVArd1NZQTZROW9kSzIz?=
 =?utf-8?B?bDZKMDkxTzlPTHBZV1hqQzRXejZ5SmlZb1ljczBqV2xjSFRrTXByS2ZlR254?=
 =?utf-8?B?aGR6VlhUSEpUbHVkYUVkZWtHQUlOUTlxSDJkZW1qRzdYUFd2NWUwZ0k2K0FJ?=
 =?utf-8?B?UE8xYW01b1JUQUN5MUNSeCtUSDd2TG1SYnY5NkxzWS8rVm5TdHVQb2JUallu?=
 =?utf-8?B?UXJQZUpvR1VuMExsbjNpZ25yK0Z1VEl5dEx0ZkpXRGUrVWhMNEU0OWYxRWgz?=
 =?utf-8?B?Ui9zUzZ6b1lYb3dYeS9NRkt4eWRHOHFDeVRtbG9YeXRrVUN6THdET01KVGQ0?=
 =?utf-8?B?U1JRLzhPN0xMeUZ0K0R4YmJPWUt0UGJoZEc5Tm1FNWJOQlk2UWlsakRiQTB2?=
 =?utf-8?B?VHdFQlVWSnRaQnRNRDlxSDBEdTZFVUZlSkI0VUdtZ3VoYnJIS3h1NjVHMkIz?=
 =?utf-8?B?cXI5NUhFNVA4a3NobElwSnhiZHZ0NmQzWi9sQzFYaHlEelNkemU5MGVLZ1Zq?=
 =?utf-8?B?SWFJZndFeHNFNVFzUGJWb3J6Nk5weDBmYVdpY3ZTQStpdXdsZFdXaC9xWGt2?=
 =?utf-8?B?QUFMVUhRQkRoZFg4SFl4WFArR0htbmdjMTFnOHhPTG5FdVFxRXF5NjhVZ3Ix?=
 =?utf-8?B?T0xLVW1WMlhaZ1JOQ1QxMGhEMWwweDRrdjVBZ0FZcG5Vcm5nNTZMc3BERHlP?=
 =?utf-8?B?R0lucUIwUnVoRW01VUcrWWg2Q0owbTdRUERqVlVuVDJHdVZFa2phdG8ydUR6?=
 =?utf-8?B?YWZ1VEZTVXRFbm05TWN1OENibXRRemFkdnBiMDZJam1VMVRGRGtaSnk4aEIy?=
 =?utf-8?B?ODhsVWxuWWhUbE53V21PVDNpbXV5NDB1czU2WlBha1k0emhuSHBtSWkreXJI?=
 =?utf-8?B?ZXdhMjF1TVhNN3NSUzU0QU9HRUxncG9PZ2R5Rm5sbS94NnN5dFVoTHJFM2ty?=
 =?utf-8?B?Rmt2UWh3eC84S1NqZkxFTmVBRDJOMUZhb29SdUVjS0gzVmdiN1F4azlFQVVj?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea211e2-aa9b-4513-9ccc-08dbef3a6d07
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 11:17:22.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duNzEMeITbffotHsEEaTqI5Ux1e/jq3+sEjAIm4az96fZz2q3yNZtgt9rNdRVmVKwOv6QPRgjimwivK+4wyybHiUftyXodizqWXbHAT+t0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7712
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, hi Uwe,

thanks for reviewing!

On 23.11.23 18:36, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Nov 23, 2023 at 01:55:57PM +0000, Greg Kroah-Hartman wrote:
>> On Thu, Nov 23, 2023 at 02:47:20PM +0100, Frieder Schrempf wrote:
>>> +	err = clk_prepare_enable(hub->clk);
>>> +	if (err) {
>>> +		dev_err(hub->dev, "failed to enable clock: %d\n", err);
>>> +		return err;
> 
> I suggest to use %pe (and ERR_PTR(err)) here.

Ok, I added this in v2. I also added a patch to convert the other error
logs to be consistent within the driver.

> 
>>> +	}
>>
>> But what happens if clk is not set here?
> 
> clk_prepare_enable() just does "return 0" if the clk argument is NULL.

Exactly!

> 
>> And doesn't clk_prepare_enable() print out a message if it fails?
> 
> clk_prepare_enable is silent on errors.

Right!

Thanks
Frieder
