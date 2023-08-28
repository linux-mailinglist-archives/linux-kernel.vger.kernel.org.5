Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B278AF15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjH1LnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjH1Lmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:42:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2645E7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50087d47d4dso4977948e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693222951; x=1693827751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pCzQJ0jMTfSwe/0ZOPIiLe+oNZxbdSusdDHoFzoxhs=;
        b=YOBcoFIwluIOyWGcyM5v2TTEslNHvlBs2ySo/ZiQpwuUeBAY9hKg1qq/9afGOprmZo
         Gb0eKwzTYugNlmzaVG42yUgv49GjkskQkbxO/OcjagywE3QkPAYrTAHiZVfAj+yL5mem
         zFZq4XJCAogZCfo4yvY4typkw4xr2L02VE3CBbT7l25J5mh6Dvzkhd0p1OX215Gm7kVP
         /rQxykWnW5J4l4DbD4rmCQaXfPCQaxTVRfuuAtNOFmZ44F5cCCGEDsmXWqKQU6fGicii
         u4QOFQL5pav29Gd/g2cteNAvHow0ts3i7fG4AaRIxV90IWjtYxcwltIarXBKDOsvIzp4
         3tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222951; x=1693827751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pCzQJ0jMTfSwe/0ZOPIiLe+oNZxbdSusdDHoFzoxhs=;
        b=EUDrgMVpCenIpplE97TP027/+glEArdpfIT6lfoT7raRYK8TBPWHxpCrmu3QW4ju99
         j5uWknKAa6eDXBayxqI3C7KWNj143RaEDpDe/HmZQFk0vOiEfWlRRwG/K65KUD8QXrdd
         gF/baSo5xoL3laySFQ/EM8a/LUiXKJJTW8079W8JC43fEUFdBanaZc75PX3L3RZaj5wW
         9BlJENGPx3nzmim4aZw7vqmZ4Mp5ggwH4v6hkliBSgRlpE9IiFQ4K8dft9zpbhkuono2
         gR0Zj/7MlvTJ8qR+KnQ/q+Re9DZJrMPdkA2xwOKIGduim28OnwXGAnsFwhNuxjPCl7NC
         4N9g==
X-Gm-Message-State: AOJu0Yw4yuOE2UJkzmW3oaXHgMswX3VnvHybNifjOBQeJ6yWVVatKbU/
        fz/wXKQe6t+Dy15nJZmR7SM/og==
X-Google-Smtp-Source: AGHT+IF25SbqjUFgSXqqBPdrZjgv2ldQjJ0ND5qCwhHMQA/wtF9QbiCD2x/Ygvw6w/u09fyqxri21g==
X-Received: by 2002:a05:6512:615:b0:4fb:829b:196e with SMTP id b21-20020a056512061500b004fb829b196emr17131926lfe.2.1693222950578;
        Mon, 28 Aug 2023 04:42:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm1547799lfp.9.2023.08.28.04.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:42:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v14 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
Date:   Mon, 28 Aug 2023 13:42:12 +0200
Message-Id: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWI7GQC/33NQWrDMBAF0KsErauiGcl26Sr3KF2MpFEsMJKRU
 tMSfPdOsispXv4/vD831bll7ur9dFONt9xzLRLAvZxUmKlcWOcohUKD1iBM+lrXHHRYm511ZLT
 ok3cTByXCU2ftG5UwiylfyyLl2jjl78ePj0/Jc+7X2n4eLzcw9/r/dTlqo8eJOL6lmGiE85ILt
 fpa20XdpzaAIw7CPSF6F4mGOD5zPOIoHMhFMxgGHqdnbo+4FR4NhJQgDC6kP3zf91/gEGiyfAE
 AAA==
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693222948; l=8940;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RBcdLtSOaoM0p4yqHckJhMBSmnQ9YdjBvghkm0NcLN0=;
 b=SOvIQsAtAafk2Ok38JUquMTJKKGW14IkPivIlU4NE8PScIiyR+lyuSmqRSnh5KSGDfkZsu2x4
 CDTcRxdsXouDJojTIgP+0uHlvhLFfKA6Ok14YhqCMFbud2JQGBNAwhs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v14:
- Rebase
- Drop cpufreq probing block (merged)
- Pick up tags
- Drop quotes from CPR3 bindings $id:
- Drop useless description: under compatible:
- Link to v13: https://lore.kernel.org/r/20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org

Changes in v13:
- blacklist -> blocklist in cpufreq commit message
- rebase atop drivers/genpd introduction
- remove quotes in cpr bindings
- describe reg entries in cpr bindings
- define the # of power-domains in cpr bindings
- pick up tags
- Link to v12: https://lore.kernel.org/r/20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org

Changes in v12:
- Add the !independent! patch to block cpufreq-dt from probing on 8998 (it tries
  to when we attach OPP tables to the CPU nodes)
- Include all promised changes to the CPR3 driver from v11 (I managed to
  send the wrong version of that patch last time around..)
- Partially rewrite debugfs code (to make it work and be cleaner)
- use FIELD_PREP/GET throughout the driver (managed to squash a bug when
  exploring that)
- Fix and finish the removal of cpr_get_ro_factor() by introducing
  cpr_thread_desc.ro_scaling_factor_common
- Replace underscores in node names with '-'
- Fix some formatstring issues that clang apparently doesn't care about
- Link to v11: https://lore.kernel.org/r/20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org

Changes in v11:

CPR COMMON:
- split the commonizing patch, make it actually do what it says on the
  tin..
- fix some overflow bugs

CPR3:
- fix some overflow bugs
- don't assume "lack of qcom,opp-?loop-vadj" means val=0"

