Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE44B7579FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGRK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGRK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:58:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E21987;
        Tue, 18 Jul 2023 03:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZivMtwmI0ktRQFJ53suMY+gHhk0vgMGKioLyd7bWdEVNqUCpUkfCLvfowwtGPo15uev2eGI5HVTQr8vLbY6ToReVLOvdAGFcuCdb/H1uab9rzHfQQrHYtWclZibijICFQ3PSvR6ZHUJfnrStSGJf3YGNInxJagNaeLMYtvQQcCwWoWKDWAoJRZ27oEG5Y0iE4VC8hW6HZ4oXp6sHgQ7HgsKsQnHmRyP6UE/DJPUYdXgtqBeF5TvUogJGjm/mnF6dTZXDuoeadc8n9gykyuRslzAwhMvaxvhPwPDfLOWuP59SpzDllPqF4YYXGbG02PxmcO09BxgUQWD4tBKK5Lagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ5a8S6u7sPEoZEc5ndote9Fxr91I5XLCWpEIYhH/8Y=;
 b=ltnj5Vn/5ZLuZqE6Vg8QAEcTNShAvInnFYYUA+1IIishu7R3ew13wDEC74ntEs/njduJXtduxhCQXzlTaWDYmoSp8TnzBbG2DdsTq3DuFXMUgH4vzvOxq62nhlZ7Ctrqty4gHjPVxQvzEzgRDHFwY5vG9qx5kErOC2VnOHiwccAnGPCeWibnh4qGHLQNklU7TEouIgAo7JW86YTwm/yaUXHTXrFVRnv6OKguhU//y1KUgZIdJdN5bb0wq4JGbNtQQg4zDbohX10FWQN+mIfPemY2IMZ19pZaMKfy8hEFOWyihySYS7+wmbh/Huhd1urIYPSX6F5nccnv1bOLy8AReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ5a8S6u7sPEoZEc5ndote9Fxr91I5XLCWpEIYhH/8Y=;
 b=xi2V/6Fn9sprRjC2rE7+ofKf2/mvUvIYm2JGyROvp9dM32JMIcXDQDHpmfML2SOKpLuGWgzpRcNf8+KC9PNWcP0yaYHLP9Ka4q5Yjs5S0qhmoF4j66pPGizpFomxpnqmVe5bn1B4xq0r4wo4Pfq8OHzkoWSOgpELT/fC4F4+COFClVfQbvrcLzRUb6qr0cU16uYznZ/cuGgHzF8i6ZvC8LRXEQl3dRlzwTASBGrFbcChujMbjU8MlFAMFTKDtrZD3kgYGKw3oCrHAjaf/n0Lat7Phwrjo1A+8mteV+5tBkL2LSfB963IW91iYP8vcmAYKlNeaXonECbuxcaGuNUfmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB5411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:58:32 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:58:32 +0000
Date:   Tue, 18 Jul 2023 12:58:27 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the
 subdirectory siemens
