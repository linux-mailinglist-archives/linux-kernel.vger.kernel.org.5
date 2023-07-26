Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C9764002
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGZTyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGZTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:29 -0400
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E41BFF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:54:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690401264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hYWOY0GOq7TEQ2jYhueW+PBQo85Ao5FyIz97jyFCuk=;
        b=ZKNK5Ckc6eUVY12vchUO7u1jlXqSMPmpVxybh4xsp6jmbbwu8hicYpy7hWEnIkESYYzfuK
        LqssD0lQMPk8GY0RE1mARkf9ckaRiGD018T+Yg8HrI48Nwn1XRgqn6DFfOtFg6+V0ZhEO8
        49pBURtGH5d4Wj5RgGn46wlqH9QwgXM=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mostafa Saleh <smostafa@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ricardo Koller <ricarkol@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, kvmarm@lists.linux.dev,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] KVM: arm64: fix __kvm_host_psci_cpu_entry() prototype
Date:   Wed, 26 Jul 2023 19:54:06 +0000
Message-ID: <169040115365.2565311.7638563346432161929.b4-ty@linux.dev>
In-Reply-To: <20230724121850.1386668-1-arnd@kernel.org>
References: <20230724121850.1386668-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:18:42 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The kvm_host_psci_cpu_entry() function was renamed in order to add a wrapper around
> it, but the prototype did not change, so now the missing-prototype warning came
> back in W=1 builds:
> 
> arch/arm64/kvm/hyp/nvhe/psci-relay.c:203:28: error: no previous prototype for function '__kvm_host_psci_cpu_entry' [-Werror,-Wmissing-prototypes]
> asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: fix __kvm_host_psci_cpu_entry() prototype
      https://git.kernel.org/kvmarm/kvmarm/c/01b94b0f3922

--
Best,
Oliver
