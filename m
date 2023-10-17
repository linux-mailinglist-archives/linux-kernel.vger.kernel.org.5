Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBC7CC5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjJQORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjJQORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:17:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6EF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:17:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4569D1BF206;
        Tue, 17 Oct 2023 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697552220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzWYE5zWxR4YaYmFe+0XGWID7PzfYYmmrvNow3aY3S8=;
        b=YRgT2TIESp421HGFWArNrytq/Jl2NLfZZUDtPgsnpvAXKMgNPOn644HqVy/S7h/WBrZpCl
        gP3ZJ9sR0xFF6u/yJ5tIsFdO3zTMxGsYXZCfap+NHZQcfuF9fcyBfmI4ucniHIRDIXmwr6
        afJk1w1IXCYYvuA7PmHq5yHmdxQP3/++Lfgm4X7vgu0fCuAgNak27fJKgnWsfVgYc8zkM9
        JSyq+NCIKjQnhbWjS1TuOeYQdyf9Fdt8SDeYsqhcPUiRclkZYDPFCxba7Can1G13X1cEQk
        0466Xg/zkf7/AvLO3xRi+iiseuh9MPORjWcCohrv00/N1TUbMaDqGi3w3sqn7Q==
Date:   Tue, 17 Oct 2023 16:16:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/6] i3c: master: svc: fix race condition in ibi work
 thread
Message-ID: <20231017161658.2de6d9f3@xps-13>
In-Reply-To: <20231016153232.2851095-2-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
        <20231016153232.2851095-2-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:27 -0400:

> The ibi work thread operates asynchronously with other transfers, such as
> svc_i3c_master_priv_xfers(). Introduces mutex protection to ensure the

Introduce

> completion of the entire i3c/i2c transaction.

Did you experience faulty conditions or was it reported thanks to
static analysis?

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Thanks,
Miqu=C3=A8l
