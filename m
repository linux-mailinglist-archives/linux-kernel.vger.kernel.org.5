Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05727EEB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjKQCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:30:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40918B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:30:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F0F6C433C9;
        Fri, 17 Nov 2023 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700188223;
        bh=Bi++G3J2BXlCQbqHWLtl+LNBbMJokVdqsIbgDw3TS5Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KFJlyho9HYAGTezuDY/KGiPEppGTIqsON5prVvh8nVs0EiSVbTeypHQtCRQH1gSV6
         hg8IQ4xL5emrLgW7wd3j/Xqs0Aiq+iClKEoHJEVzSp3YuDXTDLn1awSAVqVjEvN5CI
         SmUHlqfLf/x4EwQucrhu6DZ38M+QGUmlEpVuD6lTLZ4sBR163PxqcCwSXtNiSkdwwc
         bOlvu+S5GXNZdDSuR0FypPfRDgYNHWz1VKghZh9Abx75g6FiOAnsm0c3zQFkqFij48
         laZllMaA+eZgHQYeCFFuXDERGuMnUpZt4P5+8n7c/8uFyiMd5+6zBvpYqdXjtdoxTJ
         UoSpyvJ8j0oog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AF73E1F661;
        Fri, 17 Nov 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tipc: Remove redundant call to TLV_SPACE()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170018822349.19040.6248661340876085947.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 02:30:23 +0000
References: <20231117003704.1738094-1-syoshida@redhat.com>
In-Reply-To: <20231117003704.1738094-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 09:37:04 +0900 you wrote:
> The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
> the TLV value passed as argument and align the resulting size to
> TLV_ALIGNTO.
> 
> tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
> tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
> call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
> redundancy.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tipc: Remove redundant call to TLV_SPACE()
    https://git.kernel.org/netdev/net-next/c/d580d265e9ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


