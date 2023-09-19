Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401087A69AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjISRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjISRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:35:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10948D7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:35:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695144922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ep6P+kC61GSAMlGCWc9dKATlsMMFrwbwQ9dmRUHihJ0=;
        b=HQdcMcB/p/2G9z6frvETjilEw47A/Gxx6U+j/mSh5bkgYD99xcFOv5WAxvjjOq0ZKZUbqH
        4eLjKrpk/g4eufz46II9a9KfAcC38OqBRVsYfHq4asf7jFN4GPB2/5TzORvIgwTDBvEPHb
        8ODg735Tl9/0byVAFu+yaq7b2b930znId7VNHhCrjpOBVPQo2oYaDQjf/6FO5cvn6ORCtV
        10G0XwBr2woZYnl9IXkvqT11CiMrVoFnF6vVwOyb23vCED/oCqyMS4VWRK45utCmYtwE3b
        z1mVvwk7iQBwHcs3tfwonNYokaMantKf/Xz81bCLHnoTwzdlDgliBqJj0jCZkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695144922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ep6P+kC61GSAMlGCWc9dKATlsMMFrwbwQ9dmRUHihJ0=;
        b=b5T7r4c9bbTDBiSyGNADFvi/9XH7dIQUY+mqcMGXgkfEo9AVW6ePiU+TFwALcwS4su0jrp
        PCGmSBsLWBsyuGAg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 07/30] x86/microcode/intel: Simplify early loading
In-Reply-To: <871qeuw6q5.ffs@tglx>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.208060138@linutronix.de>
 <20230919143230.GDZQmw/kLc5nyu9CZV@fat_crate.local> <871qeuw6q5.ffs@tglx>
Date:   Tue, 19 Sep 2023 19:35:22 +0200
Message-ID: <87sf7aukv9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 16:57, Thomas Gleixner wrote:
> On Tue, Sep 19 2023 at 16:32, Borislav Petkov wrote:
>> On Tue, Sep 12, 2023 at 09:57:54AM +0200, Thomas Gleixner wrote:
>>> +/* Load microcode on BSP from CPIO */
>>
>> Yeah, no need to say "from CPIO" everywhere. We load it from somewhere,
>> it can be cpio but it can be builtin too.
>
> Makes sense.
>
>> But I can fix up too when applying.
>
> Thanks a lot!

Let me fix that up and repost as the removal of the early argument
in patch 1/N causes a metric ton of conflicts all over the series.

Thanks,

        tglx
