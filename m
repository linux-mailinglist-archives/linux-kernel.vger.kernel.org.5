Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0835758EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGSHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGSHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:20:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882C26AC;
        Wed, 19 Jul 2023 00:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8er8rD6USnjqtuWF0+X9Uv7J5sSA/dH/t8QxZ1Q5AEBjcIYT6VYkP2b2F3fgtiTJs3G9N/Zttk+RosSNyEPWbyHsnd8Fp8QTHOxTtWurl/3KyZWIE3MemmYxPwZpkn6QRnDtfXUQnCUIL/6VESkhC0NniOS2HI4BVzXInyXSC/pVTUgEJ0Ck9Pdz8e8ojRu1M2eY/HOTDeDPDoAkAZiCQ7pJWSvZTIVrqf1hhGz8HHez3hEf2IVWmNpN8zbbzs7zk8jDhqbaFv9Xa9AwhKG78Wx4VT5gg36AMcTnEsU5GbjfOX2fdiwTq5gbjgWrAHwXeHVVzJsEo8tTPZkqNouJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSKnjInqwQJ6rb4M09xR56vNJZTL+vsiqOnb+k+PYUI=;
 b=fw50TXVlRGDGWPU82wXs9Po6awGwLNUGL+iZhwzlm0aCEehk//chKAsYUCGqr2uh/bDuzgGlisihAnQicKtcEV2EC5PUHC83s5iTM34pn25SFojC4x6kgZp0fjX7q0cTIo9o2yW8fmCXs1UW5UuMErPrYAB9IR8yNeOm2t4kWeA9IlidSzcwgXb0CGB7t0jyeRnNgVvmi2JcsxPWUPeNKp4U+T+CSlepcOnbty2H5ZYzTpYIlaih2UlOOn3LQ9AhmuLS1MjGMB4fbcD6UolP6VVAHL9240erd81ogM5lOHVoiYNXPClGs5EEtBVahWekoK7by4NaOoRRjyw77a46MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSKnjInqwQJ6rb4M09xR56vNJZTL+vsiqOnb+k+PYUI=;
 b=JLLJjbAGWIqFJzVB9Kfe1+hqlvQx50YlXvqQ8yybgZzoGVgyOox2rjdU9sEa3l8y7VSQONWpBQEf5BERmQ7I1LiLFAk3afVxZNkvcQFxnRsmd6G1bsZilZOUHvVDUwvkq9yypTA2GtYoswXgHcLwuTdci9ZGr2g0onnWnw8jb7bNeigw5sXyz2oawq2G8WIejVoKUrPAAh+Kyzu5xLx97I2gk1kXEwljz/NVus8WMtZU5OKDAnoNYvtxQNfqFMXh/kYFwJUZZvlmwXm3B1PUJhHBn96hSN+3TjgVskXScA0FF0UlgSxtidKEWGjozx9jXpRP34iuylpqi71fxJ12WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB6560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 07:20:24 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 07:20:24 +0000
