Return-Path: <linux-kernel+bounces-19102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C9982680E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE01281DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBC79EF;
	Mon,  8 Jan 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4sySwq/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890747493;
	Mon,  8 Jan 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704695716; x=1736231716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+u9j3c47yhngrz+FM6tbbFm2Vqtd0o68a0TMjK4crM=;
  b=R4sySwq/sUYvWSAItiniso9A8ubRtD+6CvatlZFMcGe9fgEZhBVCFTn8
   U4YBLU+NzhnxodCg4ET7nHJOy45WpZKq1PtbYAPNFMGNxn23fRgHJcTYv
   +3JQTfjM7IuHDbVOc4n/PPgIg64zyUGQyFmSo2nzrm2ANazIQ9nEmsayF
   cVo9Tf1l0sOWdUMECR7R09tFMiNcwcyo5LHiMuVqW5546eT6mrGLcqLwg
   2p0HElOjBcXtGJiOZjA/wFOakqhuYczYPo4bwx2dA6zw+z75AK8YYaZnU
   4wLm1Y8gSea0GxV0Kuel2k5FhwKOu7i57Zo5Wg8Gnp21nricaghe3Z3F4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="396685622"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="396685622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 22:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23073387"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2024 22:35:11 -0800
Date: Mon, 8 Jan 2024 14:32:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"peter.colberg@intel.com" <peter.colberg@intel.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"v.georgiev@metrotek.ru" <v.georgiev@metrotek.ru>,
	"Simek, Michal" <michal.simek@amd.com>,
	Marco Pagani <marpagan@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC] FPGA Subsystem User Space Interface Proposal
Message-ID: <ZZuW7rQv22xEreu0@yilunxu-OptiPlex-7050>
References: <DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com>

