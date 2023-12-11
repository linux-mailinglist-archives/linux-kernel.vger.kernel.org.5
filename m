Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541980CEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjLKPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:03:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F954AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7FAC433C7;
        Mon, 11 Dec 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307042;
        bh=51NDDSCHIGZloICs3aR7G9RVWbUodymkhQPcRylmBxc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MqC2AbIlfT3kQCMaUHNlyu73kZhszyPF7xjuulKSLUeNuWnOxRqAa1zqVqb3fIVl3
         fot+C+rv5jW7VECNNO5/yH5IkSaW9qSoUzTjDWKevr5c0EXK6tdO+HT6NNLYVGkNRR
         0k8EWWUGzcB0wzdD6VuZpF/BdENmiF+WbOEuiz8TUBOs0WFXKA6hcBQ64Q+D6T7z2w
         g5dLNGL/crP7YIotTklAv+1bhVlSfZT8PDeFT1CF8GjDhtBfGjo1zhP1yCCAbrcpOf
         AgSGpwHqvVTBa21G2dczDrSXb3jdUIztRmjEBww5kEGzMCkKzNH/U4xxvt1dU8KUFr
         4ANsglQHb8Y1Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, 'Guanjun' <guanjun@linux.alibaba.com>
Cc:     jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de
In-Reply-To: <20231211053704.2725417-1-guanjun@linux.alibaba.com>
References: <20231211053704.2725417-1-guanjun@linux.alibaba.com>
Subject: Re: [PATCH v5 0/2] Some fixes for idxd driver
Message-Id: <170230703837.319897.17521835974677440707.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:33:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2023 13:37:02 +0800, 'Guanjun' wrote:
> As we talked in v1 and v2, I add fixes tag in patch 0 and change some
> descriptions in patch 1.
> 
> Hi Lijun,
> According to your comments, I change the fix tag to commit
> eb0cf33a91b4(dmaengine: idxd: move interrupt handle assignment)
> 
> [...]

Applied, thanks!

[1/2] dmaengine: idxd: Protect int_handle field in hw descriptor
      commit: 778dfacc903d4b1ef5b7a9726e3a36bc15913d29
[2/2] dmaengine: idxd: Fix incorrect descriptions for GRPCFG register
      commit: 0c154698a0fc32957d00c6009d5389e086dc8acf

Best regards,
-- 
~Vinod


