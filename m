Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161080213F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjLCGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:23:15 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCCE3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:23:21 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fab887fab8so1617195fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 22:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701584600; x=1702189400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFZVSy/mDE5jVuc8vRPPNuE4Bl9VhCOmG3KA5XneZoA=;
        b=V2bG5XNFbUweilbkpBxuPD+htNU42SLofRXSSXrLy1mjwk5aV5dS17O315TkUu7hBt
         Y+pLC1KjvXZMiG/DC150Qk0QUR6pWHaNWmK7ymjsIi03KljRe2QJ0KBKoRMG9QqNN619
         Ca3qZ8HhN6eKz2eoQnpJQlEzf7ZH7eY3NudV2nWJMnveiJbedrVRGcDjodjSgPp7dnn2
         RpsBqYjCotUCkKclZ2KbkLljJljFwYna8Jyz6/SKAaIhwY7tIWg/9yhhvuWmupdK1EFo
         tKUJr7kd4cQjTIB1z0XYR1jIyh78D87L5HIskeoWZmPaoOMLKk7sVHkyZOk7xrdYkw9w
         bwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701584600; x=1702189400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFZVSy/mDE5jVuc8vRPPNuE4Bl9VhCOmG3KA5XneZoA=;
        b=DAfGSg3eHdWZklG8I/MVPfIXt2vVXrFXhJwq/3X6KlE4Jy4Btv88Pg4CFb6WS+WDPv
         6JOTtd3DzFgLtB7Iu4YY7eYVy0xgp5ThsDW1wKD8gBfJDUr6+SoCilvsALUi097iizA3
         BRmvPeEAwi80scQ9Lvm9Qanv/Ky8u4/GcgpI+GmbfzoyC0GzKKsdiMgqLn1POkHIw0sG
         dakLlDUwFQByskqftVht8gyT9VHUF2ZNTLzVTB6NdNFhmtCSACRC1h84Ujw6fNEPz7Z2
         qlAI4Vl25x0ZvxI+SKTrfENMi1csWv5Uzd4t0dJvFPu6ndBR+xl44DJ3wc4zU76dfYcf
         2e0g==
X-Gm-Message-State: AOJu0YxS47ViANDM8N8/oxgMfIdXQoYRfvCdh+prEfC2A0/6TqkyYMr6
        0Lcqrt3mBuhr4fEk1hPgfwM=
X-Google-Smtp-Source: AGHT+IFVAjUvehoCGg+BRJsQoJfSWyjs9qnxcnOt0ZbDSr7QOtaVFqlBA26ydggUnhjUw8Gqg/1lJg==
X-Received: by 2002:a05:6871:5a8a:b0:1fb:75c:3ffd with SMTP id oo10-20020a0568715a8a00b001fb075c3ffdmr3435970oac.93.1701584599755;
        Sat, 02 Dec 2023 22:23:19 -0800 (PST)
Received: from google.com ([2601:647:5e00:4acd:998a:3f6b:ae8:65b5])
        by smtp.gmail.com with ESMTPSA id c22-20020a63da16000000b005b92d3cb4c2sm5799328pgh.58.2023.12.02.22.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:23:19 -0800 (PST)
Date:   Sun, 3 Dec 2023 06:23:16 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/input/touchscreen/egalax_ts_serial.c:116:21: warning:
 '/input0' directive output may be truncated writing 7 bytes into a region of
 size between 1 and 32
Message-ID: <ZWwe1DJ7gBdOUHwY@google.com>
References: <202312021646.cwwvptuB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202312021646.cwwvptuB-lkp@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 02:07:07PM +0800, kernel test robot wrote:
> Hi Böszörményi,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
> commit: 6b0f8f9c52efe24d6dac06ab963b7bd91c723751 Input: add eGalaxTouch serial touchscreen driver
> date:   8 years ago
> config: x86_64-randconfig-r032-20230515 (https://download.01.org/0day-ci/archive/20231202/202312021646.cwwvptuB-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312021646.cwwvptuB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312021646.cwwvptuB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kobject.h:21,
>                     from include/linux/module.h:17,
>                     from drivers/input/touchscreen/egalax_ts_serial.c:19:
>    include/linux/sysfs.h: In function 'sysfs_get_dirent':
>    include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
>      517 |         return kernfs_find_and_get(parent, name);
>          |                                            ^~~~
>          |                                            |
>          |                                            const unsigned char *
>    In file included from include/linux/sysfs.h:15:
>    include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
>      428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
>          |                                             ~~~~~~~~~~~~^~~~
>    drivers/input/touchscreen/egalax_ts_serial.c: In function 'egalax_connect':
> >> drivers/input/touchscreen/egalax_ts_serial.c:116:21: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
>      116 |                  "%s/input0", serio->phys);

Please stop using -Wformat-truncation and report warnings as errors.
This particular warning is disabled in normal builds and the truncation
is desired outcome here.

Thanks.

-- 
Dmitry
