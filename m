Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8287F47DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbjKVNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbjKVNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:34:56 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11591197;
        Wed, 22 Nov 2023 05:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyUzvwgjYcaucG2zmBiSkPOsaNSi83r3aYaYMshOrMlzj/nNajaaFqLpPbDPeWp+1eHRn5qHFFgmi4OtAqmq3N76Lup4ad3xgY7JtrmtszKX4zeUgnHPBS3bktW+BJNr/deCdOpJBpi6eVzUaeZtrEouChnLnZSQBtuIjc8VffpHDvNSScaH/78si0/w7yoTubZQyrwx5rE+QCd9c+o+jD5s6KJ8jaw5vqgv/Bs1gges+vgC5bfbxl1MVtSX8cBg1lBzVqrSxb8DrSL+qo+Be07qeCt0q1kB9lpYMW24rUOhhvxVQIDjOGLBE6bt5F00/HNGMQD7XSvDek9tywkN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5g4da9/LixP/y07m3g/dayOcGYz1RSfenT9PsIOw1Q=;
 b=oBLT4AOBOMs4O10jun4zXvNATK6Ov5MTSUFJG0zZ2W/kGbDT/LbaNv2gvXGtXCn1ZWVzhW3EtQMCOXI20cW6s4XaZZS9eOtx8xOI/Jgtz0g6UD95win7Ke4OQf5Ens9dT3e/l9fN51WNtyghc/igUFh9lojZygR0IDmpbkUQMaJkJT3asUC+xgMVXf52Bll0gzvyhGdHezs6H8mrKrn0DosXBuR318uNx1xnFGqRWDfUMxuqmYbXv6sbRugF4r37co3hX7Mx7Htkp8HlUX3ylAtLKqcCm7JSmxWYT4IgtzqJ1tnKZ6M+eeiu3bxOEhQ6D7wYNdRvMzXsA1zg+hGNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5g4da9/LixP/y07m3g/dayOcGYz1RSfenT9PsIOw1Q=;
 b=XRJy++pQ93Hz5uKHAwrBm9xszCD+iflRiBQSiwPYaaGJ0zVOUJhBkct61Y5ALsh64fYm6u0ypB3+8xcCwARLAehV50h5yJPjjzzJqbitFx3e7l3lcx+ck0m1GSStLxVWxkUusDgrGKYePWe1IOvR7JFajwLNoR7Ch10ZjaNyidY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA4PR10MB7937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 13:34:46 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 13:34:46 +0000
