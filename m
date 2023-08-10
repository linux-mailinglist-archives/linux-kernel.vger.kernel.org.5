Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6B777BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjHJPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjHJPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4426B9;
        Thu, 10 Aug 2023 08:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40B36578E;
        Thu, 10 Aug 2023 15:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91857C433C7;
        Thu, 10 Aug 2023 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680357;
        bh=wFMLSK7/t5CyDn6YsvcdZ9E8jXwYcfOsORourb+Bdb0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=nzDEk2YxVMnjFrQAcpw6xO0IDZz0vhvSyg7lqybn4EdJ6sfX0pZwIJnIUqhbS7oC6
         LTy0nEALuQiQx1XGIKt5WcCmcoi4V2hp8aVJ7dCHcNr6EPFJOsp7B+voPVYWTlXTJ1
         yM4/Yfr0PGYsolk/AbIJcLV1V3SpeiFhMj9oqWS/saFGp7N7kUV7V13HM5TN18RWVr
         UgUYtEKRTs8y35UU7w4+Xn497DOfqbWN+UG8pHUoBHH7tq7+SoOp9HgrWiNFAIxf1K
         IAH2JQCN7gqseKLtwnadapOytWskEKoK+OrSRFMU/P/E5jST6SoKG3qqOm60ORuuuI
         ZYlPjHfeGYraw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:12:29 +0300
Message-Id: <CUOYMVSMYYY0.2862H5KZKTIXG@wks-101042-mac.ad.tuni.fi>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>, <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_PRODUCT_VERSION string
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.15.2
References: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
 <7fd8bf2e-e7be-4bc9-b153-b156cf5ac090@linux.intel.com>
In-Reply-To: <7fd8bf2e-e7be-4bc9-b153-b156cf5ac090@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 12:37 PM EEST, P=C3=A9ter Ujfalusi wrote:
>
>
> On 08/08/2023 09:18, Peter Ujfalusi wrote:
> > The patch which made it to the kernel somehow lost the "01" from the
> > string, making the match to not work anymore.
> >=20
> > Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalus=
i@linux.intel.com/
> > Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON =
UPX-i11")
> > ---
> > Hi Jarkko,
> >=20
> > Can you send this patch for the 6.5 cycle?
> > edb13d7bb034 was applied in 6.5-rc3 and I just updated my work tree to =
notice
> > the regression.
> >=20
> > Thank you,
> > Peter
> >=20
> >  drivers/char/tpm/tpm_tis.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > index ac4daaf294a3..2bb9901a329a 100644
> > --- a/drivers/char/tpm/tpm_tis.c
> > +++ b/drivers/char/tpm/tpm_tis.c
> > @@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table=
[] =3D {
> >  		.ident =3D "UPX-TGL",
> >  		.matches =3D {
> >  			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> > -			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL01"),
>
> The DMI property also got changed in the applied patch, it should have
> been DMI_PRODUCT_NAME, I will send v2 shortly, please ignore this version

sure

BR, Jarkko
