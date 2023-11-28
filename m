Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CB7FB096
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjK1Cip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1Cio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:38:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4F18F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:38:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23C1C433C7;
        Tue, 28 Nov 2023 02:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701139130;
        bh=+OSbBnS4vP20UuX2XQA37QRXeVEXzq+hur1Q3s0Vb80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mCFameLSmm/b3mYOMTuAw9k9WZdn3d/OHcLU5VjWb+U8ys0lnwGO5MVtrUTBXrPzB
         YswropNRxsv6OXrtVHUBOcG7RHeipO0J6vEd0hWtD9czfcTA73BNqQa+nbohZcZG9r
         HK4t4L6MzQLTFHfwNlG6lJTmLX8cfKdVwFEORQz1dRbqucnzFS9Mn5WXNY1p8/OGEt
         srum54ahvKy33nvQgjI6rEcnxpxmkSuWdrKRVC5ZkVvaoDoKTW/D8cSradUxWdbLHM
         M8wPzTqmclFkbZ6NIBfLXxqdnaEGQeFsbAVuES5/n4ZYPoupGwWT58grkDe8KlM9wI
         XHJr2pSd/pYSg==
Date:   Mon, 27 Nov 2023 18:38:49 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-pf: Fix updation of adaptive interrupt
 coalescing
Message-ID: <20231127183849.140e8809@kernel.org>
In-Reply-To: <20231127060538.3780111-1-sumang@marvell.com>
References: <20231127060538.3780111-1-sumang@marvell.com>
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

On Mon, 27 Nov 2023 11:35:38 +0530 Suman Ghosh wrote:
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch fixes that and also
> updates tx packet stats which will be useful when there is
> only tx traffic. Also moved configuring hardware adaptive
> interrupt setting to driver dim callback.
> 
> Fixes: 6e144b47f560 ("octeontx2-pf: Add support for adaptive interrupt coalescing")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> ---
> v2 changes:
> - Missed adding the fixes tag in v1. Added the same in v2.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
pv-bot: 24h
