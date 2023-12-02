Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B780192A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441988AbjLBAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:53:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADF9B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=o1NM07RObpJNiXChqi4kLRgTG3JsgYws/JTItq52CuU=; b=Dm61uHSX3GQcno0hTrs6TXswjo
        SYYhqZ1GK7F5TtJOHrA+3DqETHWsUrakUW7VK7U05mTa1h2zg8TrggUZoIOqPf9Qb1KJsKJrYo4Eh
        QQ/TON//0O2QQ7edMgKDTET+rwjuLIOnOjyX57oon5NOa1lNs77N4ZSuOiVfNONlGRF/gSRIRRvDZ
        uN9RJ+6EUSN1ZAnoEtNc4qyr4JYNPjbUoqdxCfYrMLWUdhp+DeuFSNANzvi2OiHQPKGbTXkUA1nBz
        D9lpMuGNHFRnfUU0c/spKjK1/i/Qzkwh+SN89YgNc4iV6F31ekCysaXt20M044WPAxvwdXoMtlknQ
        5Hy1ZmUg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r9EG4-00Ewou-0Q;
        Sat, 02 Dec 2023 00:53:24 +0000
Message-ID: <6ab5bc0f-3945-43be-ab66-439402ca9a81@infradead.org>
Date:   Fri, 1 Dec 2023 16:53:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured
 comments found
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <202311220421.xKye7ZRO-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202311220421.xKye7ZRO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp,

On 11/21/23 13:12, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> commit: d8f4494e70ae5fef159719bfbb6abedc53619bf1 pinctrl: mcp23s08: drop comment about missing irq support
> date:   7 years ago
> config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311220421.xKye7ZRO-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pinctrl/pinctrl-mcp23s08.c: In function 'mcp_pinconf_set':
>    drivers/pinctrl/pinctrl-mcp23s08.c:282:6: warning: variable 'val' set but not used [-Wunused-but-set-variable]
>      u16 val;
>          ^~~
>    drivers/pinctrl/pinctrl-mcp23s08.c:281:11: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
>      u32 arg, mask;
>               ^~~~
>>> drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured comments found
> 
> 
> vim +1 drivers/pinctrl/pinctrl-mcp23s08.c
> 
>    > 1	/* MCP23S08 SPI/I2C GPIO driver */
>      2	


What is the issue here?
I fail to see a problem.

I cannot reproduce the $Subject warning message.

-- 
~Randy
