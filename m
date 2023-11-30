Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA107FECA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjK3KRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3KRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:17:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEBE10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:17:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FE4EFF80F;
        Thu, 30 Nov 2023 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701339436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbfoor/K42HcFZmg+FPYUl7SQccR75WTDfEvqXRzmjI=;
        b=fTuwUGXKtMGJI+ONtelQaDLx5QvoQtmC2cHVCbuWSlmVnscbOQfgqas9yyPsxot9afZhJi
        4VTwJxuIrwizHZyieFoZa/cNFeO/lNJhKOCANrc5JVUmnbZQu/2vpk94s1Aw5FREVnfBf5
        6NBmht5rtizrlFHouxGxqr9c4i/WC9RX+a60Xv7GHH4H7Olj2+5B8QPZxHXflh0EMwjE03
        sDstrn6gaH7sn3cHjOnmsKAu218FDfxs4GFWxNnLIHjLoBJ6L8ScBmlgfWqRNPhvSNdXbl
        0xJrseDvDfigWZMRHUH21LuuXFsPlSVOF42fjJrbEkZgWFw6VRihDkrgB4LGVg==
Date:   Thu, 30 Nov 2023 11:17:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 3/6] i3c: add actual_len in i3c_priv_xfer
Message-ID: <20231130111712.6438de35@xps-13>
In-Reply-To: <20231129221225.387952-4-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-4-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:22 -0500:

> In MIPI I3C Specification:
>=20
> "Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, the
> ninth Data bit from Target to Controller is an ACK by the Controller. By
> contrast, in I3C this bit allows the Target to end a Read, and allows the
> Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
> referred to as the T-Bit (for =E2=80=98Transition=E2=80=99)"
>=20
> I3C allow devices early terminate data transfer. So need "actual_len" fie=
ld
> to indicate how much get by i3c_priv_xfer.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
