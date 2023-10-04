Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDD7B8E87
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjJDVM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJDVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:12:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF09E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:12:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB4BC433C8;
        Wed,  4 Oct 2023 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696453973;
        bh=UMkpK8hBnhmZu6SDCnn6+NldPVpXde3GUYG3ar+O4pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qj61GGKAoLT8aQBhpkE8fQcl8WRuwzwUwJhClfjpCgKfNNb8mr8kRzzH0etrJC/Rq
         4rc2WQEpWlvtffsq83jsTASvbJp5x8TV2tgMymVxvn/18vUn7Vnq082VOoMG9834Vt
         nfPlOVSMmoVlSrxr0A0Wox7b3MuHsYum/BpvJPphv0k6FyLg8GDQIRJiNnM7VXxTvo
         M8BSgH1cmX4XnYvllRfczK9nFVOkrJfR3aJOnk9JDfM2BSpR6AVt1CAh/PnbbzbkIG
         hozI2fgP7ivkjyzdYPMr+nm42glxiHu6RR1kuqpG+h/MPq6LL3L4UFU78Aq0+hPU46
         CZVQ3W1QUwa9g==
Date:   Wed, 4 Oct 2023 14:12:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <richardcochran@gmail.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
Subject: Re: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
Message-ID: <20231004141252.49812e65@kernel.org>
In-Reply-To: <20230929071621.853570-1-saikrishnag@marvell.com>
References: <20230929071621.853570-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:46:21 +0530 Sai Krishna wrote:
> Subject: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
> Date: Fri, 29 Sep 2023 12:46:21 +0530
> X-Mailer: git-send-email 2.25.1
> 
> Currently for VFs, mailbox returns error when hardware timestamping enable
> is requested. This patch fixes this issue.
> 
> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")

If it never worked for VFs but worked for PFs - it's not really a fix.
New functionality enablement is -next material, even if the fact that 
it was previously disable was unintentional.
-- 
pw-bot: cr
