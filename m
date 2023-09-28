Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26AC7B2849
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjI1WTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1WTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:19:46 -0400
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5419D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:19:43 -0700 (PDT)
Date:   Thu, 28 Sep 2023 22:19:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695939581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGg7pY7KhRw+YOmFUl/1WZXjN2FD7xN06g/pv2WG4WM=;
        b=CBhdNxghpB0mVzHuuSrw6OO1UOX2NdQT+l0g3mJkq8XiaAoFRUSGq02uLp1lXMIYGt7fyh
        24AHdiCCyF/bnXzHtA20ShPSFQvWnPxZGxb5sL5HqFfMz6rTxvSiuXXBzo3ZfxvUjjeLWh
        21juYxDuBNTUCaOJWDVgbaNNRkdXw78=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] KVM: arm64: Support for Arm v8.8 memcpy
 instructions in KVM guests
Message-ID: <ZRX7-EJ9w-Nmyxjz@linux.dev>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
 <ZRPE9OcB9ndgFxbs@linux.dev>
 <6687f58c-0da9-0583-2dc1-2089f292b745@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6687f58c-0da9-0583-2dc1-2089f292b745@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:55:39PM +0100, Kristina Martsenko wrote:

[...]

> > Perhaps I'm being pedantic, but I'd really like for there to be some
> > documentation that suggests MOPS exceptions can happen due to context
> > migration done by a higher EL as that is the only option in the context
> > of virtualization.
> 
> That's a good point. This shouldn't affect Linux guests as Linux is
> always able to handle a MOPS exception coming from EL0. But it would
> affect any non-Linux guest that pins all its EL0 tasks and doesn't
> implement a handler. It's not clear to me what the expectation for
> guests is, I'll ask the architects to clarify and get back to you.

That'd be excellent, thanks! All I'm looking for is something to point
folks at if/when they complain about MOPS behavior in KVM guests.

-- 
Thanks,
Oliver
