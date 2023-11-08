Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1415C7E52F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjKHKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:00:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759E1BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:00:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D256AC433C8;
        Wed,  8 Nov 2023 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699437645;
        bh=B+4MKlovPeoqzv47fSzDLSGUQ4Z4sQi7UhIm6VMMyZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAsnAcQkri9C2k7tpvk9uHQSWTibyVU0Vt7+XURKEh4uw5YG2SNSI5zvOVtRCEYmz
         Vmo8QiK97T8gMhDBnC12j2fmp2L633oKeBgRERu738/mrJx3DHTVhLRSRTvE2OGycX
         lpFvfLUmmTsnT/PlBo+9HXnaOr/xNRJ0ZkucHJK8=
Date:   Wed, 8 Nov 2023 11:00:42 +0100
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
Message-ID: <2023110821-sphere-mandarin-a726@gregkh>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-7-ankur.a.arora@oracle.com>
 <2023110801-bondless-disregard-795d@gregkh>
 <87v8acmx1l.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8acmx1l.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:09:10AM -0800, Ankur Arora wrote:
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Nov 07, 2023 at 01:56:52PM -0800, Ankur Arora wrote:
> >> This reverts commit 0a70045ed8516dfcff4b5728557e1ef3fd017c53.
> >>
> >
> > None of these reverts say "why" the revert is needed, or why you even
> > want to do this at all.  Reverting a compilation error feels like you
> > are going to be adding a compilation error to the build, which is
> > generally considered a bad thing :(
> 
> Yeah, one of the many issues with this string of reverts.
> 
> I was concerned about repeating the same thing over and over enough
> that I just put my explanation at the bottom of the cover-letter and
> nowhere else.

cover letters are not in the changelog when patches are committed :)

thanks,

greg k-h
