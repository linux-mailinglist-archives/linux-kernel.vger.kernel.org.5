Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660328025DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjLCRBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:01:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECBD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:01:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C8C433C8;
        Sun,  3 Dec 2023 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701622886;
        bh=3grxlFh5smxHqqrzAwHvqw9F1PRF28tWTzgvpQYBhuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtqRwNIpS39RsbxeS8z3aeYK7U6qw6Ny4NPIiBnQyXDZ+7DVKupKzP0zHFSeqPigw
         gbJG6Y6aM3zK3ItakRT5d43r418tfyXUya8G60YCfowbd0WMiir2skSRFlMBU7pLEB
         v6AnBsVcXynl4XnWeQbpVKe057+NemJMARpz09/Lz/g/nA2VkCZNHF6j0Cof5D9lEY
         IlX5HSKvMOLkGQMWU0qS05WuvncF7T4Q27XZ9oAvQsSk6cy7wFzyDBkDR9Hb1QQ1Xm
         y5s39K4Bt6YHGdU/55o9rU8cFJy1sBnfct40RrrL7kmPXRgEqze9UgAepvPEhycy3h
         oaRbU2Rc6B3Rw==
Date:   Sun, 3 Dec 2023 17:01:20 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
Message-ID: <20231203170120.GM50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-3-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-3-gakula@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:28:15PM +0530, Geetha sowjanya wrote:
> On latest silicon versions SA cam entries increased to 256.
> This patch fixes the datatype of sa_entries in mcs_hw_info
> struct to u16 to hold 256 entries.
> 
> Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

