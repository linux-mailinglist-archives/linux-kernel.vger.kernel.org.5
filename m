Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E4757A83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGRLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:35:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B38198;
        Tue, 18 Jul 2023 04:35:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so9145692e87.1;
        Tue, 18 Jul 2023 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689680107; x=1692272107;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=558NNqLSydmCtufja3yaXYAikd07Os786z1m0zlHWWY=;
        b=E/7ooIMi7CamrmGly3+l1A7dDsrvC3XBkUkzZTladYs0HRal4h4kwGIlj4ssnbFpY5
         7d5io1U/q45FolUMlZfNrJLn/5oPtaUJ/trrKPCZ0/LhmgNTsthTHaw/12GxZaGzQScN
         +ky+63IZRgakq8zdLgNG7fXTt6AfUqtb4lMfGxYiCrAogaX5thP52tAg9/JUBqTQ0BmY
         1YUXvr0UrZYBgNUhbaRJVRKDzld2cla8xACCplaknaZ8/QTpug2wjBK96xZAxVitcBOx
         fa30mthT5NqoYc2E4nk9SVDKgRltwrnYYyfllq5DN/pJgqSzyxMrxKYiA0r7E+NdE/St
         v1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680107; x=1692272107;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=558NNqLSydmCtufja3yaXYAikd07Os786z1m0zlHWWY=;
        b=PqeRiF1n3Y4YZuAI/looqSwb4mOnuM/X5sR49/WwP0E5wC+P4kr+qKo98Ata3enXey
         Cu5UKnWMpSFpNsa86zL5eTsZB/p62+i3lc6uepMyiTg2TAXg5XZtBi8vVEOkNmfMYULU
         24obk7rLG04uEFONJi8TdHTQ6jaR87+8p19daSdFYL5iYrWCW0nY31u/v/mpsv6WBP+K
         C7sb3DpB/OKY5ViLZWbVki9o2s0vKF2dgdq89JT+sDa1ZOkOULozLbiU7Pl4alBEWZEi
         MT5eLg5sHbcnPcVqam9wLg5OSYvKQtJg0nQ8XhEvNBenBvcw7NGpicfGVaKGpVkKTfjW
         3C/Q==
X-Gm-Message-State: ABy/qLazH5WsKa08veESXfRabjlqUdDFIFuXR308p/tl/w+koYBZulMg
        qNZ2FUNjOED5aF52tKy1vhw=
X-Google-Smtp-Source: APBJJlFYESW3usU7APpYleOHD+Xy9RuSGKLPcoSl+VlmpwiezgQkXAl6V4lF0/FRuOChmTl6wdbrrQ==
X-Received: by 2002:a05:6512:3da6:b0:4f8:68a3:38e2 with SMTP id k38-20020a0565123da600b004f868a338e2mr12421232lfv.0.1689680107115;
        Tue, 18 Jul 2023 04:35:07 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cfc3000000b0051df67eaf62sm1099053edy.42.2023.07.18.04.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:35:06 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:35:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Haotien Hsu <haotienh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, WK Tsai <wtsai@nvidia.com>,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Message-ID: <ZLZ46fPCdPt1Bpul@orome>
References: <20230718091425.307589-1-haotienh@nvidia.com>
 <525bc794-b797-9a53-7f59-debcfca9edd8@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KDREtPOnoIrM9MEt"
Content-Disposition: inline
In-Reply-To: <525bc794-b797-9a53-7f59-debcfca9edd8@suse.com>
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


