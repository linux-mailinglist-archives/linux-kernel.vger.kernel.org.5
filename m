Return-Path: <linux-kernel+bounces-41327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD483EEDA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFFC284B73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF12C85A;
	Sat, 27 Jan 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj61Otru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9072C1B9;
	Sat, 27 Jan 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374557; cv=none; b=ERK0viPkoLjQyZHLr0fPRT570NhLPLsqsGoYze/EkSqZQ8SmciZawZWESdpYopeTB2zWv6LJOJPDpAw+YxTisV35wRztmSYVv6/jHX9UbbFL/q5gLeD9zJrMjqMhm12RcjeTBMr78z6y3/196Si93q9nofG0qST2tzczu5tP/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374557; c=relaxed/simple;
	bh=fTlhHfNlr1Ds/TfS/W7Chw1w907Jm5nmrt/K/Zh/X14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8RW3JLbcynPKc8S6j2j0sB0Yn1upXGnITfMqK9VmEDeEaj445sgQruv11SfA9j6ot+lIE2iTl3uYICwg1fM5yKkc1a+ngx84JT3Ho5Kcf567MmUyYXAEAVNTW9y66ZO/E5WD9AZV2f4ejCDnsPVbIpG8xsy0p479xKIAhh47T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj61Otru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B39C433F1;
	Sat, 27 Jan 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374557;
	bh=fTlhHfNlr1Ds/TfS/W7Chw1w907Jm5nmrt/K/Zh/X14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fj61OtruUPf+puokf6hBoUiIhL8e82GqdVIKjiszjCUf1oLAxMks9Jq1bq+23nS3s
	 GSqOO3Y3ALNdcPGX9epMAxrQ47DguG8VFH3sW3uBRQYoA+3Wula1XRMLOzTTBhZJQG
	 sEImCbaU4y8QN7aeRbdZogjB1XqiD0g2GvuXVu9zt9+zpv91iPTybYEjni9/AGSd9j
	 fUG6ERhJT8K6LWAXywGO6k4pu6yVnQoApqTZIjvCngp7/s6g9dF498I3Uu0Bjw9178
	 tn8jYGtTH/tRARZojW9iJNqNmhQRAiPl6D0syD0PJ7NZWOuBFXSolMYwV2Q6x1zdnN
	 rW26YprQCsguw==
Date: Sat, 27 Jan 2024 16:55:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Naresh Solanki
 <naresh.solanki@9elements.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240127165542.6eeb23e9@jic23-huawei>
In-Reply-To: <20240127-capitol-cabbage-7a9b67112a28@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
	<20240126-cinnamon-flatware-e042b5773f17@spud>
	<CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
	<20240126-scale-serrated-33686467d91b@spud>
	<CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
	<20240126-blaspheme-calculate-a4134dc1ed68@spud>
	<536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>
	<20240127-hunting-wick-fc1eed1af6b1@spud>
	<20240127144920.455b6f0c@jic23-huawei>
	<20240127-capitol-cabbage-7a9b67112a28@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 16:48:04 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Jan 27, 2024 at 02:49:20PM +0000, Jonathan Cameron wrote:
> 
> > > > It's all in the description of the binding...    
> > > 
> > > Obviously it was not sufficiently clear, it's not as if I didn't look at
> > > it...  
> > 
> > Given this device fits in both categories, perhaps a tiny bit of
> > additional documentation would help?  
> 
> That would be nice.
> 
> >   '#io-channels-cells':
> >     description:
> >       In addition to consuming the measurement services of an ADC,
> >       the voltage divider can act as an provider of measurement
> >       services to other devices.
> >     const: 1  
> 
> But I am not sure that that covers things. I think an example, like
> Peter gave, would be good?

Ok. An example is fine.

