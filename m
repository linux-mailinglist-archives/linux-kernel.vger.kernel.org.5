Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1267A8A13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjITRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjITRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7AA3;
        Wed, 20 Sep 2023 10:10:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2005CC43397;
        Wed, 20 Sep 2023 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229809;
        bh=U8XbdbOLoq3bceXv4RDD1QBPFny3+6sCvhU/9/2NBj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXRWRlQuSgCnXWJ0aegVXvCIeCh1F+nVqfIaumKoa3erCHuj+Hkl3iDcaHacHTMmd
         9vgCSVAB5ofSldIFCoLHhz7MOKCVxHOxWBJzUgODjDljqDzZOkwbkGs9gdaWWFG7fU
         rm5Vb9OH4MewCL0zBLsaBHaal4VdiikvMLOpctXEQHIF/Vt1cEYVWdrDQ4dbUZIMYK
         RckejzlsBxZCMnuGukjEXfYHxiMU1h6I/tz1UGp/OC7nD7KUgaM5eakj5AWHce1m0v
         eiuBsOp6qI2YsXt1HV5bdCV0ZOMyY917yQbDdtoj9ZktV1Jobx/bsW81Yy4amQ319B
         YFky1JZZXN8+Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, vkoul@kernel.org,
        quic_tdas@quicinc.com, dkatraga@codeaurora.org,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     adomerlee@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
Date:   Wed, 20 Sep 2023 10:13:57 -0700
Message-ID: <169523004972.2665018.4862460911301871146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913175612.8685-1-danila@jiaxyga.com>
References: <20230913175612.8685-1-danila@jiaxyga.com>
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


On Wed, 13 Sep 2023 20:56:11 +0300, Danila Tikhonov wrote:
> Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
      commit: 7138c244fb293f24ce8ab782961022eff00a10c4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
