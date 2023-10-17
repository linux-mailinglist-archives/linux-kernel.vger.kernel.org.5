Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9B7CCBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjJQTMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbjJQTMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:12:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3590
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:12:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53f3609550bso881454a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569918; x=1698174718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zshnJXva4oUtLOMSpUQJEsw05K0Ofi7PiJbFvaGT/iM=;
        b=ePKEP7hQnOK8vad0aaM64Eb0Oj1keZQjD3tOx+igK712fdO+ZXcHRVUy7AUxkYRzru
         GsU2BGo9Hpgt0mB+LLsWa0uAzYRc2MnS4xIqYMk1zxDYAUsWNNFcd9rPH3VxOpdN37ta
         zXS2BSMYnhC4gd+W8lqqiGzOenAMbAGJwi6+hTP8T7zmyPfXr0wfvEF6hplnZTkaHWA5
         fDfKtpluLHC+zwcnLuTCSSe/PUZ7eQBjKqvkwhGIZglGQoiYu3lSEkSD1t1JsPMHWult
         01dWRcntkyp1Q7wbG0Sv/WCKo/UTILAICLeODLfq0QS6yYcHRhySuFaHxSxdv/FPJBnu
         gMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569918; x=1698174718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zshnJXva4oUtLOMSpUQJEsw05K0Ofi7PiJbFvaGT/iM=;
        b=D6hN/2Mw/lOobdLcVa7b3JXmRwH9s4dfsdXHSIeaJe7rflTNFfFtPpjvDcHyM+g0Yc
         Gc3WP4OWLXK26lApbqs6HvrAOV6bYUJ9T+AeK7VZul88N1LpADIn2PcdgxII5WdtXG11
         sIVd5GHApGCmmWSpoUf3SDrnszAuSeUvzBFH1kEFJ3P6Q4QXN/JvrDZ92bqCBL2ho0fp
         WZ3Bu00akaDs0+tUMAuXS0AUGnD2S55MXGrP549K+jl9J1pOpGlLhTtusebWHVbzg2Z+
         zoDx/1TB3YkTiLzYVZXFCIepLrwil9/fcT4vPr0MS4pJjs4kxJryvULjhUNf8pGb0A6q
         AMfQ==
X-Gm-Message-State: AOJu0YwgxlG/WfRGQ2xFXZzfXVIqVXOfWD79SmQEzOPw5FEQfl4lkwME
        Mjotiy6Yqv7h9C3d38hvOUPAG2Wo/ePugBrBIaU=
X-Google-Smtp-Source: AGHT+IFSpaA5x+Cm7YslkMXYJId4PjfbmVvCgMbjcR0eLpSENXMU0AnwbwfscNv1NmyYh12pTMGDnFybGOADEVP3J/k=
X-Received: by 2002:a50:ab58:0:b0:53e:7d91:611f with SMTP id
 t24-20020a50ab58000000b0053e7d91611fmr2334224edc.11.1697569918355; Tue, 17
 Oct 2023 12:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
In-Reply-To: <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 17 Oct 2023 21:11:46 +0200
Message-ID: <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/mixed; boundary="000000000000f723500607ee4b32"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f723500607ee4b32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 9:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 17 Oct 2023 at 00:23, Nadav Amit <namit@vmware.com> wrote:
> >
> > Yes, the FPU issue is the one that caused me to crash before.
>
> Uros, can you verify whether that patch of mine resolves the issue you sa=
w?
>
> That patch is _technically_ an actual bug-fix, although right now our
> existing 'current' caching that depends on just CSE'ing the inline asm
> (and is apparently limited to only doing so within single basic
> blocks) doesn't actually trigger the bug in our __switch_to() logic in
> practice.

Unfortunately, it doesn't fix the oops :(

I'm testing your patch, together with the attached patch with the
current tip tree (that already has all necessary percpu stuff), and
get exactly the same oops in:

