Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D380A633
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574180AbjLHOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574105AbjLHOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10E1FDF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B7EC433CD;
        Fri,  8 Dec 2023 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047086;
        bh=0MgGExYJV/D19j3gNgtyW8OZmsoHr/Wvt78LtIJx10w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HE+WXVYyfTSFVfJdvnB5E8qxGWwfmjLo8pOCmbujo07GrJF72BuVlyeUdk3aW1NnJ
         48DQt+uBiVMxO+zLT1TLdDV/xaoy4GRBCH6xwcQg36ZuX40LA2JMU8IMeUvws9cclL
         ncp7SdHG1ScbrxCCxq0Tr2CCfen+1mFBW7XACRK++T3JZtn9knk9M7aXoKy82eP51D
         CyTkhAi+FDzm1Ls5DVpQwc6x5c0lmUI3Q6T99+Qbn9zGHa5miyAYlPr5PkiovaKrV4
         9rFy3hAhBHQo0mD4WOhPIc6aq7y/6I9xGS9FXK9+hzD9n6TQSOikKN4pIBQsR3eEZZ
         z4069bpnsCGEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
Subject: Re: (subset) [PATCH V3 0/4] clk: qcom: Introduce clocks drivers for X1E80100
Date:   Fri,  8 Dec 2023 06:55:34 -0800
Message-ID: <170204733637.342318.16035155134593344694.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205061002.30759-1-quic_sibis@quicinc.com>
References: <20231205061002.30759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2023 11:39:58 +0530, Sibi Sankar wrote:
> This series adds initial clock support for the Qualcomm X1E80100 platform,
> aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied, thanks!

[2/4] clk: qcom: Add Global Clock controller (GCC) driver for X1E80100
      commit: 161b7c401f4bd3e9ebd351f482139d8736be990c
[4/4] clk: qcom: rpmh: Add support for X1E80100 rpmh clocks
      commit: 874bc7be1e08bca7d47cfa2dba57164f73a30219

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
