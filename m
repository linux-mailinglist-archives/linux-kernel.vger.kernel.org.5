Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99E7E66D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKIJdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKIJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:33:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686F2590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JrmCXtoRr7oqSU3gZeuU9Jf2IqGd/4aYMHqwkCedhGc=; b=LseiTpszMRMo61aMp9dz6hpGXf
        9fJw2q1ir1+ixIC/ENi60/RVQeoSBiflP8k83NOslCq49jYcgJpSoXkaY5CPbtEm5ZYzoZxghrbjt
        QY62wZpYeU8NbuBToKPOVfORO+z54qFD5vPz7CfjD0tYaXD9IHEYnmJk4w7148n097rTfd3iud5zx
        wp7pAaCRITuzXSpHJaoNQmSCCmbxNUbX72HCBG3s5yfXxTXO3WfrdDNSde493X+iKGuZqC4Et/9ur
        fgwabBUiBszT+aI8TR+dAsbhVp0LVIWBPke2ttxmOEQPVczz+dP22ufOMTe/YlW/MYknm6WZCrPhF
        l3OmTCHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r11OD-00EJFR-0D;
        Thu, 09 Nov 2023 09:32:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8D00300454; Thu,  9 Nov 2023 10:31:52 +0100 (CET)
Date:   Thu, 9 Nov 2023 10:31:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] refcount: introduce __refcount_dec_and_lock macro
Message-ID: <20231109093152.GS8262@noisy.programming.kicks-ass.net>
References: <20231106191138.3179599-1-aahringo@redhat.com>
 <20231106191138.3179599-2-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106191138.3179599-2-aahringo@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:11:37PM -0500, Alexander Aring wrote:
> This patch adds the __refcount_dec_and_lock macro to generate code for a
> lock specific refcount_dec_and_lock implementation. Existing
> refcount_dec_and_lock implementation are updated to use the new
> __refcount_dec_and_lock macro. In future other lock implementation can
> added to use the refcount_dec_and_lock trick to only hold the lock when
> the refcount is going to be zero. Per subsystem own lock implementation
> can use the macro as well to provide such implementation for their own
> locking type.
> 
> Co-developed: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
