Return-Path: <linux-kernel+bounces-130423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A708977DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4BF1F2193C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CC153511;
	Wed,  3 Apr 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuW9hdd6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357D17C98;
	Wed,  3 Apr 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167879; cv=none; b=YHJRtbiSvu5BYdBuJkavFl2cZB5Cp27gNbWFMTQ+73E+JY8TlcR1lN5QOd9tL9WAsBytPAxvszo11dGyuoChhNi0wjw+4WLOEiv4UOVuh6WF4o4WiDL+ssaOyDNOWK9lWErxcu4a8WK5PWdmVUkkcIgJsr1gwj8IiXiq1R71Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167879; c=relaxed/simple;
	bh=cW+1HWqnie4/n+kUXN9FoZATD7nr4nMkde58cSOxrkI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KcniAXPOMVC4Fh+AJqNlWeCmJTdEM5epKqieE2S8ssd/jbxdxSYyI+TwcHAUw+RbuY+CGv6thl8cy+d8fV5d8K5k5ZPXg6h8CJ24AigQ6EEHBwls8GtEdzvYdfBASDAhoOJtdv2+yOTVSjRXEfVCRTEAW0h2VrXX1LzLEoyk6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuW9hdd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3577C433F1;
	Wed,  3 Apr 2024 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712167879;
	bh=cW+1HWqnie4/n+kUXN9FoZATD7nr4nMkde58cSOxrkI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uuW9hdd6u7gpsFeThusi2JMFwN4+vxAt8XFb16nGKo1Nyp69VaGyDfoRackM4inlO
	 DBbu+JCgKCrTS04jzUXkHojCJaPNT4745zjnw/9eufqgpzb3rSQCAXLtixJqqoZy9O
	 Uw8cOCBMggl59tJfeIDd3UIJcvvUBu4biuFsJ/pLV7LOS25ChF16cTFs9RI0L0gRxx
	 xBM0mMMTO5zwJBw5ZfaQMwPyS6xporcdMR6tgKxDPj+D60KIHf33qOuV+WVYQKP0Vh
	 K848vaDgwX6lECAjkc8Yn7RHF0xyF9SkQUoZRCLGHPcQUqorhqZ5/kjvTeZBvnV5gA
	 NuImwKmbCpmCg==
Date: Wed, 3 Apr 2024 20:11:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Max Staudt <max@enpas.org>
cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
In-Reply-To: <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2404032010320.5680@cbobk.fhfr.pm>
References: <20240207163647.15792-1-max@enpas.org> <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, Jiri Kosina wrote:

> > Dear hid-playstation maintainers,
> > 
> > Here is v2 of my patch series, with the discussed changes.
> > 
> > 
> > Differences since v1:
> >  - Dropped patch for 7545:0104 (SZ-MYPOWER controllers)
> >  - Dropped patch for DS4 clones without a MAC address on USB
> >  - Changed hid_err() to hid_warn() where things are no longer fatal
> >  - Simplified goto as return in minimal report parsing
> > 
> > 
> > I've included the patch to simplify the PID/VID mapping to controller
> > types, since the previous discussion made it sound useful for future
> > support of second-party controllers. Please feel free to drop it if you
> > don't think it's relevant now.
> > 
> > 
> > Thanks for your feedback!
> > 
> > Max
> > 
> > 
> > Patches in this series:
> >   [PATCH v2 1/5] HID: playstation: DS4: Fix LED blinking
> >   [PATCH v2 2/5] HID: playstation: DS4: Don't fail on FW/HW version
> >   [PATCH v2 3/5] HID: playstation: DS4: Don't fail on calibration data
> >   [PATCH v2 4/5] HID: playstation: DS4: Parse minimal report 0x01
> >   [PATCH v2 5/5] HID: playstation: Simplify device type ID
> 
> Roderick, any word on this series please?

Roderick, please speak up now, or I'll queue this as-is for 6.10 in the 
coming few days. Thanks,

-- 
Jiri Kosina
SUSE Labs