Message-ID: <8c9133ba-31d0-4582-918d-1e1b5dee5eb1@prevas.dk>
Date:   Wed, 22 Nov 2023 14:34:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Content-Language: en-US, da
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Eberhard Stoll <eberhard.stoll@gmx.de>, sherry.sun@nxp.com
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        eberhard.stoll@kontron.de
References: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
 <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
 <fc843c33-03e4-4603-9cc9-0b30b2c21c66@kontron.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <fc843c33-03e4-4603-9cc9-0b30b2c21c66@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA4PR10MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 02829625-5dbf-4de3-8aee-08dbeb5fcb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 534KvqeQcF8oemWjIiAHVMv8TYMRfIhI6+kNGyK4fL/qxAQXTyrUSVTMMv6DDwvMOPDis7kXCSuPdwyRpohM4EbZddDnI7gTps+FWKva3X5HdhR6h/XhnH/Bdiah422E6HSvnj0z7Pm6L+nGPfZxyhFaTEl8Ys5QGA+xDKbPLaChsqbG4MV/ZmdqsxKD8Cx99D1Mh773eXRNk4MyX/GQpDdSaMjGUXRUa5GNTjAWIF4KWNNn7NbENi3nicZLUf+fW9OozP+ZoHRu9T529igkY0bFGcjV5TVw77vxIlNHJh6Kfua2izs2NIXgDZdPYTUR4Ado7pVa1kVPipHRuDBompf60mlRV/p26O6O6CmmvK6SKXT6Qf1gBSGp8Qx2f0Rukk71zu4d7ZrPxq4GXOLVtdUuoCCzLbzbWHgM8lqv/rcDfkY7lJaCZb6QR+s1R9d6Easmj7lc7GDsfRNXQXwtt9VcNmzedCP8e2+ZWdT8RDI4Ha8lonzyKcGVb/XOGf9YunJweM1FgZqAcOWR/RWjMqNf6Sh659yMGF3fMV5CJ/rrWmQsI2nflokvsE9hke7eFMftG5Le9zw5Wr6+0Ya4p/1jdVvsG8/prR7BbWqejRw7bwe4iGG2OaThHJE4XxHYNbs42j2/JToTIbidmcbhsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(38100700002)(31696002)(86362001)(36756003)(66556008)(66476007)(316002)(8676002)(110136005)(8936002)(8976002)(41300700001)(4326008)(7416002)(5660300002)(2906002)(44832011)(31686004)(66946007)(26005)(53546011)(6512007)(2616005)(6486002)(6666004)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxydDl4VE9rOFdIb1d1MXBRNzVseTZxcDJVSUpzS2FMUXp6VlpRTGRZTzBZ?=
 =?utf-8?B?NzE1OUJNaGFnTGVXby9lQlBLV2s0cXdWNnhiVjBycW1TWDI0R0VhT2drOWx6?=
 =?utf-8?B?TkQyWFJUejU3b216cUVabWNQZTI3bm9sVTBzcERQT1Rqb0MzYkxUTVQxSnpk?=
 =?utf-8?B?N1VyNDk1R1V1V0JBZFUvSXJROFdjZU5XM0NOYjNkYUxrZFNGZGtYVm5EVDdK?=
 =?utf-8?B?VTZzbGFQM1JWenlPOGZWSlIzMzQwdnQ4M3UyN3ZwRm53QkJhcVdWQjVMbUdi?=
 =?utf-8?B?UzU2SG9tUXEwUWxXQU51ejhydzhMODA5cDZsTkREVWNMWGRJTFJEV3hyd1N1?=
 =?utf-8?B?TlZBTXBhT3FZUi9Rai9OdWJzN3lKMmRET1F5czFPbTZDZGo1c3hjUTBCTm94?=
 =?utf-8?B?MmRBWVdYYWY2YjBjSEtwV3A3RTJtUEdibUR1Q051ZG4zVmhoT2ludjhuVWZD?=
 =?utf-8?B?anVIdi80Sk5DM29qaTJEMm5kUzdZT1VqeWF4NGtLdDFyY0dwcmNhc0xLMkJY?=
 =?utf-8?B?OS9OWXB4WEV1TnZSZzkwT2tHU3E0Rkh3Q2FqN0ZKcGh2a2J3ZjdBbzJ2STFi?=
 =?utf-8?B?bm5qVWdYZ0lzOUN5R2tTY1ozQVNtMWx3d3VpQ05lcVhJb2pEeGRwWUhLWnVx?=
 =?utf-8?B?R2l2WmNZYUJudGNSb0lsa20yZVNneGwrWW16OE52RWNoMk9IYmFsZTErMEpr?=
 =?utf-8?B?TEVoODFpMWExR1Z4ZWRjdGNycWoxUVNTQmN6bEVzQVJYa1JTNlBIZEdEcGJ3?=
 =?utf-8?B?OEJ4VUZBdk1kVkZQaDZEZHBCV05HZ08wYnlQYkNHYzNKV0VSZThlZjJoQnpE?=
 =?utf-8?B?MWVpenZRMDVIOUZ0WDZoblVlTWF6QzZST3FyRXRDT0xMN2pMZUwzWndnVDcx?=
 =?utf-8?B?bHk5NmpkYUVxNUg4d2ZXckV4K04rRjRvM0xjbkxZNXlCYVVVT1NlT1Zibkg3?=
 =?utf-8?B?aGlCWG5EcEkvV0RLRFpFclhMUTgydnVyeVFVclZmSUttcDRkRjUrek9mbFJ6?=
 =?utf-8?B?dG5MSjVYZlZHdnVLanR4MHFoa3pPQzBMMmY0Sk5EVnE0S0Nsa2gyL2tCTDNP?=
 =?utf-8?B?QmFTUVdPb2c3MzJBamV1MDVBQzNPalRUUitDNEpXNm1aZXhzSWxXOFdWOWdT?=
 =?utf-8?B?Y3FXdm1SK3JOMG8vdWlRS3RCam5NaGFNMzhMNWV5NklscXk3dUxWNzNrb2pj?=
 =?utf-8?B?UTBOdHhvb0g3NFA0bThwWndpcHlSQ3MwbC9kYTU3WCtKS2VINXhDOHpRRXlS?=
 =?utf-8?B?czM5bDBuckE2L2dXS1REM0xHWmV6eXRjZE1SRHJRSHVaTFg3RW5UUnp5R204?=
 =?utf-8?B?ekFRTW5ZZVZXWDIwaGRjZ2hycTlOM0ZCcWZSNVpVNVBmNC9wbGIvY04xTzRu?=
 =?utf-8?B?azZ5bXM4U3RwaGNSckJMN3JRTTNtd3kwTXc1VDVsVG1yQzE4TnpISDlSYzI4?=
 =?utf-8?B?K2FOU0hwY3BVNXp3Tk1XVEZHVER4WnBwNmhqVVpOYmhMODVPbklxNUhPcnp5?=
 =?utf-8?B?NGJib25qcmYrN25nM2gzZklGdzZIS2VMZERUQTQ2aUVLKzFrenVzZzF6NHAr?=
 =?utf-8?B?M2VTRXVEL2FSUW9GVk5CNktsR3BidkJiZnhwTFg1OUFSZUZ0eFBoRnRMV2V4?=
 =?utf-8?B?bm1DRERGOEp3TmtYQ3daS3p5akUvTTBhZDFyZTZ2Smd4V1RCRk1FM3BGSEVD?=
 =?utf-8?B?Wm9rRGpHZDVZajVFZ2JubEw2aEM5MG1KK01JWUlhVG5FRTRLK2lpSndaUUpP?=
 =?utf-8?B?cUlHdHFWR05hdzFyOVJsRlkxZ3NPOTFVYXk3dS84Nnh4YkVWQ1Nxck5ZYVVa?=
 =?utf-8?B?Y0diOGw1WEZ0V1RHVWNBOXpMR0ZQY2M5R05HaTd1Wk9LUG1EbHlKdml2eWZK?=
 =?utf-8?B?Q0dLSmJZOUMrZHlsTVp0d1lQZmdlME9HUkFkdTZoZHlFT2FicnpxWmFJSjQr?=
 =?utf-8?B?RkpKejlBWDhWR3graGdYT1RkTi9wWE1ralFCd0M3cVJjRC80SlEzT1FSS3ZS?=
 =?utf-8?B?NlNtTmZNcDVyTG4vV09YTFlJcUJUaTRxOCtYaWhJenJMR0RIbHoyQTh1WkdI?=
 =?utf-8?B?b3ZsOWNuangrckNDQ0E3czRxVnlSbWVwVU1tZFdtdWpiSUVMNmtQcGFyNThF?=
 =?utf-8?B?RDh6YVhFbFdMdWFCT04yWGtvbVJ4T3ByNXFDUFUvOVhvOW1MeEFFejdKQUE2?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 02829625-5dbf-4de3-8aee-08dbeb5fcb2d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:34:46.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcJBDM+XOPyuddFH2lZRYnPiczGQkEvNySOkEXkgPBCkB+BhlAzu6SoLMzOfvpbS168WTx4orsSiaFeRZLsbDfmlam4txDY8H5PATcJePUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 14.01, Frieder Schrempf wrote:
