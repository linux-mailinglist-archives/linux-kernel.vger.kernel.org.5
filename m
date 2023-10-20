Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E957D10C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377484AbjJTNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377372AbjJTNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:49:41 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAFC93
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:49:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1997EFF806;
        Fri, 20 Oct 2023 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697809778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zngJBNWL2s7OHwgwI6RJ9msvZIk+5luBA5kk8oImGe8=;
        b=D+JciAcnqlZuF76qZVOF5SM8B14odr1sM6EJw8msPu/PEyekNWKje1U2T4IwDyVNvutB91
        1q35bNriijP0kNYB3tSUTbYrUNa6fd7D8O9xCcScJmbITe3wP2U/p7tJ9GVpHtXIgKpKiZ
        bXV2jnYRWhGmSyrVS6dWXDYUarbSCj7/fexplyk8URU5lfhR3fFn29W5byFUl1Kr+LybX7
        QuPs4M980mam62m7/CewDtVhWvmIRzmoWLLBXdiA6smON/srCOLnZQubN0oWKmAu+J3dwJ
        a7WMxdBgWVny0Y1DUrpuiXNWEqCvI9gj3CHIUJjtj1TWsdlbh0aJHv6dXzSvbg==
Date:   Fri, 20 Oct 2023 15:49:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] i3c: master: svc: fix ibi may not return
 mandatory data byte
Message-ID: <20231020154936.55a499ad@xps-13>
In-Reply-To: <20231019222725.3598022-4-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
        <20231019222725.3598022-4-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Thu, 19 Oct 2023 18:27:22 -0400:

> MSTATUS[RXPEND] is only updated after the data transfer cycle started. Th=
is
> creates an issue when the I3C clock is slow, and the CPU is running fast
> enough that MSTATUS[RXPEND] may not be updated when the code reaches
> checking point. As a result, mandatory data can be missed.
>=20
> Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
> already in FIFO. It also works without mandatory data.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
