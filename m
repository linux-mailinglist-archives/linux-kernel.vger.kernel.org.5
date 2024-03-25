Return-Path: <linux-kernel+bounces-117907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E080988B647
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB25B29455
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20D50A98;
	Mon, 25 Mar 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrtE7cN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605612E47;
	Mon, 25 Mar 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397687; cv=none; b=pUvyQoW6zYQ6UZWJ4I/z/M5MenpJvloWiBc3gh6WO6J70wW4qpsn/kTLvAY+LqlLPq3ePDbZP2HwDwXk3fdITfCz/+MM/OC5tNTGqtPO0QTdMexE+jZYs0qM+RCJKlrttjiyfZ3B2toLhPyblpr9X4Rvki66wOrS0nCMOdm4/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397687; c=relaxed/simple;
	bh=zVzMdPH5x8S0kvUHOTov9W0NIu59GLtknLzc50ShHxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyjcNThBY9C3h30q3WnGBr+LxIfqzXbHX45EKjO/L6VO0xR0XcGPC2moFYh+cQQq2WW0/6xFmuFa0xIifiFD7XSahyWsvaP7gH5zOUKnpNHxNl+v7dTc038uDj/Nfu3MRKp4v4GEIfn/ZdB9qObJmdtbDAxQYR/A+Xr8GXY6cTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrtE7cN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA11AC433C7;
	Mon, 25 Mar 2024 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711397686;
	bh=zVzMdPH5x8S0kvUHOTov9W0NIu59GLtknLzc50ShHxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrtE7cN0Onv431Oxd3DmFgzn+O3PToH8vmAvSNGMNV6O2Q0oAGNjTJQeZXS4BDQzX
	 nJpbglY646QwSUDaR6Qw6vnJupO5JnJnWsbIpiyThMaEcv3p/e4+UUzv9L5C8kgIwP
	 QRRDCadDwOjueWAnOfKCH+SxuMxhn3G8TBgPPityvuSpnPTz1fRoaUfSvJ/j97iRGn
	 52dDC2ZvgRkp4hLFf1gyKcFm0RI5fyDArYiV0ZvnuC/+Ce/v9huRzqFMj0GETjl6De
	 A/w4mXqQ301fosRKGQeqK04OdiqM7kiElzRZmvj9LcrnkQuY91KX7uQR3VrAyqdOIH
	 CBfYZGSvybvow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roqic-000000004Wt-420I;
	Mon, 25 Mar 2024 21:14:55 +0100
Date: Mon, 25 Mar 2024 21:14:54 +0100
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
Message-ID: <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
 <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
 <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
 <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>

On Mon, Mar 25, 2024 at 04:07:03PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Mar 25, 2024 at 3:48 PM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 03:39:03PM -0400, Luiz Augusto von Dentz wrote:
> > > On Mon, Mar 25, 2024 at 1:24 PM Johan Hovold <johan@kernel.org> wrote:
> > > > On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz wrote:
> >
> > > > > I guess the following is the latest version:
> > > > >
> > > > > https://patchwork.kernel.org/project/bluetooth/list/?series=836664
> > > > >
> > > > > Or are you working on a v5?
> > > >
> > > > This patch (revert) fixes a separate issue than the series you link to
> > > > above, but it is also a prerequisite for that series.
> > > >
> > > > v4 is indeed the latest version, and it has been acked by Rob and Bjorn
> > > > so you can take it all through the Bluetooth tree. Just remember to
> > > > apply this patch (the revert) first.
> > >
> > > Doesn't seem to apply cleanly:
> > >
> > > Applying: Bluetooth: qca: fix device-address endianness
> > > error: patch failed: drivers/bluetooth/hci_qca.c:1904
> > > error: drivers/bluetooth/hci_qca.c: patch does not apply
> > > Patch failed at 0004 Bluetooth: qca: fix device-address endianness
> >
> > Did you apply this patch (the revert) before trying to apply the series?
> 
> Probably needs rebasing:
> 
> Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
> error: drivers/bluetooth/hci_qca.c: does not match index
> Patch failed at 0001 Revert "Bluetooth: hci_qca: Set BDA quirk bit if
> fwnode exists in DT"

I just verified that it applies cleanly to 6.9-rc1.

	$ git checkout tmp v6.9-rc1
	$ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
	...
	$ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set_bda_quirk_bit_if_fwnode_exists_in_dt.mbx
	Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
	$ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
	...
	$ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_address_endianness.mbx
	Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
	Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
	Applying: Bluetooth: add quirk for broken address properties
	Applying: Bluetooth: qca: fix device-address endianness

Do you have anything else in your tree which may interfere? What tree is
that exactly?

Johan

