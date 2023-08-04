Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6E7702DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjHDOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjHDOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:22:12 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FCCC;
        Fri,  4 Aug 2023 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691158930;
  x=1722694930;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=F4ZCqB7agCNPa83F34ocsYQJWrVsDIK4bk/6GPr6EEU=;
  b=ZjqGUe/SXUr8ZyyNTxEUvMMz4vfx47/xtqw+j/jeTTcRPp4wIjWyu123
   v+sUObBONPGUoRaxbfpZMTE/CvU+2pMdUE9Z966iNqRV/x95oBprjWaqu
   OGUuHAqCEELVAXs20BzPNNERsb9DQX2XMLTwJ7pvzRJ6aVvCkv7THrAnx
   8MrqHx/QjsJTInKn5l2lqeqJQqStL2zoqFTUr/fDTuGsOAt6RcjhU/heO
   YkXr0hk6rwVwHvOEK1ZtMp7ZAUkxlmOpemuHdk1YqdV/TNgFLMlkwkuV2
   h8zqq9JFTdtFxuWbstf3KJDwYP7uybSErbBylVbZdrb09rWBEP37xuo03
   Q==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] Add a driver for Epson RX8111 RTC
Date:   Fri, 4 Aug 2023 16:19:34 +0200
Message-ID: <cover.1691158774.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series we add a basic driver for Epson RX8111 RTC with
support for only reading/writing the time and the `ioctl`s `RTC_VL_READ`
and `RTC_VL_CLR`.

Datasheet: https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en

Waqar Hameed (2):
  dt-bindings: rtc: Add Epson RX8111
  rtc: Add driver for Epson RX8111

 .../devicetree/bindings/rtc/epson,rx8111.yaml |  41 ++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rx8111.c                      | 411 ++++++++++++++++++
 4 files changed, 463 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8111.yaml
 create mode 100644 drivers/rtc/rtc-rx8111.c


base-commit: ec351c8f2e6211054e51e661589cddd1fe856425
-- 
2.30.2

