Return-Path: <linux-kernel+bounces-121531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D288EAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0AF8B33B03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57A14A094;
	Wed, 27 Mar 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2KYClsI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836F14A0B4;
	Wed, 27 Mar 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553138; cv=none; b=fByThnwIj1mQXhkWbqcjwAIG3WDSxtnFafGGI4R0vlHAHGOHYcubQ0Y+lb0XL/oINnX1qRXC14ggQucSufz1awEfyeBODkRG+6OxB3ZOS5FUZt6vrZ7oau+Jk3fUMkhdxufdlnpN2ooGkzNFR9Qdyke5Qqv39e8mpYvUVbqGSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553138; c=relaxed/simple;
	bh=HXxGyYs0zg9MvmwQmo/FM9aZyeFLcxqwQu3YQVRdxZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EPrlI+lPwMPdrpR4s65hYB8x4Lab2FNdeBSqG0h3gygzs8s+V5MmENvuN9QJT63oy33lKhyF8PLTjd/2syXDwJeo8K7tcaEdN5vsmugsoQAqAZx1nwePcMNfqAYIxK9W7Pu4KbSUmAXvKhjS0CxaKTEyCuzvnnj7CIBwbipNsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2KYClsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E717C43390;
	Wed, 27 Mar 2024 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553137;
	bh=HXxGyYs0zg9MvmwQmo/FM9aZyeFLcxqwQu3YQVRdxZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R2KYClsIRScmJ/cKKxoS5swCi1tsAyfZSyP+rZdJS/EGlh7hm65GHmer/OZer4VXA
	 cR8OxRcPSNnUBmD2NRkIWX4jRSIVLSNWfjG+fZ0Iu9G1G0yqvJkxU7q8Fn9c7tHRJm
	 5CsaMNOilcdgDpyU5i59zJ4JJ/OFp3tRChChyI9Dw0b7NTLVmyVGxWKGiw9f94uB2g
	 MNHiMW+/coaVZcJoAk+8Q9cMWpx2wJ5trKoVUH6iVbn24okAAQESZ1cOKqC3NS8dpD
	 sXuT4UZPXe8iUk5nT0jRBSCon47w/sY3AXrvExeNmB4GI3vzUppZ+nrHv72QB7xIjL
	 c+dRWYx96XN2w==
Date: Wed, 27 Mar 2024 10:25:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Documentation: PM: Update platform_pci_wakeup_init()
 reference
Message-ID: <20240327152535.GA1523374@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j6SaxTG9+Zr1Sk9iN_bvzzOCD+7_s98HEes1CY825epQ@mail.gmail.com>

On Wed, Mar 27, 2024 at 04:23:41PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 25, 2024 at 11:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > platform_pci_wakeup_init() was removed by d2e5f0c16ad6 ("ACPI / PCI: Rework
> > the setup and cleanup of device wakeup") but was still mentioned in the
> > documentation.
> >
> > Update the doc to refer to pci_acpi_setup(), which does the equivalent
> > work.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >
> > pci_acpi_setup() is a firmware-specific wart in this otherwise generic
> > paragraph, so maybe there's some better way to express this?
> >
> >  Documentation/power/pci.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> > index 12070320307e..e2c1fb8a569a 100644
> > --- a/Documentation/power/pci.rst
> > +++ b/Documentation/power/pci.rst
> > @@ -333,7 +333,7 @@ struct pci_dev.
> >  The PCI subsystem's first task related to device power management is to
> >  prepare the device for power management and initialize the fields of struct
> >  pci_dev used for this purpose.  This happens in two functions defined in
> > -drivers/pci/pci.c, pci_pm_init() and platform_pci_wakeup_init().
> > +drivers/pci/, pci_pm_init() and pci_acpi_setup().
> >
> >  The first of these functions checks if the device supports native PCI PM
> >  and if that's the case the offset of its power management capability structure
> > --
> 
> Applied as 6.10 material, or if you'd rather take it to the PCI tree,
> please let me know.

Thanks, your tree is fine!

Bjorn

