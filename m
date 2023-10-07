Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9A7BC7F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjJGNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbjJGNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:15:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1DB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 06:15:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso29649945e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696684542; x=1697289342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKBgn0nvuuvymZsKWtuHpV8zil9Djtki/7QOK92nu6A=;
        b=GtASbTSO43wu+pz99Ax8IfeYfqyCWETYm0INCoeoRi3erf6szktXEKzHraHIA8wNk1
         +GF71IfWg770e6flCCPBdPaAhJiV8+2puWHv1fWdlQfjTrj4V//cvF7shTbhnpohk/8h
         IyyK53IsYOPoD9NHSkDmtRt2dnmuupdO93gYPzQAuE6E9Vkdi2bgAVBmgoOjCVTwN++O
         3dujPdPUEOTE9Dw6A+NVp5XtFlTqoMV4eu/ivNkjSX9k782hbU4fpFpVPz1yWz/TFlNw
         ckXfQL/vagVpczZMSImr3/p1ZLHq8uhN18pgY96QnBdJjArTBvC/VpmR0aNpYBcvPcX8
         dejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696684542; x=1697289342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKBgn0nvuuvymZsKWtuHpV8zil9Djtki/7QOK92nu6A=;
        b=DJ0uuFN7QIPOF5g448q/sDhW4VNJ+tI9cydnWKzT9aUBbaGaexDcJ3OPpA6BmqICRK
         FUzc8pxkHPX+u9oECtIgDkz2P9vq3bkhrag4wg/WY0ZNOznDPlPPU3Sm8ogZDtITvja7
         4QbUFOsd5cKqdSHWRT4+VH6U2xFIYdJ9xyz+3Um7bPIDf+DVmwE0zz3K8aKJEzz+u/KP
         njFaaqA8XtOgSJc/Lp526tdDc6hnhr4ESTsSip4ouItFRVqRXxLtQC+ifUdr6Vio3PEi
         K7s+651BD7/g4eSTlaRFO+i0H0XQsU5vbKGu+Lc4R3sMZ0XAGTEmAUcQ87YAzkxbhpUy
         x7pw==
X-Gm-Message-State: AOJu0Yy0Mvk0iQu21RQQWGjJMbPRw63QuO3dH15sqZ8SV+12EVPbN2FT
        AcWnB3OGLrqDgnMOhptvJ/1/d43VWNk=
X-Google-Smtp-Source: AGHT+IErO+MDH0rugoDbL1SCA0F2Gkm2C0hlv4v/qPFicZdj2gLucCSY8vDgFQr4bsAZmluZizlIKw==
X-Received: by 2002:a05:600c:3657:b0:401:b0f2:88c1 with SMTP id y23-20020a05600c365700b00401b0f288c1mr10076380wmq.29.1696684541887;
        Sat, 07 Oct 2023 06:15:41 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b00405959bbf4fsm6170201wmb.19.2023.10.07.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 06:15:41 -0700 (PDT)
Message-ID: <652159fd.050a0220.141f8.cba3@mx.google.com>
X-Google-Original-Message-ID: <ZSFZ+3sJqYdEYhC/@Ansuel-xps.>
Date:   Sat, 7 Oct 2023 15:15:39 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     "Li, Philip" <philip.li@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array
 subscript 17 is above array bounds of 'char[16]'
References: <202309192035.GTJEEbem-lkp@intel.com>
 <6512163f.5d0a0220.e4212.8150@mx.google.com>
 <ZRQ/xt1FFJ5k0G8w@rli9-mobl>
 <6516a63b.050a0220.6ed0b.358d@mx.google.com>
 <aef19b63cfd505a1527dae705bc222ba808623de.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aef19b63cfd505a1527dae705bc222ba808623de.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 07:17:16AM +0000, Liu, Yujie wrote:
