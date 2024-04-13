Return-Path: <linux-kernel+bounces-143701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F48A3C69
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2F0B21F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0963E47E;
	Sat, 13 Apr 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BanwFe05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34573D977;
	Sat, 13 Apr 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006126; cv=none; b=WBICCcd2Jj1bcC0/g+kIc9yzbWrN5XCNGSjQ0Dsi+Y5ymMeQvimcHfCCyC2i6u2JwKFU3tOWr1BwoykKdl4EcSBuh6GQJpn7ijZ3O87hOaHKyrH/m9TlFBoI6rYO6eEybildd2SI9XJjVj4SoE/6/ae+Phz+8RZSDR0BdZ0krWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006126; c=relaxed/simple;
	bh=tM71ukHSCkRXKEj2erXIhUkB2JuKjCWaxGcrvDZckYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmyoqF6IS/mZJs/JbrGuh2zW3vkc6nWyTt1QoidbQ9SjxiBGoHhxSNsyC3u12P/Ux6mLEhwveEaCJGvOmI7Ahq2Qq5Zd4Ld4NGjGy5mWez/GXH4p03AZ2MEMeAyk+vEzzPLaTv0QjNgyLkDjJHMydEbN3l5MQVhbZjUhOUhujWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BanwFe05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3519C2BBFC;
	Sat, 13 Apr 2024 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713006126;
	bh=tM71ukHSCkRXKEj2erXIhUkB2JuKjCWaxGcrvDZckYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BanwFe05mFBZeoKqQGae8f56ZyX/w78VID8Gu0d9G8S/8/6s/ZZucbTuA8rO5BoDM
	 UvYfWoLYXCvQrXYnCnpf/1Viuk8sOgN2IFjlXTbmWnn7juUmAYmsTUQgJ0c9+3xlew
	 +3dFK3xZh0QFG+ihtjTNn/t+ZNAoODl3D0Yn9giiyZg++N8sIaPTbrmollMEMyaTOX
	 LW97mjiI1DPHCrLruglogidkNbYRhnBEUtcN3bGlz7IjF9bmw5nJPjtUWciAzmCrXT
	 o9C641PDuLnolW2CzcFiP2xOOxRlOttLkaH+gmjoWgDMR3JSu/oh3nDf8KHGvbIvEs
	 ASsnvHuFaZ23Q==
Date: Sat, 13 Apr 2024 12:01:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: imu: mpu6050: Improve i2c-gate
 disallow list
Message-ID: <20240413120152.476efa76@jic23-huawei>
In-Reply-To: <b0055143-96bf-45c6-ae9b-78b60fd02d6c@kernel.org>
References: <20240408-mpu6050-i2c-gate-v1-1-621f051ce7de@z3ntu.xyz>
	<b0055143-96bf-45c6-ae9b-78b60fd02d6c@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 08:36:08 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 08/04/2024 18:34, Luca Weiss wrote:
> > Before all supported sensors except for MPU{9150,9250,9255} were not
> > allowed to use i2c-gate in the bindings which excluded quite a few
> > supported sensors where this functionality is supported.
> > 
> > Switch the list of sensors to ones where the Linux driver explicitly
> > disallows support for the auxiliary bus ("inv_mpu_i2c_aux_bus"). Since
> > the driver is also based on "default: return true" this should scale
> > better into the future.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>  
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof
> 

Applied, thanks

