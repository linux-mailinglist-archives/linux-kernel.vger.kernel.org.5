Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7A7624FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGYV6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGYV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:57:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A6193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:57:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso9616238e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690322273; x=1690927073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9b1rum3dNzgjEBji3blebo6bNVhtpdwh9Flr67JyHF0=;
        b=Drur1jsGwj8bxxj5nirqU9Bnu417zSMei1kZzT8XEiP5HClskNp3V1gGNTJjlnAz8p
         Zx+juq2DJrdrvzv5o8jNGGW0YuBmK63ElQK0fcmV2kh8dj+pyg98KRBVqrn7w4aKtN6B
         sSYVXeRc6z3RRaE9A2/OM9s4J7EP/7LHO11Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322273; x=1690927073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b1rum3dNzgjEBji3blebo6bNVhtpdwh9Flr67JyHF0=;
        b=HQpq1LkC7TFAfY+OWWB+LNnZ5iHPd5Qn4XeifzVG7vqfgG0KBZb5iqBs+S5/Q9QkID
         sOHSnUySEAQyIrTwFvZl2liSDViVbBfww91RlIIzIOwvvdl4vHsfvuOIcXEMQForVxLL
         4AJFvs6y1ajprmwgM5e5WxZ/PiGTdcPxxYhQnYJPk8k9L6dwQsxdb3cWMtnPpfaacuf6
         iGWSarPJtVXC9Z525PDsOaqitIDHnR38C65Z2jzA2IhPlXMsK7vOQWD+x/vVLD+FnEjH
         bFKLK7uf9MZdKWUynw5LjSPKqRZAA1YmiKG2XqXFEcqlm3j9UCohsACErxa+moL6dt/m
         YOOA==
X-Gm-Message-State: ABy/qLa2Vh/iK+H63NYtb3+EmYX4BemegMaLNySSjCL9nJ2hcwzwVAGq
        4wfVvdHdgofHroBADosRPv1HkTbDZfGyUE0VMhVzG35b
X-Google-Smtp-Source: APBJJlEAKrpki/5D4JGPqTC5K+RsGX8zY+2KdyDbIca5EVPG7W+NLhdFPUq4aWDXBRoWI87a/XphNA==
X-Received: by 2002:a05:6512:202f:b0:4fb:8ee0:b8a5 with SMTP id s15-20020a056512202f00b004fb8ee0b8a5mr84516lfs.46.1690322273618;
        Tue, 25 Jul 2023 14:57:53 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d90b000000b005222a38c7b2sm3900552edr.48.2023.07.25.14.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 14:57:52 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991c786369cso934169366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:57:52 -0700 (PDT)
X-Received: by 2002:a17:906:3296:b0:970:c9f:2db6 with SMTP id
 22-20020a170906329600b009700c9f2db6mr82102ejw.63.1690322272256; Tue, 25 Jul
 2023 14:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230724230329.3970-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230724230329.3970-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 14:57:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com>
Message-ID: <CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: Fix load_unaligned_zeropad() handling for
 shared TDX memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 at 16:03, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Commit c4e34dd99f2e ("x86: simplify load_unaligned_zeropad()
> implementation") changes how exceptions around load_unaligned_zeropad()
> handled. Kernel now relies on fault_address in fixup_exception() to
> detect that the exception happened due to load_unaligned_zeropad().
>
> It works fine for #PF, but breaks on #VE since no fault address is
> passed down to fixup_exception().
>
> Propagating ve_info.gla down to fixup_exception() resolves the issue.

Ahh.

The faulting address was really only used as a sanity check, so I
guess another option would have been to just remove it.

We do need to get the "real" address anyway just to get the right
offset, and that comes from

        addr = (unsigned long) insn_get_addr_ref(&insn, regs);

and all we do is to then check they "yep, the faulting address is the
start of the next aligned word".

The faulting address in itself was never sufficient, since it has lost
the original offset in the previous page, and typically just points to
the first word in the next page.

That said, your patch looks fine to me, even if it might have been
easier to just remove the fault_addr thing entirely. And the
fault_addr verification is nice in that it validates our instruction
decoder result, so maybe it is all better this way.

I can apply this directly (having written that ex_handler_zeropad())
or wait for it to come from the x86 tree?

                 Linus
