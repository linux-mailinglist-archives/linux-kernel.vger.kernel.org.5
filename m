Return-Path: <linux-kernel+bounces-146870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0268A6C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D311F21A22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7B12C490;
	Tue, 16 Apr 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/8M0mX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2A12BF29;
	Tue, 16 Apr 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273766; cv=none; b=LuaglPOzDRFk217TyEnp5yGkubrGnpr61hI65Nwlcebrc/q2hDOCD3TQhKrM2jNKZcgOq4qNRON64pO9N7+HeVWO70Mxr72zfhOdiE28CrXgrJGgpO7HXgT3mEQvTQZM/jQ5hnfPKGjI0eFi+rfgDPMHWYPJA4yifOOHooGXKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273766; c=relaxed/simple;
	bh=Nr3+sLsToLLyElFhQSsGyV1Oz1NUsIJerVdvfb7oelI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg/m6ZYbgzVzVVjKh5LG8cHbtwPSqGM9Hk/7znOMPKtTOFdNrQ+V9WuGs/+jsZaF1un0GOhkl23nUPe3ybVKiyP2kVSROHkNfKKS7m2pWQPy9H1BQAu8LAw8Jnb9QF1zBzsnt5j0ZG7otskr/X/rLcWuno3qWnkYpuAGRzcVQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/8M0mX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F069C113CE;
	Tue, 16 Apr 2024 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273765;
	bh=Nr3+sLsToLLyElFhQSsGyV1Oz1NUsIJerVdvfb7oelI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/8M0mX/82ZzV/zhk3xGhE9dImO72ne4TdVOYtjNGH5WHkFVk19BgXkCNF5QqJgzw
	 qOhv96wOHy5G2sq6aVfna5dTE6NyGDWOXZj56PI1mmXZ7YvqkZtwyaIK/aujoCXYKX
	 aJLBYhLLujUflew/hAvnqN6YIDd17NS06Di2Efm+uq5cy6OFaYDQ9OJOQ21jPTK55l
	 4fE8MbnNg7NLQWo7Frqye+SnFu58HGG7kJb1j+VRBGQjE6xZ09k4ZJi+dZLyxnv3ns
	 0JLELTPpmMkplYXhVmO53Qnjd9k6fYE2z/8ljAyigpu0yEf1lqhz9bIFT5eQoMXtVs
	 wONDNIL1z5fIg==
Date: Tue, 16 Apr 2024 08:22:43 -0500
From: Rob Herring <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, sudeep.holla@arm.com,
	conor+dt@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
	jonathan.cameron@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Message-ID: <171327375957.2147382.5296406072245589287.robh@kernel.org>
References: <20240412192801.554464-1-cristian.marussi@arm.com>
 <20240412192801.554464-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412192801.554464-2-cristian.marussi@arm.com>


On Fri, 12 Apr 2024 20:28:00 +0100, Cristian Marussi wrote:
> Add bindings for the ARM MHUv3 Mailbox controller.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 -> v4
> - using ARM GIC defines in example
> - defined MHUv3 Extensions types in dt-bindings/arm/mhuv3-dt.h
> v2 -> v3
> - fixed spurious tabs in dt_binding_check
> v1 -> v2
> - clarified extension descriptions around configurability and discoverability
> - removed unused labels from the example
> - using pattern properties to define interrupt-names
> - bumped interrupt maxItems to 74 (allowing uo to 8 channels per extension)
> ---
>  .../bindings/mailbox/arm,mhuv3.yaml           | 224 ++++++++++++++++++
>  include/dt-bindings/arm/mhuv3-dt.h            |  13 +
>  2 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
>  create mode 100644 include/dt-bindings/arm/mhuv3-dt.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


