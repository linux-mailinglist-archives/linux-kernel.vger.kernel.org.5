Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3779D7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjILRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjILRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:43:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FD310D3;
        Tue, 12 Sep 2023 10:43:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982AC433C8;
        Tue, 12 Sep 2023 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694540624;
        bh=ONBHIXmIJpuQpqY8iv+/EpWYcu9jmFnWikMk/+0bMrI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=apqVne7LL2+W2DEta0JBgX7qiqCyEcKQqwauSDf/ABUKeQr+p/k/x+EKNWS63NsJR
         UvDbvxt/aOymQPGMQQeWe1JJhQW5FFHWVzSCcush+/aahSeqpbKLwfnxLXfmXq9G3/
         I07jRWQ3fzwfinnzj7yAvI0E+vNehdVo9yRbROU7creIn7z3yVgNBDR3zT+04PuorZ
         3X+mMh1SiZrZm9Od9D+rO4pHsqzuCC4PO7yhQlfXsV0VF62KjCnadWP0ytsqwOUB6t
         xHf8Zfxh0vXKu1l0wkCCEpXs9jq2+/YoHxEr0OmQDAkDn3bhHI2HKgeE/zdicM/bn2
         UxTZN7+XZOcHA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 20:43:41 +0300
Message-Id: <CVH4IMR7IMFX.1GWUHKK42MKOG@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Fix typo in tpmrm class definition
X-Mailer: aerc 0.14.0
References: <20230912170248.11007-1-jforbes@fedoraproject.org>
In-Reply-To: <20230912170248.11007-1-jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 8:02 PM EEST, Justin M. Forbes wrote:
> Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> unfortunately had a typo for the name on tpmrm.
>
> Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 23f6f2eda84c..42b1062e33cd 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -33,7 +33,7 @@ const struct class tpm_class =3D {
>  	.shutdown_pre =3D tpm_class_shutdown,
>  };
>  const struct class tpmrm_class =3D {
> -	.name =3D "tmprm",
> +	.name =3D "tpmrm",
>  };
>  dev_t tpm_devt;
> =20
> --=20
> 2.41.0

Hi, I was able to apply v2 after all thank you.

I'll queue it for -rc2 pull request.

BR, Jarkko
