Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A017B4F28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjJBJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjJBJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:39:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E4A7;
        Mon,  2 Oct 2023 02:39:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F49BFF80A;
        Mon,  2 Oct 2023 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696239565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXizb9gGd7vJ+bHW/cxJRzpuCYpWwyioDAXH0qfuvtk=;
        b=bEhjfkT+X0IqLZRPfwYa0v73V18GcN5X6Bpb+/p1hV//YXZeuITd5nIjeYPecbadt467fc
        UQDlKMBicXXSdQsMB2taV7+R33Sc/f/wEYPk7zchuLLNZZqSLy2VG6xwkkOf6sKUYmpBGr
        2YKP3uTv3Je+ZFs6k/UGqM9J2Ss5LVpfrN6nHlOAQN+p3jQpj30cL0WorQlsBmrCVZsP4G
        FWq1VlLGK0ZyunKux0YcIPT7CLdpF4KZF/SFelIFpZe3mrJy9Lpo0leELuBaRx6sodmocR
        3Euo8HetgP9pFRBaFE4ME2bsfaRtuskvmHm8myywH1ydKZVw3O4PW65wRtUlfQ==
Date:   Mon, 2 Oct 2023 11:39:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Message-ID: <20231002113911.6bf2b73e@xps-13>
In-Reply-To: <ZRUm4DS3qvRfcPox@ninjato>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
        <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
        <20230922163903.3f49ea2a@xps-13>
        <ZRUm4DS3qvRfcPox@ninjato>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

wsa+renesas@sang-engineering.com wrote on Thu, 28 Sep 2023 09:10:24
+0200:

> > I'm not sure it is wise to merge defconfig changes through mtd. Would
> > you mind sending this change aside to avoid potential conflicts? Each
> > patch can live on their own anyway. =20
>=20
> I checked pxa_defconfig history. Most commits in the last 7 years were
> just removing outdated Kconfig symbols from all kind of subsystems. Like
> what we want to do here. I think it is okay to keep it.
>=20

Ok, I've acked the patch anyway, so now I expect it to be taken through
the mips tree as suggested earlier. Let me know if it's happening
differently.

Thanks,
Miqu=C3=A8l
