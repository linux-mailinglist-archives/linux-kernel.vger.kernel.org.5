Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52FB78B4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjH1Py6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjH1Pyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174EA9;
        Mon, 28 Aug 2023 08:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA72D64C15;
        Mon, 28 Aug 2023 15:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE0C433C8;
        Mon, 28 Aug 2023 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693238083;
        bh=nc0qzwIFscesr+jhjizS1csWKtvqucQhTPIvVv0yCNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqo4dqTkheQ57bIjoRm4EDEsm60flIkLPRlkL4m3arCQtljzotXyyz64EZsdBxw+o
         AtC8W69czLydxAP4E75Di89rC+iDbI8hiuCOAkBIov3VP0gd5wTHfwjq4iM/iJeZml
         3axOMEXbMmet1KIaUryeZn8HNmgN3MS6yZcgSXJXyuCoKK4sdm7x7aaIpSNpiAerhK
         WsDWZ4Dg0hYw+ZMVxITjRMDtJetaJ+7PZN4jAJMz91pOxRnes9ljQj/Hi3Z6IMPFZq
         co6Ga/F4jk5emwuRBP9QWa3pu3vMPAaU7Iuj71SWZ4mIg+9iUr4NdLrlcdskuYw6FG
         dDQCZYRk2x9CA==
From:   Conor Dooley <conor@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Aurelien Jarno <aurelien@aurel32.net>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: Re: [PATCH] riscv: dts: starfive: fix NOR flash reserved-data partition size
Date:   Mon, 28 Aug 2023 16:54:01 +0100
Message-Id: <20230828-muskiness-bling-923afe7f74d1@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230826182702.2641743-1-aurelien@aurel32.net>
References: <20230826182702.2641743-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5TpTanjxdc+sswZKM9KD/TG320PDN1crxZS4F/3TNmI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClvDou8Xm/5zcKgds93wfKb7zNi9WU2mWbsOrH3wtn3/ FzXLxk+6ShlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEnBIZGT4Hc4T1nBOO9jM1 m/OUZ/K84jh9wfzHnTq+P2xDlCKSzjEyzGlq8Hjonmy55PyvLbFujQcnbcvn+Z+qE7OHo+/QFtk ZTAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Sat, 26 Aug 2023 20:27:02 +0200, Aurelien Jarno wrote:
> The Starfive VisionFive 2 has a 16MiB NOR flash, while the reserved-data
> partition is declared starting at address 0x600000 with a size of
> 0x1000000. This causes the kernel to output the following warning:
> 
> [   22.156589] mtd: partition "reserved-data" extends beyond the end of device "13010000.spi.0" -- size truncated to 0xa00000
> 
> It seems to be a confusion between the size of the partition and the end
> address. Fix that by specifying the right size.
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: fix NOR flash reserved-data partition size
      https://git.kernel.org/conor/c/602afaaa6ef9

(I may end up rebasing after -rc1, so this hash isn't stable)

Thanks,
Conor.
