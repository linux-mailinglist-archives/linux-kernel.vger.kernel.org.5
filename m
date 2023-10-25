Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDD7D7054
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjJYO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbjJYO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:59:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2AB0;
        Wed, 25 Oct 2023 07:59:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA0C433C7;
        Wed, 25 Oct 2023 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698245971;
        bh=kIFujZGjzcp/zjA/bisHTWZeLa/8sA2vWQ45CuhLzTU=;
        h=From:To:Cc:Subject:Date:From;
        b=RNbtBOKQLV2rkZwKLZQEcOjPEpIFnPmJIUtIRjCbaCGeJYv6tQXemjcRB8hyjoj6P
         JNU51FU2VlsmblfNYKG3tSXocRlCTHPfHQCnEXUugU43tVuJDb92ZkDZVSvIECfEVc
         TrxQXQHWD2OPw6JZtCZzokBFoCiwR9qTh6M/MRgfTgNhwWlbLtUJ3jfX6yRaQSIoul
         ms3mACLYgiFXWrUhd8/Lb0sQ6nqL3Av+rKJl8zTJW7uhD/IQ/hJu76q76NVRwgC81R
         juEifmN9L7j7Tw7acNc4QOSlel3LhuMwcJUbQpbFc1EyAY9CfrQJi9Z4tHImak0pFo
         NOEeFK5zAfCIQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.7
Date:   Wed, 25 Oct 2023 17:58:56 +0300
Message-Id: <20231025145857.2212632-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the v6.7-rc1 merge
window. This time it contains only driver updates. There is one new driver
and fixes and cleanups in existing drivers and dt bindings. The summary is
in the signed tag.

All patches have been in linux-next during the last week. Please pull into
char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc1

for you to fetch changes up to d4c720a19e9ac3a907a8bf9a11c5a3a4e3e50a34:

  Merge branch 'icc-platform-remove' into icc-next (2023-10-19 00:50:03 +0300)

----------------------------------------------------------------
interconnect changes for 6.7

This pull request contains the interconnect changes for the 6.7-rc1 merge
window which contains just driver changes with the following highlights:

Driver changes:
- New interconnect driver for the SDX75 platform.
- Support for coefficients to allow node-specific rate adjustments.
- Update DT bindings according to the recent changes of how we
  represent the SMD and RPM bus clocks on Qualcomm platforms.
- Misc fixes and cleanups.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Andy Shevchenko (4):
      interconnect: imx: Replace custom implementation of COUNT_ARGS()
      interconnect: msm8974: Replace custom implementation of COUNT_ARGS()
      interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()
      interconnect: imx: Replace inclusion of kernel.h in the header

Georgi Djakov (6):
      Merge branch 'icc-qcom-coefficients' into icc-next
      Merge branch 'icc-rpm-dt-bindings' into icc-next
      Merge branch 'icc-acv-enable-mask' into icc-next
      Merge branch 'icc-sdx75' into icc-next
      Merge branch 'icc-misc' into icc-next
      Merge branch 'icc-platform-remove' into icc-next

Konrad Dybcio (27):
      interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
      interconnect: qcom: icc-rpm: Separate out clock rate calulcations
      interconnect: qcom: icc-rpm: Let nodes drive their own bus clock
      interconnect: qcom: icc-rpm: Check for node-specific rate coefficients
      interconnect: qcom: qcm2290: Hook up MAS_APPS_PROC's bus clock
      interconnect: qcom: qcm2290: Set AB coefficients
      interconnect: qcom: qcm2290: Update EBI channel configuration
      interconnect: qcom: sdm660: Set AB/IB coefficients
      interconnect: qcom: msm8996: Set AB/IB coefficients
      dt-bindings: interconnect: qcom: Introduce qcom,rpm-common
      dt-bindings: interconnect: qcom: qcm2290: Remove RPM bus clocks
      dt-bindings: interconnect: qcom: Fix and separate out SDM660
      dt-bindings: interconnect: qcom: Fix and separate out MSM8996
      dt-bindings: interconnect: qcom: Fix and separate out MSM8939
      dt-bindings: interconnect: qcom: rpm: Clean up the file
      dt-bindings: interconnect: qcom: rpm: Clean up the example
      interconnect: qcom: qdu1000: Set ACV enable_mask
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm670: Set ACV enable_mask
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8250: Set ACV enable_mask
      interconnect: qcom: sm8350: Set ACV enable_mask

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,rpmh: do not require reg on SDX65 MC virt

Rohit Agarwal (2):
      dt-bindings: interconnect: Add compatibles for SDX75
      interconnect: qcom: Add SDX75 interconnect provider driver

Uwe Kleine-König (1):
      interconnect: qcom: Convert to platform remove callback returning void

Yang Yingliang (1):
      interconnect: fix error handling in qnoc_probe()

 .../devicetree/bindings/interconnect/qcom,msm8939.yaml         |   74 +
 .../devicetree/bindings/interconnect/qcom,msm8996.yaml         |  126 +
 .../devicetree/bindings/interconnect/qcom,qcm2290.yaml         |   60 +-
 .../devicetree/bindings/interconnect/qcom,rpm-common.yaml      |   28 +
 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml   |  250 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |    1 +
 .../devicetree/bindings/interconnect/qcom,sdm660.yaml          |  108 +
 .../devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml      |   92 +
 drivers/interconnect/imx/imx.h                                 |    9 +-
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/icc-rpm-clocks.c                     |    6 +
 drivers/interconnect/qcom/icc-rpm.c                            |   90 +-
 drivers/interconnect/qcom/icc-rpm.h                            |   15 +
 drivers/interconnect/qcom/icc-rpmh.c                           |    4 +-
 drivers/interconnect/qcom/icc-rpmh.h                           |    2 +-
 drivers/interconnect/qcom/msm8974.c                            |    4 +-
 drivers/interconnect/qcom/msm8996.c                            |    8 +-
 drivers/interconnect/qcom/osm-l3.c                             |    3 +-
 drivers/interconnect/qcom/qcm2290.c                            |    9 +-
 drivers/interconnect/qcom/qdu1000.c                            |    3 +-
 drivers/interconnect/qcom/sa8775p.c                            |    2 +-
 drivers/interconnect/qcom/sc7180.c                             |    3 +-
 drivers/interconnect/qcom/sc7280.c                             |    3 +-
 drivers/interconnect/qcom/sc8180x.c                            |    3 +-
 drivers/interconnect/qcom/sc8280xp.c                           |    3 +-
 drivers/interconnect/qcom/sdm660.c                             |    4 +
 drivers/interconnect/qcom/sdm670.c                             |    3 +-
 drivers/interconnect/qcom/sdm845.c                             |    3 +-
 drivers/interconnect/qcom/sdx55.c                              |    2 +-
 drivers/interconnect/qcom/sdx65.c                              |    2 +-
 drivers/interconnect/qcom/sdx75.c                              | 1107 ++++++++
 drivers/interconnect/qcom/sdx75.h                              |   97 +
 drivers/interconnect/qcom/sm6350.c                             |    3 +-
 drivers/interconnect/qcom/sm8150.c                             |    3 +-
 drivers/interconnect/qcom/sm8250.c                             |    3 +-
 drivers/interconnect/qcom/sm8350.c                             |    3 +-
 drivers/interconnect/qcom/sm8450.c                             |    2 +-
 drivers/interconnect/qcom/sm8550.c                             |    2 +-
 include/dt-bindings/interconnect/qcom,sdx75.h                  |  102 +
 40 files changed, 1916 insertions(+), 337 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h
