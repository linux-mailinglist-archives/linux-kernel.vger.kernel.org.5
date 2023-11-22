Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA387F3FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjKVIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjKVIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:07:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620718E;
        Wed, 22 Nov 2023 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700640440; x=1732176440;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=HzCmIqjiD/db2OVbbJ6fw6PB9pWnFmcUdmjHwNUjwaw=;
  b=OAlHcKef/5awVohSEwnbUzrwn8UiUXJaV+oOQgkLCc5wIazlg/a3TCBy
   Jw027fPq+iqzo7N3VPjSd7b3hJYx/bKE8qjFZHckSoZmC9SakW7+lePWe
   hLU9BXbg2GfeSvHya+6ht/Np70eIo0D5yI4NKyqlRUSWZHT/7y990X+Ne
   GNjmSymw6MWgFEjEG/Us0szn5Xjzc539Pqya16z3kwiK0tbXOU1ER2cm/
   915R1xl0G4Xx9D/PaX/KELD5/RUe6TuSKfizIdoyFCydOmjTKYV4Zkr80
   sji4P7dr69tgYanjtujn4oxkNvtKmRbquSj0JqDWYjgwwHNY7gZm22Vpq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478214281"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="478214281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 00:07:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832934951"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="832934951"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 00:07:16 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 110AF1202B6;
        Wed, 22 Nov 2023 10:07:14 +0200 (EET)
Date:   Wed, 22 Nov 2023 08:07:14 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add support for DCMIPP camera interface of
 STMicroelectronics STM32 SoC series
Message-ID: <ZV22srRYwqKf3eKs@kekkonen.localdomain>
References: <20231120170809.728941-1-alain.volmat@foss.st.com>
 <ZVvNMPfW7OhPByZk@kekkonen.localdomain>
 <20231122074404.GA787777@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122074404.GA787777@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Wed, Nov 22, 2023 at 08:44:04AM +0100, Alain Volmat wrote:
> Hi Sakari,
> 
> On Mon, Nov 20, 2023 at 09:18:40PM +0000, Sakari Ailus wrote:
> > Hi Alain,
> > 
> > On Mon, Nov 20, 2023 at 06:07:56PM +0100, Alain Volmat wrote:
> > > This patchset introduces support for Digital Camera Memory Interface
> > > Pixel Processor (DCMIPP) of STMicroelectronics STM32 SoC series.
> > > 
> > > This initial support implements a single capture pipe
> > > allowing RGB565, YUV, Y, RAW8 and JPEG capture with
> > > frame skipping, prescaling and cropping.
> > > 
> > > DCMIPP is exposed through 3 subdevices:
> > > - dcmipp_dump_parallel: parallel interface handling
> > > - dcmipp_dump_postproc: frame skipping, prescaling and cropping control
> > > - dcmipp_dump_capture: video device capture node
> > > 
> > > v7:
> > >   - correct byteproc set_fmt handling and compose/crop/fmt handling
> > >   - replace few v4l2_subdev_get_try_* into v4l2_subdev_get_pad_*
> > 
> > Can you rebase this on my my linuxtv.org tree master branch
> > <URL:https://git.linuxtv.org/sailus/media_tree.git/log/>?
> > 
> > These will be called v4l2_subdev_state_get_* now.
> 
> Ok, serie v8 is now rebased on top of the master branch of your tree.
> I'm going to push the rebased gc2145 sensor driver as well in a moment.

Thanks. Hans said he's going to merge the API change later this week (Mauro
might do that earlier), I'll take these then.

-- 
Regards,

Sakari Ailus
