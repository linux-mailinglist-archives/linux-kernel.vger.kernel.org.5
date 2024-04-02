Return-Path: <linux-kernel+bounces-127557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D6894D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F21C21BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30B57876;
	Tue,  2 Apr 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5ZmKJhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615F57306;
	Tue,  2 Apr 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046805; cv=none; b=BngCxY0SjX+dSHw7YBmLiWFgPKNZOGCKOGWaS1ddRs8UK4egqrxmLJnorQZfTQqQtaFDFJzrCaO8SxAQvBG9V5C2GP6vtA9519hffffUtIhirRlHfbMwKojSq+i1o5oV/16cwTIGRvW+lUxe9Ivf3Z848AB6cIXC+9sX4r0M8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046805; c=relaxed/simple;
	bh=VdyK9CuL3U4VLQggfdxEFwARCxJ4gjiGjJcF5BjF0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyJG2Thzk4YxhgnyiStsS5J/9whZ3JMhM+llJ6Sj+Rx2S4I+0VnmpHn37RCLwGpxCpU3ZjE2VAMTqP7F5lSeO2Mzct9xS7oHPJ5KzjMcYJ0oAIHmY/h6sxaNWQgLqgrrcaJJQYeMcj/K4/D5IZVav1/zAJVd/g/etIL381OiFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5ZmKJhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390D4C433C7;
	Tue,  2 Apr 2024 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046804;
	bh=VdyK9CuL3U4VLQggfdxEFwARCxJ4gjiGjJcF5BjF0S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5ZmKJhF9YNAaMWvfZ9p1C/M+QVSL16VsCYBS8UfOrI8SQ1rSMMJsRYbcN8B+PRnW
	 hfs/mbCY0u8bEDOeEdYHC+Wt9BPkMxNklqzesIH4T0NNeFmpw9OLhiTtWczoQNdBGA
	 49ew90BVPFIZ4Cda2yniRtAaXdtbuhDZohFpkoUEzCTz1Cl6Dg9RGM2jUHH313XQGR
	 H7ssHz7tNY1Ozhy8Z6ecc7qnaQSh0wIMfpTt9uGJq5cXskeG/2x0+K4gi1S6/v8VVc
	 dIXDfmFaUO7duQBn7Qfm1d7sIrSPYYGXbTZNOBOIXDS1e4kknqbefftpJGamcRd42q
	 zlcfE9PmyE7Kg==
Date: Tue, 2 Apr 2024 09:33:20 +0100
From: Simon Horman <horms@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] net: stmmac: mmc_core: Add GMAC LPI statistics
Message-ID: <20240402083320.GL26556@kernel.org>
References: <20240401024456.41433-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401024456.41433-1-minda.chen@starfivetech.com>

On Mon, Apr 01, 2024 at 10:44:55AM +0800, Minda Chen wrote:
> XGMAC MMC has already added LPI statistics. GMAC MMC lack of these
> statistics. Add register definition and reading the LPI statistics
> from registers.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


