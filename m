Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBC801163
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378541AbjLAQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjLAQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FE198
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF94C433CC;
        Fri,  1 Dec 2023 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449206;
        bh=MgB7h5ARqJ3S531R4IVFVRZAv2YOBJSha5OgKGiN/ak=;
        h=From:To:Cc:Subject:Date:From;
        b=cHzu3ti0064GDwTi3GVsBX+GrioJJujpwV4tt1D7gPVZtbWCduFlicw7ntM8T4qx0
         WqFSgm/ODZvs6GuucpVdNETkvW/vnaqqc0MZaLRdXHWGs+ri7xLZbKmTGy3mhtRnyv
         3FSjSCJai/D+jwEgrXrvlBsB9rY87evZMtGDZMsdFOiylqBy8xgg/+Id8mHehWe4Pt
         ASKNBFFwL51YU0YTB38dNi/g6LHYDQsiJFsYbcSvnH4SfnAqCUw16+5xwWwRbEGFrw
         Ukb0tEQkZOiBBSsLo45LAixPqej4iYzSotXqvIZcmBdyAcee72mrPf9N61uemASW9X
         lutkpT6DGtFHA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r96fi-0003IQ-2u;
        Fri, 01 Dec 2023 17:47:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] dt-bindings: mfd: fix up PMIC examples
Date:   Fri,  1 Dec 2023 17:45:42 +0100
Message-ID: <20231201164546.12606-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series addresses the mfd ones along with some related issues.

[ The PM8008 actually sits on an i2c bus but it is related to the other
  Qualcomm SPMI PMICs. ]

Johan


Changes in v2
 - drop the incorrect #address-cells and #size-cells properties also
   from the hi6421 regulator binding (Rob)
 - drop Fixes tag from pm8008 cleanup


Johan Hovold (4):
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix regulator binding
  dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
  dt-bindings: mfd: pm8008: clean up example node names

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 140 +++++++++---------
 .../devicetree/bindings/mfd/qcom,pm8008.yaml  |   5 +-
 2 files changed, 71 insertions(+), 74 deletions(-)

-- 
2.41.0

