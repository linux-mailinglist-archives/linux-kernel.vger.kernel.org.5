Return-Path: <linux-kernel+bounces-61372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5358085117E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECDB1F22D81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA4438DE0;
	Mon, 12 Feb 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrMEgCCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FF2555B;
	Mon, 12 Feb 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734858; cv=none; b=p2vH39TrhMkD3E1Qb89z8QJcDJR3h0cGZivzk7erjBIMsbqYUgzgtu1H1s87p78nmUvTTDQfJ0VvBnOaw2nBHDBvBs9hnUiyBOmYq7vN7RVGseNb0Nm4RTAkjnIfRODXzQW9TkEJI0OdQ2fDJ97W1QLEIsrVTMpkOR2Fz47asgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734858; c=relaxed/simple;
	bh=t/ZTePsKdIVKC4gWLazaU/Eiquk8TE+7jyT9VDJ6mgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL1bxiJiOlvQ6Px/a4HNS9w9HAkebL4VdRyZIcZ23pqcI/THHlj2JfVxyL7gVU+9hSnmFMCLULxFBltteJXn06q3WE21ybWKz8G4l5WkSmp8WaMcGj8Ucl+UTia0UjSXjUFNk8z9xcPMx+uKw4mWs61IHSl38pHi/CRERkgX800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrMEgCCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC055C433C7;
	Mon, 12 Feb 2024 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707734858;
	bh=t/ZTePsKdIVKC4gWLazaU/Eiquk8TE+7jyT9VDJ6mgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrMEgCCrpHvdMCfGdToN4BxinirdDqARNMPWtQr6H0NW0Ziy4uCKXTzVJNZzRMj58
	 8i3nL8Wt1M8k7yHb5AwI1vfq5kMm4QUDOe/nCQYd/0eR4+tz/6YJUJ2z1i4TK6c3xS
	 9KBE4sTFK1ZsfJ10qNJPzY/D3qLP7PxFqZYSUvRrEfYa+aTx50rO/VNZxKAe4z8Kkl
	 mfdASZ/EL62Ke6TFpTVpNJkv+8jpbDdpRusebAwh4RhibDdD9sGrprQi63knxoFMY1
	 uGmrIQ7LhSV7aHwT8OOWme+PuuvJSJBdE7FeIwnrJrjcSTzsdfq232wBvqEBPVpTsb
	 bqE9m+5ee5GAg==
Date: Mon, 12 Feb 2024 18:34:36 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module
 3H and Longan Pi 3H
Message-ID: <Zcn0POS-4BFGlRm9@xhacker>
References: <20240211081739.395-1-jszhang@kernel.org>
 <20240211081739.395-2-jszhang@kernel.org>
 <7ee6df91-76fa-44e8-ab81-fd4b63b58ce9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ee6df91-76fa-44e8-ab81-fd4b63b58ce9@linaro.org>

On Sun, Feb 11, 2024 at 05:29:32PM +0100, Krzysztof Kozlowski wrote:
> On 11/02/2024 09:17, Jisheng Zhang wrote:
> > Add name & compatible for the Sipeed Longan Module 3H and Longan PI 3H
> > board.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> 
> This is a friendly reminder during the review process.

Oops, I forgot to add Conor's ack...
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.

IIRC, the b4 can only help on the latest version. If I missed the ack
in v3, the ack tag will be lost. So how to handle this case? repost or
Conor gave an ack to v3 again?

Thanks for your information.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> Best regards,
> Krzysztof
> 

