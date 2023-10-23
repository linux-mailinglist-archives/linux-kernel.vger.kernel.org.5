Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4B7D3CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjJWQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjJWQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:52:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC312DB;
        Mon, 23 Oct 2023 09:52:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA43DC433C8;
        Mon, 23 Oct 2023 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698079956;
        bh=jQgUixbQL8W4wAwTjcJl3cwhkO3yCkXNSDqf574oSw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBG7jWc4h4+fJDaiS4Q/CaPIup2hO13Tne4/anTf6UAPe6fxoRMMivAn2M6uJKvgy
         UrF4/gVI4IKFQbsAjygYKrjiUsEO9xHDnPLTl+cpgcYVDVk06QXpyak5mpqkBqoJU8
         GMx+vshWWycWKcQU2nt0uL1VRjF83xSANNNOjYo8TM16Yn3Ra7K7URTRSIaWTUMv7O
         3MkHeReIqsYdpYLmdD5PSyY4Uwske+NxTwOF2+KalNpMLM8R4UHrVahaxS2uEKIz3+
         XpoEBCZQSyHPgDicSnvGFJC/bgMAOTi9Asxx8J2JAT0TWqOBe2HQaM+d8HdcJfJ3a/
         lYe83bQx8Gi+w==
Date:   Mon, 23 Oct 2023 17:52:14 +0100
From:   Simon Horman <horms@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] igb: e1000_82575: add an error code check in
 igb_set_d0_lplu_state_82575
Message-ID: <20231023165214.GX2100445@kernel.org>
References: <20231020092430.209765-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092430.209765-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:24:31PM +0800, Su Hui wrote:
> igb_set_d0_lplu_state_82575() check all phy->ops.read_reg()'s return value
> except this one, just fix this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Simon Horman <horms@kernel.org>

