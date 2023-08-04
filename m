Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2023077079E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHDSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHDSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5974EE2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 709D2620BC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5096BC433C8;
        Fri,  4 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691172629;
        bh=TI4Ix1tgagkTopvqKSbXoLDr+vha8PJf2DzeaLlMcm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucWJk2y8zHWVKrrtqJBSTia2njVcGy8dBQVrlLAyV6u7k1lhsnt+yfu3c2DbCN0gw
         jOMy+v1Xz7uKTRgHBSv+tGiH54qKutjaWM3p0RnOFDauqNzvl9KfKSfvhU8x8k00O0
         ebdy1SsbfQHTOucSF9+EjMh28UcctYf/lH4gk7MnJcSYebmrvv26aVXurXljdlgjTy
         hF2iUqP2J641laCrmJinKAzJhoQXbecpcEnPTxBTkR0hd7BKEHsFBqzaMNG6glZ/uO
         UH7kVNd1JzB9mpSkmXNonpqDva8hO6JSxZ2FSpxrgQAiw7s/9qEpmRECp3MDhUO+6l
         MvqdrLrom24sQ==
From:   Will Deacon <will@kernel.org>
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
Date:   Fri,  4 Aug 2023 19:10:15 +0100
Message-Id: <169116693391.147594.8584700236925488135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627002939.2758-1-scott@os.amperecomputing.com>
References: <20230627002939.2758-1-scott@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 17:29:39 -0700, D Scott Phillips wrote:
> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
> 
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: sdei: abort running SDEI handlers during crash
      https://git.kernel.org/arm64/c/5cd474e57368

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
