Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD01756298
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGQMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGQMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:18:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A23187;
        Mon, 17 Jul 2023 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n3/NLzthO8nFAChycRfPzWGbiyc6k+gcSfvI5EWt610=; b=TvhtZCv/FkWYN5C00HB718zp9W
        ealOzyLlpHG6UKdasOxE3IFuwOZwB1D9pQ7JfCxqfreotz3/Fpt5EDmEVq+6td4Y0i82FdGHQUotI
        HWelNAfJIeXkE7OXwPirytGna47GnzJpYpnw4E/1VDTV+KeTAuAeCxogzNO6q8xGHdNCSje0gwIH0
        QmWUVwCEj+j6GdB4pDIfOTjthMn43KDOQYhC5QNeb2DqCA3huJbNlE+SDw7J9ZfBzAsVJyIcl6GkW
        zk/sv9dFE1LivheXHRnvtoNAc8qT3M9QL/ZDY41CF7a35bjsJWd1LvQLg7cGEbvq1fVEB0KzJf8I7
        1ehuWzRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51890)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLNB6-0003ru-0k;
        Mon, 17 Jul 2023 13:18:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLNB3-0001uG-Ch; Mon, 17 Jul 2023 13:18:09 +0100
Date:   Mon, 17 Jul 2023 13:18:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Minjie Du <duminjie@vivo.com>
Cc:     simon.horman@corigine.com, Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MARVELL MVPP2 ETHERNET DRIVER" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] net: mvpp2: debugfs: remove redundant parameter check
 in three functions
Message-ID: <ZLUxgSioFUjERay0@shell.armlinux.org.uk>
References: <20230717025538.2848-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717025538.2848-1-duminjie@vivo.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:55:37AM +0800, Minjie Du wrote:
> As per the comment above debugfs_create_dir(), it is not expected to
> return an error, so an extra error check is not needed.
> Drop the return check of debugfs_create_dir() in
> mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
> and mvpp2_dbgfs_cls_init().
> 
> Fixes: b607cc61be41 ("net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs")
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
