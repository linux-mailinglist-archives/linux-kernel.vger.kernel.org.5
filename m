Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723617577C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGRJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGRJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:23:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07340E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z6h9Kl+9Vn52HeLrb8U7V39ZQEjyvP9ofUEU3VJOKM4=; b=p6tX8I/FflCvX1OocBMEQgWHyN
        5fEdj7K/XikooyEOuomVsAtPZ3S2HVox+MEJK30c3ftkXtTK5AGQzwibltql+ZlP5NkYGbotYvbJM
        W+DpupPpT/d8bstd9DrhQOaYG8Pag4KP+5MyJwf0GprVSmfILDveHrbizdcDdGSHsoYPSBOQutzB9
        nFABpFGkpZA2C7f96j4DO1puwkPZfGiE2DjX6/c+M22nPvLVtQwCwxyRZfQRMBbtLyhjQeHwfyRED
        gdka5+0QIqREb+Q351NvTC81s5vQ825urNftymyPMkc7wolvmW8qU4KWFYaWEKmlfQUXz8DYWjZUt
        e1p6Inmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLgvb-00BM6U-0G;
        Tue, 18 Jul 2023 09:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26EFB30007E;
        Tue, 18 Jul 2023 11:23:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CD3A213727BB; Tue, 18 Jul 2023 11:23:30 +0200 (CEST)
Date:   Tue, 18 Jul 2023 11:23:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
Message-ID: <20230718092329.GB3472843@hirez.programming.kicks-ass.net>
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717223049.327865981@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:14:33AM +0200, Thomas Gleixner wrote:

> So 58 patches and a lot of cursing later:

Hehe, and you've not even posted the topology bits yet :-)

>  58 files changed, 744 insertions(+), 1348 deletions(-)

(add another 24 lines of comments, and we have 58 patches, 58 files
changed and 580 lines removed)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>



