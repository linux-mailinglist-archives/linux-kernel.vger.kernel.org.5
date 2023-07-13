Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0E751BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjGMIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjGMIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:35:51 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0693469D;
        Thu, 13 Jul 2023 01:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC/hGs86g3Ffn2VZWCV7uLUXrnLSGmBufOnfWh7HYOFuAl7Sn9Iy+XKMId69Ux2gfzF42NgzO56JZdhox1f2O+DADjM0IOfRAemzOJSdoQT2OHCjnWEqsWBrGJlcZNHJqmc1dIMRnSl1LnW7NcVa7GxiV9QIiF2wYNiHI1h2Ga0ilTrbtXkHIGcDb3gsK0su39B4h7cgrd/pgDiV1rDmc5K34VtVa2EfSJAkDXhrYRWfvyDjR2BwWVJMSPXarMN90QvC6MmEQWRvhCK0vHVYcUMvIJsoqbF3pSnP3/uOt8lZTSedOBOS+Q91KtvwzvEsXlqZh+cC1WOudFcig1i1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xllwFhqS3ICvoO9VNA8+y7N2iUC0YiHjpmCRxDKdq3I=;
 b=YJ+x2MXJHNMi5/i1xRMbzJCiNJkRfXkWEoDgvOylKmaR8rpJG/aNAIRnexojd6ah2teP5OoU/thyTtnSmlEW3dt+0a1JOQr2Wl/k9+dQ+Uikhz5i98Arsec9uZBdo/SZIxiZmBVPplUZLdJZnk7jBhDiV/FgtH+ARnBGLkcVwEPyi+1IDEtyoDf6gO24fj9ts1rj6BNMlp3c1ctnwG5T5Ig6H6wIOey2b4X9WJVu25WGmbf02BOPp33B1FowhzsqVPDmFQCOUS1hkxTGb3YkTdmlqOivgOxCA0yhX1xRMnrgGHeItiMdn8ShM3+vhyHkgSTuZTKjZdTVdESC9A9PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xllwFhqS3ICvoO9VNA8+y7N2iUC0YiHjpmCRxDKdq3I=;
 b=KgUeEsz/3n8YmpWe1mR0saS3RLCIX80dGgXPq0ZTyNF7pObiz98ForzKADNVcZgAkcCEJRdgS3YmucPh4EnH1oKNdOChUAFKy7czrCxBb727kr0vmCQWl+DXv5kPlEFSg3J51VqkV0am12jPTWsHDlaqIZcQq/YtwNtRaNpm0mDyymWd6nU3jaxEYkJDeC0USfKNubqn2VQbgdEVcK8ynDdn07QtdyraqHcKmHD+EpxJDC+spSJ1Y8pq0ZuZdN4c787FpnWBFJ1OT/hi8I80zsKSfxq64THJC7C6TfycN518DD2ljBmYwZSAPwu35FVGVdBIX8fM1iG0DvltNUAoSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 13 Jul
 2023 08:28:46 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:28:46 +0000
Date:   Thu, 13 Jul 2023 10:28:40 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: add CMOS battery monitoring for
 simatic IPCs
