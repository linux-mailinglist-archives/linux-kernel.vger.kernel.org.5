Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C737DBC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjJ3PC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjJ3PCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3627E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:02:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC11C433C7;
        Mon, 30 Oct 2023 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698678168;
        bh=HZ3Ha4rMhluR/cnIvD4+pZKPzbOWuqqbVllRMsRZcNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b90S/syrmiFfKANW1rMs6SDRfIVVQqjZZxL7UiiJksBYlm9MTD8zenrtE70wqr0BD
         LhZoBkxLKim2fybQa9nrVdd5MdYlV2aLs7RkJJ5dpNuwayc7Cl7taCAnM7jNRMqG65
         FGYfgLunpPsD9xmP8jsRumpV5xXBP3Dw5SwwgHSdVzMqntVNXtvGjrq5ZaxqNiDDaf
         hAVeFtM+dTqqdhSSHHSkab/Aqzn5PIsqFxwZluHqGFLRsdboDRAiQTXmUmYK8oDzna
         O8rTWHvU521mPhLxfZwtqqrHiyIYw9+vsEtpHPB6v3OxJ3IHq8AgmRt0issMqOaNQS
         aUBksnbFS2nMw==
Date:   Mon, 30 Oct 2023 09:02:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-tcp: Fix a memory leak
Message-ID: <ZT_Flc9XuDdB9clo@kbusch-mbp.dhcp.thefacebook.com>
References: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:49:28PM +0100, Christophe JAILLET wrote:
> All error handling path end to the error handling path, except this one.
> Go to the error handling branch as well here, otherwise 'icreq' and
> 'icresp' will leak.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, applied to nvme-6.7.
