Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47697759055
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGSIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGSIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:32:29 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F951737;
        Wed, 19 Jul 2023 01:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6EVx0NYL1FbiMweM9EKOuf0aIJb3eb7D9qkvX8hmkWFqZnC4G+8hUgVusESL5t7aJdHQz0GV7w9+Mm/TU1GyvNnH0H5bArSgMBmEQMikpL79uzoJV6Y9MqOnqZNUDiuaPfRm/FXuwCSgz5K2miC/AeaBigl3Djw52Z53ZkQa13zcswwpcp8EoaNv9xnccsGj59YLkKbMmYrgjRM3VMFptarVsy9xgQwGsXubqI6gDZDhQKa7YoKULDzHw7hmfCACgjODGP48fcwcY7H6zkhB2DZKUuEaoGPLtrwmzAgLjBR4PIaKQCNfe7ir6rc9C9a11s9xT04x9WUAmik9YJtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP9j6FsYsqh69V8l6uZbXiSmDjNr6xd0bh6b9GGymc8=;
 b=X/gfRHN7i07ZC89oB2YCIRTej5nKZ8q6lhBHTsOOnsmH0rO5r2asGl+lwfb7Cnrf2mHYHakrto8CtQtEIlf95WnYpyUBkNkwojUqM30dt+oTVBlAYKtYR16WRCdevhzsuOXyPGXoT8TCE6sxopnGTyfJ5j90RQyvXKjIb+kJj61mGBhgBv6I2XOBeaeJitq5Sokxh5gO7fFDxvbZQmlkDpJcYOOmIUqVhRTgzqMkAX29CQ6ffChFTFTyS5l8GI5Fn40uVluUaHdd6TJKXmr2VmfIt3KJxuf5B/TibBF/BGS/feq+X+cLHKOpOi62Vm2WHc1fabgI1F8q63XlRHgYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP9j6FsYsqh69V8l6uZbXiSmDjNr6xd0bh6b9GGymc8=;
 b=l+sQNx2MD0GkXBo+q3wueS7aXuzO3CTSwPv4SgkjOGp52mjM3g9UQA23USmCEeSKvD2Zmj+NKgq423WICwLtPNAVJvDJHcDxoc6zZfOiLz13u6s8RYXiDpYNRpp1vcxN7iZzvxGtmVKkl+8aqNSnp3U+ip5h7UoeMxdYbDuIRXoQTcoy2ee1Ac5H82t7AGbhOXzUcv6tBmksl+6hi8w19VXkjBgPRwjr5qWw+8ydi4HtqlD+axVcqUZ18j2rGKODATs0EeAa8zTk7M2WlqyVEA1gk9gngBp7P9TtYoq40L1AfFB2fFXQXXZyBb+KTt+9trY9tUXb5jddP7guqolIFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 08:32:24 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 08:32:24 +0000
Date:   Wed, 19 Jul 2023 10:32:13 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the
 subdirectory siemens
