Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56180A63E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574091AbjLHOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574229AbjLHOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:52:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83802123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28037C433CB;
        Fri,  8 Dec 2023 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047092;
        bh=WSC2VtdO9KzSokLGWLoAzT6Jt1aCubjY6IGmC9Hagic=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dktVDCMfWE3iKPQHYCSVxVCYIGOjLmFb5WbLuaS30+Rimsm0U1A0jFaS91eSgYodZ
         SU6Y2oe1DfzD4X0w+eHuvqsiZ/5AfV3vy2kMHiX2H+tBiVHxcbVst+cSRx7Gozyi11
         WmJFVQIknjgxufhVqqCV6wyAWn5Zwa72KGiuC8hEk82QFWL87dXJNjzgmRXFoesTPG
         kT2bzjf5/enBxgRYky25aIoswOWTSV7U5bvEheSAvw+UwbMFtXwIeilyFEi4gyAEjq
         TgZn4hLHgEwEr4lPFiZ/cgvKpcK1ZtuUwfBUykV7mpbYhktOLWawWNfzYINoDKcL8Z
         x58tP7JQ0+W/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-ipq6018: split to separate schema
Date:   Fri,  8 Dec 2023 06:55:38 -0800
Message-ID: <170204733612.342318.7630099958511658964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026101931.695497-1-robimarko@gmail.com>
References: <20231026101931.695497-1-robimarko@gmail.com>
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


On Thu, 26 Oct 2023 12:18:37 +0200, Robert Marko wrote:
> The Qualcomm IPQ6018 GCC clock controller has clock inputs, thus existing
> gcc-other.yaml was not describing it fully so move it to a separate schema.
> 
> Fully document the allowed and required XO and sleep clock inputs, as well
> as update the provided example.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: clock: qcom,gcc-ipq6018: split to separate schema
      commit: cec1f2ffcc065568fea9718921698576c6d1c62d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
