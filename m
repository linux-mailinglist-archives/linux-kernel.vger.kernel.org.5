Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DB754A58
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGORFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGORFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E7B5;
        Sat, 15 Jul 2023 10:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B761760BD4;
        Sat, 15 Jul 2023 17:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0321C433C8;
        Sat, 15 Jul 2023 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689440736;
        bh=ncuBs4kxzk2VlZm7kfJfgZlSPKeTybZkTtdYydKCK18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9TOh4ZDaNP4erpFLfnmoiw+h2TmkSY9NJv0apQm7CqXF3xU7UZA22oYIy3CmWXDL
         S21PAMmPfcahzR3TC+SMWaYnKmDOIo4smNCrXt7gjGhtg86ICAxGeLV31ZUNCgTqZo
         jcQoa016QrvOmJIxM0rCJbcdMTyDqTwvTuBTnlVWG69hTO22gQbWUtqM97oifq+5pE
         1OM/nEiN/Nen1hIEM9lM3vNcoq4fuwL4uqc+acilKzQZ60iocC+Ro/lD6cewlLWdvi
         eTaH9UxQLTgWebkdKCwnsKufKpIPtYIpVK+kTCgbKftUxiSk+TGmXAMBikgX7+G4AN
         fiKJQAUS7Lsmw==
Date:   Sat, 15 Jul 2023 10:09:03 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v7 00/22] Restructure RPM SMD ICC
Message-ID: <yytpipulsnqnrfgn6tftwje7cpghburt3aau54x5hwecpwus4t@ayqunqa4pm4a>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
 <de875511-7356-32cd-514a-ac532d75a8fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de875511-7356-32cd-514a-ac532d75a8fd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:37:57PM +0300, Georgi Djakov wrote:
> On 19.06.23 16:04, Konrad Dybcio wrote:
> > This series reshuffles things around, moving the management of SMD RPM
> > bus clocks to the interconnect framework where they belong. This helps
> > us solve a couple of issues:
> > 
[..]
> 
> Thank you, Konrad!
> 
> Acked-by: Georgi Djakov <djakov@kernel.org>

Thank you, Georgi.

I've applied the patches to a branch based on v6.5-rc1, merged that into
the qcom-tree and pushed the branch.

Regards,
Bjorn

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org

for you to fetch changes up to 17fc623e0f728c35b82a0e79cd4f3b8aab495663:

  interconnect: qcom: icc-rpm: Fix bandwidth calculations (2023-07-15 09:54:45 -0700)

----------------------------------------------------------------
Konrad Dybcio (21):
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

 drivers/clk/qcom/clk-smd-rpm.c                  | 314 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/interconnect/qcom/Makefile              |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c      |  77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.c             | 220 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------------------
 drivers/interconnect/qcom/icc-rpm.h             |  56 +++++++++++++++++++++++++++++++++++++++++++++-----------
 drivers/interconnect/qcom/msm8916.c             |   5 +++--
 drivers/interconnect/qcom/msm8939.c             |   6 ++++--
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |  10 +++++++---
 drivers/interconnect/qcom/qcm2290.c             |   8 ++++++--
 drivers/interconnect/qcom/qcs404.c              |   5 +++--
 drivers/interconnect/qcom/sdm660.c              |   8 +++++---
 drivers/interconnect/qcom/smd-rpm.c             |  23 ++++++++++++++++++++++-
 drivers/interconnect/qcom/smd-rpm.h             |  15 ---------------
 drivers/soc/qcom/smd-rpm.c                      |  17 +----------------
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +++++++++++++
 include/linux/soc/qcom/smd-rpm.h                |  20 ++++++++++++++++++--
 17 files changed, 456 insertions(+), 345 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-rpm-clocks.c
 delete mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,rpm-icc.h
