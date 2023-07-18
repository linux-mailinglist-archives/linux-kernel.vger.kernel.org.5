Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7C757593
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGRHmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGRHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:42:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC610FC;
        Tue, 18 Jul 2023 00:42:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so4458423a12.0;
        Tue, 18 Jul 2023 00:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666140; x=1692258140;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6CEt4B1fiWeTE+geiMZjI5qydRTvLiaSco1FgfeUmY=;
        b=V2rWDQk8E/ABfOMfMDHDxfVngQWN75ZYx7R48wiPpD4Zlg8u9Q7xX33AJFk46fxR3B
         pGK+4Z/43tGuISlZOznN9e2LLU5DeSvxqoHVxhedJdq+OU3nBREwW6gTKc1pu/Rz6K0l
         rXmq2aPXyLVg1z78jtoRHD0JxtK3nRFQptk6xUaLu08F/wPNbw/UByteIIoDP86MgzAy
         DE8Pvn4thpfKpvGnsVEyPWAxmrDcRIXUb+U+KUmaQK5qo6t20w5fLbR0Jd1+07ziK7YK
         QjbA4pBHsEBac7pIEM1dIloLvGZpT2PVOJyGyC2MMDO25Az4AFPvJk1XS7CHrYk/hT92
         3clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666140; x=1692258140;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6CEt4B1fiWeTE+geiMZjI5qydRTvLiaSco1FgfeUmY=;
        b=b6o+i8m8TO7ElYF6+/8oLyUCVnPolttfCySROM0GCMnCLdFkmTrbGPTG47Jw9SYpCw
         9KKV7XoaF9krVpJ3/XO1PXOown8KJbhjNWaCpukSAZMIklZkoASQheDIhqCokdGK6odc
         9zbFQetSrxUjtLlgsUNxPSBeTD+EogUQeg2xeiT00hgUxByHnPn+PdrV+NFkNZphzhIn
         H3lB5hvjdIuhE5ZtQxEDevLerAcMlqqdkERm00jcFENZDF+PTH6mHvKdFhO1svAU8fDR
         X71s9Wim8C4O538+Zg/zCHacni9/i4P+tFxK+andodEREJIXmvTDTPPK9oODVssxTsqY
         UmtA==
X-Gm-Message-State: ABy/qLbYDlJhDL1x9SDtPiLBaIshNtXhjXCnchGA3jzVOfMcuvGJDjx8
        p4Aujqi8RriTJObJa0EHlaU=
X-Google-Smtp-Source: APBJJlFqQGf1DNrlb7Ot8ofForkF08KcO+GVJXPEQiilmJU/t+JjMKkCCG0AfF7SV+65Ei+Dit2rtQ==
X-Received: by 2002:a50:ee0e:0:b0:51d:9ddf:f0f6 with SMTP id g14-20020a50ee0e000000b0051d9ddff0f6mr13518393eds.36.1689666140279;
        Tue, 18 Jul 2023 00:42:20 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7c70f000000b0051a2d2f82fdsm816558edq.6.2023.07.18.00.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:42:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:42:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, WK Tsai <wtsai@nvidia.com>,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Message-ID: <ZLZCWgJTm5Wk-glL@orome>
References: <20230718072057.233011-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i1iMksCSr7RDaYjM"
Content-Disposition: inline
In-Reply-To: <20230718072057.233011-1-haotienh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i1iMksCSr7RDaYjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 03:20:57PM +0800, Haotien Hsu wrote:
> From: Henry Lin <henryl@nvidia.com>
>=20
> If memory accesses by the Tegra XUSB controller are translated through
> the SMMU (System MMU), the hardware may continue accessing memory even
> after the SMMU translations have been disabled during the shutdown
> process and this can in turn cause unpredictable crashes.
> Fix this by adding a shutdown implementation that ensures the hardware
> is turned off during system reboot or shutdown.
>=20
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

I just noticed that there's a typo in the linux-usb@vger.kernel.org
mailing list address, so you may want to resend this to make sure this
goes to the patch tracker and all.

Thierry

--i1iMksCSr7RDaYjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2QloACgkQ3SOs138+
s6Efdw/+JJgyH70jYy1UUCT2AkarMe45v3dXfFD+Rpr1irftfLTX57TAqQUEBTpV
4wsvkLQNR/PtRdDO2XCddHmfhWRrf06RNpznVGyfUJo0CZ1HZ/Hd79K1aASUBDI0
1eVs58qaCCtU238XJOpdqhNqqpfw2Hm3T0Dnm82vJ6QUODvtF/lp4HNUn8ByCTch
aH7W+U0rcFS+sHewLLdY9tpA/+i9VO5dGzLKsYwIny7f9bkNGp5igv4VLqyyH278
pMhjxuzvo/EZbaAqQrwxnrjEPVJHSOas2LabX3yL/0+EScQXV29SkDregRCoFLis
dJ8mzFcQuVKe9lys/XDOVuEdUo5Rf/qCedEWQjzlxAWa9T1ZXXnH0RvMCT2ttvj0
WD1tHyYYeeHM4JCzpUvmM8jjfcpNUfspVIqSsVuAne3fAtyLzbjl3BqMzg+QSEW7
vebi0SReY86kgwAbdgmo3BxR1kp/e5i9/LESUhNnfaqZ18TmP9DzOl+IhvYMzBcq
/EFX7L+KDIqRCQgqMJz4QsQWkT2Pky1M9XHEkJKVe5TqiPQPlUfi9ugP1SQc+BPc
L9m9Fk9xbzq8vBGMyAb2aKpAAec4Ngs4l9zeigvCM1VPCiMXXTyu1iKGb7musgGT
cSlkkZBKQlLO+NVq/ZxV9n9hhCJ+5wK+QvNqO5NxhdW/CGLDcAc=
=BU6p
-----END PGP SIGNATURE-----

--i1iMksCSr7RDaYjM--
