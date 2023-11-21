Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90E7F2E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKUNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:35:54 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF191BC;
        Tue, 21 Nov 2023 05:35:49 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59b5484fbe6so58247757b3.1;
        Tue, 21 Nov 2023 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573748; x=1701178548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1bgJgAbUzXysVXnmrbWD/Bln1YuJzIlRZNnYx7qdOA=;
        b=GpsCAZboO6YGBYOUOgz+KS6unTVVh58N2qaugm3gwnFsiHvqzlA2KRpPNhwjIWnXLW
         JFMKsIHNZgO7DB7svu6gmsTcpWphB/RACdepAtp7gLhjQJcu1K4avXdIr15Giq/zf910
         zqW0JygpM/SEjmwqqkuhJ5k+NmrPOlhqxVaOGWyX0k/VNFuSloSo5BHlDJmsiq7VFKlL
         IiMAw5PFibbX4XCLopd/yIvT/wCgVpMStXc2v3T4E2jIKTa/4P4IkCcwNMx9xrCLsbu7
         uYOYhZg2I03olFUAF/TXFgOLCKlaVxWI3zcuYpNUlkTuWnbHc2Cd5sYMmJa90KwzTavn
         8cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573748; x=1701178548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1bgJgAbUzXysVXnmrbWD/Bln1YuJzIlRZNnYx7qdOA=;
        b=X+g68FcgokBxlgAR9UaqBzEmLlm7Wb9eS3/gptaM23fgB4d4GqdRGTDFAGVC7KhLRz
         F5g2Ots0ad8CdGfe0CDIEMZqzLhKpxABrblcAxHd9kHqtjIrE+XURjQg6WQAhaQ5pgEl
         kIF0omFy7F33wP/MP2BdnDHqWiZPQT5x2brz02YZvnSFnI2l9/ckGkko4HYH8mk/7gDD
         C4dq/qTSjpF1nxp+OU9xVU+592vLLAIClVHVg8cYq8nE/DlFFPrPh0mznw/L/ekcOK13
         xnCSbaN8BHnaTjx7vfA4SisyTKfY3IHTKG0oe3USdAywqMIB/+pBt0HiAR039D4RtdiT
         sCMA==
X-Gm-Message-State: AOJu0YyRJUIgGGHHbK83Z691Q9O6BtBGxp+jmfs21FvlwA1fJ0lTed16
        y0Vz+qUJbhFHfCwDKpznhfA=
X-Google-Smtp-Source: AGHT+IEL90mHMqgVQ28KIc1rABP+1ecwT8HRZ7oWNV+r45XFFS8JiwR8yRPw1PcVuYOVV+JKu0LmBQ==
X-Received: by 2002:a05:690c:b19:b0:5ca:d579:52f with SMTP id cj25-20020a05690c0b1900b005cad579052fmr5118531ywb.35.1700573748564;
        Tue, 21 Nov 2023 05:35:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id i78-20020a819151000000b005a7bf9749c8sm3013199ywg.4.2023.11.21.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:35:48 -0800 (PST)
Date:   Tue, 21 Nov 2023 05:35:47 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 13/34] KVM: x86: hyper-v: optimize and cleanup
 kvm_hv_process_stimers()
Message-ID: <ZVyyM4974UQtzoCX@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-14-yury.norov@gmail.com>
 <877cmcqz5r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cmcqz5r.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:26:08PM +0100, Vitaly Kuznetsov wrote:
> Yury Norov <yury.norov@gmail.com> writes:
> 
> > The function traverses stimer_pending_bitmap n a for-loop bit by bit.
> > We can do it faster by using atomic find_and_set_bit().
> >
> > While here, refactor the logic by decreasing indentation level
> > and dropping 2nd check for stimer->config.enable.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/x86/kvm/hyperv.c | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 238afd7335e4..460e300b558b 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -870,27 +870,26 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
> >  	if (!hv_vcpu)
> >  		return;
> >  
> > -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
> > -		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
> > -			stimer = &hv_vcpu->stimer[i];
> > -			if (stimer->config.enable) {
> > -				exp_time = stimer->exp_time;
> > -
> > -				if (exp_time) {
> > -					time_now =
> > -						get_time_ref_counter(vcpu->kvm);
> > -					if (time_now >= exp_time)
> > -						stimer_expiration(stimer);
> > -				}
> > -
> > -				if ((stimer->config.enable) &&
> > -				    stimer->count) {
> > -					if (!stimer->msg_pending)
> > -						stimer_start(stimer);
> > -				} else
> > -					stimer_cleanup(stimer);
> > -			}
> > +	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
> > +					ARRAY_SIZE(hv_vcpu->stimer)) {
> > +		stimer = &hv_vcpu->stimer[i];
> > +		if (!stimer->config.enable)
> > +			continue;
> > +
> > +		exp_time = stimer->exp_time;
> > +
> > +		if (exp_time) {
> > +			time_now = get_time_ref_counter(vcpu->kvm);
> > +			if (time_now >= exp_time)
> > +				stimer_expiration(stimer);
> >  		}
> > +
> > +		if (stimer->count) {
> 
> You can't drop 'stimer->config.enable' check here as stimer_expiration()
> call above actually changes it. This is done on purpose: oneshot timers
> fire only once so 'config.enable' is reset to 0.

Ok, I see. Will fix in v2
