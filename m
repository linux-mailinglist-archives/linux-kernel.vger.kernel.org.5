Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E862763C21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjGZQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjGZQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9F272B;
        Wed, 26 Jul 2023 09:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4184861BB0;
        Wed, 26 Jul 2023 16:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF90C433C7;
        Wed, 26 Jul 2023 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690388126;
        bh=PjS7Z4XLVUrWS49n3z6ZKWBMg/vyivtQsAyTNpykwlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wo96XIOd233Ym49/rnGPn2nsiHMtnSSckxg00swNYkF464YXnWNH52Brk7gzR8a2M
         xXYR3hdZxh8VbM0jSRCQjsXFZmtcw+4hgL72Y3zEcbbMxgBMllibtqfNqzpiAzjHlA
         vTPOFJ9Y+ldpElGeT8RSwp832W4E4yr8DJe+lCJMTCDdKbkmBs8vDVSw0a/GCj0BH7
         Q8cRyCNo/OQ6fif/Ol0Zf6DO4ZTmUUKsPFxSn6tYK7KrkzUgxM+XwIHpz2FmGsxZh0
         Xekl4ta5ukqIc6eolJU16KRL4ZHrpXgaF2eMwyM987uzBi6lo/GJcVFy/DDT9GxZ44
         fRPDa0SOMtISg==
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [dt-for-next v1 0/2] Add USB PHY and USB dts node for JH7110
Date:   Wed, 26 Jul 2023 17:15:19 +0100
Message-Id: <20230726-disjoin-valiant-9eb92de6a240@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726100609.72550-1-minda.chen@starfivetech.com>
References: <20230726100609.72550-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=602; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FYw9ShWdfK+KWcg2OyowqX9vfHSugqdrc2UoYjB9w7k=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkH3aa+ZnugatKl2Dlz1baaCT+emRxSLNz6vEX67+rYD +olxo8PdJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAigj0M/8ym5bMzm27T/1yg mr9t5/Ura1bZ6fQ3Cj21rtLJ7lz8tZrhn0q9Uv9FlQtzPALCGPSuxTJ/LOgMiv2Y33Dv4a/jq3a J8wIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 26 Jul 2023 03:06:07 -0700, Minda Chen wrote:
> Add USB and USB/PCIe PHY dts node for StarFive JH7110. The PHY
> driver is in linux-phy-next tree.
> 
> Minda Chen (2):
>   riscv: dts: starfive: Add USB and PCIe PHY nodes for JH7110
>   riscv: dts: starfive: Add USB dts node for JH7110
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: Add USB and PCIe PHY nodes for JH7110
      https://git.kernel.org/conor/c/c2a10081c033
[2/2] riscv: dts: starfive: Add USB dts node for JH7110
      https://git.kernel.org/conor/c/e126aa3abc4e

Thanks,
Conor.
