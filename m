Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362067B69A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjJCM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJCM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:59:25 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7419B;
        Tue,  3 Oct 2023 05:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOEnGx+HeNHuIHesR80UJGJn7OwmDd+uT7/ZiNxMmbbDNssa4IM6iu8D//pltKTZdaWnnyMyl+GU0+pf66pj2jjkWwjwMDkb9bz/cdAG9MCW/mbpNvHfBwGzD/kN+cJb+DfPUbRPD2bQ5rkmtb25pHLksng+R+potjguki9seygOT40Z/6RQa91+iOINxfzE39d4AToOsctZEDTwQ2C6HslocJQBW3L5dLaIaUbPQIYJk52W7OSAG8rfBx5vMp3TeKz944Sn+2mYTc/w0JH+c31EN16u8pY5hhFc8ZE61XL95kHhfktnSY0oXn6aQzHS3W9PWeMG2kdAA6f1CXvQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM8AvTjB9xsVHVVwj+Wcunso93LLYxn0/14F0bvKJiQ=;
 b=MiOvG4XuceOWOjASzWyAXuslYN+B91CdGkk3Vp7x+7svwWxvyKSQjmzf0Wv5F6k65POIGri3AWTsgMJMtvjOEhDAqPoS7CDRZ+eBTMANAsUsYjQk8D4IHMW71omATSXBjyMvvZrlFwUX9OGHM/1gSx5UgxJVyxTB8b99vO6RdK60jZgPLNAAozC5oL4+drL3PR8ZC+KYkgg5SG4a8nexToHBEz5drtw4oadKGJCiRn8QJlahksRX3+W7x5qiSBamlC1tbhjHLJaWYrsHITSEA35NxWTssk+KMcUNqyf1gcSQ1mV2MVwYIkSSEP3dgoK42Qq+6s2Z05ViOi2yNRLnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM8AvTjB9xsVHVVwj+Wcunso93LLYxn0/14F0bvKJiQ=;
 b=jhX7yoV5p3Lrv5ow3kNxIDx5c1G7qY9bH+k7SyszCdeWvTCQGSwz7M9cKmDMbtLKiilmzpToa/yH9oaG8jVJlqMh3S/RSEjdfyRPoqaXbH5N62tu6Cl56XJVO8SsVt27tQ33kzbgUzhhpd1JrAePYWZK2rNu3NFIOoaJYSXAWBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15f::18)
 by AM9P193MB1064.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 12:59:18 +0000
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d]) by DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d%5]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 12:59:18 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Sony IMX290/462 image sensors I2C xfer peculiarity
References: <m3y1gpw8ri.fsf@t19.piap.pl>
        <CAPY8ntASwh3AcRqE+2zF4Df=u+=wJ5K9icAeOrXTMJGDd1+caw@mail.gmail.com>
