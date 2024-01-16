Return-Path: <linux-kernel+bounces-27109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8682EA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9B1F24059
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515811720;
	Tue, 16 Jan 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMOKEMUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995ED11C8B;
	Tue, 16 Jan 2024 08:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3284C433F1;
	Tue, 16 Jan 2024 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705392139;
	bh=tqwbL1wZkG3eopT8VYrtB5JmEZOy13U2Fa2XVhrTzMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMOKEMUi3jOrrd/RBoQXAkwTU0BKtsRJZoCSu0nhf/bbvq8+nhkZbr38HgA7sXhQU
	 5Dy2ghEEtpeO5dzLb2mNIG4Z+ECEfL2AMt3URPulliNgRwVjHwBj91IBzHCcunU/ny
	 rjs95bHVkhzm0feiL+Y4BjbB4a2kX+sW5MoTJIdE=
Date: Tue, 16 Jan 2024 09:02:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: host: xhci-plat: Add support for
 XHCI_SG_TRB_CACHE_SIZE_QUIRK
Message-ID: <2024011619-equate-polar-aa2a@gregkh>
References: <20240116055816.1169821-1-quic_prashk@quicinc.com>
 <20240116055816.1169821-3-quic_prashk@quicinc.com>
 <f0dd0455-e278-ee28-5463-34879ad9868c@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0dd0455-e278-ee28-5463-34879ad9868c@omp.ru>

On Tue, Jan 16, 2024 at 10:53:11AM +0300, Sergey Shtylyov wrote:
> On 1/16/24 8:58 AM, Prashanth K wrote:
> 
> > Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
> > XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
> 
>    It's xHCI. :-)
> 
> > which fixes XHC timeout, which was seen on synopsys XHCs while
> 
>    xHC.
> 
> > using SG buffers. Currently this quirk can only be set using
> > xhci private data. But there are some drivers like dwc3/host.c
> > which adds adds quirks using software node for xhci device.
> 
>    Double "adds".

I know I have said this before, but please don't be so pedantic at
times, it's just not helpful at all.  All of these are just fine to
ignore.

thanks,

greg k-h

