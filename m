Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB879CC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjILJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjILJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:41:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57E1116;
        Tue, 12 Sep 2023 02:41:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF2CC433C8;
        Tue, 12 Sep 2023 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694511663;
        bh=51PegvIu8zCzbCvU9YkHXrLIAzh1Rt71MmT7cj1xrT0=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=LBnItSnVBw3+u9b4WkQjmTctDkHYCzIN5ABzZxz3dr+Eq1Q27n/leGwH5TrqSdln8
         Tf5zoMcMMQoAC+Ag5uMt8i4iqe0z75WuZqFjOvbALNcDrZ5vxbdwL8o4QHvyPxCYcx
         KA7Njcr2xV7O+qNzaQ6hhLzhnKATZyZFQz1EYMsnGuiDoz7gLMmfM6dnFGZl6viPSZ
         o+WyZgxIH2Um8ja3MqtzGHtpDa+DmVS07La8XDrdIFkarp5XPARXvRlvfWMfqUW8fe
         YSrZDRI+WoOUmuq7yr78Y6vK4ssHyHe3p4DdwiAGt9imL5BZO5/nP4rYDJJvz1HNHb
         5atIv3lq0eS4w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 12:41:00 +0300
Message-Id: <CVGU920P4LEH.4WNZCAJI4URK@suppilovahvero>
Subject: Re: [PATCH] tpm: Fix typo in tpmrm class definition
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230911223238.3495955-1-jforbes@fedoraproject.org>
In-Reply-To: <20230911223238.3495955-1-jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 1:32 AM EEST, Justin M. Forbes wrote:
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

Unfortunately your patch does not apply:

$ git-tip
0bb80ecc33a8 (HEAD -> next, tag: v6.6-rc1, upstream/master, origin/next) Li=
nux 6.6-rc1

$ b4 am 20230911223238.3495955-1-jforbes@fedoraproject.org
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH] tpm: Fix typo in tpmrm class definition
  ---
  =E2=9C=93 Signed: DKIM/linuxtx.org (From: jforbes@fedoraproject.org)
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20230911223238.3495955-1-jforbes@fedorapro=
ject.org
 Base: applies clean to current tree
       git checkout -b 20230911_jforbes_fedoraproject_org HEAD
       git am ./20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx

$ git am -3 20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx
Applying: tpm: Fix typo in tpmrm class definition
error: corrupt patch at line 18
error: could not build fake ancestor
Patch failed at 0001 tpm: Fix typo in tpmrm class definition
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

BR, Jarkko
