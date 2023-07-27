Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46650765747
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjG0PSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjG0PSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:18:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09092D7B;
        Thu, 27 Jul 2023 08:18:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B481EE0007;
        Thu, 27 Jul 2023 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690471103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWVsqfiAbICASCsuV07TQo2D2wCXNnEC6aAuSLdOa4Q=;
        b=XB4iFbsv/Ag8dZs384cd62d1KI7+qhO1fLwQgU/Ho1FbLK7yEueRlXfajHiTEt5u2hTx6C
        duR4pNkAj9oZ5FQdiCxmXxHJEhWWZFdP+yKVZNZ1wefimoATnzcyOzhEibsPi/DApS6Opz
        N9CMJDRgfsBaD925ipffvnXAKVnx0BA5Bzg1H62V6XnpUPsl0PZZ1+kxnTxcs3/t79C/Vo
        6Zb9sRtXztaVoRviKh11IW3pUuDWEZ1TS3YbPXt4aRv8DSmyKqHs1IKA+fJRyj6DYmHcpT
        AxbuU1N8zZtLQHvi1KuqGEEm/p5TDFcxbal+EpIpKWZYh8emxWO1rt1EAraZjA==
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
Subject: Re: [PATCH v4 1/2] dt-bindings: nand: meson: make ECC properties dependent
Date:   Thu, 27 Jul 2023 17:18:19 +0200
Message-Id: <20230727151819.586522-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717053402.1203724-2-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'350301a3d73b217ab3d87ae42d8fcce2795fe097'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-17 at 05:34:00 UTC, Arseniy Krasnov wrote:
> ECC properties 'nand-ecc-strength' and 'nand-ecc-step-size' depends on
> each other, so they must be both either set or not set. In first case
> ECC core will try to use these values if possible (by checking ECC caps
> provided by driver), in second case ECC core will select most optimal
> values for both properties.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
