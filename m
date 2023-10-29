Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3457DACAF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2Nsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Nsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:48:51 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D2BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 06:48:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CC5F40004;
        Sun, 29 Oct 2023 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698587325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C29Y/0MMpQE3H8sEiOwcDim+jc5OpB518WeaoXpI/E=;
        b=IKfUb/fp+gNnT0EgVAJT4mDaUzIvFqi0GL14YuLu0gcJIgJ9VLkvLjrf6f4+enHf9HYe1/
        m0WdhpBfoT3ZUbKb7ITGwBxwDlc4h7Uy1DM1QdEAftS99S32qhKWZHONgKqt3b3cMbGSH8
        xW9BF3362EjglG4vCTjh1lbaNqJUP5JUbo701XH/oxg4D31txgGSwBdSQYsvMWvkI5zxD0
        6eDb7dAj60PkCNYW3/AJUKU3b/wYzqZZcfowTV029M6nKCJOQ98QsRxkGRE+scMPPzCbZy
        YjS3k+Ds3aPdyqtkSb3EgTqfSMOMw2/VREmYUHTnfNsHI9728FFTcZUJuHgEUw==
Date:   Sun, 29 Oct 2023 14:48:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND
 flash
Message-ID: <20231029144840.484facee@xps-13>
In-Reply-To: <20231029072005.6097-1-amadeus@jmu.edu.cn>
References: <20231023095451.65c4c0ec@xps-13>
        <20231029072005.6097-1-amadeus@jmu.edu.cn>
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

Hi Chukun,

amadeus@jmu.edu.cn wrote on Sun, 29 Oct 2023 15:20:05 +0800:

> Hi Miquel,
>=20
> > Any way you can detect this and fix the parameter page at run time
> > instead? =20
>=20
> Sorry but I don't know, I know very little about this.
>=20
> Thanks,
> Chukun
>=20

It's more like a request than a question. Please fix the parameter page
at run time by registering a ->.fixup_onfi_param_page() hook in
Toshiba's nand_manufacturer_ops structure.

Thanks,
Miqu=C3=A8l
