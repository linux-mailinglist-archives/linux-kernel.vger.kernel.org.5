Return-Path: <linux-kernel+bounces-24288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BA82BA63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECDC28ADA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED945B5AB;
	Fri, 12 Jan 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWMirJH1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70C33CD0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705033930; x=1736569930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bwe4VBfFRqLYoVoM0ibKK9WeELsWiV+7yc5CWqKQwL0=;
  b=NWMirJH1kCWrWiavYcd5RPVv/NZakL2I5VBUMZWvqxXwOw9QK+2zbkwr
   UYqgs/uOI3JgBi6kO4WajmnHb3CmvLOZDTcTb8s97eAgFpjMMj3vL2qve
   bE5VzkIpp/6mRl2wwiFG0XMtvuQu4CHeeAdibqTeHaj1psPaLS8dMC5BF
   n7PaumY50wMl5Z4RSVQEJ9IBvNHZ1YMkeTwzoBBrGWvkFPpnMkC6AU7Hz
   wOypAu/KcomyonWvn983Hgx3y0b6xnbNBLCR2sfGzAfZZtP7LbWQxLyEH
   HIsjeebSbNEzXmh8f7eWiwLg/ENDxlAHVhboVPP4/cQPMNLKNNAEFDZQA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="485256232"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="485256232"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 20:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="901847725"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="901847725"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jan 2024 20:32:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO9D3-00093u-20;
	Fri, 12 Jan 2024 04:32:00 +0000
Date: Fri, 12 Jan 2024 12:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Torrente <igormtorrente@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Melissa Wen <melissa.srw@gmail.com>
Subject: drivers/gpu/drm/vkms/vkms_formats.c:91:35: sparse: sparse: cast to
 restricted __le16
Message-ID: <202401121243.vaUKTMMC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22d29f1112c85c1ad519a8c0403f7f7289cf060c
commit: 3675d8a1726337bd1e839a185e0a7ce0bc459b6b drm: vkms: Adds XRGB_16161616 and ARGB_1616161616 formats
date:   1 year, 4 months ago
config: x86_64-randconfig-121-20240107 (https://download.01.org/0day-ci/archive/20240112/202401121243.vaUKTMMC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121243.vaUKTMMC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121243.vaUKTMMC-lkp@intel.com/

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

