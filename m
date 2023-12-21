Return-Path: <linux-kernel+bounces-8127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2481B26C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A721C24BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1C4EB2E;
	Thu, 21 Dec 2023 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYUnsV1v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CD4EB2B;
	Thu, 21 Dec 2023 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703150980; x=1734686980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ByO6Wara4ERsHExZfQ7+zAgRJPQof4xnCQkp5K7rASg=;
  b=DYUnsV1v3RIj3aX8o8p4577CKRGionfyP6AaXRsz9nZh0GJ7OzJ/GQSt
   DiVux0u4btOgyMvFZkEwDzU19ov+TK6GoWxbUAWIdVxHDIMkg0NflvLMX
   oqyXJ0T6JmS+sBoQI8lCU8Bj3Ec/BWEN7MlAouh370SK0q8ux58+9WkJi
   29wTm1KugZD8O++p3RX8Vo1o9mATX3dAe6JRoZnyPIgETMY4er2q7BhKF
   FF0rotBBjsFgXZ0kdkBc3pa2d9AEPNDmcsd+e7ucVOaZrK2inU/fxueuX
   9MfC+vY1SnGmAecWRK+mLAX5+XHYT7LMwG2Jtgkt70JLkfBMcMkRTA/ph
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3180036"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3180036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:29:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="18618874"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 21 Dec 2023 01:29:31 -0800
Date: Thu, 21 Dec 2023 17:26:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Message-ID: <ZYQE4/rkA++lyWaW@yilunxu-OptiPlex-7050>
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
 <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
 <2023121927-desolate-choice-a2fe@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121927-desolate-choice-a2fe@gregkh>

On Tue, Dec 19, 2023 at 07:11:09PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 06:17:20PM +0100, Marco Pagani wrote:
> > 
> > On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
> > >>
> > >>
> > >> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
> > >>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
> > >>>> This patch tentatively set the owner field of fpga_manager_ops to
> > >>>> THIS_MODULE for existing fpga manager low-level control modules.
> > >>>>
> > >>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > >>>> ---
> > >>>>  drivers/fpga/altera-cvp.c             | 1 +
> > >>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
> > >>>>  drivers/fpga/altera-ps-spi.c          | 1 +
> > >>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
> > >>>>  drivers/fpga/ice40-spi.c              | 1 +
> > >>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
> > >>>>  drivers/fpga/machxo2-spi.c            | 1 +
> > >>>>  drivers/fpga/microchip-spi.c          | 1 +
> > >>>>  drivers/fpga/socfpga-a10.c            | 1 +
> > >>>>  drivers/fpga/socfpga.c                | 1 +
> > >>>>  drivers/fpga/stratix10-soc.c          | 1 +
> > >>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
> > >>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
> > >>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
> > >>>>  drivers/fpga/versal-fpga.c            | 1 +
> > >>>>  drivers/fpga/xilinx-spi.c             | 1 +
> > >>>>  drivers/fpga/zynq-fpga.c              | 1 +
> > >>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
> > >>>>  18 files changed, 18 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > >>>> index 4ffb9da537d8..aeb913547dd8 100644
> > >>>> --- a/drivers/fpga/altera-cvp.c
> > >>>> +++ b/drivers/fpga/altera-cvp.c
> > >>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
> > >>>>  	.write_init	= altera_cvp_write_init,
> > >>>>  	.write		= altera_cvp_write,
> > >>>>  	.write_complete	= altera_cvp_write_complete,
> > >>>> +	.owner		= THIS_MODULE,
> > >>>
> > >>> Note, this is not how to do this, force the compiler to set this for you
> > >>> automatically, otherwise everyone will always forget to do it.  Look at
> > >>> how functions like usb_register_driver() works.
> > >>>
> > >>> Also, are you _sure_ that you need a module owner in this structure?  I
> > >>> still don't know why...
> > >>>
> > >>
> > >> Do you mean moving the module owner field to the manager context and setting
> > >> it during registration with a helper macro?
> > > 
> > > I mean set it during registration with a helper macro.
> > > 
> > >> Something like:
> > >>
> > >> struct fpga_manager {
> > >> 	...
> > >> 	struct module *owner;
> > >> };
> > >>
> > >> #define fpga_mgr_register(parent, ...) \
> > >> 	__fpga_mgr_register(parent,..., THIS_MODULE)
> > >>
> > >> struct fpga_manager *
> > >> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
> > >> {
> > >> 	...
> > >> 	mgr->owner = owner;
> > >> }
> > > 
> > > Yes.
> > > 
> > > But again, is a module owner even needed?  I don't think you all have
> > > proven that yet...
> > 
> > Programming an FPGA involves a potentially lengthy sequence of interactions
> > with the reconfiguration engine. The manager conceptually organizes these
> > interactions as a sequence of ops. Low-level modules implement these ops/steps
> > for a specific device. If we don't protect the low-level module, someone might
> > unload it right when we are in the middle of a low-level op programming the
> > FPGA. As far as I know, the kernel would crash in that case.
> 
> The only way an unload of a module can happen is if a user explicitly
> asks for it to be unloaded.  So they get what they ask for, right?

We have discussed this before [1]. The conclusion is kernel developers can
prevent user module unloading, as long as it doesn't make things
complex. Actually some fundamental subsystems do care about module
unloading. And I assume this patch doesn't make a complex fix.

[1] https://lore.kernel.org/linux-fpga/2023110922-lurk-subdivide-4962@gregkh/
> 
> How do you "know" it is active?  And why doesn't the normal

The FPGA core manages the reprogramming flow and knows if device is
active. FPGA core will grab the low-level driver module until
reprograming is finished. 

> "driver/device" bindings prevent unloading from being a problem?  When
> you unload a module, you stop all ops on the driver, and then unregister
> it, which causes any future ones to fail.

This is also discussed [2]. It is still about user explicit module
unloading. The low-level driver module on its own has no way to
garantee its own code page of callbacks not accessed. It *is*
accessing its code page when it tries (to release) any protection. [3]

Core code which calls into it must help, and something like
file_operations.owner is an effective way. This is why a struct
module *owner is introduced for core code to provide help.

[2] https://lore.kernel.org/linux-fpga/2023110918-showroom-choosy-ad14@gregkh/
[3] https://lore.kernel.org/all/20231010003746.GN800259@ZenIV/

Thanks,
Yilun

> 
> Or am I missing something here?
> 
> thanks,
> 
> greg k-h
> 

