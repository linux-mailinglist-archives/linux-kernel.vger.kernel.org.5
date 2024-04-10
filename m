Return-Path: <linux-kernel+bounces-139292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5E8A010D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8991C224D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29320181B9F;
	Wed, 10 Apr 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2SAOGBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5AA181B8E;
	Wed, 10 Apr 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779775; cv=none; b=Y8En0F7acbMx9l7ToKGmcwSCOXyXlMyALwMB4LVM7FGxz83w8QVQHohTZ/BU5wqe/IOPnAO6jUjuiuLcIXu12M6VgwyRCpWAAEFULPmGs9aAmB7FQEyc3nDOtO676KvaiJiNhKagOdCS+EIQVHHkumYE7zUaYuon+mVOYFYoEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779775; c=relaxed/simple;
	bh=BOYXvdkLCj/ZV6DxgWGFqH21HfxALiLHSY70/wtzsxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV7303qiiJ6FpU5R4AHmUL1xmpk1Ocaea3/0KKRNsLRxNsD1I8zivpCGMlpvNotSv6zFmYxY0mFg+bChfkYZi9MxQFPrGKP1IxK0CkywbYT2f/lIbbZSzM5xKaWlrx0CLXhSYfoaBIXIfq+E4y42eI8DngckwDk48Pd15csVCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2SAOGBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55E9C43390;
	Wed, 10 Apr 2024 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712779774;
	bh=BOYXvdkLCj/ZV6DxgWGFqH21HfxALiLHSY70/wtzsxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2SAOGBp4cUceZ9ejWdgKNmef/cCWAbEeB/xSQVjwSOO2rG3XYFFGCmoKetcpPFo7
	 fY3G3T1VdgSBh9LCXVBAjJ4FKOfFMK6wfZMntk5xfYkZ1S/pU5/s4hd2z/CWwIdVfk
	 iz1xs/z1fH0XzQj8/rrh6Ac9eCs5GSBhhsVfDTB6v75lQ1Fc5YZW95RgWNFqs8GwWP
	 GAP74HP6/oSy3MzOZBPB6ic1TlGRiHMxgiUYm+Abfrm72V88dUTBPLyJBiPLbxnsil
	 AscNcod3wm7NPSXv2O8EJYS4dgZmFH2BgPs4y5tqamzahL0mX1bs/zOR+14y3hJtm2
	 CBNT/34AldvDw==
Date: Wed, 10 Apr 2024 15:09:32 -0500
From: Rob Herring <robh@kernel.org>
To: Sudan Landge <sudanl@amazon.com>
Cc: graf@amazon.de, tytso@mit.edu, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, xmarcalx@amazon.co.uk,
	robh+dt@kernel.org, Jason@zx2c4.com, bchalios@amazon.es,
	thomas.lendacky@amd.com, dwmw@amazon.co.uk,
	devicetree@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, conor+dt@kernel.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 4/5] dt-bindings: rng: Add vmgenid support
Message-ID: <171277976994.1266656.4960056294355072441.robh@kernel.org>
References: <20240409181154.9962-1-sudanl@amazon.com>
 <20240409181154.9962-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409181154.9962-5-sudanl@amazon.com>


On Tue, 09 Apr 2024 19:11:53 +0100, Sudan Landge wrote:
> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
> ACPI only device.
> 
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
> that it is executed with a different configuration (e.g. snapshot execution
> or creation from a template).
> The guest operating system can use the notification for various purposes
> such as re-initializing its random number generator etc.
> 
> As per the specs, hypervisor should provide a globally unique identified,
> or GUID via ACPI.
> 
> This patch tries to mimic the mechanism to provide the same functionality
> which is for a hypervisor/BIOS to notify the virtual machine when it is
> executed with a different configuration.
> 
> As part of this support the devicetree bindings requires the hypervisors or
> BIOS to provide a memory address which holds the GUID and an IRQ which is
> used to notify when there is a change in the GUID.
> The memory exposed in the DT should follow the rules defined in the
> vmgenid spec mentioned above.
> 
> *Reason for this change*:
> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
> Without going into details of why a hypervisor would choose DT over ACPI,
> we would like to highlight that the hypervisors that have chose devicetree
> and now want to make use of the vmgenid functionality cannot do so today
> because vmgenid is an ACPI only device.
> This forces these hypervisors to change their design which could have
> undesirable impacts on their use-cases, test-scenarios etc.
> 
> vmgenid exposes to the guest a 16-byte cryptographically random number,
> the value of which changes every time it starts executing from a new
> configuration (snapshot, backup, etc.). During initialization, the device
> exposes to the guest the address of the generation ID and
> an interrupt number, which the device will use to notify the guest when
> the generation ID changes.
> These attributes can be trivially communicated via device tree bindings.
> 
> We believe that adding a devicetree binding for vmgenid is a simpler
> alternative way to expose the device to the guest than forcing the
> hypervisors to implement ACPI.
> 
> More references to vmgenid specs:
>  - https://www.qemu.org/docs/master/specs/vmgenid.html
>  - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
> machine-generation-identifier
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  .../bindings/rng/microsoft,vmgenid.yaml       | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


