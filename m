Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4177A8A41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjITRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjITRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A51AE;
        Wed, 20 Sep 2023 10:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DDAC433C7;
        Wed, 20 Sep 2023 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229825;
        bh=0I3AfStlyMfjYoEdi44xRtEG06lMHtCu6S/JOVwZJqo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nm2SY7FzwFqykW7m653O3ENCHQ2DRkYf00q5RpXh10QvIOV6orM4P0MDzNVluy6YK
         ABaagiMPsJCNQyGXdOhICNPua6gCQtg0TFUrRCNNJKIaEkbYdeR+RN1nphZsX8r+0h
         BNxqQvVXQnkVEIL2CS3Z3DJV6GG3mamVFKHYu0vQe7kLoEXRgJslNpXpc0RLP2cXaU
         Nd8Kp3XaEbdsmJszFBVIeJTNnw4OsOdREFIPlTPyTeNmi6QnxJGCKnlc6UHaTK0EQS
         6Z8cM25cQ+21b2CpaLVRUgkTLhMn/ZWmhzKVS/cjNqiaKykW1gRZuBMrAh73HozG4F
         7WyU45OfayObQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v2] clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
Date:   Wed, 20 Sep 2023 10:14:11 -0700
Message-ID: <169523004950.2665018.1185201202790611677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <1693474133-10467-1-git-send-email-quic_varada@quicinc.com>
References: <1693474133-10467-1-git-send-email-quic_varada@quicinc.com>
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


On Thu, 31 Aug 2023 14:58:53 +0530, Varadarajan Narayanan wrote:
> IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
> This must not be scaled based on the requirement of
> dependent clocks. Hence remove the CLK_SET_RATE_PARENT
> flag.
> 
> 

Applied, thanks!

[1/1] clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
      commit: ccd8ab030643040600a663edde56b434b6f4fb6c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
