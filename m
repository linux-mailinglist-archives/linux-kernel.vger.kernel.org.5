Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34B7667E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjG1Ixq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjG1IxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:53:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B593590;
        Fri, 28 Jul 2023 01:52:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33CB843;
        Fri, 28 Jul 2023 10:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690534271;
        bh=RBNPBgVBOEtkucU4s3YaHbDxMVYGoCMmlyMjuaes4ho=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i/b+djCcpDYm5rwVsJVU77a62ezAr5lwrjk9tiGSDGN/zr3oo4wif8kBaPjgYpGOv
         o20d4/QDbCwMEUDocQ9t48QOPSQNDr9WMsIe0gMbgAW+ap53nniP0xJ1goxUaKq0RL
         o1sbsotNo9mkdlvWN5IRCqCj1td2MKh0sLnm/w3w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230727154108.308320-1-umang.jain@ideasonboard.com>
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
Subject: Re: [PATCH 0/2] media: i2c: imx519: Support for Sony IMX519 sensor
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date:   Fri, 28 Jul 2023 09:52:08 +0100
Message-ID: <169053432818.137962.5791887898514618663@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Quoting Umang Jain (2023-07-27 16:41:06)
> Series adds driver support for Sony IMX519 sensor.
>=20
> Lee, can do add S-o-B tags please to these patches
> since I've updated your email IDs at various places from
> info@ to lee.jackson@.

Can you dig and find out what your start point was here please?

This series should already be numbered at least v6, there are 5 previous
postings. The most recent of which was already Signed off by
'lee.jackson@arducam.com' So that makes me weary that v5 was not used as
the start point for this refresh.

Previous versions are identifiable here:

- https://patchwork.linuxtv.org/project/linux-media/list/?series=3D&submitt=
er=3D&state=3D*&q=3Dimx519&archive=3Dboth&delegate=3D

Could you check through any previous review comments and make sure they
have all been addressed too please?

It would be useful if the cover letter or patch described a changelog
from the previous version too to identify what has been updated.

I see the kernel test robot reported failures based on missing
dependencies.

It's helpful to list any dependency information here in the cover
letter too.

--
Kieran



>=20
> Thanks!
>=20
> Lee Jackson (2):
>   media: dt-bindings: imx519: Add IMX519 DT bindings
>   media: i2c: imx519: Support for the Sony IMX519 sensor
>=20
>  .../bindings/media/i2c/sony,imx519.yaml       |  113 +
>  MAINTAINERS                                   |    8 +
>  drivers/media/i2c/Kconfig                     |   11 +
>  drivers/media/i2c/Makefile                    |    1 +
>  drivers/media/i2c/imx519.c                    | 2134 +++++++++++++++++
>  5 files changed, 2267 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx5=
19.yaml
>  create mode 100644 drivers/media/i2c/imx519.c
>=20
> --=20
> 2.39.1
>
