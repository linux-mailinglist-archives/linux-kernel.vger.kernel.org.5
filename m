Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A1789855
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHZRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHZRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:00:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F0FD2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:00:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1441582f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693069255; x=1693674055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRMbqnVBNO9RHS9BcEk5mmf1e60xFX1YvZAyF0oa2xw=;
        b=Q8Fwhgg21OKX0z/FysqqSiFnjLMJKn7t0p8k919Utg+OrP33QfIuVvx95MtjPbMoG0
         whdYxqDoukO/6OTCyFT4Mr3MWBr88MgBxjVq1mLNDW6yGRcTFz6nf6dgPplArOVc57sE
         dpdcNOShIqiiHSMEztW+hqKSmRwdnuu6GbocfLr8fu/dr2fI+ZqvK6+CjwRYdY9IsEmT
         Y0XjKYI4IGwUbw21icaM639mMWjE/exGhE4y26Dbw3+8JGCelAfzyiz1z9fQBM6T73Bm
         haXcfHmYJ3wAP0h/pr4ORvdIRNKot2oPJrRGpONoWaA4g2dCvHI/lgGUApxidp6oajdt
         Ppwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693069255; x=1693674055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRMbqnVBNO9RHS9BcEk5mmf1e60xFX1YvZAyF0oa2xw=;
        b=GmAzmr//bg8XmFJWoSY39lU1amGP/39NsuQ96a4iqUBn0dgHyIGMd4nzLH+lrXW64S
         ZgITnpZhKJ6aG1BBjJ6mpg9yPEkgdpEzAhcYETNkEiGsiMAj9hnNKMOuuTleU6msLX/F
         3rK+rmuuiRwnUxmwIni9Yx3D2nLLoru3F3XwP8hMFgJ2bNDPvAfi+oL2rs6MQ8zyTH4q
         PLqs5sGRAhpfkxybCWZZFpktpoWKDctWHiZaJuX619WGZVHbwm9u5TvdrtWI1SdEvBge
         LWYhj5CI7CHcLY6yooyJxZxhH+knH9cstlo148ni2USkLAt7l53hJxGkyBjtAdm9QhoQ
         e4eg==
X-Gm-Message-State: AOJu0Yxl3bZAMO6OrIHG55ee8smPX9ml4Nm26vvyKoufGvHCYjrtxb1L
        bvXmbsjJhSCNwjfKLbVHFRg=
X-Google-Smtp-Source: AGHT+IFyuPhWHq+GMH14MrEEkpFSFDK5axPmcWLQdRh6TsP3sRJ8LIWHBzptvH/wazVZ/qznzTp1wQ==
X-Received: by 2002:adf:a299:0:b0:31c:8151:86a9 with SMTP id s25-20020adfa299000000b0031c815186a9mr3500056wra.67.1693069254849;
        Sat, 26 Aug 2023 10:00:54 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d6a11000000b003142e438e8csm5340735wru.26.2023.08.26.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:00:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 26 Aug 2023 19:00:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/23] SRSO fixes/cleanups
Message-ID: <ZOovwXOjnwcgQX0R@gmail.com>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <ZOiEvVOqwjZHzVgT@gmail.com>
 <20230826155742.2hqirzpouzh5pduf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826155742.2hqirzpouzh5pduf@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Aug 25, 2023 at 12:38:53PM +0200, Ingo Molnar wrote:
> > Thank you, this all looks very nice. I've applied your fixes to
> > tip:x86/bugs, with the exception of the two KVM enablement patches.
> > 
> > I've also cherry-picked the apply_returns() fix separately to x86/urgent,
> > AFAICS that's the only super-urgent fix we want to push to the final v6.5
> > release before the weekend, right? The other fixes look like
> > reporting bugs, Kconfig oddities and inefficiencies at worst. Backporters
> > may still pick the rest from x86/bugs too - but we are too close to the
> > release right now.
> 
> As far as I can tell, the apply_returns() fix isn't necessarily urgent,
> since after commit 095b8303f383 it went from being an actual bug to just
> dead code: the optimization will never take effect now that none of the
> rethunk cases use __x86_return_thunk.
>
> On the other hand, if I'm too late sending this, it should be harmless to 
> merge it into the final v6.5 release.

Not too late at all - I've removed it from x86/urgent.

Thanks,

	Ingo