> On 22.11.23 09:03, Rasmus Villemoes wrote:
>> On 21/11/2023 21.49, Eberhard Stoll wrote:

>>> But IMHO there is one next issue with this situation: When the port
>>> operates with WAIT_AFTER_RTS and WAIT_AFTER_SEND then some timers
>>> for callback functions might be active. I did not discover where they
>>> are stopped for the case when the serial port is closed. Maybe stopping
>>> is not required ...
>>
>> Indeed, that's an extra complication. Adding two hrtimer_try_to_cancel()
>> in shutdown would probably not hurt, along with setting tx_state OFF.
>>
>> I wonder if at least mode switching should simply be disallowed (-EBUSY)
>> if tx_state is anything but OFF.
> 
> Is there a valid use-case for switching the mode while the device is
> transmitting? Is this something we need to support for whatever reason?
> It sounds rather an obscure thing to do.

No, I don't think there is, and that's not at all what I'm trying to do.
I was just thinking out loud that maybe we should explicitly disallow it
[further, in fact, if possible, it should be disallowed in the serial
core]. But of course that requires that ->tx_state can actually be
relied upon, which is what my patch attempts to do for the rs232 case -
though it might not be an entirely complete fix, as described by
Eberhard, since we can get to ->shutdown and thus disable the TC
interrupt before it has a chance to fire.

Rasmus

