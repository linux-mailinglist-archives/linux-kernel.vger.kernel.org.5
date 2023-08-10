Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0080777BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjHJPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHJPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361B26A6;
        Thu, 10 Aug 2023 08:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 508A365F37;
        Thu, 10 Aug 2023 15:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953A5C433C7;
        Thu, 10 Aug 2023 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680184;
        bh=86/qEbpjXU6huokUSRZA5Coce8+InMH7jmzOJRJa4xs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lJN7it5RwiwOtGamw891hkoJCorwKaD5yfuFXWNJ21iBDlp2Com3jz/Ozd7HFoGKk
         brKgR1vZGC+ZmGM6wVIS/hj45cZLaDAtnpi9Za1QXYMLpZ/41U+7up7zANCgMrFqno
         y9YMVMBGZZnlsL7UpOeOJ5IJu/QPM/bsbdEexY97ldhFvJPQM9dNQTHnOlw8R8X1G2
         7ArWtfBGs0c7LRet/VNfMOEgVNzWM34ow9VE6zswGpRfvzRLyjoHFsz6Pz3mCFxTJF
         kzXhJ5ylVH8c1u/eamJH6aDOFfmGSCUGRp6mYkqpcpA+IU6OhCg73Kcej1/mOn62rQ
         8vNcp/Tz61usA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:09:38 +0300
Message-Id: <CUOYKPH9MWNC.1F4F1WZY6M9IR@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_PRODUCT_VERSION string
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>, <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.15.2
References: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 9:18 AM EEST, Peter Ujfalusi wrote:
> The patch which made it to the kernel somehow lost the "01" from the
> string, making the match to not work anymore.
>
> Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@=
linux.intel.com/
> Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UP=
X-i11")
> ---
> Hi Jarkko,
>
> Can you send this patch for the 6.5 cycle?
> edb13d7bb034 was applied in 6.5-rc3 and I just updated my work tree to no=
tice
> the regression.
>
> Thank you,
> Peter
>
>  drivers/char/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ac4daaf294a3..2bb9901a329a 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[]=
 =3D {
>  		.ident =3D "UPX-TGL",
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL01"),
>  		},
>  	},
>  	{}

Yes. I'm sending a PR for v6.5-rc6 tomorrow anyhow.

BR, Jarkko