On Thu, Jan 04, 2024 at 04:52:15AM +0000, Manne, Nava kishore wrote:
> =======================================================================
> | Introduction                                                        |
> =======================================================================
> This document provides a detailed overview of the proposed Kernel feature for FPGA Manager subsystem user interface.
> It describes the problem statement behind the proposal, the problem to be solved, a top-level solution design.
> 
> Table of Contents:
> ------------------
> A. Problem Statement and Background
> B. Scope and Out of scope of the proposal
>      B.1 Scope
>      B.2 Out of scope
> C. Proposed Solution
> D. Proposed User Interface Details
> =======================================================================
> | A. Problem Statement and Background                                        |
> =======================================================================
> The existing FPGA manager subsystem didn't have any user space interface (other than the status/state in sysfs) in Kernel. 
> Basically, FPGAs are semiconductor devices that can be reprogrammed for desired hardware functionality.
> FPGAs can be reprogrammed at runtime with different types of logic and IPs as per user need and hence there is a need to use device tree overlays for removing/updating/adding the devices at runtime for the IPs/controllers that are present in FPGA. 
> But we don't have any user interface in kernel for updating the device tree at runtime.
> 
> Sometime back there was a series sent by Pantelis Antoniou (https://lore.kernel.org/lkml/1414528565-10907-4-git-send-email-pantelis.antoniou@konsulko.com/).
> This patch introduced a user interface configfs for Device Tree overlays, a method of dynamically altering the kernel's live Device Tree. However,  this patch series was not accepted in mainline due to various concerns.
> For more details refer to this link: https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive_list
> 
> One of the major valid concerns that were raised with this configfs interface was security as it opens up the interface to users for modifying the live device tree.
> 
> So, in order to configure/program the FPGA devices, All the major vendors of FPGA are using this configfs series as out-of-tree patch for configuring the FPGAs
> and there was never an attempt to introduce a generic interface to configure/program the FPGA in upstream and hence upstream kernel ended up in not having proper support for FPGAs.
> 
> The proposal below tries to address this gap of FPGA programmability by providing an interface to the user.
> 
> =======================================================================
> | B. Proposed Solution                                                |
> =======================================================================
> The proposed interface adds a new sysfs interface (of-fpga-region.c) as part of the fpga subsystem and it is responsible for supporting the below functionalities.

Why only for of-fpga-region? There are also FPGA regions that don't rely
on OF. My quick idea is that an interface for /sys/class/fpga-region/
and OF could be one of the implementation.

Thanks,
Yilun

> --> Provide the user interface for the FPGA subsystem to handle the below FPGA relevant stuff.
>          - Bridges.
>          - FPGA Configuration.
>          - Driver - Probe/Remove
>                                 
> --> The new sysfs interface uses Device Tree overlay (DTO) files to configure/ reprogram an FPGA while an operating system is running.
>                 - Restrict the overlay's subsystem usage only to FPGA regions in order to mitigate the major security concern with configfs.
>                 - Do validation checks on the user provided DTO files.
>                                 - If the user provided DTO doesn't target an FPGA Region which is already part of the running kernel, then return -INVALID error.
>                                 - If the DTO file contains multiple targets, then return -INVALID error.
>                                 - It will allow only Child nodes which are part of targeted FPGA Region.
>                 - It avoids Overlay notification calls . So that it will not interrupt the other subsystem's(Like; GPIO, I2C.....etc) exists in the kernel.
>                 
> -->This proposed solution will not change the existing sequence When a 
> -->DT overlay that targets an FPGA Region is applied
>                 - The FPGA Region will do the following:
>                 - 1. Disable appropriate FPGA bridges.
>                 - 2. Program the FPGA using the FPGA manager.
>                 - 3. Enable the FPGA bridges.
>                 - 4. The Device Tree overlay is accepted into the live tree.
>                 - 5. Child devices are populated.
>                 - When the overlay is removed, the child nodes will be removed, and the FPGA Region will disable the bridges.
>        
>                                                                     . --------------------------------------.                       .-----------------------------------------.                        
>                                                                    |                                                    |                     |                                                        |
>                                                                    |                           .------------------|                     |---------------------.                           |
>                                                                    |                           | sysfs_load() |<=======> |Overaly_apply()|                          | 
> .---------------------------------.                     |                           '------------------|                     |---------------------'                           |
> |                                          |                     |                                                    |                     |                                                        |
> |    New Sysfs interface   |        ====>   |       of-fpga-region .c               |                     |            DT Overlay.c                      |
> |       load/unload             |                      |                                                   |                     |                                                        |
> '--------------------------------'                      |                      .---------------------|                     |-------------------------.                     |
>                                                                     |                     | sysfs_unload() |<=======> | Overlay_remove() |                    |
>                                                                     |                      '-------------------- |                     |-------------------------'                     |
>                                                                     |                                                   |                     |                                                       |
>                                                                      '----------------------------------- --'                       '------------------------------------------'
> =======================================================================
> | D. Proposed User Interface Details                                               |
> =======================================================================
> How to use the fpga sysfs interface.
> 
> To load Image:
> 	 - echo "DTBO file" > /sys/class/of-fpga_region/<region>/load
> 
> To unload Image:
> 	 - /sys/class/of-fpga_region/<region>/unload
> 
> To get the image status (Load/Unload):
> 	 - cat /sys/class/of-fpga_region/<region>/status
> 
> Base Image
>                - Also called the "static image"
>                - An FPGA image that is designed to do full reconfiguration of the FPGA.
>                - A base image may set up a set of partial reconfiguration regions that may later be reprogrammed.
> 
>      .-----------------------.                       .--------------------------------------------.
>     | Host CPU              |                   |             FPGA                                      |
>     |                                |                   |                                                            |
>     |                           -- -|                   |                  -----------             ---------  |
>     |                         | H |                   |       |==>| Bridge0 |<==>| PRR0 | |
>     |                         | W|                   |       |         -----------             --------    |
>     |                         |     |                   |       |                                                   |
>     |                         | B |<=====>    |<== |         -----------             --------   |
>     |                         | R |                   |        |==>| Bridge1 |<==>| PRR1| |
>     |                         |  I |                   |        |        -----------              --------   |
>     |                         | D |                  |        |                                                   |
>     |                         | G |                  |        |         -----------               -------   |
>     |                         | E |                   |        |==>| Bridge2 |<==>| PRR2 ||
>     |                          ----|                  |                   -----------               --------  |
>     |                               |                  |                                                              |
>      '-----------------------'                     '---------------------------------------------'
> 
> In the above diagram a typical FPGA is setup with a base image that created three regions.
> Each region (PRR0 - 2) gets its own split of the busses that is independently gated by a soft logic bridge (Bridge0 - 2) in the FPGA.
> The contents of each PRR can be reprogrammed independently while the rest of the system continues to function.
> 
> Form the above tropology the sysfs interface looks like as follows.
> 
> For Base/static region:
> To load Image:
>                 - echo "DTBO file" > /sys/class/of-fpga_region/FPGA/load
> 
> To unload Image:
>                 - /sys/class/of-fpga_region/FPGA/unload
> 
> To get the image status (Load/Unload):
>                 - cat /sys/class/of-fpga_region/FPGA/status
> 
> For PRR0:
> To load Image:
>                 - echo "DTBO file" >   /sys/class/of-fpga_region/PRR0/load
> 
> To unload Image:
>                 - /sys/class/of-fpga_region/PRR0/unload
> 
> To get the image status (Load/Unload):
>                 - cat /sys/class/of-fpga_region/PRR0/status
> 
> For PRR1:
> To load Image:
>                 - echo "DTBO file" >   /sys/class/of-fpga_region/PRR1/load
> 
> To unload Image:
>                 - /sys/class/of-fpga_region/PRR1/unload
> 
> To get the image status (Load/Unload):
>                 - cat /sys/class/of-fpga_region/PRR1/status
> 
> For PRR1:
> To load Image:
>                 - echo "DTBO file" >   /sys/class/of-fpga_region/PRR1/load
> 
> To unload Image:
>                 - /sys/class/of-fpga_region/PRR1/unload
> 
> To get the image status (Load/Unload):
>                 - cat /sys/class/of-fpga_region/PRR1/status
> 

