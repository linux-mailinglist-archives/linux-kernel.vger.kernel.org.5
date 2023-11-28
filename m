Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AC7FB083
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjK1CgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjK1CgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:36:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43018E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:36:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544C3C433C8;
        Tue, 28 Nov 2023 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701138989;
        bh=TruzQA9ijzCU2zbGyD+46E6KCqwiAtln/j7kJsrBg60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FMVgunLF50RfIrm4BQGh0C4bVb3RhvFRHFQrt4D03iDtf5X5GyL//dZYTMBQmFG7p
         fNzWJ7YjTKGySwxGga95AsL51D3lkxykZ2ClpWEWGDNk78LZ718AciXBcPzWlcxh/X
         qqrqbFprC4vO8rPtRGZN76pPihUn6VfFviLA7MjR4kbh5vB45Pzv+K9lVTCRFWT5ZW
         3J+wR3reWEp2ZAQ9yV3JqfEHsBiegKa2EInyYjhX0n7v/wQWXxgp7XtIhv+2EOKq4p
         qravmIgd9HrhTRJkEx0HcAp0LrJrUuzzRzNCJ/qbi208Yii+eJKb6QUTQSeKfjJKLB
         uoJL8fyfkapAw==
Date:   Mon, 27 Nov 2023 18:36:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <naveenm@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: Fix updation of adaptive interrupt
 coalescing
Message-ID: <20231127183627.0bd5677a@kernel.org>
In-Reply-To: <20231127052811.3779132-1-sumang@marvell.com>
References: <20231127052811.3779132-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 10:58:11 +0530 Suman Ghosh wrote:
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch fixes that and also updates
> tx packet stats which will be useful when there is only tx traffic.

Doesn't sound like a fix, more of net-next material.

> Also moved configuring hardware adaptive interrupt setting to
> driver dim callback.

Also this should be a separate patch.
-- 
pw-bot: cr
