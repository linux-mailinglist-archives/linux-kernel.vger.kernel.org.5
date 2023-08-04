Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D78770725
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHDRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHDRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92B49E5;
        Fri,  4 Aug 2023 10:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FC9620BD;
        Fri,  4 Aug 2023 17:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCFC433C8;
        Fri,  4 Aug 2023 17:31:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64/ptrace: Fixes for more SME only streaming SVE cases
Date:   Fri,  4 Aug 2023 18:31:57 +0100
Message-Id: <169117030673.2722209.16942967954706695265.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
References: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 19:33:20 +0100, Mark Brown wrote:
> When we added support for streaming mode SVE there were several missed
> cases around ptrace, address them.  Some could be seen on systems which
> do physically have SVE, others would only impact SME only systems.  The
> Fixes: tag is a bit conservative for the SME only cases but it seems
> like the safest and clearest choice.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] arm64/ptrace: Don't enable SVE when setting streaming SVE
      https://git.kernel.org/arm64/c/045aecdfcb2e
[2/3] arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
      https://git.kernel.org/arm64/c/507ea5dd92d2
[3/3] arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE
      https://git.kernel.org/arm64/c/69af56ae56a4

-- 
Catalin