Message-ID: <20230713102840.7cb514d5@md1za8fc.ad001.siemens.net>
In-Reply-To: <3b1dc0a1-94b0-4fba-07e7-b871dfc08e88@redhat.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
        <20230706154831.19100-3-henning.schild@siemens.com>
        <3b1dc0a1-94b0-4fba-07e7-b871dfc08e88@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: a498c314-f746-4c86-6213-08db837b2cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtSRWSq0iEJBSMLdgTz7VBi1WWsA6wuvpcqCle7lmKnvdVysK7TwOWoIzFSPsicqTDA8A/FJo/1wSywUzZ/uWZEiBPwwd6o5lqcJMgRWdBUEzO7YFVBKpUxYR17bIBDxML+Z3fPyqFLC3NR7xF4+dpxfFFZ3Y5iAOlrWRgEeXdsJJ77yvRpdBrJezkXB5sdkGtlTamGd9WBswlyUKp3d3C5Q6GRcrW9iGFFhO1jAfkbh6vxu4QeypdnvN//SzMe1jE1A0NgL3uVfdCCr9AR0Yx1yqYwawdVqVeFFFHI1hm+auTgVlyhsBVPbK7jU2u2RQQmTddjE/x0qaf84t7Q7xWGKAnkNd3X5TAV8VXfjlLXhD2jAqBAwMX4OYCrHbJNLU3kFD3c/bbz8B0/MAOUtJfEno6ShhzIe1ggYg3h1aQnv2KMmuRD1lie40YO/DXlRJkw/4xhxLpkAmPFoHUcVPKM0W93hZYYqjX7OYcBWY7ByCytBoNWpeAwwipuopZJxTsa9+snYeu8F599m/TlcEGJSdRXeBT7w7wZnjZXJprA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(478600001)(6666004)(6486002)(54906003)(6506007)(186003)(53546011)(1076003)(9686003)(6512007)(966005)(30864003)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQhg70tluxZSFyobeXaVpvP/McA2wdV4cFGA5LGGwyYLJpUkjRVyVO9A3Ip5?=
 =?us-ascii?Q?5U6vE6HuXAmBSNjvBNggfY+MlHuafmHI7ScftUGvNBistTWhbUIsFHoh2ftH?=
 =?us-ascii?Q?twdbtOYJdvaxpAgYc/rmVh/Ci2Eu1UxsW8GdssshOIze1L86+ZCOo9fzHxIL?=
 =?us-ascii?Q?Mzeamoa38cxc0cDq2SyEX/OD1Wy2xOFM9qPi2EbIJE+UW/RjlHmy9c7abH+x?=
 =?us-ascii?Q?klhZ1WEY4ZIOD+8qPu2XLJNKcOOyF46JoXMfM2O6YW7YR4tEwZ2FuJdRzkN4?=
 =?us-ascii?Q?6dKRpaprVDRsmAn7IpUwkpbF2hhdFax4uBQHZ/JJ8e5RF4lGdtIpMzSpZZUm?=
 =?us-ascii?Q?6d38eqdIrqkJLHFUH7WvHFHT3tXiEhJjDVEgUTZDomPB4d69ep92MPonkA3W?=
 =?us-ascii?Q?9qrYOhkJeyI3PKtu+yxl41lgXL2+K9Sv3dCOJslqqkY2J0/coezOoCFZAWTO?=
 =?us-ascii?Q?PctQE9pC229XAGXE0rncF9eWRy37SSTa+SYAIHV8T9LqK0Sa8uVFrOSXCuEs?=
 =?us-ascii?Q?GUcm6gagjBtctJd6g5r4a2Whjj4eWT73b3AljWHS6VqsUWU/pB5AHjZTAylH?=
 =?us-ascii?Q?0BKHrmb5IQIxPCr9rHhpGtK1J36Sxrbb2T6oCkqz/ikiZOatbaFGK42Kvm5r?=
 =?us-ascii?Q?hj8+LXFBD6Iil8fSug2n30N7x5J0O8kk6s3aZU5Wy4B84lqjeJ47sq5OZ1u+?=
 =?us-ascii?Q?/fPJfzB6oPyGPhslfk6pwCfkJM307OtVdSPka6oqd0umZA6ke7axTUkkDFJH?=
 =?us-ascii?Q?Kt3rKl80kjVbbixSY7G/ilbJMdHLMNS7M8E7fY14A3DeXpn+GfwIxTSjzHEz?=
 =?us-ascii?Q?qznkJKbGvs5z7bPKampfXhEf+YNB0OPwgQy9Clgl4Her63czzR1yBz89r0vn?=
 =?us-ascii?Q?O+wggIIpqaK74kt1b2sTqUycOchfMJtl9Blewx0oH/s6lbx27rfkRArnvQmH?=
 =?us-ascii?Q?vKToWWfYe0THzXZOVimfNZsbyDQnPZ8AAPW7Wg+zz5LzX1cMbo23EkRJzQFM?=
 =?us-ascii?Q?jOg0gLYgT4alayxCFFXJDhPIxCp3ILdK4UQSunl5APavxqXn+im0nAz/bcuE?=
 =?us-ascii?Q?z5Xvfh4pK8f/Rrxsc16nAoLbKzWUTKwTCXmU+ri5XHr3r6ewZEtY6WRGBSP7?=
 =?us-ascii?Q?GAY2CXG99DoSNaaOyhkykWGccSX64hVoQqFoIep+ciTevS/Ffbw9uPxsVOOC?=
 =?us-ascii?Q?GI6eewZvSzJpQi1dFc+8PARVugoViz4FN36tBe5gi3l/9oTgKDjwRTkjKpDk?=
 =?us-ascii?Q?e+Y+WF9BxZCxbng+xMLNjKWjBfwqy/YQHzA5sb/4/Oq2heowng6EGzvfxmR8?=
 =?us-ascii?Q?bIiliHN8OkZ5+i5QujyEeR6gnXpepMf8oRN9pp8DTnr/2pmMbod9TqgIEiSD?=
 =?us-ascii?Q?4bQB62HQU/rSZyAGUu4QTAwNlbR1iFYId4fl9E57ywISGy41NP3KioS4sFNQ?=
 =?us-ascii?Q?r4j4FBks8i2dDesif15AFBjnzytY0qmgZZU4znegVeeva7E0BfsezRkzpqwp?=
 =?us-ascii?Q?zEThphXZya5bX8Jh5xAEaGBpvtL9HMhhIotAku3J311YvQXvYcyE2+ANjq2q?=
 =?us-ascii?Q?TMPNpq8pOPCI5YtGtwZ59h75Pk4N/11pzv3IVbf7i5vdlHPZKsXBsjce2A2A?=
 =?us-ascii?Q?geC9S/3GkvmSyx1QazJ0Z4CJUs5nw33liAZf6XAzgNVlo7cnyr8Hu7Q8a+3v?=
 =?us-ascii?Q?AQKrHA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498c314-f746-4c86-6213-08db837b2cc8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:28:46.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pe04cwdgiu/oJC7JB3467106BW3oKAJKHfHNq9Don7CHbYdrkE6WwmF3xRteI7y5yJLY3z/jT1ZYYiNEUpDd/NSQFkWGXE7Hfvjt7BdhCzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 12 Jul 2023 20:05:54 +0200
