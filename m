Return-Path: <linux-kernel+bounces-41272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D283EE48
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8ED1F2229A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAD2C19C;
	Sat, 27 Jan 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwCHmBVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AB2C6A4;
	Sat, 27 Jan 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372067; cv=none; b=hZwE7SGJw8a1bT6FVEtdQPC8tosQfeoqpBbwSoGz0bHXyMG3nfO0Rjcrs7qpH2RSEFhpDYJ/RMsxGPBH9Q6PDJGf9szWz5yZQdyLrpppR+yUecFT/prlwSGY+XPc37lPg81o0eivlA4HqYIBC6c7Oxs6UOpCsQlbDM397ia28XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372067; c=relaxed/simple;
	bh=Tb0khgdHRz2nxorO2diYsbOQmU7BIG0FOfUFJ8FN63o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li9uE+rBjK4cdvu1QzOnXf4SB4NbEZ5dPsOrYw+hSKFG+S5IuZo5XEcUd7qRiViGl3q9KgHz/TQaizeNq6qPOwHPwBSFIgInOY14LdrjO0l1kvjtF/OHl609UO39i7I3vpO7lHwLBWz2aPERzW2hBYgM2dyhk+5gOaDrJaypr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwCHmBVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC679C433F1;
	Sat, 27 Jan 2024 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706372066;
	bh=Tb0khgdHRz2nxorO2diYsbOQmU7BIG0FOfUFJ8FN63o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwCHmBVKcVVSSIqKX1f1avR2bZeqcCuL2kQkzv2+Znsj/m6s5NJeer5PcXlCeJD6r
	 qnp7ibXuMz+KDbUOq2GPZ3mpR/552mTYRwFPPzmz4HIiHr7WIlBrvMd6Xh7lZZTRJi
	 Lv1rnCPVgLuL4GflAK4AtGXu6gpVmc0R6nDYehY1FPPfQ9G5BpvPQVpg1qdP8GoWAY
	 Cq2IiYa6O31maSXJlMaMesSh5Xmjwb6muvXokDvtUmMQeNPho0fVUWxIrdUi6/TFQ7
	 np2fV/KzsQgU8OxlykGhkM5JQEN6ecrUJfUZaVfip1NLRVeUejj13yeqGnQFUzSJ5b
	 as4qF5ncdOxng==
Date: Sat, 27 Jan 2024 16:14:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240127161411.1e8ca0ca@jic23-huawei>
In-Reply-To: <20240123-curled-affront-e37d2d6b1826@spud>
References: <20240123081059.5746-1-kimseer.paller@analog.com>
	<20240123-curled-affront-e37d2d6b1826@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 16:16:49 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jan 23, 2024 at 04:10:58PM +0800, Kim Seer Paller wrote:
> > Dual microwave down converter module with input RF and LO frequency
> > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > for each down conversion path.
> > 
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>  
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks for the updates. One comment below that I missed previvously, but
> is not worth a resend.

Given there is an admfm2001 part that at least from the title of the
webpage sounds plausibly somewhat compatible, I'll give this the
benefit of the doubt and leave it as an enum whilst applying.

Jonathan



