Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78BC783ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHVHSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHVHS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EECE4B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7050A637BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E3C433C7;
        Tue, 22 Aug 2023 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688631;
        bh=8j0GmyJHT6fG0NfD1j5R5EkAuxD1rOGMTqcjw9QLvUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMFz5fLqI/oYaZ2pW2uqdsysNFRV428tq091dJD18nKjp76tsQeRod1eTb28ftwtE
         hrOi0IgoFP9+exicm95Bz5WZZJZX86Rto9BQqwhfG9DIPT5NUPC12ZTENG9CgmE9tH
         vwrsaXZluchltL3J0aQ4AuMrP8H0DC//jgCUGWqNF0WsRcZcm0pP8mAmBcneBBpX8y
         Sm+a+kJ7kGhoMChRNUfOcOCLkcIGzugJGt/g3BLNI+HXJQRpGJucozuggKPU1grjY5
         DeRi96lOvWs2Hwjvg8NW0ELmFPIR6i02a/A6x5iczEJbsh1hY0xBJvC0MHa8I7pP55
         zfj7HbWpdPkPg==
Date:   Tue, 22 Aug 2023 09:17:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 3/3] cteonxt2-pf: Fix backpressure config for
 multiple PFC priorities to work simultaneously
Message-ID: <20230822071707.GK2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-4-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821052516.398572-4-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:55:16AM +0530, Suman Ghosh wrote:
> MAC (CGX or RPM) asserts backpressure at TL3 or TL2 node of the egress
> hierarchical scheduler tree depending on link level config done. If
> there are multiple PFC priorities enabled at a time and for all such
> flows to backoff, each priority will have to assert backpressure at
> different TL3/TL2 scheduler nodes and these flows will need to submit
> egress pkts to these nodes.
> 
> Current PFC configuration has an issue where in only one backpressure
> scheduler node is being allocated which is resulting in only one PFC
> priority to work. This patch fixes this issue.
> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>
