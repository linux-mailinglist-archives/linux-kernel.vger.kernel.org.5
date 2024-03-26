Return-Path: <linux-kernel+bounces-118221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE388B645
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359172E8EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DAB18E1E;
	Tue, 26 Mar 2024 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="P3v+DbSr"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463B1B285
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413763; cv=none; b=lmCJ24nDQpWzyjjDM1oWaD4WGa6ZLm+2T25olyJNbPLNA3qC/wQcQ9m0z66F3mFDU9FaD/Cx3DjSROtiP5mBRn6SLZom0f5DyEPQYWIzTjAb4Zko9mFJCieOhDdl/fDSd/nBNVEqBqoCTkASVjiClN63VZrSXQH5JjtwQxAHWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413763; c=relaxed/simple;
	bh=4QJ/6/jO0Ghq8D3lI04piss7UYAkTLyaKjBohqFRuak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlI+CpSx0Ns95/Umjkh3ySsaSl6gPkvwVt51q8ehQNISGuiRF4Kc6TJ7vUpkjL+6h7YAGM1gp+bTTujD/QAJGOIFnV0WR1ICLN59wt/ZDcl7LMDkXVwbuXfRg9fVZQbjKCOWFG4X8jGmfAP08k7fwGJaCIbgNRnUw65g60U3Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=P3v+DbSr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Tue, 26 Mar 2024 11:42:08 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711413759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swCBvVxY19q5QCFoCh3CilyHYDojXjj2iBKqZTEVPTk=;
	b=P3v+DbSrjxwcEzz5xiHAHhnXdU44P5rN3DDSC11hcYlHznJP9DLvYzk2BtIehC52iA5vYU
	1UehtPVXzvCWfTIqLWEq2QfUOyExwWrQhJFul4/6Hvw0ajVOsU9PpMxZ7kUEd6j1CF89y0
	fwg+VI73Atfbj3S+gw3eE4WqSXBJ7NSzQ7yBPyajg4Mmq5hkhtXdfYIGWxvnBOtTWFo3mk
	bOTIZEuwNtWTDll7uk0WYHO1XZeKhyrc3sjapUnl2pKorq6PaV50X/JJ0BlN7EIPKfaBtL
	V/NiQnFbJhJuIMTw7zqsGuEWg7MZ2tceTPR2W4tHiJqALMV5WIvFzw2BrxCLSg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <ZgIZ4LmFOqdiDJBH@titan>
References: <20240224052436.3552333-1-saravanak@google.com>
 <ZfvN5jDrftG-YRG4@titan>
 <CAGETcx8+vw0Vr0NWzjOAvxAZ07M4U7BWPAgO9avCngW0-9e_kA@mail.gmail.com>
 <Zf7I65PiOR2wX1Uo@titan>
 <CAGETcx_=MmfgDajM16iJ4Of9Yr2Sy6ZpU=MyhYgnmOJFUTD_oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_=MmfgDajM16iJ4Of9Yr2Sy6ZpU=MyhYgnmOJFUTD_oA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hello there,

On Mon, Mar 25, 2024 at 03:49:44PM -0700, Saravana Kannan wrote:
> Ok, I think I understand now what's going on. fw_devlink does not know
> that "sound" device will not populate "multi" as a child device.
> Typically in such situations, "sound" would probe as a device and add
> its child DT nodes devices. At that point, the cycle is only between
> "multi" and "test_codec" and fw_devlink will detect that and not
> enforce any ordering. However, in this case, "sound" doesn't have any
> child devices and just depends on the remote endpoints directly.
> 
> We already have "ports", "in-ports" and "out-ports". Is there a reason
> none of them will work for your use case and it has to be "multi"?
> When you use one of those 3 recognized node names, things are handled
> correctly.

audio-graph-card2 uses 'multi' to define DAI links that have multiple
endpoints. It also suports codec2codec and dpcm.

> I think the right fix is the use of post-init-providers. Because even
> if you do the above, all it does is let fw_devlink see that there's a
> cyclic dependency in DT. And it'll stop enforcing the probe and
> suspend/resume ordering. Ideally we want to enforce a specific order
> here. test_codec first and then sound.

Is there a way to do this automatically so all the existing audio-graph-card2
device trees aren't broken? As it stands it seems like this driver is now
broken due to this change.

> Maybe. But the logs would be more helpful.

If you have a way for me to get more logs please tell me.

> > > post-init-provider = <&multi>;
> 
> Did you try this? Did it help?
> 
> -Saravana

No I haven't tried this yet. I shall try it soon. But I wouldn't consider
this a useful fix as it requires upgrading existing device trees.

John.

