Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E27CA69A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjJPLU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:20:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18A8DC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:20:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD7C433C7;
        Mon, 16 Oct 2023 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697455253;
        bh=16AKyUtoR6pajVMK2yQqNyWfjYnlASTn9I445Ew14Ys=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hkubut12CrO/Qcv23mT30wM0jPVRvGJc37oVA6Pm04PApR1waoyd/uMTC0fmO/w9Z
         7AhQXLhcAYZpN80ROqCLJHFP3zuc/kEHxw3Ioccydb0BLDE+6vJaRAv9jf0pteXZJd
         tPFGleEVYr6Re0Kve0mlP1B+hDVVpy5wW3bFBjdmmmz9PCt+pubXLkM0CAoLxz/7be
         eVfBgHLNcJxPTsuA1koDBbp8zqfKNym6yH9x4pL8p+g5AY4YLPypM2/M4+3u3FBNNY
         szGy52OO4whI96ILxhyoBOwpFOQwhs5Vxep/HYZkzsFGm01VC+SErtA4+lBlmZCJQG
         r8awHMLd2hnYg==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20231013010812.114216-1-yung-chuan.liao@linux.intel.com>
References: <20231013010812.114216-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: improve error handling for clock stop
 prepare/deprepare
Message-Id: <169745525118.217856.10954000456240343694.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:50:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 09:08:12 +0800, Bard Liao wrote:
> The same logic is used for clock stop prepare and deprepare, and
> having different logs for the two steps helps identify problems.
> 
> In addition, when the "NotFinished" bit remains set, the error
> handling is not quite right:
> 
> a) for the clock stop prepare, the error is handled at the caller
> level, and the error is ignored: there's no good reason to prevent the
> pm_runtime suspend from happening. Throwing an error that is later
> ignored is confusing.
> 
> [...]

Applied, thanks!

[1/1] soundwire: bus: improve error handling for clock stop prepare/deprepare
      commit: ff435da4cc8b6137be9f0b6b4a9af095590d4b8c

Best regards,
-- 
~Vinod


