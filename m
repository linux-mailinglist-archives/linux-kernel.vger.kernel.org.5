Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4C7806FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358511AbjHRIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358538AbjHRIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:16:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF342D7E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:16:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3efebcc24so450302b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692346596; x=1692951396;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lbM1VAOmIuDwNg7wfQxXA0nJWjB0nVU1MmLI6jlwhto=;
        b=aX3GdRrN5u7986hkYft5jqQU/slDJdT/0j/IvJALAV9ap/XB6ty/U4nbGhNRK4V6NR
         YU9oGKYVRV52pW422iHWmKyq/FLd8GyEgzHt7ZmzUk//yIGg4WjkZVO2UXwatwed1eIw
         j3lWhYw3Mh+kVuQgRtwIoqb1XRFuBa+rOUgyUbXKwNoliK0V/mert/Tpekb6SWz62Fgd
         pjeQ1+zN0nsyM5+J8UbewxhHbtDDVwm44HF31FpK3qInoHkSkHCRzAXDNM1riqhsrs4E
         A1dxFwo8R7wx9wHj8nlhzU47nDJAlULDEVluwGgnHIvvfjoF7xzThu+IED+jYsztcmkz
         rNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692346596; x=1692951396;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbM1VAOmIuDwNg7wfQxXA0nJWjB0nVU1MmLI6jlwhto=;
        b=SK0wEMAfbYA2EDtYWd2fRQ1hcFM8/FVnLKjNVCD+6cFNMD1a7diiZBD4iMD4c0E2Nt
         Mo0s6lyRT8Q2E9Vut9JuJfq1bdE5A0S6kWtn+qnBV4MAzTBmFSQLH7K2ODmnlmmllMTU
         kocO9BmZWPkGeSRgrp17UY9iSee01wOI4lTuhadjaCraMp9STZm59DAZNn28lJrADfmM
         lat9uoyd+3Wedz5aIRCq/iNrJSABLOtYudCyMaGQ8cfZv6pSXWkoPHfA5PV+C5O5rATC
         ou1jphJQDB23TT7PLLnkHWx9vTtsG3gvpdXZQWIyKIMvcLK0P5p+URROqc5NnQ7w+SNK
         tOCA==
X-Gm-Message-State: AOJu0YzLmo3rZLUl6DYH+O526j7NAXxF2p65Wa6ZqzSCKPw8WnaU6hlw
        J1mOTj+0mIJGlbul5lXSRdWSBkQka+IPCns3GVyoSBPqbvfwzD2z/3o=
X-Google-Smtp-Source: AGHT+IF1apv76gbFlJez+VjwnL+TeCwg2GIpqX0la41LXsM1MAZ9V7pc4isaw9XO0kdt5vFUXBPptO4eji4e3eotnFE=
X-Received: by 2002:a05:6358:9318:b0:13a:a85b:cdc2 with SMTP id
 x24-20020a056358931800b0013aa85bcdc2mr2071609rwa.15.1692346596390; Fri, 18
 Aug 2023 01:16:36 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Aug 2023 10:16:25 +0200
Message-ID: <CACRpkdYq=Ep4ji=Vy9k8X8cXE9_9gTS5T6eK_uP1M58v21sWbQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ninad Naik <quic_ninanaik@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some late fixes for v6.5 it's just two patches related
to a Qualcomm SoC but I think they put it into significant
devices so let's get the fixes out there.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.5-3

for you to fetch changes up to 9757300d2750ef76f139aa6f5f7eadd61a0de0d3:

  pinctrl: qcom: Add intr_target_width field to support increased
number of interrupt targets (2023-08-10 10:48:15 +0200)

----------------------------------------------------------------
Some pin control fixes for v6.5, fixes two issues with the
Qualcomm SA8775P platform:

- Some minor device tree binding flunky that is nice to iron
  out but more importantly:

- Support the increased interrupt targets mask from 3 to 4
  bits, making interrupts with higher (hardware) numbers
  work.

----------------------------------------------------------------
Ninad Naik (1):
      pinctrl: qcom: Add intr_target_width field to support increased
number of interrupt targets

Shazad Hussain (1):
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio function constant

 Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                               | 9 ++++++---
 drivers/pinctrl/qcom/pinctrl-msm.h                               | 2 ++
 drivers/pinctrl/qcom/pinctrl-sa8775p.c                           | 1 +
 4 files changed, 10 insertions(+), 4 deletions(-)
