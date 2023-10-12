Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D87C7408
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbjJLRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347348AbjJLRVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:21:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD07DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:21:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c60778a3bfso10944465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697131303; x=1697736103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4o0VE3GXuM7/67ZO5GT2U/bw0PES2y181UsbC++z2Rs=;
        b=Puj4pjSUZXL8tC4Mu1RXLH6ejEYdFmlVqbNtedtXB+xGkAc6ajBy+lfmf0lY3U8Xfn
         Gd3/xMJFkMLIYgsJYXbhG/8pouOsYBi/kpSflyyE+qgnEn1BmhHwpx9LFH0oiSVv0p2M
         40FTsyN0IPrpUWu4IAZK2UO8JH0zVqVT2KIHEz6i9i62+4JXiIvvMPlzjd9jU//TAP/S
         ugpH70uc57Vbj4N521Nrt12hfIK6mPaDLMPzXBK0lJDaYdGmiF0hR5tbOuyxjAfX0LmV
         k4GARgpqPdvTSxnBxxpyAvAD4m6inst1Dauwgp2p5ADGLjVCj1ipiRfG2o3KdbC+3//y
         ubog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131303; x=1697736103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o0VE3GXuM7/67ZO5GT2U/bw0PES2y181UsbC++z2Rs=;
        b=MFdtf5IGGDC8C8Xlwm9qqFQdighfYBiHBnZrKOC1JQtJ27KO4K/AndIldkt+Vczqo2
         ui79ngoE15sESdDNPsG9vI9x7/4IoeYe8FGfGyx+CYAGr7sKC1cyKawis3ldeKXsygAB
         xjurZXMAeqKxX5qAgO6QvAlAP513uiyf8934dtvHYmfc/22zOw3nsTRSaMKVpXOnsEoJ
         mu025wvoJ2rje1dKGFKrbGCZOr2PnnzYVV/c5pYOZM8B/+bDp9bqZJd0DbgurP1Boq7N
         DrQRi9MIb+oy6+qPtFkQ9K6iW6k/5uVo488efhlXbckXZG0krEkRBet6wFukdbwgOsR1
         BUvQ==
X-Gm-Message-State: AOJu0Yy0pQvEy5TWx7R04PcwcI6Y2JPFxAkPxU6qwPo8qdbSpJm9Z4lV
        DUVcJQ7+DlPiQe5azt+sq1ag
X-Google-Smtp-Source: AGHT+IFucoxW73imfXYl6qZ7hJDLFsbG0EOZVauFefSh8gl9htQMON7uvSIswMx3E08U0aMzzT889w==
X-Received: by 2002:a17:903:810:b0:1c9:e257:f88 with SMTP id kr16-20020a170903081000b001c9e2570f88mr1805665plb.10.1697131303216;
        Thu, 12 Oct 2023 10:21:43 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c75a07f62esm2242359plg.34.2023.10.12.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:42 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 0/5] UFS: Add OPP support
Date:   Thu, 12 Oct 2023 22:51:24 +0530
Message-Id: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds OPP (Operating Points) support to UFSHCD driver.

Motivation behind adding OPP support is to scale both clocks as well as
regulators/performance state dynamically. Currently, UFSHCD just scales
clock frequency during runtime with the help of "freq-table-hz" property
defined in devicetree. With the addition of OPP tables in devicetree (as
done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
both clocks and performance state of power domain which helps in power
saving.

For the addition of OPP support to UFSHCD, there are changes required to
the OPP framework and devfreq drivers. The OPP framework changes are already
merged and the devfreq change is added in this series.

Credits
=======

This series is a continuation of previous work by Krzysztof Kozlowski [1].

Testing
=======

This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
development boards.

Merging Strategy
================

Since the devfreq patch got an Ack from the maintainer, either it can be merged
to scsi tree with rest of the patches or merged separately through devfreq tree.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/

Changes in v7:

* Added missing EXPORT_SYMBOL_GPL() for ufshcd_opp_config_clks() API as reported
  by Alessandro Carminati

Changes in v6:

* Collected tags from Dmitry
* Fixed bindings issues reported by Krzysztof

Changes in v5:

* Dropped the devfreq patch since it got applied
* Fixed the bindings issue reported by DT bot
* Rebased on top of mkp/scsi/for-next

Changes in v4:

* Rebased on top of v6.6-rc3

Changes in v3:

* Rebased on top of linux-next/master tag: next-20230731
* Dropped the already applied patches (dts, opp binding and framework)
* Moved the interconnect patches to a separate series:
  https://lore.kernel.org/linux-scsi/20230731145020.41262-1-manivannan.sadhasivam@linaro.org/
* Moved ufshcd_opp_config_clks() API to ufshcd.c to fix the build failure
  reported by Kbuild bot: https://lore.kernel.org/all/202307210542.KoLHRbU6-lkp@intel.com/
* Collected Acks
* v2: https://lore.kernel.org/all/20230720054100.9940-1-manivannan.sadhasivam@linaro.org/

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

Manivannan Sadhasivam (3):
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC

 .../devicetree/bindings/ufs/ufs-common.yaml   |  35 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  42 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  39 +++-
 drivers/ufs/core/ufshcd.c                     | 180 ++++++++++++++----
 drivers/ufs/host/ufshcd-pltfrm.c              |  78 ++++++++
 include/ufs/ufshcd.h                          |   7 +
 6 files changed, 326 insertions(+), 55 deletions(-)

-- 
2.25.1

