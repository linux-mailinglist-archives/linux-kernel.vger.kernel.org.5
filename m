Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8A7D23B6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJVPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjJVPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD44188;
        Sun, 22 Oct 2023 08:46:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5076CC433C7;
        Sun, 22 Oct 2023 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989578;
        bh=DetEMdiRD6MGqVtSW2k7LUFnENO0dedBHH9GU+rM+SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/RTYhLYRkfZadEsok7DCOgCXivU8FProHQzWUGJ/DwKSY8opBoVeHiYET0RF6YJL
         2UBmXwfqhC01/3fvDrqIsqZ121GpIA4o/1sHP9Vj8LE0HJ0rGAQVyZzKil+kpUtQok
         iiAmT1cWH244idnuTYLuvEjN0gO1UqqPN/l/tjhsXo9EEo3+Ii4bdv9HK0vd88P2Vo
         aYOSPfnbxMYbBcrxssoLuE74s8ikNrhunvaTRwe+oB8WDC4j01Oj5/VQg7Qb9e49pR
         5Tg3Y161ioi6+xZDUtNt8dL7yWeOclW+dJL9SlVS3GqRgHvXiW1C5w1XQIoemXTD9D
         4popM2snj/AyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: msm8916/39: Fix-ups for dynamic reserved mem patches
Date:   Sun, 22 Oct 2023 08:50:25 -0700
Message-ID: <169798982295.271027.6626600075646673370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
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


On Thu, 21 Sep 2023 20:56:03 +0200, Stephan Gerhold wrote:
> Enable GPU/WCNSS properly in some MSM8916/MSM8939 boards that were
> changed after I sent the patches for the dynamic reserved memory
> allocation.
> 
> I have magic scripts that make the necessary changes automatically so
> I'm quite sure that I caught all new instances that need adjustment. :-)
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
      commit: e87cef6a035edc03b4ac98f88121c706b2843156
[2/3] arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
      commit: d63ae4a814a763a5d2d4d078073562698693a909
[3/3] arm64: dts: qcom: msm8916-*: Fix alphabetic node order
      commit: b364cc485da1b769f1ead705dcd853e87b42f96e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
