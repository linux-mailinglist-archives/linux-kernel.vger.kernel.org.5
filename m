Return-Path: <linux-kernel+bounces-144081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6578A4194
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB21B1F2157C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82A23748;
	Sun, 14 Apr 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brXOj02v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314521A19
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087989; cv=none; b=f/a6lpyh7dCubPWCJzra5VTRvTGUGTN2M472G37gB4y/ipjqlyZxtZTONQrUmvq1hsvr3vPXyRMePc4U5BHrYGdfvszgks8rQmIG9c75VykvIKFajCCSEj5kMP6hQjYp/8EvDPHu6y7M9pQpkg0XQTh9RRddrFO8TCBDE1We3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087989; c=relaxed/simple;
	bh=0zSoq5qVDWV1e93UmNWw6HasZ/G8cDLO5gr6MqwnptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo0Is/nYCtvYCyVxueTTGqPAbG0exbWa3ImGWMpl2/K6fzKjeVVT/behMkPC9oQmBOJQHYnFh//EtR+/ZX8APkmm+Hz6YhtytENVYZVl6IbE11hS4Bw8ZLvy6oBHObSDKhBGhcBJBavZSb0sUZ1XQxCZm0H+paL9oU0G0QipuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brXOj02v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E0C072AA;
	Sun, 14 Apr 2024 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713087988;
	bh=0zSoq5qVDWV1e93UmNWw6HasZ/G8cDLO5gr6MqwnptQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brXOj02vmKWNlhKPdtd6ZLtr9Ez3MeP8uJn/tI2W2bjWZntdOnuuLuYYTC78nk5rM
	 Sl3kBkZwwP1whZLivLL6Z5f8sb/1fq5xmL+QnOmnRYbFsHr0VPywdqQj0TKnPrrvB+
	 qDYXZOwRsN0rs8PgJZx3xMf0Dy6MM0em99RZBzc4=
Date: Sun, 14 Apr 2024 11:46:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024041458-directory-image-6a0c@gregkh>
References: <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041310-bundle-patio-8a22@gregkh>
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <b5d400e6-9e4a-4f5d-b48f-a75c65ec1ae8@app.fastmail.com>
 <MW4PR18MB52449BD843670B347C0383EDA60A2@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB52449BD843670B347C0383EDA60A2@MW4PR18MB5244.namprd18.prod.outlook.com>

