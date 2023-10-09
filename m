Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780637BE6F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377788AbjJIQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377758AbjJIQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2ECD6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB8F7C433CA;
        Mon,  9 Oct 2023 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870231;
        bh=AJkot5FBCm4lPSoreEelc8js7+6JtqmXG87A7jEJW8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PYxAPRRifbyBtor5MJp1SjG98sEY3Ie+v74dm79AvAwHgrgVfJYnwbxUQmL/CgoPi
         kBA0bYDa13OUGIM47APeprLgaQY2A8WuGAH58jlIC1i7C0W2ceoVG2T1XIycMiSeJn
         27CaiXxz63OeDwwySHuUnIv7VwVpee72P+stYWqZM6hkbm+d6vqNOZoEqtJWMc/7B8
         vajXCXz2HyQV0N+H84c5Z/NXxA47rdHpUFWIcUzM+LKc3AlucMKg3Zt1JtadHs9Yfx
         Y3L6hhpX00eHYh+dt7wj09wyJ0Ub7NAx7vXOcGXwWKScRFVrLJlfr0EdZN3kSXljE6
         7eGsQ9hCPw+cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D155DE0009C;
        Mon,  9 Oct 2023 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/2] bpftool: Align output skeleton ELF code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169687023085.4743.8248369412311953528.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Oct 2023 16:50:30 +0000
References: <20231007044439.25171-1-irogers@google.com>
In-Reply-To: <20231007044439.25171-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, alastorze@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, alan.maguire@oracle.com
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

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Oct 2023 21:44:38 -0700 you wrote:
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
> 
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v6,1/2] bpftool: Align output skeleton ELF code
    https://git.kernel.org/bpf/bpf-next/c/23671f4dfd10
  - [v6,2/2] bpftool: Align bpf_load_and_run_opts insns and data
    https://git.kernel.org/bpf/bpf-next/c/1be84ca53ca0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


