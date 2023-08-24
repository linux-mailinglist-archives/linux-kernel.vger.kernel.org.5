Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5078643C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbjHXAUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjHXAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B110E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141E26378A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6117FC433C9;
        Thu, 24 Aug 2023 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692836424;
        bh=mHheW+hsnMJ66Qr7GrRSRKNhdX39hE5ClgSLeMSCvQ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PeBiSHxWpPcvMdtBf4+3h9SIyKf1e98WZSKTgS8SAFmqGOtlGCokR6Gkuiq57a9CR
         ZtgZxv/V6lvUFqrFUWXs4kLuNx365ueZE84bL/JE7gg8rI2II/UU0zL4aSEoM5frLo
         WIJemC3ii88vqSEy4DCnpgOXkDBQr9oUIAAEq4SJUto5GAMHvHpAiUvWkkMRZFGvm5
         4XGBbxeyrVfuE+VuVwdGm6iSNiYUSzVBD8DbgTsqKhZM7amTNZRvVl1cpHw+FTAMre
         UDhP+GJhdRKOORYs/B7NlUNHvnkJV4E14JW1bHCSckw7FO9E8KFycZ8sXOpuGqt1Pb
         Fjm1vJzduOsmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 433BCC4314B;
        Thu, 24 Aug 2023 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Add bpf_object__unpin()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169283642427.5265.11674522531780375026.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 00:20:24 +0000
References: <b2f9d41da4a350281a0b53a804d11b68327e14e5.1692832478.git.dxu@dxuuu.xyz>
In-Reply-To: <b2f9d41da4a350281a0b53a804d11b68327e14e5.1692832478.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Aug 2023 17:15:02 -0600 you wrote:
> For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
> 
> But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
> symmetry to the API.
> 
> It's also convenient for cleanup in application code. It's an API I
> would've used if it was available for a repro I was writing earlier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Add bpf_object__unpin()
    https://git.kernel.org/bpf/bpf-next/c/068ca522d5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


