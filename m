Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56A7DF1D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjKBL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKBL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:57:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C28DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpoyf0umzevL48zlxPDHoMyyBJL1AYvLijGDL66r8U0=; b=Y8nBbUmHyrFCPnUpfg4L/wT/tV
        Rb9l5vEDe9EsOi3GmhjiXaKLGJNAyhnCPu4XE9yqoSv/3a1b00CCQcPWjs1mJJsxLobKREw0MQQzM
        7flM8kXa6gnUknd6kM0i9Rthlrg8YugyVA3/4NmF4VZhqzWjS7GgBBbE6ZSevRlhNB2g1IX/j6p4l
        D4M7CLHRgDfTSCzb1frM3xspjlE1iRZE+zACAhWakUtlckePnHeLw31IPlrghznuTX/IamKeIZSQk
        Fy57/AXyMIc8r2koEwuZQ+Pkl5XiERF5TPVM/tckiidjluvqxr1z8++d2RQMQXPPiUb3gIEDSS1G/
        mPCcpIrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyWJU-006Y20-01;
        Thu, 02 Nov 2023 11:56:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA92F3004AB; Thu,  2 Nov 2023 12:56:39 +0100 (CET)
Date:   Thu, 2 Nov 2023 12:56:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] x86/callthunks: Handle %rip-relative relocations in
 call thunk template
Message-ID: <20231102115639.GC3818@noisy.programming.kicks-ass.net>
References: <20231102112850.3448745-1-ubizjak@gmail.com>
 <20231102112850.3448745-3-ubizjak@gmail.com>
 <20231102114422.GB3818@noisy.programming.kicks-ass.net>
 <CAFULd4Yj=0XrufmZZiv=cZ3A+ncUd-8CF8bfr2h1w2N3PFf=DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Yj=0XrufmZZiv=cZ3A+ncUd-8CF8bfr2h1w2N3PFf=DQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:50:01PM +0100, Uros Bizjak wrote:

> > Remove static, add decl, stuff like that?
> 
> On second thought, you are right. Should I move the above function
> somewhere (reloc.c?) , or can I just use it from alternative.c and add
> decl (where?) ?

Yeah, leave it there for now, perhaps asm/text-patching.h ?
