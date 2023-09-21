Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715FB7A9804
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjIUR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjIUR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54423A9E5;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26713C32784;
        Thu, 21 Sep 2023 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695289087;
        bh=C4un4gYxCr/CUvb+/OQ1fTPtd4znlJYmidwWhyiPGtU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d0HpfYzobyg8jx7fPPVL5WntNltqZx9usHaRcy9vjWuXQGA/nvs9gFdsiBwYJD91m
         0kr/oaqLLDtvrwDqEeE0CUCCjaLRp2s53UbI2pkT0vF77i1RqpZMUMh28EWlkUZLWk
         sUGmAnhIxapCI9JT1zJK7W5snh2t0jOKajrHK1g/UL71wdMWy/NgAVyHjxp7e3BJNC
         3/X+PbMykegQr0QQhurtrXO3Wc7AdeSDDmfxikFC4pQcVWN12lfceRi75O8gqjBkeX
         h9pXlDTofyeq0S8DWpT/mL73Iw1LT3v5NPBtNyImpod9dbH6BhE7/v3c8+sJN1p5CU
         2drPD/S3ahN7w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230721164901.2155287-1-quic_bjorande@quicinc.com>
References: <20230721164901.2155287-1-quic_bjorande@quicinc.com>
Subject: Re: [PATCH] soundwire: qcom: Log clk_get("iface") failures
Message-Id: <169528908579.97319.3591383647900607937.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 11:38:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jul 2023 09:49:01 -0700, Bjorn Andersson wrote:
> Failing to acquire the iface clock makes probing of the Qualcomm
> SoundWire driver fail without providing any indication to the user. Make
> the driver log the error to aid debugging system configuration issues.
> 
> 

Applied, thanks!

[1/1] soundwire: qcom: Log clk_get("iface") failures
      commit: 95b0f3aa71eb09d067d89395fdb7f2dd87feae18

Best regards,
-- 
~Vinod


