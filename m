Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4E758EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGSHSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGSHSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:18:32 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022CFE43;
        Wed, 19 Jul 2023 00:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaLhvFTlwbYMkTtFkGiELDsUKVFjBQ8nWFtOgw5tgKqIpsBKo+cSuGPlkJMRoaePSWj53iRMrdAMj6SzN+jDUVjgY8gUHyY9fmhmNsUw0mAX66aIoHCgxwEU4CRqrlBbraLWxqlBkTv9f2jjT8dyI+B03UzFnFRNjT7X3EbT9Qv6RtY/AeVlOCcLwGXxdPRzwISizsusicEktp1KuQbT07Fy2JRXNnMkNK7h3Gt4cS7r8M3lww4jOw1hzujUPrjzTc8LEtC9/8wdSvqF9fGP9OzHPxhyTUX0WeAIb1Cq8IOop2VV8b+fgnBlEdDMXbsDyHz53MoTMgyocXGdYp776Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi2QBSKzFSjDcdrreflBDkz8xo1S1l8YBII/FUXdkCk=;
 b=hU1lrowFxIki956Uu5VbcwiZPXHMMMK1oQd43FVbGdJNUACY8ZgqF6Hqa82NVIXK5y4oxB6H9sM3siTLioYyvGgX9ahx0gTjTod4oWWdhd1tspL3yPa6Yr1r+dommKANnZyPi8yQwgTV8IjQgAJAC0m4gWH8ZHu32pFVoN8T81wQ04y0zLXiIPDfP7tH5HurxUJKqKtx/omx4Q0pMm6WVjuBZWTc5LtBLkGJdtw9teT5fNP+TYaXF6cbbYntP1TAENrnTUt+S0TFyKiY0o59/BKq8LDXdyMyBJ6ocA+GhzmzrBggM1LchRyVX7J2EqXJz2xWo+9+sUa8Br9tah3rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi2QBSKzFSjDcdrreflBDkz8xo1S1l8YBII/FUXdkCk=;
 b=weZNCI/pJzQA/KLyVyIupmh2Zq6LVRe72pPWlUHrw+0LP27SlF8mIaZPgupN+g4B/RUcpGyB00ydV6XnrbFMKpAeviFvSt5JvxU6ClJi/wdLoOnhXFycRAKriMCDgQduNpwfUM+6Mka8YUMFY0g+tUO6W6dS0q07ajiKJryEM8MIp6Oj98LUwmoL7UkuT4R1NfQwkSETMJY0fi+3kNLcao58fDdKFNupBMmxtxGclK3zE4XPp2yKgICsoNk48XtT3ou62NToJUCcoT8oGYryb/Egn+/U3JxTn05RLYoTpEbQI53SAyMXN9YYqmul+ab9jLiVVxbUY7ANCNedFwnoTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 07:18:28 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 07:18:28 +0000
