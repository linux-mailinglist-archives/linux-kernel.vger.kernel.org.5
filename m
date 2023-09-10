Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF8799EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbjIJOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjIJOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:46:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF699D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:46:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD05DC433C7;
        Sun, 10 Sep 2023 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694357188;
        bh=VZHoP5kYcYyfcXZ35ny5LQtB1CmlcEONkuJdZApsAq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vu/5QLhIOYnS8xqIO7rbRBslzmsH30XEnbqEkTiQvcceTcRlz4YiFQavVfR247kjR
         JpAYHKtSPEy+SiS15N2JUV80YG7S2wPKeiziU4XQl1eM+2WOdprtjPGqeTF9KxFaMV
         07Zws+msdzu1Gdo/tcPT7keO+G5ozcsvyYKeikRGzdS0X0hsr+A5kv/Wf50j4e+S/p
         zWXV2UEEmipgqyypJJyvlxDvZKSH2cT6UYRD/XryirZt4tqpvkMXBlYDYQTxJDtZEu
         S+JOWjbguxbMJM9CrCh1SwuVGYG7vHkT0SApkJWybXTipOiMT6DxJ+8RO6wJEBpLia
         998bfF+BySEQQ==
Date:   Sun, 10 Sep 2023 16:46:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] net: ethernet: bcmasp: fix possible OOB write in
 bcmasp_netfilt_get_all_active()
Message-ID: <20230910144622.GE775887@kernel.org>
References: <20230908061950.20287-1-hbh25y@gmail.com>
 <20230908061950.20287-2-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908061950.20287-2-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:19:48PM +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid OOB writing or NULL pointer dereference.
> 
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

