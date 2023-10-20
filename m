Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B607D10D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377439AbjJTNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377510AbjJTNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:51:05 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05493
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:51:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F0681C0009;
        Fri, 20 Oct 2023 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697809860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEJdh2dlht0YbkjGiXzj0O1UFXr5Vq+0OYseTVm5gD0=;
        b=RPknoZfelsjqVnX7ujKayYxTjgpay25KcKrzIsmenLT/Ui3+XA2AWDhTG+mBuOUh9nP0CY
        JEFOgENRhrNcQ3L57X5oK5O4+Oqm2XdXmCDLbxbGvpypRHVlPUlHslOlxbH83G1L7pEQrp
        ClpVmJXFXM2i9IkHNJqwynQ6hfuL6PYO3PgQkc79hFwJAioHedmAPC8U7vC14IYtbz5fQm
        uB1WjhVbU7LHV6u6lap1+mbVFztdN8T/f+W7GpFZ1K+GRwIr9SSxRv4f1SyLolsRDlG6T6
        v9440lfZ4lvyfA7GGImIAjb23Li7gJE2+g6/gT9iudLRSD9lDSOjWEUM2CMj0g==
Date:   Fri, 20 Oct 2023 15:50:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] i3c: master: svc: fix check wrong status
 register in irq handler
Message-ID: <20231020155059.4dfd4109@xps-13>
In-Reply-To: <20231019222725.3598022-5-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
        <20231019222725.3598022-5-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Thu, 19 Oct 2023 18:27:23 -0400:

> svc_i3c_master_irq_handler() wrong check register SVC_I3C_MINTMASKED. It

This sentence still needs to be corrected, please read carefully my
reviews.

> should be SVC_I3C_MSTATUS.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---


Thanks,
Miqu=C3=A8l