Message-ID: <20230718125827.40971d76@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230718105213.1275-4-henning.schild@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-4-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca4cfe-57f4-4a8e-3bbe-08db877ded1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmVcwff+wFenxbF5nZ6h14/AsSiwvvwG2noBInVCkS2Dx1X0Z3oVQBiC/RHiIWNEqta/GUbN0PRfj25C2TBVKfxLubpRVHE9rq0m7a6zQ0LGcqMXrh/Ul3uzMS1kIc6hTM3y73kf0vK4B6TXb6p6E8Ii9GcjYq2pugiqbmKqB/FgT/iHUbIf24XHP3D4L80068svEIEKZaxESiyyWtGJUO6b4XjzeSMkTrzfSMPjKQATWRd9+Okbvie/ZL3u9NRliKYvDV3tFx9yjKMVOQK6YANbqIeO2Ko22RlBer8aZF7/vQ+Gw8KEQ9zo67/E29LezaUWa2luP55urgcIwGsAzJ+BgNW2vBZTRGk3oYE3XVSC705Grn8jx8u9imWPP2pizOYvF6K+UH+R17wvy5PrVdRFNBw3af7CkgQeWLDpK0lCWDMCmO7atFKsCM/6LQ36YlH8urmLcN6xZ4vx0uSvzGyzjCc+2Mb6ELS18/yJObqqI/1Xi22PpQPpi3sNap0i8Du45jLttdJ/pBzxnUeig7aMJ7fFyw1kwLLQ28EvB/aP69Af8Oi70dgFdHNr4b47
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(30864003)(2906002)(44832011)(6512007)(83380400001)(186003)(9686003)(6506007)(1076003)(107886003)(82960400001)(6666004)(6486002)(54906003)(110136005)(316002)(4326008)(66946007)(38100700002)(66476007)(5660300002)(478600001)(8936002)(66556008)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKi3CT1xpjS2RPx09UEbDkdE0R0jN5U5DkLNfcs3YsMGDxL5r1Z3mKcVosy9?=
 =?us-ascii?Q?AkI6qKDzoa+eND0BIOeUl3ZCFiDxud65E3K810dFTfGJgD+MhPS2GcUmAu4V?=
 =?us-ascii?Q?mimWeKR1EYFLH90kStzhJapfh0I3IyqEBDaahLtTQtlPyisSZHYXQFy3W5MX?=
 =?us-ascii?Q?/cLxfzjTE47DdKE0OeOKDLjSOvk9HyfOaIGgeXXGvatURdXKEkos5kUhisG3?=
 =?us-ascii?Q?3NIwZiN5cASu5YmKRpdonsOJUjm0inSTUpv/rC5AjqBIHnkUU1bWQ8RSLoq8?=
 =?us-ascii?Q?BlxKontdlvkzimRWgDgTrz85G4Ir/udOWNscC3IASH7miKGpXVWOEJPhGW9s?=
 =?us-ascii?Q?LkTUgpmm3rj8n+KDx1gCbr1/nqG3rM+vGYYpEF/tETxNAKmDYbXk5twztDFo?=
 =?us-ascii?Q?tLYP08S84TiVJYw8WX99jD/bc6jVd2ZMOiGV3FGPmJknBennFj6iq0gn7rH4?=
 =?us-ascii?Q?pAPSJmIiat5S1iWIL9wpcDugC8QkUgbb02YpEZJr370zuqaxMPqVGm53Iruk?=
 =?us-ascii?Q?Agzl/jgyxKwe1UwKXb/PWMmvjMLGVNv7aRqcAnTTK/7k6k1/gw6Kq41/kuqn?=
 =?us-ascii?Q?oj1I3Esb2JNlFn/YPySA18xSbL+4Rds57sIM2wDOKw1o3tnZ554BZC8wWlay?=
 =?us-ascii?Q?Mn5Hn47UVKfWwRdrFpWw/ujf/TnV1ZHaM6aML2TIwUHy2LzsCrextsxyJa//?=
 =?us-ascii?Q?aKmgXuO9rCbehop0sRfxXy07xu0e+pqpUYzJ0GcZQqdgonOavyXAGI7YpWuP?=
 =?us-ascii?Q?+ODnhGgCd/XQmnKflBbVHQFqTRhe7P78c00vzVHTutQbFkp2xU0nM+mN9YSV?=
 =?us-ascii?Q?ABaNcZBA/xhBoPCMas4sNJc1MZPqLsL6/WksneE6Ekjki2HX1EuaOmY6q4ea?=
 =?us-ascii?Q?v4BygsRLxDGK274ovxLpRlMrLCvb+FykCH2nZ+/5v9HIioxsJ+ADjtMUkA/z?=
 =?us-ascii?Q?jJzd8qaFv6l0YkMqQ9wArsX9daQozG+qz+j3+6noLvKBy0oBsEYuQ/GBaoHG?=
 =?us-ascii?Q?kwk6tFXioN6EIig68ymw9oW8sORb5MSDKj1AiSLSrR+woIXXr0pIXy6sFbiP?=
 =?us-ascii?Q?DMy/I4Sbq6d8H3+v1sAVRksPk3MiuhQUQ942vM9m5aRAvFIVUaDrhzcqLhel?=
 =?us-ascii?Q?JncEGdHqkV5mH0AraQ6xcrmIaeOgJtbv1k72c/DeixksCK+cs/N9wrOdHA6v?=
 =?us-ascii?Q?JG1TJGyosxyQgYXoF3QWY3MNsPDGHALTk/sW+dGLAZvzbhn9CeG/1nlvirkl?=
 =?us-ascii?Q?zsyQEASGx6v5iRJfmXWtj/m1R+y+ZFYrWae6yx/eFwWjFb30CPAhf7GeqMBK?=
 =?us-ascii?Q?zhrJEPfQwHV9z8GfPKEh/NXtM5uCjt3F/E6i9UZc2Ij1dNZoGzKgsjTljVPi?=
 =?us-ascii?Q?7yxl8jlnjwMkQsMKBmyxbGjtoVIt5f1WBNPoOHT41f/ManIV8VK52ozkBipL?=
 =?us-ascii?Q?7lX1TVuLQJMnqpMuBbrpaC8GCXpO2Fm9m5/N2Sr0SbMc2bUHaNa1nmr0UBR5?=
 =?us-ascii?Q?WMJnd9uJ7KUZg0cETYVVI1df0/O6yEwnV8mGOsYGu0N8CAayq33sLplcePNa?=
 =?us-ascii?Q?QhqRJmtd29inRa4IToB9AHvEs7jok4fehfxejDKbMHtYHi2lXQzn4Y/C+s2V?=
 =?us-ascii?Q?7/3YfQb8bdSMLfiwXzl1IjwrYuH0xALpmReI+QsHpM2fYRZrQu+mVae85rGl?=
 =?us-ascii?Q?UWDAaQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca4cfe-57f4-4a8e-3bbe-08db877ded1f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:58:32.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XClr6/UUij5qgSb4X6VQtWX0FKDn93d8a324w+WX7JQOjJ8ywtsNnbNVgYIJD23Z5VS+R5fJj7Ch6LloFeHFjgdhgrCDvP36DOVIVZq/qoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

