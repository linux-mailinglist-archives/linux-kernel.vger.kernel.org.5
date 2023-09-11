Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023279C198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjILBXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjILBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:23:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650611C8D2;
        Mon, 11 Sep 2023 17:33:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C15C116A5;
        Mon, 11 Sep 2023 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469188;
        bh=TllNdsAeJZVEmYHlEsZj5tpY2JKjXsU1MiXsCjv+Kxw=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=npfnh9t+b8VOQJ5vKYGAqd6ihFyVyeIabXh1zhC0E2ZW+hcFegyoIHO2Dhc7mWOJY
         ros0QvZuA91GEEBgD7n2bYccSLAB9fHnYmr3NNEgKcfSp1z4dNpzfqD+TQ3j+BBgL5
         cry1KV33FxzBM86KjbLUYxqEaEP5xc0wVjfYhxD6BRjMrjqvOuOMvCn0u4Tmv7RPB2
         T3McsF9agV7C4dNgqTjnEQmBY13RnMwvmj3rkrYsiztaZzl7qg/8xdtsEHfFQdRzNA
         zD5MHDDGcpVD1kJ4FiFCwFaG/P/5sEbTcYY5bftz203iMaPRg9gaYa52WUQ9DHR1mW
         fzDbXBBi9o91A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 00:53:05 +0300
Message-Id: <CVGF71DQQCJ2.1XC0V5TKKRX5R@suppilovahvero>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <jmforbes@linuxtx.org>
Subject: Re: [PATCH] Fix typo in tpmrm class definition
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230908140629.2930150-1-jforbes@fedoraproject.org>
In-Reply-To: <20230908140629.2930150-1-jforbes@fedoraproject.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

I have issues applying the patch:

$ git am -3 20230908_jforbes_fix_typo_in_tpmrm_class_definition.mbx
Applying: Fix typo in tpmrm class definition
error: corrupt patch at line 18
error: could not build fake ancestor
Patch failed at 0001 Fix typo in tpmrm class definition
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ git log -2
commit ba46245183940de39e42c8456b85ceaf3519b764 (HEAD -> master, origin/mas=
ter, origin/HEAD)
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Tue Aug 22 16:59:33 2023 +0530

    KEYS: trusted: tee: Refactor register SHM usage

    The OP-TEE driver using the old SMC based ABI permits overlapping share=
d
    buffers, but with the new FF-A based ABI each physical page may only
    be registered once.

    As the key and blob buffer are allocated adjancently, there is no need
    for redundant register shared memory invocation. Also, it is incompatib=
ile
    with FF-A based ABI limitation. So refactor register shared memory
    implementation to use only single invocation to register both key and b=
lob
    buffers.

    [jarkko: Added cc to stable.]
    Cc: stable@vger.kernel.org # v5.16+
    Fixes: 4615e5a34b95 ("optee: add FF-A support")
    Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
    Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
    Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d (tag: v6.6-rc1, upstream/ma=
ster, origin/next, next)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Sep 10 16:28:41 2023 -0700

    Linux 6.6-rc1

BR, Jarkko
