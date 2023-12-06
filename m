Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1D8065A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376393AbjLFD2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLFD2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:28:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10E1AA;
        Tue,  5 Dec 2023 19:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701833313; x=1733369313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i9MHb5U6e3TzYWbb2CrJBDckRhv25cfoZYj3PzWoVU0=;
  b=J1M58YlSQ92nGIa50FIwzOCkChbjZXCCpSI4z/7/JJqXj1ZnanRHxmTt
   tnsVo8xRub0efwMqLgSiBWu2bF8AsovRYlhCkYge6PaT+/6PxHFW11MY2
   C0gMOTSmzJY4Oz0zivEt94LJDo5P3SLP/m4D7uao+208KvfTbx5CLDghb
   JmQAIr1eK4ScX8y9iU4wJN1XXxOHn0VaPsk45/lnbjK5pCyfZGbnwBzGy
   25eiqSMHTdSruPXLC8znnDHgpAcOJNYYXy2QPlUZ2eLDPQY4xQ5Kw/1Py
   GTnc/01fFUuQBKi0fNGHoLewxUay+8vTmJWf3nhE4PuthFNin+mQJp5eP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374183166"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="374183166"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 19:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018431548"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018431548"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 19:28:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAiaI-000AAa-2u;
        Wed, 06 Dec 2023 03:28:26 +0000
