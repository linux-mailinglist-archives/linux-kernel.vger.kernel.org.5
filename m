Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55B7F9B68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjK0INU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjK0INP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:13:15 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025F138;
        Mon, 27 Nov 2023 00:13:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 904BAE000A;
        Mon, 27 Nov 2023 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701072798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gwtotMkyInHvaujAg6JsxkLZJLTKN68b8bnxHuv0oQ=;
        b=hnWwTnG+thPOUXHyN88he4IldYTntNd9L6f6v9L3Iks1J0WgsvXr8Ll6h+vfCa/fg9PnbI
        YExj33cc+qcfW/j0QNAY2xC1uTfrjghTxBAysOdZTzjZQ1GZ4/EcfSBj8Mv278IjTXsFWP
        bBlKBdsRNRJIU0AKjobDVrHDY2O1z9HiamQI5i4dB8w66D2l8cbslK1WQDVP5g9n2ah4x3
        11ZIG+ow+UBQjXq5Yrh/fmjHfUUzZIDDl1yUnZkvZCnIWX4fXs04nYMcP+sVHYi2AAVpFR
        UWJVERwmiCPzTHrpYTUFzr7rOqI8moZgy4ODFLrC17PwQyrrt80EfocAAV+7Dg==
Date:   Mon, 27 Nov 2023 09:13:16 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: Do not expect fixed layouts to grab a layout
 driver
Message-ID: <20231127091316.5b56a224@booty>
In-Reply-To: <20231124193814.360552-1-miquel.raynal@bootlin.com>
References: <20231124193814.360552-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

On Fri, 24 Nov 2023 20:38:14 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two series lived in parallel for some time, which led to this situation:
> - The nvmem-layout container is used for dynamic layouts
> - We now expect fixed layouts to also use the nvmem-layout container but
> this does not require any additional driver, the support is built-in the
> nvmem core.
>=20
> Ensure we don't refuse to probe for wrong reasons.
>=20
> Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells *layout*")
> Cc: stable@vger.kernel.org
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

[fixes probing I2C EEPROMs using fixed-layout]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
