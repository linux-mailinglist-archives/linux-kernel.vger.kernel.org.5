Return-Path: <linux-kernel+bounces-63883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54228535EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71AD1C21AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825495FEE7;
	Tue, 13 Feb 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLeB+qYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C635FDBC;
	Tue, 13 Feb 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841388; cv=none; b=uswaGG+dlVMTaPwHKAtfZxHxabKvi9KKuNEpVyQJnfOZNxYMAJg6u0nLSqg9fJe1D9DDpe6Ak7C83c1bXPRbPgsKY6WnvmsHE9z9vfw4Vha94CA7g0ttBa1cNGwdUXKQIamn6VDe7ceLukHezSKmUBxx8MubMKBpU27NMXY3t2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841388; c=relaxed/simple;
	bh=3i4GdydSftiCj1W1u+Jm/PpXtfDwToM0GIQpqW2yLjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyg91256c8l7E04tpzUM7+JHJ/gIAtgDjq+gX9uTOreoBTZbiurAIzyijY157f7OtbmFVInYEbpqyEU1VFowuAsnDohxLFlC6HnRX1I3rz1gBz7ItxkxmifjFcizV9wRbTEbge+IigO3EX1zn6f4b4H0bxLcf+Re0ahqVK6k69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLeB+qYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E283C433F1;
	Tue, 13 Feb 2024 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841388;
	bh=3i4GdydSftiCj1W1u+Jm/PpXtfDwToM0GIQpqW2yLjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLeB+qYklmQMxjilrcwWfIu956gmind9aFgmbjdHBcassOt5mVc188rscgHVdcyDV
	 1RWetKxW94PA2/lp2kPg8mIu9R152MZZAowyYPJHTv+0/YBBtgX0T6zKJ/JFz8Pk6S
	 ZwzeSL5ts6/r1F2jbq7BkZ8ygtXx2YRWwow3XjT3tpFmfi4D6+XEMcxYP5Qnev2w89
	 N//7S8dA+zZNtw/Punrwasl0qpb3RgqSTvstkEr7qZdJM/7JOVgOe0AAFcNuawHgiI
	 80VCgJPYNdsAYkakqesAuOwiY7JHUXLd1dzDrA80V5/HNB+QodR4ufo2OhS4/QD5SF
	 NCkC3Hw7nC5iA==
Date: Tue, 13 Feb 2024 10:23:06 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: dt: writing-schema: document expectations on
 example DTS
Message-ID: <170784138526.1472222.12187200205428604794.robh@kernel.org>
References: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>
 <20240212150524.81819-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212150524.81819-3-krzysztof.kozlowski@linaro.org>


On Mon, 12 Feb 2024 16:05:24 +0100, Krzysztof Kozlowski wrote:
> Devicetree binding maintainers expect the example DTS in a binding to
> show the usage of only this one particular binding, without unrelated
> device nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!


