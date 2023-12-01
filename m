Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537FF800A21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378639AbjLALzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:55:01 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5571B4;
        Fri,  1 Dec 2023 03:55:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2031D240009;
        Fri,  1 Dec 2023 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701431706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyrHR3xQvFZqYpSgaO4Yekhq+6bnItgb7/+ZV0mlCFw=;
        b=iCHbatUaVfY+IwgqGPkS88aNn6XYuQvR46LCRbzPCsVQ4GdUDiNnj20SpObr+PxSpL0FZC
        2ctu6Ml6dZXPtiIHf454Iu3X7vm0gL0P1EBUSFk2qB7WwykbS/mAkV9O0WwtRAryh1qh8d
        Ps4uR8Ef+Fog9u6NhrT1oPI7CvI7haRbFW7h8KhOlL0I9imPCGmr2pRZUnMKfdGDySr0V/
        2Y6qa0cibIAue/TI3N9E2ew/gNwZOBpL0FTSgLzZ2EH/8+IDgJai9BAqqujDI7c4nI8/FE
        1v0dUkLkJqzGRY5g2o0TUCdFjeYLexmEaUajH1QFJ2bzOo8tGkHDnWw7ufpkwg==
Date:   Fri, 1 Dec 2023 12:55:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     David Regan <dregan@broadcom.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nand tree
Message-ID: <20231201125503.1bedb057@xps-13>
In-Reply-To: <CAA_RMS5THkAQxEPWvtpcbb=F-G1xdntZPTmzhAhvK6voWi6VOA@mail.gmail.com>
References: <20231201125648.71d7586d@canb.auug.org.au>
        <CAA_RMS5THkAQxEPWvtpcbb=F-G1xdntZPTmzhAhvK6voWi6VOA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

dregan@broadcom.com wrote on Thu, 30 Nov 2023 21:03:00 -0800:

> Hi Stephen,
>=20
> from this post:
> https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0=
f172d58717
>=20
> Looks like this comment needs to be added:
>=20
> * @deassert_wp: set to true when the operation requires the WP pin to be
> *                         de-asserted (ERASE, PROG, ...)
>=20
>=20
> What's the best way to go about doing this?

Please send a normal patch and I will take care of this.

Thanks,
Miqu=C3=A8l
