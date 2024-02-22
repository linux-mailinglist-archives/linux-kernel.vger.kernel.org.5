Return-Path: <linux-kernel+bounces-77288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9E860364
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFDBB271DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED56AFA0;
	Thu, 22 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ+B4zYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097454914;
	Thu, 22 Feb 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631603; cv=none; b=tsaCOp1YR5rU2dzACFs4pnRlUx9R3YXzl1XJ80y4qFMCNXXDfStEZ8l+Kk5Gsw5AGm7jRGYU/LUc3Ca4Nb34WN6S2Uz6lFex8Rob4h0nlxZbdAS7bcoP8fbatMQ2VwYd4paEThC4W3BGmr6LMhLZRoUCrYTQxiWL3kNHGPZYqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631603; c=relaxed/simple;
	bh=qDXBB0ij/If0VYG0ekjLIrDHl3WNvkiffFUNpfTYhQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3ADtESAq4LHXxPGydQvDBeyjArrw8RgGCEsKUiFCc+Vt8UusuiI6oTvq8wh9FtkdndVU98tPRQlVvELec9k1DNQuoCY9u6fzdyrvTMlPWhbdK/oJCqmk/Fk9OFUYVcXKwGQtOqe3iIv+ovXvvrAIjYA1DQ7neiojxvzreqoc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ+B4zYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EF5C433C7;
	Thu, 22 Feb 2024 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631603;
	bh=qDXBB0ij/If0VYG0ekjLIrDHl3WNvkiffFUNpfTYhQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQ+B4zYsFdcQTnlXnTJzTjKwxMjTba6V/pdA3mNW1UJZVdLboIrHrIPeDgwfolNk9
	 W1+ChLdKC24pmYgf+HiJg8Xnfg4hU0nlhCNCh5arvgmTJHpX215MLOVsnHcpjRHnEH
	 NddVjpNG3zF1puwZUIkKmTt6S8Jbgkof0hguop3mw70KYGMY5iZ0yToi4v2HPV2ABu
	 zmU9/vjsIoHjwnxNBfwQQWdGCRdjYd+psb6feGRjKLEtVpQhd1FJKRW+FgWMSfH+3j
	 ZddQM84ZCxc5ZUUZX0DRoYQwNl9kmOLJjTelH2h3BBen3pJdbQDVwDoFqECtOxQnMb
	 cqMXsTgiPjauQ==
Date: Thu, 22 Feb 2024 13:53:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: ti,ina2xx: use common hwmon
 schema
Message-ID: <170863160056.3749405.5990160563545861721.robh@kernel.org>
References: <20240216-dt-bindings-hwmon-common-v1-0-3c2c24ff1260@linaro.org>
 <20240216-dt-bindings-hwmon-common-v1-2-3c2c24ff1260@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-dt-bindings-hwmon-common-v1-2-3c2c24ff1260@linaro.org>


On Fri, 16 Feb 2024 08:55:47 +0100, Krzysztof Kozlowski wrote:
> Reference common hwmon schema which brings the "label" property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


