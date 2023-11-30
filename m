Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA427FFAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376284AbjK3TQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjK3TQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:16:01 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FCD40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:16:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 109F01C0003;
        Thu, 30 Nov 2023 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701371766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE9/tLP0eyYG3y00nEhJnVDwOaisqMrxBjBW9/Ybvm0=;
        b=DM6ceKIhBV6tIWBT1O5ejGiMHISZq82LwOsjaEZcszhe+L61E5vrnfgwaLv1tTDKpVarRP
        lQfaK3Dz/6iem1wLq2aORwPTg9BRG0gRkygmx97qDxoaDFuHBkSVaFlMB13DtRZeMsiRXV
        RM5qHfvJrT5U9ABu2DxecrN+isoBUJpNuPKwHQmyQFYR6YuURpD5KlwGVNuSvPA+/Rs3G8
        MsaCKdBURif4juKKYVGjk50hqlCmcEkhFq4pJnDV3CdTj5N49BO6dCBDetH6BTOvhSGVgZ
        Hj1MffyQ1K9Ntf49cvTRlmc+on0RYu8MlplBKwSpXFdKXrnAIyDgGvPiS4sHzw==
Date:   Thu, 30 Nov 2023 20:16:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 6/6] i3c: add API i3c_dev_gettstatus_format1() to get
 target device status
Message-ID: <20231130201602.2944cc9f@xps-13>
In-Reply-To: <ZWjLMNKJElPI6uSo@lizhi-Precision-Tower-5810>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-7-Frank.Li@nxp.com>
        <20231130111959.11afd8a8@xps-13>
        <ZWjLMNKJElPI6uSo@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

> > > +
> > > +	if (!status)
> > > +		return -EINVAL;
> > > +
> > > +	i3c_bus_normaluse_lock(dev->bus);
> > > +	if (dev->desc)
> > > +		ret =3D i3c_dev_getstatus_format1_locked(dev->desc, status);
> > > +
> > > +	i3c_bus_normaluse_unlock(dev->bus);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1); =20
> >=20
> > There is no user yet. Maybe this needs to be done in another series?
> > Same below. =20
>=20
> See
> https://lore.kernel.org/imx/202311070330.5mylauLR-lkp@intel.com/T/#t

Then this patch should be part of the series you mention.

Thanks,
Miqu=C3=A8l
