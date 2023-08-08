Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D96774E19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHHWPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHHWPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53DFE51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FC962DA5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F0C433C7;
        Tue,  8 Aug 2023 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691532934;
        bh=hlPqlxQlzDRRFtRMjpUQOwGvFZHg26ls07TFrTzOkS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oR74k4cd44FBGrLFr9vZeD3tpDrOcq+PEeiPlDZFqLMwYXY2AHmKyOznht5KNXzt0
         SXUfqZ3ACCn4/lfvCrMebxupp8pVFwgmpAn16mbTkk4HHh0aeXOfBBrftQys9qNave
         zvCjvum6C7AI3j0PNTibQpt72FedazM+qREJQ7VQS7zsbwX6pFyWmwm7n3r7wEJE2l
         fTrAtA1hNMDOuSHQhGKYjaqf7bmGj+TeDQIyW4KZpG8TfUwfjKdIjIJtdFx3yAJq9q
         LP3zxxfCBvCARxPGWzDExD0atbc5xGS6ZY5iXNGd2p6/i2mYDL9rEXVdTEC91HktgC
         M5X/Vr8bQCpsQ==
Date:   Tue, 8 Aug 2023 15:15:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
Subject: Re: [net PATCH 2/3] octeontx2-pf: Fix PFC TX scheduler free
Message-ID: <20230808151533.3085f5f6@kernel.org>
In-Reply-To: <20230808112708.3179218-3-sumang@marvell.com>
References: <20230808112708.3179218-1-sumang@marvell.com>
        <20230808112708.3179218-3-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 16:57:07 +0530 Suman Ghosh wrote:
> +	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
> +		otx2_txschq_free_one(pfvf, lvl,
> +				     pfvf->pfc_schq_list[lvl][prio]);


ERROR: modpost: "otx2_txschq_free_one" [drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf.ko] undefined!
-- 
pw-bot: cr
