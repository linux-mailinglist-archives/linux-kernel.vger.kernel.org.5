Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB3763C49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGZQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjGZQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273F2696;
        Wed, 26 Jul 2023 09:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9343D61B9D;
        Wed, 26 Jul 2023 16:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51C9C433C8;
        Wed, 26 Jul 2023 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690388505;
        bh=18NDTqqHohoTLr90XQLxpr4K5+AZj+2bL/ajmxJtfhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVBZg2ZbLdRVYWcCdqu3F5jx+QQU/aWzKtgtSWBdD+3DrwcbLPhCALBN0nkQANsFY
         hHJgx5qyPifqGPY3HrU9YntFvjNF7pJod4M1TCGVAOZn3FbNN7rrQm7pGauGcdWcSJ
         KSPMWbjSYgsZxLZLU2LWhkSt64nF8GIKOVypy+Nvi3t6/MxeU1licJ2W2ItROHfY28
         4vD+8KQ35/M5dZiWkUeGpK1/Hw/T8K84t8QDtjQA0N6etOkfiJRVMuJbsuom4Iak5U
         bmSY5+ucnbhUkTxdvqyKdzPDJ33bxyJ95qd3fdM/jLjdopjMuMNo/gY/8jS2vBaJZP
         wi8w7X8PJDxeA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add dma and tdm nodes for StarFive JH7110 SOC
Date:   Wed, 26 Jul 2023 17:21:39 +0100
Message-Id: <20230726-upriver-net-8490aa69df8a@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724065158.925-1-walker.chen@starfivetech.com>
References: <20230724065158.925-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=563; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pqWLKNJK9l4lLD6VJLXQH57mRv1gdUVqiglI+UMeLd4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkHPYR2TpIPWzt/4n6VP4c26iTMu2GprHn+fsDd69psM TefS9Y97ChlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEzl5kZHhXoz594zzeKteD T7tZ/VivnHlTpfMw7Zz0mR1sGp8+txxgZDhox6juePxGl2r/piLha33m55LKl9mv/mv3eHdjHzP 3cg4A
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

On Mon, 24 Jul 2023 14:51:56 +0800, Walker Chen wrote:
> These patches add dma and tdm nodes for the StarFive JH7110 SoC, they
> are based on linux-next. I have tested them on the VisionFive2 board.
> Thanks.
> 
> Best regards,
> Walker
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: jh7110: add dma controller node
      https://git.kernel.org/conor/c/ac73c09716c3
[2/2] riscv: dts: starfive: jh7110: add the node and pins configuration for tdm
      https://git.kernel.org/conor/c/e7c304c0346d

Thanks,
Conor.
