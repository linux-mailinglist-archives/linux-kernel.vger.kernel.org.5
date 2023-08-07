Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A9772FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHGTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHGTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:53:04 -0400
X-Greylist: delayed 1109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 12:53:03 PDT
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D461E7F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:53:03 -0700 (PDT)
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1qT603-006bGM-IH; Mon, 07 Aug 2023 20:34:44 +0100
Date:   Mon, 7 Aug 2023 20:34:21 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: drivers/iio/light/opt4001.c:215:9: error: call to
 '__compiletime_assert_355' declared with 'error' attribute: FIELD_PREP:
 value too large for the field
Message-ID: <20230807203421.4b62f931@jic23-huawei>
In-Reply-To: <202308061902.0gVz6bSe-lkp@intel.com>
References: <202308061902.0gVz6bSe-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2023 20:00:10 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f0ab9f34e59e0c01a1c31142e0b336245367fd86
> commit: 9a9608418292bb8733805c3f3123dfe0454fadac iio: light: Add support for TI OPT4001 light sensor
> date:   3 months ago
> config: s390-randconfig-r034-20230806 (https://download.01.org/0day-ci/archive/20230806/202308061902.0gVz6bSe-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230806/202308061902.0gVz6bSe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308061902.0gVz6bSe-lkp@intel.com/
> 	
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/iio/light/opt4001.c:16:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>      102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>          |                                                      ^
>    In file included from drivers/iio/light/opt4001.c:16:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>      115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>          |                                                      ^
>    In file included from drivers/iio/light/opt4001.c:16:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      584 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      692 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      700 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      708 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      717 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      726 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      735 |         writesl(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
> >> drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_355' declared with 'error' attribute: FIELD_PREP: value too large for the field  
>      215 |         reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);
>          |                ^
>    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
>      114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>          |                 ^
>    include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
>       68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>          |                 ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^
>    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:385:2: note: expanded from macro '_compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:378:4: note: expanded from macro '__compiletime_assert'
>      378 |                         prefix ## suffix();                             \
>          |                         ^
>    <scratch space>:55:1: note: expanded from here
>       55 | __compiletime_assert_355
>          | ^
>    12 warnings and 1 error generated.
> 
> 
> vim +215 drivers/iio/light/opt4001.c
> 
>    207	
>    208	static int opt4001_set_conf(struct opt4001_chip *chip)
>    209	{
>    210		struct device *dev = &chip->client->dev;
>    211		u16 reg;
>    212		int ret;
>    213	
>    214		reg = FIELD_PREP(OPT4001_CTRL_RANGE_MASK, OPT4001_CTRL_LIGHT_SCALE_AUTO);
>  > 215		reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);  
>    216		reg |= FIELD_PREP(OPT4001_CTRL_OPER_MODE_MASK, OPT4001_CTRL_OPER_MODE_CONTINUOUS);
>    217	
>    218		ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
>    219		if (ret)
>    220			dev_err(dev, "Failed to set configuration\n");
>    221	
>    222		return ret;
>    223	}
>    224	

This took me a few mins to conjecture what it might be finding.
I think it's managing to spot the missing divide by 2 in here which ends up in int_time
and could potentially go as high as 21 - overflowing the field,

static int opt4001_als_time_to_index(const u32 als_integration_time)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available); i++) {
		if (als_integration_time == opt4001_int_time_available[i][1])
			return i;
	}

	return -EINVAL;
}

ARRAY_SIZE is applied to an Nx2 array so that should be ARRAY_SIZE()/2 to index over just
the first dimension as intended.  I'll send a patch shortly once I've checked with the
reproducer.  It's a bug either way (I think!)

Jonathan



> 

