Return-Path: <linux-kernel+bounces-88696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E772C86E582
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C15B2526E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BA71B2F;
	Fri,  1 Mar 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8HHwUey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DD70CB6;
	Fri,  1 Mar 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310394; cv=none; b=aW0EKNvaikv7hmaEeNFwFDoDY0FTrL5KX8Z3rqh5BO/kOR3FYse6ktfcoSsG9i2jkIAj0x9Dh6D1j3PZF+u+mGFueOH1KSgaXKjQLvfL2fD6n7s4M8JRZeXlry6KwpR+WO39529tMB5dvBLK/7XIfavjcAYuFBD4LH2E7JzbPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310394; c=relaxed/simple;
	bh=TvXH6saXNfgndMe7jdShDcIe/NSIB7gQ2yk9JpkDGn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udo85MAu0kPkUPseCr4Rmv5xqRxy/u/3D9beze16/GYCiALQ8fSdKVKm2EyeOIlT0SneMeMjQ+eYVN/I0jIhnfgkDaZfTP6BD1hV1W2wc7A5qQBEbYD7KkLn655EAdVe/iUJS3/3owT6wceCH2++f1u+kdxwWHVxM3ov1HQpKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8HHwUey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDB6C433F1;
	Fri,  1 Mar 2024 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709310393;
	bh=TvXH6saXNfgndMe7jdShDcIe/NSIB7gQ2yk9JpkDGn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8HHwUeyo9sVtVc/RAO1ayTmbaD3Z23Oo0ITl1vz9T/FMJwRzvbqazR+e2aFvjBeW
	 wadUfFc0+uTrOVOIYHYn+F4gXQHT4nBKav4nJYrpzOhfJKEXSijHQbrDHe9ruF3rf5
	 nPZiCQr9p6vpFqmDLwYVp2xdbLmuqyvGNz+jDfMz5O5q/e7DsNk4FJxEJrdX/fa9px
	 vj7JamfrK1La7K9tCvG2xx6frkXRcItzx9Wwj1dcdIqod9s5hrYAUli+1RPvduLMIN
	 dJRIwzbCTAkUlOoqqqlD1w/Kmb4wdEEbA8V7/976bGB9iGev7Lahvd5NfCRh16tvxC
	 3rckRK2qKInYA==
Date: Fri, 1 Mar 2024 16:26:28 +0000
From: Simon Horman <horms@kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
	quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
	elder@kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: ipa: change ipa_interrupt_config()
 prototype
Message-ID: <20240301162628.GF403078@kernel.org>
References: <20240229205554.86762-1-elder@linaro.org>
 <20240229205554.86762-2-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229205554.86762-2-elder@linaro.org>

On Thu, Feb 29, 2024 at 02:55:48PM -0600, Alex Elder wrote:
> Change the return type of ipa_interrupt_config() to be an error
> code rather than an IPA interrupt structure pointer, and assign the
> the pointer within that function.
> 
> Change ipa_interrupt_deconfig() to take the IPA pointer as argument
> and have it invalidate the ipa->interrupt pointer.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ipa/ipa_interrupt.c | 15 ++++++++++-----
>  drivers/net/ipa/ipa_interrupt.h | 10 +++++-----
>  drivers/net/ipa/ipa_main.c      | 13 ++++---------
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index 4d80bf77a5323..a298d922dd871 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -236,7 +236,7 @@ void ipa_interrupt_simulate_suspend(struct ipa_interrupt *interrupt)
>  }
>  
>  /* Configure the IPA interrupt framework */
> -struct ipa_interrupt *ipa_interrupt_config(struct ipa *ipa)
> +int ipa_interrupt_config(struct ipa *ipa)

Hi Alex,

There are two cases where this function still returns a pointer.

Around line 250:

	ret = platform_get_irq_byname(ipa->pdev, "ipa");
	if (ret <= 0) {
		dev_err(dev, "DT error %d getting \"ipa\" IRQ property\n",
			ret);
		return ERR_PTR(ret ? : -EINVAL);
	}

And around line 280:

	return interrupt;

This does seem to be resolved in patch 2/7.
But as it is, this patch breaks bisection.

..

