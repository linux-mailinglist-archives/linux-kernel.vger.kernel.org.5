Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39A7519D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMHYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjGMHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:24:17 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FB273A;
        Thu, 13 Jul 2023 00:23:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 279B7240006;
        Thu, 13 Jul 2023 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689233025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoDzNSI3ahCfLCs7dMH1IsP0mTjPdlEnGHMJAo/tqy4=;
        b=I9MrwSNG/NmLjdZj0n0800gG+CD7VJbNN9lGJ+a1KrmbzNPjMBpUx8rBQknXmliwUeBg1q
        Wd4TnvdwxmHNsVH6sATdJYlbXZHs1VznmvVMr6IoiBdoCb9v1iIPRzNujiQf8m1Rb0/Qt9
        HfaMfRALerKdaZp//lKn3ix/eF7tDaZ3MrjhGMoJwNIn0Dz/rNCvbyIpYsHZSA+mIm7Orp
        AaxcqoAepP2cxkA1GR4fm5b59xYaU0u5TwzPae0RwKZQ85/AgQMhWMGn56ZB8M/stI5dTZ
        6B8wl8U7lqWs9YnydMsH3N5/AZyTTugKLXIMQnZoum67Tj80C1MqRfrKDTD4Hg==
Date:   Thu, 13 Jul 2023 09:23:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20230713092342.6c25fb05@xps-13>
In-Reply-To: <20230712-headway-unlikable-436a4533d540@spud>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
        <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
        <20230712143220.06a3d6eb@xps-13>
        <20230712-headway-unlikable-436a4533d540@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

conor@kernel.org wrote on Wed, 12 Jul 2023 19:13:02 +0100:

> On Wed, Jul 12, 2023 at 02:32:20PM +0200, Miquel Raynal wrote:
> > Hi Chris,
> >=20
> > chris.packham@alliedtelesis.co.nz wrote on Mon,  3 Jul 2023 15:50:42
> > +1200:
> >  =20
> > > Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
> > > mode 3 so a specific compatible value is needed.
> > >=20
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com> =20
> >=20
> > I need DT-binding maintainer's ack to take this patch, but this commit
> > did not receive feedback (positive of negative) from them and is no
> > longer in their patchwork. Can you please resend the series? =20
>=20
> You have one ;)
>=20
> https://docs.kernel.org/process/maintainers.html?highlight=3Dconor+dooley=
#open-firmware-and-flattened-device-tree-bindings

\o/

Love that, thanks for stepping-up and good luck!

Thanks,
Miqu=C3=A8l
