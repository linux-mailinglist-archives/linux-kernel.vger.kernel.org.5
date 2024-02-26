Return-Path: <linux-kernel+bounces-82264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674E86815D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F46628FBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17369130AFF;
	Mon, 26 Feb 2024 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii0eJzW+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24612FF76;
	Mon, 26 Feb 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976716; cv=none; b=EgwJz23uVHbsUc9GG/1CxqRo07gRVVMsSKPrXbaJeTG8Q9ttovBP3/8hKdMJFf7pi0qsSgfLy4dFnhXcyZndKYeT0gi2PoQIzrT1NLNkwGdx8bg4RCDTYWvLBOuyEzBUrxLs3UT1Ew97+6qI3LoJSoD6uVDpIhRicqXuc/GdH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976716; c=relaxed/simple;
	bh=c2xGuxqUYk6XBV7fQSqwuK1caD9EDtYOazobEUWJOas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwu01lMFOZRdNJn3YSlLrhgsWbPcR2Gf7rG1HtZ+EqqwOVHOUndPPRJxDJ1ziibcBi7sMlYUjWOwDxnpH/Glr43jgVhIML2B8bPl08Sk/sZlUjmaEh9fgNKBTY4VPF2G1jZHNZDNwUBY6/A0gmQRKaaGb5sPB4HNzaJG3yhUTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii0eJzW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A59FC433F1;
	Mon, 26 Feb 2024 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976715;
	bh=c2xGuxqUYk6XBV7fQSqwuK1caD9EDtYOazobEUWJOas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ii0eJzW++KvxdbBE/D8hwpA7r25l0FyTN/fBfzKihg467pkyTf+X7cVoZzRWwNdvp
	 /L5kExZslpG3IcSm+SjS4azgD5oJEmUVZrG1Do5jarIpZ2N7+291+fQO2JXOYwH+HD
	 SHkb5Yie6TVPP1rgsykTLs1pL8cjuR11o5Gaf7VhafgCaaFB5U2aJLuX2b/iMcIk6o
	 6zS+Vn7/NEVBWI8F3b4GuHKgvp0KPHmxJBvoON4GjJ4W09u7Lea69R4FQGjHLXroCT
	 8WpMNN1E62+R8MJM2UlDVtX1VxxkQC6FtSt+g34hjr9OmiZyxVvll5szF7Zc8/2Z8i
	 R6jZ9UuEYRAsQ==
Date: Mon, 26 Feb 2024 13:45:13 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: ti,davinci: remove unstable
 remark
Message-ID: <170897671297.1320339.4266711529554696495.robh@kernel.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
 <20240224091236.10146-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224091236.10146-3-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 10:12:36 +0100, Krzysztof Kozlowski wrote:
> TI Davinci remoteproc bindings were marked as work-in-progress /
> unstable in 2017 in commit ae67b8007816 ("dt-bindings: remoteproc: Add
> bindings for Davinci DSP processors"). Almost seven years is enough, so
> drop the "unstable" remark and expect usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/ti,davinci-rproc.txt        | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


