Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112B7E5152
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:48:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E86125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:47:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63490C433C7;
        Wed,  8 Nov 2023 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699429679;
        bh=BWp6lhJTxsDCOa5gmhx2BMbjklSMauDnFR0MD4QddRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBQYU7aj72B9RUhWE00L9k9OfTiKJBu3IrqzMWKxpJpvrFWo2cV/38iNfWepWIAbq
         9bnKTXAeulw8NYcQGHlRXRT99AMoeU2ERPVjT5cLLt9LdUabY+lndakOXxq7GjRYFm
         g3KDCPrEeqgY79HtU6JT0CkVJ4iXHPWfTg2XmUxg=
Date:   Wed, 8 Nov 2023 08:47:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 06/86] Revert "entry: Fix compile error in
 dynamic_irqentry_exit_cond_resched()"
Message-ID: <2023110801-bondless-disregard-795d@gregkh>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-7-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-7-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:56:52PM -0800, Ankur Arora wrote:
> This reverts commit 0a70045ed8516dfcff4b5728557e1ef3fd017c53.
> 

None of these reverts say "why" the revert is needed, or why you even
want to do this at all.  Reverting a compilation error feels like you
are going to be adding a compilation error to the build, which is
generally considered a bad thing :(

So, more information please.

thanks,

greg k-h
