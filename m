Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F077A322D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjIPTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbjIPTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:32:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D9186
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:32:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso2971637f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694892723; x=1695497523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4tSANpdPZtQ5moNLopTdGJ5bxa+NmMhHjATNkQUyBj8=;
        b=EZStcdriyk1KJERl8lIl1b+TR11Ns6dUpAbJvafwNnidOFJ5Wn5EnfcIeWywlOe2fM
         gYtmn4FPMwkbKRubHyVMtuwIEdgLiJexrnPAR1KoxLnFMZnC7h6Tqrdl7ehIc3uQ0oIy
         eWAUJmk/JAjjShfB6HUn5x/IV3mSHiaLFMY1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694892723; x=1695497523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tSANpdPZtQ5moNLopTdGJ5bxa+NmMhHjATNkQUyBj8=;
        b=SR7RaVay2ae04K2qEpq9vCGNBGw7+7XQ6EyPfB9Zs6iUKgqxSoWH7om+nnUWEOosBB
         tJVdofPH1HwaDieyK/23Cx3Q8coGg+dngYYknCOhwe/XE8TFSECmS8a5sC/Bn4W1XIIj
         GKoDTklxW3CpY4jsWIfRo9fdUmNRpll9fKCnx+27ueg8cOKCm5CSFEDP6Gcju9dUyqMK
         uO8dGhMiCfD0AVNHbZwkyaEQMgbGaBObRh1j4eF0CLPQ3YBMLsiT0IuzZNnM1eUr7uY1
         OEQYvP0m7K+y1o9lWBH2tB8FHqTCSUQ03KZ7pgz6sG5nJRuhjhT59YqfoxFS1IRPnbrb
         26lA==
X-Gm-Message-State: AOJu0Yyhu8bfUFY8B4tfqNDh7nCtf/DGMcwqhEk4VEpItcOywfl0iGrx
        qmRlQ6pa9DM/k2B+HN7mwE4fQP+VptsoH/WEZaayunqD
X-Google-Smtp-Source: AGHT+IEbik6BTQRY9ssA8JbrBc4r2FhJL+Www3ZamhZAL6tRRcbNLjdoSGeHDg0hm9c0swL9kO28fw==
X-Received: by 2002:adf:fb90:0:b0:317:e5dc:5cd0 with SMTP id a16-20020adffb90000000b00317e5dc5cd0mr4169858wrr.21.1694892722693;
        Sat, 16 Sep 2023 12:32:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0099bd6026f45sm4025014ejf.198.2023.09.16.12.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 12:32:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso3816355a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:31:59 -0700 (PDT)
X-Received: by 2002:a05:6402:229a:b0:530:a19b:175 with SMTP id
 cw26-20020a056402229a00b00530a19b0175mr3639630edb.2.1694892719344; Sat, 16
 Sep 2023 12:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <1694366957@msgid.manchmal.in-ulm.de> <ZQWUzwiKWLk79qbp@debian.me>
In-Reply-To: <ZQWUzwiKWLk79qbp@debian.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Sep 2023 12:31:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
Message-ID: <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000783fdf06057ef6ee"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000783fdf06057ef6ee
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Sept 2023 at 04:43, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Thanks for the regression report. Michael had already bisected it [1], so
> telling regzbot:
>
> #regzbot ^introduced: 408579cd627a15
> #regzbot title: huge committed memory due to returning 0 on do_vmi_align_mmunmap() success
>
> [1]: https://lore.kernel.org/linux-parisc/30f16b4f-a2fa-fc42-fe6e-abad01c3f794@virtuozzo.com/

Funky. That commit isn't actually supposed to change anything, and the
only locking change was because it incorrectly ended up doing the
unlock a bit too early (before it did a validate_mm() - fixed in
commit b5641a5d8b8b ("mm: don't do validate_mm() unnecessarily and
without mmap locking").

HOWEVER.

Now that I look at it again, I note this change in move_vma().

-       if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+       if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {

and I think that is wrong.

The return value that changed was the old "return 1 if successful
_and_ lock downgraded".

Now it does "lock is always released on success if requested". So the
special "1" return went away, but the failure case didn't change.

So that change to "move_vma()" seems to be bogus. It used to do "if
failed". Now it does "if success".

Does the attached patch fix the problem?

Liam - or am I just crazy? That return value check change really looks
bogus to me, but it looks *so* bogus that it makes me think I'm
missing something.

                       Linus

--000000000000783fdf06057ef6ee
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lmmf85c00>
X-Attachment-Id: f_lmmf85c00

IG1tL21yZW1hcC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbXJlbWFwLmMgYi9tbS9tcmVtYXAuYwppbmRleCAw
NTY0NzhjMTA2ZWUuLjM4MmU4MWMzM2ZjNCAxMDA2NDQKLS0tIGEvbW0vbXJlbWFwLmMKKysrIGIv
bW0vbXJlbWFwLmMKQEAgLTcxNSw3ICs3MTUsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBtb3Zl
X3ZtYShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKIAl9CiAKIAl2bWFfaXRlcl9pbml0KCZ2
bWksIG1tLCBvbGRfYWRkcik7Ci0JaWYgKCFkb192bWlfbXVubWFwKCZ2bWksIG1tLCBvbGRfYWRk
ciwgb2xkX2xlbiwgdWZfdW5tYXAsIGZhbHNlKSkgeworCWlmIChkb192bWlfbXVubWFwKCZ2bWks
IG1tLCBvbGRfYWRkciwgb2xkX2xlbiwgdWZfdW5tYXAsIGZhbHNlKSA8IDApIHsKIAkJLyogT09N
OiB1bmFibGUgdG8gc3BsaXQgdm1hLCBqdXN0IGdldCBhY2NvdW50cyByaWdodCAqLwogCQlpZiAo
dm1fZmxhZ3MgJiBWTV9BQ0NPVU5UICYmICEoZmxhZ3MgJiBNUkVNQVBfRE9OVFVOTUFQKSkKIAkJ
CXZtX2FjY3RfbWVtb3J5KG9sZF9sZW4gPj4gUEFHRV9TSElGVCk7Cg==
--000000000000783fdf06057ef6ee--
