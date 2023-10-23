Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793847D3FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJWTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJWTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:10:35 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420E103
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:10:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBC2940006;
        Mon, 23 Oct 2023 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698088231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQTqFxA2htUn59dyviXFE3afEYPNmc6FuT7Pc/5oDXo=;
        b=VfH2RE8fu683n82J63fAWnyh0YZCsIKYktyJuucgqGBGaWQPg5j+AZjEi8ci0on++E8J9G
        dZVeeNTfESapIOvknDZCI7ObRjEfDo07U7oFh752U3lhkS2j62PgqRUAxEdW3qC9n1XygC
        QzsSCYYK6nkRLs61j00m83eE/c8PEgZff6DCS7pRK1ov1/WMdLO69S10bQZgr5v4zE0CFZ
        uTwXkFVnrMPvsDbk1e2yUgWpSpy01s5iJbgZ8Vpb7pSDACu39S9AFdP82lhgYsf55cqdXT
        U3ZFtzbjaNHJRCRJL/eveRMBEq42GpDxtQvQdEcPw2IDZVZc5EPFgENxrXIKeg==
Date:   Mon, 23 Oct 2023 21:10:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] i3c: master: svc: fix random hot join failure
 since timeout error
Message-ID: <20231023211028.3a4613df@xps-13>
In-Reply-To: <20231023161658.3890811-7-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
        <20231023161658.3890811-7-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 23 Oct 2023 12:16:58 -0400:

> master side report:
>   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x0200=
90c7, MERRWARN 0x00100000
>=20
> BIT 20: TIMEOUT error
>   The module has stalled too long in a frame. This happens when:
>   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> middle of a message,
>   - No STOP was issued and between messages,
>   - IBI manual is used and no decision was made.
>   The maximum stall period is 100 =CE=BCs.
>=20
> This can be considered as being just a warning as the system IRQ latency
> can easily be greater than 100us.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