Date:   Wed, 6 Dec 2023 11:27:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
Message-ID: <202312061130.xSPDblkL-lkp@intel.com>
References: <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Théo,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-linus]
[also build test ERROR on usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.7-rc4 next-20231205]
[cannot apply to tty/tty-testing tty/tty-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Th-o-Lebrun/tty-serial-amba-Use-linux-bits-bitfield-h-macros/20231130-230738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
patch link:    https://lore.kernel.org/r/20231130-mbly-uart-v5-2-6566703a04b5%40bootlin.com
patch subject: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h macros
config: arm-ep93xx_defconfig (https://download.01.org/0day-ci/archive/20231206/202312061130.xSPDblkL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061130.xSPDblkL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061130.xSPDblkL-lkp@intel.com/

All errors (new ones prefixed by >>):

   include/linux/stddef.h: Assembler messages:
>> include/linux/stddef.h:10: Error: bad instruction `enum {'
>> include/linux/stddef.h:11: Error: junk at end of line, first unrecognized character is `,'
   include/linux/stddef.h:13: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/uapi/asm/swab.h:28: Error: bad instruction `static inline __attribute_const__ __u32 __arch_swab32(__u32 x)'
>> arch/arm/include/uapi/asm/swab.h:29: Error: junk at end of line, first unrecognized character is `{'
>> arch/arm/include/uapi/asm/swab.h:30: Error: bad instruction `__u32 t'
>> arch/arm/include/uapi/asm/swab.h:33: Error: bad instruction `if (!__builtin_constant_p(x)){'
>> arch/arm/include/uapi/asm/swab.h:39: Error: bad instruction `asm ("eor\t%0, %1, %1, ror #16":"=r"(t):"r"(x))'
   arch/arm/include/uapi/asm/swab.h:40: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/uapi/asm/swab.h:45: Error: bad instruction `t &=~0x00FF0000'
>> arch/arm/include/uapi/asm/swab.h:46: Error: bad instruction `x ^=(t>>8)'
>> arch/arm/include/uapi/asm/swab.h:48: Error: bad instruction `return x'
   arch/arm/include/uapi/asm/swab.h:49: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:48: Error: bad instruction `static inline __attribute_const__ __u16 __fswab16(__u16 val)'
>> include/uapi/linux/swab.h:49: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:53: Error: bad instruction `return ((__u16)((((__u16)(val)&(__u16)0x00ffU)<<8)|(((__u16)(val)&(__u16)0xff00U)>>8)))'
   include/uapi/linux/swab.h:55: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:57: Error: bad instruction `static inline __attribute_const__ __u32 __fswab32(__u32 val)'
   include/uapi/linux/swab.h:58: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:60: Error: bad instruction `return __arch_swab32(val)'
   include/uapi/linux/swab.h:64: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:66: Error: bad instruction `static inline __attribute_const__ __u64 __fswab64(__u64 val)'
   include/uapi/linux/swab.h:67: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:71: Error: bad instruction `__u32 h=val>>32'
>> include/uapi/linux/swab.h:72: Error: bad instruction `__u32 l=val&((1ULL<<32)-1)'
>> include/uapi/linux/swab.h:73: Error: bad instruction `return (((__u64)__fswab32(l))<<32)|((__u64)(__fswab32(h)))'
   include/uapi/linux/swab.h:77: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:79: Error: bad instruction `static inline __attribute_const__ __u32 __fswahw32(__u32 val)'
   include/uapi/linux/swab.h:80: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:84: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x0000ffffUL)<<16)|(((__u32)(val)&(__u32)0xffff0000UL)>>16)))'
   include/uapi/linux/swab.h:86: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:88: Error: bad instruction `static inline __attribute_const__ __u32 __fswahb32(__u32 val)'
   include/uapi/linux/swab.h:89: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:93: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(val)&(__u32)0xff00ff00UL)>>8)))'
   include/uapi/linux/swab.h:95: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:136: Error: bad instruction `static inline unsigned long __swab(const unsigned long y)'
   include/uapi/linux/swab.h:137: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:141: Error: bad instruction `return (__u32)(__builtin_constant_p(y)?((__u32)((((__u32)(y)&(__u32)0x000000ffUL)<<24)|(((__u32)(y)&(__u32)0x0000ff00UL)<<8)|(((__u32)(y)&(__u32)0x00ff0000UL)>>8)|(((__u32)(y)&(__u32)0xff000000UL)>>24))):__fswab32(y))'
   include/uapi/linux/swab.h:143: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:171: Error: bad instruction `static inline __u16 __swab16p(const __u16*p)'
   include/uapi/linux/swab.h:172: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:176: Error: bad instruction `return (__u16)(__builtin_constant_p(*p)?((__u16)((((__u16)(*p)&(__u16)0x00ffU)<<8)|(((__u16)(*p)&(__u16)0xff00U)>>8))):__fswab16(*p))'
   include/uapi/linux/swab.h:178: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:184: Error: bad instruction `static inline __u32 __swab32p(const __u32*p)'
   include/uapi/linux/swab.h:185: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:189: Error: bad instruction `return (__u32)(__builtin_constant_p(*p)?((__u32)((((__u32)(*p)&(__u32)0x000000ffUL)<<24)|(((__u32)(*p)&(__u32)0x0000ff00UL)<<8)|(((__u32)(*p)&(__u32)0x00ff0000UL)>>8)|(((__u32)(*p)&(__u32)0xff000000UL)>>24))):__fswab32(*p))'
   include/uapi/linux/swab.h:191: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:197: Error: bad instruction `static inline __u64 __swab64p(const __u64*p)'
   include/uapi/linux/swab.h:198: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:202: Error: bad instruction `return (__u64)(__builtin_constant_p(*p)?((__u64)((((__u64)(*p)&(__u64)0x00000000000000ffULL)<<56)|(((__u64)(*p)&(__u64)0x000000000000ff00ULL)<<40)|(((__u64)(*p)&(__u64)0x0000000000ff0000ULL)<<24)|(((__u64)(*p)&(__u64)0x00000000ff000000ULL)<<8)|(((__u64)(*p)&(__u64)0x000000ff00000000ULL)>>8)|(((__u64)(*p)&(__u64)0x0000ff0000000000ULL)>>24)|(((__u64)(*p)&(__u64)0x00ff000000000000ULL)>>40)|(((__u64)(*p)&(__u64)0xff00000000000000ULL)>>56))):__fswab64(*p))'
   include/uapi/linux/swab.h:204: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:212: Error: bad instruction `static inline __u32 __swahw32p(const __u32*p)'
   include/uapi/linux/swab.h:213: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:217: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x0000ffffUL)<<16)|(((__u32)(*p)&(__u32)0xffff0000UL)>>16))):__fswahw32(*p))'
   include/uapi/linux/swab.h:219: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:227: Error: bad instruction `static inline __u32 __swahb32p(const __u32*p)'
   include/uapi/linux/swab.h:228: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:232: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(*p)&(__u32)0xff00ff00UL)>>8))):__fswahb32(*p))'
   include/uapi/linux/swab.h:234: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:240: Error: bad instruction `static inline void __swab16s(__u16*p)'
   include/uapi/linux/swab.h:241: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:245: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:247: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:252: Error: bad instruction `static inline void __swab32s(__u32*p)'
   include/uapi/linux/swab.h:253: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:257: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:259: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:265: Error: bad instruction `static inline void __swab64s(__u64*p)'
   include/uapi/linux/swab.h:266: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:270: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:272: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:280: Error: bad instruction `static inline void __swahw32s(__u32*p)'
   include/uapi/linux/swab.h:281: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:285: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:287: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:295: Error: bad instruction `static inline void __swahb32s(__u32*p)'
   include/uapi/linux/swab.h:296: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:300: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:302: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:24: Error: bad instruction `static inline void swab16_array(u16*buf,unsigned int words)'
   include/linux/swab.h:25: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:26: Error: bad instruction `while (words--){'
   include/linux/swab.h:27: Error: bad instruction `__swab16s(buf)'
   include/linux/swab.h:28: Error: bad instruction `buf++'
   include/linux/swab.h:29: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:30: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:32: Error: bad instruction `static inline void swab32_array(u32*buf,unsigned int words)'
   include/linux/swab.h:33: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:34: Error: bad instruction `while (words--){'
   include/linux/swab.h:35: Error: bad instruction `__swab32s(buf)'
   include/linux/swab.h:36: Error: bad instruction `buf++'
   include/linux/swab.h:37: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:38: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:40: Error: bad instruction `static inline void swab64_array(u64*buf,unsigned int words)'
   include/linux/swab.h:41: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:42: Error: bad instruction `while (words--){'
   include/linux/swab.h:43: Error: bad instruction `__swab64s(buf)'
   include/linux/swab.h:44: Error: bad instruction `buf++'
   include/linux/swab.h:45: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:46: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:45: Error: bad instruction `static inline __le64 __cpu_to_le64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:46: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:47: Error: bad instruction `return (__force __le64)*p'
   include/uapi/linux/byteorder/little_endian.h:48: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:49: Error: bad instruction `static inline __u64 __le64_to_cpup(const __le64*p)'
   include/uapi/linux/byteorder/little_endian.h:50: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:51: Error: bad instruction `return (__force __u64)*p'
   include/uapi/linux/byteorder/little_endian.h:52: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:53: Error: bad instruction `static inline __le32 __cpu_to_le32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:54: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:55: Error: bad instruction `return (__force __le32)*p'
   include/uapi/linux/byteorder/little_endian.h:56: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:57: Error: bad instruction `static inline __u32 __le32_to_cpup(const __le32*p)'
   include/uapi/linux/byteorder/little_endian.h:58: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:59: Error: bad instruction `return (__force __u32)*p'
   include/uapi/linux/byteorder/little_endian.h:60: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:61: Error: bad instruction `static inline __le16 __cpu_to_le16p(const __u16*p)'
   include/uapi/linux/byteorder/little_endian.h:62: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:63: Error: bad instruction `return (__force __le16)*p'
   include/uapi/linux/byteorder/little_endian.h:64: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:65: Error: bad instruction `static inline __u16 __le16_to_cpup(const __le16*p)'
   include/uapi/linux/byteorder/little_endian.h:66: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:67: Error: bad instruction `return (__force __u16)*p'
   include/uapi/linux/byteorder/little_endian.h:68: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:69: Error: bad instruction `static inline __be64 __cpu_to_be64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:70: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:71: Error: bad instruction `return (__force __be64)__swab64p(p)'
   include/uapi/linux/byteorder/little_endian.h:72: Error: junk at end of line, first unrecognized character is `}'
