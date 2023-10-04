Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14E57B8999
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbjJDS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbjJDS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:27:25 -0400
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75A98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:27:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696444039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHGl6xWhs0tENVvXmfAIBiogdIWWHOiNDVc38UfDAxo=;
        b=d/48tgusZMqvpxXO2+csYfQZASRRCWl2sC/kk8XdoDSZ1XJLUjAcWp0E7wvI8paY3kYw3M
        K6URqRJf/G8WbLueAbRv3UOYfq5zTE3l1FkCmKdnAqpPi4//e8PL3/YmmW85yIy0yFuEPE
        NHArvvtxg4p6KlL+a/02qAS5FzWotis=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     kvmarm@lists.linux.dev,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH v2 0/2] KVM: arm64: Support for Arm v8.8 memcpy instructions in KVM guests
Date:   Wed,  4 Oct 2023 18:27:08 +0000
Message-ID: <169644402344.3996132.10135608827504283886.b4-ty@linux.dev>
In-Reply-To: <20230922112508.1774352-1-kristina.martsenko@arm.com>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 12:25:06 +0100, Kristina Martsenko wrote:
> This is v2 of the series to allow using the new Arm memory copy instructions
> in KVM guests. See v1 for more information [1].
> 
> Changes in v2:
>  - Dropped HCRX_EL2 vcpu field
>  - Rebased onto v6.6-rc2
> 
> [...]

Applied to kvmarm/next, thanks!

[1/2] KVM: arm64: Add handler for MOPS exceptions
      https://git.kernel.org/kvmarm/kvmarm/c/17b8ac23488b
[2/2] KVM: arm64: Expose MOPS instructions to guests
      https://git.kernel.org/kvmarm/kvmarm/c/a24015b6cc66

--
Best,
Oliver
