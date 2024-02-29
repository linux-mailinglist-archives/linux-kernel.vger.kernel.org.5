Return-Path: <linux-kernel+bounces-87287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B586D23C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8101F223EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFD7A15A;
	Thu, 29 Feb 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCj3smvi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F488160649;
	Thu, 29 Feb 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231248; cv=none; b=Wc3wAw11tcvc+OwAEPDvFe7NJQVqbL8zt1KzBSwyN7Zb1nDhsvICqg2L0fmQmKW42oeQ/OmPpKTOsfxZoslE1jIynnyKQP16NMbBrWatKpoPUfgH9f0ktSEFELIaUPEvvlqtagjXLVSpINZ290T+b+8lW/X9iZkqAi7S0oxhxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231248; c=relaxed/simple;
	bh=DM1+TDGlpoIdXe3Yub3/EkTQHLT0a3FH9jPyyK8F8Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfK5J0tLaaEESVJI21hRi7G1HGfA5inuPv4nOlaxUeRjgWRs/jPkG2sZnFMTRmRTs2PCZ9IvkfoiSKJ72vqT+KO7Jbi+948qzJ37mBbaiMQb8NjiL65MHD/vp8zZLrBnrAA3u8/s6nzv0CA22bv4j/PrdVMLBGh3/l7PgJ8h628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCj3smvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA79C433C7;
	Thu, 29 Feb 2024 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709231248;
	bh=DM1+TDGlpoIdXe3Yub3/EkTQHLT0a3FH9jPyyK8F8Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCj3smviGbgJc8R+R+fPnSE9fDlU9bvsgVf74CJPIW+Spe38sco9f7qemvXqwh6/9
	 +ilwwrVWUheYxO+Uxi9fEMM9aDB8SzzuTh3x6axiwJo8+9Z45J7nOHhbrHXdmfklSP
	 DGJQUzDVruZDpaRjLIsAAOviUrECdgk4ihHzmucc=
Date: Thu, 29 Feb 2024 13:27:26 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-iio@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240229-imaginary-sophisticated-dodo-5b97b8@lemur>
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
 <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com>
 <06235b66-6948-49b3-b881-198443a421df@linaro.org>
 <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>

On Thu, Feb 29, 2024 at 08:35:47AM -0600, David Lechner wrote:
> Oh geez, yeah really dumb mistake. Will resend. I do use b4 but it
> doesn't handle per-patch changelogs that I know of.

b4 directly doesn't, but you can put them under --- in individual commits and
they should be preserved and included on send. E.g.:

    foodrv: add new device bar-0x555

    The commit message that should go into the tree.

    Signed-off-by: You <you@example.com>
    ---
    Changes:

    v3: add foo to bar

-K

