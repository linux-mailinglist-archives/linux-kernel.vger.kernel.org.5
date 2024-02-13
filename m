Return-Path: <linux-kernel+bounces-63881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593788535E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1231C22405
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8565F85E;
	Tue, 13 Feb 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdK31RqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7B5DF29;
	Tue, 13 Feb 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841382; cv=none; b=qPe5fcXreFAaYOSWorj9ndthyAMH96xpCIEas3tFEugr5l+d6m5BiItj9weZZ661txR7J0A+keLL/Z41HJJYDPDRX/nIw44FvspFOj8K0Ca6F3cUjIaWIVSpi7uIuX19XRU011Zwa+sIJ8CY167dJIL7pYPOGZ1lx+fpNb1VCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841382; c=relaxed/simple;
	bh=eUD5OPUqJVb975+Op2lRRteKWRRDXRd2aLwnzF0kc9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkMelrlWJsC7xW5M0gD+Cfm42CoEfSolq6qlpXBav9GY6CmN90JJZF3e5g1IJVjUaRlk+jgWYGkcP3hYcQrrMeNwaF57lXet9ZxBdXJKxIA9h/Of7OtTXUvLUjXGUkliMQ+0G7u+AtHvliKUY3gPDrylv9SxZDlA3tWYLo+dB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdK31RqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2DBC43390;
	Tue, 13 Feb 2024 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841381;
	bh=eUD5OPUqJVb975+Op2lRRteKWRRDXRd2aLwnzF0kc9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdK31RqRkT6+/58bo0zi3tgJsN5RDShpEdSqPdsMOd6guXg7A0iPdd3Mh0dGndprU
	 zZp76aEsNvEBs1lUZZIaK8gNVCPK5g4AwOjCHwDiQ+HUxBdk3eMzD5MVB6le0URpDY
	 cZJHDBnXVZcetR3SGScMWdH8B4ztA8qM7w4Pz3/JlPf3HLu/zpoANrQJj2NlDwO0dJ
	 zAofgaK/vrJst+shpQJsLGCBzm8QFv8S0e63eue6SsHk4z5CjDyTrG3ndqahLN28US
	 7XnQPNlGvWPP0by1hHwJRfkWPYbwnczrbMk2srbl4kuQl9nmLCmk2IXN5uq0s7Vhww
	 +AS4X3QrD6qJA==
Date: Tue, 13 Feb 2024 10:22:59 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs: dt: writing-schema: explain
 additional/unevaluatedProperties
Message-ID: <170784137875.1471908.10199519978929933920.robh@kernel.org>
References: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>
 <20240212150524.81819-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212150524.81819-2-krzysztof.kozlowski@linaro.org>


On Mon, 12 Feb 2024 16:05:23 +0100, Krzysztof Kozlowski wrote:
> Add to the list of schema contents expected keywords with their
> explanation: additionalProperties and unevaluatedProperties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/writing-schema.rst    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Applied, thanks!


