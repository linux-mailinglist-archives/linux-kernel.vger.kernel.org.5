Return-Path: <linux-kernel+bounces-167673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CD8BAD41
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73020281D14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CE153596;
	Fri,  3 May 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaLNk9Um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026757CAF;
	Fri,  3 May 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741915; cv=none; b=ktItq0Ah6SV/91l9gNzX3/ug3ZkPXPLfpYtSvy0mnx4Veg8XjzKpkizo/HOpPyA4upBx/LTZjW8KmDne5Vcxjw/fN5InwWp8I2Y0kTbc7LrK++bUmnNsL/fFJKQwRpDe4EtfaECYrX6BnZXzx1+PJHrdzRT0Lro78GF2+ZtgqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741915; c=relaxed/simple;
	bh=ANCH/5fb/NrOj5nrHhzFj3oxEzNnmd9OZHr8GGtNWn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv2j6pdflhhwbqVb3gD0ciDBGqkKb4IWVHDeaRj3Gfr2joMBigR063y5Y9sHW394fEFhdnwCwI+H43GVamv97HYF8UbiaMwd66WG5t5prd9oTftXIThgWduHU8NUfvkAP9GZTnnjPuZT+CBn34yLqM+gPQzB3WMFUmdZ9g5qJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaLNk9Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF068C116B1;
	Fri,  3 May 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741914;
	bh=ANCH/5fb/NrOj5nrHhzFj3oxEzNnmd9OZHr8GGtNWn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaLNk9Um9MrcEpLi6V7ITwtWJwY5tRxkMMF1BLQg+qQ/iRxtOo/utw9flGSH0aFv/
	 GrZFOW3omhjkGFB1zkCGk+0JcWlCu4Tl5ln2WiPLfNGdHORfNr5KtLTMvDhZvkg/RX
	 P1hO5Id7RbqFRFDRC3+oQuJi8+Bf+gca4Sl07OfX3iQhg/i9N9QyYIJAXOg3ZTbVb3
	 8wAK5bCKWBCetkm5d80oYgADcDQydfbJpbi7G+r9/XnfOQuzDUxqXpSFFC0K9/igwU
	 D9+ZHBtd9hjL6z9TK2vHfqBNqQE4mwIBDOjXHZhpa6vHueQXagVMkvrAlCQ3EE4z53
	 FFKtKIaJ2qmUw==
Date: Fri, 3 May 2024 14:11:49 +0100
From: Will Deacon <will@kernel.org>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, shenghui.qu@shingroup.cn,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Support uncore NI-700 Performance Monitor
Message-ID: <20240503131148.GC18392@willie-the-truck>
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709694173.git.jialong.yang@shingroup.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Mar 06, 2024 at 02:16:00PM +0800, JiaLong.Yang wrote:
> 1. 
> The MAINTAINERS file should be in dt-bindings or drivers?
> It's needed by the two subpatchs.
> I place it in dt-bindings. So I receive the warning in driver patch.
> 
> 2.
> When using the new macro DEFINE_FREE(), we should ended it without ';'.
> So there is one warning asking me to indentation next statement.
> 
> 3.
> If the file vendor-prefixes.yaml should be submit solely?
> 
> JiaLong.Yang (3):
>   dt-bindings: Add HEXIN Technologies Co., Ltd. vendor prefix
>   dt-bindings: perf: Support uncore NI-700 PMU
>   perf/hx_arm_ni: Support uncore NI-700 PMU

Please can you take a look at Robin's series for this IP?

https://lore.kernel.org/r/cover.1713972897.git.robin.murphy@arm.com

Thanks,

Will

