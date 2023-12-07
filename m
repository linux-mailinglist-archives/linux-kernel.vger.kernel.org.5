Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662F808F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443584AbjLGRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443447AbjLGRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:52:52 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA2170C;
        Thu,  7 Dec 2023 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=zG2UGPXCv4/FgbLJTXPGX3Nf8DqXr0h+L8Zc4YpOnTg=; b=RThyG6ynxjFruIcj+Fjw17JpTZ
        9Xlpp4UZrDFthSmK3pDHBqY5AHfVWp12rkbHjOKkuO7YeVb47/IpVphxP8OZHbED7+45vEsnAj7b2
        +z4JeO/Lbt6egcVkjiaMEkDmTdrwVuILKEq9PbcLYKM+vHdhc0KUUrY+tHqcRW29k6Hk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57946 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rBIYG-0007oa-0U; Thu, 07 Dec 2023 12:52:45 -0500
Date:   Thu, 7 Dec 2023 12:52:43 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     kernel test robot <lkp@intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
In-Reply-To: <202312061443.Cknef7Uq-lkp@intel.com>
References: <20231130191050.3165862-2-hugo@hugovil.com>
        <202312061443.Cknef7Uq-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 14:29:39 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Hugo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on d804987153e7bedf503f8e4ba649afe52cfd7f6d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-fix-snprintf-format-specifier-in-sc16is7xx_regmap_name/20231201-031413
> base:   d804987153e7bedf503f8e4ba649afe52cfd7f6d
> patch link:    https://lore.kernel.org/r/20231130191050.3165862-2-hugo%40hugovil.com
> patch subject: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
> config: x86_64-buildonly-randconfig-001-20231201 (https://download.01.org/0day-ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312061443.Cknef7Uq-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
> >> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
>     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
>          |                                         ^~
>    In function 'sc16is7xx_regmap_name',
>        inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7xx.c:1805:17:
>    drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in the range [0, 4294967294]
>     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
>          |                                    ^~~~~~~~
>    drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
>     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hi,
the only solution I could find is to add this line just before snprintf:

    BUG_ON(port_id > MAX310X_MAX_PORTS);

it allows us to have the smallest buffer size possible.

One other solution would be to change port_id from "unsigned int"
to "u8", and increase the buffer by an additional 2 bytes to silence
the warning, but then wasting 2 bytes for each channel, like so:

static const char *max310x_regmap_name(u8 port_id)
{
    static char buf[
        sizeof(MAX310X_PORT_NAME_SUFFIX __stringify(UCHAR_MAX))];

I prefer solution 1, unless there is another solution that I am
unaware of.

Hugo.


> vim +1703 drivers/tty/serial/sc16is7xx.c
> 
>   1698	
>   1699	static const char *sc16is7xx_regmap_name(unsigned int port_id)
>   1700	{
>   1701		static char buf[6];
>   1702	
> > 1703		snprintf(buf, sizeof(buf), "port%u", port_id);
>   1704	
>   1705		return buf;
>   1706	}
>   1707	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Hugo Villeneuve
