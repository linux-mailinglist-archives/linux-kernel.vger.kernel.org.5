Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08B7E3A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKGK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37076EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:55:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E054BC433C8;
        Tue,  7 Nov 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699354557;
        bh=mfBp2TCGrhfD2b1dIjeSC/i76vwZNpisdtEQ4annegg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY/a6Bf6398FibBNUTQpWp8yXcBjZBo7qj3nFkcZXvo2EBCuXiUs1EkRCKQrY2HuS
         GQAVVRhBqu4a5cFcved2FAzSLIjzv0LWQZ2uhOTwC13vhJ0CYi3kvYHct1nWWsA/Om
         4PTExfaSCdzSJ+4qI6OOw4HVlPQK9EdX0wLLrIkObeNHyAmsvXv3T8VXutlY0MEVYS
         Z/fDpSWx6E1EOxUe99ArW8ltwPNTJZWplrodXr6tKwf3y3ay/dexy1E4+o23k5Ffa7
         GBNr9we7MMmK/hOHI0EbO/eEMqZEd9iWws2Uo9OVk8EkP2DXYOe3WRTJZtf5wXfARj
         sCR1iA88RR93Q==
Date:   Tue, 7 Nov 2023 10:55:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit
 registers
Message-ID: <20231107105552.GC19133@willie-the-truck>
References: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:30:12AM -0700, Ilkka Koskinen wrote:
> The driver used to truncate several 64-bit registers such as PMCEID[n]
> registers used to describe whether architectural and microarchitectural
> events in range 0x4000-0x401f exist. Due to discarding the bits, the
> driver made the events invisible, even if they existed.
> 
> Moreover, PMCCFILTR and PMCR registers have additional bits in the upper
> 32 bits. This patch makes them available although they aren't currently
> used. Finally, functions handling PMXEVCNTR and PMXEVTYPER registers are
> removed as they not being used at all.
> 
> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
> Reported-by: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Acked-by: Will Deacon <will@kernel.org>

Catalin -- another perf fix for you, thanks!

Will
