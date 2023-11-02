Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB57DF28D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376301AbjKBMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbjKBMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662E19D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:34:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so1390574a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928465; x=1699533265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FA0yTwkInLGsLQa5BhVK4Bn2x+30cc/C0kqHF1MhyZo=;
        b=MoglkKUBogMXol4oY44romC4E8vORDpImhoRl3xHbyoIjbgbvTWifwUUEpJjKnabVf
         7uvehOCA88KCUIhCWxAMXm8ZHahJuw6CbqVRDb2vKZzhTzzGRMmHWNLKSotUkVEU7MLK
         iCUwU5UZC3bJj/bohnNoWx3PBcWh+e5Oq7m1LghxiC3fUGimx7Js+/3b6hqjHM32BE+5
         76i5Lx/lPeamdRWEOC053j/EBOTrIQaSNYH++G1NgVz8cXQBmo7FXHghT5zEgPLreFgl
         mW8YG+/9ieztWYb5JMVjh+imbsTNufkEZPfFqaUXCR9xx9jF0jnW5tWFVF3K+IUk3rKR
         /vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928465; x=1699533265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA0yTwkInLGsLQa5BhVK4Bn2x+30cc/C0kqHF1MhyZo=;
        b=PYa3YoJXCNthMml+lbCLX0n9Mt4c8F2MdJQl2p4eqb2e+h6Rj5PC0v+tNkUejeg3VS
         +YzwP2Ox6oapi2G1snOhDUlG83DaiikdsCo9YFY0dBqumdwPs13iWTQMch2waG8WGW5k
         CgjVl0nVSMOwBHk66NRQN8cc90HoasQMkxn+w7rQj4Cxc/IbN1DVLJkIAUC3q7uTf4u2
         EdPr/gMp0sBgAPCIeX5JbFrJnbv9qTa2GHQ+ZQjwKSUBNzMwOQ6M3tEOQqGU6CGMglzB
         B02y/6U2nhMUfj6mPuL3m9uShQhcoNLQJbejekgAkoqY8W3RhVIK/Wo/zDg9wR6yTwYG
         hXkg==
X-Gm-Message-State: AOJu0YzAwFzXKki5/Dko/mxEe+Rj4H/7RfiuqE4JHMMwcch53XrbdMQX
        PJmrEEnmtUzqGnPYc4nfus2uBgxO/7eUXF+064k=
X-Google-Smtp-Source: AGHT+IGDh7AL1Mav8sk0mH2HXxxQ/ajDIxgY0oHmkqRrXKODH2MP3d8cTGawqYQBHqD3+lZw9GQceSJxpfplfWG9JnE=
X-Received: by 2002:aa7:c71a:0:b0:540:e588:8243 with SMTP id
 i26-20020aa7c71a000000b00540e5888243mr14780173edq.20.1698928465428; Thu, 02
 Nov 2023 05:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231102112850.3448745-1-ubizjak@gmail.com> <20231102112850.3448745-3-ubizjak@gmail.com>
 <20231102114422.GB3818@noisy.programming.kicks-ass.net> <CAFULd4Yj=0XrufmZZiv=cZ3A+ncUd-8CF8bfr2h1w2N3PFf=DQ@mail.gmail.com>
 <20231102115639.GC3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231102115639.GC3818@noisy.programming.kicks-ass.net>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 2 Nov 2023 13:34:14 +0100
Message-ID: <CAFULd4ZjqAL-_QvfH11vafk5cDOCF8yCALgEMvSgfYJuVG1pNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/callthunks: Handle %rip-relative relocations in
 call thunk template
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="000000000000ae5b1106092a9b52"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ae5b1106092a9b52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 12:56=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 02, 2023 at 12:50:01PM +0100, Uros Bizjak wrote:
>
> > > Remove static, add decl, stuff like that?
> >
> > On second thought, you are right. Should I move the above function
> > somewhere (reloc.c?) , or can I just use it from alternative.c and add
> > decl (where?) ?
>
> Yeah, leave it there for now, perhaps asm/text-patching.h ?

The new version boots OK and looks like the attached patch.

Uros.

