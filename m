Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F007CC57C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjJQODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbjJQODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:03:35 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE1F0;
        Tue, 17 Oct 2023 07:03:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA0A11BF212;
        Tue, 17 Oct 2023 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697551411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiOs9YI1ID+7xm218JICttAfUAvK/5UkhYCx7ePCGkQ=;
        b=KpTFFW951zuT+F79MouKuHxWBk54OyHi5B/wOsPLTPLH8ulW9GAY7Nkwuq56og//cO7Mgo
        eG1H/dfvAm5Q4Ept/hjOz1VrnIiDy2V5iSu0IJqtoGN/gLX7l6sTwvlYGfJPYF98jUWlyh
        0EJiKJoRx+ARTVlkcHUNdXqg6DxPl1ym2MISJ6bPqhvNrFjSO+B3q8rT6nFy2Bu3I/wwJY
        oFL3+/ElyO4kLHn59CvDF58uBUdZIhncxwsN8NojCuBBAgmsGpF1qfP2luPb2V4TkkiByM
        dWOFfQXK+WI96tqw79289nv6x1yOZxrVfYNyLzeqiAP8tPL68AtIdGswJ1ixqw==
Date:   Tue, 17 Oct 2023 16:03:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     krzysztof.kozlowski@linaro.org, alexander.stein@ew.tq-group.com,
        alexandre.belloni@bootlin.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        sherry.sun@nxp.com, xiaoning.wang@nxp.com
Subject: Re: [PATCH 1/2] i3c: master: svc: fix compatibility string mismatch
 with binding doc
Message-ID: <20231017160327.569043e0@xps-13>
In-Reply-To: <20231016211854.2901427-1-Frank.Li@nxp.com>
References: <20231016211854.2901427-1-Frank.Li@nxp.com>
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

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 17:18:53 -0400:

> In the binding documentation, the compatible string is specified as
> 'silvaco,i3c-master-v1', but in the driver, it is defined as
> 'silvaco,i3c-master'.
>=20
> Add 'silvaco,i3c-master-v1' to the driver and deprecates
> 'silvaco,i3c-master' to ensure compatibility with the documentation.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