On Sun, Apr 14, 2024 at 09:33:37AM +0000, Vamsi Krishna Attunuru wrote:
> 
> 
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Sunday, April 14, 2024 12:41 AM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Cc: linux-kernel@vger.kernel.org; Jerin Jacob <jerinj@marvell.com>
> > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > Octeon CN10K DPI administrative driver
> > 
> > On Sat, Apr 13, 2024, at 18:17, Vamsi Krishna Attunuru wrote:
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > >> On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru wrote:
> > >> > From: Greg KH <gregkh@linuxfoundation.org>
> > >> >
> > >> > No, it's a normal PCIe sriov capability implemented in all sriov
> > >> > capable PCIe
> > >> devices.
> > >> > Our PF device aka this driver in kernel space service mailbox
> > >> > requests from userspace applications via VF devices. For instance,
> > >> > DPI VF device from user space writes into mailbox registers and the
> > >> > DPI hardware
> > >> triggers an interrupt to DPI PF device.
> > >> > Upon PF interrupt, this driver services the mailbox requests.
> > >>
> > >> Isn't that a "normal" PCI thing?  How is this different from other
> > >> devices that have VF?
> > >
> > > Looks like there is a lot of confusion for this device. Let me explain
> > > There are two aspects for this DPI PF device.
> > > a) It's a PCIe device so it is "using" some of the PCI services
> > > provided PCIe HW or PCI subsystem
> > > b) It is "providing" non PCIe service(DPI HW administrative function)
> > > by using (a) Let me enumerate PF device operations with above aspects.
> > > 1) Means to create VF(s) from PF. It's category (a) service and driver
> > > uses API (pci_sriov_configure_simple()) from PCI subsystem to
> > > implement it.
> > > 2) Means to get the interrupt(mailbox or any device specific
> > > interrupt). It's category (a) service and driver uses API
> > > (pci_alloc_irq_vectors()) from PCI subsystem to implement it.
> > > 3) Means to get the mailbox content from VF by using (2). It's
> > > category
> > > (b) service. This service is not part of PCI specification.
> > > DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA
> > registers)
> > > in its PCIe BAR space which are device specific.
> > > 4) Upon receiving DPI HW administrative function mailbox request,
> > > service it. Its category (b) service. This service is not part of PCI
> > > specification.
> > > For instance, dpi_queue_open & close are requests sent from DPI VF
> > > device to DPI PF device for setting up the DPI VF queue resources.
> > > Once its setup by DPI PF, then DPI VF device can use these queues.
> > > These queues are not part of PCIe specification. These queues are used
> > > for making DMA by DPI VF device/driver.
> > 
> > It's not directly my area either, but as far as I can tell from reading the
> > competing sr-iov based device drivers, these seem to handle all of the above
> > in the network driver that owns the PF rather than a separate driver, e.g. for
> > the first point:
> > 
> > $ git grep -w sriov_configure.= drivers/net/
> > drivers/net/ethernet/amazon/ena/ena_netdev.c:   .sriov_configure =
> > pci_sriov_configure_simple,
> > drivers/net/ethernet/amd/pds_core/main.c:       .sriov_configure =
> > pdsc_sriov_configure,
> > drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:       .sriov_configure =
> > bnx2x_sriov_configure,
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:      .sriov_configure =
> > bnxt_sriov_configure,
> > drivers/net/ethernet/cavium/liquidio/lio_main.c:        .sriov_configure =
> > liquidio_enable_sriov,
> > drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        .sriov_configure =
> > cxgb4_iov_configure,
> > drivers/net/ethernet/emulex/benet/be_main.c:    .sriov_configure =
> > be_pci_sriov_configure,
> > drivers/net/ethernet/freescale/enetc/enetc_pf.c:        .sriov_configure =
> > enetc_sriov_configure,
> > drivers/net/ethernet/fungible/funeth/funeth_main.c:     .sriov_configure =
> > funeth_sriov_configure,
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        .sriov_configure =
> > hns3_pci_sriov_configure,
> > drivers/net/ethernet/huawei/hinic/hinic_main.c: .sriov_configure =
> > hinic_pci_sriov_configure,
> > drivers/net/ethernet/intel/fm10k/fm10k_pci.c:   .sriov_configure        =
> > fm10k_iov_configure,
> > drivers/net/ethernet/intel/i40e/i40e_main.c:    .sriov_configure =
> > i40e_pci_sriov_configure,
> > drivers/net/ethernet/intel/ice/ice_main.c:      .sriov_configure =
> > ice_sriov_configure,
> > drivers/net/ethernet/intel/idpf/idpf_main.c:    .sriov_configure        =
> > idpf_sriov_configure,
> > drivers/net/ethernet/intel/igb/igb_main.c:      .sriov_configure =
> > igb_pci_sriov_configure,
> > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  .sriov_configure =
> > ixgbe_pci_sriov_configure,
> > drivers/net/ethernet/marvell/octeon_ep/octep_main.c:    .sriov_configure =
> > octep_sriov_configure,
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:   .sriov_configure =
> > otx2_sriov_configure
> > drivers/net/ethernet/netronome/nfp/nfp_main.c:  .sriov_configure        =
> > nfp_pcie_sriov_configure,
> > drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:    .sriov_configure =
> > ionic_sriov_configure,
> > drivers/net/ethernet/qlogic/qede/qede_main.c:   .sriov_configure =
> > qede_sriov_configure,
> > drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:       .sriov_configure =
> > qlcnic_pci_sriov_configure,
> > drivers/net/ethernet/sfc/ef10.c:        .sriov_configure =
> > efx_ef10_sriov_configure,
> > drivers/net/ethernet/sfc/ef100.c:       .sriov_configure =
> > ef100_pci_sriov_configure,
> > drivers/net/ethernet/sfc/ef100_nic.c:   .sriov_configure =
> > IS_ENABLED(CONFIG_SFC_SRIOV) ?
> > drivers/net/ethernet/sfc/efx.c: .sriov_configure = efx_pci_sriov_configure,
> > drivers/net/ethernet/sfc/siena/efx.c:   .sriov_configure =
> > efx_pci_sriov_configure,
> > drivers/net/ethernet/sfc/siena/siena.c: .sriov_configure =
> > efx_siena_sriov_configure,
> > 
> > In what way is your hardware different from all the others?
> 
> All of above devices are network devices which implements struct net_device_ops.
> i.e Those PCI devices are networking devices which are capable of sending/receiving network packets.
> This device doesn't have networking functionality to implement struct net_device_ops, It's a simple PCIe PF
> device enables it's VFs and services any mailbox requests.

What driver handles the "mailbox requests"?  What are these requests
for?

thanks,

greg k-h

