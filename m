Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B8755AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGQFuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGQFuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0710E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA1060F28
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A20C433C8;
        Mon, 17 Jul 2023 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689573008;
        bh=pgl6PJoOSONOm5ZYiNl1/zgwYMgt+PVFhF2XdFTsRmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drfHxyfpLBlexRaMzwD9vdni2tKVQrVyWjmJvOIaIaC570HF8AEPx+DyyiiGtpLXz
         ZaLQQEbtjlNnsS+0HqVSwroADG21yK5vBCK34CjPee33i4hzAt6mlv0GZspiVC1S+t
         a51cxJs/j8CriNkDmRX/IcSzaktKqC0BNjQ+T3S1bKeFbCNe3ku3krbEMARFPHiaRG
         rvW0mKAGG77yyBvKmofS+STs8waUaACFuLqgh5hcjBRb5WvUQMy+4VJAJlAukxf/8/
         9B4Jp3LrbtuA6KoKJzTQwC9/hGBj9XCsRdKiemsQJaXyvxkDAgLSEG5honTsPA7UrK
         S2TEBI9TS7xCg==
Date:   Mon, 17 Jul 2023 08:50:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH V2] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <20230717055004.GC9461@unreal>
References: <20230716182649.2467419-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716182649.2467419-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 11:56:49PM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v1:
> - Rebased the patch on top of current 'main' branch

And how this patch is different from another which was sent two minutes before this one?

https://lore.kernel.org/netdev/20230716182442.2467328-1-sumang@marvell.com/

Thanks
