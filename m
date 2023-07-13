Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7437520A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjGML7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjGML73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:59:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84B119;
        Thu, 13 Jul 2023 04:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFX4Sd6ZsOPefsXihyJRCMh46axiebjEfmQBPxUlUpIuO9Sr7/zHBlCmHTOVICY5a7hRNgKytmE0ASFfJb/iWp9ZBmTJpp+HfVU4qdlM/0jMDcRzg/SPOsFp8xY3cer/IzFkreDKlhWMsCMcLyJXvzK6CtPIYvXuRgzNRabevTmxdqq/0sEjcikX8oedlsCGlCqTTEgLjtvf16QIxMUtdlmajQvpdVLDCBLf7EZ5wp5L/IfPKckI6zmTZ+XvoMjDvxN9vup9EOFEdEE/29aqyO2mAMxjGVj5GrCa/A1Dlh9H7qUe8QAGlFHe6hqkxxZVfLW8zK3GayaY0LRNYtmzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8uQsab6mlqVoPDDQWmqt0PORJeocVtFPNGaSAhqhPU=;
 b=IyKA+tL6+wo9vemSm5yr/GVZRW35dsUjZic2mP1Yxu9CAEiFnDPiSJl6aLSnkw051GoroVICQXe4pMYhDYHn7jcthna9QaBLANEFmRsoe3jy0YWbWdI/9zDgVM5mAJKf4BUfbzfDlJX6iGJLmkXV5AC2etzcHdxY75+XVhucfbQ8N2ih4x/BrHa1WHB9OESX+kwhj2z3zuf14ngZDOArp+i2zfwr12e4ezZ5d/kXLUC8tdCUFtCBF5AKLYQO5r/Kiw9qFX+kIZDMeQXpHvYD/puavbAYRFozsXrujUyKGMAJMs8rjfIWAc2SUulrnIS0y6bOZX1pqIDG0PO6Sz0QnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8uQsab6mlqVoPDDQWmqt0PORJeocVtFPNGaSAhqhPU=;
 b=fLnIwlaAZYYL9xihKEm23jT7fs+1PIYE0g07HW9YG0r6a7Gz7KG89rw1eh+sEvZDyCBSTrh0WfYnzqt+loAiQv9heKv9+0TbFv/jrBsd2O8z8X1J+wLUuKbAj3MZLj60FxY9D5lC3wx8IJkhw1w68TmolQDYgAsBQd451tWxsqyzNvP2eLIXjfCAc2gWEiXanKU+VZ5wwdbyysuVw4tdgI3FEGPQ8NRX8BiJ2nnHTYu0ojRCv0OsEL/CHOqdD0nqQSK6S28sTpGf3w87TLIzi/JcNNsMTsJCLPZAfsNQ+6vLSR3zP5BJuCXanfOOfiiuHotU6rW6WuT1/+hr8xAqlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS4PR10MB5269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 11:59:22 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 11:59:22 +0000
Date:   Thu, 13 Jul 2023 13:59:10 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: add CMOS battery monitoring for
 simatic IPCs
