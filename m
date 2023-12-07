Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50248091CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjLGTqR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjLGTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:46:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFF1710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:46:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-216-Lg-bH7P_MLmKxgoy-bEtjA-1; Thu, 07 Dec 2023 19:46:10 +0000
X-MC-Unique: Lg-bH7P_MLmKxgoy-bEtjA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 19:45:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 7 Dec 2023 19:45:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hugo Villeneuve' <hugo@hugovil.com>,
        kernel test robot <lkp@intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
Thread-Topic: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
Thread-Index: AQHaKTY2EJh7ggNIk0GV0BoNbt/4DLCeM6bg
Date:   Thu, 7 Dec 2023 19:45:55 +0000
Message-ID: <16093ec23ca34085824987456eac8f2a@AcuMS.aculab.com>
References: <20231130191050.3165862-2-hugo@hugovil.com>
        <202312061443.Cknef7Uq-lkp@intel.com>
 <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
In-Reply-To: <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve
> Sent: 07 December 2023 17:53
...
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on d804987153e7bedf503f8e4ba649afe52cfd7f6d]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-fix-
> snprintf-format-specifier-in-sc16is7xx_regmap_name/20231201-031413
> > base:   d804987153e7bedf503f8e4ba649afe52cfd7f6d
> > patch link:    https://lore.kernel.org/r/20231130191050.3165862-2-hugo%40hugovil.com
> > patch subject: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
> sc16is7xx_regmap_name()
> > config: x86_64-buildonly-randconfig-001-20231201 (https://download.01.org/0day-
> ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-
> ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312061443.Cknef7Uq-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
> > >> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive output may be truncated writing
> between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |                                         ^~
> >    In function 'sc16is7xx_regmap_name',
> >        inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7xx.c:1805:17:
> >    drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in the range [0, 4294967294]
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |                                    ^~~~~~~~
> >    drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output between 6 and 15 bytes into a
> destination of size 6
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Hi,
> the only solution I could find is to add this line just before snprintf:
> 
>     BUG_ON(port_id > MAX310X_MAX_PORTS);
> 
> it allows us to have the smallest buffer size possible.

Or "port%c", '0' + port_id);

Or maybe:
	size_t buflen = sizeof (buf);
	OPTIMIZER_HIDE_VAR(buflen);
	snprintf(buf, buflen, fmt, args);

See https://godbolt.org/z/Wjz3xG5c4

Maybe there should be snprintf_may_truncate() (etc) in one of the headers.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

