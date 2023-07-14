Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6575441C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjGNVKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjGNVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:10:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0643A95
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ri2OsQ43RGoam4un0Kxs46/n4AvKY+KDWVmdcTp0Iek=; b=NA4JsUrZl/9s9QTMKyBD9OGDWY
        G9+POBjqr7G2k4JZ9sVTy9MZqS/TEs90Sn5Z5SiPKqm8+H+e28J3xTA8GNZ6vdAjdygwv5k/EqN4M
        YJ8qRJzDgA49Odn6gptdAzmd/MFU+5OH2O8aBU2NJYGRsVmXTdYm1aq4GXtAOp5PRdnIwtwfLMyOt
        Z1S5QjOUVgPeK2QvcqsvvYujLIjfeiTMoNVHmxl045UPoysp4ojK+vVtELMGpc5WSJh0D+YSf4ccR
        R3FkASs3wGpa4zph30XulPu3x7Z1tqcEF1nIYrRWmZ0s4lCFLi4Vj9h72OmHVRWynMOQ1q+AuvHbO
        xL8QmrTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKQ3S-006NZf-24;
        Fri, 14 Jul 2023 21:10:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7F8330023F;
        Fri, 14 Jul 2023 23:10:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 966EF21372899; Fri, 14 Jul 2023 23:10:21 +0200 (CEST)
Date:   Fri, 14 Jul 2023 23:10:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>, arjan@linux.intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230714211021.GB3275140@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:37:51PM +0200, Wysocki, Rafael J wrote:

> > Rafael, can we please just pull these patches and try again later?
> 
> I think you mean "revert"?

Yes, revert. The whole premise with the unparsable changelog that
babbles about TLB invalidates without any performance data-so-ever
should've been a red-flag.

That whole TLB angle is nonsense. We have paravirt TLB invalidation for
this.
