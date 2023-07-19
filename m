Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692587598A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGSOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:40:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13110C7;
        Wed, 19 Jul 2023 07:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc1u1P74q8TjvRSl6EI+M+3KwmHFi4ZmPfnxWVHdGUujvqNiUpVk2CvjfniNuXjaGqm10exI9+/CAP62CV0yRmO5jG6G1Fc6rD9uYL4tJUu/yOv9nIDeLBLDkgFMVTMaJYd+hVN4pZKzFi40CUt1hnR1/VhrcCyHNykCfHtF2qa3ItB48lfW5MYuO2yUY5AkpMUg42vy2pQhTAHNJPt11zCDcSBv7kw5C/kj2RssXH96hz4CJ7M1WIYVUSB2Q/FqyR00QDnweYdzQ4h3ctHVkczL36vt1Wy3uY1sApSZ24t7jNn29883AX3t46NFUeeGul6Go2Dvpm87298nsjQwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dRVhkcG7az2B6QYrlXyXhljfnR0AuF+4YMXgcq05jE=;
 b=CMqtCnDHllwCQMenX+iIIA7QOMTm4nCIccYt7zFEHgLRNz9iOcrSdFPyIlWpkFKFQEfpLs8zxaq7w5T6WNGCdwz1h5aCK6vWxWGfjMhTi73i+38lHd5SqBxAszZ4WNFcIkOu0de+55Z8lP7wBNiBeuWDFH2uE296IPInmGlPqR6RYV7QJjP3HELj38rmTqf75Cslanr3CuRQSTxRPOKYZiINSoEhhFJULPhHjlS7K2YRvkDH+57+rVaxm7p8kLOtmPgCMXfQo6ulWxeX134OSqEZlhfKz1gRvYa+eMizXw2Nqii0BR65Kb7Ec9ZjB8kuug0Q/stpQw1UVN2eOP53RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dRVhkcG7az2B6QYrlXyXhljfnR0AuF+4YMXgcq05jE=;
 b=ZroORGFDRNrk0EukhXPhApXHeMQjQuEP/ONjMM9Yv9hig38JUEHUB5pG/nlnb2bjVqNXRtanYKwAhkv670hP2b1R9F/VJriDb8R3sX3e1G+6yBaZifelC08h+03hSXoxPiUQbQwdYBF2/IOigcAlNdMg1n8KEsrWiSUJzQdCe5UIXfdKhpzr5qxHDFBXgV1ZR7sIpJqZAzZYHLkbCHzal78wylRW0dNbkx36Wa23o03XZofjWM/sdTBDNLNJcrNFq34m3HRnd9I3Gjvl1m3V4TnmfuzTaMbQDWOsnaxb6ngiPA59JUzuexCEbZaK9jqni9ljFLXbQyxyE5pRPK9Ntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAVPR10MB7089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 14:40:46 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 14:40:46 +0000
