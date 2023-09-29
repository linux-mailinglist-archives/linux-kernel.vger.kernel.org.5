Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02A7B2FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjI2K0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2K0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:26:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D6199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:26:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40566f8a093so108719545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695983164; x=1696587964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TgAhQ7loPfu5pVSaMSiEnd8fpas0xpb8Yo7jiaQJmVA=;
        b=ehM/ZJIVYMQUGGmqQCAupCzI0dmPLwiieT/mZ3roAWx2eIIivbBg3L8snsRqdBr3Xz
         asBXwuPZ/9qaJq3PE8Fh9MauH1PU+WPq7JdsjhDn5/EIkX2PAN6B9kAEjq7MNMiB5Rt2
         on6v7U22QIuLI1o6bJthOTBZg1nmFx8O2jCiXRlPxPmsl4SWlQC70INLdNlyyyOS+p9x
         /qSxpJtM7lE0Sa9J7O/a6WH2VWIx/vIWRreUmaX4NHnElaRhEbtPKlMFXzz/OcMhH6a9
         a95p4WJiJ53raDdGqLWXoE0xexAI3vTZ71/PTGzv5SrD+heBKf/OVSrr+CLgNdI55kVw
         MX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695983164; x=1696587964;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgAhQ7loPfu5pVSaMSiEnd8fpas0xpb8Yo7jiaQJmVA=;
        b=aCwvT6vX4DEqNmW4BZFrBN1fJ4jbs8o4Wp4nFPBIl9MefGdaJm5J3KdWk9gIFKlp/7
         f+AKAuEE2hug/W8Cj245D+2LdlsUbWHUVi4DjFSmJeaSMXfNseQ9AYYaF85NaD1TWaig
         ZzneBUiDEI7yAJOYnCMC0bKjR/48Sw/hl5CaohSyWntgZfp0oVEY6lzKHg8jaYSKndcG
         KEfUEscThyweHPTLVxptruhNOHRXP2ObKA6QyL4E2X5z9m7FoDcJKkr70jVqmYc2ArOb
         suxgL8FTqhqyjY1CD621i2aL5cJNGSuSb16eDnGMZIBhLkwaRScEYp11koQqawmhn7s8
         d4NQ==
X-Gm-Message-State: AOJu0YxQ8EXQm9SlKCKpadqnhHF4aMvEZMeMfCU1Th+1+I/b56O8UEVf
        8YCmO5BwxMnHh424aWABblcw1JP2Pao=
X-Google-Smtp-Source: AGHT+IHhAh27jONKvyK71PYWJmsTs4FcnpqxjsLyNZieJqxZn6MmpYeU7rOHccciUvd2jSonE3W6SA==
X-Received: by 2002:a05:600c:2146:b0:405:458d:d54 with SMTP id v6-20020a05600c214600b00405458d0d54mr3480855wml.33.1695983163869;
        Fri, 29 Sep 2023 03:26:03 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003fe2b081661sm1107623wmi.30.2023.09.29.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 03:26:03 -0700 (PDT)
Message-ID: <6516a63b.050a0220.6ed0b.358d@mx.google.com>
X-Google-Original-Message-ID: <ZRamOLghapRPf4T2@Ansuel-xps.>
Date:   Fri, 29 Sep 2023 12:26:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array
 subscript 17 is above array bounds of 'char[16]'
References: <202309192035.GTJEEbem-lkp@intel.com>
 <6512163f.5d0a0220.e4212.8150@mx.google.com>
 <ZRQ/xt1FFJ5k0G8w@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQ/xt1FFJ5k0G8w@rli9-mobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:44:22PM +0800, Philip Li wrote:
> On Tue, Sep 26, 2023 at 01:22:35AM +0200, Christian Marangi wrote:
> > On Tue, Sep 19, 2023 at 08:21:03PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   2cf0f715623872823a72e451243bbf555d10d032
> > > commit: 28a6a2ef18ad840a390d519840c303b03040961c leds: trigger: netdev: refactor code setting device name
> > > date:   4 months ago
> > > config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309192035.GTJEEbem-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    drivers/leds/trigger/ledtrig-netdev.c: In function 'set_device_name':
> > > >> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
> > >      120 |         trigger_data->device_name[size] = 0;
> > >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
> > >       48 |         char device_name[IFNAMSIZ];
> > >          |              ^~~~~~~~~~~
> > > >> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
> > >      120 |         trigger_data->device_name[size] = 0;
> > >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
> > >       48 |         char device_name[IFNAMSIZ];
> > >          |              ^~~~~~~~~~~
> > > 
> > > 
> > > vim +120 drivers/leds/trigger/ledtrig-netdev.c
> > > 
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  106  
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  107  static int set_device_name(struct led_netdev_data *trigger_data,
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  108  			   const char *name, size_t size)
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  109  {
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  110  	cancel_delayed_work_sync(&trigger_data->work);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  111  
> > > d1b9e1391ab2dc Christian Marangi 2023-04-19  112  	mutex_lock(&trigger_data->lock);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  113  
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  114  	if (trigger_data->net_dev) {
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  115  		dev_put(trigger_data->net_dev);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  116  		trigger_data->net_dev = NULL;
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  117  	}
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  118  
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  119  	memcpy(trigger_data->device_name, name, size);
> > > 909346433064b8 Rasmus Villemoes  2019-03-14 @120  	trigger_data->device_name[size] = 0;
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  121  	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  122  		trigger_data->device_name[size - 1] = 0;
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  123  
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  124  	if (trigger_data->device_name[0] != 0)
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  125  		trigger_data->net_dev =
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  126  		    dev_get_by_name(&init_net, trigger_data->device_name);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  127  
> > > e2f24cb1b5daf9 Christian Marangi 2023-04-19  128  	trigger_data->carrier_link_up = false;
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  129  	if (trigger_data->net_dev != NULL)
> > > e2f24cb1b5daf9 Christian Marangi 2023-04-19  130  		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  131  
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  132  	trigger_data->last_activity = 0;
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  133  
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  134  	set_baseline_state(trigger_data);
> > > d1b9e1391ab2dc Christian Marangi 2023-04-19  135  	mutex_unlock(&trigger_data->lock);
> > > 06f502f57d0d77 Ben Whitten       2017-12-10  136  
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  137  	return 0;
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  138  }
> > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  139  
> > > 
> > > :::::: The code at line 120 was first introduced by commit
> > > :::::: 909346433064b8d840dc82af26161926b8d37558 leds: trigger: netdev: use memcpy in device_name_store
> > > 
> > > :::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > :::::: CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
> > Can't repro so I guess this was a false-positive that got fixed? (I used
> > the repro commands and doesn't print any error)
> 
> Hi Ansuel, the issue requires to build with -Warray-bounds flag. We will fix
> the reproduce steps in earliest time. Sorry for the inconvenience.
> 

Hi again, happy to help you further.

By adding the flag I still can't repro.
I'm using this command.
COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/bin/make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/leds/trigger/  -Warray-bounds

Also on top of that I can see that only ledtrig-audio is compiled.
From what I can see using olddefconfig won't actually use the config
used by the bot.

By manually adding the config of the bot to the build_dir ledtrig-netdev
is correctly compiled and still no warning about this.

I'm here to any test needed to improve the repro instructions.

-- 
	Ansuel
