Return-Path: <linux-kernel+bounces-20066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95988278E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E77A1F23F35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3355C14;
	Mon,  8 Jan 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fSktbuRy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41955C0A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e4d64a3d8so1783105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704744283; x=1705349083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKaOcjr19a2vwIjqh7fHn9wNZxGyRA/jfnsAXF1KDq0=;
        b=fSktbuRyyDJ4bv941/9G+X2pgzuDFlWe9jmBVwIT/bhk2kCWjCjUFHJ2KEVBBQF9xs
         J//O5OXFuLj4GdmHa+mTRcxWQ3GWOf6v/7BZu41PltBjPvP2XWpVH54rIw9NL2sS1MFt
         3w2L57iF0PnUBjIy9ciO0jlFr1D5gpHp/uVcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744283; x=1705349083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKaOcjr19a2vwIjqh7fHn9wNZxGyRA/jfnsAXF1KDq0=;
        b=BERbcTHIcEK53kC1nRkDCdQS12lZG08bjFPTe7UmDd+Mh+QqmIcXP2GvKge9N9wKZa
         lINZe1Xul4beXEzfwckNEAft47KnPgWX57kXY26h2nx0Kt6YMLkAEFwzLQk0eRAktgdq
         NXTGDzhxclFO9SHeP2KgZFcL3Dt5E6gUfHzujN/kOGB+aqXIU3fkYH6l9w22k45hQkEJ
         tMSjTQdxpUvv4NEnyJc2YKB8sUE2ksAG5IvSLDVKsSP7KHVPdzsj9yJ0MjGZ1HCwWmdi
         SxKKBjFX0xuYRMjRjLCTo50Z0GGBqTGH11TQAOJUk93om8Gn1PzTx2t/D2zsmNH1lDNL
         yjSQ==
X-Gm-Message-State: AOJu0YwBfCPlcT4z1o+IaPsSlZzbaJJyEjvZx3nVhdltYSTWD/Um2wPz
	uv5hyiyXFMhLiE+Uq5NPeidhrEJMH/s+n86DnDFZlAZf68fOzJjA
X-Google-Smtp-Source: AGHT+IHPrbVXq0ZqHmdMIrJerXaxm/nNf1Ev/6FYD9PYk5vCCJcvgUjP//ZD1+PQVnARiamMzvRVlg==
X-Received: by 2002:a05:600c:1c28:b0:40e:4550:3b7a with SMTP id j40-20020a05600c1c2800b0040e45503b7amr1232072wms.123.1704744282742;
        Mon, 08 Jan 2024 12:04:42 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b00a26b44ac54dsm212768ejb.68.2024.01.08.12.04.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 12:04:42 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28bd9ca247so214699666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:04:42 -0800 (PST)
X-Received: by 2002:a17:907:26ce:b0:a27:4fe1:3087 with SMTP id
 bp14-20020a17090726ce00b00a274fe13087mr2399939ejc.18.1704744281725; Mon, 08
 Jan 2024 12:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com> <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
In-Reply-To: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 12:04:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
Message-ID: <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
To: Jiri Slaby <jirislaby@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: multipart/mixed; boundary="00000000000058812a060e74b521"

--00000000000058812a060e74b521
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 10:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, I'm sure this thing exists to a smaller degree elsewhere. I
> wonder if we could simplify our min/max type tests..

Hmm. Gcc seems to have fixed the old (horrid) behavior of warning
about comparing an unsigned variable with a (signed) positive constant
integer, which caused lots of completely unacceptable warnings.

Which means that maybe we could some day enable -Wsign-compare, if we
just fix all the cases we didn't care about because the warning was
fundamentally broken and useless anyway.

So we *could* plan on that, remove the checks from min/max, and use
something like the attached patch.

               Linus

--00000000000058812a060e74b521
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lr5coybp0>
X-Attachment-Id: f_lr5coybp0

