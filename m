Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE67BBA24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJFOX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:23:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07781A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:23:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CDC433C7;
        Fri,  6 Oct 2023 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696602203;
        bh=XBqQ4iHvesdBU73kOzoPty/h5/FDyNYsclRZqIaRyyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKkOpWXzz6eDbdbOCxP0fPboHebR5GKzL84RUoH28JCCfL9ANd85mDFRXZIKqrvi1
         gGbyRnzd8t42VE1W/iTQw0c1u7fH/cq/hOvAZGACduPfPfD7g3e+pb/zVPTIZih9Kf
         PqDzgjUvnDR0p3fvyCY5yfLDei7G3EqDpbYwx2bA3Z7KhtPVoRJ92ruLhy6ruStkKo
         O8NkM9S+3cDnilgrqo0PnQOHFu/svL2zOreAQG5Z7nbOuLZMO7FSwOBqB/RkrE6bqC
         N4pZFHXAwNl4s4+BUsuYvv5t2xnurWBJtsQxrhcbZrLLXLOQ3Tb5hCf96Ea/+hvrU4
         t7ftKtUkOvnVQ==
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 0/5] Add Milk-V Duo board support
Date:   Fri,  6 Oct 2023 15:21:44 +0100
Message-Id: <20231006-petal-conjoined-4c3afb0c5a0f@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006121449.721-1-jszhang@kernel.org>
References: <20231006121449.721-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6ahMtWbaNULcWlwY37kB+Ja+SZGh9Mj1DK1OOUAhQp0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkK4t9+zVTpO9B56JryVolrMkb2kbsXruS2/5t/60VMv PPPsJsLOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRQ/KMDNelk6f+uMzfmOZ7 quzQZb9nxf817l4y37yXt8Fwf3xAyRxGhg/qhdeZDSz3au97537jDXOEMM9y8Rs5cVd0qrQ85N/ c5QUA
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

On Fri, 06 Oct 2023 20:14:44 +0800, Jisheng Zhang wrote:
> Milk-V Duo[1] board is an embedded development platform based on the
> CV1800B[2] chip. Add minimal device tree files for the development board.
> Currently, now it's supported to boot to a basic shell.
> 
> NOTE: this series is based on the SG2042 upstream series[3] for the vendor
> prefix and ARCH_SOPHGO option.
> 
> [...]

These look grand to me, so I have applied them on a temp. basis to a
"sophgo" branch. I'll merge it in for real to the riscv-dt-for-next if
my changes to the prereq series for the sg2042 are acceptable to their
authors.

[1/5] dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
      https://git.kernel.org/conor/c/101276d77e84
[2/5] dt-bindings: timer: Add SOPHGO CV1800B clint
      https://git.kernel.org/conor/c/a3a24243b83b
[3/5] dt-bindings: riscv: Add Milk-V Duo board compatibles
      https://git.kernel.org/conor/c/533874200f8c
[4/5] riscv: dts: sophgo: add initial CV1800B SoC device tree
      https://git.kernel.org/conor/c/4e31e0e61845
[5/5] riscv: dts: sophgo: add Milk-V Duo board device tree
      https://git.kernel.org/conor/c/0edd1de88d35

Thanks,
Conor.
