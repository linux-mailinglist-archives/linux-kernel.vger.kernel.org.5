Return-Path: <linux-kernel+bounces-71751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3F85A9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281AA1F22095
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9147A61;
	Mon, 19 Feb 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZDmiA1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AB44C9C;
	Mon, 19 Feb 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363525; cv=none; b=gqUBTk8WJ3kE1vYKu+abRDXoX3YNNHvXceF69OOoze1U4mQb9H/EizwJaXgZZL1lGUgPn+QXlKUcs5D26cOIpzg30YquSheLy89xCfOwPFgox/dVAF7a9+Y3OI6c8ciwn5mTU8UjdbXKyNG11Ho2Qm+SP1sWHXcow0K99rPs6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363525; c=relaxed/simple;
	bh=wMNKfNljDxVgzrZucLr6jIgjIOCOrZ/lrIeAT8DiT0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph+0bS55j7ud3jeLX7bOxeHTFbqj0drYfFdZuKRGknnTW6iyQ9DPb82wlgJIEWz1Pj+wuv1ecIz9eXjXYWntSZZm7q8h1Y2+BKndnNcdDvx87fuKC5NJ3ZUOAJbA3g40/w/knSqz60pQ3nQVC352mR1W52dT8ElGRjjRp/bi084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZDmiA1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E95C433C7;
	Mon, 19 Feb 2024 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708363525;
	bh=wMNKfNljDxVgzrZucLr6jIgjIOCOrZ/lrIeAT8DiT0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZDmiA1hdzjbIAcFByxzAVA0EUeL4W30iscLiEQvgH9A7hJRxIcuBsGYSD1/6n3hk
	 K/SVuslQ98pOMYyyLq0TNIgxL7ll9ZbS5CiIwjJYdb+fNZ7vKNFh5X63RwRhfrvwpU
	 ert1v5HbMJbUYdBVzjV/U3eQGPExzOZC6qa1QX6C8cLEGqA07uyy6choii8pzdx4RE
	 mCntkgYNbGrdU8CqLmP2Hgdxoa5UFMgvMi11XJwCqbaecXdC2dlvYMA+jFWRCf5Exd
	 ftVhtAu+TI+IHVMTF1kWFpaLvv7qk52I+eSw8+tBEq7UM3QPcImbnQc7v33yBUhTJC
	 ISav9Deh+bppA==
Date: Mon, 19 Feb 2024 17:25:21 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH net-next] net: wan: framer: constify
 of_phandle_args in xlate
Message-ID: <20240219172521.GJ40273@kernel.org>
References: <20240217100306.86740-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217100306.86740-1-krzysztof.kozlowski@linaro.org>

On Sat, Feb 17, 2024 at 11:03:06AM +0100, Krzysztof Kozlowski wrote:
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>