--
   include/linux/stddef.h: Assembler messages:
>> include/linux/stddef.h:10: Error: bad instruction `enum {'
>> include/linux/stddef.h:11: Error: junk at end of line, first unrecognized character is `,'
   include/linux/stddef.h:13: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/uapi/asm/swab.h:28: Error: bad instruction `static inline __attribute_const__ __u32 __arch_swab32(__u32 x)'
>> arch/arm/include/uapi/asm/swab.h:29: Error: junk at end of line, first unrecognized character is `{'
>> arch/arm/include/uapi/asm/swab.h:30: Error: bad instruction `__u32 t'
>> arch/arm/include/uapi/asm/swab.h:33: Error: bad instruction `if (!__builtin_constant_p(x)){'
>> arch/arm/include/uapi/asm/swab.h:39: Error: bad instruction `asm ("eor\t%0, %1, %1, ror #16":"=r"(t):"r"(x))'
   arch/arm/include/uapi/asm/swab.h:40: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/uapi/asm/swab.h:45: Error: bad instruction `t &=~0x00FF0000'
>> arch/arm/include/uapi/asm/swab.h:46: Error: bad instruction `x ^=(t>>8)'
>> arch/arm/include/uapi/asm/swab.h:48: Error: bad instruction `return x'
   arch/arm/include/uapi/asm/swab.h:49: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:48: Error: bad instruction `static inline __attribute_const__ __u16 __fswab16(__u16 val)'
>> include/uapi/linux/swab.h:49: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:53: Error: bad instruction `return ((__u16)((((__u16)(val)&(__u16)0x00ffU)<<8)|(((__u16)(val)&(__u16)0xff00U)>>8)))'
   include/uapi/linux/swab.h:55: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:57: Error: bad instruction `static inline __attribute_const__ __u32 __fswab32(__u32 val)'
   include/uapi/linux/swab.h:58: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:60: Error: bad instruction `return __arch_swab32(val)'
   include/uapi/linux/swab.h:64: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:66: Error: bad instruction `static inline __attribute_const__ __u64 __fswab64(__u64 val)'
   include/uapi/linux/swab.h:67: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/swab.h:71: Error: bad instruction `__u32 h=val>>32'
>> include/uapi/linux/swab.h:72: Error: bad instruction `__u32 l=val&((1ULL<<32)-1)'
>> include/uapi/linux/swab.h:73: Error: bad instruction `return (((__u64)__fswab32(l))<<32)|((__u64)(__fswab32(h)))'
   include/uapi/linux/swab.h:77: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/swab.h:79: Error: bad instruction `static inline __attribute_const__ __u32 __fswahw32(__u32 val)'
   include/uapi/linux/swab.h:80: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:84: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x0000ffffUL)<<16)|(((__u32)(val)&(__u32)0xffff0000UL)>>16)))'
   include/uapi/linux/swab.h:86: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:88: Error: bad instruction `static inline __attribute_const__ __u32 __fswahb32(__u32 val)'
   include/uapi/linux/swab.h:89: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:93: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(val)&(__u32)0xff00ff00UL)>>8)))'
   include/uapi/linux/swab.h:95: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:136: Error: bad instruction `static inline unsigned long __swab(const unsigned long y)'
   include/uapi/linux/swab.h:137: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:141: Error: bad instruction `return (__u32)(__builtin_constant_p(y)?((__u32)((((__u32)(y)&(__u32)0x000000ffUL)<<24)|(((__u32)(y)&(__u32)0x0000ff00UL)<<8)|(((__u32)(y)&(__u32)0x00ff0000UL)>>8)|(((__u32)(y)&(__u32)0xff000000UL)>>24))):__fswab32(y))'
   include/uapi/linux/swab.h:143: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:171: Error: bad instruction `static inline __u16 __swab16p(const __u16*p)'
   include/uapi/linux/swab.h:172: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:176: Error: bad instruction `return (__u16)(__builtin_constant_p(*p)?((__u16)((((__u16)(*p)&(__u16)0x00ffU)<<8)|(((__u16)(*p)&(__u16)0xff00U)>>8))):__fswab16(*p))'
   include/uapi/linux/swab.h:178: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:184: Error: bad instruction `static inline __u32 __swab32p(const __u32*p)'
   include/uapi/linux/swab.h:185: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:189: Error: bad instruction `return (__u32)(__builtin_constant_p(*p)?((__u32)((((__u32)(*p)&(__u32)0x000000ffUL)<<24)|(((__u32)(*p)&(__u32)0x0000ff00UL)<<8)|(((__u32)(*p)&(__u32)0x00ff0000UL)>>8)|(((__u32)(*p)&(__u32)0xff000000UL)>>24))):__fswab32(*p))'
   include/uapi/linux/swab.h:191: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:197: Error: bad instruction `static inline __u64 __swab64p(const __u64*p)'
   include/uapi/linux/swab.h:198: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:202: Error: bad instruction `return (__u64)(__builtin_constant_p(*p)?((__u64)((((__u64)(*p)&(__u64)0x00000000000000ffULL)<<56)|(((__u64)(*p)&(__u64)0x000000000000ff00ULL)<<40)|(((__u64)(*p)&(__u64)0x0000000000ff0000ULL)<<24)|(((__u64)(*p)&(__u64)0x00000000ff000000ULL)<<8)|(((__u64)(*p)&(__u64)0x000000ff00000000ULL)>>8)|(((__u64)(*p)&(__u64)0x0000ff0000000000ULL)>>24)|(((__u64)(*p)&(__u64)0x00ff000000000000ULL)>>40)|(((__u64)(*p)&(__u64)0xff00000000000000ULL)>>56))):__fswab64(*p))'
   include/uapi/linux/swab.h:204: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:212: Error: bad instruction `static inline __u32 __swahw32p(const __u32*p)'
   include/uapi/linux/swab.h:213: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:217: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x0000ffffUL)<<16)|(((__u32)(*p)&(__u32)0xffff0000UL)>>16))):__fswahw32(*p))'
   include/uapi/linux/swab.h:219: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:227: Error: bad instruction `static inline __u32 __swahb32p(const __u32*p)'
   include/uapi/linux/swab.h:228: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:232: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(*p)&(__u32)0xff00ff00UL)>>8))):__fswahb32(*p))'
   include/uapi/linux/swab.h:234: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:240: Error: bad instruction `static inline void __swab16s(__u16*p)'
   include/uapi/linux/swab.h:241: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:245: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:247: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:252: Error: bad instruction `static inline void __swab32s(__u32*p)'
   include/uapi/linux/swab.h:253: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:257: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:259: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:265: Error: bad instruction `static inline void __swab64s(__u64*p)'
   include/uapi/linux/swab.h:266: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:270: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:272: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:280: Error: bad instruction `static inline void __swahw32s(__u32*p)'
   include/uapi/linux/swab.h:281: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:285: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:287: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:295: Error: bad instruction `static inline void __swahb32s(__u32*p)'
   include/uapi/linux/swab.h:296: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:300: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:302: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:24: Error: bad instruction `static inline void swab16_array(u16*buf,unsigned int words)'
   include/linux/swab.h:25: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:26: Error: bad instruction `while (words--){'
   include/linux/swab.h:27: Error: bad instruction `__swab16s(buf)'
   include/linux/swab.h:28: Error: bad instruction `buf++'
   include/linux/swab.h:29: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:30: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:32: Error: bad instruction `static inline void swab32_array(u32*buf,unsigned int words)'
   include/linux/swab.h:33: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:34: Error: bad instruction `while (words--){'
   include/linux/swab.h:35: Error: bad instruction `__swab32s(buf)'
   include/linux/swab.h:36: Error: bad instruction `buf++'
   include/linux/swab.h:37: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:38: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:40: Error: bad instruction `static inline void swab64_array(u64*buf,unsigned int words)'
   include/linux/swab.h:41: Error: junk at end of line, first unrecognized character is `{'
   include/linux/swab.h:42: Error: bad instruction `while (words--){'
   include/linux/swab.h:43: Error: bad instruction `__swab64s(buf)'
   include/linux/swab.h:44: Error: bad instruction `buf++'
   include/linux/swab.h:45: Error: junk at end of line, first unrecognized character is `}'
   include/linux/swab.h:46: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:45: Error: bad instruction `static inline __le64 __cpu_to_le64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:46: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:47: Error: bad instruction `return (__force __le64)*p'
   include/uapi/linux/byteorder/little_endian.h:48: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:49: Error: bad instruction `static inline __u64 __le64_to_cpup(const __le64*p)'
   include/uapi/linux/byteorder/little_endian.h:50: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:51: Error: bad instruction `return (__force __u64)*p'
   include/uapi/linux/byteorder/little_endian.h:52: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:53: Error: bad instruction `static inline __le32 __cpu_to_le32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:54: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:55: Error: bad instruction `return (__force __le32)*p'
   include/uapi/linux/byteorder/little_endian.h:56: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:57: Error: bad instruction `static inline __u32 __le32_to_cpup(const __le32*p)'
   include/uapi/linux/byteorder/little_endian.h:58: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:59: Error: bad instruction `return (__force __u32)*p'
   include/uapi/linux/byteorder/little_endian.h:60: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:61: Error: bad instruction `static inline __le16 __cpu_to_le16p(const __u16*p)'
   include/uapi/linux/byteorder/little_endian.h:62: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:63: Error: bad instruction `return (__force __le16)*p'
   include/uapi/linux/byteorder/little_endian.h:64: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:65: Error: bad instruction `static inline __u16 __le16_to_cpup(const __le16*p)'
   include/uapi/linux/byteorder/little_endian.h:66: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:67: Error: bad instruction `return (__force __u16)*p'
   include/uapi/linux/byteorder/little_endian.h:68: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/byteorder/little_endian.h:69: Error: bad instruction `static inline __be64 __cpu_to_be64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:70: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/byteorder/little_endian.h:71: Error: bad instruction `return (__force __be64)__swab64p(p)'
   include/uapi/linux/byteorder/little_endian.h:72: Error: junk at end of line, first unrecognized character is `}'


