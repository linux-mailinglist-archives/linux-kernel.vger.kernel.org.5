Return-Path: <linux-kernel+bounces-20352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3D827D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D171F2242B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1CDDAA;
	Tue,  9 Jan 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLLIbgxE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7779C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e4d64a3fbso4860735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704772680; x=1705377480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45zM0R9q7VfUYNYi2fe7xJF+eCb1AlHM9xpqWPMm6Ho=;
        b=GLLIbgxEYMKvKRfiVbztyzLY0DBxYIS46gDYvheNry/w/b+WwJnRfD2pBBzptQiI5g
         vl5WbshU7L4bBkQqJd6qtOjSok3BdtAuGyDyw9dA35jk1f6XKQDSE8MuV4BVM7X5ojTw
         TU87sgV4RbGar7ae+l/nRgNlZY12fSWItF6M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704772680; x=1705377480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45zM0R9q7VfUYNYi2fe7xJF+eCb1AlHM9xpqWPMm6Ho=;
        b=f8qcRcZO7y4kTaixWmmHHIrpu5xby8RnYZB7pYyOz4OAhcgKJNFoaT2eLYYe5X0MmK
         nbQKkIHlRcOxuj4ngDhPhdSR4TzXsRq3VeGdxktlrerCr6DOtYqHAtWMTgjZt/7vvcjW
         rXj54G7K274MGWKV0fXl7fi+2dnEjGCP4jbIed/Hc0HRfGQd4DhRi8H7vtRXhtkrByyU
         ALfD92PZniuSYtoxV254mSz4d4YLvGPfm+x4FbzAEvkRjjo7FXQfDnxQam5sdocGnO/W
         GknACtHjxf4w0waE3alZCNIWhQotO0y1YCtbkrjAY1DFf/ECW1rugFo75icdYqQDiAVD
         D6Yg==
X-Gm-Message-State: AOJu0YxPbZPTDCrYe5ggmGmpSETfTjGSFX7xYeenn1yts55updOOkFtm
	/17a+XB0IxDOackOIUjjbSUOBm6AvXkamOxYFA3SMb6Ih0lKAadU
X-Google-Smtp-Source: AGHT+IG8ecKOmQqOnXjN/TNInEsky+JykxDRJutlKHhFaVmdM0kHH3RvXLLtt6I+6LiYnyEJRJy3Vw==
X-Received: by 2002:a05:600c:3acb:b0:40e:47dd:1c62 with SMTP id d11-20020a05600c3acb00b0040e47dd1c62mr1063345wms.124.1704772679770;
        Mon, 08 Jan 2024 19:57:59 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906250c00b00a2693ce340csm556253ejb.59.2024.01.08.19.57.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 19:57:58 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2ac304e526so145107566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:57:58 -0800 (PST)
X-Received: by 2002:a17:906:f288:b0:a27:7959:a5a6 with SMTP id
 gu8-20020a170906f28800b00a277959a5a6mr196960ejb.89.1704772677875; Mon, 08 Jan
 2024 19:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZvd5KZKVXAtM1+F@gmail.com> <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
In-Reply-To: <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 19:57:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOJOOyWvZOUsKppD068H3D=5dzQOJv5j2DU4rDPsJBBg@mail.gmail.com>
Message-ID: <CAHk-=wiOJOOyWvZOUsKppD068H3D=5dzQOJv5j2DU4rDPsJBBg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v6.8
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000e35a5b060e7b51e8"

--000000000000e35a5b060e7b51e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 18:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This does not even compile for me.
>
>   arch/x86/include/asm/uaccess_64.h: In function =E2=80=98__untagged_addr=
=E2=80=99:
>   arch/x86/include/asm/uaccess_64.h:25:28: error: implicit declaration
> of function =E2=80=98__my_cpu_var=E2=80=99; did you mean =E2=80=98put_cpu=
_var=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]

Side note: the whole __my_cpu_var() reminds me of the attached patch
that I have in my testing tree, and have been carrying along for a
number of months now.

