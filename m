Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25187F0756
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D62115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:12:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E07EC433C8;
        Sun, 19 Nov 2023 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700410320;
        bh=FviOo4+HTPFpVUCgfNxlIvuh0YvLmOQEGbiuswYPjOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlud+6eA3nh0LxIPG/wYRVifl43OK984NNQfehKMhpfQ2AaXlAfGHo/1bqMhoA3fJ
         FIzTXm2vfOD46JEkF3btnF6gUe/LBr/415OkV/F8DJ0tKxCPCL5Kvj2nlz/2LeH0Fc
         H5jsthlTQasv8tVnep5+g8Yuiz2TMdgGMpbqDlrwT+BEk8FdxJOe8DgkNavmJ6bQPt
         vPBmUJKR+8oslKAioo+epMfJj5vkOMrBxnXKEGgdIlho0uCpH8TNBHAcStvWb6X+NK
         arxVOLFH8+rZeDto2k2VBiaogj/OHGT2zTJgYayXvTd2Hgs6JObeXqoRidr+ad/Dml
         KtMYFSVWP5k1g==
Date:   Sun, 19 Nov 2023 16:11:55 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v2] octeontx2-pf: Fix memory leak during interface
 down
Message-ID: <20231119161155.GB186930@vergenet.net>
References: <20231117104018.3435212-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117104018.3435212-1-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:10:18PM +0530, Suman Ghosh wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Updated fixes tag

Thanks for the update, this now looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
