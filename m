Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B57CB38C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjJPTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJPTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:54:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F98F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:54:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a29c7eefso2901423e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697486095; x=1698090895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=baP8YkQxU9yI25DBD+/65bf+wTrEW6XypsQOt1oBEAk=;
        b=cF3MOT+bHmHi7qeDjP37YIirjNrtzkTlb/iPDk1EMm++OEGvdd2KhBiGv8nE8oTz60
         GXVyJAbVVKDi77QV2stFYLZm+cHQ4i90cdZx4LgaqxlgvfwbB/ZQWH/qwTXmHKcj2eQJ
         BbFgP2Ht052tLezkJMmflNYjgbGSlRnzRhw7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486095; x=1698090895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baP8YkQxU9yI25DBD+/65bf+wTrEW6XypsQOt1oBEAk=;
        b=cRmP4QZSiT6ulE0V3OTrW3zPpBZTsLoZSlvMzxIEkL3FvoTV51nqG5G/i9NbUVzfly
         YGHaeR/G8ny4YQCRZoSy/poQCwfmB0viPhqifMFBzClKcroLmpCPpGSqYbRUAmIRqvU1
         MnZwv2K83onMIU1ULS+2h0RHwKNNJkgM3b5Gm6HboxSUiUp/aQ1lG1AYwr978K0fRpco
         10NBW0IdCqyK9NIGU7qBCIncUbagBIuEKe6cHHalKRFNkSv/m0V2ChBoOtbxyb3cBYdX
         5M0/qRxOFxD2WdGwDr12wEcfPOl0Usvppv7M+R5y0TN+MqjccUAAsslMJKkVx7DvQQCX
         yhOg==
X-Gm-Message-State: AOJu0YxXEUEFBSBx46WJ/rg704OSt7BuXHi6cG0D3vuUobXFj/R6k2zX
        OJ+H2NiM9pu/+lmAjbK918zW+qxAan7awqRJ2ZmLK+z7
X-Google-Smtp-Source: AGHT+IGrSqcj+PQvxNpPtOyd2s18Ypzgl3LSjnCelVNWyKrb07OcJ7LtSWEX8wUU3KlIEqPXgMsOuw==
X-Received: by 2002:a19:f80f:0:b0:507:ab5b:7b6c with SMTP id a15-20020a19f80f000000b00507ab5b7b6cmr256640lff.36.1697486094986;
        Mon, 16 Oct 2023 12:54:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512314800b005079a8b0f19sm93042lfi.62.2023.10.16.12.54.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:54:53 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507a29c7eefso2901387e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:54:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3b0c:b0:502:fdca:2eaa with SMTP id
 f12-20020a0565123b0c00b00502fdca2eaamr300196lfv.52.1697486093274; Mon, 16 Oct
 2023 12:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231015202523.189168-1-ubizjak@gmail.com> <20231015202523.189168-3-ubizjak@gmail.com>
 <ZS0bLvcC46tHjM/G@gmail.com> <ZS2PIzzffqflnVoY@google.com>
In-Reply-To: <ZS2PIzzffqflnVoY@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 12:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-MFtUhhFUzv1_8zrpkRFWY5vG72WzrG-xAkJB+1S1hQ@mail.gmail.com>
Message-ID: <CAHk-=wj-MFtUhhFUzv1_8zrpkRFWY5vG72WzrG-xAkJB+1S1hQ@mail.gmail.com>
Subject: Re: [PATCH -tip 3/3] x86/percpu: *NOT FOR MERGE* Implement
 arch_raw_cpu_ptr() with RDGSBASE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: multipart/mixed; boundary="0000000000009a2b780607dac7a8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009a2b780607dac7a8
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Oct 2023 at 12:29, Sean Christopherson <seanjc@google.com> wrote:
>
> > Are we certain that ucode on modern x86 CPUs check CR4 for every affected
> > instruction?
>
> Not certain at all.  I agree the CR4.FSGSBASE thing could be a complete non-issue
> and was just me speculating.

Note that my timings on two fairly different arches do put the cost of
'rdgsbase' at 2 cycles, so it's not microcoded in the sense of jumping
off to some microcode sequence that has a noticeable overhead.

So it's almost certainly what Intel calls a "complex decoder" case
that generates up to 4 uops inline and only decodes in the first
decode slot.

