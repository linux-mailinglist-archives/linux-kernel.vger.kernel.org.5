Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2277AF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjHNCbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjHNCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BCE195;
        Sun, 13 Aug 2023 19:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 397B562729;
        Mon, 14 Aug 2023 02:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69D3C433C7;
        Mon, 14 Aug 2023 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691980263;
        bh=VWxsrgrmzgiFVeh4uApFFOq1bvVtEbfmqGxK5dcHgJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqNYowo89QH+fv5UYg6/rjtlSX8A654pS4ZglHks3eafCI4ipt5BTaf8h2y1eUBkK
         KKUWawzDfLHRwDYCXYWmHgIYFpbmhkcSR4avxjw7AGHLB5vH5jIMSjpSGzQqz3Y8FL
         rZWeuQEhJbzyz6C+gUUDIiAXrZFyvTYWN6eN4jNsyuloz01ncxvPuLi8cz+7pwIf2l
         546uPdmjU1Cu01L7CK3vpdLnL+QX2vp/FF5RU1IvTxLvh+2nzUYLm6x8a/6X7YhR5Y
         NMHuEsHCpiuYk6O1FlUO9eE79p7M0yZRNMOxK8UGFtb2NLc20YWYSvubBLmiikhMoT
         WgdQYSnyEOzPg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: (subset) [PATCH v2 0/4] soc: qcom: aoss: Introduce debugfs interface and cleanup things
Date:   Sun, 13 Aug 2023 19:33:50 -0700
Message-ID: <169198038111.2378845.5285992748905331833.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811205839.727373-1-quic_bjorande@quicinc.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 13:58:35 -0700, Bjorn Andersson wrote:
> The Always On Processor supports a number useful commands for affecting
> system resources during in various debug scenarious. Introduce a debugfs
> interface for allowing the debugger/tester to send these commands.
> 
> While at it, let's make some improvements to the qmp_send() API.
> 
> 
> [...]

Applied, thanks!

[1/4] soc: qcom: aoss: Move length requirements from caller
      commit: 59e09100836fdb618b107c37189d6001b5825872
[3/4] soc: qcom: aoss: Format string in qmp_send()
      commit: 8873d1e2f88afbe89c99d8f49f88934a2da2991f
[4/4] soc: qcom: aoss: Tidy up qmp_send() callers
      commit: b4f63bbff96e4510676b1e78b00d14baaee9ad29


Please note that I did not pick the debugfs interface (patch 2/4).

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