Message-ID: <20230713135910.64228cd0@md1za8fc.ad001.siemens.net>
In-Reply-To: <3b1dc0a1-94b0-4fba-07e7-b871dfc08e88@redhat.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
        <20230706154831.19100-3-henning.schild@siemens.com>
        <3b1dc0a1-94b0-4fba-07e7-b871dfc08e88@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:610:4d::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS4PR10MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eed229b-b22f-45c8-3315-08db839898be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqMCGkTopc13sdncRW1YWIF3Qj4NUk8LHUFmPEyzl+R5XijxjelW2uVRBtsO2DM++d8bgQJBJp8sfdClerTdslbsiXSIjofDEL1bJOOAwR1odbYMSlbe2OPi6iJep0Uju7lwraT/Kja7wWJd97bMpvfQv7DTMX90VJFuKr5OsMubVlWHD1Yn4Ko24y92TviXBJM2CzR49ADTP6lXh6HzVRMLyb3uvm6Qvb2r/epI2YtvPhrtJatbKBTPK99g0A7tArl1MFMqucadL8gSskqy4soLTgLvPtqehU6VX1Psjxz0raLZi7pT0Cm8iN2/CTuVGL6ZbnY+qZ7/+B1Ec0yMdY6uHksyALdWOdBuLJZ9dhHSe2nNiwgith6sNLxPKCUIB3MJvQSIuINZJ5WXx5WCWgHTKDlQL27D4BkJNCvGGFtmUujO6ElDKRfkLSB8xzYOWeFvavtWXAL0zZPmCaVNt2KM8pF1xYxhcIRelTl8Oe23XQmuxcJmKywwOV3oF/HIc2O+C6rbMyHkPEJq4LIC8ir0alb+puGULNHGZV8kWJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(4326008)(66556008)(66946007)(66476007)(38100700002)(86362001)(186003)(1076003)(6506007)(53546011)(83380400001)(9686003)(82960400001)(966005)(478600001)(110136005)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(30864003)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xaw8mTUlgDPatiFXwwbUnVVeRe7H0RrNQ/PiMP7aqcpybo1WkStYWPJKHIpT?=
 =?us-ascii?Q?rIhAC7Wf6R/1fd08OUTgqpvviM8pwriJ7vCq6zsp+FacDWsOLZsL+wToS8BV?=
 =?us-ascii?Q?GZunXXgd0gCjqu3JhLydtK1+kMLvzULSeU4gcfhB/RnXES7Xo5t+4tczcP+k?=
 =?us-ascii?Q?9uqS3raowZrSw/KejSt8asO4jRt7xSQVhmcj70CP37qfpDaxaB7Z+A17Vuft?=
 =?us-ascii?Q?iGS7MLKn5C2mif1L5EZdjUdWa4NiEkgoLAswAToa5u73sQw2TrlmgLm7FDfn?=
 =?us-ascii?Q?xJErXgBQV/RhiaadYcpyxZFqfiQhPR8hRDfX6gWLNpvSWvp/GQWPIrW4XSxO?=
 =?us-ascii?Q?O4MgsdIxZntooR4Yh3wbGIv9NA8pITU+cfasQXvSFgqooMNrdW2WGSqVaxcs?=
 =?us-ascii?Q?h3zEbxO1gcsO9MHoJdAxXuwyYoyjEbTiWA/EBm7t90clIdA+eQzThhhMb0fv?=
 =?us-ascii?Q?EVoO1ek27c1cIcpVFsA0ltf1y9sEQE3S6s6c1deXUn2HBlwrZqKiI/pyKqDh?=
 =?us-ascii?Q?UaTtl7G62Vr2n7U+gLU/4ATMEbrpsNN/1GxcZlJSv3RoXbPr7cLJP2gGd2wE?=
 =?us-ascii?Q?xEX4WlzGYq5/tskvq6/rFbLy0b+wRNF+fBaPb4AqHXQkrCNx3Iu4dOTWN5aI?=
 =?us-ascii?Q?/hHNM3kNKYk7qUFKtz2PvA+S1Vcu7GtrF7VripiEttNdm+f0INxr7HrBq6Uz?=
 =?us-ascii?Q?iIHfAVflwcfOYaMkxaEuWyuKkxjZArptxK23rq5RexTKvRaYVgXpsy7RFwEM?=
 =?us-ascii?Q?glKh9hgvw0CsaDen2u8f0Y2nAFQ5HkWMclWBTeBGPqZI3T+jOi4jr6+JxJ/u?=
 =?us-ascii?Q?MaXvP2CN2Ls+fsBpmsSZnfC1BM1CyDCHWj1Y5yR1NUU0MNvGtNsX1r7IycgI?=
 =?us-ascii?Q?/Wg+xDZ4KoFMl+Fetz952Qmsn4MbR71WABxRfiHnoZw850Tcpt1UKBwo2I5C?=
 =?us-ascii?Q?MPDoEKUdAAAjP+s10eEoB7i6w8DVscvMS6J1Owb2VqtLlToTbgzVGGUcmbTq?=
 =?us-ascii?Q?oDUSnziTeAP5GJiJxAmiAWCdQz9ymXN+mEDi5QzWvPPDuVKZKXhHcVjZsjub?=
 =?us-ascii?Q?ZeMDvXy65yxbdz3eGhGLV7SoLQXqXq6HYZo7E9RiIQlPp/JG7hSdPdUNVYM1?=
 =?us-ascii?Q?rbLuBPfY6JSFVcE/YOCCo/RH+B5ca3Isdg1ETtfFdT2sHSvDUzUn08LgH/As?=
 =?us-ascii?Q?chkqapSw4/GEjl1Wlv9XZb2MwV9j6fe8QdRze887i89C22FlcclOQfI6mTcv?=
 =?us-ascii?Q?uEaBCc5dzu2wtNX+UbJE+ZWKIUYp293j8JbK1/ANLnjTlJsTti7dFRD2uY8b?=
 =?us-ascii?Q?bRHm9hZ+us6KVczKxN1eMFWP1JdHBTSbcb/OijepdMSBvc+X2hTE4z0GQrUk?=
 =?us-ascii?Q?mfBkEzeSOZwOLRvi8Fz8Q1xfqfuqExoHEl6//NOZbpc3KTvjDzwmi9wwIU5G?=
 =?us-ascii?Q?FlXGEnmlTEOYuCHR5q88E/p9qVMM53sVi/9kGgV/5OJ4fL1zpTBLGUDBg9ec?=
 =?us-ascii?Q?m7486RjZkQhZngmx1EkinJvkz5WB7kNpS0P7GNNLMKmeWoxx13nFNZTVY2jr?=
 =?us-ascii?Q?qOctenVIspjuW2n6n87p1YCuIpyAU1mctDKd9PSnFBujBur1VQ2VcpztkaWR?=
 =?us-ascii?Q?Bthyjb5d07iZ1v6EONwlK5YG6Bq6dCJO/ai0JZET6OTcPvlAcSJyKZanIjan?=
 =?us-ascii?Q?GU9vmA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed229b-b22f-45c8-3315-08db839898be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:59:22.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3OOoM6TmxLr6gNHgEvmdDmqw9at7zST4eUM7nVYkvHvJtuMp+y48oy8H1QcxeyotA8W4WkyE4ahYYrDXgh+xrK8BXfHMiooP3vQQAooFO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

just sent
[PATCH v2 1/2] platform/x86: simatic-ipc: add another model BX-21A

which you can base this on and Lee takes v2 2/2 on top

Henning

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
> 
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

