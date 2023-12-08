Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120680AAFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574454AbjLHRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjLHRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7F85
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B00FEC433C9;
        Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702057223;
        bh=QWhvnecDQHsSaXh1TXP016NGyva6puMd5hngwy14e1A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gl+aUEkGPwTZV9V8E7sXAPFMgVXZdNBzTUASVKUbdAwvD1NO8NBvvjRYx2fAUxjN9
         exjo+hOzkBII5sUkYzXgvQLFBs+Yp1u5TznvFoyRe381Z8y7jxmfP8de0OLsq61usY
         Us5t/vAq6TubNMrtkY7yd94vO/q81fbVGCVxojvD2G3RHS+uY02eMupLaglp+gkWhE
         en0sX2G4QTvNoqaqSTNrYkwEpVNLX83c/XOcajTPrIkdWIwyfCNuV9TGJHK3Q2T9oy
         Nzk4a9O9ZWof9u1qELuyV8MNRIWVGzkM8nwYJgHEolwYcxhB3cCZUOeNFRNqtiLVVG
         sWH4O7T4JKf2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96EC6C04E24;
        Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Load vmlinux btf for any struct_ops map
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170205722361.30055.15108519957098973880.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 17:40:23 +0000
References: <20231208061704.400463-1-void@manifault.com>
In-Reply-To: <20231208061704.400463-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Dec 2023 00:17:03 -0600 you wrote:
> In libbpf, when determining whether we need to load vmlinux btf, we're
> currently (among other things) checking whether there is any struct_ops
> program present in the object. This works for most realistic struct_ops
> maps, as a struct_ops map is of course typically composed of one or more
> struct_ops programs. However, that technically need not be the case. A
> struct_ops interface could be defined which allows a map to be specified
> which one or more non-prog fields, and which provides default behavior
> if no struct_ops progs is actually provided otherwise. For sched_ext,
> for example, you technically only need to specify the name of the
> scheduler in the struct_ops map, with the core scheduler logic providing
> default behavior if no prog is actually specified.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Load vmlinux btf for any struct_ops map
    https://git.kernel.org/bpf/bpf-next/c/8b7b0e5fe47d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


