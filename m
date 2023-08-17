Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752577FE35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354618AbjHQSyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354649AbjHQSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3732727;
        Thu, 17 Aug 2023 11:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45DCE67760;
        Thu, 17 Aug 2023 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36824C433C8;
        Thu, 17 Aug 2023 18:54:30 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
Date:   Thu, 17 Aug 2023 19:54:27 +0100
Message-Id: <169229846427.1184154.14407026846596603141.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org>
References: <20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 12:28:19 +0100, Mark Brown wrote:
> When we use NT_ARM_SSVE to either enable streaming mode or change the
> vector length for a process we do not currently do anything to ensure that
> there is storage allocated for the SME specific register state.  If the
> task had not previously used SME or we changed the vector length then
> the task will not have had TIF_SME set or backing storage for ZA/ZT
> allocated, resulting in inconsistent register sizes when saving state
> and spurious traps which flush the newly set register state.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
      https://git.kernel.org/arm64/c/5d0a8d2fba50

-- 
Catalin