Message-ID: <20230719103213.75999895@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZLasehsClBD8pkPC@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-4-henning.schild@siemens.com>
        <ZLagYgJT4cz4jZ5r@smile.fi.intel.com>
        <20230718164727.6a89e3da@md1za8fc.ad001.siemens.net>
        <ZLasehsClBD8pkPC@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:610:e7::24) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: ae52006d-873d-4f4b-1146-08db8832ad3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLCjlYJOdsKf5hxw9FSyQ7tGwi9KfWQDp4xIvJKSGvWG/jtFkoQrGMN+xmOcNKxBHRBY66St/J2Olr0n14p/Q/UnU2VUQHtxCz7Sg/gLeZh2aJJWwI3VohsjRqC+9BoQ+9nhkheS5hCLn+O2aLmYOZlLoxQLWYvCBXFwORcy7fxE852UrTPqijrcOUbwt0KgmMn9nhZAlqeCzOuMfk+hczGNut7Ts4bJfs/nTLnWmkqahRV5tUHipaH0fdhbyvjbR7bNgGC7EPiNIUR5f8ZLMvn+S7hF5SvgU+9Lj1YxtTfSTsvrexBEMILfzpJf/V2KW6UQhp0BiFWq4+DenRVJ4Ta855lp+i42XlEoLCl1qFuigeRef3+SYCXqv5PPE7EDAY3COAlkqcp/Z+e5li2Xmdt2ioKMLoQxMTnebDRy49GRotSQDNuPlvgkrsunnGWctAw3dQMp3vsm0Cu+eeINv5Egibt4VA8gZpSeQTHdfNYrPOz2jnn2y2FK+xdtuJ+4/Ph4iA8sbHyxYE8Jef2774Lt3vYjVBNvyhMFaysmKNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(41300700001)(6512007)(7416002)(8676002)(66476007)(66946007)(966005)(8936002)(6916009)(66556008)(2906002)(6486002)(6666004)(54906003)(86362001)(4326008)(316002)(44832011)(5660300002)(9686003)(38100700002)(83380400001)(1076003)(186003)(6506007)(82960400001)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4Gl6vbesD4mPqPv4qoUOIYJIc2F78G6TSYx5ULbuxdva0Nw9Kp/F29vSxOf?=
 =?us-ascii?Q?mApbmWHaqQerydR6ICysqnfCuVZLwiFkE0wYh+juTsIgQJPRbSBfwb/I0d9p?=
 =?us-ascii?Q?P43S/7SR+aX69voQlP4KeKvK6tGwMBa5YCWaKXv4tJ5YI0m97CeUbh8jxGMM?=
 =?us-ascii?Q?Q7ZGbGcLpcutgTss6HntLf8H0O4hdHw9FHZQZhBXF30ukjaLrc5UAGbUiRUU?=
 =?us-ascii?Q?t3BBbKe8ZnsWsLQH/s51f83bJPHo+geC11v3nZwU7UxVKLyHRPrQuAYQMn8I?=
 =?us-ascii?Q?3RzHnQntszNAXDuLACXyfTObiUjkjaL2GBI3B0+/a6ely1vEVRfMK9VTbFMs?=
 =?us-ascii?Q?qiRugBeQeJG+H2NLc24lNynCKVJat5OeDUkPSZuxBoGowhfYk96B8DpiQwlX?=
 =?us-ascii?Q?8Hn1kSlaqAjeTjzJ0cpNy2I6W+OUsvXG5JAsASRF4meRvllt/aBq+pPz9ekX?=
 =?us-ascii?Q?l1FWCYptpSNyBw4cb+s/HTnk42DMMYlZd3ap3nbInvEfjQTSAKQRacc/dZK1?=
 =?us-ascii?Q?o7MCiVi85EtbgK2YYo/An4CXxdteAiWHx/oZT1sowdlXBoaVrUoK6zymZUcR?=
 =?us-ascii?Q?Sym4ld7yaXKvqYKIp0ziby2647TWGz7PRCj4gFrgBZVtzew7WBdhpgzdBW4T?=
 =?us-ascii?Q?MqD9DBrsAZst4enJO7TASJdZbr2YbyfRT/k0T8U8W+d6lsEmwBzydYlNo220?=
 =?us-ascii?Q?rvs19W98vYHGwqETWLM4v9PpsmsXYsvnPc02jleVzoDmvTYy9UDRTP4VRdAp?=
 =?us-ascii?Q?5L3bMn5J9+agVw9CyK7/aLt8zXPogzvC7pSOS3ZsxR9JSjbWLdCayaXeh5ND?=
 =?us-ascii?Q?Y0e/bFMSWU/Sy7fciotkhvRmbZ2ioE5NpAcgOkMs9vqYDIccTmg5t5ytW1aH?=
 =?us-ascii?Q?6aPjuqA7+muvGLZKK4saJ6f8++QDfP+uaKMpQhD3sPl8vnh8uEaMXCsNeId9?=
 =?us-ascii?Q?bkjhYUhRyi+ZgXQeBSsDJRKqC4U8DcfZAhOLrN3njut4b4ESN0rOlswTg+JU?=
 =?us-ascii?Q?5ct4CU5K4hc4/lU53Dh4PXFBbOmgdMo3PJr1XrCWMNDYRj7CwmhrWeMtgrTm?=
 =?us-ascii?Q?izjpNJerf11N3pbtEN0ne3NpvIzS/6EXlq0kEicq3lXgnROzMhpd0zDw9vps?=
 =?us-ascii?Q?vmIqhsAbOh63WCzVwYrC7o9TCeZshru1dNQDV+MDKk+eo0YvSVqwu4K8Xeh/?=
 =?us-ascii?Q?0UEc9DXmEwVK2Y5ABG3lcbCP6XmIv9gEsX9lwV+WQGHmeNa6vaS3rM6+yEH3?=
 =?us-ascii?Q?xmsCqwmSMFvhCJ9SfKX66kz3/igaTsOPifd26Jx4AKiBo1WDRl0dIHoHhWS0?=
 =?us-ascii?Q?Fz1SZ+IgD6aAtr9Af4whXfyU5lQgGeLG/5MRORgtj/t5XxgVrUMrE35lFbwE?=
 =?us-ascii?Q?aBAFdBptJA31wX2FOfuUepRP8wVBI90u7dxNOy95WhWGgWQflUpMx8SZFcIB?=
 =?us-ascii?Q?tY3livm5xPnZJL6A6gRgzTuFZKtyvB4671gzdfrNmVPm6CUBN74/1VuKcB+0?=
 =?us-ascii?Q?4o/V0kjdJoVBKX2KszUivsJ4d9kjVGAQZCiCHDSB6qc2dSmHvfv9PjbxRJkm?=
 =?us-ascii?Q?K48pei3V1ZKPO1weHlbsNUZHZQ175FLuzNF8KhsNMDSRQ6YJTVqQv5xY0yph?=
 =?us-ascii?Q?Ka8AomdEVXs1GJkzbpiGzQDE1Ly0aoEkcxplL9V7XbuvRxyOg+Mq/xN71qZd?=
 =?us-ascii?Q?45v4QA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52006d-873d-4f4b-1146-08db8832ad3a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 08:32:24.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkkRvNAyOoK1mUExEmWbSSC5QTz/sEYTIA1uUlHTPK6gORQe5jbXPGqKWfg+dvLrF/1gCMP8aPTjKSCQi9PEwBJhusS6DvSCnsV0m2jIJ1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382
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