Date:   Tue, 03 Oct 2023 14:59:16 +0200
In-Reply-To: <CAPY8ntASwh3AcRqE+2zF4Df=u+=wJ5K9icAeOrXTMJGDd1+caw@mail.gmail.com>
        (Dave Stevenson's message of "Fri, 29 Sep 2023 14:33:42 +0100")
Message-ID: <m3o7hfx3ob.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:15f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P193MB0680:EE_|AM9P193MB1064:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e3a7fd-34c2-46ba-5f9b-08dbc4108e01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfT3KmtGbq7zle1QT8o2D9M/1VWZyEtqBnSgIAKnGVyJ6XGaW8CnW3W0HwI0b3owRgyJOFKw7BJ2PqUvOUGAEFRut1bzcMlUYWzU58xeMkzbw380OMdRslYQy5TWhRgQkpOK5r4OeifTj8FMfxZ9SZ/fYH5T4bPRDYjOjt2YhElesdN2qbDu4BalwxkaHCJGNZztVkro0V9StP3e+Sg1DS6I0WwaStSzoZHO8x2d4yJXyS6WLgS7frB0Cx9ybSpvxZZMaooBEkMhQ8w2Sme0T1tkhENjcid+xmhCe8etwgQhAF7QxQBD3PMHcNrZMer2582Cbi/Ngaw+W7orSdNiUGpa3CKo7PVCKvcA8AcQ15nhYZf8NZzC5rM5BerJgJJYhNRMLJEgIbzT47/0mrtSK+waYEIpKk99LaDGdKUbGdEy/FnsUkWWSFmkIOnUFjq3c7pm8ID+CrdRqWfR+Eeq0Ae4anbIsjVgqyP3idnERseBnc8H6Gbhz+fl3vBqAd4+cGci2l54sOFLlmNqob/DE7hWX9sfGc5GQxfm7ka1H6MFbAoi5N5U8ei4mu8kKNcEfNSjqFrKbz29BUh4ki+A5OBBwWuy6/iFWEZub3erH5/n1gRTGdJeJJuenl0bYE7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P193MB0680.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(64100799003)(451199024)(186009)(1800799009)(6486002)(52116002)(6506007)(6512007)(478600001)(38100700002)(83170400001)(38350700002)(316002)(66574015)(42882007)(26005)(83380400001)(6916009)(786003)(2906002)(5660300002)(54906003)(8676002)(8936002)(66946007)(66556008)(41300700001)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pVdUVwS3pXWHk2eE9Yak1zVEphWlVnVm1zUVZ4NXppc0FPdHFOblVFeHQv?=
 =?utf-8?B?VkRMa1lORnhEaEthY1l6OWNMSmVYZXRZaW5xekpsT0Y4QmgzbERzcHRNWCt1?=
 =?utf-8?B?akhGTjlKMHdFNDE4UzZrTnphQXk1MmtUMUtBb0YvajVTNXNjUTQ3NStDQVBj?=
 =?utf-8?B?UkhvOGhRWXdBcUtGWUM2aHNLMXJZbWxPc2FtTmFLOHVLRjczdDgzcVhTWENk?=
 =?utf-8?B?L3VsSVNFeHRBTVhrVTRQNUR4NS8xQ2htY1R5aXZZamhKYnZpdFhhenFGMCtt?=
 =?utf-8?B?dW5Kc0xuY3V6aTg1T2VydUxQOXN0ZEU4bnNaQ2dVQjlSczhJc3hSVnZJQlV3?=
 =?utf-8?B?enFNbmtEVVJCa0UvVTlRaldYREN6NlFRQW56cjNsQzFhYTRvUmtHRElRMHlN?=
 =?utf-8?B?UkwwUVgyb09LWTQ5bkFPRDZUSkVpUEVYUXlzbWt2dDczWmliOW1XZlc4WHds?=
 =?utf-8?B?WTNJMXh5cFo3RzI5bVVZbUNvS3l0cUc3WElZRngxblkvN2V4M1JnVDZJYWJ5?=
 =?utf-8?B?bEhqbWJGcXhScUpJRWZFQXdyYUhNU3NRMFMxcVpMUXlVY0RnbUdxaFZUQWU5?=
 =?utf-8?B?aDVUL3hwQklSZXpqd21yYkd3S1hucEFkTE0rT1FuT05wbUttSFNpQWFBdmZS?=
 =?utf-8?B?K3psN29TeXlmbGFISlpxTFc5OUVRSmZlYm9VdVpSRmlrTStPRkhQa2htVmJn?=
 =?utf-8?B?M0NOK3VVbEQ1TVloaHhCUjdGTXE3MWFvbXQxdXNKSlFXY2s3TGhtUHc0OVQ1?=
 =?utf-8?B?aE11SnpzMU9MYUdGQktqa0RYeDdvUHhVSmdLRzhUeDFhNGpzczFkTHRPQ2Uy?=
 =?utf-8?B?aGlTYjh3QVR2UzRZNWJRK0Z1Y2FZSnY0d3pMQk55WWhuK0J5aVdJRUZBbE4x?=
 =?utf-8?B?NkdETGh1MnlYbnBEOW1sZzVsU01HNEVuMDkxcTRqZldFMzZqQnpsOTR2UlB3?=
 =?utf-8?B?UWJuQ2NmY25neGxYU3BKcjhrc2tMMzJ5Mkd5aWpiZTJBVUllTzNOcWRkZXdp?=
 =?utf-8?B?LzR6V1R1UkpDMEpHUk5yc0pOeHV1amI4TEI4bmJNS256ZElDMUp5dzhaRDRn?=
 =?utf-8?B?K0RIVm1hTGpBVklUQy9WemlPeEluMDlndVR1MVFGRmRxcUI5eExJVTh1OVQ1?=
 =?utf-8?B?NGdjTzkvR3Z0OXNldmxCNXlyVlZ4YS9vbFRJb2E0R1JkUHFhQ0tWdGZsQ3NB?=
 =?utf-8?B?N1F5Qzhxd3p5THRUWjdnWGM5QWVKQ1hBMUlwb1dxOVU3YzlzV0pqMVBZdVRB?=
 =?utf-8?B?VGtUUi9kdkRlbDhML2FnTzMzbFp4dFROOEthdzRzRGE5YW0rT3Y4OFQ5OFlk?=
 =?utf-8?B?SHdraEV3aW5UdHZmNVBneVEwWVZNU1ppa2hHanV5aG9XSFJXMVMzYk5jN2RK?=
 =?utf-8?B?WUhQMWoySlFrbmtTOGxCc1BDbTFmcnNLZ3k1V2RzdEhBc1Bad2xxdTdDRmtL?=
 =?utf-8?B?ckxHWUdBVmlyNGNWbkROMFdyTlZEbVFmZ3hHU0lLTENHL1Nmc2wzejh6ZUp3?=
 =?utf-8?B?RmNjOHZ0UUNUVkQ2dlc5bW0wa2ZyUEJ3enZSVEF0clVQdWVKbHE1SC9HTHV5?=
 =?utf-8?B?SVBPUE9PYUQ2d05RTm9kZzFRWUU3S3RFVGl6a1cxRUZEd0ZKVDlFY0JSK0xK?=
 =?utf-8?B?dFFCclRZVHFDbGdDRWd4UkR4eWJQWGFGYmI5Mk1oL0Y0K0VTTE5nMTdWMEdp?=
 =?utf-8?B?TEdCMjZkOFBsQkxQcSttdTFPS0FQZmhkZHlzV0VUU1NoYVVNbllmTnBiTEc1?=
 =?utf-8?B?VGlzSTJhSlIwQk1hSEgwblNvZCtRTjdiL3JLV2ordVFycXAwTnc4V3J3NTZy?=
 =?utf-8?B?RHJsMTluN0hqV1cvOU9Wb3BXcHJ6Q2tJaWJvT2NPMmdwb1lKQ3hNcU9zOUZY?=
 =?utf-8?B?REd4TGZBUXIrcnFpZnAwUlJ2UW01YTNVK0h0TDhTNU84RFFJK296QUVxSWF1?=
 =?utf-8?B?SWlLdktsSTNHM2lDSVpxL3dCUE5uUWViWWVjUlkydWhlTUJHdEt3dVBGdDhG?=
 =?utf-8?B?RFFUNmVnODZMNTlSNE8zb0F4NktkREtvVEhCUXdOLzJZVTJOb2Z6emNNVDcy?=
 =?utf-8?B?Zmk5MTBva09XQW8vb1VZTmdrY3UxdkIxK3g3dVFkTVlIcHFxaUtGVFhDN0hB?=
 =?utf-8?B?eEEvSmd0akdUWHpIWG40NVA3VkJVSGxCR1c3K2NSVUN5V3EvY1d5V1lLMzk1?=
 =?utf-8?Q?/14VQfcgLBVVC1o9vM26UK3T0QPFTmCl/ywvbdKdx67Y?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e3a7fd-34c2-46ba-5f9b-08dbc4108e01
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 12:59:18.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWUX1dal/PjFaVlNoZTxsXtEDBi8ZGQdVrDCRodbB2IYKcJJojiXFobMDq4zZDRYTFcShUQQQ/tAD6DbiKOlgWUBvPXHRWRtXgf7gHhBdbXOpIla0Gep4It/vZtj7R6pu7S1luXzgwwUPtl8v6NLng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1064
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

thanks for your mail:

> What's your requirement to be able to read back so many registers at once=
?

Ah, I'm debugging I/O errors while trying to use the sensors, it was
only an example how to reliably trigger the problem.

> I currently can't see a reason for a sensor driver to be needing to do
> these big reads, so how can it cause a driver failure?

I2C doesn't specify a time limit for requests. Even doing basic things -
like enabling streaming - I sometimes get I/O errors ("arbitration
lost"). This is i.MX6MP platform using PIO-style hardware master I2C.
While the CPU has some DMA capability for I2C, it's apparently not used
in this case - maybe because the transfers are shorter than the
threshold.

BTW the "arbitration lost" means here a STOP was detected by the CPU.
This happens when the sensor stops pulling down SDA on timeout, in case
SCL was high at the time (SDA 0->1 with SCL high is technically STOP,
but there is only one master here - CPU - and only one I2C device - the
sensor, so it isn't a real STOP, it's just a sensor disconnection from
the I2C bus).

With 37.125 MHz master clock the time limit is ca. 7 ms - it's easy for
a short transfer to take more time, even on an otherwise idle system and
even with 400 kHz I2C clock.

It happens in init, while enabling streaming, while setting parameters
while streaming. Everytime a transfer crosses the magic ca. 7.06xx ms
time. No transfer can take more time than this value, I always get
a (false) STOP or the data being read becomes all ones.

> Scanning the IMX290 datasheet further, there is a slightly worrying
> paragraph in "Register Communication Timing (I2C)":
> "In I2C communication system, communication can be performed excluding
> during the period when communication is prohibited from the falling
> edge of XVS to 6H after (1H period)."
> and the diagram shows a 1 line period 6 lines after XVS which is
> marked "communication prohibited period". Ouch!

Right, I noticed this, but I don't think it's related. The issue can be
seen in idle as well.

> I've never experienced issues with I2C comms to these modules, but is
> it possible that you're hitting this period with your longer I2C
> transactions?

I'm just hitting a seemingly hard limit with long transfers (albeit it
may be quite short in terms of bytes - times between bytes are just long
due to scheduling and PIO-style byte-sized CPU access).

> A logic analyser looking at XVS, XHS, and the I2C might
> give you some clues.

TBH I didn't try to connect to XVS and XHS. My IMX290 modules don't even
have these signals (apparently -  there are "unused" connections).
I just observed that the timeout is 2^18 master cycles from the first
START. There it very little jitter here (on an oscilloscope - a fraction
of a microsecond). I haven't counted the exact master clock cycles #,
should I?

> Or are you not streaming when you're doing these
> transactions?

That's the case, too.

> IMX462 appears to list a similar restriction.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
