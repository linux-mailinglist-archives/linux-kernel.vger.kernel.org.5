Return-Path: <linux-kernel+bounces-90525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B594E87009B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7140C2847E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401733A8E1;
	Mon,  4 Mar 2024 11:45:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691913A1BD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552751; cv=none; b=YgGs3DLNX/x0vML8oiHyRdipmIc/E2J+8DRK+I1Ghyg3nTNE4fRrBRZihFfSxw2rNgU7aO6l3JcCQT/ASi7jNxRjYHf7QbYXQSwJwYG6awe7+xcB8H7wOQeIjDDdzJuOBONaKAAHQBbDjWIyzQ2cn998Se0NmVNU8TIPl0tnMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552751; c=relaxed/simple;
	bh=35fzCKDGyb1iAEeJtIZBGvLzvc69xXg+MMNnks/ms5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8MlzilSVMEW2Brh8O92P5NlI/y3onWVVYowULg2KzNPrvD0F+SbCutlYYx0lrg3K9MDp30kNZZ6/ERbujNFlvWL3DOFlEq+1lVa2+wQMs7uLbul3W1y3dc01uxzyQN107idvGfW3DnXwgYtzzrHQVqSxXa0V2nCleDQhZc0wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 850001FB;
	Mon,  4 Mar 2024 03:46:26 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5240A3F738;
	Mon,  4 Mar 2024 03:45:48 -0800 (PST)
Date: Mon, 4 Mar 2024 11:45:46 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, "Maxime
 Ripard" <mripard@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Message-ID: <20240304114546.4e8e1e32@donnerap.manchester.arm.com>
In-Reply-To: <1baf9a7f-b0e4-45d8-ac57-0727a213d82d@app.fastmail.com>
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
	<338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
	<20240304112441.707ded23@donnerap.manchester.arm.com>
	<1baf9a7f-b0e4-45d8-ac57-0727a213d82d@app.fastmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Mar 2024 12:26:46 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Mar 4, 2024, at 12:24, Andre Przywara wrote:
> > On Mon, 04 Mar 2024 12:11:36 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:  
> >>
> >> This used to be a 32-bit division. If the rate is never more than
> >> 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> >> the expensive div_u64().  
> >
> > Wouldn't "div_u64(clock, 200)" solve this problem?  
> 
> Yes, that's why I mentioned it as the worse of the two obvious
> solutions. ;-)

Argh, should have cleaned my glasses first ;-)

I guess I was put somehow put off by the word "expensive". While it's
admittedly not trivial, I wonder if we care about the (hidden) complexity
of that function? I mean it's neither core code nor something called
frequently?
I don't think we have any clock exceeding 3GHz at the moment, but it
sounds fishy to rely on that.

Cheers,
Andre

