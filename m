Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190F17D5F61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJYBK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJYBK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89D10D5;
        Tue, 24 Oct 2023 18:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96026C433C9;
        Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698196223;
        bh=Wzhk5GWKvNAybKey4Q2A/3TY/ldAFnqYK29HEtyA0h8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HtGKeZjFksXy7wh0RZGlHwS7/LlgbvMMMtjzzAlteh++aPHczMT5qcpwV2Za0EKwn
         qLXw4wXidsGYCAI3NjeijCNsyh4/ItpAJWCSe7uMqD/OCPJLWNbe2ewmP1K3cFn0bN
         QUIsdClchcVLRgF9GkxlOASwmj7XlhipPfL3BlUBWS5uDBOOFUSYwBubwogmsg68/I
         KesZBmk2hLreQ1EuqruGf9+ViOR6ufSVQHrPtpl+Wcms5TKJdKiAY66CruoA2ZUMso
         EOCDijNKYdWPP7bUvxGF6bzbBWIh/tYEGfezAzV7WTW/WX06FVcoumoZ1tdLuwX9Rr
         KPZWb7a+gvqcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B24EC00446;
        Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169819622350.20949.9484167363310455139.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 01:10:23 +0000
References: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
In-Reply-To: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 19:39:39 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_entry->dbf_name to be NUL-terminated based on its use with
> strcmp():
> |       if (strcmp(entry->dbf_name, name) == 0) {
> 
> [...]

Here is the summary with links:
  - s390/qeth: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/e43e6d9582e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