this is based on your tag "ib-pdx86-simatic-v6.6" as you requested.

Henning

Am Tue, 18 Jul 2023 12:52:13 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Users without a Siemens Simatic IPC will not care about any of these
> drivers. Users who do care can enable the submenu and all drivers
> behind it will be enabled.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/platform/x86/Kconfig                  | 59 +-------------
>  drivers/platform/x86/Makefile                 |  6 +-
>  drivers/platform/x86/siemens/Kconfig          | 77
> +++++++++++++++++++ drivers/platform/x86/siemens/Makefile         |
> 11 +++ .../simatic-ipc-batt-apollolake.c             |  0
>  .../simatic-ipc-batt-elkhartlake.c            |  0
>  .../{ => siemens}/simatic-ipc-batt-f7188x.c   |  0
>  .../x86/{ => siemens}/simatic-ipc-batt.c      |  0
>  .../x86/{ => siemens}/simatic-ipc-batt.h      |  0
>  .../platform/x86/{ => siemens}/simatic-ipc.c  |  0
>  10 files changed, 90 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/platform/x86/siemens/Kconfig
>  create mode 100644 drivers/platform/x86/siemens/Makefile
>  rename drivers/platform/x86/{ =>
> siemens}/simatic-ipc-batt-apollolake.c (100%) rename
> drivers/platform/x86/{ => siemens}/simatic-ipc-batt-elkhartlake.c
> (100%) rename drivers/platform/x86/{ =>
> siemens}/simatic-ipc-batt-f7188x.c (100%) rename
> drivers/platform/x86/{ => siemens}/simatic-ipc-batt.c (100%) rename
> drivers/platform/x86/{ => siemens}/simatic-ipc-batt.h (100%) rename
> drivers/platform/x86/{ => siemens}/simatic-ipc.c (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig
> b/drivers/platform/x86/Kconfig index 487d3d8f4da9..f5fcb1ca1b63 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1074,64 +1074,7 @@ config INTEL_SCU_IPC_UTIL
>  	  low level access for debug work and updating the firmware.
> Say N unless you will be doing this on an Intel MID platform.
>  
> -config SIEMENS_SIMATIC_IPC
> -	tristate "Siemens Simatic IPC Class driver"
> -	help
> -	  This Simatic IPC class driver is the central of several
> drivers. It
> -	  is mainly used for system identification, after which
> drivers in other
> -	  classes will take care of driving specifics of those
> machines.
> -	  i.e. LEDs and watchdog.
> -
> -	  To compile this driver as a module, choose M here: the
> module
> -	  will be called simatic-ipc.
> -
> -config SIEMENS_SIMATIC_IPC_BATT
> -	tristate "CMOS battery driver for Siemens Simatic IPCs"
> -	depends on HWMON
> -	depends on SIEMENS_SIMATIC_IPC
> -	default SIEMENS_SIMATIC_IPC
> -	help
> -	  This option enables support for monitoring the voltage of
> the CMOS
> -	  batteries of several Industrial PCs from Siemens.
> -
> -	  To compile this driver as a module, choose M here: the
> module
> -	  will be called simatic-ipc-batt.
> -
> -config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
> -	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Apollo Lake GPIO"
> -	depends on PINCTRL_BROXTON
> -	depends on SIEMENS_SIMATIC_IPC_BATT
> -	default SIEMENS_SIMATIC_IPC_BATT
> -	help
> -	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> -	  from Siemens based on Apollo Lake GPIO.
> -
> -	  To compile this driver as a module, choose M here: the
> module
> -	  will be called simatic-ipc-batt-apollolake.
> -
> -config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
> -	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Elkhart Lake GPIO"
> -	depends on PINCTRL_ELKHARTLAKE
> -	depends on SIEMENS_SIMATIC_IPC_BATT
> -	default SIEMENS_SIMATIC_IPC_BATT
> -	help
> -	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> -	  from Siemens based on Elkhart Lake GPIO.
> -
> -	  To compile this driver as a module, choose M here: the
> module
> -	  will be called simatic-ipc-batt-elkhartlake.
> -
> -config SIEMENS_SIMATIC_IPC_BATT_F7188X
> -	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Nuvoton GPIO"
> -	depends on GPIO_F7188X
> -	depends on SIEMENS_SIMATIC_IPC_BATT
> -	default SIEMENS_SIMATIC_IPC_BATT
> -	help
> -	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> -	  from Siemens based on Nuvoton GPIO.
> -
> -	  To compile this driver as a module, choose M here: the
> module
> -	  will be called simatic-ipc-batt-elkhartlake.
> +source "drivers/platform/x86/siemens/Kconfig"
>  
>  config WINMATE_FM07_KEYS
>  	tristate "Winmate FM07/FM07P front-panel keys driver"
> diff --git a/drivers/platform/x86/Makefile
> b/drivers/platform/x86/Makefile index 522da0d1584d..f3bf4b90b878
> 100644 --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -131,11 +131,7 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+=
> intel_scu_ipcutil.o obj-$(CONFIG_X86_INTEL_LPSS)		+=
> pmc_atom.o 
>  # Siemens Simatic Industrial PCs
> -obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+=
> simatic-ipc.o -obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)
> 	+= simatic-ipc-batt.o
> -obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+=
> simatic-ipc-batt-apollolake.o
> -obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+=
> simatic-ipc-batt-elkhartlake.o
> -obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+=
> simatic-ipc-batt-f7188x.o
> +obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+=
> siemens/ # Winmate obj-$(CONFIG_WINMATE_FM07_KEYS)		+=
> winmate-fm07-keys.o diff --git a/drivers/platform/x86/siemens/Kconfig
> b/drivers/platform/x86/siemens/Kconfig new file mode 100644 index
> 000000000000..64479f83698c --- /dev/null +++
> b/drivers/platform/x86/siemens/Kconfig @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Siemens X86 Platform Specific Drivers
> +#
> +
> +menuconfig X86_PLATFORM_DRIVERS_SIEMENS
> +	bool "Siemens X86 Platform Specific Device Drivers"
> +	help
> +	  Say Y here to get to see options for device drivers for
> various
> +	  Siemens x86 platforms, mainly Simatic Industrial PCs.
> +	  This option alone does not add any kernel code.
> +
> +	  If you say N, all options in this submenu will be skipped
> and disabled. +
> +if X86_PLATFORM_DRIVERS_SIEMENS
> +
> +config SIEMENS_SIMATIC_IPC
> +	tristate "Siemens Simatic IPC Class driver"
> +	default m
> +	help
> +	  This Simatic IPC class driver is the central of several
> drivers. It
> +	  is mainly used for system identification, after which
> drivers in other
> +	  classes will take care of driving specifics of those
> machines.
> +	  i.e. LEDs and watchdog.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc.
> +
> +config SIEMENS_SIMATIC_IPC_BATT
> +	tristate "CMOS battery driver for Siemens Simatic IPCs"
> +	depends on HWMON
> +	depends on SIEMENS_SIMATIC_IPC
> +	default SIEMENS_SIMATIC_IPC
> +	help
> +	  This option enables support for monitoring the voltage of
> the CMOS
> +	  batteries of several Industrial PCs from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-batt.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Apollo Lake GPIO"
> +	depends on PINCTRL_BROXTON
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> +	  from Siemens based on Apollo Lake GPIO.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-batt-apollolake.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Elkhart Lake GPIO"
> +	depends on PINCTRL_ELKHARTLAKE
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> +	  from Siemens based on Elkhart Lake GPIO.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-batt-elkhartlake.
> +
> +config SIEMENS_SIMATIC_IPC_BATT_F7188X
> +	tristate "CMOS Battery monitoring for Simatic IPCs based on
> Nuvoton GPIO"
> +	depends on GPIO_F7188X
> +	depends on SIEMENS_SIMATIC_IPC_BATT
> +	default SIEMENS_SIMATIC_IPC_BATT
> +	help
> +	  This option enables CMOS battery monitoring for Simatic
> Industrial PCs
> +	  from Siemens based on Nuvoton GPIO.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-batt-elkhartlake.
> +
> +endif # X86_PLATFORM_DRIVERS_SIEMENS
> diff --git a/drivers/platform/x86/siemens/Makefile
> b/drivers/platform/x86/siemens/Makefile new file mode 100644
> index 000000000000..2b384b4cb8ba
> --- /dev/null
> +++ b/drivers/platform/x86/siemens/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/x86/siemens
> +# Siemens x86 Platform-Specific Drivers
> +#
> +
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+=
> simatic-ipc.o +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)
> 	+= simatic-ipc-batt.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+=
> simatic-ipc-batt-apollolake.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+=
> simatic-ipc-batt-elkhartlake.o
> +obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+=
> simatic-ipc-batt-f7188x.o diff --git
> a/drivers/platform/x86/simatic-ipc-batt-apollolake.c
> b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
> similarity index 100% rename from
> drivers/platform/x86/simatic-ipc-batt-apollolake.c rename to
> drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c diff --git
> a/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
> b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
> similarity index 100% rename from
> drivers/platform/x86/simatic-ipc-batt-elkhartlake.c rename to
> drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c diff
> --git a/drivers/platform/x86/simatic-ipc-batt-f7188x.c
> b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c similarity
> index 100% rename from drivers/platform/x86/simatic-ipc-batt-f7188x.c
> rename to drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c diff
> --git a/drivers/platform/x86/simatic-ipc-batt.c
> b/drivers/platform/x86/siemens/simatic-ipc-batt.c similarity index
> 100% rename from drivers/platform/x86/simatic-ipc-batt.c rename to
> drivers/platform/x86/siemens/simatic-ipc-batt.c diff --git
> a/drivers/platform/x86/simatic-ipc-batt.h
> b/drivers/platform/x86/siemens/simatic-ipc-batt.h similarity index
> 100% rename from drivers/platform/x86/simatic-ipc-batt.h rename to
> drivers/platform/x86/siemens/simatic-ipc-batt.h diff --git
> a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/siemens/simatic-ipc.c similarity index 100%
> rename from drivers/platform/x86/simatic-ipc.c rename to
> drivers/platform/x86/siemens/simatic-ipc.c

