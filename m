Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720997A36A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjIQQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIQQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA5130;
        Sun, 17 Sep 2023 09:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41FBAC433C9;
        Sun, 17 Sep 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694969423;
        bh=C9gxb6ygGZTrYUONXA9mBq77NHECc+jbe5xlDI++VEo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n7/m2+NMUxNVSPnhpbbe+9yfGzZRUdrN2jQee8HZJB/k1SLiQ56Gfrd9Dukvpzst4
         RU+FKiXsilR4f90uE6IjFPPw2/WXB+LdcDqh6L5Kntft3t/NVaFGpIxckaxkUkn5dy
         7rE/0isBmj0D/GGZgLpDTrJpSTAkA0k6jeB0A1QWXKvDiMnazd+/LeNNFENK2uO/vx
         oK/XtkbhVXe0VIZprphvK3ymhEjDDqfX2pSOKnSPK7dHB0J28pa/zzoeW3BneI5sj2
         cre8n8GBCbtwluui3ws5idgVJagTEzXQBXwbFOv7U8FPEN4OkMvau0aTPAKAsxKKsc
         +QR7Q1CN16AlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 266F1E26885;
        Sun, 17 Sep 2023 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] scsi: iscsi_tcp: restrict to TCP sockets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169496942315.18728.17720146599552391400.git-patchwork-notify@kernel.org>
Date:   Sun, 17 Sep 2023 16:50:23 +0000
References: <20230915171111.4057930-1-edumazet@google.com>
In-Reply-To: <20230915171111.4057930-1-edumazet@google.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     lduncan@suse.com, michael.christie@oracle.com, cleech@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 17:11:11 +0000 you wrote:
> Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
> pointing to non TCP socket (af_unix for example).
> 
> Return -EINVAL if this is attempted, instead of crashing the kernel.
> 
> Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator: Initiator code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lee Duncan <lduncan@suse.com>
> Cc: Chris Leech <cleech@redhat.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: open-iscsi@googlegroups.com
> Cc: linux-scsi@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - scsi: iscsi_tcp: restrict to TCP sockets
    https://git.kernel.org/netdev/net/c/f4f82c52a0ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


