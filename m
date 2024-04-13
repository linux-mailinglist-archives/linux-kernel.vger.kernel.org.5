Return-Path: <linux-kernel+bounces-143850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465328A3E31
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41B1281FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084BB53802;
	Sat, 13 Apr 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ctHpPj2P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4rKpyCs"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5945941
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713035501; cv=none; b=QwgqdmWwMYo/FtLk4wtEJF0MgQOwTLqieYHog6cVxQR3IOw6MBbFl4n8LkrKIxsGaweTDo2CAW3PCP+88mndp56skEBLmQHdUOqhv+mgiCKO2lFbVjwFF+vpIQnqNnkNNW9JdC8dsgMRXj+lU+6aEIGABTm8B1EwAPrR3RQ2G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713035501; c=relaxed/simple;
	bh=6bj15aLSjX7l5nwcn+kIZdI8pZmBYJUBOrIhchveqjA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HpWPmhjx2v7wmokcK6XsF8pAMSLZQ+KrCEvTf1cVSy/DRcaYtXEWCCBPRPuMgrzOp66P4XAX/XFGHkxU6JmAqFDGKDCgmeAxwO3qcBraswa01Zp6+WqjQPry+5w9GsR6hy9zbnOBvLZV6DAsWXmtLnHwH/QQJLejCyqU3VPsr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ctHpPj2P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x4rKpyCs; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CD45F1C000CF;
	Sat, 13 Apr 2024 15:11:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 13 Apr 2024 15:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713035497; x=1713121897; bh=rx3Lv7nakm
	8QuMyFyr2z7BR0YjGKMeUSkMp0y+XXhGI=; b=ctHpPj2Ps/IcAa9lJSGGiEWlps
	9MaY6EN8HKfUFhjfpZrJJsg4SW3Wh+TQEw5az6WzjARn3KMjpik+5xATTV5ReLin
	V+IlQlzf96xFxpdDMNTRwMe00tbdy8gKq01BuoNGu5xAH+EkVwc/afEmqVYE6wEi
	MGHkgRh/C1Mv4HbLz6BRTa1xa8nMbQSww8ruapqL0t08VJAVfU4PfSBGw7BIeFVJ
	q6opF38k/xO/1MUEpx7ijEOtNYzfdQscU9jtwQXK5Qdb+x/R9y5O+WvOoBqdmbQg
	22N3fTnVIAqem3Nzf0w/LSfMwL+Lswi4lF0ZT5Jml4okYRTjGPl7DW6pwYdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713035497; x=1713121897; bh=rx3Lv7nakm8QuMyFyr2z7BR0YjGK
	MeUSkMp0y+XXhGI=; b=x4rKpyCsdKzhdAEU7WXyTYjG7YdN2B82/ofHG/asjXa+
	jMR0ZxOrhPrYjHQxu9pEDjwsuhMuDg7wRMnZ056u4NTduMz3l3a9CcH7+qnxi8p5
	ChvrZn6HOhgunq+1gRVXuap4RxGNsn688yPx9BDCtfluUt8YSTa1syphbx21CLT1
	raEl45ZUgP6xXrWxEpcbWx4QLax/KNERXb2LInJ97BdFD84Q6bPS2zQqQZiu3QDb
	QCDHp+al8CdvdLcNGw2g1pUQDvHXWZvtUd4mhfzYn+GHt1+ouvdvgHbNkf46sAPq
	iJystZXSS1UI6avk+W1CwXzUY9pLJyK+2zQJriQXBQ==
X-ME-Sender: <xms:6dgaZunD6DM4722Y5biDNGorA3D_gNglELnaxkh9GB5eYPx2Aw17hA>
    <xme:6dgaZl3c4CqYy5UywLd3kmhyxOp3wfmd2XJDohe2NHgclUPNsnt3bjT-6OfiejU1K
    aP2_izHd1-c6pBIEF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6dgaZsq51QqFa_NcOSXES_CpGgOgYjfB7yGaNDaCiQ7jCMxshNi5KQ>
    <xmx:6dgaZikDB1mrG1fMY_WRtUlL7OBpKhzPbOVlbKVd5JNOtpCGKyvBZA>
    <xmx:6dgaZs3y4uhP4McXBwr3mC5brIFNJOZdOKVGT08LJcp9w0VGCgN4YA>
    <xmx:6dgaZpsrqCp4dRJSrtu-1yp3YaSUEPkaSJ8Yy8xwdboK21oTFhKr3Q>
    <xmx:6dgaZpxJ0moLczN_7n_zIER715YyXwcvPYvg3k6QrNtosfAasBqUvMRo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EB37DB6008D; Sat, 13 Apr 2024 15:11:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5d400e6-9e4a-4f5d-b48f-a75c65ec1ae8@app.fastmail.com>
In-Reply-To: 
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041310-bundle-patio-8a22@gregkh>
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
Date: Sat, 13 Apr 2024 21:11:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jerin Jacob" <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Content-Type: text/plain