Date:   Wed, 19 Jul 2023 09:20:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Message-ID: <20230719092019.5545ee15@md1za8fc.ad001.siemens.net>
In-Reply-To: <0f38956f-8d23-4f50-8e76-85fc3e225fd6@roeck-us.net>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-2-henning.schild@siemens.com>
        <0f38956f-8d23-4f50-8e76-85fc3e225fd6@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 07df36d0-1c09-4f1e-3433-08db88289e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07WPiSvkQVe+up+8rxiGE9CyhcLWvdITznjs7a3j1RNtnrz99DuxHWJu1/0kuRuag2VwLZFCCFLqhA3EFMAwOkvH7j61AjL+FAKErgvv362l/FPpv+K16PMBgqbxkI2vL5il3UfV4yG6qKs5amnQyg9bpMJBvgRsTqS7Xe9r0nxeOkdn1QxUgzba8TjHKRT/2PaCqteVEhhNIYvtYdR7CplkaloBK7O3wDbozJOHDy77R9y6XE8mOU7rAvpxzpRWKii7UOt6wCzh2lCsB9AM7H5CttB8EXPzM/8HaGV9ZCL78Gr8snU+/zI6LTpWHnNgqQ7mf0fPxqOv+EhctVX+UnNMbFkutp5TWK2y6GmzdcnXFwg65bVrh4/5jJyWayepsnA72HRTrDsNd/GdgrxQuuvluZ+e6tTRg7z8a3qqgSaIgPR6xUVXG8w3HgN1OxVLHLwQ+gq/yWyKmKEgOfFdc+l+j3m6F4zOjKB9heKgNT2Z7S520Zo0zumjd6lsyE4p8upnPzB/RxZZSBstKqVHD41+LyJaDnff93wn5VjZ7j++p447oQM52dqoN3Ecomq4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(478600001)(6486002)(6666004)(54906003)(86362001)(2906002)(44832011)(186003)(1076003)(6506007)(6512007)(9686003)(107886003)(38100700002)(41300700001)(82960400001)(66556008)(66476007)(6916009)(8936002)(8676002)(7416002)(4326008)(5660300002)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G98Hxha5fTP9HBFdgelwPCkrQdrGquNFxnIgFqDuw04qXd06egsGqOKbWWzm?=
 =?us-ascii?Q?KErxVFSdQWmAsSBay2v4MdCHa+ksX3UyEdMeIsxB+5W2qH8vMua8VXG93dgG?=
 =?us-ascii?Q?HRN6qyXhhUU1WPLphxNbFCIChbGjLZJ04/WTRywx34SrBsZHpxQB5aOgQ3M6?=
 =?us-ascii?Q?KkTvpgb5toeEEQwmUvlD5uvuZdwhHZPLu0yQPpG2yTpMXjE/itK8KzQL9C9F?=
 =?us-ascii?Q?rmiOPvbEQDC/WuR5bo2sv0yGpz/K4h2BOuwC+nyH4SKarghcOYBlWWpS+dXZ?=
 =?us-ascii?Q?BEO8jSbaBTZ3UQ+Ob7rKzchySOeqUbcOyHp3+pqy6ns0RupDluRHGyyDmCDF?=
 =?us-ascii?Q?ivLVbfm2BsIQ/G2In063NnOP9+XXsyloMEjXgjA7s6yKEsXd7YASRSM9ris9?=
 =?us-ascii?Q?lOp2gpMulGoiFH8ssk4AqNX4o3hRPcrP6a0cwzt5jGyiCdmRrab4UUyaurFk?=
 =?us-ascii?Q?dX2YOdc0qscyowRWTCTkRu4Xv25+MBZnk3a0VSt0Sg7f/nL6PdOi9VvY9a3Y?=
 =?us-ascii?Q?GIMHlT29dW26TU5r3pLJrA+0C0uiEWGAkWYnskT2A4NqjnGfS1zRfX9zeWaE?=
 =?us-ascii?Q?TmWpcP2HcjuKs85fhko1crHFzv8QLV/CIIuNEnJVwxYbtPMr6xLQYXDSJSOH?=
 =?us-ascii?Q?YhWqudHGupRWNDMpgXiKJN5wxlCtylBK97hB9WyXv9zAnFHkfPT8DBbk5RU6?=
 =?us-ascii?Q?zl/XcshfjKruY5Mh5El0uKFYcxMIQdrRdtf/ARRl2MySMoPHCf7c5bmJNk5c?=
 =?us-ascii?Q?wkAOda+BkXm34FBwC2/XyR1umkbo9LaBxFnuwmCk9gis+YVytaIz+TdL59Hc?=
 =?us-ascii?Q?dhJpgMxPtkkwKm6bK3//5y633d9x+rLaZBU1r1NKJB2xgQK4j9Qg6rgPNB8j?=
 =?us-ascii?Q?RaTLzVYB+IR75dxl2qayOrKVP2Hp5DfXEZ0WSQl3k9yx3A0+QUrIlXe9t53F?=
 =?us-ascii?Q?Srk61b3xvNl7iViGbicaFBCd3OYiZ39v3Ly400iw1kxw31C5/7Fou5vajI2L?=
 =?us-ascii?Q?lHndZF9xhAYmDyZXhvv9XyiwVVR0CPcCQoHMYhIfsjAGL0vRfxtyPpMo5OYI?=
 =?us-ascii?Q?ibTtZvwAQWUfwhfGzDQsb6VtkzrbP3MrBYLpmT5/uLoj/n9EF/iI9vjkYyrw?=
 =?us-ascii?Q?Xd3rLhwNqBjZrnHH4q21KTPDULy45BLsk22+0If3QvOQ77+Qq1PcOYztIO8H?=
 =?us-ascii?Q?G7NCQEtD6ovp4owjrDLLmDHr3jVgFp4v9XTPn7RBRjOhrSw+0eSYdBcgDp1L?=
 =?us-ascii?Q?ceBKBBcTNTJSytt0KnhSCSivTOMH9I4P5ClX5FKC/wDx8Dopjly90Oz14na5?=
 =?us-ascii?Q?0+u00Xf5LnpyuGum8Nbkl2UoBYYL9W0UGA5KAwVs67Cl+/Bin0JPFZbFUiG5?=
 =?us-ascii?Q?A9SZmpV3kTd6DqdZcKC+mVe6BwgMygZx0vVKvc0o2/X2CfXhen/9oXzbcFRb?=
 =?us-ascii?Q?MjhOslnB9iLY+sJiunV4T+wsGvdnovARRaeqsAIXculUn1KN2YaOioYKX4+7?=
 =?us-ascii?Q?HiyfsHrz1fAecg60UXuD0MhPMohTODRQhHZNPPf0zXSpHb/qZLwhyBh3BcF3?=
 =?us-ascii?Q?+X7xgltUk1sZKwGiOIyB7LUNfA09lzXI044OmsVS1iX71lYNGynonM8kKNCJ?=
 =?us-ascii?Q?jhXWjdo+bbNkNl7pQHF+IH7aWYhuahzQqIsxrfnyn9BG7td7MOt2kwb+Xgz+?=
 =?us-ascii?Q?gJEYkA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07df36d0-1c09-4f1e-3433-08db88289e5b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:20:24.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX4AjymXxt+8JmUtW7a76DBYtfdSfgLLS+/+ijEuzXxssv6OMVgVAxLWAySZJEyv0jofA+fbkRZ9b4PsUgSGugdfNWzeJiJISFiFp0/mmCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6560
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

Am Tue, 18 Jul 2023 08:07:52 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
> > If a user did choose to enable Siemens Simatic platform support they
> > likely want that driver to be enabled without having to flip more
> > config switches. So we make the watchdog driver config switch
> > default to the platform driver switches value.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/watchdog/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index ee97d89dfc11..ccdbd1109a32 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1681,6 +1681,7 @@ config NIC7018_WDT
> >  config SIEMENS_SIMATIC_IPC_WDT
> >  	tristate "Siemens Simatic IPC Watchdog"
> >  	depends on SIEMENS_SIMATIC_IPC
> > +	default SIEMENS_SIMATIC_IPC  
> 
> Why not just "default y" ? That does the same (it will be set to m if
> SIEMENS_SIMATIC_IPC=m) without the complexity.

I see. Thanks! In that case i will go for "default y" and not "default
m" which i wrote about in the other mail.

Henning

> Guenter
> 
> >  	select WATCHDOG_CORE
> >  	select P2SB
> >  	help
> > -- 
> > 2.41.0
> >   

