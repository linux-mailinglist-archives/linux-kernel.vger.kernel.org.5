Return-Path: <linux-kernel+bounces-32119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971068356BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE811F21E69
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136037712;
	Sun, 21 Jan 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEopUBpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54597374ED;
	Sun, 21 Jan 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855776; cv=none; b=CdrXJMZoF5ttNxPAt79g+mWQJ8KA/rmVaTCsnAh3n2BviEnbRBHpAlOmTJ8fqW9syfV3pSueBb9YjfaisDunJIDKMTpRpirTMiVCbu93ZYyKgIqbw7O/ZXVl/D6CByhIrBuF5lBy8c8CGlNLZfehxiJ5tHgz6bNf/Kl52as9KHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855776; c=relaxed/simple;
	bh=JmZ81xo1EjAKmyGPoYlZ1X+tYcmrfrJJnpf0SJRKbvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1+zM5rwkgcWU5TZHRJlXmeJ661cmbzXjIrW6NrE79hFHD6fbkg3liS+TGnCzcMKHDzQdAKFCkC1KTCOxv5egsRnN/4SdlUcPDHHaBdMKzpzN20CmGT6d6jVqfo9mAampKNmf3KKBQtWRdddpHPbRaXHMIxSaqumLM7Ls3C3dNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEopUBpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F9DC433C7;
	Sun, 21 Jan 2024 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705855775;
	bh=JmZ81xo1EjAKmyGPoYlZ1X+tYcmrfrJJnpf0SJRKbvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JEopUBpl6aaFQKVvllFfze/RMkBrJ5edM9zTAnr76VFpalCdaf1iThKrMSD7oMdez
	 nruSFnh5Zy7gYOFWJ92OuxI0gjlACP0LsHdtMwpA33XKK+94BGt6337pycpy9svQ/k
	 /5cXbNu6ZmWZcJQ1wfR5qCFvGTAX2PIvi+NftJ2VjRsHUhDtsGBdWq+thvKzbNfSUC
	 AJ3hjIJQwW7bVMeEjHBrhXVlLlB8mUAaCljEvRFY3A3W2puTWK4pVJ9ecCFXw9v8eA
	 CffKYY3EwDkx4Ka4FOCO69vtqul6JKcyXIjm8xkku0sfvQ1i+3yqsmHUmOArKr8WtS
	 ve8ZsZjI0jj3w==
Date: Sun, 21 Jan 2024 16:49:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add IIO GTS tests
Message-ID: <20240121164901.6a4707ff@jic23-huawei>
In-Reply-To: <52c66fe2798192529738ac2ab98a27230a6ad8cd.1705328293.git.mazziesaccount@gmail.com>
References: <cover.1705328293.git.mazziesaccount@gmail.com>
	<52c66fe2798192529738ac2ab98a27230a6ad8cd.1705328293.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 16:26:33 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add undersigned as a maintainer for IIO GTS helper's KUnit tests.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> This may or may not conflict with the filename fix here:
> https://lore.kernel.org/all/CAO=gReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9UeQekA@mail.gmail.com/
> 
> Conflict should be very trivial so I didn't wait for the above fix to
> get in IIO tree. I can rebase and resend if this appears to be a problem
> though.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40c754b4c39c..05c13e0f8c4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10310,6 +10310,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/light/gain-time-scale-helper.c
>  F:	drivers/iio/light/gain-time-scale-helper.h
> +F:	drivers/iio/test/iio-test-gts.c
This needed a manual merge as you pointed out.

Otherwise all lgtm and applied to the togreg branch of iio.git.

It's on an odd base as the moment though so I'll rebase on rc1 once available.

Thanks,

Jonathan

>  
>  IIO MULTIPLEXER
>  M:	Peter Rosin <peda@axentia.se>


