Return-Path: <linux-kernel+bounces-166506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83438B9B97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2509A1C211BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2884DF5;
	Thu,  2 May 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEdNcM2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DC83CC5;
	Thu,  2 May 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656344; cv=none; b=Nm7lUq51pP1+3aoMTxLTJx6ktFy3oDeGyEdn2wcpUEstQhz7nGjPiDEOVj0byMeJZ/f5KvuaBlLuN5clBQb1Z+VLCK86ahy/kBOPAMHALGFIrTAtFAgbP2qrdDEmqZznWZmqrDiYsdZoYJTxRzN2dvz4ZJh3FZGm1cX+jiRNQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656344; c=relaxed/simple;
	bh=DvfYRYHvgsxTSZyqjmlAyayx/56nh7hHtnI5bpCN+2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om4UT7KPRNBE4HiU9RPZBwBMsoTCf3lgvsUXnxs7gBnnY6lNc3k+UUIbowazaXtFjrRG76iAUi6KkYkifhAGsKZqsx8aHGjj5T7eiLbSH7+73i+FLAiXyHGp/NW+ubAf+xo14siJEJeZ2tUvaoOFGB3+EPNjcvuzOzFaOfNR+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEdNcM2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8FEC113CC;
	Thu,  2 May 2024 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714656344;
	bh=DvfYRYHvgsxTSZyqjmlAyayx/56nh7hHtnI5bpCN+2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEdNcM2I17MtW0rDVTMcO7IfhLLuPazC6GauJKMHdiAZqQBcSdFA0skf2gOaS/nas
	 EUorKlh9C5JHh/w5eoEaoMM7/ANVHSZPSJH9veMQexzc7AAzpiVyeHXUoNv05x4m+U
	 q/FCWWHMN8L/Ma9G/u9zlAsjtYiJspcrk7d5/lxPvA4gs39JjX/2Til1w2860sKdZJ
	 7HBCWrq6lMlgLoaLyBsE/gxxZO+igJca3I/9kv7Op3gOb//YsoCR2YCLXu4HAVkOli
	 1AtStUb1lm/u8uEUPSU90pX561aJJmodtpt97uIC4it8HeFUs4WxKfIhQsA9z0Vbi6
	 QkH6DHAjqLRmQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2WRW-000000005WP-3Swo;
	Thu, 02 May 2024 15:25:47 +0200
Date: Thu, 2 May 2024 15:25:46 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Tim Jiang <quic_tjiang@quicinc.com>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA NVM file for the X13s (WCN6855)
Message-ID: <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>

On Thu, May 02, 2024 at 08:56:12PM +0800, quic_zijuhu wrote:
> On 5/2/2024 6:57 PM, Johan Hovold wrote:

> > I noticed that you have both submitted firmware and NVM files for
> > QCA2066 to linux-firmware. [1][2]
> > 
> > I'm working on Linux support for the Lenovo ThinkPad X13s (Windows on
> > Arm, Snapdragon), which has the related WCN6855 controller that uses the
> > same firmware (hpbtfw21.tlv).

> which SOC type does the machine use?  WCN6855 or QCA2066?

It's WCN6855 but the Linux driver currently uses the firmware you pushed
for QCA2066.

> > The current Linux driver is using the generic NVM file (hpnv21.bin) for
> > WCN6855, but connectivity is quite bad and I only get 2-3 meters of
> > range.

> > > Switching to the board-specific NVM configuration (hpnv21b.b8c) that
> it seems hpnv21b.b8c is a wrong NVM name.
> is it hpnv21g.b8c?

I've only tested with the NVM file without the "g" infix, but there
indeed also is a 'hpnv21g.b8c' in the Windows installation.

What is the difference between those two?

> > came with the Windows driver make all issues go away and the range is
> > really good, but I'm not sure if that file is fully compatible with the
> > firmware used by the Linux driver.
> > 
> > Could you help us submit an NVM configuration file for the controller
> > with board id 0x008c to linux-firmware?
> > 
> For Windows OS, there are relevant channel to deliver BT firmware.
> For Linux OS, we normally upload relevant BT firmware to linux-firmware.
> 
> it seems customer would like to use Linux OS instead of preinstalled
> Windows OS for the machine.
> right?

Exactly. It's a Lenovo machine that comes with Windows pre-installed and
we're working on enabling Linux on it with some help from Lenovo.

> need customer to make a request for their requirements if the answer is
> yes for above question.

Lenovo has made requests for X13s firmware from Qualcomm and pushed it
to linux-firmware [1], but they have not yet been able to get Qualcomm
to provide an NVM configuration file for Bluetooth (I think the problem
may be finding the right person to talk to inside Qualcomm).

So I was hoping maybe you could help us with this since the difference
between 'hpnv21.bin' that you pushed to linux-firmware and what came
with Windows appears to be really small (e.g. just a few bytes).

Johan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qcom?id=4ae4ae88918928e15006eb129ad981aa58216b59