Date:   Wed, 19 Jul 2023 16:40:34 +0200
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
Message-ID: <20230719164034.3efc9504@md1za8fc.ad001.siemens.net>
In-Reply-To: <160cb639-5081-ec50-2c41-fc31502107a2@roeck-us.net>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-2-henning.schild@siemens.com>
        <ZLafwOPrw+puH+rF@smile.fi.intel.com>
        <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
        <b1528e3d-15f7-7ab2-b803-917f79efe999@roeck-us.net>
        <20230719091816.6661d535@md1za8fc.ad001.siemens.net>
        <160cb639-5081-ec50-2c41-fc31502107a2@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:610:cd::23) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAVPR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 413f1e47-5baa-4227-0df7-08db88662331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnJyHqPV+4b/FV4a/mhSollRp0oJ/SmyMbJOsA93NQj5jiW65G2XwIIE7hIkzHjAvOA9SX8c4/vVWbl0FcntztCnQ2OL0Vy64L2G0rj/DaKjpsrA7L2eb5xsdjxHz1/L6onH07KPs0iQsM2je19PpBYSXFFUrup98FycWqLJDxaSwVLwGV0QpNUP69N+U7V0hzhxLtEatJyIOMYfF8Ulpy9Wzu38pKhFkxa9bYzlmtVvIhTLMoVjvDbvNVoMdTjlOe3zo/VFYBLFPMIvZCsEubs0vNgBA6o6VqJGrvxLM2RlwbamE3ltt1b4l90wFgdYR1zIy1+Iivqo8U2HU9SF/z5FD6E9+YOD8MpWi3Vi+FZDhELakoJNCZkzazIeF1c2v1NurM33QdG4/TZZWa0szAxXsY0qR3mYPoVehknv2hd803hh7cqOyvXLxbSScA20kAiW2uvE7dZ4+GFFq04FSgm64yinXcDi6XJWmaQbyWULiaLVUTI3ZX7vjScDQ2pIX1oPngRsiBWx/emLz6//xXUcmiZ4HFO+6M9yDJFPnm+VBjF/uX+TQNttWA323z80
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(66899021)(41300700001)(1076003)(6506007)(5660300002)(8936002)(8676002)(82960400001)(66556008)(66476007)(66946007)(6916009)(316002)(4326008)(2906002)(44832011)(7416002)(38100700002)(54906003)(186003)(6666004)(86362001)(6486002)(53546011)(9686003)(6512007)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMzjV6Al1tLPoIcqXrk5ty+TZHPyP/+PpHdwEylJ7+g+B1vu3TU6tdIR5/35?=
 =?us-ascii?Q?otH5lq03K+P6NttjByZmr2aXoaiddZyKeRRYKhRCQxJ3O7JAG1DCJiVL9xx3?=
 =?us-ascii?Q?QkQ1HI11MrSm3iWuEP3hqzbkKZkXfAaxojb7DhdkGT+ld0m4oyBfr7AHcgkF?=
 =?us-ascii?Q?ZFUOs6d8fzIVUk3PntNK/YBKnUno/mLGLVTkG6p3l2s1gjgDcnhmgZCgwa5j?=
 =?us-ascii?Q?6+Od71SegNvfpCHYAaKvlkt3ggTjPxoVIxVl8A89z1lW/Ghj4Wo8pxV71xwo?=
 =?us-ascii?Q?uAv7lOBlWrGNgVln3SjL8Mu13YBzMC00TO8q0c4RkaLHqfxqWYwqNawPiw7g?=
 =?us-ascii?Q?7KGYW+Ua12l3a+QWDwg4pLuHzMb2FhtSBk3bMQDxZrbJijVSOq8b6nbo70A0?=
 =?us-ascii?Q?ZVpUTlENd0sZVCxxSltjX8FJZd9xSRHNU4UAElPhgdpa4OxMJ1FEM5+toFey?=
 =?us-ascii?Q?9HP9UhT7frWMLAmSyUo5aKjFKUn8mPtOQtXw2GMyu3wwu3xy4ycUPZjBSXjg?=
 =?us-ascii?Q?4cqd7QFeDVFQjONC/HYrjvuF1rlilrAgJweWYnxEvigpFW/5pdQKfXH/GZW4?=
 =?us-ascii?Q?1Dx0ggjMbj7roVYJuiJYi0H1awFq11d4bVDGF1hgCMpgdnutEa//oyN+nJLb?=
 =?us-ascii?Q?5T+1usjKQg7m4+AfkkICZaA7wKEdlL3gJBPbTLIIY9+9ps8rTTI3O0vlWP8w?=
 =?us-ascii?Q?82d6T5tfkY9MXRWkAqxmTltHGx275BQhY43V4Es6H8zAEZTIMuLlLB+Ew7af?=
 =?us-ascii?Q?FHXgtnI9z2+A6hY6qgTMF5Kp9BcDu+tAjaLneW0l1iiZQGkbLIgnfXIXKf8C?=
 =?us-ascii?Q?gNckC8KAq90KgMnZVgznjIueH6FruaScFkP98yn/fBPbuSBbgQsIPokbEPZe?=
 =?us-ascii?Q?znkV4lyEW/zIfLfL23TkHQWUTcgqUXlLyTtEv4ycuoqXPoRZn8BD4SaJBz7C?=
 =?us-ascii?Q?4Jyo3lwgj+uGDJ/1Fbw7VZb7wsCWceESSrBN2/p50uhof6fDj2feifXdETNE?=
 =?us-ascii?Q?m961Cqn6xzPqvkTZX1emAiVtrZ/U8K7iAZe9K3dCFAZZBsmgRKIzUqfUFgnW?=
 =?us-ascii?Q?R2bIonOB5osMpKhi94FZn7DGwCRyQrPYqYJfbTbmK8cD/deeNHsoyfL7ttta?=
 =?us-ascii?Q?HqRXb3U6rrBysMncva01d3ICxzp/ZzWu0kGw6MGDtsJkoBtax4SJGNlkHRbC?=
 =?us-ascii?Q?SGsNHnwlEVhIDwqNGjyDVSJkDjfoVqyuIgO1ynhVSCSo9zMwdk2MVeU/G8yS?=
 =?us-ascii?Q?9BBxO5LdDX1qo/RMe0zFOIn4qCSMisJy9Hv98UdBjbUw1AYhyD78OPnHSXIf?=
 =?us-ascii?Q?WGuUndctcj4RCVLN6VlqxWEllN9lthknL2DqDlgo0WBBF6STuh8HCM2UVSjd?=
 =?us-ascii?Q?x9EmiIruFIjdL0IZIDaf+z0+lVEaRD1Qo9+j8gU5KXhaMPyZCCyxSnhPFl3d?=
 =?us-ascii?Q?/n/xvQ/ycPD8BAW/ZGixxxUTkahpVwu0tbG2m8wFPC/7MbM7OWPbkIUAGWX/?=
 =?us-ascii?Q?KJkFDjbNKONqdK0ubz7QwcffSj1Li+BLkav+EwgfwK/vxTOC3khou7sB0HpE?=
 =?us-ascii?Q?9cH2hOKcyQeI9ZhFUkEeuNI59vE7sq6JTOgbycSjzhZefvbvCHVyX6m7Lr1D?=
 =?us-ascii?Q?whu/q80FoUCZ164ESm5TXoSTf7Fs/uRdfWk42SCjNf0YmfOWt5LOA0xvHfQI?=
 =?us-ascii?Q?iAzVKQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413f1e47-5baa-4227-0df7-08db88662331
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:40:46.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls8ojZNRd7XC8fIdlmyXL2akhDovz8tR9nXko6c6EPYNDLpmgHQpcOetnV+DAN1roo8vutwOb5wpQRgDUbEwd3S1sqfFXbSBvGuunsrJhQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7089
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

