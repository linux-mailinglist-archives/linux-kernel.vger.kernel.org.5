Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CFE8062C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbjLEXMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjLEXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:11:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E756120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VCL1DzminhNT4bz7Zg1RCj1idSj2Oed0iYRadOstj/U=; b=MZwG1wmyyVfshMXHma183QSrEM
        XV+oQm0k/CzXyDa5qqMKbY96YNk26P/gF5gPDJ0T3FEbNoIA0XO4/nTCBILpy7TY+ztSP6GSmlIpT
        JKyFeZ9vL16r94MCWgxXa26ihLkPAyLO3p9QiioQLLWUmHWSHVhH00/CUU1IAcRQ4MnxpmaXrBdZL
        S+VqagFYNMXxvjBC9H1Va3w32U0yDTqjMHrFs1oxlp+WNvkk8tmlADiWAeznHNNI86tw7EWlGLejj
        XGrF9Yu/EW50Tqrrz4bX5JB0sUJtug2QALFqqjGYpbLJra8QUi5FCxc5/bKestUWrHOaf7lwWdREU
        A1erqkJw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAeaC-008agr-34;
        Tue, 05 Dec 2023 23:12:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] extcon: qcom-spmi-misc: don't use kernel-doc marker for comment
Date:   Tue,  5 Dec 2023 15:12:04 -0800
Message-ID: <20231205231204.1130-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use "/**" for non-kernel-doc comments. This prevents a warning
from scripts/kernel-doc:

warning: expecting prototype for extcon(). Prototype was for USB_ID_DEBOUNCE_MS() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-qcom-spmi-misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
--- a/drivers/extcon/extcon-qcom-spmi-misc.c
+++ b/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * extcon-qcom-spmi-misc.c - Qualcomm USB extcon driver to support USB ID
  *			and VBUS detection based on extcon-usb-gpio.c.
  *
