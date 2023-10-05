Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9667B9E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJEOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjJEOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:05:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE772B5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:06:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so994316a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696489581; x=1697094381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G17il7t3WuJpFf2QHKqlDXDRJHy2EY97D1jjipO9ojg=;
        b=J5rAdni2HQQ3X7WpPe5VM2V4rlMMnyPtCqdvPHOJnCkd1uXlksnXpFByBFSOmjWP48
         Wv/sHpHmzjNbWNRjbTRCUj1yxiHeMFXzMuobLeGUU+QGFq8I6SOkuY7YeZiXY/6zkDYZ
         oJ9FOoq9J973WQaT5WVU2uNDuns+2OC6JlSvvH911Cs5Be3p6S4r0wZNEhnEcP9oQuxm
         X9zHy4AFSmkWIXGoWhdgP//qRdFEgY3aQ52cr7gj5/VRD8efgj1DJJVs78VdyX1FT75u
         MqR7PoiFXPwNnBnXrJlHXoWKcAPwoBIpzkj/guCzgZhza+6aOxIsKDtBVZY8rqb7cw0z
         wmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489581; x=1697094381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G17il7t3WuJpFf2QHKqlDXDRJHy2EY97D1jjipO9ojg=;
        b=d0iXDws/nUkUqtZPrBRbLlES4CqLPP+cLzut5kAy13kYMx1viLftyDRFwqovLJKfcI
         /5HlrSkb9DejL0G8mNF+z4PkgOV3yUBGs+qYG2vmQuA1DyvnAPjFh56HtwBRFMOwopRq
         zaigfXrhj0/dUttC0dNoWwpGcpbZG4rIsZgLGXjCwbsfim+vnHGZYgsQKenYQnGFJaOq
         ZGMV+4vnVoT0u4EZyd5eWk7kyCrSSJBatKBy0M4VmD2nABz2wYVIalTiBFCHx60RZQ+l
         eaMPTGmt4uo3WTqqA59PS1bxLVsenUdIWoP9UDNYDntS+KgMreFPsBWGlADFc2G3sNWf
         z+cw==
X-Gm-Message-State: AOJu0YzJD73L9lSqQv0NZ6x9QlqC/VFZx9mcBwIElvpOLVOiPJhyyX9N
        zRIxxi3enYQbAh1X+zHMQWE=
X-Google-Smtp-Source: AGHT+IE1ty58ds3EW5HurKf7JOcdA7bhqSb0A5VjSeKNH2rybXwCTzW0T2zXoMwa+m9QiIbjgaD/PQ==
X-Received: by 2002:a17:906:29e:b0:9b2:9a0e:9973 with SMTP id 30-20020a170906029e00b009b29a0e9973mr4469560ejf.42.1696489580784;
        Thu, 05 Oct 2023 00:06:20 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id qx18-20020a170906fcd200b0099bc8bd9066sm665467ejb.150.2023.10.05.00.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:06:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 09:06:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZR5gaXIE50J0oCeH@gmail.com>
References: <ZR2U4DLycLT5xFH6@gmail.com>
 <20231004192404.31733-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004192404.31733-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> The percpu code mostly uses inline assembly. Using segment qualifiers
> allows to use C code instead, which enables the compiler to perform
> various optimizations (e.g. propagation of memory arguments). Convert
> percpu read and write accessors to C code, so the memory argument can
> be propagated to the instruction that uses this argument.

>    text    data     bss     dec     hex filename
> 25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla.o
> 25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o

Ok, this all looks like a pretty nice optimization.

As discussed previously, I've created a new tip:x86/percpu topic branch
for this, based on tip:x86/asm that carries the other percpu patches.
This branch will be merged in v6.8, best-case scenario.

Also note that I lowered the version cutoff from GCC 13.1 to 12.1, for
the simple selfish reason to include my own daily systems in test coverage.

Is there any known bug fixed in the GCC 12.1 ... 13.1 version range that
could make this approach problematic?

Thanks,

	Ingo
