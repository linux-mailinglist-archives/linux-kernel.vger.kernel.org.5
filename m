Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26EF7670C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjG1Pkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjG1Pkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59521BD1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F0A62181
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6D5C433C7;
        Fri, 28 Jul 2023 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558847;
        bh=PXHcT/NQwG7GVZErcgvIAilJ/Q5hOPzcNFZV9tnPlwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEUiSbPyn9oQWhB3NMrXKVa7s/kebesxpcvxqqLM+QDNxwCKSWea0DwZEeZR55m/e
         8x/E/qHkiGnatWxGwM34bRgOjt0BafB5PV/De5e6fKB8Z/xp/kVFr8+xOFIFF4HXgz
         ZzRWN4gDcHOqXtlWvG5WilbdQKuhjFfGXkhP+HwGXf4aDJtKTO/3g881TLG4wpRpPL
         rqQj1MLnCK3VNBigtqDwfinGPPe4xT35ghn9cZPDSTxzv7X3VTsKule1f8tLEYXL4z
         /j1a1w9n2J9Q2TarwfAShm2Aj2cNhL8EKXfQGl2QLFNdiAWOMKIquoFVpKHnX6UnHt
         qAOHL7Kb+1MxA==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, blakgeof@amazon.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 0/3] perf: Arm CMN updates
Date:   Fri, 28 Jul 2023 16:40:42 +0100
Message-Id: <169055106672.1935989.16792278281794617341.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1688746690.git.robin.murphy@arm.com>
References: <cover.1688746690.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 17:38:10 +0100, Robin Murphy wrote:
> Here's another CMN update which unfortunately due to circumstances
> didn't manage to be ready in time for 6.5. I realise it's a bit early
> now, but I'm about to be offline for 4 weeks so hey. For anyone playing
> along at home, the HN-S is not documented not in the CMN-700 TRM, but
> in its own special supplement[1].
> 
> Thanks,
> Robin.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] perf/arm-cmn: Remove spurious event aliases
      https://git.kernel.org/will/c/00df90934c9e
[2/3] perf/arm-cmn: Refactor HN-F event selector macros
      https://git.kernel.org/will/c/b1b7dc38e482
[3/3] perf/arm-cmn: Add CMN-700 r3 support
      https://git.kernel.org/will/c/ac18ea1a8935

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
