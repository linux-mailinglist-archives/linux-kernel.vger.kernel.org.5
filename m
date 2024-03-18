Return-Path: <linux-kernel+bounces-106480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711787EF30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DE2869A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A655E50;
	Mon, 18 Mar 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XlZWs+Jf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BF55C3C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784238; cv=none; b=nNJ+wXQ7dV/aXsZyK0PHOspmxCXurSlR3em0mPpwNniGeAN0UdeVx+JbTIZ2hTmYwYCzgQYh0/0NM0J8GTpvHszJFNpsLqhY/VHVG+pkxCW0jmJ3lGoT0/7mxjX25ba33XXOxrNKQAnb0jQfAPrJ10b8P7nqVQMfABvltktXCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784238; c=relaxed/simple;
	bh=pQUEXLiwsG9pj5PVCtfU0JO6LrCsUmWuFBjSmI5msyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpBuibfFOZCCiNGP0DtLy5AdbHSyXzGT+HWoINqmRyu5Ah/Vr2CTlhY83JnFIJ0kU1yFJsTIqNX3HbT1GCrRwoewaM/VT/v5g20jJH5TK7ya0c8LqoIKU7saSIKo8BSE0/qLE/8FRXiXbSJ+Al5I3SMfHE4AtP97S4d437qKE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XlZWs+Jf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94D937E9;
	Mon, 18 Mar 2024 18:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710784208;
	bh=pQUEXLiwsG9pj5PVCtfU0JO6LrCsUmWuFBjSmI5msyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlZWs+Jf10VPkSIZExabneHvJ8lPq37tytooEGy4gXnTQOUn+SBX64FjyPPL5IiiN
	 92deGuT2P4WZHtLhdkYdvo6BzTg7FIN57y0JL/vEG/n61IUsahuTfD9wmQLYjST/81
	 pETs6/R8TlJ4l5MEDjO7d2427SLRIfRFb4Q1I0X4=
Date: Mon, 18 Mar 2024 19:50:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: kernel test robot <lkp@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, oe-kbuild-all@lists.linux.dev,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance
 testing
Message-ID: <20240318175032.GM13682@pendragon.ideasonboard.com>
References: <20240315230916.1759060-7-sean.anderson@linux.dev>
 <202403161704.ACHJdSJG-lkp@intel.com>
 <ce1190ad-27c2-4a16-b36f-442c0c419dcc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce1190ad-27c2-4a16-b36f-442c0c419dcc@linux.dev>

On Mon, Mar 18, 2024 at 11:06:40AM -0400, Sean Anderson wrote:
> On 3/16/24 06:14, kernel test robot wrote:
> > Hi Sean,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on v6.8]
> > [cannot apply to drm-misc/drm-misc-next linus/master next-20240315]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/drm-zynqmp_dp-Downgrade-log-level-for-aux-retries-message/20240316-071208
> > base:   v6.8
> > patch link:    https://lore.kernel.org/r/20240315230916.1759060-7-sean.anderson%40linux.dev
> > patch subject: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance testing
> > config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/config)
> > compiler: microblaze-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403161704.ACHJdSJG-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/gpu/drm/xlnx/zynqmp_dp.c: In function 'zynqmp_dp_bridge_debugfs_init':
> >>> drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:31: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
> >     2168 |                 sprintf(name, fmt, i);
> >          |                               ^~~
> >    drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:17: note: 'sprintf' output between 18 and 20 bytes into a destination of size 19
> >     2168 |                 sprintf(name, fmt, i);
> >          |                 ^~~~~~~~~~~~~~~~~~~~~
> 
> Not a bug, as i will be at most 4, which uses 1 digit.

The compiler can't know that. Please fix this, there's a zero warning
policy.

> > vim +/sprintf +2168 drivers/gpu/drm/xlnx/zynqmp_dp.c
> > 
> >   2136	
> >   2137	DEFINE_DEBUGFS_ATTRIBUTE(fops_zynqmp_dp_rate, zynqmp_dp_rate_get,
> >   2138				 zynqmp_dp_rate_set, "%llu\n");
> >   2139	
> >   2140	static void zynqmp_dp_bridge_debugfs_init(struct drm_bridge *bridge,
> >   2141						  struct dentry *root)
> >   2142	{
> >   2143		struct zynqmp_dp *dp = bridge_to_dp(bridge);
> >   2144		struct dentry *test;
> >   2145		int i;
> >   2146	
> >   2147		dp->test.bw_code = DP_LINK_BW_5_4;
> >   2148		dp->test.link_cnt = dp->num_lanes;
> >   2149	
> >   2150		test = debugfs_create_dir("test", root);
> >   2151	#define CREATE_FILE(name) \
> >   2152		debugfs_create_file(#name, 0600, test, dp, &fops_zynqmp_dp_##name)
> >   2153		CREATE_FILE(pattern);
> >   2154		CREATE_FILE(enhanced);
> >   2155		CREATE_FILE(downspread);
> >   2156		CREATE_FILE(active);
> >   2157		CREATE_FILE(custom);
> >   2158		CREATE_FILE(rate);
> >   2159		CREATE_FILE(lanes);
> >   2160	
> >   2161		for (i = 0; i < dp->num_lanes; i++) {
> >   2162			static const char fmt[] = "lane%d_preemphasis";
> >   2163			char name[sizeof(fmt)];
> >   2164	
> >   2165			dp->debugfs_train_set[i].dp = dp;
> >   2166			dp->debugfs_train_set[i].lane = i;
> >   2167	
> >> 2168			sprintf(name, fmt, i);
> >   2169			debugfs_create_file(name, 0600, test,
> >   2170					    &dp->debugfs_train_set[i],
> >   2171					    &fops_zynqmp_dp_preemphasis);
> >   2172	
> >   2173			sprintf(name, "lane%d_swing", i);
> >   2174			debugfs_create_file(name, 0600, test,
> >   2175					    &dp->debugfs_train_set[i],
> >   2176					    &fops_zynqmp_dp_swing);
> >   2177		}
> >   2178	}
> >   2179	

-- 
Regards,

Laurent Pinchart