--000000000000ae5b1106092a9b52
Content-Type: text/plain; charset="US-ASCII"; name="reloc.diff.txt"
Content-Disposition: attachment; filename="reloc.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_loh64tzt0>
X-Attachment-Id: f_loh64tzt0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RleHQtcGF0Y2hpbmcuaCBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3RleHQtcGF0Y2hpbmcuaAppbmRleCAyOTgzMmMzMzhjZGMuLmJhOGQ5
MDBmM2ViZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGV4dC1wYXRjaGluZy5o
CisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RleHQtcGF0Y2hpbmcuaApAQCAtMTgsNiArMTgs
OCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXBwbHlfcGFyYXZpcnQoc3RydWN0IHBhcmF2aXJ0X3Bh
dGNoX3NpdGUgKnN0YXJ0LAogI2RlZmluZSBfX3BhcmFpbnN0cnVjdGlvbnNfZW5kCU5VTEwKICNl
bmRpZgogCit2b2lkIGFwcGx5X3JlbG9jYXRpb24odTggKmJ1Ziwgc2l6ZV90IGxlbiwgdTggKmRl
c3QsIHU4ICpzcmMsIHNpemVfdCBzcmNfbGVuKTsKKwogLyoKICAqIEN1cnJlbnRseSwgdGhlIG1h
eCBvYnNlcnZlZCBzaXplIGluIHRoZSBrZXJuZWwgY29kZSBpcwogICogSlVNUF9MQUJFTF9OT1Bf
U0laRS9SRUxBVElWRUpVTVBfU0laRSwgd2hpY2ggYXJlIDUuCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYyBiL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jCmlu
ZGV4IDczYmUzOTMxZTRmMC4uNjYxNDBjNTRkNGY2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvYWx0ZXJuYXRpdmUuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYwpAQCAt
MzI1LDggKzMyNSw3IEBAIGJvb2wgbmVlZF9yZWxvYyh1bnNpZ25lZCBsb25nIG9mZnNldCwgdTgg
KnNyYywgc2l6ZV90IHNyY19sZW4pCiAJcmV0dXJuICh0YXJnZXQgPCBzcmMgfHwgdGFyZ2V0ID4g
c3JjICsgc3JjX2xlbik7CiB9CiAKLXN0YXRpYyB2b2lkIF9faW5pdF9vcl9tb2R1bGUgbm9pbmxp
bmUKLWFwcGx5X3JlbG9jYXRpb24odTggKmJ1Ziwgc2l6ZV90IGxlbiwgdTggKmRlc3QsIHU4ICpz
cmMsIHNpemVfdCBzcmNfbGVuKQordm9pZCBhcHBseV9yZWxvY2F0aW9uKHU4ICpidWYsIHNpemVf
dCBsZW4sIHU4ICpkZXN0LCB1OCAqc3JjLCBzaXplX3Qgc3JjX2xlbikKIHsKIAlpbnQgcHJldiwg
dGFyZ2V0ID0gMDsKIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYyBi
L2FyY2gveDg2L2tlcm5lbC9jYWxsdGh1bmtzLmMKaW5kZXggZDA5MjJjZjk0YzkwLi44MzJlYWVj
MzZlMmIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jYWxsdGh1bmtzLmMKKysrIGIvYXJj
aC94ODYva2VybmVsL2NhbGx0aHVua3MuYwpAQCAtMjQsNiArMjQsOCBAQAogCiBzdGF0aWMgaW50
IF9faW5pdGRhdGFfb3JfbW9kdWxlIGRlYnVnX2NhbGx0aHVua3M7CiAKKyNkZWZpbmUgTUFYX1BB
VENIX0xFTiAoMjU1LTEpCisKICNkZWZpbmUgcHJkYmcoZm10LCBhcmdzLi4uKQkJCQkJXAogZG8g
ewkJCQkJCQkJXAogCWlmIChkZWJ1Z19jYWxsdGh1bmtzKQkJCQkJXApAQCAtMTY5LDEwICsxNzEs
MTUgQEAgc3RhdGljIGNvbnN0IHU4IG5vcHNbXSA9IHsKIHN0YXRpYyB2b2lkICpwYXRjaF9kZXN0
KHZvaWQgKmRlc3QsIGJvb2wgZGlyZWN0KQogewogCXVuc2lnbmVkIGludCB0c2l6ZSA9IFNLTF9U
TVBMX1NJWkU7CisJdTggaW5zbl9idWZmW01BWF9QQVRDSF9MRU5dOwogCXU4ICpwYWQgPSBkZXN0
IC0gdHNpemU7CiAKKwltZW1jcHkoaW5zbl9idWZmLCBza2xfY2FsbF90aHVua190ZW1wbGF0ZSwg
dHNpemUpOworCWFwcGx5X3JlbG9jYXRpb24oaW5zbl9idWZmLCB0c2l6ZSwgcGFkLAorCQkJIHNr
bF9jYWxsX3RodW5rX3RlbXBsYXRlLCB0c2l6ZSk7CisKIAkvKiBBbHJlYWR5IHBhdGNoZWQ/ICov
Ci0JaWYgKCFiY21wKHBhZCwgc2tsX2NhbGxfdGh1bmtfdGVtcGxhdGUsIHRzaXplKSkKKwlpZiAo
IWJjbXAocGFkLCBpbnNuX2J1ZmYsIHRzaXplKSkKIAkJcmV0dXJuIHBhZDsKIAogCS8qIEVuc3Vy
ZSB0aGVyZSBhcmUgbm9wcyAqLwpAQCAtMTgyLDkgKzE4OSw5IEBAIHN0YXRpYyB2b2lkICpwYXRj
aF9kZXN0KHZvaWQgKmRlc3QsIGJvb2wgZGlyZWN0KQogCX0KIAogCWlmIChkaXJlY3QpCi0JCW1l
bWNweShwYWQsIHNrbF9jYWxsX3RodW5rX3RlbXBsYXRlLCB0c2l6ZSk7CisJCW1lbWNweShwYWQs
IGluc25fYnVmZiwgdHNpemUpOwogCWVsc2UKLQkJdGV4dF9wb2tlX2NvcHlfbG9ja2VkKHBhZCwg
c2tsX2NhbGxfdGh1bmtfdGVtcGxhdGUsIHRzaXplLCB0cnVlKTsKKwkJdGV4dF9wb2tlX2NvcHlf
bG9ja2VkKHBhZCwgaW5zbl9idWZmLCB0c2l6ZSwgdHJ1ZSk7CiAJcmV0dXJuIHBhZDsKIH0KIApA
QCAtMjgxLDIwICsyODgsMjcgQEAgdm9pZCAqY2FsbHRodW5rc190cmFuc2xhdGVfY2FsbF9kZXN0
KHZvaWQgKmRlc3QpCiBzdGF0aWMgYm9vbCBpc19jYWxsdGh1bmsodm9pZCAqYWRkcikKIHsKIAl1
bnNpZ25lZCBpbnQgdG1wbF9zaXplID0gU0tMX1RNUExfU0laRTsKLQl2b2lkICp0bXBsID0gc2ts
X2NhbGxfdGh1bmtfdGVtcGxhdGU7CisJdTggaW5zbl9idWZmW01BWF9QQVRDSF9MRU5dOwogCXVu
c2lnbmVkIGxvbmcgZGVzdDsKKwl1OCAqcGFkOwogCiAJZGVzdCA9IHJvdW5kdXAoKHVuc2lnbmVk
IGxvbmcpYWRkciwgQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVOVCk7CiAJaWYgKCF0aHVua3NfaW5p
dGlhbGl6ZWQgfHwgc2tpcF9hZGRyKCh2b2lkICopZGVzdCkpCiAJCXJldHVybiBmYWxzZTsKIAot
CXJldHVybiAhYmNtcCgodm9pZCAqKShkZXN0IC0gdG1wbF9zaXplKSwgdG1wbCwgdG1wbF9zaXpl
KTsKKwkqcGFkID0gZGVzdCAtIHRtcGxfc2l6ZTsKKworCW1lbWNweShpbnNuX2J1ZmYsIHNrbF9j
YWxsX3RodW5rX3RlbXBsYXRlLCB0bXBsX3NpemUpOworCWFwcGx5X3JlbG9jYXRpb24oaW5zbl9i
dWZmLCB0bXBsX3NpemUsIHBhZCwKKwkJCSBza2xfY2FsbF90aHVua190ZW1wbGF0ZSwgdG1wbF9z
aXplKTsKKworCXJldHVybiAhYmNtcChwYWQsIGluc25fYnVmZiwgdG1wbF9zaXplKTsKIH0KIAog
aW50IHg4Nl9jYWxsX2RlcHRoX2VtaXRfYWNjb3VudGluZyh1OCAqKnBwcm9nLCB2b2lkICpmdW5j
KQogewogCXVuc2lnbmVkIGludCB0bXBsX3NpemUgPSBTS0xfVE1QTF9TSVpFOwotCXZvaWQgKnRt
cGwgPSBza2xfY2FsbF90aHVua190ZW1wbGF0ZTsKKwl1OCBpbnNuX2J1ZmZbTUFYX1BBVENIX0xF
Tl07CiAKIAlpZiAoIXRodW5rc19pbml0aWFsaXplZCkKIAkJcmV0dXJuIDA7CkBAIC0zMDMsNyAr
MzE3LDExIEBAIGludCB4ODZfY2FsbF9kZXB0aF9lbWl0X2FjY291bnRpbmcodTggKipwcHJvZywg
dm9pZCAqZnVuYykKIAlpZiAoZnVuYyAmJiBpc19jYWxsdGh1bmsoZnVuYykpCiAJCXJldHVybiAw
OwogCi0JbWVtY3B5KCpwcHJvZywgdG1wbCwgdG1wbF9zaXplKTsKKwltZW1jcHkoaW5zbl9idWZm
LCBza2xfY2FsbF90aHVua190ZW1wbGF0ZSwgdG1wbF9zaXplKTsKKwlhcHBseV9yZWxvY2F0aW9u
KGluc25fYnVmZiwgdG1wbF9zaXplLCAqcHByb2csCisJCQkgc2tsX2NhbGxfdGh1bmtfdGVtcGxh
dGUsIHRtcGxfc2l6ZSk7CisKKwltZW1jcHkoKnBwcm9nLCBpbnNuX2J1ZmYsIHRtcGxfc2l6ZSk7
CiAJKnBwcm9nICs9IHRtcGxfc2l6ZTsKIAlyZXR1cm4gdG1wbF9zaXplOwogfQo=
--000000000000ae5b1106092a9b52--
