Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D8806DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378162AbjLFLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378049AbjLFLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86210A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:17:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5383C433C8;
        Wed,  6 Dec 2023 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701861462;
        bh=7eln7pxVEETenxeXywIjzoP1QmPs7ZhmHa7giWC3B/U=;
        h=From:To:Cc:Subject:Date:From;
        b=LY0HV7/sC/KjLK8Cnp653pOgtidr/XJBquqaMW8yCQw0Dyz/Yyqgw9Dunh0JLHNFp
         IWfE9LkVpBMOZJ+ub4e6F08Mqm+ARrb5D72WIuSlLKdh2zNUfNPZel7hGIBew2NXQg
         40ZN40UOVnPwxlsmabo9ci3qz9o1vcczK7uIRDtFWO8097ivzPrQw5s1KXH7u+ot4P
         uTKSEX8yfOIrSm43HBXQEQCSpUObj4b2gt/OSdxog7UwJtMv2pj2hokkBQHFuw7FAi
         aFCHAsX31d1mzCAGyvFg0i8J27bX4MJ6vXwOeaU6hNaqbSEA/ydcJ4iJ/HWYuT1k+q
         vquv1ZFZksoUQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rApvA-0001wC-14;
        Wed, 06 Dec 2023 12:18:28 +0100
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
Subject: [PATCH v3 0/4] dt-bindings: mfd: fix up PMIC examples
Date:   Wed,  6 Dec 2023 12:17:50 +0100
Message-ID: <20231206111754.7410-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series addresses the mfd ones along with some related issues.

[ The PM8008 actually sits on an i2c bus but it is related to the other
  Qualcomm SPMI PMICs. ]

Johan


Changes in v3
 - rebase pm8008 update on linux-next to avoid a trivial conflict due to
   a local change in my tree

Changes in v2
 - drop the incorrect #address-cells and #size-cells properties also
   from the hi6421 regulator binding (Rob)
 - drop Fixes tag from pm8008 cleanup


Johan Hovold (4):
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix regulator binding
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
  dt-bindings: mfd: pm8008: clean up example node names

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 140 +++++++++---------
 .../devicetree/bindings/mfd/qcom,pm8008.yaml  |   6 +-
 2 files changed, 72 insertions(+), 74 deletions(-)

-- 
2.41.0

