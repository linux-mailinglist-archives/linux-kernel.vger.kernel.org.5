Return-Path: <linux-kernel+bounces-89558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D886F207
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEBF1F21E4E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB603FE2E;
	Sat,  2 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxHfguVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C321DA22;
	Sat,  2 Mar 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406659; cv=none; b=gdlAFGT2Qum23DSKSU0JbxmEAi2SsywhkjfJ1R9ft2QfisPrMR//o7S7R7TPuQSoTPDauj1Eht9G/YYLXkfweTY3nXovK5dtNfUYqDYjOM7lQhL7IDQEJ3fLRbVGrGK5kUq5/dedo40kHxwXpOyqjLJSAg8XaT+ufPgtS72fL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406659; c=relaxed/simple;
	bh=5ef50iIgk9tBLjreqhP8f+o4CxPURqkjvCpllkGLct8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyzYSO3dnUJu0+HAb+zrgbvsa9Zr1e3xzaLhRfglRo0kxqbf1wW40AsshYhZGfxlRyjg66Cg7aNeRXnBUaOXjJEXOfh5diDcFFoMKVYYmLUNeVMU6TP5fl0pB2HkhoTp3jfBuEVuZmylT/qXGQC1umQ+LI1Cu3Q3laZ4zAL7XMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxHfguVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B505C433C7;
	Sat,  2 Mar 2024 19:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709406658;
	bh=5ef50iIgk9tBLjreqhP8f+o4CxPURqkjvCpllkGLct8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxHfguVdRGS71akDiuqYM5VYZCsbaQanbYlCN3NHWxtjL01QenLHeBRaOG5vuqi00
	 ycP2feXim6UPZpq6bC2ivTioHHnrvYCHB4SIbhkjBhDiw4kW2oiJkGUX6q0UNMKV8g
	 4DGG3rp0tHFihsdxSEoeqZ0v+nE8BrzN8o9b7v3CkbM57ZjVKAV1F00vnq9FEYQDEo
	 FzbRH6Syl59LZypeWCRCI8xChKZOesifZbrBzyOKQp9KJNIjG7NpjJ937dHEZpyMeV
	 IhwboaZxBbNqcnCv3FJbKANpeWyc7erk5bqTZ7rx6Sz4PFpeBmfQsdSex7zWP36TJ3
	 rTzPnmIYlwdjg==
Date: Sat, 2 Mar 2024 13:10:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 1/9] firmware: qcom: scm: Rename scm_query_lock to
 scm_lock
Message-ID: <kflyrlagnqjyscpcavw6y7pu2y275lfqduidy3hj26cyfiuc7w@wghjxrntmrn6>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-2-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-2-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:00PM +0530, Mukesh Ojha wrote:
> scm_query_lock is global spin lock and only used for query
> purpose with trustzone and that too for one time to get the
> convention of scm communication. It is possible that, it
> can reused for other purpose.
> 

This is not a good principle to follow for something as complex as
locking...

Regards,
Bjorn

> Rename scm_query_lock to scm_lock.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..2d0ba529cf56 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -193,7 +193,7 @@ static void qcom_scm_bw_disable(void)
>  }
>  
>  enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
> -static DEFINE_SPINLOCK(scm_query_lock);
> +static DEFINE_SPINLOCK(scm_lock);
>  
>  static enum qcom_scm_convention __get_convention(void)
>  {
> @@ -250,14 +250,14 @@ static enum qcom_scm_convention __get_convention(void)
>  
>  	probed_convention = SMC_CONVENTION_LEGACY;
>  found:
> -	spin_lock_irqsave(&scm_query_lock, flags);
> +	spin_lock_irqsave(&scm_lock, flags);
>  	if (probed_convention != qcom_scm_convention) {
>  		qcom_scm_convention = probed_convention;
>  		pr_info("qcom_scm: convention: %s%s\n",
>  			qcom_scm_convention_names[qcom_scm_convention],
>  			forced ? " (forced)" : "");
>  	}
> -	spin_unlock_irqrestore(&scm_query_lock, flags);
> +	spin_unlock_irqrestore(&scm_lock, flags);
>  
>  	return qcom_scm_convention;
>  }
> -- 
> 2.43.0.254.ga26002b62827
> 

