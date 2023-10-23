Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B707D2BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjJWHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjJWHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1801D7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:49:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C1CC433C7;
        Mon, 23 Oct 2023 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698047385;
        bh=Z7625dXSwNAIWJbpV0miy7cQjxCDQhBKrpEH6/RCiGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxnFg/NwZYy5E8q3I1ENeLf2kNwEL2cxWcPPRytCSFoiDj7IP3kC/gyn9uCFjgXJp
         mxBekediY3Y+zUv6LXj+tz6Vv0riljHZxEQVA4bnKE5MDq0QH1Sd3j3zk5UIbdPJCO
         xtTPvMWhjaY+sEkf1k8dP07Yv+frHdKcpGmebn87j3/30MBOb8p0TpU8UHWa+ckq2Q
         qGP59GFdjyMmehFz0ZZUL5AjW1LQx9Vdb5qCuxpGJ62wdqFnUZ/oSnHR2wcVduFLuI
         cf3nk9+bTSdo6Ztrwejj6nJ75QdMaGhRfk1RPSk8guZwHEdB7gJzOt/rnLcC8dwnVL
         3Y0RCOB7kv/bA==
Date:   Mon, 23 Oct 2023 08:49:40 +0100
From:   Simon Horman <horms@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] sock: Doc behaviors for pressure heurisitics
Message-ID: <20231023074940.GU2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-2-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-2-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:00:25PM +0800, Abel Wu wrote:
> There are now two accounting infrastructures for skmem, while the
> heuristics in __sk_mem_raise_allocated() were actually introduced
> before memcg was born.
> 
> Add some comments to clarify whether they can be applied to both
> infrastructures or not.
> 
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

