Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52E7A09F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbjINQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbjINQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81901BEF;
        Thu, 14 Sep 2023 09:00:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64221C433C7;
        Thu, 14 Sep 2023 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707230;
        bh=OYN5GeHDGg/fi2AaPThTCk4AuKi5RjqpvJ0Y1SDgX/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fcy6Q1bfxYDY/IOa3YKiQaKZRUXtIgxcdDtZZUjHZw/Djm1cjCKi4u+av9XChdltj
         pfPAZrMEfjJjxoWshrmdUzUHYIUfA4JbyUZQG7UvjLryoJpKgnOmFInRQukxnBEwj/
         SxC2GVT415zPjU5UUJJZxheXhyK9DfD9usF1uhaqfBc1DhTd6RDsAYqTUDfy8UMH/l
         cngmJVmD1VsRP1QBS/JGUvA/q/tPMcQmieszLQMep0tGIcNNIntPTn7d+Tcj7GQORC
         DHYR5sH2LRqGjswvwj0lyE51TapExlIMZdIXT9rzvUQEoHjE9DdgYdFyIHb8B01aeg
         pynNGXH7QZ9lg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] MSM8976 PLL,RPMPD and DTS changes
Date:   Thu, 14 Sep 2023 09:04:18 -0700
Message-ID: <169470744874.681825.2938456613731544807.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Aug 2023 13:24:43 +0200, Adam Skladowski wrote:
> This patch series fixes introduce support for msm8976 pll,
> also brings some adjustments and fixes domains setup and few dts nitpicks.
> 
> Changes since v1
> ================
> 1. Fixed few styling issues
> 2. Changed compatibles for plls
> 3. Added fixes: tag to first patch
> 
> [...]

Applied, thanks!

[2/7] clk: qcom: clk-hfpll: Configure l_val in init when required
      commit: 500a4609eef46d49a260173b66cabb20bd5159ad
[3/7] clk: qcom: hfpll: Allow matching pdata
      commit: 34e000c0963e55f24be2254fa645f8dd8257a9e0
[4/7] dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
      commit: de37ca2dc98607e74522d8f243aa7feac74577c5
[5/7] clk: qcom: hfpll: Add MSM8976 PLL data
      commit: 1fa2d1a887c763246662a88e203d69b36052770c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
