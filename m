Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7817E6060
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjKHWQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:16:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702E258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:16:27 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b9a456798eso159009a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699481786; x=1700086586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5Z/JCS+cADDfWxySWlv4rRO+qNPvclX4YCANHkp5R8=;
        b=i9fsL6GEP2VA3QXna1YZZhoPSpPM3ow2GP+TNotsHKK02RlXvdXRNyFFxwtyhFg6/y
         7LoXFyioU3PjUfbtZesVEaiCsf7uaEx1jdfMtkRJJhQkH0Q2w/T0cQQ/UIE67hHf26uw
         3gXl3uxuthynTowC56uXxVzyC/nuMHUbdECcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699481786; x=1700086586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Z/JCS+cADDfWxySWlv4rRO+qNPvclX4YCANHkp5R8=;
        b=Q+KTpMNCR/n3/f2fs/Z4EkAaeOuVxYjPgrHG/RKza/hzMHpaKTe5IlLL0t1zVPBkQV
         CAqz/HXto09dMePMTJn0NDQWZrxLf4pDwYc2nwFBMhwdYMstSnwAvQURaVMmSpSuRlOK
         khNMQXWt+3haTnpiHJYGOXzhRcEwc7oPydqFG9bQ47Vhf4Y25wYewRcVowBJPS/CrxrV
         2OEsnF+dn97JyFw3KK+kzZKH1PXWW/SCQB11YvjJksEWCXN4RIfAXr32xBJedEwOdeoM
         CSwT0PBa0i7fXsmc/Q8ywkx83vR39DftWrH1Ji7T8usD4FisciWaxKYO5b7PkyPNvXxR
         Mcdw==
X-Gm-Message-State: AOJu0YxF4dcHur3fFxDgpOEex6mI+d1/451i5G4NiIVYqdBf4HTTr6iM
        lU9lNKOPmtIG5HwS909l9s/LIA==
X-Google-Smtp-Source: AGHT+IHoU713sclUOZkoi37zwa+QOf3ppCcfBMl+RWuXGf605oldTnKLFIGc969oQgjeQKm61zWlow==
X-Received: by 2002:a05:6a21:33a7:b0:184:26d8:cf5c with SMTP id yy39-20020a056a2133a700b0018426d8cf5cmr3782752pzb.0.1699481786466;
        Wed, 08 Nov 2023 14:16:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001c7453fae33sm2161258plz.280.2023.11.08.14.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:16:25 -0800 (PST)
Date:   Wed, 8 Nov 2023 14:16:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <202311081415.C4774E1B@keescook>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-15-ankur.a.arora@oracle.com>
 <202311081114.0F15C1FB9@keescook>
 <20231108144144.3d257286@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108144144.3d257286@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 02:41:44PM -0500, Steven Rostedt wrote:
> On Wed, 8 Nov 2023 11:15:37 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > FOr the memcpy_kunit.c cases, I don't think there are preemption
> > locations in its loops. Perhaps I'm misunderstanding something? Why will
> > the memcpy test no longer produce softlockup splats?
> 
> This patchset will switch over to a NEED_RESCHED_LAZY routine, so that
> VOLUNTARY and NONE preemption models will be forced to preempt if its in
> the kernel for too long.
> 
> Time slice is over: set NEED_RESCHED_LAZY
> 
> For VOLUNTARY and NONE, NEED_RESCHED_LAZY will not preempt the kernel (but
> will preempt user space).
> 
> If in the kernel for over 1 tick (1ms for 1000Hz, 4ms for 250Hz, etc),
> if NEED_RESCHED_LAZY is still set after one tick, then set NEED_RESCHED.
> 
> NEED_RESCHED will now schedule in the kernel once it is able to regardless
> of preemption model. (PREEMPT_NONE will now use preempt_disable()).
> 
> This allows us to get rid of all cond_resched()s throughout the kernel as
> this will be the new mechanism to keep from running inside the kernel for
> too long. The watchdog is always longer than one tick.

Okay, it sounds like it's taken care of. :)

Acked-by: Kees Cook <keescook@chromium.org> # for lib/memcpy_kunit.c

-- 
Kees Cook
