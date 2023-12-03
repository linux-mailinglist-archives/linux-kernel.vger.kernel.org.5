Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD71802103
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjLCExy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjLCExL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:53:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4971FFB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B38C43395;
        Sun,  3 Dec 2023 04:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579124;
        bh=5TnnNiKyWWARtWCoPBVYm/DD73kBLxdG0tcydvAN094=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuUAUBEYVKhMHZ1t37E+/uS+hWPlAst2qQhD3hTmGcMoJYed0ivpzccLAvEaWRSAn
         nkzodWHxyg+9H/BEjloutndEb9C+qCLfkEE8ot3TEj4dJXZ2oM6V7+1f99nU4SMrW8
         NdOTG4RJPoDW6zjyBn8J1XJ0eCl/bIjIkun3uxej20vsN6l3IxE172hKCmTJ4Y5jcQ
         GXt7ooRNnyIt+UNx2ZzF9Btz+mLz7YwpSVM51MYxnjGd9kZKqgG8gsJ46BSvMZoHMM
         ppsvUwu4pz8zhAiJheCNE7w7cneOlXVoJPUl9dgGyAQTydEsSamT20qHnToGGIs3iT
         TqlTadZ7OVRSg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Add support for qcm6490 idp and qcs6490 rb3gen2 board
Date:   Sat,  2 Dec 2023 20:54:50 -0800
Message-ID: <170157925812.1717511.10611634209504625070.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129065816.26409-1-quic_kbajaj@quicinc.com>
References: <20231129065816.26409-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Wed, 29 Nov 2023 12:28:13 +0530, Komal Bajaj wrote:
> This series adds the dt-binding and base devicetree files for
> QCM6490 IDP based off QCM6490 SoC derived from SC7280 meant for
> various form factor including IoT and QCS6490 RB3Gen2 based
> off QCS6490 SoC derivative of QCM6490 without internal modem.
> See more at:
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qcs-qcm6490-soc-product-brief_87-28733-1-b.pdf
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: qcom: Add QCM6490 IDP and QCS6490 RB3Gen2 board
      commit: 06fd1dd1efde4a0bcc874de03558f6e0ba3817eb
[2/3] arm64: dts: qcom: Add base qcm6490 idp board dts
      commit: 9af6a9f32ad0023b1d682af213a0c8c2aa1dce29
[3/3] arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts
      commit: 04cf333afc757d8fd3c674c6c3f5f86c7755b4d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