CPR BINDINGS:
- drop quotes in items
- drop clock-names (there's just a single one)
- rewrite the description a bit
- fix up the example
- drop bogus minItems
- "acc-syscon" -> "qcom,acc"

DTS:
- fix qfprom children so that the bits=<> doesn't overflow reg[size]
- drop unrelated changes
- place one reg entry per line

Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org

Changes in v10:
- Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
- Use b4 (it may be the first time you're receiving this if git send-email
  omitted you before..)
- +Cc Robert Marko (expressed interest in previous revisions)
- Add "Document CPR3 open/closed loop volt adjustment"
CPR:
- %hhu -> %u (checkpatch)
CPR BINDINGS:
- Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
  but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
  follow soon..)
- Drop Rob's R-b (as things changed *again*, please take one more look to make
  sure you're okay with this file, Rob..)

Link to v9:
https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/

Changes in v9:
- Restore forgotten MAINTAINERS patch (oops)
CPR:
- Include the missing header (big oops!)
- Fix kconfig dependencies
CPR bindings:
- Fix cpu reg in example (why didn't dt_binding_check scream at that)
- Add newlines between nodes in example
- Change opp table node names to opp-table-cpu[04]
- Change opp table labels to cpu[04]_opp_table
- Change CPRh opp subnode names to opp-N from oppN
- Remove some stray newlines
- Bring back nvmem-cell-names and add the 8998's set
- Allow power-domains for VDDCX_AO voting
- Remove Rob's r-b, there's been quite a bit of changes..
CPR DT:
- Send the correct revision of the patch this time around..
OPP bindings:
- Add Rob's ack

Link to v8:
https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/

Changes in v8:
- Overtake this series from AGdR
- Apply all review comments from v7 except Vladimir's request to
  not create the include/ header; it will be strictly necessary for
  OSM-aware cpufreq_hw programming, which this series was more or
  less created just for..
- Drop QCS404 dtsi change, account for not breaking backwards compat
  in [3/5]
- Add type phandle type reference to acc-syscon in [1/5]
- Update AGdR's email addresses for maintainer entries
- Add [2/5] to make dt_binding_check happy
- Separate the CPRh DT addition from cpufreq_hw addition, sort and
  properly indent new nodes
- Drop CPR yaml conversion, that happened in meantime
- Reorder the patches to make a bit more sense
- Tested again on MSM8998 Xperia XZ Premium (Maple)
- I take no responsibility for AGdR's cheeky jokes, only the code!

Link to v7:
https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/

Changes in v7:
- Rebased on linux-next as of 210901
- Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
  following what was done in commit c77634b9d916

Changes in v6:
- Fixes from Bjorn's review
- After a conversation with Viresh, it turned out I was abusing the
  OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
  so now the driver is using the genpd created virtual device and
  passing drvdata instead to stop the abuse
- Since the CPR commonization was ignored for more than 6 months,
  it is now included in the CPRv3/4/h series, as there is no point
  in commonizing without having this driver
- Rebased on v5.13

Changes in v5:
- Fixed getting OPP table when not yet installed by the caller
  of power domain attachment

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Fixed YAML doc issues
- Removed unused variables and redundant if branch

Changes in v2:
- Implemented dynamic Memory Accelerator corners support, needed
  by MSM8998
- Added MSM8998 Silver/Gold parameters

This commit introduces a new driver, based on the one for cpr v1,
to enable support for the newer Qualcomm Core Power Reduction
hardware, known downstream as CPR3, CPR4 and CPRh, and support
for MSM8998 and SDM630 CPU power reduction.

In these new versions of the hardware, support for various new
features was introduced, including voltage reduction for the GPU,
security hardening and a new way of controlling CPU DVFS,
consisting in internal communication between microcontrollers,
specifically the CPR-Hardened and the Operating State Manager.

The CPR v3, v4 and CPRh are present in a broad range of SoCs,
from the mid-range to the high end ones including, but not limited
to, MSM8953/8996/8998, SDM630/636/660/845.

As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
this is limited to the CPU context; despite GPU CPR support being not
implemented in this series, it is planned for the future, and some
SDM845 need the CPR (in the context of GPU CPR) to be configured from
this driver.

It is also planned to add the CPR data for MSM8996, since this driver
does support the CPRv4 found on that SoC, but I currently have no time
to properly test that on a real device, so I prefer getting this big
implementation merged before adding more things on top.

As for MSM8953, we (read: nobody from SoMainline) have no device with
this chip: since we are unable to test the cpr data and the entire
driver on that one, we currently have no plans to do this addition
in the future. This is left to other nice developers: I'm sure that
somebody will come up with that, sooner or later

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
AngeloGioacchino Del Regno (7):
      MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
      dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
      soc: qcom: cpr: Move common functions to new file
      soc: qcom: cpr-common: Add support for flat fuse adjustment
      soc: qcom: cpr-common: Add threads support
      soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
      arm64: dts: qcom: msm8998: Configure CPRh

Konrad Dybcio (2):
      dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
      soc: qcom: cpr: Use u64 for frequency

 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  286 ++
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  757 ++++++
 drivers/genpd/qcom/Makefile                        |    2 +
 drivers/genpd/qcom/cpr-common.c                    |  362 +++
 drivers/genpd/qcom/cpr-common.h                    |  109 +
 drivers/genpd/qcom/cpr.c                           |  394 +--
 drivers/genpd/qcom/cpr3.c                          | 2855 ++++++++++++++++++++
 drivers/soc/qcom/Kconfig                           |   22 +
 include/soc/qcom/cpr.h                             |   17 +
 11 files changed, 4456 insertions(+), 368 deletions(-)
---
base-commit: 6269320850097903b30be8f07a5c61d9f7592393
change-id: 20230217-topic-cpr3h-de232bfb47ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

