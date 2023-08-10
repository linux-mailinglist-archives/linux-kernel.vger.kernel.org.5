Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7083777AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjHJOeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjHJOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF1268D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC4A61E5D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FCFC433C9;
        Thu, 10 Aug 2023 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678059;
        bh=7Vwhp4p/XB6mca/2Nq2iQ1Eld7O1WIHV1khXbXPaM64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SC4wvhTAHNe74sHM1qaMTBG6OiQWGsAjGsQ1lWQEBEzeN1QsPl9c6Sw2LBaXtSLiQ
         6iQnX2rDWiDmLLVGFzHxXrPSn50rELJw0s4FTeg8nwmQux+2uDwyD7zoc+I2OawE5Z
         dVSB7DevxAR3Trkbz2SNetx6+FbxPnR7FG3LMar2RGwHjC/9cmgNSmjoJYgPds02ni
         Y719c2GCoRkPMRbnQ4fZpL++XX9VINvelML1OLdbgCQbqnzkCIdP0fddmGWH5wJDbJ
         QYKxI8xwkZM+NpgAswrAfyvCeBxIZNitNdxlkjqMBTbd/MxV1CXS21JS6AuL0T9VqH
         WYDvd+hBLDxhA==
Date:   Thu, 10 Aug 2023 16:34:14 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next] octeontx2-af: Harden rule validation.
Message-ID: <ZNT1ZkWtLDg5rOnr@vergenet.net>
References: <20230809064039.1167803-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809064039.1167803-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:10:39PM +0530, Ratheesh Kannoth wrote:
> Accept TC offload classifier rule only if SPI field
> can be extracted by HW.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

