Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCB7CBCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjJQHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjJQHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:47:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B244F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:47:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4000EE0013;
        Tue, 17 Oct 2023 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697528857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KM4KLRt+5IjihJQXo+jsfeiMylcvEg8wsmECyvz1s2w=;
        b=Be89U5XdfZrxV3tdfaRI6U03c0zVST+3R5wj9a+lldE7BTkUeeO2fPdT+64gpFJIXowRHD
        T9BbPAZEmCc7PcTZWu4XfjiLMRQgFWAgLoiKpEHiUyg55Ua0yEizvxV2VUQIO7DKUYGNaW
        QvaP7uxzbn+pdBQgkdTfPuMHCmnft29BIyll7fAScoBGGpPdCMnH4aviENb7iuH0pMK5xy
        jIkZI/5PnHiroxmOhR6NXVNhsOOHwHLezZeJ1UXLUTM3Yl8FI9AvP/Qgf9FTn0Bzfdqp5Q
        izijN3S57/VAqr7sBA883cQQBImifKC7wtkN8aNOtm/yN/fPZ1lD0aUwEs/EdQ==
Date:   Tue, 17 Oct 2023 09:47:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add destructive operation
Message-ID: <20231017094733.14181153@xps-13>
In-Reply-To: <trinity-cbcf4faa-c0bd-4cac-a435-2ada79887cda-1697523547686@3c-app-mailcom-lxa03>
References: <trinity-d4b16b4a-e223-4daf-8a3e-4aaa7fc6c9cb-1697071235519@3c-app-mailcom-lxa05>
        <20231012090638.1e093fe6@xps-13>
        <trinity-902f8ae6-26e3-484b-ba2d-00946a63333a-1697132171458@3c-app-mailcom-lxa13>
        <20231013104809.15821b9f@xps-13>
        <trinity-cbcf4faa-c0bd-4cac-a435-2ada79887cda-1697523547686@3c-app-mailcom-lxa03>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

dregan@mail.com wrote on Tue, 17 Oct 2023 08:19:07 +0200:

> Hi Miqu=C3=A8l,
>=20
> ...
>=20
> > > > Please use Boris' kernel.org e-mail for the authorship and SoB   =20
> > >  =20
>=20
> ...
>=20
> >=20
> > It's in .mailmap: bbrezillon@kernel.org
> >  =20
> > > > > Signed-off-by: David Regan <dregan@mail.com>   =20
> > >=20
> > > Do I still keep this SOB or should I change it to something else? =20
> >=20
> > You need both SoB: his then yours.
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20
>=20
> Thank you very much for the information!
>=20
> I believe I have the git sendmail issues resolved, and I may be sending
> the next patch series via a Broadcom email. In this case should I send
> the series as v3 even though it may not link to my previous messages?
> (Although hopefully the messages will stay together as a group.)

Yes, please.

Thanks,
Miqu=C3=A8l
