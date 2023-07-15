Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A2754A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGOQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGOQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:19:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EE35A9;
        Sat, 15 Jul 2023 09:19:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DADDE20002;
        Sat, 15 Jul 2023 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689437978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yy5aynzT+WX47xT4QRYlc8ZdbQrg+GOPHcIEhZNHQP8=;
        b=CO9KYMG5MhWX4NDpLmVQqrZvMM2IyafHPB/Gb9T86PMy8Xpx1Mjxx4qFb96sDcvuGzqvNA
        vulH9EGwQl5cTNGk9EHGeaquo/lrC+stzCGHqsi60qOAP1t0twJqmEroide1k15NTCtAmL
        w8xQlhkUZqkIREHdGtNH2PQLDvFDUEUJACyyH8ufvkvbMai1gS/a/nCUrNxBDBAk5MnFq6
        Wyx4uSHU1elq9IE17xnaDkXCtXBGOYVJglXH21c7zMQLkW0OOU1zJ1Qce3UmiPPVeOqY9m
        c7hNQqmo9a3iL7PRQLP5aMxPIEt0rTwOBYqg+OxaZBUU5p6eK0OUP87wEZbJKQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        Rob Herring <robh@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] dt-bindings: nand: meson: support for 512B ECC step size
Date:   Sat, 15 Jul 2023 18:19:36 +0200
Message-Id: <20230715161936.20703-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711122129.2635558-2-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c3519aed2a3faf77b66350214fb5caa9a0905888'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 12:21:27 UTC, Arseniy Krasnov wrote:
> Meson NAND supports both 512B and 1024B ECC step size, so replace
> 'const' for only 1024B step size with enum for both sizes.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