One of the uops could easily be a cr4 check, that's not an uncommon
thing for those kinds of instructions.

If somebody wants to try my truly atrocious test program on other
machines, go right ahead. It's attached. I'm not proud of it. It's a
hack.

Do something like this:

    $ gcc -O2 t.c
    $ ./a.out
      "nop"=0l: 0.380925
      "nop"=0l: 0.380640
      "nop"=0l: 0.380373
      "mov %1,%0":"=r"(base):"m"(zero)=0l: 0.787984
      "rdgsbase %0":"=r"(base)=0l: 2.626625

and you'll see that a no-op takes about a third of a cycle on my Zen 2
core (according to this truly stupid benchmark). With some small
overhead.

And a "mov memory to register" shows up as ~3/4 cycle, but it's really
probably that the core can do two of them per cycle, and then the
chain of adds (see how that benchmark makes sure the result is "used")
adds some more overhead etc.

And the 'rdgsbase' is about two cycles, and presumably is fully
serialized, so all the loop overhead and adding results then shows up
as that extra .6 of a cycle on average.

But doing cycle estimations on OoO machines is "guess rough patterns",
so take all the above with a big pinch of salt. And feel free to test
it on other cores than the ones I did (Intel Skylake and and AMD Zen
2). You migth want to put your machine into "performance" mode or
other things to actually make it run at the highest frequency to get
more repeatable numbers.

The Skylake core does better on the nops (I think Intel gets rid of
them earlier in the decode stages and they basically disappear in the
uop cache), and can do three loads per cycle. So rdgsbase looks
relatively slower on my Skylake at about 3 cycles per op, but when you
look at an individual instruction, that's a fairly artificial thing.
You don't run these things in the uop cache in reality.

              Linus

--0000000000009a2b780607dac7a8
Content-Type: text/x-c-code; charset="US-ASCII"; name="t.c"
Content-Disposition: attachment; filename="t.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lntaw81r0>
X-Attachment-Id: f_lntaw81r0

I2luY2x1ZGUgPHN0ZGlvLmg+CgojZGVmaW5lIE5SIDEwMDAwMDAwMAoKI2RlZmluZSBMT09QKHgp
IGZvcihpbnQgaSA9IDA7IGkgPCBOUi8xNjsgaSsrKSBkbyB7IFwKCWFzbSB2b2xhdGlsZSh4KTsg
c3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xh
dGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwK
CWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9
IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4
KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2
b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7
IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3Vt
ICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGls
ZSh4KTsgc3VtICs9IGJhc2U7IFwKCWFzbSB2b2xhdGlsZSh4KTsgc3VtICs9IGJhc2U7IFwKfSB3
aGlsZSAoMCkKCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHJkdHNjKHZvaWQpCnsKCXVuc2ln
bmVkIGludCBhLGQ7Cglhc20gdm9sYXRpbGUoInJkdHNjIjoiPWEiKGEpLCI9ZCIoZCk6OiJtZW1v
cnkiKTsKCXJldHVybiBhOwp9CgojZGVmaW5lIFRFU1QoeCkgZG8geyBcCgl1bnNpZ25lZCBpbnQg
cyA9IHJkdHNjKCk7IFwKCUxPT1AoeCk7IFwKCXMgPSByZHRzYygpLXM7IFwKCWZwcmludGYoc3Rk
ZXJyLCAiICAiICN4ICI9JXVsOiAlZlxuIiwgc3VtLCBzIC8gKGRvdWJsZSlOUik7IFwKfSB3aGls
ZSAoMCkKCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKewoJdW5zaWduZWQgbG9uZyBi
YXNlID0gMCwgc3VtID0gMDsKCXVuc2lnbmVkIGxvbmcgemVybyA9IDA7CgoJVEVTVCgibm9wIik7
CglURVNUKCJub3AiKTsKCVRFU1QoIm5vcCIpOwoJVEVTVCgibW92ICUxLCUwIjoiPXIiKGJhc2Up
OiJtIih6ZXJvKSk7CglURVNUKCJyZGdzYmFzZSAlMCI6Ij1yIihiYXNlKSk7CglyZXR1cm4gMDsK
fQo=
--0000000000009a2b780607dac7a8--
