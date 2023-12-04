Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF1804176
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjLDWQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:16:56 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE415CD;
        Mon,  4 Dec 2023 14:17:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F71240002;
        Mon,  4 Dec 2023 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701728219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS4jS69KLOJnxFovqZv/8vQ3n77jCj0+KLo8w0Mmcsg=;
        b=lofcBWGepeW/OU/1n6lJ8R6GE91nJTN2RoVmxDzB15pF9kdEiP7bO0iK0X1sv/XtlsDrIh
        MnOZIWUSeJRGkli7LMGZAW3C27vp22wofxiW098Qnv8KdgMxEieov+WNEGoBHjUe5LGRVY
        nMIbM0Qc9jsW5R+7C+7nLQLYREMNFbocLbWSmC8E8V+LlcDmlDslF+43uhjYIVVnUSOm4A
        YXnuPlsxnA00gaHZyQXStqWEYInVGusAIN9CpaDQk1HQYaCRYS3jBQ4FT0lsyIeP/nwgMg
        83XERe3VDQtNi4zxYQytFRtKtBs79vu2MVvSgYndNJ/pjq8a4Xb+BXqQVAdPsA==
Date:   Mon, 4 Dec 2023 23:16:55 +0100
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
Message-ID: <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
In-Reply-To: <6eeead27-e1b1-48e4-8a3b-857e1c33496b@wanadoo.fr>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
        <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
        <6eeead27-e1b1-48e4-8a3b-857e1c33496b@wanadoo.fr>
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

Thanks for your review!

On Sun, 3 Dec 2023 22:11:46 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> > +
> > +	fwl =3D firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
> > +				       &pd692x0_fw_ops, priv);
> > +	if (IS_ERR(fwl)) {
> > +		dev_err(dev, "Failed to register to the Firmware Upload
> > API\n");
> > +		ret =3D PTR_ERR(fwl);
> > +		return ret; =20
>=20
> Nit: return dev_err_probe()?

No EPROBE_DEFER error can be catch from firmware_upload_register() function=
, so
it's not needed.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