[    4.969657] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    4.980712] modprobe (53) used greatest stack depth: 13480 bytes left
[    4.981048] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    4.981830] #PF: supervisor write access in kernel mode
[    4.981830] #PF: error_code(0x0002) - not-present page
[    4.981830] PGD 0 P4D 0
[    4.981830] Oops: 0002 [#1] PREEMPT SMP PTI
[    4.981830] CPU: 1 PID: 54 Comm: kworker/u4:1 Not tainted
6.6.0-rc6-00406-g84ab57184ff4-dirty #2
[    4.981830] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-1.fc37 04/01/2014
[    4.981830] RIP: 0010:begin_new_exec+0x8f2/0xa30
[    4.981830] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
fa ff ff <f0>
41 ff 0c 24 0f 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9 48 fb
[    4.981830] RSP: 0000:ffffa505401f3d68 EFLAGS: 00010246
[    4.981830] RAX: 0000000000000000 RBX: ffff89ed809e9f00 RCX: 00000000000=
00000
[    4.981830] RDX: 0000000000000000 RSI: ffff89ed80e6c000 RDI: ffff89ed809=
ea718
[    4.981830] RBP: ffff89ed8039ee00 R08: 00000000fffffffe R09: 00000000fff=
fffff
[    4.981830] R10: 000001ffffffffff R11: 0000000000000001 R12: 00000000000=
00000
[    4.981830] R13: 0000000000000000 R14: ffff89ed809ea718 R15: ffff89ed80e=
6c000
[    4.981830] FS:  0000000000000000(0000) GS:ffff89ee24900000(0000)
knlGS:0000000000000000
[    4.981830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.981830] CR2: 0000000000000000 CR3: 00000001003a0000 CR4: 00000000000=
406f0
[    4.981830] Call Trace:
[    4.981830]  <TASK>
[    4.981830]  ? __die+0x1e/0x60
[    4.981830]  ? page_fault_oops+0x17b/0x470
[    4.981830]  ? search_module_extables+0x14/0x50
[    4.981830]  ? exc_page_fault+0x66/0x140
[    4.981830]  ? asm_exc_page_fault+0x26/0x30
[    4.981830]  ? begin_new_exec+0x8f2/0xa30
[    4.981830]  ? begin_new_exec+0x3ce/0xa30
[    4.981830]  ? load_elf_phdrs+0x67/0xb0
[    4.981830]  load_elf_binary+0x2bb/0x1770
[    4.981830]  ? __kernel_read+0x136/0x2d0
[    4.981830]  bprm_execve+0x277/0x630
[    4.981830]  kernel_execve+0x145/0x1a0
[    4.981830]  call_usermodehelper_exec_async+0xcb/0x180
[    4.981830]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    4.981830]  ret_from_fork+0x2f/0x50
[    4.981830]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    4.981830]  ret_from_fork_asm+0x1b/0x30
[    4.981830]  </TASK>
[    4.981830] Modules linked in:
[    4.981830] CR2: 0000000000000000
[    5.052612] ---[ end trace 0000000000000000 ]---
[    5.053833] RIP: 0010:begin_new_exec+0x8f2/0xa30
[    5.055065] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
fa ff ff <f0>
41 ff 0c 24 0f 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9 48 fb
[    5.059476] RSP: 0000:ffffa505401f3d68 EFLAGS: 00010246
[    5.060780] RAX: 0000000000000000 RBX: ffff89ed809e9f00 RCX: 00000000000=
00000
[    5.062483] RDX: 0000000000000000 RSI: ffff89ed80e6c000 RDI: ffff89ed809=
ea718
[    5.064190] RBP: ffff89ed8039ee00 R08: 00000000fffffffe R09: 00000000fff=
fffff
[    5.065908] R10: 000001ffffffffff R11: 0000000000000001 R12: 00000000000=
00000
[    5.067625] R13: 0000000000000000 R14: ffff89ed809ea718 R15: ffff89ed80e=
6c000
[    5.069343] FS:  0000000000000000(0000) GS:ffff89ee24900000(0000)
knlGS:0000000000000000
[    5.071313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.072732] CR2: 0000000000000000 CR3: 00000001003a0000 CR4: 00000000000=
406f0
[    5.074439] Kernel panic - not syncing: Fatal exception
[    5.075028] Kernel Offset: 0xcc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)



Uros.

