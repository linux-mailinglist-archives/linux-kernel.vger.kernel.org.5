Return-Path: <linux-kernel+bounces-29904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F98314F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972381F25134
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50071125B3;
	Thu, 18 Jan 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/upmPKV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A511729;
	Thu, 18 Jan 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567229; cv=none; b=K/cUhqfnjdmHSPkwvb8/GFu93PO29Bu31GOsdQH+Hy+XgSv2V0NMMdnLfWa4f5clq8HNBg/tqd0PrqcuchnKUpYlw5SnOUy1upkgYSs94VHScOapljjBWh3vZF7eFbJayzjon9Nddpvciq89rGwmOqvcevgxKVGVSsE2xxYeLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567229; c=relaxed/simple;
	bh=Nae8yxhkYkovkItw8eTsuNr+khFIydZsusz95L+/xEI=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=dsZ29Ko4atyFO+6Gv8fZd7RjvSQf7g3zHJATRCSwH8TwdcJA7Jfg2YeKRRizQHzLRHMJXtLnRvLq2/+jqv8E9vconfBzTTOVxrARHT82mUCfEqZtirNYJ+uOge6IdApEXNlRELWkanL+xJYtbKQJ3GKMRR7vGqP4yOehMPT6XT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/upmPKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B9CC433C7;
	Thu, 18 Jan 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705567229;
	bh=Nae8yxhkYkovkItw8eTsuNr+khFIydZsusz95L+/xEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/upmPKVDD44TDRIpF4V6xyDI/dgH7sfI1UtNYg0/BhboT42VldbTAnwh8mOsyaC/
	 hE0bMJrMezddutwnFZFfDE2xc+otlnK77yr63zeoOCUiyo/X6TMpKd3Y5eE/AZ03ag
	 h4M44ftMMc+krB8lOvLZwQeoqkywiaWclPNuwWziZ/n8b9msNC7ODq+0F/crmJlstO
	 hQ564Me3eF3DLla+0kNDe/xIQbVpnnFRZ5G5oS+CW+RmTHL7Z14ytb5WqwsX3+wQ2w
	 vZl0VYKWLB9lmN7/q/WF1XKld/fvMY5aAF3d4Eux4/EPlGoqi6k8Q/VcPqGHtjEN39
	 IKlUKioytNwAQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQNwx-0001xg-08;
	Thu, 18 Jan 2024 09:40:35 +0100
Date: Thu, 18 Jan 2024 09:40:35 +0100
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
Message-ID: <ZajkA6oxtMcxKY4X@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
 <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com>
 <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
 <CABBYNZJ_EAuGEdeW+vZzXu20nVqLkLwiQbYQ9XzoABxQ5rAzdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ_EAuGEdeW+vZzXu20nVqLkLwiQbYQ9XzoABxQ5rAzdQ@mail.gmail.com>

On Wed, Jan 17, 2024 at 05:49:07PM -0500, Luiz Augusto von Dentz wrote:
> On Wed, Jan 10, 2024 at 3:12 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Jan 09, 2024 at 05:54:01PM +0000, Matthias Kaehlcke wrote:

> > > hciconfig
> > > hci0:   Type: Primary  Bus: UART
> > >         BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 240:8
> > >         UP RUNNING
> > >         RX bytes:1700 acl:0 sco:0 events:95 errors:0
> > >         TX bytes:128949 acl:0 sco:0 commands:578 errors:0
> >
> > And any user space tool overriding the address would currently need to
> > provide the address in reverse order on Qualcomm platforms like this
> > one (e.g. if generating the address for privacy reasons).
> 
> Perhaps we could attempt to resolve the address byteorder, in
> userspace we use hwdb_get_company to resolve the company but since
> this shall only really care about Qualcomm range(s) perhaps we can
> hardcode them check in which order the address is, that said if the
> device is configured with a Static Random Address then that would not
> work, but that is only really possible for BLE only devices.

It's not just Qualcomm ranges; The Lenovo ThinkPad X13s that I noticed
this on has been assigned a Wistron OUI, for example.

We're still hoping to learn how to retrieve this address (from the
secure world firmware) so that we can set it directly from the driver,
but for now it needs to be set using btmgmt (or the local-bd-address
devicetree property).

As was discussed here:

	https://github.com/bluez/bluez/issues/107

it would be useful to teach bluetoothd to (generate and) set an address
for devices that lack (accessible) persistent storage. And any such
generic tool would need to work using the standard interfaces and the
address endianness that those interfaces expect.

And from skimming the Bluetooth spec, I was under the impression that
random addresses applied also to non-BLE devices (e.g. requiring the two
most-significants bits to be 1).

But to summarise, I don't really see any way around fixing the Qualcomm
driver.

Johan

