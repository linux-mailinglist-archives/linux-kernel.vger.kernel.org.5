Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD277DA4A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjJ1B2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1B2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:28:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF62128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698456485; x=1729992485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bqx7muvXiDahoTiyjP5K3nYRlQ0IYNhGE4dsuYQiyl0=;
  b=NzTdIFc01tYoEKlUPc9lZ1P9HKYL1cYeM5eRBesspWrJUoKCQjwwzn4I
   gtnReac1sRItB1107oz4sFeujnvF6xk9+pOWuf0QOOKky/gLUJvMtvOXg
   5Z9TRhfuAm72AcNIpDYNPpDpgu1H0zNxt5e7dT+FmIBK3GLJSpwlrw76o
   fld3yEDONaTOe+IkOVYdzt0/ue4PC1e62E6wzhS6EkTCBb2PSP0s46yn3
   E/QboO5w2pvzfuhEVaorgUovJ+jsQ1Q4XqjjA4WsBVekbb2OUvxtHONa7
   n4nK49NcqXcCL6M/qUhMAZMD0TR76zOjI4CUVGilry/XGgM04utrb1CN4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="367214268"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="367214268"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="763398743"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="763398743"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2023 18:28:03 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwY7N-000BMQ-0t;
        Sat, 28 Oct 2023 01:28:01 +0000
Date:   Sat, 28 Oct 2023 09:27:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Igor Torrente <igormtorrente@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Melissa Wen <melissa.srw@gmail.com>
Subject: drivers/gpu/drm/vkms/vkms_formats.c:91:35: sparse: sparse: cast to
 restricted __le16
Message-ID: <202310280922.FO6joaGF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56567a20b22bdbf85c3e55eee3bf2bd23fa2f108
commit: 3675d8a1726337bd1e839a185e0a7ce0bc459b6b drm: vkms: Adds XRGB_16161616 and ARGB_1616161616 formats
date:   1 year, 2 months ago
config: x86_64-randconfig-123-20231016 (https://download.01.org/0day-ci/archive/20231028/202310280922.FO6joaGF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310280922.FO6joaGF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310280922.FO6joaGF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/vkms/vkms_formats.c:91:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:92:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:93:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:94:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:109:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:110:35: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/vkms/vkms_formats.c:111:35: sparse: sparse: cast to restricted __le16
>> drivers/gpu/drm/vkms/vkms_formats.c:177:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:177:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:177:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:178:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:178:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:178:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:179:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:179:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:179:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:180:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:180:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:180:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:195:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:195:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:195:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:196:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:196:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:196:31: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:197:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/vkms/vkms_formats.c:197:31: sparse:     expected unsigned short [usertype]
   drivers/gpu/drm/vkms/vkms_formats.c:197:31: sparse:     got restricted __le16 [usertype]

vim +91 drivers/gpu/drm/vkms/vkms_formats.c

    80	
    81	static void ARGB16161616_to_argb_u16(struct line_buffer *stage_buffer,
    82					     const struct vkms_frame_info *frame_info,
    83					     int y)
    84	{
    85		struct pixel_argb_u16 *out_pixels = stage_buffer->pixels;
    86		u16 *src_pixels = get_packed_src_addr(frame_info, y);
    87		int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
    88				    stage_buffer->n_pixels);
    89	
    90		for (size_t x = 0; x < x_limit; x++, src_pixels += 4) {
  > 91			out_pixels[x].a = le16_to_cpu(src_pixels[3]);
    92			out_pixels[x].r = le16_to_cpu(src_pixels[2]);
    93			out_pixels[x].g = le16_to_cpu(src_pixels[1]);
    94			out_pixels[x].b = le16_to_cpu(src_pixels[0]);
    95		}
    96	}
    97	
    98	static void XRGB16161616_to_argb_u16(struct line_buffer *stage_buffer,
    99					     const struct vkms_frame_info *frame_info,
   100					     int y)
   101	{
   102		struct pixel_argb_u16 *out_pixels = stage_buffer->pixels;
   103		u16 *src_pixels = get_packed_src_addr(frame_info, y);
   104		int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
   105				    stage_buffer->n_pixels);
   106	
   107		for (size_t x = 0; x < x_limit; x++, src_pixels += 4) {
   108			out_pixels[x].a = (u16)0xffff;
   109			out_pixels[x].r = le16_to_cpu(src_pixels[2]);
   110			out_pixels[x].g = le16_to_cpu(src_pixels[1]);
   111			out_pixels[x].b = le16_to_cpu(src_pixels[0]);
   112		}
   113	}
   114	
   115	/*
   116	 * The following  functions take an line of argb_u16 pixels from the
   117	 * src_buffer, convert them to a specific format, and store them in the
   118	 * destination.
   119	 *
   120	 * They are used in the `compose_active_planes` to convert and store a line
   121	 * from the src_buffer to the writeback buffer.
   122	 */
   123	static void argb_u16_to_ARGB8888(struct vkms_frame_info *frame_info,
   124					 const struct line_buffer *src_buffer, int y)
   125	{
   126		int x_dst = frame_info->dst.x1;
   127		u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
   128		struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
   129		int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
   130				    src_buffer->n_pixels);
   131	
   132		for (size_t x = 0; x < x_limit; x++, dst_pixels += 4) {
   133			/*
   134			 * This sequence below is important because the format's byte order is
   135			 * in little-endian. In the case of the ARGB8888 the memory is
   136			 * organized this way:
   137			 *
   138			 * | Addr     | = blue channel
   139			 * | Addr + 1 | = green channel
   140			 * | Addr + 2 | = Red channel
   141			 * | Addr + 3 | = Alpha channel
   142			 */
   143			dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixels[x].a, 257);
   144			dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixels[x].r, 257);
   145			dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixels[x].g, 257);
   146			dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixels[x].b, 257);
   147		}
   148	}
   149	
   150	static void argb_u16_to_XRGB8888(struct vkms_frame_info *frame_info,
   151					 const struct line_buffer *src_buffer, int y)
   152	{
   153		int x_dst = frame_info->dst.x1;
   154		u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
   155		struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
   156		int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
   157				    src_buffer->n_pixels);
   158	
   159		for (size_t x = 0; x < x_limit; x++, dst_pixels += 4) {
   160			dst_pixels[3] = 0xff;
   161			dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixels[x].r, 257);
   162			dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixels[x].g, 257);
   163			dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixels[x].b, 257);
   164		}
   165	}
   166	
   167	static void argb_u16_to_ARGB16161616(struct vkms_frame_info *frame_info,
   168					     const struct line_buffer *src_buffer, int y)
   169	{
   170		int x_dst = frame_info->dst.x1;
   171		u16 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
   172		struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
   173		int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
   174				    src_buffer->n_pixels);
   175	
   176		for (size_t x = 0; x < x_limit; x++, dst_pixels += 4) {
 > 177			dst_pixels[3] = cpu_to_le16(in_pixels[x].a);
   178			dst_pixels[2] = cpu_to_le16(in_pixels[x].r);
   179			dst_pixels[1] = cpu_to_le16(in_pixels[x].g);
   180			dst_pixels[0] = cpu_to_le16(in_pixels[x].b);
   181		}
   182	}
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
