Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B837A97C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIUR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjIUR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C510FA;
        Thu, 21 Sep 2023 10:03:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CF6C4E764;
        Thu, 21 Sep 2023 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306586;
        bh=HPNrgxZmgDrK/7v8w1qWsE4OijoieBpRZDKxz/upQ20=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BtH1ChD9v3Lhaimr7O4iFGTSAiQZu4lSCYhz2K+x9Z7DmqGsODmZnFO/tEo9Exnqg
         XUwyIE3AqFA+nQy8qDyspp+6lU7AUcELyyug+/MvtklzQXMYaqklyBqyEZJ77MSuky
         Ux8t6gzVFuD1ZGdYO4lK8+01rMNheQ0tM1Q+R2S1fhB3vGirg63wf6bzm/2Rj6Amn/
         mIC6CrR/HVJWhV2tlZWo2R2QxmbJ7X3PLl3iPHUCJtkg/Tc+AWQtrRxh01+DRtPJN6
         66R9mxWdzrQs0mKX2s2AvYOImdFD0sj+55fMAxD9KMhUOkEO/K9uRsU9j4Cc/9ELRd
         h3AZ8hq1/2hfw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
References: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
Subject: Re: [PATCH v2 0/4] EUSB2 repeater init sequence override
Message-Id: <169530658362.106263.16903519035871193100.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 11:53:22 +0200, Konrad Dybcio wrote:
> The EUSB2 repeater goes through a tuning sequence as part of its
> initialization. This series ensures the tuning is "clean" and can be
> overridden for devices that need it.
> 
> 

Applied, thanks!

[1/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic tuning overrides
      commit: 2da73b4e0cf1d9847483fe474ce27af987bfb614
[2/4] phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields
      commit: dcc8a942852f00845e75c49ca8a7a6865d6b669d
[3/4] phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs
      commit: af1c6ec341c3a1cc396784b2ce4619aec7be3e34
[4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning overrides
      commit: 05733bd60f7aa4f260a2837574555bbd3b847cca

Best regards,
-- 
~Vinod


