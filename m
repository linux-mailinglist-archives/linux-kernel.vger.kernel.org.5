Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A57FF88C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbjK3Rkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjK3Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F0C10DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:40:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA3DC433C9;
        Thu, 30 Nov 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366047;
        bh=zWMt5IhznV4y9Tk0tbO7xpSyPtkYWHHVPfOad0SC0aE=;
        h=From:To:Cc:Subject:Date:From;
        b=cusBl+xAfmeQGQ8xZrO/Nsx3tct0XtjelzpH3X+fk3W4r9Zh8/JpXLSd+IR2Vecmh
         +oGvLbOzKDDhwn4X+82NNE2Ai/aKgcEmBdMNNrpd+rXkQuCMOo+badO2YRh0G0rQwr
         MdJ9N2+C6Rc1Pk2WHFdEyL4gi4w8/ZP5s0oUtMMO4cBVwN4CuedvrsoTXsPI3rsRlQ
         K+sGgXQPNkZBtDwMk0WtUo8oAgEjGQp+53qHG5JSr5jnbcMoiED5OM61iaRVdEPQP2
         FFZ77xkUIceFMw/xpQNdWgwtg14oLuEYowInWoeCtM9HKmCtis5SZZCadUlKRS8Bit
         FL2SGbgKSGHvg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8l2P-0003Pu-01;
        Thu, 30 Nov 2023 18:41:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] dt-bindings: thermal: qcom-spmi-adc-tm5/hc: fix up examples
Date:   Thu, 30 Nov 2023 18:41:12 +0100
Message-ID: <20231130174114.13122-1-johan+linaro@kernel.org>
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

This series addresses the thermal ones.

Johan


Johan Hovold (2):
  dt-bindings: thermal: qcom-spmi-adc-tm5/hc: fix example node names
  dt-bindings: thermal: qcom-spmi-adc-tm5/hc: clean up examples

 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml    |  8 +++++---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml      | 16 ++++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.41.0

