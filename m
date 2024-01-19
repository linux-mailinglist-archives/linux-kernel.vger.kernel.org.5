Return-Path: <linux-kernel+bounces-31330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FC832C98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CEAB22F79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052E54BF7;
	Fri, 19 Jan 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7EY+w5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623954BE0;
	Fri, 19 Jan 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679985; cv=none; b=BuPkBh8T1HXRbf7xQSYN3byr9tS89s+HtfLIG7Q4pEH9PECXT782tN5YysgwpGGgvgUb1Ln/ddFIRVIczOiieCOzG/vPM/fiXS5fXBfXL9iEnOCk7Ps8PALDcxqJSUDPtQM/ZWcEx0pEtXFfOIPDHes0WJNfK/WRHoWxDE7LmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679985; c=relaxed/simple;
	bh=gfrLkbtYzKFT46/9XEwPAniAWGb9wlDVWjw8A1etnwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUqdfxp4rfjaruaVoWKDxsALEpHDR02SoF5oUiKbY8YZruAG8zWgCfOQatkJYv450JPgoM7hgQlOlKwwNGzQSDpuhg/erP2mAT0JL8AKJl/nJgTBo1al0bprnNNPSLcedipHdDRuqqBzpXNmv3uPDnVJloYG2+s3C+5QKyIIDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7EY+w5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86EC433C7;
	Fri, 19 Jan 2024 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705679984;
	bh=gfrLkbtYzKFT46/9XEwPAniAWGb9wlDVWjw8A1etnwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7EY+w5rLd3kuXBKR/USovrJ/5x/r2dnnDn3X97Oojo4GsESiMMNcGj29ChZbiWc/
	 d89FHJFHOTxIZDMVw8ryaYK20WbLvQShYga0FW0zA5qwJ7SMxbIBrIJN0xnkKAqDcv
	 eTsBxukaHO1r8kQ/Ce1/veZeqEuVrDaV7V6k56UXCXNtZ7JUwHcDrlPP4UGFQaoIez
	 0r+K/4Aw7S0rPUMxny3bIxFJ4JuczSpUO/yb25D3gCUxfZKXOm/xABB7TOVHOjOtpH
	 5U8x3Ier/jUQD7wrNs4V53nB2qAJOCDlb5FdnYiwl5LYKHAgPNek36xUmuVrQVCMf3
	 /6SUKh1MCItqw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQrHd-0004jx-28;
	Fri, 19 Jan 2024 16:59:54 +0100
Date: Fri, 19 Jan 2024 16:59:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Doug Anderson <dianders@google.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZaqcefHE2LAnRRRz@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
 <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com>
 <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
 <CABBYNZJ_EAuGEdeW+vZzXu20nVqLkLwiQbYQ9XzoABxQ5rAzdQ@mail.gmail.com>
 <ZajkA6oxtMcxKY4X@hovoldconsulting.com>
 <CABBYNZLV9o9hsYGVTGA7dPby-j1P_a35yNrDy4d9PMJq=TaRsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLV9o9hsYGVTGA7dPby-j1P_a35yNrDy4d9PMJq=TaRsQ@mail.gmail.com>

On Thu, Jan 18, 2024 at 10:30:50AM -0500, Luiz Augusto von Dentz wrote:
> On Thu, Jan 18, 2024 at 3:40 AM Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Jan 17, 2024 at 05:49:07PM -0500, Luiz Augusto von Dentz wrote:
> > > On Wed, Jan 10, 2024 at 3:12 AM Johan Hovold <johan@kernel.org> wrote:
> > > > On Tue, Jan 09, 2024 at 05:54:01PM +0000, Matthias Kaehlcke wrote:

> > > > And any user space tool overriding the address would currently need to
> > > > provide the address in reverse order on Qualcomm platforms like this
> > > > one (e.g. if generating the address for privacy reasons).
> > >
> > > Perhaps we could attempt to resolve the address byteorder, in
> > > userspace we use hwdb_get_company to resolve the company but since
> > > this shall only really care about Qualcomm range(s) perhaps we can
> > > hardcode them check in which order the address is, that said if the
> > > device is configured with a Static Random Address then that would not
> > > work, but that is only really possible for BLE only devices.
> >
> > It's not just Qualcomm ranges; The Lenovo ThinkPad X13s that I noticed
> > this on has been assigned a Wistron OUI, for example.
> 
> Well we could still attempt to check if it has a valid OUI and then it
> fail swap and check again.

So in the kernel you would parse any address coming from firmware or
user space to try to determine if it's given in reverse order? I don't
see how this would work as presumably some of the least significant
bytes would occasionally match a valid OUI even if you were somehow able
to determine that.

> > We're still hoping to learn how to retrieve this address (from the
> > secure world firmware) so that we can set it directly from the driver,
> > but for now it needs to be set using btmgmt (or the local-bd-address
> > devicetree property).
> >
> > As was discussed here:
> >
> >         https://github.com/bluez/bluez/issues/107
> >
> > it would be useful to teach bluetoothd to (generate and) set an address
> > for devices that lack (accessible) persistent storage. And any such
> > generic tool would need to work using the standard interfaces and the
> > address endianness that those interfaces expect.
> 
> Yep, patches are welcome in this regard, note that we do something like this:
> 
> https://github.com/bluez/bluez/blob/master/src/adapter.c#L9847
> 
> But the first thing it checks is if the controller supports BR/EDR, so
> if you want to extend that we need at least the OUI portion to be able
> to allocate a valid public address, we could perhaps attempt to fetch
> the manufacturer somehow or use the controller manufacturer
> (adapter->manufacturer) in case there is nothing else to use.

Thanks for the pointer. I'm trying nudge some of the distro folks to
look into this.

> > And from skimming the Bluetooth spec, I was under the impression that
> > random addresses applied also to non-BLE devices (e.g. requiring the two
> > most-significants bits to be 1).
> 
> Not really, BR/EDR/classic addresses are always considered public
> addresses, the HCI interface doesn't even have an address type to be
> able to handle something like a random address or privacy for the same
> reason.

Ah, ok. Then generating an address is perhaps not an option, but reading
one out from a file and setting it would still be useful for cases like
the X13s which do have an address assigned (e.g. accessible through
windows or written on the box the machine came in).

Johan

