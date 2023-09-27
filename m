Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15917B0AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjI0Qy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Qy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:54:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CBEDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:54:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9649EC433C7;
        Wed, 27 Sep 2023 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695833664;
        bh=PbWliIL+YkhZx/7SImI4k4hkB5SastFowOtRO9Imz4k=;
        h=From:To:Cc:Subject:Date:From;
        b=T563OrhTCvY+vjXfbCikSv8n5+yLYxvGgPRibY122ZnVcMDfS0NfEwpkXZIuN2nJl
         i1xO/bzNLvdXZAFzvRLj8VJCxNYxg596/v8jBCmPK49XwEPTqT8axX9q4sOoI7+5E5
         kmjov4C/ihxcWw1ZUrTYjGUy2zbhnXBTwAroo00pXxzoen/Rn6QNHA5an/aCNCEyS0
         DBvSAxEIuXjqwzF54vFm+nrhwod7Z9sp/1n5lLgFRRHnV0fJ76dhMuv2O4UJpk+eUp
         eWR7+NsfInLgS3L8Z5zgLZ/MIzkZejSaXv7poJ8so6lad4vL5eFHjgkl5RCjkqytxl
         mySyjpQeih4wQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] usb: dwc3: add driver for T-HEAD TH1520 SoC
Date:   Thu, 28 Sep 2023 00:42:20 +0800
Message-Id: <20230927164222.3505-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the usb driver support for T-HEAD TH1520 SoC.

Since the clk part isn't mainlined, so SoC dts(i) changes are not
included in this series. However, it can be tested by using fixed-clock.

Jisheng Zhang (2):
  dt-bindings: usb: Add T-HEAD TH1520 USB controller
  usb: dwc3: add T-HEAD TH1520 usb driver

 .../bindings/usb/thead,th1520-usb.yaml        |  73 +++++++++++
 MAINTAINERS                                   |   1 +
 drivers/usb/dwc3/Kconfig                      |   9 ++
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-thead.c                 | 119 ++++++++++++++++++
 5 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-thead.c

-- 
2.40.1

