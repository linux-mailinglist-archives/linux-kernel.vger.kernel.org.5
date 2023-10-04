Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0C7B85B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbjJDQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjJDQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDAA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:49:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E14C433C7;
        Wed,  4 Oct 2023 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438162;
        bh=Pl/CyWpmpy67oQBOmr7t29W7B7Izi7OrIHxghbevJRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMIgUHUKAG/BKID844uIM19QNSFWgjecnw37K3KYEWUhfHIATrrS4AKHU2uCG4yAB
         lGlikiB+BbezByQJbPoJqpDYaadKfan/yQPB6hecDK3UwTByjGQn1gRr7jhW7nIRnj
         th44BQAaKPj2shPBdX/UWckF7VzZLCb1aHGR1vAj7rJG+Vu2dg+vkSJtr1k3ztnCmV
         gTk/KcNEaIr3PM2WgV0yNR7mNk0vjfHTE/fqPfzLEU1HQhk7L7k69WoADgtjpCGo5t
         v4Y9NQs74thC5IirzuQ5Xaf1KWS6VD/Tbk7HRonfKncJxC+E4PfqkyN8pjaCvScsaE
         aumGo5Q58dFrg==
From:   Will Deacon <will@kernel.org>
To:     lenb@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        sudeep.holla@arm.com, Oza Pawandeep <quic_poza@quicinc.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v10] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date:   Wed,  4 Oct 2023 17:49:15 +0100
Message-Id: <169643348853.2504487.15808600653362880318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231003173333.2865323-1-quic_poza@quicinc.com>
References: <20231003173333.2865323-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 10:33:33 -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provide an architectural context loss flags field that can
> be used to describe the context that might be lost when an LPI
> state is entered.
> 
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
      https://git.kernel.org/arm64/c/4785aa802853

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
