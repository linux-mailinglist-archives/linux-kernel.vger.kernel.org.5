Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54A7FECFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjK3Kil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjK3Kij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:38:39 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C5BD6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:38:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE4E624000E;
        Thu, 30 Nov 2023 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701340723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2o9uX9vrkj04eaNyRdXWxcYczS837OGJ7gj6iTGmilY=;
        b=UoGp5lg0OnE/2Fb0P5Hx25RKvace8C6B9exYB7N4nziLoQ7Ucq44kJ88LK9uJ0qlJ9spAF
        zMCxZAR4GF4LlQorNKWlCaTTgH4AKsMClLNXv6bSea8HPtY9ppo1w7vIRanN/d1BDUCLDk
        6yI6yNif4cJBGOAMLLfAk9kuyDYPhBqnQlwfYArgaJdoXA0sPGHg/XgOVyAxIs3q9fdKDP
        CjlbkcqVOE2QeuyS43x97mkdZKSdija5O/TbMoPO/R8KqwLQ8WFsox3n+UwUXAopfqjEU8
        BtAC/wA0szVIU6K6VthmwSjHjSWngaR0BytVZiaIJ7bcQPxfeaPHC9KlaPaFFQ==
Date:   Thu, 30 Nov 2023 11:38:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@broadcom.com, miquel.raynal@bootlin.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v5 4/4] mtd: rawnand: brcmnand: exec_op implementation
Message-ID: <20231130113840.10500927@xps-13>
In-Reply-To: <20231130103624.715263-1-miquel.raynal@bootlin.com>
References: <20231125012438.15191-4-dregan@broadcom.com>
        <20231130103624.715263-1-miquel.raynal@bootlin.com>
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

Hello,

miquel.raynal@bootlin.com wrote on Thu, 30 Nov 2023 11:36:24 +0100:

> On Sat, 2023-11-25 at 01:24:38 UTC, dregan@broadcom.com wrote:
> > From: David Regan <dregan@broadcom.com>
> >=20
> > exec_op implementation for Broadcom STB, Broadband and iProc SoC
> > This adds exec_op and removes the legacy interface. Based on changes
> > proposed by Boris Brezillon.
> >=20
> > https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02d4=
8da96d41fcba
> > https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d19=
fcd6f45e4696
> >=20
> > Signed-off-by: David Regan <dregan@broadcom.com> =20
>=20
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git =
nand/next, thanks.

FYI, I've applied misc style fixes on top of this patch.

Thanks,
Miqu=C3=A8l