Am Wed, 19 Jul 2023 06:27:19 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On 7/19/23 00:18, Henning Schild wrote:
> > Am Tue, 18 Jul 2023 08:10:09 -0700
> > schrieb Guenter Roeck <linux@roeck-us.net>:
> >   
> >> On 7/18/23 07:42, Henning Schild wrote:  
> >>> Am Tue, 18 Jul 2023 17:20:48 +0300
> >>> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >>>      
> >>>> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:  
> >>>>> If a user did choose to enable Siemens Simatic platform support
> >>>>> they likely want that driver to be enabled without having to
> >>>>> flip more config switches. So we make the watchdog driver
> >>>>> config switch default to the platform driver switches value.  
> >>>>
> >>>> A nit-pick below.
> >>>>
> >>>> ...
> >>>>     
> >>>>>    config SIEMENS_SIMATIC_IPC_WDT
> >>>>>    	tristate "Siemens Simatic IPC Watchdog"
> >>>>>    	depends on SIEMENS_SIMATIC_IPC  
> >>>>     
> >>>>> +	default SIEMENS_SIMATIC_IPC  
> >>>>
> >>>> It's more natural to group tristate and default, vs. depends and
> >>>> select.  
> >>>
> >>> Will be ignored unless maintainer insists.
> >>>      
> >>
> >> Maintainer wants to know why "default SIEMENS_SIMATIC_IPC" is
> >> needed or warranted instead of the much simpler and easier to
> >> understand "default y".  
> > 
> > I thought a "default y" or "default m" was maybe not the best idea
> > for a platform that is not super common. That is why i did not dare
> > to even think about defaulting any of the Simatic stuff to not-no.
> > 
> > But it seems that this would be ok after all. And i would be very
> > happy to do so because it means less work on distro configs.
> > 
> > SIEMENS_SIMATIC_IPC_WDT will drive a platform device which gets
> > registered by SIEMENS_SIMATIC_IPC and nothing else. That is why
> > "default SIEMENS_SIMATIC_IPC" was chosen.
> >   
> 
> It depends on SIEMENS_SIMATIC_IPC. "default y" would make it y if
> SIEMENS_SIMATIC_IPC=y, and m if SIEMENS_SIMATIC_IPC=m. If
> SIEMENS_SIMATIC_IPC=n, it won't even be offered as option, and
> default={m,y} will be ignored.
> 
> > But if i may i would change that to "default m", not "y" because
> > there is an out of tree driver package which if installed on top,
> > should be able to override the in-tree drivers.
> > 
> > So i will go ahead and make that one "default m"
> >   
> 
> Why make it m as default even if SIEMENS_SIMATIC_IPC=y for whatever
> reason ? Presumably anyone selecting SIEMENS_SIMATIC_IPC=y would
> also want SIEMENS_SIMATIC_IPC_WDT=y, which is what you had before.
> Sorry, I don't understand your logic.

At the time of writing i did not know what you described above. That y
with depends does not result in y.

Next round will have a "default y", Thanks.

Henning

> Guenter
> 

