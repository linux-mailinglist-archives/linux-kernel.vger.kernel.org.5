Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780247FEF87
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjK3Mvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjK3Mvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:51:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443ADD7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:51:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984FC433C8;
        Thu, 30 Nov 2023 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701348699;
        bh=whpAvqeWMJ4SUO2YBq9Sm8+Qb2Or4IsFgJpf3mW6gzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLxnPcLOjf4scmTFShSA6euIg7GuHrDzeWs9XSAV/gQRuHQMYHCAk3eGIVoTFDBKk
         vC7kPrj4g9Xf2wKqn5XcOq0C2VsbOSih3feRRJRpJBUzcUP5rE3bLrz7UJZbZh1zbr
         wxZPFFQyBUJUNNGRPJ4JZb7h/jYW0BbQMtwgE9mN8ltkQiyIcVHJ9W/PAD9VvVHzCg
         cUKKn9drBbL7f9qsSVGczJdJlcQ2qNLNv2hoJ4AxGgFM7A3W2Ngysqh9aFVopOw1IC
         uCU/J6vhPLX3vz11SSbZpC0jBy6BNU+PHvrvDMQ3Sm9ut6Ogebw/AjTy4M34PrsGeZ
         jieJSsDJe1i5g==
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Thu, 30 Nov 2023 12:51:02 +0000
Message-Id: <20231130-radiator-cut-167bcaaa2cd6@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To:  <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References:  <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=vYNZ6BjbkHyaeAO19u7sN0ydYCv26psNewnOx/yeJ/c=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkZrSZ6DU2KyXmHeM9dlr9kGLV2o86lTQty9GxqM+WfT 9Tia/LvKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwER+rGT4w8X+tHn1SZVfVv0O 4Ysqb9a0u6qsnzdp+7SYDu6bsxe/P8Pwz4r51D8tN8ZQk919OjnHjwh2LVZZIHpvh0Z/YEjorX8 vWAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
> Huashan Pi board is an embedded development platform based on the
> CV1812H chip. Add minimal device tree files for this board.
> Currently, it can boot to a basic shell.
> 
> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
> 
> Link: https://en.sophgo.com/product/introduce/huashan.html
> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
> 
> [...]

Applied to riscv-dt-for-next, thanks! LMK if something looks not as
expected.

[1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
      https://git.kernel.org/conor/c/21a34e63afcc
[2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
      https://git.kernel.org/conor/c/06ea2a1968a9
[3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
      https://git.kernel.org/conor/c/d7b92027834e
[4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
      https://git.kernel.org/conor/c/5b5dce3951b2
[5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
      https://git.kernel.org/conor/c/dd791b45c866
[6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
      https://git.kernel.org/conor/c/681ec684a741
[7/7] riscv: dts: sophgo: add Huashan Pi board device tree
      https://git.kernel.org/conor/c/2c36b0cfb408

Thanks,
Conor.
