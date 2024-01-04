Return-Path: <linux-kernel+bounces-16348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5D823D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8821F2467B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6467200C0;
	Thu,  4 Jan 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZT148dVL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509C200AC;
	Thu,  4 Jan 2024 08:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D555C433C7;
	Thu,  4 Jan 2024 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704355362;
	bh=pp0So8gs5MkuWez0uSmAaEFSV4iDlUOwU5mnTRXt3yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZT148dVL8fyl//AMobk+iTX7hdxXTXCLo7CI1q4rQ/2nxySks0j8rIhnNRbrD7ix8
	 aqt1yPlxzziKE9MaIi7S/Y5UZXc3lW2V4j7QhjzoINuNOOZRoWv4ZB2oeYupmi1bKs
	 xEqpHLIequJul/pMBeBEHX195HAeP+OqS7/hRc68=
Date: Thu, 4 Jan 2024 09:02:39 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
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
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC] FPGA Subsystem User Space Interface Proposal
Message-ID: <2024010451-syrup-obituary-3388@gregkh>
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

Can you line-wrap your emails to make them easier to read?

Also, something went wrong here:

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


And here:

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

Your spaces all seem too big, making this really hard to read.

But really, we need to see some code before we can go further.
"proposals" are great, but that's not how kernel development works, we
need actual patches to be able to evaluate anything, as that shows you
at least have a working implementation to start with, and that you have
resolved any of the obvious issues ahead of time.

thanks,

greg k-h

