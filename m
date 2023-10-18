Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566BD7CD1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjJRBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJRBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:15:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2AB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:15:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6205C433C8;
        Wed, 18 Oct 2023 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697591745;
        bh=txh0CUFBNNdl/1yV+ubQIc1v2meuc+g1RlL8IiDVMtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eB6fL6g3DGYiyQGzTY1ORMxAdBrTR6uHsE3B9mOurD0ARmEgYyOAbNYRhA0Br/n/O
         G8YBo3OqTB0qsSPtyY4rtU79sF7NItMU1y8jwC3KvLbq4mAWGNFXZVFnDoVFvNrWxn
         N5s5u8A3XQv8iln5pVP2MauYrlUWiFBGMt+xlxV8RYNNt9OGtglfX5J5QrQ6sfXEJz
         c9HoHkDMIl0cfoMguW7IS1pLx76c6ii4sza4IWawT5OLU1MiwJxlFY57yRrNyzo6dT
         DCIBiwJKL6cQrAD43ScrbE9+hLup3aGtiRPLQ6d2OK6IDSy2Ordio/ap4XEo/kP2w+
         qpHRncobsvwtg==
Date:   Tue, 17 Oct 2023 18:15:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>, Benjamin Poirier <bpoirier@suse.com>
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <20231017181543.70a75b82@kernel.org>
In-Reply-To: <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
        <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 12:53:40 +0200 Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.

Humpf. Unrelated to the set, when did qlge grow devlink support?!

Coiby, do you still use this HW?

It looks like the driver was moved to staging on account of being
old and unused, and expecting that we'll delete it. Clearly that's
not the case if people are adding devlink support, so should we
move it back?
