Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D37D2480
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJVQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjJVPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8386EF7;
        Sun, 22 Oct 2023 08:46:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D28C43395;
        Sun, 22 Oct 2023 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989574;
        bh=xG2Tj9Dab8omFXwv+XzIHeLf8u48rq8d44pq+3OjGZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL+XRI6q8gBzldTLIiHuxzNdFR9ZVsuUm1BLtjO40dY20pUWve4WRBcgYmZufKVvD
         FzumuHXdwh35cGZy+fZFLIN0Db9B7dbMcdtrLTjyrIdOOh29NtJx0UIiAG4++Fh0rU
         GG8O3bWsU8Nw9BBKdeeZc7fK/C4mOCHaw9Rm/GDJgF7iS0xlD4DhCJRvvD5A3DnT/k
         eLnnz5Zcha2ZVzkZCjMnMAwsjwXMqBjyuqmW2qTnrC7IiFXPZn0KV9onRe39vuXVJJ
         e/RPmABmRcqvffBWuQIMwgAf4vd87gHMu1SoZZuMISaltZ1W3G5TVNMOoVd+86orer
         35jSF2diKsAuA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v5 0/2] irqchip/qcom-pdc: support v3.2 HW
Date:   Sun, 22 Oct 2023 08:50:21 -0700
Message-ID: <169798982232.271027.4963613790320740027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
References: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Fri, 29 Sep 2023 05:43:59 +0200, Neil Armstrong wrote:
> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
> IRQ_i_CFG register and requires a change of the driver to avoid
> writing into an undefined register address.
> 
> Get the HW version from registers and set the IRQ_ENABLE bit to the
> correct register depending on the HW version.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm8150: extend the size of the PDC resource
      commit: 00c86efb0f78319958b7bca3391c532016acf39c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
