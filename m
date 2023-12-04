Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118AA802AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjLDEkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjLDEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:40:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E392
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 20:40:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33330305372so2387064f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 20:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701664812; x=1702269612; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7q5G2KknbcCBX38jRrjfi6bGriuiAOVeE6vCr3ghSGw=;
        b=l9F4kU4iwAtXsfQDfLCbr3p5dD01gfFd3pQjNCUrpkpm554awJ3L5lrWYdT8CqOjqN
         QOTugy90MFrjMkUSn6CABABhdYUfS38mAusNUVduhmu/ynyZkKKT0YC1lWuonQKBVccA
         ycTgOxuwAttrCoUKXm2jvXuf6WAJEhdyvR48sV+9FXtaPIlKkvwqtwQOqytNg2lK/Jjx
         +hPOAui4oScg+/p6SJ6unRHD0/sSw+G9H4mO6gTnKrl+Nc4I4FJAvT67Wa0IW6A/+9SX
         iy3Elf1AZVn5ebYvBqadWlp2NS8j1XMecO81HM3V32i4NUP3ctT4hN/Qq7M5VSYnfXDS
         Q0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701664812; x=1702269612;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5G2KknbcCBX38jRrjfi6bGriuiAOVeE6vCr3ghSGw=;
        b=HDPwwwH5yDF7Qx80jlQn3T64ozQ4Ly+bYjC5g3ZMz4FO78ESXd4E+1Jfiyaa/uMcw8
         4ox0siFE7RQgIKkWT8nFI42eKT03ZM5U5H53C+jhY2Otwdd4eEGbmK9WeLJd4OqGRgaU
         Hv1WGCujByyJ5QuC//ymaauvH3dFenCNCNAGu7DX+04GIDlRozznIUGa/IbXltZfyelC
         3zSF/nX2hR71vKUVUfPBj+lDeLGCL7c0V2H2r/e/X2A1id9DwteoQT88t2EId5VFGV2P
         G0EkmkEvCfUQAt/4H+KAheWR1mQ/S0NlGfHVludS8a9mdZIUJQgqM7VRINU0Nez5JTtg
         SHxw==
X-Gm-Message-State: AOJu0YxcH/UTKtN4ZWUHjTjsFx1FfRnTMl6f1b26rg2HvftAXKY8vyAN
        0qjZhBMw2ZEfPD8AKlxX3qCV7m5riXfyYT4O44E=
X-Google-Smtp-Source: AGHT+IGIPkjX0Mimhpi7bOnIb6Uggha41uqwpjIgxyxM9rwGZZxxzeMtmpsZ8E/b0f+bDXZ1sm0UcQ==
X-Received: by 2002:a05:6000:4f0:b0:333:3f5d:63d2 with SMTP id cr16-20020a05600004f000b003333f5d63d2mr1265974wrb.3.1701664812619;
        Sun, 03 Dec 2023 20:40:12 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l13-20020adffe8d000000b0033342978c93sm3083094wrr.30.2023.12.03.20.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 20:40:12 -0800 (PST)
Date:   Mon, 4 Dec 2023 07:40:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/mv88e6xxx/chip.c:245 mv88e6xxx_default_mdio_bus()
 warn: can 'mdio_bus' even be NULL?
Message-ID: <80166d2f-d877-4db8-ab55-d7d7243969b7@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: a3c53be55c955b7150cda17874c3fcb4eeb97a89 net: dsa: mv88e6xxx: Support multiple MDIO busses
config: i386-randconfig-141-20231010 (https://download.01.org/0day-ci/archive/20231203/202312030131.Vl3CGtDZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312030131.Vl3CGtDZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312030131.Vl3CGtDZ-lkp@intel.com/

New smatch warnings:
drivers/net/dsa/mv88e6xxx/chip.c:245 mv88e6xxx_default_mdio_bus() warn: can 'mdio_bus' even be NULL?

vim +/mdio_bus +245 drivers/net/dsa/mv88e6xxx/chip.c

a3c53be55c955b Andrew Lunn 2017-01-24  239  static struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
a3c53be55c955b Andrew Lunn 2017-01-24  240  {
a3c53be55c955b Andrew Lunn 2017-01-24  241  	struct mv88e6xxx_mdio_bus *mdio_bus;
a3c53be55c955b Andrew Lunn 2017-01-24  242  
a3c53be55c955b Andrew Lunn 2017-01-24  243  	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
a3c53be55c955b Andrew Lunn 2017-01-24  244  				    list);
a3c53be55c955b Andrew Lunn 2017-01-24 @245  	if (!mdio_bus)

Why is kbuild-bot complaining about 7 year old code?  Anyway, the check
is wrong.  Was list_first_entry_or_null() intended?

a3c53be55c955b Andrew Lunn 2017-01-24  246  		return NULL;
a3c53be55c955b Andrew Lunn 2017-01-24  247  
a3c53be55c955b Andrew Lunn 2017-01-24  248  	return mdio_bus->bus;
a3c53be55c955b Andrew Lunn 2017-01-24  249  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