vim +158 include/linux/bitfield.h

e2192de59e457a Johannes Berg   2023-01-18  119  
e2192de59e457a Johannes Berg   2023-01-18  120  /**
e2192de59e457a Johannes Berg   2023-01-18  121   * FIELD_PREP_CONST() - prepare a constant bitfield element
e2192de59e457a Johannes Berg   2023-01-18  122   * @_mask: shifted mask defining the field's length and position
e2192de59e457a Johannes Berg   2023-01-18  123   * @_val:  value to put in the field
e2192de59e457a Johannes Berg   2023-01-18  124   *
e2192de59e457a Johannes Berg   2023-01-18  125   * FIELD_PREP_CONST() masks and shifts up the value.  The result should
e2192de59e457a Johannes Berg   2023-01-18  126   * be combined with other fields of the bitfield using logical OR.
e2192de59e457a Johannes Berg   2023-01-18  127   *
e2192de59e457a Johannes Berg   2023-01-18  128   * Unlike FIELD_PREP() this is a constant expression and can therefore
e2192de59e457a Johannes Berg   2023-01-18  129   * be used in initializers. Error checking is less comfortable for this
e2192de59e457a Johannes Berg   2023-01-18  130   * version, and non-constant masks cannot be used.
e2192de59e457a Johannes Berg   2023-01-18  131   */
e2192de59e457a Johannes Berg   2023-01-18  132  #define FIELD_PREP_CONST(_mask, _val)					\
e2192de59e457a Johannes Berg   2023-01-18  133  	(								\
e2192de59e457a Johannes Berg   2023-01-18  134  		/* mask must be non-zero */				\
e2192de59e457a Johannes Berg   2023-01-18  135  		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
e2192de59e457a Johannes Berg   2023-01-18  136  		/* check if value fits */				\
e2192de59e457a Johannes Berg   2023-01-18  137  		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
e2192de59e457a Johannes Berg   2023-01-18  138  		/* check if mask is contiguous */			\
e2192de59e457a Johannes Berg   2023-01-18  139  		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
e2192de59e457a Johannes Berg   2023-01-18  140  		/* and create the value */				\
e2192de59e457a Johannes Berg   2023-01-18  141  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
e2192de59e457a Johannes Berg   2023-01-18  142  	)
e2192de59e457a Johannes Berg   2023-01-18  143  
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  144  /**
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  145   * FIELD_GET() - extract a bitfield element
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  146   * @_mask: shifted mask defining the field's length and position
7240767450d6d8 Masahiro Yamada 2017-10-03  147   * @_reg:  value of entire bitfield
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  148   *
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  149   * FIELD_GET() extracts the field specified by @_mask from the
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  150   * bitfield passed in as @_reg by masking and shifting it down.
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  151   */
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  152  #define FIELD_GET(_mask, _reg)						\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  153  	({								\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  154  		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  155  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  156  	})
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  157  
e7d4a95da86e0b Johannes Berg   2018-06-20 @158  extern void __compiletime_error("value doesn't fit into mask")
00b0c9b82663ac Al Viro         2017-12-14 @159  __field_overflow(void);
00b0c9b82663ac Al Viro         2017-12-14 @160  extern void __compiletime_error("bad bitfield mask")
00b0c9b82663ac Al Viro         2017-12-14 @161  __bad_mask(void);
00b0c9b82663ac Al Viro         2017-12-14 @162  static __always_inline u64 field_multiplier(u64 field)
00b0c9b82663ac Al Viro         2017-12-14 @163  {
00b0c9b82663ac Al Viro         2017-12-14 @164  	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
00b0c9b82663ac Al Viro         2017-12-14 @165  		__bad_mask();
00b0c9b82663ac Al Viro         2017-12-14 @166  	return field & -field;
00b0c9b82663ac Al Viro         2017-12-14  167  }
00b0c9b82663ac Al Viro         2017-12-14 @168  static __always_inline u64 field_mask(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  169  {
00b0c9b82663ac Al Viro         2017-12-14 @170  	return field / field_multiplier(field);
00b0c9b82663ac Al Viro         2017-12-14  171  }
e31a50162feb35 Alex Elder      2020-03-12  172  #define field_max(field)	((typeof(field))field_mask(field))
00b0c9b82663ac Al Viro         2017-12-14  173  #define ____MAKE_OP(type,base,to,from)					\
00b0c9b82663ac Al Viro         2017-12-14  174  static __always_inline __##type type##_encode_bits(base v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  175  {									\
e7d4a95da86e0b Johannes Berg   2018-06-20  176  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
00b0c9b82663ac Al Viro         2017-12-14  177  		__field_overflow();					\
00b0c9b82663ac Al Viro         2017-12-14  178  	return to((v & field_mask(field)) * field_multiplier(field));	\
00b0c9b82663ac Al Viro         2017-12-14  179  }									\
00b0c9b82663ac Al Viro         2017-12-14  180  static __always_inline __##type type##_replace_bits(__##type old,	\
00b0c9b82663ac Al Viro         2017-12-14  181  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  182  {									\
00b0c9b82663ac Al Viro         2017-12-14  183  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  184  }									\
00b0c9b82663ac Al Viro         2017-12-14  185  static __always_inline void type##p_replace_bits(__##type *p,		\
00b0c9b82663ac Al Viro         2017-12-14  186  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  187  {									\
00b0c9b82663ac Al Viro         2017-12-14  188  	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  189  }									\
00b0c9b82663ac Al Viro         2017-12-14  190  static __always_inline base type##_get_bits(__##type v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  191  {									\
00b0c9b82663ac Al Viro         2017-12-14  192  	return (from(v) & field)/field_multiplier(field);		\
00b0c9b82663ac Al Viro         2017-12-14  193  }
00b0c9b82663ac Al Viro         2017-12-14  194  #define __MAKE_OP(size)							\
00b0c9b82663ac Al Viro         2017-12-14  195  	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  196  	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  197  	____MAKE_OP(u##size,u##size,,)
37a3862e123826 Johannes Berg   2018-06-20 @198  ____MAKE_OP(u8,u8,,)
00b0c9b82663ac Al Viro         2017-12-14 @199  __MAKE_OP(16)
00b0c9b82663ac Al Viro         2017-12-14 @200  __MAKE_OP(32)
00b0c9b82663ac Al Viro         2017-12-14 @201  __MAKE_OP(64)
00b0c9b82663ac Al Viro         2017-12-14  202  #undef __MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  203  #undef ____MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  204  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
