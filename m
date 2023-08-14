Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1577B024
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjHNDZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjHNDZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ADDE6D;
        Sun, 13 Aug 2023 20:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C66E627C0;
        Mon, 14 Aug 2023 03:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B283CC433D9;
        Mon, 14 Aug 2023 03:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983513;
        bh=d6SfdTT0d81miRczCrfduf5niAE7sKcxyMBLpdQB55c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CC36m/Jv3Lw0rqSQPDTVDwg4p4GyGCDtcD5ivFn6CQv1zCz1kHkwZ9iXz7T6gWifd
         L2isvigjtAV4GCJ2U3NSs06e95tTCvsUsKuIz9TvofR+GuWowuD5rCpHSmgLD8wb3q
         Z0w03/YvhzWqcZfxnsCbuEQ5N/GL/KvkCP9HBx3spJC7D0N8CHjTy00+cUGytL+6K+
         pqlsey8K/hUbpkupXVpGLvM69dtsxu62/RV9ae0wEVlnDjvrzq+s5DIPNfPPZxsQhd
         phIZX7XX85U+qUJnUUP5vhJjdjYe01su3bskmh/bQIjMtXHY65p68t33dcoKZQjPed
         aYZDSJ3Hm6lCw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_anusha@quicinc.com, quic_saahtoma@quicinc.com
Subject: Re: [PATCH 0/2] Drop the mem noc clocks from the IPQ5332 GCC driver
Date:   Sun, 13 Aug 2023 20:27:42 -0700
Message-ID: <169198364306.2443702.8402512633493071282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
References: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jul 2023 15:58:05 +0530, Kathiravan T wrote:
> Due to the recent design changes, all the mem noc clocks will be
> configured by the bootloaders and it will be access protected by the TZ
> firmware. Also there are no comsumers for these clocks in the kernel. So
> drop these clocks from the GCC driver.
> 
> With these clocks removal, remove the gcc_apss_axi_clk_src clock as well
> since no clocks uses this as a parent.
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: ipq5332: drop the mem noc clocks
      commit: 1784d031ef1f329bd362343a8fe1c083116160af
[2/2] clk: qcom: ipq5332: drop the gcc_apss_axi_clk_src clock
      commit: 90d5c043dda7901065e9da4b23967903640fd2ea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