--000000000000f723500607ee4b32
Content-Type: text/plain; charset="US-ASCII"; name="current.diff.txt"
Content-Disposition: attachment; filename="current.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnup8xbz0>
X-Attachment-Id: f_lnup8xbz0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaAppbmRleCBhMTE2OGU3YjY5ZTUuLjIxZThiZDRlYTQ0ZSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaApAQCAtMzYsMTAgKzM2LDIzIEBAIHN0YXRpY19hc3NlcnQoc2l6
ZW9mKHN0cnVjdCBwY3B1X2hvdCkgPT0gNjQpOwogCiBERUNMQVJFX1BFUl9DUFVfQUxJR05FRChz
dHJ1Y3QgcGNwdV9ob3QsIHBjcHVfaG90KTsKIAorLyoKKyAqCisgKi8KK0RFQ0xBUkVfUEVSX0NQ
VV9BTElHTkVEKGNvbnN0IHN0cnVjdCBwY3B1X2hvdCBfX3BlcmNwdV9zZWdfb3ZlcnJpZGUsCisJ
CQljb25zdF9wY3B1X2hvdCk7CisKKyNpZmRlZiBDT05GSUdfVVNFX1g4Nl9TRUdfU1VQUE9SVAor
c3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmdldF9jdXJyZW50KHZv
aWQpCit7CisJcmV0dXJuIGNvbnN0X3BjcHVfaG90LmN1cnJlbnRfdGFzazsKK30KKyNlbHNlCiBz
dGF0aWMgX19hbHdheXNfaW5saW5lIHN0cnVjdCB0YXNrX3N0cnVjdCAqZ2V0X2N1cnJlbnQodm9p
ZCkKIHsKIAlyZXR1cm4gdGhpc19jcHVfcmVhZF9zdGFibGUocGNwdV9ob3QuY3VycmVudF90YXNr
KTsKIH0KKyNlbmRpZgogCiAjZGVmaW5lIGN1cnJlbnQgZ2V0X2N1cnJlbnQoKQogCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9j
b21tb24uYwppbmRleCBiMTRmYzhjMWM5NTMuLmYyODRjMDhhYWVjYSAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9jb21tb24uYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1v
bi5jCkBAIC0yMDUwLDYgKzIwNTAsMTAgQEAgREVGSU5FX1BFUl9DUFVfQUxJR05FRChzdHJ1Y3Qg
cGNwdV9ob3QsIHBjcHVfaG90KSA9IHsKIH07CiBFWFBPUlRfUEVSX0NQVV9TWU1CT0wocGNwdV9o
b3QpOwogCitERUNMQVJFX1BFUl9DUFVfQUxJR05FRChjb25zdCBzdHJ1Y3QgcGNwdV9ob3QgX19w
ZXJjcHVfc2VnX292ZXJyaWRlLAorCQkJY29uc3RfcGNwdV9ob3QpIF9fYXR0cmlidXRlX18oKGFs
aWFzKCJwY3B1X2hvdCIpKSk7CitFWFBPUlRfUEVSX0NQVV9TWU1CT0woY29uc3RfcGNwdV9ob3Qp
OworCiAjaWZkZWYgQ09ORklHX1g4Nl82NAogREVGSU5FX1BFUl9DUFVfRklSU1Qoc3RydWN0IGZp
eGVkX3BlcmNwdV9kYXRhLAogCQkgICAgIGZpeGVkX3BlcmNwdV9kYXRhKSBfX2FsaWduZWQoUEFH
RV9TSVpFKSBfX3Zpc2libGU7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgg
Yi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKaW5kZXggZDc3NzlhMThiMjRmLi5iZjk4MTVlYWY0
YWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyLmgKQEAgLTIxMiw3ICsyMTIsNyBAQCB2b2lkIGZ0cmFjZV9saWtlbHlfdXBk
YXRlKHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEgKmYsIGludCB2YWwsCiAgKi8KICNkZWZpbmUg
X19fQUREUkVTU0FCTEUoc3ltLCBfX2F0dHJzKSBcCiAJc3RhdGljIHZvaWQgKiBfX3VzZWQgX19h
dHRycyBcCi0JCV9fVU5JUVVFX0lEKF9fUEFTVEUoX19hZGRyZXNzYWJsZV8sc3ltKSkgPSAodm9p
ZCAqKSZzeW07CisJX19VTklRVUVfSUQoX19QQVNURShfX2FkZHJlc3NhYmxlXyxzeW0pKSA9ICh2
b2lkICopKHVpbnRwdHJfdCkmc3ltOwogI2RlZmluZSBfX0FERFJFU1NBQkxFKHN5bSkgXAogCV9f
X0FERFJFU1NBQkxFKHN5bSwgX19zZWN0aW9uKCIuZGlzY2FyZC5hZGRyZXNzYWJsZSIpKQogCg==
--000000000000f723500607ee4b32--
