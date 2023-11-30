Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2457FF82C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbjK3RZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345639AbjK3RZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6B10E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:25:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B656AC433C8;
        Thu, 30 Nov 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365125;
        bh=lrJZDSmPE6sJggjsC2wQcjtU9RHwzSAEI63jRK7gA5E=;
        h=From:To:Cc:Subject:Date:From;
        b=hXqezqqAWgqa+SAGfd+k3U5sSfEuSFTpO7wBs/cDK+vzPy8EegEV4rLyIOn/+QrTm
         hhuw9Fz4Zya+VsmbwtHK0i6U6r5UDCiP+UJhmHPvqUb6KfjRWw7Zel9oprNYvQG+JA
         C84REje0b6WrPPHI+DiN5XKPNijVaSr1Mojz7adROq4Y6zdJSgG1BX3Hab3AfNso+6
         BHvbPbvZ0kZRzrwiiX0OGNljJOWk7nyRBkyUlN3nLMJC7BCQrfa6UkaRhziekZM3n4
         4p6dzY36iSIj7W6FCyUhz6UZoyy1OPKwQ/fphvzytDOjPULIVZWKIj2tRfDGZJJgAB
         t8bEeXbbunHwA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8knX-0003Gt-0Y;
        Thu, 30 Nov 2023 18:25:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] dt-bindings: mfd: fix up PMIC examples
Date:   Thu, 30 Nov 2023 18:25:43 +0100
Message-ID: <20231130172547.12555-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series addresses the mfd ones.

[ The PM8008 actually sits on an i2c bus but it is related to the other
  Qualcomm SPMI PMICs. ]

Johan


Johan Hovold (4):
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix example regulator
    node
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
  dt-bindings: mfd: pm8008: fix example node names

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 133 +++++++++---------
 .../devicetree/bindings/mfd/qcom,pm8008.yaml  |   5 +-
 2 files changed, 71 insertions(+), 67 deletions(-)

-- 
2.41.0

