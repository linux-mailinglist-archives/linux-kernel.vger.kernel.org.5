Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5C7E27FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKFPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKFPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67843184
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627B6C433B6;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=VWCKe7SjFh7Bq6TAg/SU7Px7u48cI9rpqXcfMsj++00=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UtDBledcwcoJZyUIZWrXUPzitXxY+nodql2ACEEcF2akw2wiv7yLIcIUj2RdqcZ+v
         zikdWGqTGs2h+wnWlzL+tVuE4pIa1Dv7pVB/SJ12+aWmpXSSMbKovYIBUWJ6cGRSvo
         M11dxmDHUHjmyEW4hOAzlxaKZXqYtjRdof4Uf0Td0utwqVoTWa+KuNHdeyXmhfEY6w
         +B/9GWmZvNvYab6hE6twYg5LGz+zpAdrsVCm9O226fG2dxcDzqf7LKSt8ArJYooTMs
         fqUMqezbEvhoqhoau4EzSlEeOIg8vzabQw/pBXtHAO5qoe40+rGC2ti+lFzQt+ANMO
         agFBETtvRWGZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4232BC04DD9;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] RISC-V: capitalise CMO op macros
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282926.16503.8131988006359901785.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230915-aloe-dollar-994937477776@spud>
In-Reply-To: <20230915-aloe-dollar-994937477776@spud>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 15 Sep 2023 16:40:44 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The CMO op macros initially used lower case, as the original iteration
> of the ALT_CMO_OP alternative stringified the first parameter to
> finalise the assembly for the standard variant.
> As a knock-on, the T-Head versions of these CMOs had to use mixed case
> defines. Commit dd23e9535889 ("RISC-V: replace cbom instructions with
> an insn-def") removed the asm construction with stringify, replacing it
> an insn-def macro, rending the lower-case surplus to requirements.
> As far as I can tell from a brief check, CBO_zero does not see similar
> use and didn't require the mixed case define in the first place.
> Replace the lower case characters now for consistency with other
> insn-def macros in the standard and T-Head forms, and adjust the
> callsites.
> 
> [...]

Here is the summary with links:
  - [v1] RISC-V: capitalise CMO op macros
    https://git.kernel.org/riscv/c/d3eabf2f2c81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


