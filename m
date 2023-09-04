Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88F791168
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjIDGdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjIDGdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:33:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C80510D;
        Sun,  3 Sep 2023 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693809189; x=1725345189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hm87bvsrPQVAZfKF5UL9l3c0p/ekBlKRwg6W7XwU9Mk=;
  b=BE7cYLIED+1eQoY5FQbvabpJVPaipG4KKubU1l8s88M9YpsvFTIjHgQo
   f/33MPx0zw6QcQ1tyxxJw441ZUIuDsc98bpGLPflVJzUSWMPuLEmZquXP
   OyiO7n+5GVyvpbKzUfhQ3ysj55kAYa2shqPwc2e2NGMaRva0iND5oF6P+
   VzC+BXrlrjJwb/jaZzV7unoQ84sFij+NKJKVv7AI9CsmppfxfeJrg2v9B
   6G5mxuD1xmKHS0uwPj3wUe7rBhSYvCHaNgPpX7zzpieEEC3pc/wG6Xifj
   yBYHSRefBryxaXYBo1x7vIffjrLPzADDlqmlxLvhYOxHb5ttC10OF1Eq4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462893867"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="462893867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 23:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806134594"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="806134594"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 23:33:05 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 724C511F9DF;
        Mon,  4 Sep 2023 09:33:02 +0300 (EEST)
Date:   Mon, 4 Sep 2023 06:33:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH 2/2] media: i2c: imx519: Support for the Sony IMX519
 sensor
Message-ID: <ZPV6HnHj8TkEL1Nb@kekkonen.localdomain>
References: <20230727154108.308320-3-umang.jain@ideasonboard.com>
 <202307281538.bqZ5kcV9-lkp@intel.com>
 <1070170e-830c-4752-bad5-8f653ebd80a4@ideasonboard.com>
 <20230903212158.GF13794@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903212158.GF13794@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang, Laurent,

On Mon, Sep 04, 2023 at 12:21:58AM +0300, Laurent Pinchart wrote:
> Hi Umang,
> 
> On Fri, Jul 28, 2023 at 01:47:36PM +0530, Umang Jain wrote:
> > On 7/28/23 12:56 PM, kernel test robot wrote:
> > > Hi Umang,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on media-tree/master]
> > > [also build test ERROR on soc/for-next linus/master v6.5-rc3 next-20230727]
> > > [cannot apply to sailus-media-tree/streams]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-dt-bindings-imx519-Add-IMX519-DT-bindings/20230727-234440
> > > base:   git://linuxtv.org/media_tree.git master
> > > patch link:    https://lore.kernel.org/r/20230727154108.308320-3-umang.jain%40ideasonboard.com
> > > patch subject: [PATCH 2/2] media: i2c: imx519: Support for the Sony IMX519 sensor
> > > config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230728/202307281538.bqZ5kcV9-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281538.bqZ5kcV9-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202307281538.bqZ5kcV9-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >     drivers/media/i2c/imx519.c: In function 'imx519_open':
> > >>> drivers/media/i2c/imx519.c:1170:30: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
> > 
> > This comes from the bcm2835-unicam for Rpi's that's being worked upon. 
> > And I was testing this driver on top of it.
> 
> Please base the next version on top of Sakari's metadata series, provide
> a branch with your patches and all dependencies in the cover letter, and
> use the --base argument to git-format-patch to indicate the base
> clearly.

I've pushed my latest development series to
<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=metadata>.

-- 
Sakari Ailus
