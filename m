Return-Path: <linux-kernel+bounces-163448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27328B6B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1150C1C21870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22B374E3;
	Tue, 30 Apr 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp02gZOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5501BF20;
	Tue, 30 Apr 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460860; cv=none; b=WuxTwYcEeSZ9migh7l1zcaQnaUvnEPv+kqeIRN+LhTVxzSU8f71WUeAvtRS2oDryRB38z+ccHLd/Mdgm57rhjv19z/GaCrdKhqytw0PTZSMrF5tqGv1y9GswIMuapLhR+LWbqKQJNgOxxGJvSzSxhdvSwHvgXGM51sJewB6mDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460860; c=relaxed/simple;
	bh=TxxoVyNCTc8zKzy9eUibWwwSsZ9EVbgR21o1ZrGuGEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTeSWrXjzYxryTbiEpBBema+uTh9jmW6uLPXf3pj7cNWzYKJShOPMR46NjOyj8x7c/HA7qmtGgFlX+++f1VrqmS2vk2HjUoQ3oH4sj7uImWnsatrhyIPVVViX+mEb4mgpj5Up3XAKh3hnYQ+IOb7HG/Y/BZlq22EACVml7Yy+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp02gZOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6B9C2BBFC;
	Tue, 30 Apr 2024 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714460859;
	bh=TxxoVyNCTc8zKzy9eUibWwwSsZ9EVbgR21o1ZrGuGEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp02gZOuaCjcoryLVoJCy0y7IiN90uQXlnQ1kWz3gvaxiT03THk2OtyM1+FYr4SbQ
	 Yfzat1QYHu7zWQn8P/dN50FB69HOlQ4MzhEqgc2cuievryMl9tZ9NFwoPkL6xja3Q7
	 gsQ6m+CIndtJLJ/cP4L3RUh7kad5yEFTdLABCY/fqiW4UJ4bMEqvOjtF6QiR7eisuM
	 JYBUyJzHcnwt9e8qKvfoX5Oadz3bpzi//Mm82cNKQBfHeu6NMSFxcptB3TPKKu6L60
	 aEkGEj+tSC8VdVmSRjmviTZDy2ebVr5f7aSb+k6btejZ+/F6e+2T3Lcl8bFEIXlyyW
	 T5XY6CzBMGg4g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1haV-000000001Uw-2oBY;
	Tue, 30 Apr 2024 09:07:40 +0200
Date: Tue, 30 Apr 2024 09:07:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZjCYu2pc8376rjXk@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>

On Mon, Apr 29, 2024 at 01:31:53PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Apr 29, 2024 at 1:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > On Mon, Apr 29, 2024 at 10:02 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Mon, Apr 29, 2024 at 03:34:32PM +0530, Janaki Ramaiah Thota wrote:

> > > > Having a default BDA list from NVM BDA tag value will prevent developers
> > > > from using the device if there is no user space app(In Fluoride) to set
> > > > the BDA. Therefore, we are requesting to use default address check patch,
> > > > so that developer can change the NVM BDA to make use of the device.
> > >
> > > But a developer on such an old platform that can patch and replace the
> > > NVM configuration file should also be able to just disable the check in
> > > the driver right (e.g. by commenting out the call to
> > > qca_check_bdaddr())?
> > >
> > > >   List Of default Addresses:
> > > >   ---------------------------------------------------------
> > > > |       BDA          |      Chipset                       |
> > > >   ---------------------------------------------------------
> > > > | 39 80 10 00 00 20  |  WCN3988 with ROM Version 0x0200   |
> > > >   ---------------------------------------------------------
> > > > | 39 80 12 74 08 00  |  WCN3988 with ROM Version 0x0201   |
> > > >   ---------------------------------------------------------
> > > > | 39 90 21 64 07 00  |  WCN3990                           |
> > > >   ---------------------------------------------------------
> > > > | 39 98 00 00 5A AD  |  WCN3991                           |
> > > >   ---------------------------------------------------------
> > > > | 00 00 00 00 5A AD  |  QCA DEFAULT                       |
> > > >   ---------------------------------------------------------
> > >
> > > What about WCN6750 and 64:90:00:00:5a:ad?
> > >
> > > And then there's currently also:
> > >
> > > > > bluetooth hci0: bd_addr = 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
> > > > > bluetooth hci0: bd_addr = 61:47:aa:32:44:07 (qca/nvm_00130302.bin)
> > >
> > > Which controllers use these configurations?
> >
> > These are not unique addresses though, we can't just have addresses by
> > chipset address mapping logic as that would cause address clashes over
> > the air, e.g. if there are other devices with the same chipset in the
> > vicinity.
> 
> I see where this is going now, the firmware actually contain these
> duplicated addresses which then are checked and cause
> HCI_QUIRK_USE_BDADDR_PROPERTY then the tries
> hci_dev_get_bd_addr_from_property which loads the local-bd-address
> property from the parente device (SOC?), btw that could also have an
> invalid/duplicated address.

Right, the expectation is that vendors don't abuse this and leave the
address in the devicetree as all-zero unless the boot firmware has
access to a unique address.

HCI_QUIRK_USE_BDADDR_PROPERTY effectively implies
HCI_QUIRK_INVALID_BDADDR, that is, both quirks marks the controller
address as invalid. The only difference is that the former also goes out
and checks if there's an address in the devicetree that can be used
instead.

The 'local-bd-address' property is used on boards where the boot
firmware has access to some storage for the address and updates the
devicetree with the board-specific address before passing the DT to the
kernel.

As I've mentioned before, we should probably just drop
HCI_QUIRK_USE_BDADDR_PROPERTY eventually and always look for an address
in the devicetree when HCI_QUIRK_INVALID_BDADDR is set instead.

We could take that one step further and always let the devicetree
override the controller address as Doug suggested, but I'm not sure
that's what we want to do generally.

Either way, these are later questions.

> Anyway the fact that firmware loading itself is programming a
> potentially duplicated address already seems wrong enough to me,
> either it shall leave it as 00... or set a valid address otherwise we
> always risk missing yet another duplicate address being introduced and
> then used over the air causing all sorts of problems for users.
> 
> So to be clear, QCA firmware shall never attempt to flash anything
> other than 00:00:00:00:00:00 if you don't have a valid and unique
> identity address, so we can get rid of this table altogether.

Nothing is being flashed, but when the controller has not been
provisioned with an address, the address in the NVM configuration file
is used.

And we need to handle this in some way, as the configuration files are
already out there (e.g. in linux-firmware) and are honoured by the QCA
firmware.

My patch reads out the default address from the configuration file
before downloading it during setup() so that no matter what address is
set this way, it will be treated as non-unique and invalid.

This way we don't need to maintain any table in the kernel and we don't
risk any regressions if the address is ever changed in a later firmware
update.

The only downside is that developers on old platforms that don't have
any user space tools to set a valid address (e.g. btmgmt) cannot set
an address by patching the firmware file.

But I don't think we need to care about that. I assume that in most
cases those developers all just use the default address, with the risk
of collisions that that implies.

We have a standard APIs for configuring the address, just use that.

> ps: If the intention is to have these addresses for testing then these
> firmwares files shall probably be kept private, since as explained
> above the use of duplicated addresses will cause problems to users who
> have no idea they have to be changed.

Johan

