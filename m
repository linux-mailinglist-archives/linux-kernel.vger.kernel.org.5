Return-Path: <linux-kernel+bounces-118446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600D88BAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982601C3066C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D6130491;
	Tue, 26 Mar 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2tAol0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CD128394;
	Tue, 26 Mar 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436956; cv=none; b=HYWEv5sBLDK8sQq+zWyBntE+e0QPxtiBL3ES0yNCw2b6JCgDHt05MxXS8yb+f3nFXrayXwtsWWB897Mrrsfcdcxa5eoMc3kfD7/8uWIN+dLvULBIYYbseDVma1wIgren1a2bibZxbAz0poevFf1dujchx/n2uutrIdQSow/9u8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436956; c=relaxed/simple;
	bh=S1+D5CctG8AMUv6EK6M5WzyBfkPV4fTXRAVv7FJqFkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUkEz95uDrswXKzl8dxd1FwfF8krHFXgd3wPFl2hvUnyZrxL+NjDzBiWxAK65++z45FYp4IxTPOiBI1FBnp3FXF5G+Df8pEZkPdD7nB020a+TEsY/GgBTIicSwW0t++DY2iwKGBy+B2mIY1VYzIPscfCnpla8sw+WtziyTyxJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2tAol0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AE2C433C7;
	Tue, 26 Mar 2024 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711436955;
	bh=S1+D5CctG8AMUv6EK6M5WzyBfkPV4fTXRAVv7FJqFkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2tAol0CxU9tomWHC/iz/dFozSU/D59ojiuI/3zLTetuGVO/oo53gqCkFAjGte4fo
	 OgTaF/oL32d4rpcz4jpKxZ5qi4ho8M8KM9iM4rPJq2fb2+eAacq7uAMh2B0rfyd4TQ
	 C9doQKhvnHmOfXgHKXqXMB8jGLcbieY0ce5C83YP/2Jxx84vYPC+DVXF047sSClPjs
	 qctSgRjmbz1s35PsYz8G6J1n+Qp/XNJ64DuBVX5iBJgzFsaYGXWGlffbT0c8nLgsHi
	 30MWDlByuga01WNoMg8HG18fZTn3QX7dUxzxfd+VOb/wNDdnj3zPrsV22u2ZZaURBW
	 WjuEBLEm8qkyQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp0vy-000000004q7-21w1;
	Tue, 26 Mar 2024 08:09:23 +0100
Date: Tue, 26 Mar 2024 08:09:22 +0100
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
Message-ID: <ZgJ0okobGv5nPreG@hovoldconsulting.com>
References: <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
 <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
 <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
 <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
 <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>

On Mon, Mar 25, 2024 at 04:31:53PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Mar 25, 2024 at 4:14 PM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 04:07:03PM -0400, Luiz Augusto von Dentz wrote:

> > > Probably needs rebasing:
> > >
> > > Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
> > > error: drivers/bluetooth/hci_qca.c: does not match index
> > > Patch failed at 0001 Revert "Bluetooth: hci_qca: Set BDA quirk bit if
> > > fwnode exists in DT"
> >
> > I just verified that it applies cleanly to 6.9-rc1.
> >
> >         $ git checkout tmp v6.9-rc1
> >         $ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
> >         ...
> >         $ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set_bda_quirk_bit_if_fwnode_exists_in_dt.mbx
> >         Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
> >         $ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
> >         ...
> >         $ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_address_endianness.mbx
> >         Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
> >         Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
> >         Applying: Bluetooth: add quirk for broken address properties
> >         Applying: Bluetooth: qca: fix device-address endianness
> >
> > Do you have anything else in your tree which may interfere? What tree is
> > that exactly?
> 
> bluetooth-next tree, why would it be anything other than that?

I ask because I did not see anything in either the bluetooth or
bluetooth-next tree which should interfere.

And I just verified that by applying the revert followed by the series
to bluetooth-next. In that order it applies just fine, as expected.

> All the
> CI automation is done on bluetooth-next and if you are asking to be
> done via bluetooth tree which is based on the latest rc that is not
> how things works here, we usually first apply to bluetooth-next and in
> case it needs to be backported then it later done via pull-request.

The revert fixes a regression in 6.7-rc7 and should get to Linus as soon
as possible and I assume you have some way to get fixes into mainline
for the current development cycle.

The series fixes a critical bug in the Qualcomm driver and should
similarly get into mainline as soon as possible to avoid having people
unknowingly start relying on the broken behaviour (reversed address).
The bug in this case is older, but since the bug is severe and we're
only at rc1, I don't think this one should wait for 6.10 either.

Johan

