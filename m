Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC8782471
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjHUH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjHUH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:27:25 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D549B1;
        Mon, 21 Aug 2023 00:27:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 923D81BF209;
        Mon, 21 Aug 2023 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692602838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAgH0DvxLAEMiNliLKZ4cEqqgUQpI+wUaks5do5xsag=;
        b=fX5ULKqLKwPWy4uS6/n2AutYTaG6w3xabcDKnAa5BrfXKl818y+QBXfRMyDVQtPynjzF0R
        ZbqDOjtKk02raew9hFUKCGde6J+a5UTJKkcFkXT/pRwvysYf07IsqBWdkV18qkkbw4/XaC
        mqRx/zSBQoxfGcUZVTlOyUAYYEMJODhsm1TjskJuTa/0NSc6YzFJxybnclB/QeIqnon2h2
        0KqmHINHdeFbVPe+9JuS+OQBWQ+JAfeg//0lY2tvb/ixD1+0VbNZDaGMm/WxKEVmpdY7PJ
        EMyD6WAErQd/Jt2ADnYP0wyGwh4fIfPly5B1zCs2qg8wNNLkrMoX495nwu1jPQ==
Date:   Mon, 21 Aug 2023 09:27:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with the mtd tree
Message-ID: <20230821092715.068a2666@xps-13>
In-Reply-To: <20230821115507.229d85fc@canb.auug.org.au>
References: <20230821115507.229d85fc@canb.auug.org.au>
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

Hi Stephen,

sfr@canb.auug.org.au wrote on Mon, 21 Aug 2023 11:55:07 +1000:

> Hi all,
>=20
> Today's linux-next merge of the nand tree got a conflict in:
>=20
>   drivers/mtd/nand/raw/qcom_nandc.c
>=20
> between commit:
>=20
>   c2fc6b694790 ("mtd: Explicitly include correct DT includes")
>=20
> from the mtd tree and commit:
>=20
>   93ca966b4a20 ("mtd: rawnand: qcom: Sort includes alphabetically")
>=20
> from the nand tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the warning, I'll handle it when merging nand/next into
mtd/next before sending to Linus.

Thanks,
Miqu=C3=A8l