schrieb Hans de Goede <hdegoede@redhat.com>:

> <resend with Lee's new email address>
> 
> Hi,
> 
> On 7/6/23 17:48, Henning Schild wrote:
> > Siemens Simatic Industrial PCs can monitor the voltage of the CMOS
> > battery with two bits that indicate low or empty state. This can be
> > GPIO or PortIO based.
> > Here we model that as a hwmon voltage. The core driver does the
> > PortIO and provides boilerplate for the GPIO versions. Which are
> > split out to model runtime dependencies while allowing fine-grained
> > kernel configuration.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> 
> So I tried to merge this, but it does not apply because:
> 
> "[PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A"
> https://lore.kernel.org/platform-driver-x86/20230531155457.31632-2-henning.schild@siemens.com/
> 
> has not been merged yet.
> 
> I think it would be best to split the:
> 
> drivers/platform/x86/simatic-ipc.c
> include/linux/platform_data/x86/simatic-ipc-base.h
> include/linux/platform_data/x86/simatic-ipc.h
> 
> bits of
> https://lore.kernel.org/platform-driver-x86/20230531155457.31632-2-henning.schild@siemens.com/
> 
> out into its own prep patch named e.g. :
> "platform/x86: simatic-ipc: add BX-21A model"
> 
> And then post a new v2 series for
> "leds: simatic-ipc-leds-gpio: add new model BX-21A"
> consisting of the prep patch + the actual new LED driver.
> 
> Then I can do an immutable branch based on 6.5-rc1 with
> the prep patch in there and send a pull-req to Lee Jones
> for that, so that he can apply the LED driver patch on
> top of the immutable branch.
> 
> This way we can continue with merging all the pending
> simatic IPC work without being dependent on Lee having
> time to review the LED driver.

Sounds like a plan, i will send another version of "leds:
simatic-ipc-leds-gpio: add new model BX-21A" with the pdx86 stuff as
separate patch.

But just to note one thing, we would be registering a platform device
before there is a driver for it. ("simatic_ipc_leds_gpio_elkhartlake")
I think that is fine, but would want to be sure that Lee will actually
merge that driver also for 6.5 so the gap between device and driver
does not become too big.

regards,
Henning

> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> > ---
> >  drivers/platform/x86/Kconfig                  |  48 ++++
> >  drivers/platform/x86/Makefile                 |   6 +-
> >  .../x86/simatic-ipc-batt-apollolake.c         |  51 ++++
> >  .../x86/simatic-ipc-batt-elkhartlake.c        |  51 ++++
> >  .../platform/x86/simatic-ipc-batt-f7188x.c    |  70 +++++
> >  drivers/platform/x86/simatic-ipc-batt.c       | 250
> > ++++++++++++++++++ drivers/platform/x86/simatic-ipc-batt.h       |
> > 20 ++ drivers/platform/x86/simatic-ipc.c            |  65 ++++-
> >  .../platform_data/x86/simatic-ipc-base.h      |   1 +
> >  9 files changed, 547 insertions(+), 15 deletions(-)
> >  create mode 100644
> > drivers/platform/x86/simatic-ipc-batt-apollolake.c create mode
> > 100644 drivers/platform/x86/simatic-ipc-batt-elkhartlake.c create
> > mode 100644 drivers/platform/x86/simatic-ipc-batt-f7188x.c create
> > mode 100644 drivers/platform/x86/simatic-ipc-batt.c create mode
> > 100644 drivers/platform/x86/simatic-ipc-batt.h
> > 
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig index 49c2c4cd8d00..ad15063e1178
> > 100644 --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1086,6 +1086,54 @@ config SIEMENS_SIMATIC_IPC
> >  	  To compile this driver as a module, choose M here: the
> > module will be called simatic-ipc.
> >  
> > +config SIEMENS_SIMATIC_IPC_BATT
> > +	tristate "CMOS battery driver for Siemens Simatic IPCs"
> > +	depends on HWMON
> > +	depends on SIEMENS_SIMATIC_IPC
> > +	default SIEMENS_SIMATIC_IPC
> > +	help
> > +	  This option enables support for monitoring the voltage
> > of the CMOS
> > +	  batteries of several Industrial PCs from Siemens.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-batt.
> > +
> > +config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
> > +	tristate "CMOS Battery monitoring for Simatic IPCs based
> > on Apollo Lake GPIO"
> > +	depends on PINCTRL_BROXTON
> > +	depends on SIEMENS_SIMATIC_IPC_BATT
> > +	default SIEMENS_SIMATIC_IPC_BATT
> > +	help
> > +	  This option enables CMOS battery monitoring for Simatic
> > Industrial PCs
> > +	  from Siemens based on Apollo Lake GPIO.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-batt-apollolake.
> > +
> > +config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
> > +	tristate "CMOS Battery monitoring for Simatic IPCs based
> > on Elkhart Lake GPIO"
> > +	depends on PINCTRL_ELKHARTLAKE
> > +	depends on SIEMENS_SIMATIC_IPC_BATT
> > +	default SIEMENS_SIMATIC_IPC_BATT
> > +	help
> > +	  This option enables CMOS battery monitoring for Simatic
> > Industrial PCs
> > +	  from Siemens based on Elkhart Lake GPIO.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-batt-elkhartlake.
> > +
> > +config SIEMENS_SIMATIC_IPC_BATT_F7188X
> > +	tristate "CMOS Battery monitoring for Simatic IPCs based
> > on Nuvoton GPIO"
> > +	depends on GPIO_F7188X
> > +	depends on SIEMENS_SIMATIC_IPC_BATT
> > +	default SIEMENS_SIMATIC_IPC_BATT
> > +	help
> > +	  This option enables CMOS battery monitoring for Simatic
> > Industrial PCs
> > +	  from Siemens based on Nuvoton GPIO.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-batt-elkhartlake.
> > +
> >  config WINMATE_FM07_KEYS
> >  	tristate "Winmate FM07/FM07P front-panel keys driver"
> >  	depends on INPUT
> > diff --git a/drivers/platform/x86/Makefile
> > b/drivers/platform/x86/Makefile index 52dfdf574ac2..522da0d1584d
> > 100644 --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -131,7 +131,11 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+=
> > intel_scu_ipcutil.o obj-$(CONFIG_X86_INTEL_LPSS)		+=
> > pmc_atom.o 
> >  # Siemens Simatic Industrial PCs
> > -obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
> > +obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+=
> > simatic-ipc.o +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)
> > 		+= simatic-ipc-batt.o
> > +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+=
> > simatic-ipc-batt-apollolake.o
> > +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+=
> > simatic-ipc-batt-elkhartlake.o
> > +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+=
> > simatic-ipc-batt-f7188x.o # Winmate
> > obj-$(CONFIG_WINMATE_FM07_KEYS)		+=
> > winmate-fm07-keys.o diff --git
> > a/drivers/platform/x86/simatic-ipc-batt-apollolake.c
> > b/drivers/platform/x86/simatic-ipc-batt-apollolake.c new file mode
> > 100644 index 000000000000..0503cb89d8f8 --- /dev/null +++
> > b/drivers/platform/x86/simatic-ipc-batt-apollolake.c @@ -0,0 +1,51
> > @@ +// SPDX-License-Identifier: GPL-2.0 +/*
> > + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Authors:
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "simatic-ipc-batt.h"
> > +
> > +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_127e = {
> > +	.table = {
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 55, NULL,
> > 0, GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 61, NULL,
> > 1, GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.1", 41, NULL,
> > 2, GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> > +	},
> > +};
> > +
> > +static int simatic_ipc_batt_apollolake_remove(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_batt_remove(pdev,
> > &simatic_ipc_batt_gpio_table_127e); +}
> > +
> > +static int simatic_ipc_batt_apollolake_probe(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_batt_probe(pdev,
> > &simatic_ipc_batt_gpio_table_127e); +}
> > +
> > +static struct platform_driver simatic_ipc_batt_driver = {
> > +	.probe = simatic_ipc_batt_apollolake_probe,
> > +	.remove = simatic_ipc_batt_apollolake_remove,
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +	},
> > +};
> > +
> > +module_platform_driver(simatic_ipc_batt_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> > +MODULE_SOFTDEP("pre: simatic-ipc-batt
> > platform:apollolake-pinctrl"); +MODULE_AUTHOR("Henning Schild
> > <henning.schild@siemens.com>"); diff --git
> > a/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
> > b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c new file mode
> > 100644 index 000000000000..ecf5ceb167f9 --- /dev/null
> > +++ b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Authors:
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "simatic-ipc-batt.h"
> > +
> > +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_21a = {
> > +	.table = {
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 18, NULL, 0,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 19, NULL, 1,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:01", 66, NULL, 2,
> > GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> > +	},
> > +};
> > +
> > +static int simatic_ipc_batt_elkhartlake_remove(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_batt_remove(pdev,
> > &simatic_ipc_batt_gpio_table_bx_21a); +}
> > +
> > +static int simatic_ipc_batt_elkhartlake_probe(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_batt_probe(pdev,
> > &simatic_ipc_batt_gpio_table_bx_21a); +}
> > +
> > +static struct platform_driver simatic_ipc_batt_driver = {
> > +	.probe = simatic_ipc_batt_elkhartlake_probe,
> > +	.remove = simatic_ipc_batt_elkhartlake_remove,
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +	},
> > +};
> > +
> > +module_platform_driver(simatic_ipc_batt_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> > +MODULE_SOFTDEP("pre: simatic-ipc-batt
> > platform:elkhartlake-pinctrl"); +MODULE_AUTHOR("Henning Schild
> > <henning.schild@siemens.com>"); diff --git
> > a/drivers/platform/x86/simatic-ipc-batt-f7188x.c
> > b/drivers/platform/x86/simatic-ipc-batt-f7188x.c new file mode
> > 100644 index 000000000000..a0189b9289f6 --- /dev/null
> > +++ b/drivers/platform/x86/simatic-ipc-batt-f7188x.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Authors:
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/x86/simatic-ipc-base.h>
> > +
> > +#include "simatic-ipc-batt.h"
> > +
> > +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_227g = {
> > +	.table = {
> > +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 6, NULL, 0,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 5, NULL, 1,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:01",  66, NULL, 2,
> > GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> > +	},
> > +};
> > +
> > +struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_39a = {
> > +	.table = {
> > +		GPIO_LOOKUP_IDX("gpio-f7188x-6", 4, NULL, 0,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("gpio-f7188x-6", 3, NULL, 1,
> > GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> > +	},
> > +};
> > +
> > +static int simatic_ipc_batt_f7188x_remove(struct platform_device
> > *pdev) +{
> > +	const struct simatic_ipc_platform *plat =
> > pdev->dev.platform_data; +
> > +	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
> > +		return simatic_ipc_batt_remove(pdev,
> > &simatic_ipc_batt_gpio_table_227g); +
> > +	return simatic_ipc_batt_remove(pdev,
> > &simatic_ipc_batt_gpio_table_bx_39a); +}
> > +
> > +static int simatic_ipc_batt_f7188x_probe(struct platform_device
> > *pdev) +{
> > +	const struct simatic_ipc_platform *plat =
> > pdev->dev.platform_data; +
> > +	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
> > +		return simatic_ipc_batt_probe(pdev,
> > &simatic_ipc_batt_gpio_table_227g); +
> > +	return simatic_ipc_batt_probe(pdev,
> > &simatic_ipc_batt_gpio_table_bx_39a); +}
> > +
> > +static struct platform_driver simatic_ipc_batt_driver = {
> > +	.probe = simatic_ipc_batt_f7188x_probe,
> > +	.remove = simatic_ipc_batt_f7188x_remove,
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +	},
> > +};
> > +
> > +module_platform_driver(simatic_ipc_batt_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> > +MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x
> > platform:elkhartlake-pinctrl"); +MODULE_AUTHOR("Henning Schild
> > <henning.schild@siemens.com>"); diff --git
> > a/drivers/platform/x86/simatic-ipc-batt.c
> > b/drivers/platform/x86/simatic-ipc-batt.c new file mode 100644
> > index 000000000000..a83272475b9d --- /dev/null
> > +++ b/drivers/platform/x86/simatic-ipc-batt.c
> > @@ -0,0 +1,250 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Authors:
> > + *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/x86/simatic-ipc-base.h>
> > +#include <linux/sizes.h>
> > +
> > +#define BATT_DELAY_MS	(1000 * 60 * 60 * 24)	/* 24 h
> > delay */ +
> > +#define SIMATIC_IPC_BATT_LEVEL_FULL	3000
> > +#define SIMATIC_IPC_BATT_LEVEL_CRIT	2750
> > +#define SIMATIC_IPC_BATT_LEVEL_EMPTY	   0
> > +
> > +static struct simatic_ipc_batt {
> > +	u8 devmode;
> > +	long current_state;
> > +	struct gpio_desc *gpios[3];
> > +	unsigned long last_updated_jiffies;
> > +} priv;
> > +
> > +static long simatic_ipc_batt_read_gpio(void)
> > +{
> > +	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
> > +
> > +	if (priv.gpios[2]) {
> > +		gpiod_set_value(priv.gpios[2], 1);
> > +		msleep(150);
> > +	}
> > +
> > +	if (gpiod_get_value_cansleep(priv.gpios[0]))
> > +		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
> > +	else if (gpiod_get_value_cansleep(priv.gpios[1]))
> > +		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
> > +
> > +	if (priv.gpios[2])
> > +		gpiod_set_value(priv.gpios[2], 0);
> > +
> > +	return r;
> > +}
> > +
> > +#define SIMATIC_IPC_BATT_PORT_BASE	0x404D
> > +static struct resource simatic_ipc_batt_io_res =
> > +	DEFINE_RES_IO_NAMED(SIMATIC_IPC_BATT_PORT_BASE, SZ_1,
> > KBUILD_MODNAME); +
> > +static long simatic_ipc_batt_read_io(struct device *dev)
> > +{
> > +	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
> > +	struct resource *res = &simatic_ipc_batt_io_res;
> > +	u8 val;
> > +
> > +	if (!request_muxed_region(res->start, resource_size(res),
> > res->name)) {
> > +		dev_err(dev, "Unable to register IO resource at
> > %pR\n", res);
> > +		return -EBUSY;
> > +	}
> > +
> > +	val = inb(SIMATIC_IPC_BATT_PORT_BASE);
> > +	release_region(simatic_ipc_batt_io_res.start,
> > resource_size(&simatic_ipc_batt_io_res)); +
> > +	if (val & (1 << 7))
> > +		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
> > +	else if (val & (1 << 6))
> > +		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
> > +
> > +	return r;
> > +}
> > +
> > +static long simatic_ipc_batt_read_value(struct device *dev)
> > +{
> > +	unsigned long next_update;
> > +
> > +	next_update = priv.last_updated_jiffies +
> > msecs_to_jiffies(BATT_DELAY_MS);
> > +	if (time_after(jiffies, next_update) ||
> > !priv.last_updated_jiffies) {
> > +		switch (priv.devmode) {
> > +		case SIMATIC_IPC_DEVICE_127E:
> > +		case SIMATIC_IPC_DEVICE_227G:
> > +		case SIMATIC_IPC_DEVICE_BX_39A:
> > +			priv.current_state =
> > simatic_ipc_batt_read_gpio();
> > +			break;
> > +		case SIMATIC_IPC_DEVICE_227E:
> > +			priv.current_state =
> > simatic_ipc_batt_read_io(dev);
> > +			break;
> > +		}
> > +		priv.last_updated_jiffies = jiffies;
> > +		if (priv.current_state <
> > SIMATIC_IPC_BATT_LEVEL_FULL)
> > +			dev_warn(dev, "CMOS battery needs to be
> > replaced.");
> > +	}
> > +
> > +	return priv.current_state;
> > +}
> > +
> > +static int simatic_ipc_batt_read(struct device *dev, enum
> > hwmon_sensor_types type,
> > +				 u32 attr, int channel, long *val)
> > +{
> > +	switch (attr) {
> > +	case hwmon_in_input:
> > +		*val = simatic_ipc_batt_read_value(dev);
> > +		break;
> > +	case hwmon_in_lcrit:
> > +		*val = SIMATIC_IPC_BATT_LEVEL_CRIT;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static umode_t simatic_ipc_batt_is_visible(const void *data, enum
> > hwmon_sensor_types type,
> > +					   u32 attr, int channel)
> > +{
> > +	if (attr == hwmon_in_input || attr == hwmon_in_lcrit)
> > +		return 0444;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops simatic_ipc_batt_ops = {
> > +	.is_visible = simatic_ipc_batt_is_visible,
> > +	.read = simatic_ipc_batt_read,
> > +};
> > +
> > +static const struct hwmon_channel_info *simatic_ipc_batt_info[] = {
> > +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LCRIT),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info simatic_ipc_batt_chip_info = {
> > +	.ops = &simatic_ipc_batt_ops,
> > +	.info = simatic_ipc_batt_info,
> > +};
> > +
> > +int simatic_ipc_batt_remove(struct platform_device *pdev, struct
> > gpiod_lookup_table *table) +{
> > +	gpiod_remove_lookup_table(table);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(simatic_ipc_batt_remove);
> > +
> > +int simatic_ipc_batt_probe(struct platform_device *pdev, struct
> > gpiod_lookup_table *table) +{
> > +	struct simatic_ipc_platform *plat;
> > +	struct device *dev = &pdev->dev;
> > +	struct device *hwmon_dev;
> > +	int err;
> > +
> > +	plat = pdev->dev.platform_data;
> > +	priv.devmode = plat->devmode;
> > +
> > +	switch (priv.devmode) {
> > +	case SIMATIC_IPC_DEVICE_127E:
> > +	case SIMATIC_IPC_DEVICE_227G:
> > +	case SIMATIC_IPC_DEVICE_BX_39A:
> > +	case SIMATIC_IPC_DEVICE_BX_21A:
> > +		table->dev_id = dev_name(dev);
> > +		gpiod_add_lookup_table(table);
> > +		break;
> > +	case SIMATIC_IPC_DEVICE_227E:
> > +		goto nogpio;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +
> > +	priv.gpios[0] = devm_gpiod_get_index(dev, "CMOSBattery
> > empty", 0, GPIOD_IN);
> > +	if (IS_ERR(priv.gpios[0])) {
> > +		err = PTR_ERR(priv.gpios[0]);
> > +		priv.gpios[0] = NULL;
> > +		goto out;
> > +	}
> > +	priv.gpios[1] = devm_gpiod_get_index(dev, "CMOSBattery
> > low", 1, GPIOD_IN);
> > +	if (IS_ERR(priv.gpios[1])) {
> > +		err = PTR_ERR(priv.gpios[1]);
> > +		priv.gpios[1] = NULL;
> > +		goto out;
> > +	}
> > +
> > +	if (table->table[2].key) {
> > +		priv.gpios[2] = devm_gpiod_get_index(dev,
> > "CMOSBattery meter", 2, GPIOD_OUT_HIGH);
> > +		if (IS_ERR(priv.gpios[2])) {
> > +			err = PTR_ERR(priv.gpios[1]);
> > +			priv.gpios[2] = NULL;
> > +			goto out;
> > +		}
> > +	} else {
> > +		priv.gpios[2] = NULL;
> > +	}
> > +
> > +nogpio:
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> > KBUILD_MODNAME,
> > +							 &priv,
> > +
> > &simatic_ipc_batt_chip_info,
> > +							 NULL);
> > +	if (IS_ERR(hwmon_dev)) {
> > +		err = PTR_ERR(hwmon_dev);
> > +		goto out;
> > +	}
> > +
> > +	/* warn about aging battery even if userspace never reads
> > hwmon */
> > +	simatic_ipc_batt_read_value(dev);
> > +
> > +	return 0;
> > +out:
> > +	simatic_ipc_batt_remove(pdev, table);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(simatic_ipc_batt_probe);
> > +
> > +static int simatic_ipc_batt_io_remove(struct platform_device *pdev)
> > +{
> > +	return simatic_ipc_batt_remove(pdev, NULL);
> > +}
> > +
> > +static int simatic_ipc_batt_io_probe(struct platform_device *pdev)
> > +{
> > +	return simatic_ipc_batt_probe(pdev, NULL);
> > +}
> > +
> > +static struct platform_driver simatic_ipc_batt_driver = {
> > +	.probe = simatic_ipc_batt_io_probe,
> > +	.remove = simatic_ipc_batt_io_remove,
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +	},
> > +};
> > +
> > +module_platform_driver(simatic_ipc_batt_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> > +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> > diff --git a/drivers/platform/x86/simatic-ipc-batt.h
> > b/drivers/platform/x86/simatic-ipc-batt.h new file mode 100644
> > index 000000000000..4545cd3e3026
> > --- /dev/null
> > +++ b/drivers/platform/x86/simatic-ipc-batt.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Siemens SIMATIC IPC driver for CMOS battery monitoring
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Author:
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#ifndef _SIMATIC_IPC_BATT_H
> > +#define _SIMATIC_IPC_BATT_H
> > +
> > +int simatic_ipc_batt_probe(struct platform_device *pdev,
> > +			   struct gpiod_lookup_table *table);
> > +
> > +int simatic_ipc_batt_remove(struct platform_device *pdev,
> > +			    struct gpiod_lookup_table *table);
> > +
> > +#endif /* _SIMATIC_IPC_BATT_H */
> > diff --git a/drivers/platform/x86/simatic-ipc.c
> > b/drivers/platform/x86/simatic-ipc.c index
> > 4402cd354104..6d2c94c17414 100644 ---
> > a/drivers/platform/x86/simatic-ipc.c +++
> > b/drivers/platform/x86/simatic-ipc.c @@ -21,6 +21,7 @@
> >  
> >  static struct platform_device *ipc_led_platform_device;
> >  static struct platform_device *ipc_wdt_platform_device;
> > +static struct platform_device *ipc_batt_platform_device;
> >  
> >  static const struct dmi_system_id simatic_ipc_whitelist[] = {
> >  	{
> > @@ -37,38 +38,71 @@ static struct {
> >  	u32 station_id;
> >  	u8 led_mode;
> >  	u8 wdt_mode;
> > +	u8 batt_mode;
> >  } device_modes[] = {
> > -	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E,
> > SIMATIC_IPC_DEVICE_NONE},
> > -	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D,
> > SIMATIC_IPC_DEVICE_NONE},
> > -	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E,
> > SIMATIC_IPC_DEVICE_227E},
> > -	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G,
> > SIMATIC_IPC_DEVICE_227G},
> > -	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_227E},
> > -	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E,
> > SIMATIC_IPC_DEVICE_NONE},
> > -	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E,
> > SIMATIC_IPC_DEVICE_427E},
> > -	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_427E},
> > -	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G,
> > SIMATIC_IPC_DEVICE_227G},
> > -	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_227G},
> > -	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A,
> > SIMATIC_IPC_DEVICE_NONE},
> > +	{SIMATIC_IPC_IPC127E,
> > +		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_127E},
> > +	{SIMATIC_IPC_IPC227D,
> > +		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_NONE},
> > +	{SIMATIC_IPC_IPC227E,
> > +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E,
> > SIMATIC_IPC_DEVICE_227E},
> > +	{SIMATIC_IPC_IPC227G,
> > +		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
> > SIMATIC_IPC_DEVICE_227G},
> > +	{SIMATIC_IPC_IPC277E,
> > +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E,
> > SIMATIC_IPC_DEVICE_227E},
> > +	{SIMATIC_IPC_IPC427D,
> > +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_NONE},
> > +	{SIMATIC_IPC_IPC427E,
> > +		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E,
> > SIMATIC_IPC_DEVICE_NONE},
> > +	{SIMATIC_IPC_IPC477E,
> > +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E,
> > SIMATIC_IPC_DEVICE_NONE},
> > +	{SIMATIC_IPC_IPCBX_39A,
> > +		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
> > SIMATIC_IPC_DEVICE_BX_39A},
> > +	{SIMATIC_IPC_IPCPX_39A,
> > +		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G,
> > SIMATIC_IPC_DEVICE_BX_39A},
> > +	{SIMATIC_IPC_IPCBX_21A,
> > +		SIMATIC_IPC_DEVICE_BX_21A,
> > SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A}, };
> >  
> >  static int register_platform_devices(u32 station_id)
> >  {
> >  	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
> >  	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
> > -	char *pdevname = KBUILD_MODNAME "_leds";
> > +	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
> > +	char *pdevname;
> >  	int i;
> >  
> > -	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
> > -
> >  	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
> >  		if (device_modes[i].station_id == station_id) {
> >  			ledmode = device_modes[i].led_mode;
> >  			wdtmode = device_modes[i].wdt_mode;
> > +			battmode = device_modes[i].batt_mode;
> >  			break;
> >  		}
> >  	}
> >  
> > +	if (battmode != SIMATIC_IPC_DEVICE_NONE) {
> > +		pdevname = KBUILD_MODNAME "_batt";
> > +		if (battmode == SIMATIC_IPC_DEVICE_127E)
> > +			pdevname = KBUILD_MODNAME
> > "_batt_apollolake";
> > +		if (battmode == SIMATIC_IPC_DEVICE_BX_21A)
> > +			pdevname = KBUILD_MODNAME
> > "_batt_elkhartlake";
> > +		if (battmode == SIMATIC_IPC_DEVICE_227G ||
> > battmode == SIMATIC_IPC_DEVICE_BX_39A)
> > +			pdevname = KBUILD_MODNAME "_batt_f7188x";
> > +		platform_data.devmode = battmode;
> > +		ipc_batt_platform_device =
> > +			platform_device_register_data(NULL,
> > pdevname,
> > +				PLATFORM_DEVID_NONE,
> > &platform_data,
> > +				sizeof(struct
> > simatic_ipc_platform));
> > +		if (IS_ERR(ipc_batt_platform_device))
> > +			return PTR_ERR(ipc_batt_platform_device);
> > +
> > +		pr_debug("device=%s created\n",
> > +			 ipc_batt_platform_device->name);
> > +	}
> > +
> >  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> > +		pdevname = KBUILD_MODNAME "_leds";
> >  		if (ledmode == SIMATIC_IPC_DEVICE_127E)
> >  			pdevname = KBUILD_MODNAME
> > "_leds_gpio_apollolake"; if (ledmode == SIMATIC_IPC_DEVICE_227G)
> > @@ -144,6 +178,9 @@ static void __exit simatic_ipc_exit_module(void)
> >  
> >  	platform_device_unregister(ipc_wdt_platform_device);
> >  	ipc_wdt_platform_device = NULL;
> > +
> > +	platform_device_unregister(ipc_batt_platform_device);
> > +	ipc_batt_platform_device = NULL;
> >  }
> >  
> >  module_init(simatic_ipc_init_module);
> > diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h
> > b/include/linux/platform_data/x86/simatic-ipc-base.h index
> > 00bf18ecb160..1ba47dd6939e 100644 ---
> > a/include/linux/platform_data/x86/simatic-ipc-base.h +++
> > b/include/linux/platform_data/x86/simatic-ipc-base.h @@ -21,6 +21,7
> > @@ #define SIMATIC_IPC_DEVICE_227E 4
> >  #define SIMATIC_IPC_DEVICE_227G 5
> >  #define SIMATIC_IPC_DEVICE_BX_21A 6
> > +#define SIMATIC_IPC_DEVICE_BX_39A 7
> >  
> >  struct simatic_ipc_platform {
> >  	u8	devmode;  
> 
> 

