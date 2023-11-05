Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F707E1673
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKEUmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:42:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD78B8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:42:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-543923af573so6526462a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699216934; x=1699821734; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pk9DoOLWuMsYDueLKRHC6CMfn/3wE5uzyWWR9D0at2w=;
        b=az3kNPUuScCEUCqWmNq4k5kTfYnQGXREZYJcTjJh3lTsaNH7c7iBu+WzechSV4h5zS
         VWOsCDUrXdMNFL7dYoaG9JMIlBrmf40gtZkl1EyaVsUxp5DrLLXJYU5tYc6LBLBP11pC
         ePnm9TdRXFu+F2AVSvX3XhYNq7OTqL/eQ+R3oN7AORdSn5x52N5aP2X8nwo02O07BaNw
         ybUFYTzPMmyj58FQt5IRYx+dWGUv7xeAlfnc2gWboz/Qso4ARrfeGhrvpwa5uwn8d8Mf
         BVI/6PFoojU2V/WFQ1LoYOJLTp/bWCkFo2YZ53CJBMd4Ew+X3EUzlLv1TfBF2JVu6K7j
         M46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699216934; x=1699821734;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pk9DoOLWuMsYDueLKRHC6CMfn/3wE5uzyWWR9D0at2w=;
        b=kZPvHlCYLv4azpwiKZtPt4ao7WMTEqxemwkDEgZWCybcHpJ+QgYOPPM6Fud8AQ9/Kx
         u24/fpVo7nQVxoYsHeOWYqPulvNffPwt2xYogqoL4DvfijvdHeIGJGJsVF/FnQrYh3uZ
         LcMuChTvno5fr7QVVfwjsYh4K1giO3vTvPz706IPsf06qvBaJGpAPtiAqpKQuUxM+Zba
         N4/eQkX1M7AXxnSfUoM8a2MYz3H4V+4gOhGoSAAPWjmnJabEW33ozpGftCyf3k/o3caE
         IvHECAgZZSMNKMjr3XWEPNkeftwnW21/O7P3N4H9D1Cg0jcObVpACn6wrTHVq7dQbXNo
         RSGw==
X-Gm-Message-State: AOJu0Yy3r2ZcI809ktumk8BhCrhrwngtQkuyIKO6MZxI6cpkoL5hy0Cb
        d4pH/wPEowNeOn34tvFzvb3LGRzZfSwaihCaoONZxppHD88=
X-Google-Smtp-Source: AGHT+IHWG0vSVlJr/67yeCoZoSDenf+ivJC7j5Em6h+VzbhYQh3Cy6hHcl5lLsoaGaQtVr1tC9HN8N48Gka+kTovW98=
X-Received: by 2002:a17:907:98a:b0:9ae:69b8:322b with SMTP id
 bf10-20020a170907098a00b009ae69b8322bmr11390389ejc.60.1699216933576; Sun, 05
 Nov 2023 12:42:13 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 5 Nov 2023 14:42:02 -0600
Message-ID: <CABb+yY2JHKRv3+cjvnLONK+BDd=j7SbPa_oEecqQ7gtw19R5TA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 11d3f72613957cba0783938a1ceddffe7dbbf5a1:

  Merge tag 'usb-6.6-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2023-10-15
09:16:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.7

for you to fetch changes up to 96cb7a4e296da9aaae0ad61394fdb2828e0a21b5:

  dt-bindings: mailbox: qcom-ipcc: document the SM8650 Inter-Processor
Communication Controller (2023-11-04 13:46:53 -0500)

----------------------------------------------------------------
Moving repo
  From
   https://git.linaro.org/landing-teams/working/fujitsu/integration.git
  To
   git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git

imx: add support for TX Doorbell v2
mtk: implement runtime PM
zynqmp: add destination mailbox compatible
qcom: add another clock provider for IPQ
      add SM8650 compatible
misc: sse preferred device_get_match_data()

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend

Kathiravan Thirumoorthy (1):
      dt-bindings: mailbox: qcom: add one more clock provider for IPQ mailbox

Neil Armstrong (1):
      dt-bindings: mailbox: qcom-ipcc: document the SM8650
Inter-Processor Communication Controller

Peng Fan (2):
      dt-bindings: mailbox: fsl,mu: add new tx doorbell channel
      mailbox: imx: support channel type tx doorbell v2

Rob Herring (1):
      mailbox: Use device_get_match_data()

Tanmay Shah (1):
      dt-bindings: zynqmp: add destination mailbox compatible

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  5 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  2 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  1 +
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  |  6 ++
 drivers/mailbox/bcm-pdc-mailbox.c                  | 10 +--
 drivers/mailbox/imx-mailbox.c                      | 32 ++++++++-
 drivers/mailbox/mailbox-sti.c                      |  8 +--
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 80 ++++++++++++++++++----
 drivers/mailbox/ti-msgmgr.c                        | 12 +---
 9 files changed, 117 insertions(+), 39 deletions(-)
