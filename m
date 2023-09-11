Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9CC79C2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbjILCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjILCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:23:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7C13C454;
        Mon, 11 Sep 2023 18:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8AC116A0;
        Mon, 11 Sep 2023 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468924;
        bh=Ulze66Ad1d6zNhaVNx6J3lAT+v/UnU3+VUAUHHsD9Wc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Quy73ISD2M2qEMMOFwoDTOfqKWgeMvZcMQFXSXKIuhE2hLDYgvStxPxYrPkZaDemz
         o1wiunENyCPPcicT/TzpaCcrxkDAJJdH+DiaqJGQ/tpvlaFGBex4MJ6pqOXf+/c+s2
         hoit0GRyD/1ao9orNmCgLdqK7zP7knutRoCFOKMByajH9cG+xntFC3cHlL6gZwRTG+
         yiVoQbL4OXgUtQIaeX/sK4bteLCRhOnKmg1S1nwHS00arQ5g11Tj4/Yux4a27Vy2zq
         eah+eCA/AJjg8vEQ1vErPo/ufncYryDQxWotzDw8i1pU7sJ+e2eSI63to26gekFwfI
         YXoTT1rs8InRQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 00:48:41 +0300
Message-Id: <CVGF3OAVF2W6.3V99S2XAHPTHC@suppilovahvero>
Cc:     <jmforbes@linuxtx.org>
Subject: Re: [PATCH] Fix typo in tpmrm class definition
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230908140629.2930150-1-jforbes@fedoraproject.org>
In-Reply-To: <20230908140629.2930150-1-jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 8, 2023 at 5:06 PM EEST, Justin M. Forbes wrote:
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
>
> --=20
> 2.41.0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks, I'll queue this up for rc2.

BR, Jarkko