Date:   Wed, 19 Jul 2023 09:18:16 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Message-ID: <20230719091816.6661d535@md1za8fc.ad001.siemens.net>
In-Reply-To: <b1528e3d-15f7-7ab2-b803-917f79efe999@roeck-us.net>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-2-henning.schild@siemens.com>
        <ZLafwOPrw+puH+rF@smile.fi.intel.com>
        <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
        <b1528e3d-15f7-7ab2-b803-917f79efe999@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3737:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c73727-59cc-4e98-9de2-08db88285935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIm6Pen9PvPE88ZNSBeJ22PFpJaEOAwqLXfnaBeS5Ax3J9+uG7+seDObr3Ojy5Qf6WR37e7we06l5dF8gOAa3B+nF5XpfZuw2Fo5iOUzagGGMjPeCWYnxdr6Yyfxlkf4qz3aVR77PMuVpl8Wy7BnNIZdQ8xrBRDiNEtfbJsK0bPAgjHux6SHEnGw9kGW0rcoxEKzxhbpBeAKJJi9X5U2yaqZp95U4nUA1LDJNvf/Oma43QKNixXQRvXQmbysPSzQmxD84YieGK1BQdho2/XNdD+K3tuCqDoZGELux4naHgs8E6MVQcJBXPzi4LlJ2ETq7v/HTkMw4kzjJ+L8EIQUWzL6MMCZZ0ZEYsj316iJg6mbDdNaZLJ6G7S+2cXRY5gOI9y48p/x/vFvZYPAlpyyJ7NEoFBmUB6Yn12KFRZ/cvsRWd00rQSLy9q0fDBPZOzfG13l3Mwz32VXqimn+nBVipTbDDX5GA+8EldngoGTDMJ+svxgiMFbMRbe5X9hfwS4rdqCcdGuHTNokiKFkNZD0h2c+G5HegIyrxzXE9fIhAFuo0ED67GTgYLuu34uQYtn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(53546011)(6506007)(1076003)(6512007)(9686003)(107886003)(54906003)(38100700002)(7416002)(44832011)(5660300002)(86362001)(4326008)(2906002)(316002)(6916009)(41300700001)(66476007)(66556008)(66946007)(8936002)(8676002)(6486002)(6666004)(82960400001)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1ElPgFNoAa0gw8Y+4xQxPaykyh3XbIWXQRO6sBj4Q737GcRuZk/5nUZd2sX?=
 =?us-ascii?Q?Wcz2D4911HKqXtf7VyYlIb4Xdry0viZzRTKt0yD7OD7AZ8GweAEwkSjg6UXJ?=
 =?us-ascii?Q?MoVZWIhM2KHpwTLSPNMEtqI7NvFmZaV8mxGeeEH+9c1FzVwipkYqkXUtw/1u?=
 =?us-ascii?Q?alvHR/i6qQVgZbbU+8X5Ngfswa8jK8sTRDfEJfJ0YxGULw/xqxldgde0Nf4n?=
 =?us-ascii?Q?cUJ/71csxzv9zpu5Z9GnqDQSZIMMiGMB8SfghdKQGaOnXdaDGw2YXicwomE1?=
 =?us-ascii?Q?rISico0OQbz2CiehqbMhrQ14vQ7s/5zOEKBUfxmax5P+87SSKCb3bIIOtftM?=
 =?us-ascii?Q?FdmmxkY72RaktjBFpmQjEbacZIjZlAUWtC6H9VEDzWbYe9ljZMkgPCbiM8Qu?=
 =?us-ascii?Q?uU8Q4BuIuR6CaSmRHo04l5qS8wJZntsUSffrOWDpDzKpOmMPLhiLG4Fz6XDa?=
 =?us-ascii?Q?VPGwnfwKXCpLMcgdM3UsdzANwHTjCEbCPq0fm9KFL8L8XAh3oIcSiB48zIvp?=
 =?us-ascii?Q?o9Z4dRLJWGD0tjjx0ZaT6HTcIgEd4yX2TTu0QNycG+aajaBhrE4/Ug6SXg4f?=
 =?us-ascii?Q?l5PHnVVfcbOOXJU4sue3g3iztvaT7IpQPp8tIDAw5SLM5iZGTuRcX01BxL80?=
 =?us-ascii?Q?r8NBYxdoBDAXjj52j7sZoS30W+H23WwYsRRRUE3gKP0/69Gwi27vwd2ucYFN?=
 =?us-ascii?Q?Csd+xaRSzhiIz6tIcNyoDtWni5iFk24U//ILMyFx0wvJgYVIHMlO2PXBvmbs?=
 =?us-ascii?Q?8X9sROlH5/dyOU/pjZaMSiP7Ix2WILrOndA+Dpw7zbgzVRPtEDmiYTBEgyGh?=
 =?us-ascii?Q?mb7Fn1h8GTRyqWNuw5SIN8I7lWf5ET5lWiO0sE+LkiuPVSSiYnT8KxsGiZQ9?=
 =?us-ascii?Q?dEyara6w4VJbHNB7oK3EC2pEBXIXzo1G7D0gizZVFs8QxWgAFMQaRGPX/kpo?=
 =?us-ascii?Q?SHe6OxLdPRPxr4xupUmC7SUWwTOHeC22bAvztV+dO7GDs8FOCTqQSS88aHYB?=
 =?us-ascii?Q?UiI/nSIPDSFTPMwFZ7TB2mapM1py8T3nS/Pn4R+BjUoh+u25zLLeLSYqVYss?=
 =?us-ascii?Q?uEC2kslqxYwLa63c2/nTiK8Y09eLbTICfNLhIgbiK3kqmX634iJqNk1VJgst?=
 =?us-ascii?Q?J8fECGwHkM1qSMrckZYnC4Pp7vLr366/5okCx8r0w8Xi66mlBii6fKhRa/k7?=
 =?us-ascii?Q?qIgYEymJLMNO5t6Wii1aRVGkxzMmSUArBQamt74lQCggaIHzW/krOZNESleg?=
 =?us-ascii?Q?54LLsiLsHsZ5gtzNXOdhoY/p5CfJV1rejzQQIpT5xrE8/02yK1Qg/uWW6S1T?=
 =?us-ascii?Q?8nDzRToeYlGgjvMDR2AZc1EN9Vn8HI1DmQcSIFk0tbP27QkX7RGPRAH0m67S?=
 =?us-ascii?Q?r8+pdotrXym2z1mzfHye93L/sSYn06M5MonS32vXmnIJ8H/6KCX00hfvzIOF?=
 =?us-ascii?Q?s2W/KGjPs0vQ3ck11QPEfOkGRvsb/ePRw/bq3bP8mHfM6+11gRQRix30y6B/?=
 =?us-ascii?Q?jCWHBwMP+6+i45d4JegeptYfuIjINvplAqz0TZtG7E+O+KJpMyn0EPbTN217?=
 =?us-ascii?Q?bkGvE0EzSIHHGFBfx6aZQDfSArHPxumRmOw/020xi/+lu7/uAKqHs/54AAx/?=
 =?us-ascii?Q?XfAA8eENjfkm8Ow2dG/GcxtQAeKmqBsBlDocrdCDc9fXf7f3HUe+KJZHViiv?=
 =?us-ascii?Q?E/mMbQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c73727-59cc-4e98-9de2-08db88285935
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:18:28.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLEUTfQ3kB2XqSDyqzFjl9lMMQm4MJBc3SeDXDiXcB1GjrWi93a7pcl7xeDY2ob3ZsXgZoFAsg8y6bodH43r0Sv1jYX9jAHoAEH+UVSjEbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 18 Jul 2023 08:10:09 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On 7/18/23 07:42, Henning Schild wrote:
> > Am Tue, 18 Jul 2023 17:20:48 +0300
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >   
> >> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:  
> >>> If a user did choose to enable Siemens Simatic platform support
> >>> they likely want that driver to be enabled without having to flip
> >>> more config switches. So we make the watchdog driver config switch
> >>> default to the platform driver switches value.  
> >>
> >> A nit-pick below.
> >>
> >> ...
> >>  
> >>>   config SIEMENS_SIMATIC_IPC_WDT
> >>>   	tristate "Siemens Simatic IPC Watchdog"
> >>>   	depends on SIEMENS_SIMATIC_IPC  
> >>  
> >>> +	default SIEMENS_SIMATIC_IPC  
> >>
> >> It's more natural to group tristate and default, vs. depends and
> >> select.  
> > 
> > Will be ignored unless maintainer insists.
> >   
> 
> Maintainer wants to know why "default SIEMENS_SIMATIC_IPC" is needed
> or warranted instead of the much simpler and easier to understand
> "default y".

I thought a "default y" or "default m" was maybe not the best idea for
a platform that is not super common. That is why i did not dare to even
think about defaulting any of the Simatic stuff to not-no.

But it seems that this would be ok after all. And i would be very happy
to do so because it means less work on distro configs.

SIEMENS_SIMATIC_IPC_WDT will drive a platform device which gets
registered by SIEMENS_SIMATIC_IPC and nothing else. That is why
"default SIEMENS_SIMATIC_IPC" was chosen.

But if i may i would change that to "default m", not "y" because there
is an out of tree driver package which if installed on top, should be
able to override the in-tree drivers.

So i will go ahead and make that one "default m"

regards,
Henning

> Guenter
> 