Am Tue, 18 Jul 2023 18:15:06 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Jul 18, 2023 at 04:47:27PM +0200, Henning Schild wrote:
> > Am Tue, 18 Jul 2023 17:23:30 +0300
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >   
> > > On Tue, Jul 18, 2023 at 12:52:13PM +0200, Henning Schild wrote:  
> > > > Users without a Siemens Simatic IPC will not care about any of
> > > > these drivers. Users who do care can enable the submenu and all
> > > > drivers behind it will be enabled.    
> 
> ...
> 
> > > >  # Siemens Simatic Industrial PCs
> > > > +obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+=
> > > > siemens/    
> > > 
> > > Do you need conditional here? We have stumbled over similar for
> > > entire intel subfolder, it might affect the rest as well when you
> > > don't expect it.
> > > 
> > > obj-y		+= siemens/
> > > 
> > > ?  
> > 
> > It was requested to be done like that by Hans, he wanted me to do a
> > similar thing that  
> 
> "Similar" is not the "same". :-)
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
> > is doing.
> > 
> > And that is what i did. If there was a y ... the whole "one switch
> > to rule them all" story would not work out anymore.  
> 
> See these:
> https://git.kernel.org/torvalds/c/8bd836feb6ca
> https://git.kernel.org/torvalds/c/4f6c131c3c31

Ok i will switch that to a simple y without a CONFIG item to it, and
start that inheritance chain at SIEMENS_SIMATIC_IPC.

That in fact also makes sure the interface does not change and "make
olddefconfig" does not turn the Siemens stuff back off because the
newly introduced guard is blocking/hiding what used to be turned on.

Thanks!
Henning