--KDREtPOnoIrM9MEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:18:25AM +0200, Oliver Neukum wrote:
>=20
>=20
> On 18.07.23 11:14, Haotien Hsu wrote:
> > From: Henry Lin <henryl@nvidia.com>
> >=20
> > If memory accesses by the Tegra XUSB controller are translated through
> > the SMMU (System MMU), the hardware may continue accessing memory even
> > after the SMMU translations have been disabled during the shutdown
> > process and this can in turn cause unpredictable crashes.
> > Fix this by adding a shutdown implementation that ensures the hardware
> > is turned off during system reboot or shutdown.
> >=20
> > Signed-off-by: Henry Lin <henryl@nvidia.com>
> > Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> >=20
> > ---
> > V1 -> V2: Resend for the typo in the mailing list
> > ---
> >   drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
> >   1 file changed, 21 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegr=
a.c
> > index a56cc81b9404..6ef2eac9835d 100644
> > --- a/drivers/usb/host/xhci-tegra.c
> > +++ b/drivers/usb/host/xhci-tegra.c
> > @@ -1925,6 +1925,15 @@ static int tegra_xusb_probe(struct platform_devi=
ce *pdev)
> >   	return err;
> >   }
> > +static void tegra_xusb_disable(struct tegra_xusb *tegra)
> > +{
> > +	tegra_xusb_powergate_partitions(tegra);
> > +	tegra_xusb_powerdomain_remove(tegra->dev, tegra);
> > +	tegra_xusb_phy_disable(tegra);
> > +	tegra_xusb_clk_disable(tegra);
> > +	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> > +}
> > +
> >   static int tegra_xusb_remove(struct platform_device *pdev)
> >   {
> >   	struct tegra_xusb *tegra =3D platform_get_drvdata(pdev);
> > @@ -1947,18 +1956,22 @@ static int tegra_xusb_remove(struct platform_de=
vice *pdev)
> >   	pm_runtime_put(&pdev->dev);
> > -	tegra_xusb_powergate_partitions(tegra);
> > -
> > -	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
> > -
> > -	tegra_xusb_phy_disable(tegra);
> > -	tegra_xusb_clk_disable(tegra);
> > -	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> > +	tegra_xusb_disable(tegra);
> >   	tegra_xusb_padctl_put(tegra->padctl);
> >   	return 0;
> >   }
> > +static void tegra_xusb_shutdown(struct platform_device *pdev)
> > +{
> > +	struct tegra_xusb *tegra =3D platform_get_drvdata(pdev);
> > +
> > +	pm_runtime_get_sync(&pdev->dev);
>=20
> Where is this balanced?

Well, I suppose we could add a pm_runtime_put() at the end of this
function, but since we expect the system to shut down after this, at
which point any runtime PM accounting is going to go bye-bye anyway,
do we really want to bother?

Thierry

--KDREtPOnoIrM9MEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2eOYACgkQ3SOs138+
s6G2DhAAqDAGSWBzjm2Ul3XGEIDkj9UxFJ5HEhBxD3+oeW1RvnFMMjj54xRV+GwE
J0+4KDAaQVKEp8k29X6hDHR4jDqoMsAWpZj5FGIC2IQBiZUflILX0zajOlTI3l3e
IjS2GUQyQ0/XqJ7fN/tsIK3tY+Phpz+GvttXAqb8srhaY8gA+/n1+/fePx/vYCyw
Ne3Ajz0WLKzOfdUv16uZdlNKVGD6kyUZsgnFjCZpFGxteAUcyEjoJayYMsoJF0ch
SiAI5XWeDM6pxDxJnOX+hk2QF3Wpgv0anxm/3IAu3P923t5+QuIbSEvmOvWiJeXe
ACSpQD/RY5ID5llsr3PxGcTZsOqQ5YRUbq0bcEgfoH6s5WmsEkme1YpVt1YBC96m
Z8yO2IpOiSQOVkBm8s9bg1SYJBZ8hcSgOWX7kXU89TGzz9UrC5bQo7qK+EVDhpXo
HWdDdTdnSCoZSjsln1j3cPkQMAXgb9PSaE7yZUqOj8KTvwRcELp3IrIOhfZ15H+0
3nsPb97Rp3olURkqZIQv0Ex+1OLKMZXmHd2genONATMqHq6Jb4na1svHq/pUx1EK
K4B2MS2ZF8l2QMog0FbWIB3WWyfTurUQ06/usGnG2P9eWfKDOLagApFyHLwDmYul
sDKZqgru6gD+WYgilAoBUgLbhwD8lm9ELvUQ0ncQUuqvwHhJ/Ss=
=nUaM
-----END PGP SIGNATURE-----

--KDREtPOnoIrM9MEt--
