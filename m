Return-Path: <linux-kernel+bounces-119288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9F88C6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C7A1C6355B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE6B13C83E;
	Tue, 26 Mar 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGoxXeV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069013C805;
	Tue, 26 Mar 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466289; cv=none; b=BNAIQ2nQVtLsUiuKPJcomB19NGDRKhzw4iS9u9wsxuJziR8pZSZDnb7iO9U/mSoikj6KAinwDK5OkPzfp1/Z0nkk6DuFjgag6GtKT3jsOqqZPJ8Kn6KOvg1qY1CCCJbRWr5iFC168to4RLgJPZrkwq2LCKJDqHuzpk8UhcOhtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466289; c=relaxed/simple;
	bh=5CFqXTRiPA7QPiMzP6jRV1zgDfIHtr1T5FItOcXiCCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+CHxwj8/oeGUKvjNEl7qq3CGB0ar5Ap5bXUjpJTc0FRWRAPf/+bkNnQn1xoeCqbkDncLNOC1R1ETrd4ptpxBci5R8yN5USHkKBP/Hnpxxr9bycJ6YHTiHfqUFe9MBjuPCcNDvH8d2eT6gTxnCBFl1Su2wIXd45OWomJwnfBpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGoxXeV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B428C43390;
	Tue, 26 Mar 2024 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466288;
	bh=5CFqXTRiPA7QPiMzP6jRV1zgDfIHtr1T5FItOcXiCCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGoxXeV41GEMH80edsOQXFQBWqYiVMBVcjgUFa/D+LbXeyWyBRKj6mHOirR3w+BCt
	 p5x8gNJpShgQwJwL29tNGXdoSxadPhXjrZLKeWqKac8C5C0/UkWSy7xnkihxuw5N0X
	 6NBos5YrWhwsUiJtz6wMqAGzjKBHvBSsxIcJ0NGnieGJ2LXCpmL+m+Gox+9IuRjG8P
	 4tZx6GXE2lMoeGAsLOdbMkXyjwcP6y2uNw662FgiHmQbV6T2Q1Mh527Kiutw9r3/ak
	 J0XohuzmVVG9V9OIxvAmAQgjDs3+C4/Syh3DC2S5D2xlMXu+mOBQqTB8baYq+UrC0C
	 hbyv1sqn5LGuQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp8Z6-000000006RV-2tuL;
	Tue, 26 Mar 2024 16:18:16 +0100
Date: Tue, 26 Mar 2024 16:18:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZgLnOHiCzo5AQzra@hovoldconsulting.com>
References: <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
 <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
 <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
 <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
 <ZgJ0okobGv5nPreG@hovoldconsulting.com>
 <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>

On Tue, Mar 26, 2024 at 10:17:13AM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Mar 26, 2024 at 3:09 AM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 04:31:53PM -0400, Luiz Augusto von Dentz wrote:
> > > On Mon, Mar 25, 2024 at 4:14 PM Johan Hovold <johan@kernel.org> wrote:

> > > > I just verified that it applies cleanly to 6.9-rc1.
> > > >
> > > >         $ git checkout tmp v6.9-rc1
> > > >         $ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
> > > >         ...
> > > >         $ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set_bda_quirk_bit_if_fwnode_exists_in_dt.mbx
> > > >         Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
> > > >         $ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
> > > >         ...
> > > >         $ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_address_endianness.mbx
> > > >         Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
> > > >         Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
> > > >         Applying: Bluetooth: add quirk for broken address properties
> > > >         Applying: Bluetooth: qca: fix device-address endianness
> > > >
> > > > Do you have anything else in your tree which may interfere? What tree is
> > > > that exactly?
> > >
> > > bluetooth-next tree, why would it be anything other than that?
> >
> > I ask because I did not see anything in either the bluetooth or
> > bluetooth-next tree which should interfere.
> >
> > And I just verified that by applying the revert followed by the series
> > to bluetooth-next. In that order it applies just fine, as expected.
> >
> > > All the
> > > CI automation is done on bluetooth-next and if you are asking to be
> > > done via bluetooth tree which is based on the latest rc that is not
> > > how things works here, we usually first apply to bluetooth-next and in
> > > case it needs to be backported then it later done via pull-request.
> >
> > The revert fixes a regression in 6.7-rc7 and should get to Linus as soon
> > as possible and I assume you have some way to get fixes into mainline
> > for the current development cycle.
> 
> Yeah I will send it later today to be included in the next rc release
> and since it is marked for stable that shall trigger the process of
> backporting it.
> 
> > The series fixes a critical bug in the Qualcomm driver and should
> > similarly get into mainline as soon as possible to avoid having people
> > unknowingly start relying on the broken behaviour (reversed address).
> > The bug in this case is older, but since the bug is severe and we're
> > only at rc1, I don't think this one should wait for 6.10 either.
> 
> The revert is now pushed, I had to apply it manually though since it
> didn't apply cleanly, that said the other set still don't apply:

I have no idea what you did here but you need to drop that commit
immediately, it's completely messed up:

	https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=1b2cc5c2e5a666bdaa57a7a3964a2fe2afefb667

This is the revert:

	https://lore.kernel.org/lkml/20240314084412.1127-1-johan+linaro@kernel.org/

and as you can see your commit bears no resemblance to the revert
(instead it includes code from the below series which obviously then
fails to apply):

> Applying: Bluetooth: qca: fix device-address endianness
> error: patch failed: drivers/bluetooth/btqca.c:826
> error: drivers/bluetooth/btqca.c: patch does not apply
> error: drivers/bluetooth/hci_qca.c: does not match index
> Patch failed at 0004 Bluetooth: qca: fix device-address endianness
> 
> So please rebase and send a v5.

There should be no need to resend as the problem is clearly on your end.

Just drop whatever you applied and start fresh:

> > > >         $ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
> > > >         ...
> > > >         $ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set_bda_quirk_bit_if_fwnode_exists_in_dt.mbx
> > > >         Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"

This is the revert from this thread.

> > > >         $ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
> > > >         ...
> > > >         $ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_address_endianness.mbx
> > > >         Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
> > > >         Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
> > > >         Applying: Bluetooth: add quirk for broken address properties
> > > >         Applying: Bluetooth: qca: fix device-address endianness

And this is the follow-on series that depends on the revert.

Johan

