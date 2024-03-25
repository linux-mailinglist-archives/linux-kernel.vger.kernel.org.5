Return-Path: <linux-kernel+bounces-117439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577688AB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D1A1C3CE0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141167173E;
	Mon, 25 Mar 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD82Pt+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D35C903;
	Mon, 25 Mar 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382841; cv=none; b=Z39pNBEaXIy7Op9fJ8DvxwAMN/fIJ/kOeZxT6CC4ynFLGX8k4a7Nihl4sqrv5wpSF7TEJSWbj5KjXwsCkLvKYDMx1RAQ0HUIsStJRqI/tJJzrjC84FmVqpP+sYDTybxBcLcQNEzLun9Gd7UmXm5TAfytbchniAWwW32s1bmalm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382841; c=relaxed/simple;
	bh=v172qyV8Bc8XH/ooY9B7LjnhNHws+VqGP6W473NqwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAgcTbbYA2PiaFwbEx1b1ExTUiaolyH31vDqKFnUsSN0eCqvLBWlwCz/KFN/fYf6x1OWdQJt+vsnz8NRgovrpUFOb+5186kuZLnhMv92lqDkOJbwHZcLZP+BBR7c5PsiKxluuqqgylieQ1mOXnqaLH6xscZuD3XfOP8RxyHG+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD82Pt+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE99EC433F1;
	Mon, 25 Mar 2024 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382841;
	bh=v172qyV8Bc8XH/ooY9B7LjnhNHws+VqGP6W473NqwCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nD82Pt+pejN4D7WaAZ0MN0xlJiy07AQqA/7+WsoO+fVHn4pAqeTa3Sw8pHaRW4lqD
	 WB9JG2K/O9BX3cu75Pyd6iV3l9kaF86LItzZJni7xq17fXXSk5uUODdO00jcINBG9D
	 EaQm6A1CRaooijLYNYfc+hDzbIiO/TukSv/rjRasgGeTN6draitpktrqdqICtMtk9+
	 5Zr22ysB12cOUsNKLNUn5NxCDN1bplrY7O+3YZ9yn8UXjWH2wXxtyKy0G5gfFBd9hi
	 xK4X+ABVsUL1Ox837xs5wd5nzIQKqnDlDyaiKXtXUewwhoW+LSLxLxkvKDRZmw7mU0
	 0/5+tyGOjI5dA==
Date: Mon, 25 Mar 2024 11:07:18 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: dt-bindings: add missing address/size-cells to
 example
Message-ID: <171138283534.4134792.6088114833940330306.robh@kernel.org>
References: <20240325091139.18602-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325091139.18602-1-krzysztof.kozlowski@linaro.org>


On Mon, 25 Mar 2024 10:11:39 +0100, Krzysztof Kozlowski wrote:
> Complete the example of recommended order of properties by adding
> missing address/size-cells.  They are not necessary to illustrate the
> style, but lack of them us bit really correct DTS code which might
> confuse readers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/devicetree/bindings/dts-coding-style.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


