Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC27686AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG3RZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3RZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCA126;
        Sun, 30 Jul 2023 10:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EA860C95;
        Sun, 30 Jul 2023 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ADAC433C7;
        Sun, 30 Jul 2023 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690737945;
        bh=bh6u2MzpdMnVE6tLD8Ry8Qo9sUET08WImS5mG9hAsUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3DYeWUxkkTtvJPmLrvSEdvr6G+VBhrYIDWO+DlnsJN8cLlwTChpbSrNyyMSBjP0l
         3Eg4ZO9P+j4YuMDnAfPexv6pDEG9GzKoXseXB1GT7ZLP+/MBzuTM9EtNO9eVxUeddc
         OFrqIKtF8ZuWzVvvIy7igqCoo5nsLiQXzSIRySt7kGTe3YrTghhdQzDCoF2ZKkXwXh
         +VWqz7VbLI1eUq/BqA4FTGFeHqh2iGQaw+jMrUJajudaYRDiVmTGBkmdq2gShkCXvZ
         kn1sj7nzZKdWDcfeiuSzU5hazyKAnYWxnRYQ9gWjcq5BMB2EJ3E/5TGl3dQLqVv98A
         H+vSi/e6FIMfA==
Date:   Sun, 30 Jul 2023 19:25:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
Message-ID: <ZMadFUMmqgVXvjMe@kernel.org>
References: <20230729121929.17180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:19:29PM +0800, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

