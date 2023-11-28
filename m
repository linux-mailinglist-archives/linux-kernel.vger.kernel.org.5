Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229A87FB673
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjK1J6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK1J6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:58:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CA1A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:58:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D01DC433CC;
        Tue, 28 Nov 2023 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701165524;
        bh=LcD+ldJkLkGq0ZEQhTcLuS/VhjTh8l+OCqrr7fSArpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tkDLR5C3UywF0mRe344TagJiExVImW2+HXTOqoplnlCrUQo5sdUm1i9DjueHX3YDz
         3nv1aMCXbt4hN/PDbPWVrWxN1wPWaqDWikrnZrR3BYARa7jLvPwPJaa1fwNhmG4OEI
         Ote3rT5wZ/OEjNeIyZ8HWo9GFL0HxXp7CrAOd+eDxdass5Hqd/XrchHswiCYAVeoHo
         A/xNwhLHpDH4AJwwR6zcOmVnLDZ/0ehnVsajl8QVNZo6zZxYtL5YOW7IGi7ccBuV1t
         16ckgqvFfB5BlajCu27yvklYUCO5t/iVTn7hsOuhQgasPvV4AgE61DwzbNt53OIfkk
         XSufqXVZPvF7g==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-sound@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20231127124735.2080562-1-yung-chuan.liao@linux.intel.com>
References: <20231127124735.2080562-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_ace2x: fix AC timing setting for
 ACE2.x
Message-Id: <170116552221.73476.13450222254446640671.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 15:28:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2023 20:47:35 +0800, Bard Liao wrote:
> Start from ACE1.x, DOAISE is added to AC timing control
> register bit 5, it combines with DOAIS to get effective
> timing, and has the default value 1.
> 
> The current code fills DOAIS, DACTQE and DODS bits to a
> variable initialized to zero, and updates the variable
> to AC timing control register. With this operation, We
> change DOAISE to 0, and force a much more aggressive
> timing. The timing is even unable to form a working
> waveform on SDA pin.
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_ace2x: fix AC timing setting for ACE2.x
      commit: 393cae5f32d640b9798903702018a48c7a45e59f

Best regards,
-- 
~Vinod