IGFyY2gveDg2L01ha2VmaWxlICAgICAgICAgIHwgIDIgLS0KIGluY2x1ZGUvbGludXgvaXJxY2hp
cC5oICAgIHwgIDMgKysrCiBpbmNsdWRlL2xpbnV4L21pbm1heC5oICAgICB8IDMxICsrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGluaXQvS2NvbmZpZyAgICAgICAgICAgICAgIHwgIDQg
KysrKwogc2NyaXB0cy9NYWtlZmlsZS5leHRyYXdhcm4gfCAgMSArCiA1IGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L01ha2VmaWxlIGIvYXJjaC94ODYvTWFrZWZpbGUKaW5kZXggMWEwNjhkZTEyYTU2Li5iNDk5NGVi
OTM0YmMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L01ha2VmaWxlCisrKyBiL2FyY2gveDg2L01ha2Vm
aWxlCkBAIC0xODYsOCArMTg2LDYgQEAgaWZlcSAoJChBQ0NVTVVMQVRFX09VVEdPSU5HX0FSR1Mp
LCAxKQogCUtCVUlMRF9DRkxBR1MgKz0gJChjYWxsIGNjLW9wdGlvbiwtbWFjY3VtdWxhdGUtb3V0
Z29pbmctYXJncywpCiBlbmRpZgogCi0jIFdvcmthcm91bmQgZm9yIGEgZ2NjIHByZWxlYXNlIHRo
YXQgdW5mb3J0dW5hdGVseSB3YXMgc2hpcHBlZCBpbiBhIHN1c2UgcmVsZWFzZQotS0JVSUxEX0NG
TEFHUyArPSAtV25vLXNpZ24tY29tcGFyZQogIwogS0JVSUxEX0NGTEFHUyArPSAtZm5vLWFzeW5j
aHJvbm91cy11bndpbmQtdGFibGVzCiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaXJxY2hp
cC5oIGIvaW5jbHVkZS9saW51eC9pcnFjaGlwLmgKaW5kZXggZDVlNjAyNGNiMmE4Li42NDg4ZjNh
M2NhNWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaXJxY2hpcC5oCisrKyBiL2luY2x1ZGUv
bGludXgvaXJxY2hpcC5oCkBAIC0yMCw2ICsyMCw5IEBACiAvKiBVbmRlZmluZWQgb24gcHVycG9z
ZSAqLwogZXh0ZXJuIG9mX2lycV9pbml0X2NiX3QgdHlwZWNoZWNrX2lycV9pbml0X2NiOwogCisj
ZGVmaW5lIF9fdHlwZWNoZWNrKHgsIHkpIFwKKwkoISEoc2l6ZW9mKCh0eXBlb2YoeCkgKikxID09
ICh0eXBlb2YoeSkgKikxKSkpCisKICNkZWZpbmUgdHlwZWNoZWNrX2lycV9pbml0X2NiKGZuKQkJ
CQkJXAogCShfX3R5cGVjaGVjayh0eXBlY2hlY2tfaXJxX2luaXRfY2IsICZmbikgPyBmbiA6IGZu
KQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oIGIvaW5jbHVkZS9saW51eC9t
aW5tYXguaAppbmRleCAyZWM1NTkyODRhOWYuLmIyZTQyYzc0MTg1OSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9taW5tYXguaAorKysgYi9pbmNsdWRlL2xpbnV4L21pbm1heC5oCkBAIC04LDM3
ICs4LDE2IEBACiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KIAogLyoKLSAqIG1pbigpL21heCgp
L2NsYW1wKCkgbWFjcm9zIG11c3QgYWNjb21wbGlzaCB0aHJlZSB0aGluZ3M6CisgKiBtaW4oKS9t
YXgoKS9jbGFtcCgpIG1hY3JvcyBtdXN0IGFjY29tcGxpc2ggdHdvIHRoaW5nczoKICAqCiAgKiAt
IEF2b2lkIG11bHRpcGxlIGV2YWx1YXRpb25zIG9mIHRoZSBhcmd1bWVudHMgKHNvIHNpZGUtZWZm
ZWN0cyBsaWtlCiAgKiAgICJ4KysiIGhhcHBlbiBvbmx5IG9uY2UpIHdoZW4gbm9uLWNvbnN0YW50
LgogICogLSBSZXRhaW4gcmVzdWx0IGFzIGEgY29uc3RhbnQgZXhwcmVzc2lvbnMgd2hlbiBjYWxs
ZWQgd2l0aCBvbmx5CiAgKiAgIGNvbnN0YW50IGV4cHJlc3Npb25zICh0byBhdm9pZCB0cmlwcGlu
ZyBWTEEgd2FybmluZ3MgaW4gc3RhY2sKICAqICAgYWxsb2NhdGlvbiB1c2FnZSkuCi0gKiAtIFBl
cmZvcm0gc2lnbmVkIHYgdW5zaWduZWQgdHlwZS1jaGVja2luZyAodG8gZ2VuZXJhdGUgY29tcGls
ZQotICogICBlcnJvcnMgaW5zdGVhZCBvZiBuYXN0eSBydW50aW1lIHN1cnByaXNlcykuCi0gKiAt
IFVuc2lnbmVkIGNoYXIvc2hvcnQgYXJlIGFsd2F5cyBwcm9tb3RlZCB0byBzaWduZWQgaW50IGFu
ZCBjYW4gYmUKLSAqICAgY29tcGFyZWQgYWdhaW5zdCBzaWduZWQgb3IgdW5zaWduZWQgYXJndW1l
bnRzLgotICogLSBVbnNpZ25lZCBhcmd1bWVudHMgY2FuIGJlIGNvbXBhcmVkIGFnYWluc3Qgbm9u
LW5lZ2F0aXZlIHNpZ25lZCBjb25zdGFudHMuCi0gKiAtIENvbXBhcmlzb24gb2YgYSBzaWduZWQg
YXJndW1lbnQgYWdhaW5zdCBhbiB1bnNpZ25lZCBjb25zdGFudCBmYWlscwotICogICBldmVuIGlm
IHRoZSBjb25zdGFudCBpcyBiZWxvdyBfX0lOVF9NQVhfXyBhbmQgY291bGQgYmUgY2FzdCB0byBp
bnQuCisgKgorICogSG9wZWZ1bGx5LCBzaWduIGNvbXBhcmlzb24gd2FybmluZ3MgY2FuIGJlIGRv
bmUgYnkgdGhlIGNvbXBpbGVycy4KICAqLwotI2RlZmluZSBfX3R5cGVjaGVjayh4LCB5KSBcCi0J
KCEhKHNpemVvZigodHlwZW9mKHgpICopMSA9PSAodHlwZW9mKHkpICopMSkpKQotCi0vKiBpc19z
aWduZWRfdHlwZSgpIGlzbid0IGEgY29uc3RleHByIGZvciBwb2ludGVyIHR5cGVzICovCi0jZGVm
aW5lIF9faXNfc2lnbmVkKHgpIAkJCQkJCQkJXAotCV9fYnVpbHRpbl9jaG9vc2VfZXhwcihfX2lz
X2NvbnN0ZXhwcihpc19zaWduZWRfdHlwZSh0eXBlb2YoeCkpKSwJXAotCQlpc19zaWduZWRfdHlw
ZSh0eXBlb2YoeCkpLCAwKQotCi0vKiBUcnVlIGZvciBhIG5vbi1uZWdhdGl2ZSBzaWduZWQgaW50
IGNvbnN0YW50ICovCi0jZGVmaW5lIF9faXNfbm9uZWdfaW50KHgpCVwKLQkoX19idWlsdGluX2No
b29zZV9leHByKF9faXNfY29uc3RleHByKHgpICYmIF9faXNfc2lnbmVkKHgpLCB4LCAtMSkgPj0g
MCkKLQotI2RlZmluZSBfX3R5cGVzX29rKHgsIHkpIAkJCQkJXAotCShfX2lzX3NpZ25lZCh4KSA9
PSBfX2lzX3NpZ25lZCh5KSB8fAkJCVwKLQkJX19pc19zaWduZWQoKHgpICsgMCkgPT0gX19pc19z
aWduZWQoKHkpICsgMCkgfHwJXAotCQlfX2lzX25vbmVnX2ludCh4KSB8fCBfX2lzX25vbmVnX2lu
dCh5KSkKIAogI2RlZmluZSBfX2NtcF9vcF9taW4gPAogI2RlZmluZSBfX2NtcF9vcF9tYXggPgpA
QCAtNDgsOCArMjcsNiBAQAogI2RlZmluZSBfX2NtcF9vbmNlKG9wLCB4LCB5LCB1bmlxdWVfeCwg
dW5pcXVlX3kpICh7CVwKIAl0eXBlb2YoeCkgdW5pcXVlX3ggPSAoeCk7CQkJXAogCXR5cGVvZih5
KSB1bmlxdWVfeSA9ICh5KTsJCQlcCi0Jc3RhdGljX2Fzc2VydChfX3R5cGVzX29rKHgsIHkpLAkJ
CVwKLQkJI29wICIoIiAjeCAiLCAiICN5ICIpIHNpZ25lZG5lc3MgZXJyb3IsIGZpeCB0eXBlcyBv
ciBjb25zaWRlciB1IiAjb3AgIigpIGJlZm9yZSAiICNvcCAiX3QoKSIpOyBcCiAJX19jbXAob3As
IHVuaXF1ZV94LCB1bmlxdWVfeSk7IH0pCiAKICNkZWZpbmUgX19jYXJlZnVsX2NtcChvcCwgeCwg
eSkJCQkJCVwKQEAgLTY3LDggKzQ0LDYgQEAKIAlzdGF0aWNfYXNzZXJ0KF9fYnVpbHRpbl9jaG9v
c2VfZXhwcihfX2lzX2NvbnN0ZXhwcigobG8pID4gKGhpKSksIAlcCiAJCQkobG8pIDw9IChoaSks
IHRydWUpLAkJCQkJXAogCQkiY2xhbXAoKSBsb3cgbGltaXQgIiAjbG8gIiBncmVhdGVyIHRoYW4g
aGlnaCBsaW1pdCAiICNoaSk7CVwKLQlzdGF0aWNfYXNzZXJ0KF9fdHlwZXNfb2sodmFsLCBsbyks
ICJjbGFtcCgpICdsbycgc2lnbmVkbmVzcyBlcnJvciIpOwlcCi0Jc3RhdGljX2Fzc2VydChfX3R5
cGVzX29rKHZhbCwgaGkpLCAiY2xhbXAoKSAnaGknIHNpZ25lZG5lc3MgZXJyb3IiKTsJXAogCV9f
Y2xhbXAodW5pcXVlX3ZhbCwgdW5pcXVlX2xvLCB1bmlxdWVfaGkpOyB9KQogCiAjZGVmaW5lIF9f
Y2FyZWZ1bF9jbGFtcCh2YWwsIGxvLCBoaSkgKHsJCQkJCVwKZGlmZiAtLWdpdCBhL2luaXQvS2Nv
bmZpZyBiL2luaXQvS2NvbmZpZwppbmRleCA5ZmZiMTAzZmM5MjcuLjAyNDUyNTMyMDNjMCAxMDA2
NDQKLS0tIGEvaW5pdC9LY29uZmlnCisrKyBiL2luaXQvS2NvbmZpZwpAQCAtODc2LDYgKzg3Niwx
MCBAQCBjb25maWcgQ0NfTk9fQVJSQVlfQk9VTkRTCiAJYm9vbAogCWRlZmF1bHQgeSBpZiBDQ19J
U19HQ0MgJiYgR0NDX1ZFUlNJT04gPj0gMTEwMDAwICYmIEdDQzExX05PX0FSUkFZX0JPVU5EUwog
CisjIC1Xc2lnbi1jb21wYXJlIGhhcyB0cmFkaXRpb25hbGx5IGJlZW4gaG9ycmlmaWMKK2NvbmZp
ZyBDQ19OT19TSUdOX0NPTVBBUkUKKwlib29sCisJZGVmYXVsdCB5CiAjCiAjIEZvciBhcmNoaXRl
Y3R1cmVzIHRoYXQga25vdyB0aGVpciBHQ0MgX19pbnQxMjggc3VwcG9ydCBpcyBzb3VuZAogIwpk
aWZmIC0tZ2l0IGEvc2NyaXB0cy9NYWtlZmlsZS5leHRyYXdhcm4gYi9zY3JpcHRzL01ha2VmaWxl
LmV4dHJhd2FybgppbmRleCAyZmU2ZjI4MjhkMzcuLmVkZWYwY2JjZjdkNCAxMDA2NDQKLS0tIGEv
c2NyaXB0cy9NYWtlZmlsZS5leHRyYXdhcm4KKysrIGIvc2NyaXB0cy9NYWtlZmlsZS5leHRyYXdh
cm4KQEAgLTI1LDYgKzI1LDcgQEAgZW5kaWYKIEtCVUlMRF9DUFBGTEFHUy0kKENPTkZJR19XRVJS
T1IpICs9IC1XZXJyb3IKIEtCVUlMRF9DUFBGTEFHUyArPSAkKEtCVUlMRF9DUFBGTEFHUy15KQog
S0JVSUxEX0NGTEFHUy0kKENPTkZJR19DQ19OT19BUlJBWV9CT1VORFMpICs9IC1Xbm8tYXJyYXkt
Ym91bmRzCitLQlVJTERfQ0ZMQUdTLSQoQ09ORklHX0NDX05PX1NJR05fQ09NUEFSRSkgKz0gLVdu
by1zaWduLWNvbXBhcmUKIAogaWZkZWYgQ09ORklHX0NDX0lTX0NMQU5HCiAjIFRoZSBrZXJuZWwg
YnVpbGRzIHdpdGggJy1zdGQ9Z251MTEnIHNvIHVzZSBvZiBHTlUgZXh0ZW5zaW9ucyBpcyBhY2Nl
cHRhYmxlLgo=
--00000000000058812a060e74b521--