On Sat, Apr 13, 2024, at 18:17, Vamsi Krishna Attunuru wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
>> On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru wrote:
>> > From: Greg KH <gregkh@linuxfoundation.org>
>> >
>> > No, it's a normal PCIe sriov capability implemented in all sriov capable PCIe
>> devices.
>> > Our PF device aka this driver in kernel space service mailbox requests
>> > from userspace applications via VF devices. For instance, DPI VF
>> > device from user space writes into mailbox registers and the DPI hardware
>> triggers an interrupt to DPI PF device.
>> > Upon PF interrupt, this driver services the mailbox requests.
>> 
>> Isn't that a "normal" PCI thing?  How is this different from other devices that
>> have VF?
>
> Looks like there is a lot of confusion for this device. Let me explain
> There are two aspects for this DPI PF device.
> a) It's a PCIe device so it is "using" some of the PCI services 
> provided PCIe HW or PCI subsystem
> b) It is "providing" non PCIe service(DPI HW administrative function) 
> by using (a)
> Let me enumerate PF device operations with above aspects.
> 1) Means to create VF(s) from PF. It's category (a) service and driver 
> uses API (pci_sriov_configure_simple()) from PCI subsystem to implement 
> it.
> 2) Means to get the interrupt(mailbox or any device specific 
> interrupt). It's category (a) service and driver uses API 
> (pci_alloc_irq_vectors()) from PCI subsystem to implement it.
> 3) Means to get the mailbox content from VF by using (2). It's category 
> (b) service. This service is not part of PCI specification.
> DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA registers) 
> in its PCIe BAR space which are device specific.
> 4) Upon receiving DPI HW administrative function mailbox request, 
> service it. Its category (b) service. This service is not part of PCI 
> specification.
> For instance, dpi_queue_open & close are requests sent from DPI VF 
> device to DPI PF device for setting up the DPI VF queue resources. Once 
> its setup by DPI PF,
> then DPI VF device can use these queues. These queues are not part of 
> PCIe specification. These queues are used for making DMA by DPI VF 
> device/driver.

It's not directly my area either, but as far as I can tell
from reading the competing sr-iov based device drivers, these
seem to handle all of the above in the network driver that
owns the PF rather than a separate driver, e.g. for the
first point:

$ git grep -w sriov_configure.= drivers/net/
drivers/net/ethernet/amazon/ena/ena_netdev.c:   .sriov_configure = pci_sriov_configure_simple,
drivers/net/ethernet/amd/pds_core/main.c:       .sriov_configure = pdsc_sriov_configure,
drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:       .sriov_configure = bnx2x_sriov_configure,
drivers/net/ethernet/broadcom/bnxt/bnxt.c:      .sriov_configure = bnxt_sriov_configure,
drivers/net/ethernet/cavium/liquidio/lio_main.c:        .sriov_configure = liquidio_enable_sriov,
drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        .sriov_configure = cxgb4_iov_configure,
drivers/net/ethernet/emulex/benet/be_main.c:    .sriov_configure = be_pci_sriov_configure,
drivers/net/ethernet/freescale/enetc/enetc_pf.c:        .sriov_configure = enetc_sriov_configure,
drivers/net/ethernet/fungible/funeth/funeth_main.c:     .sriov_configure = funeth_sriov_configure,
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        .sriov_configure = hns3_pci_sriov_configure,
drivers/net/ethernet/huawei/hinic/hinic_main.c: .sriov_configure = hinic_pci_sriov_configure,
drivers/net/ethernet/intel/fm10k/fm10k_pci.c:   .sriov_configure        = fm10k_iov_configure,
drivers/net/ethernet/intel/i40e/i40e_main.c:    .sriov_configure = i40e_pci_sriov_configure,
drivers/net/ethernet/intel/ice/ice_main.c:      .sriov_configure = ice_sriov_configure,
drivers/net/ethernet/intel/idpf/idpf_main.c:    .sriov_configure        = idpf_sriov_configure,
drivers/net/ethernet/intel/igb/igb_main.c:      .sriov_configure = igb_pci_sriov_configure,
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  .sriov_configure = ixgbe_pci_sriov_configure,
drivers/net/ethernet/marvell/octeon_ep/octep_main.c:    .sriov_configure = octep_sriov_configure,
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:   .sriov_configure = otx2_sriov_configure
drivers/net/ethernet/netronome/nfp/nfp_main.c:  .sriov_configure        = nfp_pcie_sriov_configure,
drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:    .sriov_configure = ionic_sriov_configure,
drivers/net/ethernet/qlogic/qede/qede_main.c:   .sriov_configure = qede_sriov_configure,
drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:       .sriov_configure = qlcnic_pci_sriov_configure,
drivers/net/ethernet/sfc/ef10.c:        .sriov_configure = efx_ef10_sriov_configure,
drivers/net/ethernet/sfc/ef100.c:       .sriov_configure = ef100_pci_sriov_configure,
drivers/net/ethernet/sfc/ef100_nic.c:   .sriov_configure = IS_ENABLED(CONFIG_SFC_SRIOV) ?
drivers/net/ethernet/sfc/efx.c: .sriov_configure = efx_pci_sriov_configure,
drivers/net/ethernet/sfc/siena/efx.c:   .sriov_configure = efx_pci_sriov_configure,
drivers/net/ethernet/sfc/siena/siena.c: .sriov_configure = efx_siena_sriov_configure,

In what way is your hardware different from all the others?

     Arnd

