Return-Path: <linux-kernel+bounces-44177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE3841E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B331F23412
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046AC57898;
	Tue, 30 Jan 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Fpz+rEj0"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E052F62;
	Tue, 30 Jan 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604621; cv=none; b=jYYCLxGXCsYd0MLE0zIILTQz3GLJe2F0OAeVvonplics8QUphepW0Oh50vqAJGAPuGJDKFHgfui7pcmQIBAMNO//UpwWJWedYXyyPmy2iO7haoLOWlY5Dgt8/h4xKD4oGK0EvgsQT4rxJ9sQDRYHNXDFkjF2g4wPuklPM0ec2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604621; c=relaxed/simple;
	bh=ZsubLEjPBiTlfUd936iAo4PuZaNtpRmxWj6Wk42XDJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQOhChNIS4gPJeUZzwElEofGY3x6TZA7XTIjfM+WOPGxmkUHFTnFLWByw8Pec8IwOmPo6I83PbrLcKob7Vx64JBMnA9e/QKYVPqoJT47bCjzpAWGGIE0x6CbhbO6QyTdz18mtBWVO3ecxVVdPKuh7r5RYhjx2XU2wdxyRBvovNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Fpz+rEj0; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 34F4920B42;
	Tue, 30 Jan 2024 09:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706604611;
	bh=3lN3zuSgHYMooD1pKa70hIdez5M/4wV0gmFofKkTA3c=; h=From:To:Subject;
	b=Fpz+rEj0xU2+fAzOpWyp7F3uPPVOi29B2k7AbVfeHmnVvZDpgf3ldJCFZfeCnyGCW
	 5rZMHQ+nWp5PjxDyLntzvMyjIN3zsV/tTF2xFHpzaHGzEriE5g/lu8HwmzSnXN2m/l
	 YllJ5ERkM3gcuri8Z/KfjRY0KPNbZ+1TG4PhUg2xLIHs+ipARXGNDPb3Splvs92V09
	 HyNf8MQ4oF8I21wKQeXX4lZx5jWzsnqL2jERI847JZ3IQrh0Qi1J8Cka7dtX0za3iL
	 +bg46qmYooIV83182zbkykzWHil/l1//xSf43KqQtDIj+OuJAkChAHbupMCwB4qiqm
	 V1KDW8KlzXtOg==
Date: Tue, 30 Jan 2024 09:50:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	piyush.mehta@amd.com, michal.simek@amd.com,
	francesco.dolcini@toradex.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH] dt-bindings: usb: microchip,usb5744: Remove peer-hub as
 requirement
Message-ID: <20240130085006.GA4068@francesco-nb>
References: <20240130073505.8916-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130073505.8916-1-eichest@gmail.com>

On Tue, Jan 30, 2024 at 08:35:05AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The peer-hub is used to model the relationship between the USB 2 and USB
> 3 hub. However, it is possible to only connect USB 2 without having
> USB 3. Therefore, the peer-hub property should not be marked as required.

This was noticed while adding this HUB in the DTS on a board in which
USB3 is not supported. To some extent this is fix.

> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


