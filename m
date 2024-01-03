Return-Path: <linux-kernel+bounces-15611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173C822ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF77AB23B21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84519BCC;
	Wed,  3 Jan 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgSXVU1D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2919BAE;
	Wed,  3 Jan 2024 13:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2D3C433C8;
	Wed,  3 Jan 2024 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704289403;
	bh=lH8kEZFrXGI1bnQsKeNEw6UOy6JQqWQ3hm3JYplz/m8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dgSXVU1DAhx22mEbqMUPaaxmD/McWevgEmgyDP6JIU3qB7S/zwZ8K5I+jlJlSzX4/
	 Qsj5NhIMAU5cHGxPC/wZ4ytlfhkrivQPb4eHRdOtfEcAhrRWWr4DKLqyQt+oR3vUMV
	 C/hglmQfQ6xvm76tHbCU2ghf/6e6WoiBFIuK62nQFFhToQl2w3Ur9qkerHIVfpKdfE
	 V9iw9v0WAVHhEBBybTIEptG+37BMkYy5jPDcWW5dLNA3xYsnc1UNem/HZY2r857L8B
	 WCUyewnyypDUo90XPBeuGTw7ZqBpV2i3QaIE9XEvjxqSL4jIxBTMekpfN9bxlQ+qqY
	 RtiytuRCko3WA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 15:43:19 +0200
Message-Id: <CY5465ME87NL.5XCVWIEAJVZW@suppilovahvero>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm: cr50: fix kernel-doc warning and spelling
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231222061916.9552-1-rdunlap@infradead.org>
In-Reply-To: <20231222061916.9552-1-rdunlap@infradead.org>

On Fri Dec 22, 2023 at 8:19 AM EET, Randy Dunlap wrote:
> Fix kernel-doc notation to prevent a warning:
> tpm_tis_i2c_cr50.c:681: warning: Excess function parameter 'id' descripti=
on in 'tpm_cr50_i2c_probe'
>
> and fix a spelling error reported by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff -- a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_=
i2c_cr50.c
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -235,7 +235,7 @@ out:
>   * @len:	Number of bytes to write.
>   *
>   * The provided address is prepended to the data in 'buffer', the
> - * cobined address+data is sent to the TPM, then wait for TPM to
> + * combined address+data is sent to the TPM, then wait for TPM to
>   * indicate it is done writing.
>   *
>   * Return:
> @@ -671,7 +671,6 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_matc
>  /**
>   * tpm_cr50_i2c_probe() - Driver probe function.
>   * @client:	I2C client information.
> - * @id:		I2C device id.
>   *
>   * Return:
>   * - 0:		Success.


Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

BR, Jarkko

