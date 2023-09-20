Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D67A8A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjITRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjITRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F24A9;
        Wed, 20 Sep 2023 10:10:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF4EC433AB;
        Wed, 20 Sep 2023 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229812;
        bh=o7nTU3QvpL/h81ML/cdz1dzlBMttTK2LQ8L4LUAtGpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boRaIMjWBsKexLTv+Deq9YfQ6vaiszX2DM0jwV62Im3qgxMk4mYDdUWLHdSEXXVYL
         JTXQbUBqe3kXk2uMuf2kNzjHcSt+CR8UVALvgCVPRHadZW3iBP8/ecnJLNXQlCBkOV
         ddAOtwCko7UavxFOud+pMCh1QysCFgpVOAgSK5QgZpCyToIvvHe5C0oCrW1yjWjDIk
         MXdc5blbxXt8Xj1kOBUbwDRvmLQXgbUzdiYgrIIEFrD3puBtPfyf69U5s7KTn4V8C/
         qGFpAQv4eE19a0lB9ddAQa3ClltgfEefLSG+5yB89vEzx9Z4ZBAsiidGdYjv1Nx8d5
         kRm5k6uO+lw5Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-msm8996: Remove RPM bus clocks
Date:   Wed, 20 Sep 2023 10:14:00 -0700
Message-ID: <169523004951.2665018.11245736362041950205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
References: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
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


On Thu, 31 Aug 2023 11:39:14 +0200, Konrad Dybcio wrote:
> The GCC driver contains clocks that are owned (meaning configured and
> scaled) by the RPM core.
> 
> Remove them from Linux to stop interjecting the RPM's logic.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-msm8996: Remove RPM bus clocks
      commit: 4afda5f6bcdf673ef2556fcfa458daf3a5a648d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
