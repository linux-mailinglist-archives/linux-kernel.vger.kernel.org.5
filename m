Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA27684DB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjG3Kwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Kwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC29CF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE8C60BED
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2324C433C7;
        Sun, 30 Jul 2023 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690714363;
        bh=L0/B2pwlAtd2YgE4g+cGWSdLmLx7xZyE3P9pMCFiAY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5RyfES8dyv7/I1/iF9BsbR+u3+ZLu+hoM4q9wzg6qHiT9Bpq3GeesQntP4blN6tk
         xO5BmUE5uFSMDPrRC4ebZJONXej1rHSnyoQIm1CN3TvVBTSNF4/owVf3SCfz9sR5AV
         8l30wAiDcnGU9bSbhb841QHjK8dCEK9TSs2B1B/3hbxVYFU+dxDItM2PvWtBg9zJQP
         HAnBPzhxYWbsZ/75HnK7bIgV+4wpbTpyNSvN8n5vVChl3LQl9IqFKPP+v3TdBE6pOx
         fJxuLGl3p9IKjERgbcz6yTurpSRAct+iiCiDZD1rMVHLZfmAkT+p7jeQy5KiGggT10
         3WgNkesYys1qg==
Date:   Sun, 30 Jul 2023 13:52:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <20230730105238.GB94048@unreal>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
 <20230726115500.GV11388@unreal>
 <5be7712f.ead00.1899266e0a1.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be7712f.ead00.1899266e0a1.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:32:43PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > This CVE is a joke, you need to be root to execute this attack.
> > 
> 
> Not really, this call routine only checks
> 
>   if (!netlink_net_capable(skb, CAP_NET_ADMIN))
>     return -EPERM;
> 
> and any users in most vendor kernel can create a network namespace to
> get such privilege and trigger this bug.

ok, fair enough.

> 
> > Anyway change is ok.
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Regards
> Lin
