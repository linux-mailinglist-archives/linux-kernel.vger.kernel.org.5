Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4057FB8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbjK1LFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbjK1LEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:04:50 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E595268D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:04:30 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17DFA1BF204;
        Tue, 28 Nov 2023 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701169468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALB/2PJEXwYVACiswllyZ9AnZktQ1Oe3z8KlIjb4z+c=;
        b=BPngda0vE5ETpklq77sq1GUwPFNyctL1BJmAT/UCw/0l75QLzSRYcQZASa1txykwx9zeTj
        HPqac2Tr91WodiXNs9mjHoqa+ieBzoDLmMMlG8TbfDNhyCd+NjiKO2hljWG6hy/fQKZDLH
        rFNt4VM60CeXSretMtIn6snkbwFxZ4Z+XxS2wsFOCNBxEvxVzaFlOyF32F5VfASyXpXqIb
        BrSIY4FgH0mnwgxqDsb/FrFpplQLt7m17s9DeEEN1EDuPl0NAyNq1S+6uhRLdSROeM9r9v
        Chw9n1sOUSY6mH4A7mmMLe6xh92sRgajnG+DqETQDD5nJtPApmXdKRyMexYnDw==
Date:   Tue, 28 Nov 2023 12:04:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     liao jaime <jaimeliao.tw@gmail.com>,
        Michael Walle <michael@walle.cc>, jaimeliao@mxic.com.tw,
        pratyush@kernel.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Message-ID: <20231128120424.79f8f215@xps-13>
In-Reply-To: <756aa94a-3237-4689-885a-1e17504e72b6@linaro.org>
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
        <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc>
        <20231128100313.3c990f69@xps-13>
        <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
        <CAAQoYR=ZAEVeoCwkRmky2CHVeKGX55JijM8Q6D5msz_5iW+jtw@mail.gmail.com>
        <d7bb4580-00b9-4206-bbfc-bd203c21a877@linaro.org>
        <756aa94a-3237-4689-885a-1e17504e72b6@linaro.org>
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

Hello,

tudor.ambarus@linaro.org wrote on Tue, 28 Nov 2023 09:47:22 +0000:

> On 11/28/23 09:39, Tudor Ambarus wrote:
> >=20
> > cut
> >  =20
> >>>> Maybe we don't need this at all, as long as one message remains about
> >>>> the JEDEC ID, but keep in mind that spi-nors are commonly storing the
> >>>> rootfs and if your spi-nor does not boot you don't have a userspace =
yet
> >>>> and all the debugfs entries are purely useless. =20
> >>>
> >>> Good point.
> >>>
> >>> Just curious, do you know any boards which has the rootfs writable on
> >>> the spi-nor flash? =20
> >> I am also interested.
> >> =20
> >=20
> > Having the rootfs stored on SPI NOR is a poor design decision as you're
> > better of with a NAND, which is cheaper and faster on writes. I tried in
> > the past a ubifs on top of a large (64 and 128MB) SPI NOR flash. But
> > they were plug-able flashes, not something that is always tied to the
> > board. Microchip's sama7g5ek comes with a 128MB macronix SPI NOR flash
> > populated. But there are other vendors that provide large SPI NORs if
> > really needed.
> >  =20
>=20
> pressed sent too soon :). What I wanted to say is that it's not uncommon
> for vendors to populate large SPI NOR flashes, there are others as well,
> thus Miquel's concerns are valid. There may be people out there having
> rootfs on top of SPI NORs.

I don't think it is a too bad approach to store a rootfs on a spi-nor,
as long as your "regularly written" data files are somewhere else
(otherwise it's fine, but slow). It's actually nice to keep your boot
files and rootfs in a "safe" place whereas your app is stored somewhere
else, so users can mess around: they will not break the system.

Thanks,
Miqu=C3=A8l
