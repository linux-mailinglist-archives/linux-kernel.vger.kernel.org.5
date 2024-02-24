Return-Path: <linux-kernel+bounces-79734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9E8625F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759B528338C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E747F4A;
	Sat, 24 Feb 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnArIWcJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B249F1;
	Sat, 24 Feb 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790908; cv=none; b=IJ98KS/MKsZtnC9L7BXPz2fH8KMYck9LqVVV6r1/fOVt32dFvARqr1TX3uBbv0s/ENCB+mJD+SwONiIBH7sEx8XF4H/n09SCzY5jqT3f7xPdNItaxpN8kmPI8yM5GThVqCt4nkt/pl0gjD4zHLTACGSR1YjUQgTsyJJyWXwx0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790908; c=relaxed/simple;
	bh=vGyWWYV8na+hzi5jplalPwfDYnpFi2wMP0WWLNZpFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYPxoCqEFURFbV44CX+Uln9phHPz9N03RILZq3ey0A4KeUYR9AnCOJVFILG9NGRtlArSYEyEFGorsZK2EfvgRGQDTc4RTh4VgnOebE7aHJJ09Nwq/tt0gZFM7efFlh2sJ0BAKiFr0cHGbp5njVPiJfSltIGlnPUpKUo4kO+Y1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnArIWcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89849C433F1;
	Sat, 24 Feb 2024 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790908;
	bh=vGyWWYV8na+hzi5jplalPwfDYnpFi2wMP0WWLNZpFIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WnArIWcJzOPcrTrwRK9E12YjLoYUGIPuKAWGlkRRCNRQeQdy8HAh6UfH7CXu1HDi8
	 yfbe2pynwspBwEZ941UHsO/Ovw4z+sInOZfR/Y/3wznq0EfRHS+e+ggkAkgc8DoYtv
	 PYU0dau6qujiSiYnpSvYM9neHNjIBlpoXwg9sKCLQZDEhHSGASWHZgNXpFUIxuYxrQ
	 j0UAKCCTz8U5Hr6eJGlzx3Wghz5nUoGAiov7lLrSZY4lb3S+fmEn4QmnQYifByI5eF
	 tg6JFnii6SM/plU99UpwB9VjDiDpyjrlBKQyQpBVQZwY/24FrE7rribCPfytXQXsQv
	 AlKogB2FpI7Jw==
Date: Sat, 24 Feb 2024 16:08:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Eugene Zaikonnikov <ez@norophonic.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>
Subject: Re: [PATCH v7] dt-bindings: iio: humidity: hdc20x0: add optional
 interrupts property
Message-ID: <20240224160815.0407662a@jic23-huawei>
In-Reply-To: <20240219-iio-hdc20x0-interrupt-binding-v7-1-c8ffb39c3768@solid-run.com>
References: <20240219-iio-hdc20x0-interrupt-binding-v7-1-c8ffb39c3768@solid-run.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 15:48:21 +0100
Josua Mayer <josua@solid-run.com> wrote:

> HDC2010 and HDC2080 humidity sensors both have an interrupt / data-ready
> signal which can be used for signaling to the host.
> 
> Add binding for "interrupts" property so that boards wiring this signal
> may describe the connection.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git but pushed out initially
as testing so the autobuilders can have their fun.

Jonathan
> ---
> Changes in v7:
> - split out of original patchset because it should go via iio tree
> - collected acked-by Rob Herring from v6
> - Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
> ---
>  Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> index 79e75a8675cb..e3eca8917517 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> @@ -27,6 +27,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> 
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240219-iio-hdc20x0-interrupt-binding-42307b7b99b5
> 
> Best regards,


