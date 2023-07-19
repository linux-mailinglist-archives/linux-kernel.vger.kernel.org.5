Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE6758B77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGSCog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC77FC;
        Tue, 18 Jul 2023 19:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3963E61689;
        Wed, 19 Jul 2023 02:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF1AC433C8;
        Wed, 19 Jul 2023 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689734673;
        bh=i6ODCpZdw7yLI/3Tk1F1jRRURwyjESiWyE6EJzeWL4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GyXCHH1o6MXRYbpwlAWo4bDRRNaRqreFxfEWh0bv1gqA+vFzisAQkWBWtkkR2rolW
         S+i0qIHgWdTNZOoRGNoPF+EkIPIeORj7roVfF68SIRnaPCRBM9ijv6lefLhqZRByyC
         Xg8WIpkO+pv0vXIEaolUwgguTnnrLcBu9+M0oqRMf6AN3TjxSY7OcUDV/bUSUPnnq6
         QwAX0DgHnxeHhs8/50NznKzCII/5A6/lY3ly853LXskuA2qmcOj22UfMuGtcKXNzLr
         m8b96MtnZlVYnKNLUyLsHeAkHgpWGeDSopECi2I75Fgeky1JzsvHjJinJfTYCXRffs
         TmUnKrM3uaIqg==
Date:   Tue, 18 Jul 2023 19:44:31 -0700
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
Subject: Re: [net-next Patch v3 4/4] docs: octeontx2: extend documentation
 for Round Robin scheduling
Message-ID: <20230718194431.38c02846@kernel.org>
In-Reply-To: <20230717093319.26618-5-hkelam@marvell.com>
References: <20230717093319.26618-1-hkelam@marvell.com>
        <20230717093319.26618-5-hkelam@marvell.com>
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

On Mon, 17 Jul 2023 15:03:19 +0530 Hariprasad Kelam wrote:
> +4. Create tc classes with same priorities and different quantum::
> +
> +        # tc class add dev <interface> parent 1: classid 1:1 htb rate 10Gbit prio 2 quantum 409600
> +
> +        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
> +
> +        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 32768

last two rules should presumably have different classids?
-- 
pw-bot: cr
