Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B47A8A28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjITRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjITRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E3FB;
        Wed, 20 Sep 2023 10:10:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23884C433CB;
        Wed, 20 Sep 2023 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229816;
        bh=ffoIJVvj5rKT27gchGJm/7DiJGZLbaObPIL49iF12PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMn15jip586IfOOvPd1IyjxMrf1cA4peJeiQFHvFNOcQ9edykYlFfyhgPeJuxM+81
         HVk1rV7vIvWSXp3jl/oXIaD5Uv0NHe2Uhcb8AuoYOndsq5XSgnjBW9mORkusLdcPaL
         q448OMONyJXgDnQsEdcA+l3CXtanEvQAeSoy1rmz+COs0V8YS+ZaStyB6CTSpOBkyz
         d2JaYLgWkqXCXi4Zx1x5YPI88IbsrBWGNP7kNEdpRGcKJl2ymivwKtgJlKOcEG6eJ1
         ZVFy91jeJl8Au6uS0ocJYQeVA94CCiSzWCrhQ/KggP7FOW6qpt6MWjkxGhZ0tKO07a
         JeSAeBina2uEA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [RFT PATCH 1/2] arm64: dts: qcom: apq8096-db820c: fix missing clock populate
Date:   Wed, 20 Sep 2023 10:14:03 -0700
Message-ID: <169523004953.2665018.6144096426032891536.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
References: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 10:18:11 +0200, Krzysztof Kozlowski wrote:
> Commit 704e26678c8d ("arm64: dts: qcom: apq8096-db820c: drop simple-bus
> from clocks") removed "simple-bus" compatible from "clocks" node, but
> one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
> CLK_OF_DECLARE.  This means it will not be instantiated if placed in
> some subnode.  Move the clocks to the root node, so regular devices will
> be populated.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: apq8096-db820c: fix missing clock populate
      commit: 2ca3e844e3f978c0dbc95072dbf379abfc4a27db
[2/2] arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate
      commit: 725f593692ceedeab639b661298955b6f9ba8ec3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
