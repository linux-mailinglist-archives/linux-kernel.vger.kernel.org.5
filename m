Return-Path: <linux-kernel+bounces-2569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A22815EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C962C1C2132E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0832C7A;
	Sun, 17 Dec 2023 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQfyH7hN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD635267;
	Sun, 17 Dec 2023 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so20769355e9.0;
        Sun, 17 Dec 2023 04:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815228; x=1703420028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JE7dOMH1nRocIYdSdGHxkcV4ltVmVneKSFcLQT234uE=;
        b=TQfyH7hNSb24KCaYuwv1B97qW1UM13lWLdjldi6cesJ8IBE1q48o6UH4KSTlWmieoK
         +rsOgpnCA5/JSlpNyGXm0nyGDRm+HClAu1wz1zAY6aiAMC+0X1xs9kJJDwZfinbvawNY
         HirLbV+UKTF+6yUVtQMKq43dmvAFI0VuHwbgDYlS09r0H3okvtRN9VemWW1x16LNkiNN
         WHhT6q4QjOdCg/G1HQ3Z0VaYDU831vlgNhmZVvRg4CIlt697+xGfuRjqxQBxc9ZKrYHK
         S9m48yvqZimVZl7HkNyZIeqWgWe0MbltRC2GIigzE04Q9jX4a1/Ya2opub0ACweRHhxK
         1dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815228; x=1703420028;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE7dOMH1nRocIYdSdGHxkcV4ltVmVneKSFcLQT234uE=;
        b=KgZQn7JgvNmDid2+KaOi6gorM2Zj5Gnqf36urWUK4EEbGYX7YUw5HM9nKXdJFhTdr2
         dy+vjBR0qhW4nAFlU+CQf53FqHkn9NDvM6s8rk+AM/JLFZN5C0YONqPp11vHZB7Ti71P
         lZseIfmpmk/5sOnepGlUmVvfJ9upz9MENFAQligOBh7Ysp5H/i76TNtOuMkPw0j8Fx7+
         jQ+qtJ1uirvAidxXPEgzWO5q/yOTqA4cTlwFnPan7l6MGnVBABn/JRiCI+vo5nNMXkkH
         3MXObX+X0nMzrUBgP2O6U2yjw9tR/3BvXuGFF6i941Mmss5+2EMq3uyAOuWDI0XjNtkZ
         6x6g==
X-Gm-Message-State: AOJu0YzA4z+p1G76EacwOx38qIEn1/4yBLWUiCd9ZhZPYfOtk8r71TJ0
	ZBQPtRomSkjV8LmThPtqxh99Hwh1DL8=
X-Google-Smtp-Source: AGHT+IEdbWMb886XiB+Q0uoh9ts9fkqR69ux7NW4Dy1aSAVyKaEw+WWmuwC6j6n3jhxkAszye6nNQw==
X-Received: by 2002:a05:600c:2106:b0:40c:3270:ecb4 with SMTP id u6-20020a05600c210600b0040c3270ecb4mr6982773wml.181.1702815227847;
        Sun, 17 Dec 2023 04:13:47 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm39747867wmr.34.2023.12.17.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:13:47 -0800 (PST)
Message-ID: <657ee5fb.050a0220.37aa0.36a3@mx.google.com>
X-Google-Original-Message-ID: <ZX7l-YA8gD_4SEqo@Ansuel-xps.>
Date: Sun, 17 Dec 2023 13:13:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: display only supported
 link speed attribute
References: <20231214122041.17439-1-ansuelsmth@gmail.com>
 <202312170606.NWH5SzQD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312170606.NWH5SzQD-lkp@intel.com>

On Sun, Dec 17, 2023 at 06:23:05AM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on lee-leds/for-leds-next]
> [cannot apply to net-next/main net/main linus/master v6.7-rc5 next-20231215]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/docs-ABI-sysfs-class-led-trigger-netdev-Document-now-hidable-link_/20231214-202215
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
> patch link:    https://lore.kernel.org/r/20231214122041.17439-1-ansuelsmth%40gmail.com
> patch subject: [PATCH v3 1/2] leds: trigger: netdev: display only supported link speed attribute
> config: i386-randconfig-011-20231217 (https://download.01.org/0day-ci/archive/20231217/202312170606.NWH5SzQD-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170606.NWH5SzQD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312170606.NWH5SzQD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/leds/trigger/ledtrig-netdev.o: in function `get_device_state':
> >> drivers/leds/trigger/ledtrig-netdev.c:230: undefined reference to `phy_speeds'
> 
> 
> vim +230 drivers/leds/trigger/ledtrig-netdev.c
> 
>    211	
>    212	static void get_device_state(struct led_netdev_data *trigger_data)
>    213	{
>    214		struct ethtool_link_ksettings cmd;
>    215		int speeds_num;
>    216	
>    217		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
>    218	
>    219		if (__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
>    220			return;
>    221	
>    222		if (trigger_data->carrier_link_up) {
>    223			trigger_data->link_speed = cmd.base.speed;
>    224			trigger_data->duplex = cmd.base.duplex;
>    225		}
>    226	
>    227		/* Have a local copy of the link speed supported to not rtnl lock every time
>    228		 * Modes are refreshed on any change event to handle mode changes
>    229		 */
>  > 230		speeds_num = phy_speeds(trigger_data->supported_link_speeds,
>    231					ARRAY_SIZE(trigger_data->supported_link_speeds),
>    232					cmd.link_modes.supported);
>    233		trigger_data->supported_link_speeds_num = speeds_num;
>    234	}
>    235	

Ugh didn't think that LEDs netdev trigger doesn't have a dependency on
PHY...

Andrew any idea about this?

I can see 2 solution (or maybe 3???):

- Add the dependency for PHY
- Move phy_speeds net_utils.c (with the settings table moved there)
- Implement a custom function in ledtrig-netdev.c

It's sad since the phy_speed was just what we needed to implement this
ins a ""clean way"".

-- 
	Ansuel