> On Fri, 2023-09-29 at 12:26 +0200, Christian Marangi wrote:
> > On Wed, Sep 27, 2023 at 10:44:22PM +0800, Philip Li wrote:
> > > On Tue, Sep 26, 2023 at 01:22:35AM +0200, Christian Marangi wrote:
> > > > On Tue, Sep 19, 2023 at 08:21:03PM +0800, kernel test robot
> > > > wrote:
> > > > > tree:  
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > >  master
> > > > > head:   2cf0f715623872823a72e451243bbf555d10d032
> > > > > commit: 28a6a2ef18ad840a390d519840c303b03040961c leds: trigger:
> > > > > netdev: refactor code setting device name
> > > > > date:   4 months ago
> > > > > config: loongarch-allmodconfig
> > > > > (https://download.01.org/0day-ci/archive/20230919/202309192035
> > > > > .GTJEEbem-lkp@intel.com/config)
> > > > > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > > > > reproduce (this is a W=1 build):
> > > > > (https://download.01.org/0day-ci/archive/20230919/202309192035
> > > > > .GTJEEbem-lkp@intel.com/reproduce)
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just
> > > > > a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Closes:
> > > > > > https://lore.kernel.org/oe-kbuild-all/202309192035.GTJEEbem-lkp@intel.com/
> > > > > 
> > > > > All warnings (new ones prefixed by >>):
> > > > > 
> > > > >    drivers/leds/trigger/ledtrig-netdev.c: In function
> > > > > 'set_device_name':
> > > > > > > drivers/leds/trigger/ledtrig-netdev.c:120:34: warning:
> > > > > > > array subscript 17 is above array bounds of 'char[16]' [-
> > > > > > > Warray-bounds=]
> > > > >      120 |         trigger_data->device_name[size] = 0;
> > > > >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > > > >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while
> > > > > referencing 'device_name'
> > > > >       48 |         char device_name[IFNAMSIZ];
> > > > >          |              ^~~~~~~~~~~
> > > > > > > drivers/leds/trigger/ledtrig-netdev.c:120:34: warning:
> > > > > > > array subscript 17 is above array bounds of 'char[16]' [-
> > > > > > > Warray-bounds=]
> > > > >      120 |         trigger_data->device_name[size] = 0;
> > > > >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > > > >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while
> > > > > referencing 'device_name'
> > > > >       48 |         char device_name[IFNAMSIZ];
> > > > >          |              ^~~~~~~~~~~
> > > > > 
> > > > > 
> > > > > vim +120 drivers/leds/trigger/ledtrig-netdev.c
> > > > > 
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  106  
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  107  static int
> > > > > set_device_name(struct led_netdev_data *trigger_data,
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29 
> > > > > 108                           const char *name, size_t size)
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  109  {
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 110        cancel_delayed_work_sync(&trigger_data->work);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  111  
> > > > > d1b9e1391ab2dc Christian Marangi 2023-04-19 
> > > > > 112        mutex_lock(&trigger_data->lock);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  113  
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  114        if
> > > > > (trigger_data->net_dev) {
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 115                dev_put(trigger_data->net_dev);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 116                trigger_data->net_dev = NULL;
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  117        }
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  118  
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29 
> > > > > 119        memcpy(trigger_data->device_name, name, size);
> > > > > 909346433064b8 Rasmus Villemoes  2019-03-14
> > > > > @120        trigger_data->device_name[size] = 0;
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  121        if
> > > > > (size > 0 && trigger_data->device_name[size - 1] == '\n')
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 122                trigger_data->device_name[size - 1] = 0;
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  123  
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  124        if
> > > > > (trigger_data->device_name[0] != 0)
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 125                trigger_data->net_dev =
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 126                    dev_get_by_name(&init_net, trigger_data-
> > > > > >device_name);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  127  
> > > > > e2f24cb1b5daf9 Christian Marangi 2023-04-19 
> > > > > 128        trigger_data->carrier_link_up = false;
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  129        if
> > > > > (trigger_data->net_dev != NULL)
> > > > > e2f24cb1b5daf9 Christian Marangi 2023-04-19 
> > > > > 130                trigger_data->carrier_link_up =
> > > > > netif_carrier_ok(trigger_data->net_dev);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  131  
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 132        trigger_data->last_activity = 0;
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  133  
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10 
> > > > > 134        set_baseline_state(trigger_data);
> > > > > d1b9e1391ab2dc Christian Marangi 2023-04-19 
> > > > > 135        mutex_unlock(&trigger_data->lock);
> > > > > 06f502f57d0d77 Ben Whitten       2017-12-10  136  
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  137        return
> > > > > 0;
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  138  }
> > > > > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  139  
> > > > > 
> > > > > :::::: The code at line 120 was first introduced by commit
> > > > > :::::: 909346433064b8d840dc82af26161926b8d37558 leds: trigger:
> > > > > netdev: use memcpy in device_name_store
> > > > > 
> > > > > :::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > > :::::: CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > > > > 
> > > > > -- 
> > > > > 0-DAY CI Kernel Test Service
> > > > > https://github.com/intel/lkp-tests/wiki
> > > > 
> > > > Can't repro so I guess this was a false-positive that got fixed?
> > > > (I used
> > > > the repro commands and doesn't print any error)
> > > 
> > > Hi Ansuel, the issue requires to build with -Warray-bounds flag. We
> > > will fix
> > > the reproduce steps in earliest time. Sorry for the inconvenience.
> > > 
> > 
> > Hi again, happy to help you further.
> > 
> > By adding the flag I still can't repro.
> > I'm using this command.
> > COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/bin/make.cross
> > W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/leds/trigger/ 
> > -Warray-bounds
> 
> Hi Ansuel, we added some extra compiler flags recently but the repro
> steps were not updated in time. Sorry for this.
> 
> Could you please have a try with the following command? (append
> KCFLAGS="-Warray-bounds" at the end)
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/bin/make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/leds/trigger/ KCFLAGS="-Warray-bounds"
>

Can confirm this worked! (also sent patch upstream)

May I suggest some improvement to the repro script?

I would add some instruction on the cleanup... A simple rm -rf with all
the toolchain and directory downloaded may be useful.

Also some reference on the config to download to exactly repro the
error? If someone doesn't download the config from the mail, the default
kernel config for the ARCH is used and the bug is not repro.

I know these are all steps that a kernel dev should already know but
since we are giving instructions, it might not be a bad idea to include
every required step.

> > Also on top of that I can see that only ledtrig-audio is compiled.
> > From what I can see using olddefconfig won't actually use the config
> > used by the bot.
> 
> The original config used by the bot can be obtained by:
> 
> $ wget
> https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/config
> -O build_dir/.config
> 
> "make olddefconfig" is for refreshing it to resolve potential config
> dependencies.
> 

-- 
	Ansuel
