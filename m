Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2507B0B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjI0Rsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Rsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:48:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56796A1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1498394866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695836918; x=1696441718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVfo3IwQ/RTkqzINk2Et8vGqwK+wAQzTwLtlllfdR+g=;
        b=N4q5i4/4mytt4AGIf/kpdNYizlCS0wOnWt3ZXUUCSDLPyMmOLkOsgOamSLvjVQushv
         WOmN/OMFQC64v8ip4jK+Rat3KElRJQ2npWRqIgi16djwTm0S8XY8hvodh6kOrzwFrfWy
         7XulAZpjs82oeapYPxXakZuiq8/yqSUulwFBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836918; x=1696441718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVfo3IwQ/RTkqzINk2Et8vGqwK+wAQzTwLtlllfdR+g=;
        b=AGHALXaRsv6R9YeIl99bwXToAPMkmaMbW84iiq0GwHLO5KTxukjFpvAN8qCBc8aOc6
         mpuf6Ls2+4mLkhVMLSFwlk08A2eQrda3NPDURhZH53Zo19vObtf4ndJfvynlT7cm32pl
         VCfRNxevG7orhIUSBJcoPjSjBpRe+smUGFup7Sr7ho/q5AI2TyzIaGbXaOBgO8G/bkkb
         JW+skHwULunZfFH/dSWRcgTmByrOfM+4SuwnqWPPfdmGX2yuv7D0XUv2UWBKN5obH0ae
         yO0e7yX6vSV+dbHIwn4nMlXK2pMh0Loj1ciAd7LXtaoqCJwN1lQOWJ4UQORkj8IZavDh
         nXLQ==
X-Gm-Message-State: AOJu0Yyyb3b75p6yumt5fBpIR21+MJV1/OtOG7226+8DtIrKF+USPj5T
        3QCuKZ1X3gEqtiYiFIVhc7sKVQlYKkKEPGtPDSmAoA==
X-Google-Smtp-Source: AGHT+IGL7F3G08GkDuwtqx+CySAH1ptXy8A2dLY2vdM+sYDwq9Pwr3MC4NyE/jAeyjMOaZ3NDhCF/Q==
X-Received: by 2002:a17:907:6d11:b0:9ae:6a08:6f53 with SMTP id sa17-20020a1709076d1100b009ae6a086f53mr3130854ejc.63.1695836918509;
        Wed, 27 Sep 2023 10:48:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090652cc00b0099364d9f0e6sm9592163ejn.117.2023.09.27.10.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 10:48:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5310a63cf7bso13744825a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:aa7:c406:0:b0:52e:9eff:1e5f with SMTP id
 j6-20020aa7c406000000b0052e9eff1e5fmr2377804edq.15.1695836917305; Wed, 27 Sep
 2023 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com> <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
In-Reply-To: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 10:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
Message-ID: <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000dc77506065acdeb"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000dc77506065acdeb
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Sept 2023 at 07:10, Christian Brauner <brauner@kernel.org> wrote:
>
> No need to resend I can massage this well enough in-tree.

Hmm. Please do, but here's some more food for thought for at least the
commit message.

Because there's more than the "__fput_sync()" issue at hand, we have
another delayed thing that this patch ends up short-circuiting, which
wasn't obvious from the original description.

I'm talking about the fact that our existing "file_free()" ends up
doing the actual release with

        call_rcu(&f->f_rcuhead, file_free_rcu);

and the patch under discussion avoids that part too.

And I actually like that it avoids it, I just think it should be
mentioned explicitly, because it wasn't obvious to me until I actually
looked at the old __fput() path. Particularly since it means that the
f_creds are free'd synchronously now.

I do think that's fine, although I forget what path it was that
required that rcu-delayed cred freeing. Worth mentioning, and maybe
worth thinking about.

However, when I *did* look at it, it strikes me that we could do this
differently.

Something like this (ENTIRELY UNTESTED) patch, which just moves this
logic into fput() itself.

