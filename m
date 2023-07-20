Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FA75A589
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGTFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:41:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0A172D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:41:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2886364so2278405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831689; x=1690436489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WN6RnkgIzdaal19YY8XLdqCtBwmPCaI6lFevgwA6NkQ=;
        b=QcYN2iEFkUyQ9vHTSJINfTdF7Du3vqHm7+OJIxMyIcPuF8wdIC66YH1vt5jWCRjYlh
         JmwoX5r4Ob1wCA6nTd5XkFYt85qKAzVnQj7l9EuEgtjPUAtwq+glNlKsOdi0NcrE8EMc
         bWw1W7Chzo8CtMEmzQTqJzOctMJj7KnlCXZK3l4/zZlJfaj5v2XQa0OOdjZA5QD4OhaN
         NtOmAPtb9Evw/eRaNG1HSbHPnl2xxUJj5l657HC355NXs7jc5i8/9W/edxqDiY97snMv
         udRbCcszreDVjxnanciO2otrhctaRybcyMfqRSHbc4TAg0mFufQ/FYJL5qvGOVh4TPS8
         jVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831689; x=1690436489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN6RnkgIzdaal19YY8XLdqCtBwmPCaI6lFevgwA6NkQ=;
        b=I6uxC55pH6bPJ+dakpznKMRPcZBaPGCnMPcL4NGKX1cWjqBbSrkbm7Hl8SF7+MXgQW
         6FgwTREGjzlQP/jnYEWtxTM4+4cy3ghGr7jqOmvVJ39C+t78Hk4XVyBmySY5aZaERQzW
         T3NcNSQCiJKwbk+OlqDiXnQ/s3F51ArluAFiFwfgoi3bIStwAtNwMXC1ZeWctNP4j9nb
         /TVqb5huRFrRP3lVSdRa1Ap2fsYwP/p4cTzdcSrC8UEUOE0UdusTp1Onk50QcrC2KhF0
         M+l1NR72fk6Km86oVFEhIky8XH+SKePgB9rJokmQ63c5V/tsL3R2dFL4A9gWRazjhDzj
         PATQ==
X-Gm-Message-State: ABy/qLbpuaisHXL2LYyMEfmmiiMKuRfgtEN+r63zAjDyCPlj9RTc1fpn
        rsbb3PZ/9QJzYjBcao5abUtG
X-Google-Smtp-Source: APBJJlF1woeafM7N5JSQiQHje6/huLkPMe/UguooncmqloYSF3r+Ni7Qp6cwpNBSwGU8Fj3qkHdVZw==
X-Received: by 2002:a17:903:26c5:b0:1b8:5735:2850 with SMTP id jg5-20020a17090326c500b001b857352850mr3799158plb.32.1689831688756;
        Wed, 19 Jul 2023 22:41:28 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:41:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/15] UFS: Add OPP and interconnect support
Date:   Thu, 20 Jul 2023 11:10:45 +0530
Message-Id: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds OPP (Operating Points) support to UFSHCD driver and
interconnect support to Qcom UFS driver.

Motivation behind adding OPP support is to scale both clocks as well as
regulators/performance state dynamically. Currently, UFSHCD just scales
clock frequency during runtime with the help of "freq-table-hz" property
defined in devicetree. With the addition of OPP tables in devicetree (as
done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
both clocks and performance state of power domain which helps in power
saving.

For the addition of OPP support to UFSHCD, there are changes required to
the OPP framework and devfreq drivers which are also added in this series.

Finally, interconnect support is added to Qcom UFS driver for scaling the
interconnect path dynamically. This is required to avoid boot crash in
recent SoCs and also to save power during runtime. More information is
available in patch 13/13.

Credits
=======

This series is a continuation of previous work by Krzysztof Kozlowski [1]
and Brian Masney [2]. Ideally, this could've split into two series (OPP
and interconnect) but since there will be a dependency in the devicetree,
I decided to keep them in a single series.

Testing
=======

This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
development boards.

Merging Strategy
================

An immutable branch might be required between OPP and SCSI trees because of
the API dependency (devfreq too). And I leave it up to the maintainers to
decide.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/
[2] https://lore.kernel.org/all/20221117104957.254648-1-bmasney@redhat.com/

Changes in v2:

* Added more description to the bindings patch 2/15
* Fixed dev_pm_opp_put() usage in patch 10/15
* Added a new patch for adding enums for UFS lanes 14/15
* Changed the icc variables to mem_bw and cfg_bw and used
  the enums for gears and lanes in bw_table
* Collected review tags
* Added SCSI list and folks
* Removed duplicate patches

Krzysztof Kozlowski (2):
  dt-bindings: ufs: common: add OPP table
  arm64: dts: qcom: sdm845: Add OPP table support to UFSHC

Manivannan Sadhasivam (13):
  dt-bindings: opp: Increase maxItems for opp-hz property
  arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
  arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
  OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
  OPP: Introduce dev_pm_opp_get_freq_indexed() API
  PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
    APIs
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
  arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
  scsi: ufs: core: Add enums for UFS lanes
  scsi: ufs: qcom: Add support for scaling interconnects

 .../devicetree/bindings/opp/opp-v2-base.yaml  |   2 +-
 .../devicetree/bindings/ufs/ufs-common.yaml   |  34 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  47 ++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  43 +++--
 drivers/devfreq/devfreq.c                     |  14 +-
 drivers/opp/core.c                            |  76 +++++++++
 drivers/ufs/core/ufshcd.c                     | 148 +++++++++++++-----
 drivers/ufs/host/ufs-qcom.c                   | 131 +++++++++++++++-
 drivers/ufs/host/ufs-qcom.h                   |   3 +
 drivers/ufs/host/ufshcd-pltfrm.c              | 120 +++++++++++++-
 include/linux/pm_opp.h                        |  26 +++
 include/ufs/ufshcd.h                          |   4 +
 include/ufs/unipro.h                          |   6 +
 13 files changed, 586 insertions(+), 68 deletions(-)

-- 
2.25.1

