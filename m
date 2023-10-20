Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E847D0D83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjJTKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJTKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13C124
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8303C433C7;
        Fri, 20 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697798424;
        bh=UrcYS+ZaQOX5RRsIuEqjxnymUeTFytovx7cOTsprRGc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E9dVDyGmZX2O/ToVdDsq4NTe/B13WwzisCBsle7UyOFV8IHEsXlYUX5Xq8EJ8dWic
         O82T4R8To+T8BW9G6lLdrd5NLnRiYvWlPFgoboYlef708V7asiSNwXQVfM9vsy2IYw
         6CRrT5b/AFeTd8AadQoEZakclmG4eoSxgxB7L45pKhhmQIdSIZkH0ufAYy33dQz/la
         bHzpe4rjB6yac/P/lrtVjW9nnoiw1zcCPMnP5PAbOAzAU7BEcd0+JrwX7ZwaBXz3Ge
         RlNBgvH+YBoeTWOAQVd1bedl4+SsArXxWZjxBZnqteBxsqZQhdQ7sjIepZbxZfvurH
         OSlvY2HSR3vcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F6B3C73FE2;
        Fri, 20 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/11] devlink: retain error in struct
 devlink_fmsg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169779842464.30774.4987417905807311634.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Oct 2023 10:40:24 +0000
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     jiri@resnulli.us, netdev@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shannon.nelson@amd.com, michael.chan@broadcom.com,
        cai.huoqing@linux.dev, george.cherian@marvell.com,
        danieller@nvidia.com, moshe@nvidia.com, saeedm@nvidia.com,
        aelior@marvell.com, manishc@marvell.com, irusskikh@marvell.com,
        coiby.xu@gmail.com, horms@kernel.org, brett.creeley@amd.com,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        idosch@nvidia.com, petrm@nvidia.com, eranbe@nvidia.com,
        ayal@mellanox.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        bpoirier@suse.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Oct 2023 22:26:36 +0200 you wrote:
> Extend devlink fmsg to retain error (patch 1),
> so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
> and finally enforce future uses to follow this practice by change to
> return void (patch 11)
> 
> Note that it was compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/11] devlink: retain error in struct devlink_fmsg
    (no matching commit)
  - [net-next,v3,02/11] netdevsim: devlink health: use retained error fmsg API
    (no matching commit)
  - [net-next,v3,03/11] pds_core: devlink health: use retained error fmsg API
    https://git.kernel.org/netdev/net-next/c/47957bb3f783
  - [net-next,v3,04/11] bnxt_en: devlink health: use retained error fmsg API
    (no matching commit)
  - [net-next,v3,05/11] hinic: devlink health: use retained error fmsg API
    (no matching commit)
  - [net-next,v3,06/11] octeontx2-af: devlink health: use retained error fmsg API
    https://git.kernel.org/netdev/net-next/c/d8cf03fca341
  - [net-next,v3,07/11] mlxsw: core: devlink health: use retained error fmsg API
    https://git.kernel.org/netdev/net-next/c/1d434b48495d
  - [net-next,v3,08/11] net/mlx5: devlink health: use retained error fmsg API
    (no matching commit)
  - [net-next,v3,09/11] qed: devlink health: use retained error fmsg API
    https://git.kernel.org/netdev/net-next/c/18256cb2d4a0
  - [net-next,v3,10/11] staging: qlge: devlink health: use retained error fmsg API
    https://git.kernel.org/netdev/net-next/c/3465915e9985
  - [net-next,v3,11/11] devlink: convert most of devlink_fmsg_*() to return void
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