Again: ENTIRELY UNTESTED, and I might easily have screwed up. But it
looks simpler and more straightforward to me. But again: that may be
because I missed something.

             Linus

--0000000000000dc77506065acdeb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ln21i4ht0>
X-Attachment-Id: f_ln21i4ht0

IGZzL2ZpbGVfdGFibGUuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMv
ZmlsZV90YWJsZS5jCmluZGV4IGVlMjFiM2RhOWQwOC4uNGZiODdhMDM4MmQ5IDEwMDY0NAotLS0g
YS9mcy9maWxlX3RhYmxlLmMKKysrIGIvZnMvZmlsZV90YWJsZS5jCkBAIC00MzAsMTEgKzQzMCwz
MyBAQCBFWFBPUlRfU1lNQk9MX0dQTChmbHVzaF9kZWxheWVkX2ZwdXQpOwogCiBzdGF0aWMgREVD
TEFSRV9ERUxBWUVEX1dPUksoZGVsYXllZF9mcHV0X3dvcmssIGRlbGF5ZWRfZnB1dCk7CiAKKy8q
CisgKiBDYWxsZWQgZm9yIGZpbGVzIHRoYXQgd2VyZSBuZXZlciBmdWxseSBvcGVuZWQsIGFuZAor
ICogZG9uJ3QgbmVlZCB0aGUgUkNVLWRlbGF5ZWQgZnJlZWluZzogdGhleSBoYXZlIG5ldmVyCisg
KiBiZWVuIGFjY2Vzc2VkIGluIGFueSBvdGhlciBjb250ZXh0LgorICovCitzdGF0aWMgdm9pZCBm
cHV0X2ltbWVkaWF0ZShzdHJ1Y3QgZmlsZSAqZikKK3sKKwlzZWN1cml0eV9maWxlX2ZyZWUoZik7
CisJcHV0X2NyZWQoZi0+Zl9jcmVkKTsKKwlpZiAobGlrZWx5KCEoZi0+Zl9tb2RlICYgRk1PREVf
Tk9BQ0NPVU5UKSkpCisJCXBlcmNwdV9jb3VudGVyX2RlYygmbnJfZmlsZXMpOworCWlmICh1bmxp
a2VseShmLT5mX21vZGUgJiBGTU9ERV9CQUNLSU5HKSkgeworCQlwYXRoX3B1dChiYWNraW5nX2Zp
bGVfcmVhbF9wYXRoKGYpKTsKKwkJa2ZyZWUoYmFja2luZ19maWxlKGYpKTsKKwl9IGVsc2Ugewor
CQlrbWVtX2NhY2hlX2ZyZWUoZmlscF9jYWNoZXAsIGYpOworCX0KK30KKwogdm9pZCBmcHV0KHN0
cnVjdCBmaWxlICpmaWxlKQogewogCWlmIChhdG9taWNfbG9uZ19kZWNfYW5kX3Rlc3QoJmZpbGUt
PmZfY291bnQpKSB7CiAJCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGN1cnJlbnQ7CiAKKwkJ
aWYgKHVubGlrZWx5KCEoZmlsZS0+Zl9tb2RlICYgRk1PREVfT1BFTkVEKSkpCisJCQlyZXR1cm4g
ZnB1dF9pbW1lZGlhdGUoZmlsZSk7CisKIAkJaWYgKGxpa2VseSghaW5faW50ZXJydXB0KCkgJiYg
ISh0YXNrLT5mbGFncyAmIFBGX0tUSFJFQUQpKSkgewogCQkJaW5pdF90YXNrX3dvcmsoJmZpbGUt
PmZfcmN1aGVhZCwgX19fX2ZwdXQpOwogCQkJaWYgKCF0YXNrX3dvcmtfYWRkKHRhc2ssICZmaWxl
LT5mX3JjdWhlYWQsIFRXQV9SRVNVTUUpKQo=
--0000000000000dc77506065acdeb--