I definitely think it's the right thing to do, so here it is again,
even if it is only tangentially related to the build failure wrt this
broken pull request.

                   Linus

--000000000000e35a5b060e7b51e8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-clean-up-fpu-switching-to-not-load-current-in-th.patch"
Content-Disposition: attachment; 
	filename="0001-x86-clean-up-fpu-switching-to-not-load-current-in-th.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lr5tm9ag0>
X-Attachment-Id: f_lr5tm9ag0

RnJvbSAxNGY4MWNmZDNhYTNiNTNiZTlhZDA1ODAxY2RjN2Q3ZGU5MWY4MDdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgMTYgT2N0IDIwMjMgMTY6MDQ6MTEgLTA3MDAKU3ViamVjdDog
W1BBVENIXSB4ODY6IGNsZWFuIHVwIGZwdSBzd2l0Y2hpbmcgdG8gbm90IGxvYWQgJ2N1cnJlbnQn
IGluIHRoZQogbWlkZGxlIG9mIHRhc2sgc3dpdGNoaW5nCgpJdCBoYXBwZW5zIHRvIHdvcmssIGJ1
dCBpdCdzIHZlcnkgdmVyeSB3cm9uZywgYmVjYXVzZSBvdXQgJ2N1cnJlbnQnCm1hY3JvIGlzIG1h
Z2ljIHRoYXQgaXMgc3VwcG9zZWRseSBsb2FkaW5nIGEgc3RhYmxlIHZhbHVlLgoKSXQganVzdCBo
YXBwZW5zIHRvIGJlIG5vdCBxdWl0ZSBzdGFibGUgZW5vdWdoIGFuZCB0aGUgY29tcGlsZXJzIHJl
LWxvYWQKdGhlIHZhbHVlIGVub3VnaCBmb3IgdGhpcyBjb2RlIHRvIHdvcmsuICBCdXQgaXQncyB3
cm9uZy4KCkl0IGFsc28gZ2VuZXJhdGVzIHdvcnNlIGNvZGUuCgpTbyBmaXggaXQuCgpTaWduZWQt
b2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0t
LQogYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L3NjaGVkLmggfCAxMCArKysrKystLS0tCiBhcmNo
L3g4Ni9rZXJuZWwvcHJvY2Vzc18zMi5jICAgICB8ICA3ICsrKy0tLS0KIGFyY2gveDg2L2tlcm5l
bC9wcm9jZXNzXzY0LmMgICAgIHwgIDcgKysrLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9mcHUvc2NoZWQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9zY2hlZC5oCmluZGV4
IGNhNmU1ZTVmMTZiMi4uYzQ4NWYxOTQ0YzVmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9mcHUvc2NoZWQuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvc2NoZWQuaApA
QCAtMzcsMTAgKzM3LDEyIEBAIGV4dGVybiB2b2lkIGZwdV9mbHVzaF90aHJlYWQodm9pZCk7CiAg
KiBUaGUgRlBVIGNvbnRleHQgaXMgb25seSBzdG9yZWQvcmVzdG9yZWQgZm9yIGEgdXNlciB0YXNr
IGFuZAogICogUEZfS1RIUkVBRCBpcyB1c2VkIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4ga2VybmVs
IGFuZCB1c2VyIHRocmVhZHMuCiAgKi8KLXN0YXRpYyBpbmxpbmUgdm9pZCBzd2l0Y2hfZnB1X3By
ZXBhcmUoc3RydWN0IGZwdSAqb2xkX2ZwdSwgaW50IGNwdSkKK3N0YXRpYyBpbmxpbmUgdm9pZCBz
d2l0Y2hfZnB1X3ByZXBhcmUoc3RydWN0IHRhc2tfc3RydWN0ICpvbGQsIGludCBjcHUpCiB7CiAJ
aWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfRlBVKSAmJgotCSAgICAhKGN1cnJl
bnQtPmZsYWdzICYgKFBGX0tUSFJFQUQgfCBQRl9VU0VSX1dPUktFUikpKSB7CisJICAgICEob2xk
LT5mbGFncyAmIChQRl9LVEhSRUFEIHwgUEZfVVNFUl9XT1JLRVIpKSkgeworCQlzdHJ1Y3QgZnB1
ICpvbGRfZnB1ID0gJm9sZC0+dGhyZWFkLmZwdTsKKwogCQlzYXZlX2ZwcmVnc190b19mcHN0YXRl
KG9sZF9mcHUpOwogCQkvKgogCQkgKiBUaGUgc2F2ZSBvcGVyYXRpb24gcHJlc2VydmVkIHJlZ2lz
dGVyIHN0YXRlLCBzbyB0aGUKQEAgLTYwLDEwICs2MiwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
c3dpdGNoX2ZwdV9wcmVwYXJlKHN0cnVjdCBmcHUgKm9sZF9mcHUsIGludCBjcHUpCiAgKiBEZWxh
eSBsb2FkaW5nIG9mIHRoZSBjb21wbGV0ZSBGUFUgc3RhdGUgdW50aWwgdGhlIHJldHVybiB0byB1
c2VybGFuZC4KICAqIFBLUlUgaXMgaGFuZGxlZCBzZXBhcmF0ZWx5LgogICovCi1zdGF0aWMgaW5s
aW5lIHZvaWQgc3dpdGNoX2ZwdV9maW5pc2godm9pZCkKK3N0YXRpYyBpbmxpbmUgdm9pZCBzd2l0
Y2hfZnB1X2ZpbmlzaChzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5ldykKIHsKIAlpZiAoY3B1X2ZlYXR1
cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUFUpKQotCQlzZXRfdGhyZWFkX2ZsYWcoVElGX05FRURf
RlBVX0xPQUQpOworCQlzZXRfdHNrX3RocmVhZF9mbGFnKG5ldywgVElGX05FRURfRlBVX0xPQUQp
OwogfQogCiAjZW5kaWYgLyogX0FTTV9YODZfRlBVX1NDSEVEX0ggKi8KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9wcm9jZXNzXzMyLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc18zMi5j
CmluZGV4IDcwOGM4N2I4OGNjMS4uMDkxN2M3ZjI1NzIwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzc18zMi5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzMyLmMKQEAg
LTE1NiwxMyArMTU2LDEyIEBAIF9fc3dpdGNoX3RvKHN0cnVjdCB0YXNrX3N0cnVjdCAqcHJldl9w
LCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHRfcCkKIHsKIAlzdHJ1Y3QgdGhyZWFkX3N0cnVjdCAq
cHJldiA9ICZwcmV2X3AtPnRocmVhZCwKIAkJCSAgICAgKm5leHQgPSAmbmV4dF9wLT50aHJlYWQ7
Ci0Jc3RydWN0IGZwdSAqcHJldl9mcHUgPSAmcHJldi0+ZnB1OwogCWludCBjcHUgPSBzbXBfcHJv
Y2Vzc29yX2lkKCk7CiAKIAkvKiBuZXZlciBwdXQgYSBwcmludGsgaW4gX19zd2l0Y2hfdG8uLi4g
cHJpbnRrKCkgY2FsbHMgd2FrZV91cCooKSBpbmRpcmVjdGx5ICovCiAKLQlpZiAoIXRlc3RfdGhy
ZWFkX2ZsYWcoVElGX05FRURfRlBVX0xPQUQpKQotCQlzd2l0Y2hfZnB1X3ByZXBhcmUocHJldl9m
cHUsIGNwdSk7CisJaWYgKCF0ZXN0X3Rza190aHJlYWRfZmxhZyhwcmV2X3AsIFRJRl9ORUVEX0ZQ
VV9MT0FEKSkKKwkJc3dpdGNoX2ZwdV9wcmVwYXJlKHByZXZfcCwgY3B1KTsKIAogCS8qCiAJICog
U2F2ZSBhd2F5ICVncy4gTm8gbmVlZCB0byBzYXZlICVmcywgYXMgaXQgd2FzIHNhdmVkIG9uIHRo
ZQpAQCAtMjA5LDcgKzIwOCw3IEBAIF9fc3dpdGNoX3RvKHN0cnVjdCB0YXNrX3N0cnVjdCAqcHJl
dl9wLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHRfcCkKIAogCXJhd19jcHVfd3JpdGUocGNwdV9o
b3QuY3VycmVudF90YXNrLCBuZXh0X3ApOwogCi0Jc3dpdGNoX2ZwdV9maW5pc2goKTsKKwlzd2l0
Y2hfZnB1X2ZpbmlzaChuZXh0X3ApOwogCiAJLyogTG9hZCB0aGUgSW50ZWwgY2FjaGUgYWxsb2Nh
dGlvbiBQUVIgTVNSLiAqLwogCXJlc2N0cmxfc2NoZWRfaW4obmV4dF9wKTsKZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182
NC5jCmluZGV4IDMzYjI2ODc0N2JiNy4uMTU1M2UxOTkwNGUwIDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvcHJvY2Vzc182NC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0LmMK
QEAgLTU2MiwxNCArNTYyLDEzIEBAIF9fc3dpdGNoX3RvKHN0cnVjdCB0YXNrX3N0cnVjdCAqcHJl
dl9wLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHRfcCkKIHsKIAlzdHJ1Y3QgdGhyZWFkX3N0cnVj
dCAqcHJldiA9ICZwcmV2X3AtPnRocmVhZDsKIAlzdHJ1Y3QgdGhyZWFkX3N0cnVjdCAqbmV4dCA9
ICZuZXh0X3AtPnRocmVhZDsKLQlzdHJ1Y3QgZnB1ICpwcmV2X2ZwdSA9ICZwcmV2LT5mcHU7CiAJ
aW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKIAogCVdBUk5fT05fT05DRShJU19FTkFCTEVE
KENPTkZJR19ERUJVR19FTlRSWSkgJiYKIAkJICAgICB0aGlzX2NwdV9yZWFkKHBjcHVfaG90Lmhh
cmRpcnFfc3RhY2tfaW51c2UpKTsKIAotCWlmICghdGVzdF90aHJlYWRfZmxhZyhUSUZfTkVFRF9G
UFVfTE9BRCkpCi0JCXN3aXRjaF9mcHVfcHJlcGFyZShwcmV2X2ZwdSwgY3B1KTsKKwlpZiAoIXRl
c3RfdHNrX3RocmVhZF9mbGFnKHByZXZfcCwgVElGX05FRURfRlBVX0xPQUQpKQorCQlzd2l0Y2hf
ZnB1X3ByZXBhcmUocHJldl9wLCBjcHUpOwogCiAJLyogV2UgbXVzdCBzYXZlICVmcyBhbmQgJWdz
IGJlZm9yZSBsb2FkX1RMUygpIGJlY2F1c2UKIAkgKiAlZnMgYW5kICVncyBtYXkgYmUgY2xlYXJl
ZCBieSBsb2FkX1RMUygpLgpAQCAtNjIzLDcgKzYyMiw3IEBAIF9fc3dpdGNoX3RvKHN0cnVjdCB0
YXNrX3N0cnVjdCAqcHJldl9wLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHRfcCkKIAlyYXdfY3B1
X3dyaXRlKHBjcHVfaG90LmN1cnJlbnRfdGFzaywgbmV4dF9wKTsKIAlyYXdfY3B1X3dyaXRlKHBj
cHVfaG90LnRvcF9vZl9zdGFjaywgdGFza190b3Bfb2Zfc3RhY2sobmV4dF9wKSk7CiAKLQlzd2l0
Y2hfZnB1X2ZpbmlzaCgpOworCXN3aXRjaF9mcHVfZmluaXNoKG5leHRfcCk7CiAKIAkvKiBSZWxv
YWQgc3AwLiAqLwogCXVwZGF0ZV90YXNrX3N0YWNrKG5leHRfcCk7Ci0tIAoyLjQzLjAuNS5nMzhm
YjEzN2JkYgoK
--000000000000e35a5b060e7b51e8--

