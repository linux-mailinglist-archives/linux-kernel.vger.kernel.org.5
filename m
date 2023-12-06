Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0778069F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377177AbjLFIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLFIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:41:37 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ACBA1;
        Wed,  6 Dec 2023 00:41:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FDD220004;
        Wed,  6 Dec 2023 08:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701852100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXU57gWotBm7I/l7GKsWF7uvDD3oXFTjUZ5xXd0u10A=;
        b=ETqbu50vQezP1pXb8hRNCEfD9UrHVYkoav5rUn+OJ+r1F1ZiC6lrr5IATcOV/SRpBJmw3u
        GyTIlXdyfIqs4MUz5OEYMchaKsBxOVvJltxI0rXq9OUipwfsZFnui9CG3UqFKxP2pYkhWH
        TR/0/7EG4texGUEY91r3VRox3vwS3IUd4clRgkToG/ml9Ema3JE2lGFiHqj7EnRxhMCBCP
        Hz07fNdW+BFp4qASZck2gNCF1NT2YwYbXwF8Hgs32pT3DxKxg57k2Sw/iM5dxEODTPlHCH
        Zl07LYFpAxqGSE1GdRVRvtRC4LWKZcZzOAh8NUc7lEXJngm2ORqbSN5Ac7figg==
Date:   Wed, 6 Dec 2023 09:41:36 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231206094136.4e0b10eb@kmaincent-XPS-13-7390>
In-Reply-To: <e6752370-7aba-4b47-90ff-7896a49ba84b@wanadoo.fr>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
        <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
        <6eeead27-e1b1-48e4-8a3b-857e1c33496b@wanadoo.fr>
        <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
        <e6752370-7aba-4b47-90ff-7896a49ba84b@wanadoo.fr>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 19:01:47 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 04/12/2023 =C3=A0 23:16, K=C3=B6ry Maincent a =C3=A9crit=C2=A0:
> > Thanks for your review!
> >=20
> > On Sun, 3 Dec 2023 22:11:46 +0100
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >  =20
> >>> +
> >>> +	fwl =3D firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
> >>> +				       &pd692x0_fw_ops, priv);
> >>> +	if (IS_ERR(fwl)) {
> >>> +		dev_err(dev, "Failed to register to the Firmware Upload
> >>> API\n");
> >>> +		ret =3D PTR_ERR(fwl);
> >>> +		return ret; =20
> >>
> >> Nit: return dev_err_probe()? =20
> >=20
> > No EPROBE_DEFER error can be catch from firmware_upload_register()
> > function, so it's not needed. =20
>=20
> Hi,
>=20
> up to you to take it or not, but dev_err_probe() also logs the error=20
> code in a human readable way and it saves a few lines of code.
>=20
> If I remember correctly, it also saves some bytes in the .o file.

Oh, didn't know that.

> Other than that, it is a matter of style.

After some thought it seems indeed better, I will move on to dev_err_probe(=
) in
next version.

Thanks,
Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
