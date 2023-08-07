Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D27727D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjHGOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHGOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:33:45 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5910E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:33:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E5B924000F;
        Mon,  7 Aug 2023 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691418822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKtPqCM9+PIHJAxQ6f/YY0Vlrdo6mUPL0xywZvSmixY=;
        b=BDO2Q8+lXkOMXUgTtXk/UEu8dkash/Xkd+nezxKkrHwcqwSNMz3Q3+gE+5tEHgQpxeZ8nj
        YwO5aK7c76jY4Ft0Fax7z7fiE8YXdbcOF8qGuI39iMjI5cf+EqeaCa0x/pS7sYgkaxJjXv
        +YhDlw60Pm8nV6w/B2o82WATYTkwDn1z9dsE2j38dvgliOaslcwpRqSOiZJPj6of6yqmeZ
        ChgKT/FxZxD8HwUZf1FtwrN5kMu2Vsz1RYvag6vDPeEvY7W6pXSPOqNZhAnctuMN5F2Qe1
        ryt6Ec4/n8qoLj2vX6r2X8P8elBecMtioEeFACBblfDv2W/ktPEuP0kMbCKAtA==
Date:   Mon, 7 Aug 2023 16:33:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Michael Walle <mwalle@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/41] mtd: spi-nor: default page_size to 256 bytes
Message-ID: <20230807163340.1ebe1e15@xps-13>
In-Reply-To: <cebd793208c9956e0c7be1b528e16627@walle.cc>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
        <20230807-mtd-flash-info-db-rework-v1-6-3d3d5bef4ba4@kernel.org>
        <20230807154754.70e994fa@xps-13>
        <cebd793208c9956e0c7be1b528e16627@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

michael@walle.cc wrote on Mon, 07 Aug 2023 16:29:38 +0200:

> Hi Miquel,
>=20
> >> +	params->page_size =3D info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE; =
=20
> >=20
> > Would you mind clarifying this? It does not look right, while
> > perhaps it is. But TBH, I have no idea what params->page_size will be
> > after this assignment. =20
>=20
> It's info->page_size, it's a shortcut [1].

Elvis operator :')

> I'm not the first one using it (in fact I was explicitly asked to use it,
> e.g. in gpio subsys):
>=20
> $ grep -r "?:" **/*.c |wc -l
> 1268

Okay then... I didn't know this was encouraged.

> -michael
>=20
> [1] https://en.wikipedia.org/wiki/Elvis_operator

Thanks,
Miqu=C3=A8l
