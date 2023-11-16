Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81757EE48F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbjKPPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:46:50 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2A11F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:46:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0055AFF811;
        Thu, 16 Nov 2023 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700149602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzP6omckKO6pXhBexT1X2n8wT+/cFEgMRBiyd2eBaWg=;
        b=KZYfnwvsovuEUdw9BicMVkdt6L8HYUJwBzlp4wQSmeQJcF8m365OG77RAHx7AECWuTCv40
        Z96sByOGHIc4KsRGzXpiv5ZUIUW98tnV8TvhoK2b3ypY1OEkcfKoQtaPp9ZpUKdbJyCExK
        qvCVtY9OdYB9llRGycCqSzPlD4chR6NLyl/dIAJD+eRG5XHgPQWmK1Ulr49Ykx/Fc5g5Op
        mZxRFTRZBxhf4ipE0ij3wMkI15RKcnKV18fFs2CRYGCaTijj5gkwlueWWgk1Et7AN+hglj
        6F0FBeHsTul7CMixl9DZqA5946isEjLOGuH8biYeV/Y5mrbS0SbzN2YmOgkTiw==
Date:   Thu, 16 Nov 2023 16:46:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND
 flash
Message-ID: <20231116164640.7eedec50@xps-13>
In-Reply-To: <20231114123008.185071-1-amadeus@jmu.edu.cn>
References: <20231029144840.484facee@xps-13>
        <20231114123008.185071-1-amadeus@jmu.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

amadeus@jmu.edu.cn wrote on Tue, 14 Nov 2023 20:30:08 +0800:

> Hi Miquel,
>=20
> > It's more like a request than a question. Please fix the parameter page
> > at run time by registering a ->.fixup_onfi_param_page() hook in
> > Toshiba's nand_manufacturer_ops structure. =20
>=20
> Sorry for the late reply. This flash is not ONFI compliant NAND,
> so onfi fixup can't work. Datasheet available at:
> https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datasheet=
/201910/DST_TH58NYG3S0HBAI4-TDE_EN_31565.pdf

You said in your commit log that this flash was detected with a smaller
(or bigger, I don't remember) OOB size than it really has. This number
comes from somewhere? Is it an existing ID? Is it an auto-discovery
mechanism?

If it's an ID then why not adding a new entry. Otherwise you can I
guess make some changes in the device geometry in the manufacturer init
operation as well if the fixup-onfi hook does no apply.

Thanks,
Miqu=C3=A8l
