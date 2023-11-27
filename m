Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B27FA897
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjK0SGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjK0SGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:06:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4A8198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:06:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951BCC433C9;
        Mon, 27 Nov 2023 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701108401;
        bh=SXk9TLrwLgA89r0jB1vEwVRH5/KUIw8Zo/Yl4z5i8aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WTllf2c1P+/VCxnAZyt0dJ2ZWye5KhMZHmjnEfgbaJzDY6/gy3B0Wht68/UXA9Wpd
         Whn4CgI1lV1q1c2XJTsQW3hRIkfkhwFZB7a5s0PFPNEtNdfbopZenbA3oGS6cfZU9S
         /F4Mro6jJe5ltMEUuRo7VkIhis3M4oGsJ71lWsOkejDi2HX65plhJDKSm6IFiNCYEE
         xMscVCvaYXsxCCfF9s5Bqu5HvEwCKa2YkMVmoQEEHfymuoVeXf6iSXNhtx/hubpbZz
         dOszSU4xj4q2V6CQpWjy+aUN1RHyKdg1YCaCa3UB7qxY9WoacNhzH+9muL9bk7C62q
         uttN3Qv44zL/Q==
Date:   Mon, 27 Nov 2023 10:06:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@microsoft.com>
Cc:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231127100639.5f2f3d3e@kernel.org>
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
        <20231121154841.7fc019c8@kernel.org>
        <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 09:36:38 +0000 Souradeep Chakrabarti wrote:
> easier to keep things inside the mana driver code here

Easier for who? Upstream we care about consistency and maintainability
across all drivers.
