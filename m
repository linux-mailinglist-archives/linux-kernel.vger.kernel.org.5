Return-Path: <linux-kernel+bounces-63603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE2853219
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B76F282FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EB256472;
	Tue, 13 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ48bfpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75F56444;
	Tue, 13 Feb 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831583; cv=none; b=mQu9fPy6kVB7f3Vxs/GYC+eOU2vvuIh07t5rRk7xkh8nNjBOmH5hmNJ7yjEsMbgMEs0Jkz7uerb+azjrvYilDEqGpjjgxpye1s09bg7L2BWQ26q5HnRF41sZDfU2N7JKg+a5enfiLwM8dDsFo/8360kTqMcVWQFo52XUhalmJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831583; c=relaxed/simple;
	bh=9UJEgszb3cxpnlKdtWLxFXT8K5hAvSwLcEDG2zJZnHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa0m5n8yJX3DMdeFzHPDGZxrhtwvpnrLm5jZmX2HKGBnx4hooJVqnZm0GQwOWwgKREoTf7N4ocHK/7TJ4uOr6jpACE95KlFjv5BWiKw7dzUjPslSvQ6Xo1RlQXIl7rkvxJ98SKqe+PT+rKpyGwTujLnJuQVGcNKW/H710NeKFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ48bfpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B863BC433C7;
	Tue, 13 Feb 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707831583;
	bh=9UJEgszb3cxpnlKdtWLxFXT8K5hAvSwLcEDG2zJZnHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZ48bfpXcj2eDwOlKY2sIMc0rlf1n2ewyzr+DTq0MLMlWOR3JWf9zCpD3/BBbcq2e
	 +xnWMDuamRUzWbxwukpiz3BeKgAKWbGjNX+aOeXAEdZowYboYTZ6ZAMjytBT5crIv/
	 qAhb/s2aiJ8pVZ5XbV339r+NvLGI3IsqhqUf8gXAG7ps1Y5Z0ULqsWPREpG3BIeL0g
	 NFozzeSMpe5MLZuMWgYqpukJspeG79KYdKTvy5YOqXHU9L3ZOOHV2hD+dZb3o3Pq8n
	 qBllucI1OAtH841YwThhEkurCso1y1OVlP85PIdP8rpHRpce5GY6wYCLpoTjYU6LpA
	 K+3x6UFApDShA==
Date: Tue, 13 Feb 2024 07:39:40 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Sebastian Reichel <sre@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add smartrg
Message-ID: <170783157961.1082071.9686592830997462350.robh@kernel.org>
References: <20240212140839.27150-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212140839.27150-1-zajec5@gmail.com>


On Mon, 12 Feb 2024 15:08:39 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> SmartRG described itself as a CPE manufacturer and produced few home
> network devices (e.g. wireless routers). Their SmartRG SR400ac router
> (smartrg,sr400ac) is covered by in-Linux DT binding and DTS file.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


