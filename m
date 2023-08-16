Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276AB77E844
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjHPSFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjHPSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD41BE6;
        Wed, 16 Aug 2023 11:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BF0631CE;
        Wed, 16 Aug 2023 18:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBFC433C7;
        Wed, 16 Aug 2023 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692209147;
        bh=G2w7GTgTG5XZ0to/vVqlZUtxf/FFA2ugU3EJGGioMmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifS3Ug1L/U16RiXNRWKS22WhjbLYccpjzxlgMvY1AYK2r3SBob6ei/W4yrXFKOp1z
         /XCWi6IrhynN11W0S4JKyNNdUdAWpkGkUdtOiFYbBzVyS2zxblhlRk8va7XC2Mzolu
         LXKP1T1hq7MQAaLYX/+2WzoiSwCpIeXUgpQBwBcSk4RFVqSMdDIowrYISVqJvs65Wy
         9gBDBU6FOLEPq0nuuIL4pYFP3s6g/UtSIWKmasE8wZxUFnKmQckOHbi9/sNvUmRJ38
         2YfONuE+DPsK+lO2U53Ka9c+VDjWdljZMTrv+cH4BLGMpSxVE0YboZNEkonqTfTCBp
         nAu/Ay4AQY4VQ==
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] riscv: Add BeagleV Ahead board support
Date:   Wed, 16 Aug 2023 19:05:30 +0100
Message-Id: <20230816-embark-share-db89a121eade@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
References: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5RE+12/CDvB6PvGnDNxjPAxeCAzbOZQ4H91Fuc3Fl7M=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCl3+Z/3ZadY7Ypd+vSsyHm5x0ZHdAqeplveVVYTTr8/u 3fONo64jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEwkegXDP+tjFroKtw1dvjCs PrR206olPKtjQ8/8LPbxeXfmU3jSveMM/zOvZGmWuP1Zl73m2fv/+vrPpwccvC/n07k7/HJuhsv Xl7wA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 11 Aug 2023 17:47:15 -0700, Drew Fustini wrote:
> The BeagleV Ahead single board computer [1] features the T-Head TH1520
> SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
> minimal device tree file to support booting to a basic shell [3].
> 
> Changes since v2:
> - Drop the MAINTAINERS patch as it is not important and I want this
>   patch series to make it into the next PR
> - Add Conor's R-b
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] dt-bindings: riscv: Add BeagleV Ahead board compatibles
      https://git.kernel.org/conor/c/d19c10d5b95a
[2/2] riscv: dts: thead: add BeagleV Ahead board device tree
      https://git.kernel.org/conor/c/31ceedee8aa4

Thanks,
Conor.
