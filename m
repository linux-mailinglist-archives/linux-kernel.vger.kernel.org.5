Return-Path: <linux-kernel+bounces-112682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C8887CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841AC1C20DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830617C72;
	Sun, 24 Mar 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Bp6qvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C117BCA;
	Sun, 24 Mar 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287691; cv=none; b=OLD8xPO3jfbKUmu4XvIf88gztCflRxkzWtCoKth/oG8D3iigpbEPPTcz5YXi4xsrGSieSweyCV7JB6EpzorzaLmeTwM6E1/oeo5S9+/EfF3SUuKKXJyMB7EQ7QroYi90lELZTskax96SK2arhXL4WQE477mJP3GMpzwxoNw9zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287691; c=relaxed/simple;
	bh=EboX70F+3+t7ZeDd01epnf/aRoP9Cg1U0VVgeysaQ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giPV5inZsbqR9lgP/yP/nUL2ZaMcBeKMq+ZNXDC65q071g2uk4WC9qt98FuZ7YOtmlxPcZhbbX/LgLzGjGC3nJLCQm1Pb9/Hf6rFaVs6TVMnZ82Z9jFESO27nxDNlwWR5OIYmKgVg1aYMiqQwNILpfYOGoTSY2eZktmaddrYVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Bp6qvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E4BC433F1;
	Sun, 24 Mar 2024 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287691;
	bh=EboX70F+3+t7ZeDd01epnf/aRoP9Cg1U0VVgeysaQ6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7Bp6qvKwcBVtnti5i61ivt4PJ6c0K/ULRzwp/oFV2OJkxY4eN73PbjpJAgYqRQjB
	 O52bd5nYw3egIkNOmlIv4YQUQZQqyHEHFi3Hs0UG0e3k4+iP7zTA9ZWYBNXlAnrSFk
	 sInxRXSoQM/QCRprHj7Fzrl937qZOhNbFeDFpHUq56QLdEB7hU7aG3bvTSaPP/uyff
	 uMRr31ceHmPJVuc7N9vgNJ62wMz+D4zoOxDUitUgS6zuQy879M0v+i8NIy4WLpfN48
	 0MwXEOl9gbOCD5fKb36Zby6bmN3yDaq38DVH6RDQcPhL//j0GNTYS69uNGhEP/vGC7
	 delSV5US26/yA==
Date: Sun, 24 Mar 2024 13:41:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
Message-ID: <20240324134117.6d1dccb6@jic23-huawei>
In-Reply-To: <20240321-max30101-v1-1-00b83e966824@gmail.com>
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
	<20240321-max30101-v1-1-00b83e966824@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 19:33:48 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Maxim max30101 irs the replacement for the max30105, which is no

is

> longer recommended for future designs.
> 
> The max30101 does not require new properties, and it can be described
> with the existing ones for the max30105.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> index c13c10c8d65d..0e455809340f 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/health/maxim,max30102.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Maxim MAX30102 heart rate and pulse oximeter and MAX30105 particle-sensor
> +title: Maxim MAX30101/2 heart rate and pulse oximeter and MAX30105 particle-sensor
>  
>  maintainers:
>    - Matt Ranostay <matt.ranostay@konsulko.com>
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - maxim,max30101
>        - maxim,max30102
>        - maxim,max30105
>  
> 


