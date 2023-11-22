Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5407F475E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjKVNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjKVNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:08:14 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1316D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:08:10 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 740B4240006;
        Wed, 22 Nov 2023 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700658489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFvIffjeh7UJPy7HOhTCrJstZpn+ngVTAePPWXClIk8=;
        b=b22uI0fU6uVROmNHIJUVxCRkvwkKJ8Nwog9Pd9sSD6nGP3631K6YDNIpgosh03ReDOswsm
        ptKkyqsPt/9HaJZnxxB8ZyN1LiWs86OCrhWaXWkmeFBlaizKDLsIsyVNhW9mJSapFRSFAb
        b68clEpLdXqxBA6vRcUj8FpE8RwWhvZQ7I3aVOlFe2Bnc47aIy9FMQWynO7HjYBZCIGdUD
        ezUf0lrgiLbiCGd6rFG/bVzhfXQxF2XGqtU90CDa2Neke2yIU0ABtPF8S18qj+3f6BYTbQ
        r4fBqNLBnPeKbD7+HRDADqjNfqlKkfgBSl/v2JEiVkzzIqW0q986lTGzCoI58A==
Date:   Wed, 22 Nov 2023 14:08:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jean Delvare <jdelvare@suse.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 19/39] mtd: rawnand: add support for ts72xx
Message-ID: <20231122140803.239a3c17@xps-13>
In-Reply-To: <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
        <20231122-ep93xx-v5-19-d59a76d5df29@maquefel.me>
        <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> > +	int ret;
> > +
> > +	ret =3D mtd_device_unregister(nand_to_mtd(chip));
> > +	WARN_ON(ret); =20
>=20
> Is this a requirement by MTD to have return value being checked?

Yes, for now this is the preferred way, with the hope some day to turn
the return value into void.

Thanks,
Miqu=C3=A8l
