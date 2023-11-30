Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A937FF7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbjK3RQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjK3RQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62010D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C69C433CA;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=UUFQFRvb1jh1J5SJLOCbZilXMNLl0hLuc7JaAaDPPtc=;
        h=From:To:Cc:Subject:Date:From;
        b=BtrU19xYVX3pBdckOdxDyK8GaLlTk1wYxcTqfXvUhjW9VzRBZtRS2tfNAdgYFsMLC
         PYCwKyLTIdnc8Op8EmKrvFr9qvgoHJE/V2rO0eM84kpIA33vagLfzAoetHuPL6SPV1
         SYYL43iE5P3R/ssgzzN8B1TRWMU4qjanMS+xh2RYVIXDeQrrvGkYkKqAlZuCG4AX8k
         uWjPbG3bAoVk3k7CAnOckVheVck8psHKCn8x1r56iNI5uJce7EFMY9Ni+StnXeJFOv
         MO7OvFK2ydYj0kawDp6WbEDesPEe4TmTbmdOE8RljXlX4uZt+518W2o4K/rv+1/z0O
         pHMtqQSgU208w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfF-0003Ce-1w;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Date:   Thu, 30 Nov 2023 18:16:22 +0100
Message-ID: <20231130171628.12257-1-johan+linaro@kernel.org>
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

This series addresses the iio/adc ones.

Johan


Johan Hovold (6):
  dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
  dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
  dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
  dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
  dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
  dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples

 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml    | 10 ++++++----
 .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml   |  4 ++--
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml    |  9 +++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.41.0

