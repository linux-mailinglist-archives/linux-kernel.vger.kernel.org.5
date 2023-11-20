Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA77F184C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjKTQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKTQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:16:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B6CED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:16:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F25FC433CB;
        Mon, 20 Nov 2023 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700496979;
        bh=a5fyGCT8iWPqPVsgRUucqaCokV/kZiJAVbPFezCBmLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+wXiaco7qjT78OGEVCzAARrd3lrRixC1UX4o6C9RwLaI8TIKylD1a/6dUKSMyQS2
         6M0jAtDmFohyGdrg7jWvsNVdLKeShf5OD4s4wAV8s+pOZGe8poHcDLmeGUa8H+Q76C
         San5bP+TQQWBPoMGH5N/CyhQHAdWD6KEshnJaTGq+CtZHmk7RR5Nj/9U0yVedavbvK
         WVx9EjjJkVqBSqJBtMYZw/gEtKAzbVls23IzVN2uXgZ1zZS3PrMaMpvanfWSgyzgo8
         e19B3T5folkdAIOTqcqb+pnFiLnZMRtm1AOUdYuXSt5mArW4WXLukFfF/HB1N1FrD6
         hOxOKIEBozQCg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r56wm-0001vm-1h;
        Mon, 20 Nov 2023 17:16:28 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] dt-bindings: usb: qcom,dwc3: fix example wakeup interrupt types
Date:   Mon, 20 Nov 2023 17:16:05 +0100
Message-ID: <20231120161607.7405-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120161607.7405-1-johan+linaro@kernel.org>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
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

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Fixes: 3828026c9ec8 ("dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index e889158ca205..915c8205623b 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -521,8 +521,8 @@ examples:
 
             interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
+                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
             interrupt-names = "hs_phy_irq", "ss_phy_irq",
                           "dm_hs_phy_irq", "dp_hs_phy_irq";
 
-- 
2.41.0

