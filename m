Return-Path: <linux-kernel+bounces-44847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC484281B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA8B1F2574A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48E82D8A;
	Tue, 30 Jan 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEUZmIfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03B7F7CF;
	Tue, 30 Jan 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628807; cv=none; b=tokEfzQudBwbjhr4bM6PvIzF+rhv/CupW/gBvGDij+J/ZYqkGZbCfEaVdh4yv62pcDEqcY+M2kBTrzJgNUL5GNd5RSA/2r9DUrSiOIwuISSujYFnf25u71m+ospwu/YqapQfvLIy5r5712bKNbpmQv4nD4rVE6pHSY4Qy7Fz1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628807; c=relaxed/simple;
	bh=xL9kFnUvGlP9fBkvgK0in4ewf6ZPO4qQZEK2ExFEHDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZPHlAgUbtbS+H+C8B61WuIkHA36QZXGRY+pGgrKK6mWDI73z5cpYSoTfvcEwjDXKIJ9kWJP7hXcN5tourfxZwGbKz777oZ2SDaOiZSonxSbHjSiC97GNQ/YGVMqHgtipCS0jjtODSk86sO1qXt5ZA1yRUAy7txngiZUpDd7EQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEUZmIfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC3C433F1;
	Tue, 30 Jan 2024 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628806;
	bh=xL9kFnUvGlP9fBkvgK0in4ewf6ZPO4qQZEK2ExFEHDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEUZmIfF+/ZFfhkJ3j7kTnmXvKgFiXwU2qigFrT46q3b8HIMfyqkw+WzXrm9Mhkh4
	 LZNOEMSgh85IO6caMHOLwHdKOohDvsEo3cgbbsQjw4m9c9lofKrVQ3k6yh4SNcwBoa
	 Dan/4pjo9RcTNFU+BvpwXuRRtJxKgfg1EPWjWohZCKy2VqmS8iCmpGC48n4PHfjk6X
	 I4Cmxyb+XMMh7NpYq0Lg9UZW1VjxvUBrilF0PRAuiQLlRj7p9jn/NYTj/IZx86z3le
	 Eqsjgl06VCmBYhZu1PY+rAhK+lJnKpnxkgtzVZotG2k8sHTWulLXTaGFITD1+1EUxv
	 RBELXLAODvuXA==
Date: Tue, 30 Jan 2024 21:03:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>, bhupesh.linux@gmail.com
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Drop unreachable reviewer for Qualcomm
 ETHQOS ethernet driver
Message-ID: <ZbkWwn-oN5wqoPfJ@matsya>
References: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>

On 29-01-24, 11:12, Andrew Halaney wrote:
> Bhupesh's email responds indicating they've changed employers and with
> no new contact information. Let's drop the line from MAINTAINERS to
> avoid getting the same response over and over.

Looks like Bhupesh sent the patch changing but never followed up with a
v2 for this:
lore.kernel.org/r/20230915191600.3410862-1-bhupesh.linux@gmail.com

Would prefer if this is changed to his email (copied him as well)


> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> If anyone knows how to contact Bhupesh / if they're willing to continue
> being a reviewer feel free to suggest an alternative, but for the moment
> this is better than nothing.
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 939f6dd0ef6a..b285d9a123ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18080,7 +18080,6 @@ F:	drivers/net/ethernet/qualcomm/emac/
>  
>  QUALCOMM ETHQOS ETHERNET DRIVER
>  M:	Vinod Koul <vkoul@kernel.org>
> -R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
>  L:	netdev@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> 
> ---
> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> change-id: 20240129-remove-dwmac-qcom-ethqos-reviewer-1a37d8c71383
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>

-- 
~Vinod

