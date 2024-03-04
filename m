Return-Path: <linux-kernel+bounces-90405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE586FEBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B7B1F23463
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1151624215;
	Mon,  4 Mar 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP/VLUnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A363225A2;
	Mon,  4 Mar 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547269; cv=none; b=kLytkASZo4Y6DbGYvxSGvLipkTzI+7druCaUfhPmh/EqiGeP7EIUmzfeEUnikvWqLedjZFu8+7ubeS/Cixr9cU7I4VY6dIWulM+JR8O9Gc4nRpmpZ7CNLO36m/aljDNBffMV7JPYLzo4Xn6C5hksEIO7R+zzASCoUPplB7LCoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547269; c=relaxed/simple;
	bh=nhV3nLQLv9fmwP/nySp4wv0mZvbHQ0i0sj34n6Bo4pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwshFnyFErNkA2arx+76EQX3KybIf1GMwQ/wV8lqrvgeZ6u5eFBhWUx1X9EFUPL/tmMRr6nd5Z+2JlnreZaD4dp8jAR49eMhnB15PNpO7DC/CeU+udn/JqEKl1jksN5CzKnXN8sOrIODJejxZkSYMGYrK9GoZi8WFPQgv20Fht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP/VLUnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3236C433F1;
	Mon,  4 Mar 2024 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547268;
	bh=nhV3nLQLv9fmwP/nySp4wv0mZvbHQ0i0sj34n6Bo4pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UP/VLUnY5u+1a64IBrRO5uXaeBnbx88yQUVRsYK7v7zuM/y7npA6dhXODCCKE/lyR
	 sk6EO2HIRaz46qWpIj5DTEqPsOIbvmceH7kqI4cW3KyvTXhkwijxTqtX5CnEaj8gez
	 SGJwprpM9PeZmRXDTzF4ZV2Xf2uJ5B8TBUX1G3RHgkXVMkazpxgTfeKCdyhC1OoJac
	 9ZnAnl8LIFUNhtBRrotYLPnoAiTF/4k57q66meSZVPOwQ1HFwQP4sCAax12yYkYMk0
	 Q30mbiHHH10X3Nl2wDiEoKpgAMsVfzHt40N+yGibjS9J/UE4MLwO37fA0H0voK8bms
	 d9eBqY+i6N6ow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh5LB-0000000076g-0Foe;
	Mon, 04 Mar 2024 11:14:37 +0100
Date: Mon, 4 Mar 2024 11:14:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Cameron Williams <cang1@live.co.uk>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: serial: Add device ID for cp210x
Message-ID: <ZeWfDU3Mx7dhq-j6@hovoldconsulting.com>
References: <DU0PR02MB7899B4A2A35EFE1B350E6F97C44F2@DU0PR02MB7899.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899B4A2A35EFE1B350E6F97C44F2@DU0PR02MB7899.eurprd02.prod.outlook.com>

On Tue, Feb 13, 2024 at 09:53:29PM +0000, Cameron Williams wrote:
> Add device ID for a (probably fake) CP2102 UART device.
> lsusb -v output:

Now applied with a slightly updated summary:

	USB: serial: add device ID for VeriFone adapter

Johan

