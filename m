Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDF7E08B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbjKCTEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCTEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:04:09 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AADBD;
        Fri,  3 Nov 2023 12:04:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 727D1FF805;
        Fri,  3 Nov 2023 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699038241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dss+61W/+HYAg0e5xd/Pz/gyDtB4Y0Iwbk0N61bIATc=;
        b=N4Lw034G7uM2A93eso9Bw/JSrNQnmJRPBniVBxbVSxgtyFjQf2yN8hb5Qn/H58vXodfjbQ
        JBcHn0KksFszWgp+TxmL7M3e5uuL2/V8IZvbrcgnmS2/xKjOG3kkYIre4IHNgqCkdJvh2f
        eYkc8FCMLZYt1PPEjJGSCqb9FpCPf5oHDyAANyrA8mRhaIgBmfX0yh53NCpu7pmdXEkARN
        lBHtaZvS8FLV1kaJRReVBMYGeKlRwg4RrAUlaN/rqXMXCF+UHYzceETrKY52ucqr8v4C6q
        miXWqx3hX9O15Kugv8k5M8iQX0UTgt6j47M06dyGPiXeatYmYGQEMblSD1Vcng==
Date:   Fri, 3 Nov 2023 20:04:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc:     alexander.stein@ew.tq-group.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        sherry.sun@nxp.com, xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 1/2] i3c: master: svc: fix compatibility string
 mismatch with binding doc
Message-ID: <169903821819.391162.6378829151615918079.b4-ty@bootlin.com>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017194657.3199749-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 15:46:56 -0400, Frank Li wrote:
> In the binding documentation, the compatible string is specified as
> 'silvaco,i3c-master-v1', but in the driver, it is defined as
> 'silvaco,i3c-master'.
> 
> Rename 'silvaco,i3c-master' to 'silvaco,i3c-master-v1' to ensure
> compatibility with the documentation.
> 
> [...]

Applied, thanks!

[1/2] i3c: master: svc: fix compatibility string mismatch with binding doc
      commit: 8911eae9c8a947e5c1cc4fcce40473f1f5e475cd

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
