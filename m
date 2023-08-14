Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA177AF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHNCAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjHNCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276EE77;
        Sun, 13 Aug 2023 19:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7903562883;
        Mon, 14 Aug 2023 02:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379E7C433C8;
        Mon, 14 Aug 2023 02:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691978401;
        bh=VXCgreshLhYYln6/SruNwFSfHu1qDG+fekDFktePmJc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jmcl7UOjFEL9oROv23bexnFwWHXZdx/INnmp82xfnx1PtzLpsYJVAvVS9sk3RlnPu
         KiGKnAncUTqo5zChom23XTdbv2QlkH+9FZji6m3SoGCCcsafbz+LRvbEFUodCHNfVS
         W6X/weeU4H/LyqzihjjN7do5NcPt5ZchF21SiHvZsaciqe3Yv3haQi5Y9cDqRjdy/9
         VW+uJyhgEjyVbosk9jPE9HjAhcFFmghmwUfFYNpmDWlVnExmW7sGUciKy0m8Q3yVIg
         ByWpCkxj99YW4uj+EbO+Z3Pzz/tC2FTBI3cRdqElUXdNkmRcHPS+LWSMEmMlspTInX
         GvrRCe5ZQQpUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robimarko@gmail.com, krzysztof.kozlowski@linaro.org,
        andy.shevchenko@gmail.com,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: (subset) [PATCH V12 0/6] Add minimal boot support for IPQ5018
Date:   Sun, 13 Aug 2023 19:02:44 -0700
Message-ID: <169197856187.2338511.8659955599601986267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1690533192-22220-1-git-send-email-quic_srichara@quicinc.com>
References: <1690533192-22220-1-git-send-email-quic_srichara@quicinc.com>
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


On Fri, 28 Jul 2023 14:03:06 +0530, Sricharan Ramabadhran wrote:
> The IPQ5018 is Qualcomm's 802.11ax SoC for Routers,
> Gateways and Access Points.
> 
> This series adds minimal board boot support for ipq5018-rdp432-c2 board.
> 
> [v12]   Fixed the subject for patch #1 and fixed a conflict in Makefile for patch #5
>         Reposting all because of some confusion from Hariharan K other patch series.
> 	https://www.spinics.net/lists/linux-arm-msm/msg165658.html
> 
> [...]

Applied, thanks!

[6/6] arm64: defconfig: Enable IPQ5018 SoC base configs
      commit: 7f0c87348fb52d575295d16d4656ecd4c00bad87

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
