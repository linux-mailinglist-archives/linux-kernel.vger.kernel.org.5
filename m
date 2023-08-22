Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D3783DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHVK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjHVK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:27:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5ECD1;
        Tue, 22 Aug 2023 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692700063;
  x=1724236063;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p50imcCFa/rY09pHfsfLn8Pcg/uVZPGOFH2OvBDpFZk=;
  b=IMABWM7Wq9Bi+cKR0lPAmx5KmY5shDxCTZuF1eqMoymg9luOJQjdSIvo
   006cvpKMp38Y3ep6TTgW0ZqpSUB0vL5IHES5ScC7Kr6sUA7xo3QP+bv0m
   eVPcrGostkmEwycbK8Di8NYh4H+KVPncYF0c/2U4fgR/NdK2e1Bo/XtyK
   RA7uexh5K2aWb7dxoQ7qjDiqcZ6XZX75jWcVpbYAHb+p6O0pq4LKVbi9q
   rV1DjCmdq9SCiswbk4++Hu58/b/CEfXi2gx/Tsk01m99K2va/L8HoDvO3
   fwei0lRjikhFXdxJ4qBxnD34nfU/vo2gX6iYB7BXPuVPDvjZRWj25ChwI
   w==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] Add a driver for Epson RX8111 RTC
Date:   Tue, 22 Aug 2023 12:25:31 +0200
Message-ID: <cover.1692699931.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
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

In this patch series we add a basic driver for Epson RX8111 RTC with support for
only reading/writing the time and the `ioctl`s `RTC_VL_READ` and `RTC_VL_CLR`.

Datasheet: https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en

Changes in v2:
* Move dt-bindings to `trivial-rtc.yaml`.

Link to v1: https://lore.kernel.org/lkml/cover.1691158774.git.waqar.hameed@axis.com/

I decided to send v2 now since it has been a while, and I didn't get any
comments for `rtc-rx8111.c` in v1.

Waqar Hameed (2):
  dt-bindings: rtc: Add Epson RX8111
  rtc: Add driver for Epson RX8111

 .../devicetree/bindings/rtc/trivial-rtc.yaml  |   1 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rx8111.c                      | 411 ++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx8111.c


base-commit: ec351c8f2e6211054e51e661589cddd1fe856425
-- 
2.30.2

