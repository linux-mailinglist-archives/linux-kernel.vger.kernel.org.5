Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD4752FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjGND2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjGND2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DC26A5;
        Thu, 13 Jul 2023 20:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2756B61BAA;
        Fri, 14 Jul 2023 03:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECDFC433C7;
        Fri, 14 Jul 2023 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689305308;
        bh=2xj8F0S6TzwUbEUnsVNE1YC34zaDXKl959eBBMlj52s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J9M4mF9jlTs29Tku+qyUmRi0yvEnNSyQttTlGjlCjm3nIvIM6qvY1GekaAEVY+M54
         Ek8S1m+5OJoc7ZHsJ/sSOiuSDZLDz6KBNDGIw6VV06aR18RAPYnzAqK1pFaFspPLi5
         zLRQdLy8GmCSDN41biWTzUBF6HfAjYaMgrw/6l2VCRQmq109qAUXVPCudZ18Mhs3oG
         DSd8ul0FpLW4wqJgcVKKMDg9pQCEmjVTz2oaOPnkaWT0jHU9gnH0nekSlTxQMJ8eEo
         HwritwpbLXtxHm5wbqDbyKLnyryihOd50frFNT8/nOXeyG3APooRSLQNlgw12jPtOp
         PJUKnH3Sb4akg==
Date:   Thu, 13 Jul 2023 20:28:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>,
        <andrew@lunn.ch>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: Re: [net-next Patchv2 0/3] support Round Robin scheduling
Message-ID: <20230713202826.52cb8389@kernel.org>
In-Reply-To: <20230713060111.14169-1-hkelam@marvell.com>
References: <20230713060111.14169-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 11:31:08 +0530 Hariprasad Kelam wrote:
> octeontx2 and CN10K silicons support Round Robin scheduling. When multiple
> traffic flows reach transmit level with the same priority, with Round Robin
> scheduling traffic flow with the highest quantum value is picked. With this
> support, the user can add multiple classes with the same priority and
> different quantum in htb offload.

Please extend the driver documentation appropriately, there's 
a "Setup HTB offload" section which only shows strict prio now.
-- 
pw-bot: cr
