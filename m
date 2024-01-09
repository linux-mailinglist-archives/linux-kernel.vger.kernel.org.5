Return-Path: <linux-kernel+bounces-20207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F7827BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18852B2288B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF7939E;
	Tue,  9 Jan 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XiTh5vwo"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E418191
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33677fb38a3so2560178f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704759604; x=1705364404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WOoPbj1TfvnHYvIjlhZpF7Ke3bdIdyWQQkhfFJGvHco=;
        b=XiTh5vwo8LieL4AICd8yOfr7V/4+YrD3UNC3Nwwoz77zJUYzFShu/xKT0I+c03bENb
         rN5L+HCM7s9KpMtIlrchrapk8Es8exKMy+c6Vjqzr8T+5aVNdS6NgVgHzEK5tBWkbmFC
         7TEp67L05XVnL5gFBcWXdKJNed4KRA6h5p4S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704759604; x=1705364404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOoPbj1TfvnHYvIjlhZpF7Ke3bdIdyWQQkhfFJGvHco=;
        b=wvRm3V9kQKRi/PgroLSEKSDI7XTD09N5IvG7gTlQ9/4rUmitrl3MjNsokNc0gOCYaH
         nTKzgwKH/UbCPPCSwR77GvS+stmATJezVjyITmDU0Oo9/gx+UBzmEZRJ/Gi7A74+ECKV
         zqzO0P9FNpgvP2InROj4cVniInIusMU8u2ktrkHaUhiKVyAQPUOZB1SS1oH1QmORqrcA
         JHZw/hC9uImXZLi6HUGKxGoymvxQuhjhVw36FIs9Zynisl/8f1d98quNpdZp/5JKIPrj
         QEsCwKNSGe6cjK+GE4jjo7EELY5NlYxMXye9KMuaI0yCZ6421qbBlwzTNO32/bJJKt0L
         4SSw==
X-Gm-Message-State: AOJu0Yzpfg+hX5ubFaacjI1REKr8Q2RdnDHgWgZ41w2BKz5T6NqoZX79
	frqJqQ2STId0c4gB/wk3k5i3Yq0hzLMHjj8AXDcNpuLng/QEe++5
X-Google-Smtp-Source: AGHT+IH1I0VngsJTMpj9b4uk2Y25cRus/XuK7PcqYDmogXDyMit+JluwXsdvwjIlri2fK07rCbpnPg==
X-Received: by 2002:a05:6000:22f:b0:337:6836:494e with SMTP id l15-20020a056000022f00b003376836494emr88766wrz.95.1704759604256;
        Mon, 08 Jan 2024 16:20:04 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b00552d03a17acsm340120edb.61.2024.01.08.16.20.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 16:20:03 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5576fae29ffso2263399a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:20:03 -0800 (PST)
X-Received: by 2002:a17:906:af89:b0:a28:a8dc:67a8 with SMTP id
 mj9-20020a170906af8900b00a28a8dc67a8mr91570ejb.89.1704759603035; Mon, 08 Jan
 2024 16:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook>
In-Reply-To: <202401081028.0E908F9E0A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 16:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
Message-ID: <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	Josh Triplett <josh@joshtriplett.org>
Content-Type: multipart/mixed; boundary="0000000000009168d9060e7846e6"

--0000000000009168d9060e7846e6
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 10:35, Kees Cook <keescook@chromium.org> wrote:
>
> Josh Triplett (1):
>       fs/exec.c: Add fast path for ENOENT on PATH search before allocating mm

No, we're not doing this.

If you want to open the file before the allocations, then dammit, do
exactly that.

Don't look up the path twice. Something (ENTIRELY UNTESTED) like this
patch that just moves the open from "bprm_execve()" to "alloc_bprm()".
It actually cleans up the odd BINPRM_FLAGS_PATH_INACCESSIBLE case too,
by setting it where it makes sense.

Anyway, I want to repeat: this patch is UNTESTED. It compiles for me.
But that is literally all the testing it has gotten apart from a
cursory "this patch looks sane".

There might be something seriously wrong with this patch, but it at
least makes sense, unlike that horror that will look up the filename
twice.

I bet whatever benchmark did the original was not using long filenames
with lots of components, or was only testing the ENOENT case.

                   Linus

--0000000000009168d9060e7846e6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lr5lu9aw0>
X-Attachment-Id: f_lr5lu9aw0

IGZzL2V4ZWMuYyB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyks
IDM1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZWMuYyBiL2ZzL2V4ZWMuYwppbmRl
eCA0YWExOWIyNGYyODEuLmE3ZjZmNTBhNDUzZiAxMDA2NDQKLS0tIGEvZnMvZXhlYy5jCisrKyBi
L2ZzL2V4ZWMuYwpAQCAtMTUwNywxMiArMTUwNywyNCBAQCBzdGF0aWMgdm9pZCBmcmVlX2Jwcm0o
c3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSkKIAlrZnJlZShicHJtKTsKIH0KIAotc3RhdGljIHN0
cnVjdCBsaW51eF9iaW5wcm0gKmFsbG9jX2Jwcm0oaW50IGZkLCBzdHJ1Y3QgZmlsZW5hbWUgKmZp
bGVuYW1lKQorc3RhdGljIHN0cnVjdCBsaW51eF9iaW5wcm0gKmFsbG9jX2Jwcm0oaW50IGZkLCBz
dHJ1Y3QgZmlsZW5hbWUgKmZpbGVuYW1lLCBpbnQgZmxhZ3MpCiB7Ci0Jc3RydWN0IGxpbnV4X2Jp
bnBybSAqYnBybSA9IGt6YWxsb2Moc2l6ZW9mKCpicHJtKSwgR0ZQX0tFUk5FTCk7Ci0JaW50IHJl
dHZhbCA9IC1FTk9NRU07Ci0JaWYgKCFicHJtKQotCQlnb3RvIG91dDsKKwlzdHJ1Y3QgbGludXhf
YmlucHJtICpicHJtOworCXN0cnVjdCBmaWxlICpmaWxlOworCWludCByZXR2YWw7CisKKwlmaWxl
ID0gZG9fb3Blbl9leGVjYXQoZmQsIGZpbGVuYW1lLCBmbGFncyk7CisJaWYgKElTX0VSUihmaWxl
KSkKKwkJcmV0dXJuIEVSUl9DQVNUKGZpbGUpOworCisJYnBybSA9IGt6YWxsb2Moc2l6ZW9mKCpi
cHJtKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFicHJtKSB7CisJCWFsbG93X3dyaXRlX2FjY2Vzcyhm
aWxlKTsKKwkJZnB1dChmaWxlKTsKKwkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7CisJfQorCisJ
YnBybS0+ZmlsZSA9IGZpbGU7CiAKIAlpZiAoZmQgPT0gQVRfRkRDV0QgfHwgZmlsZW5hbWUtPm5h
bWVbMF0gPT0gJy8nKSB7CiAJCWJwcm0tPmZpbGVuYW1lID0gZmlsZW5hbWUtPm5hbWU7CkBAIC0x
NTI1LDE4ICsxNTM3LDI4IEBAIHN0YXRpYyBzdHJ1Y3QgbGludXhfYmlucHJtICphbGxvY19icHJt
KGludCBmZCwgc3RydWN0IGZpbGVuYW1lICpmaWxlbmFtZSkKIAkJaWYgKCFicHJtLT5mZHBhdGgp
CiAJCQlnb3RvIG91dF9mcmVlOwogCisJCS8qCisJCSAqIFJlY29yZCB0aGF0IGEgbmFtZSBkZXJp
dmVkIGZyb20gYW4gT19DTE9FWEVDIGZkIHdpbGwgYmUKKwkJICogaW5hY2Nlc3NpYmxlIGFmdGVy
IGV4ZWMuICBUaGlzIGFsbG93cyB0aGUgY29kZSBpbiBleGVjIHRvCisJCSAqIGNob29zZSB0byBm
YWlsIHdoZW4gdGhlIGV4ZWN1dGFibGUgaXMgbm90IG1tYXBlZCBpbnRvIHRoZQorCQkgKiBpbnRl
cnByZXRlciBhbmQgYW4gb3BlbiBmaWxlIGRlc2NyaXB0b3IgaXMgbm90IHBhc3NlZCB0bworCQkg
KiB0aGUgaW50ZXJwcmV0ZXIuICBUaGlzIG1ha2VzIGZvciBhIGJldHRlciB1c2VyIGV4cGVyaWVu
Y2UKKwkJICogdGhhbiBoYXZpbmcgdGhlIGludGVycHJldGVyIHN0YXJ0IGFuZCB0aGVuIGltbWVk
aWF0ZWx5IGZhaWwKKwkJICogd2hlbiBpdCBmaW5kcyB0aGUgZXhlY3V0YWJsZSBpcyBpbmFjY2Vz
c2libGUuCisJCSAqLworCQlpZiAoZ2V0X2Nsb3NlX29uX2V4ZWMoZmQpKQorCQkJYnBybS0+aW50
ZXJwX2ZsYWdzIHw9IEJJTlBSTV9GTEFHU19QQVRIX0lOQUNDRVNTSUJMRTsKKwogCQlicHJtLT5m
aWxlbmFtZSA9IGJwcm0tPmZkcGF0aDsKIAl9CiAJYnBybS0+aW50ZXJwID0gYnBybS0+ZmlsZW5h
bWU7CiAKIAlyZXR2YWwgPSBicHJtX21tX2luaXQoYnBybSk7Ci0JaWYgKHJldHZhbCkKLQkJZ290
byBvdXRfZnJlZTsKLQlyZXR1cm4gYnBybTsKKwlpZiAoIXJldHZhbCkKKwkJcmV0dXJuIGJwcm07
CiAKIG91dF9mcmVlOgogCWZyZWVfYnBybShicHJtKTsKLW91dDoKIAlyZXR1cm4gRVJSX1BUUihy
ZXR2YWwpOwogfQogCkBAIC0xODA3LDEwICsxODI5LDggQEAgc3RhdGljIGludCBleGVjX2JpbnBy
bShzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtKQogLyoKICAqIHN5c19leGVjdmUoKSBleGVjdXRl
cyBhIG5ldyBwcm9ncmFtLgogICovCi1zdGF0aWMgaW50IGJwcm1fZXhlY3ZlKHN0cnVjdCBsaW51
eF9iaW5wcm0gKmJwcm0sCi0JCSAgICAgICBpbnQgZmQsIHN0cnVjdCBmaWxlbmFtZSAqZmlsZW5h
bWUsIGludCBmbGFncykKK3N0YXRpYyBpbnQgYnBybV9leGVjdmUoc3RydWN0IGxpbnV4X2JpbnBy
bSAqYnBybSkKIHsKLQlzdHJ1Y3QgZmlsZSAqZmlsZTsKIAlpbnQgcmV0dmFsOwogCiAJcmV0dmFs
ID0gcHJlcGFyZV9icHJtX2NyZWRzKGJwcm0pOwpAQCAtMTgyNiwyNiArMTg0Niw4IEBAIHN0YXRp
YyBpbnQgYnBybV9leGVjdmUoc3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSwKIAljdXJyZW50LT5p
bl9leGVjdmUgPSAxOwogCXNjaGVkX21tX2NpZF9iZWZvcmVfZXhlY3ZlKGN1cnJlbnQpOwogCi0J
ZmlsZSA9IGRvX29wZW5fZXhlY2F0KGZkLCBmaWxlbmFtZSwgZmxhZ3MpOwotCXJldHZhbCA9IFBU
Ul9FUlIoZmlsZSk7Ci0JaWYgKElTX0VSUihmaWxlKSkKLQkJZ290byBvdXRfdW5tYXJrOwotCiAJ
c2NoZWRfZXhlYygpOwogCi0JYnBybS0+ZmlsZSA9IGZpbGU7Ci0JLyoKLQkgKiBSZWNvcmQgdGhh
dCBhIG5hbWUgZGVyaXZlZCBmcm9tIGFuIE9fQ0xPRVhFQyBmZCB3aWxsIGJlCi0JICogaW5hY2Nl
c3NpYmxlIGFmdGVyIGV4ZWMuICBUaGlzIGFsbG93cyB0aGUgY29kZSBpbiBleGVjIHRvCi0JICog
Y2hvb3NlIHRvIGZhaWwgd2hlbiB0aGUgZXhlY3V0YWJsZSBpcyBub3QgbW1hcGVkIGludG8gdGhl
Ci0JICogaW50ZXJwcmV0ZXIgYW5kIGFuIG9wZW4gZmlsZSBkZXNjcmlwdG9yIGlzIG5vdCBwYXNz
ZWQgdG8KLQkgKiB0aGUgaW50ZXJwcmV0ZXIuICBUaGlzIG1ha2VzIGZvciBhIGJldHRlciB1c2Vy
IGV4cGVyaWVuY2UKLQkgKiB0aGFuIGhhdmluZyB0aGUgaW50ZXJwcmV0ZXIgc3RhcnQgYW5kIHRo
ZW4gaW1tZWRpYXRlbHkgZmFpbAotCSAqIHdoZW4gaXQgZmluZHMgdGhlIGV4ZWN1dGFibGUgaXMg
aW5hY2Nlc3NpYmxlLgotCSAqLwotCWlmIChicHJtLT5mZHBhdGggJiYgZ2V0X2Nsb3NlX29uX2V4
ZWMoZmQpKQotCQlicHJtLT5pbnRlcnBfZmxhZ3MgfD0gQklOUFJNX0ZMQUdTX1BBVEhfSU5BQ0NF
U1NJQkxFOwotCiAJLyogU2V0IHRoZSB1bmNoYW5naW5nIHBhcnQgb2YgYnBybS0+Y3JlZCAqLwog
CXJldHZhbCA9IHNlY3VyaXR5X2Jwcm1fY3JlZHNfZm9yX2V4ZWMoYnBybSk7CiAJaWYgKHJldHZh
bCkKQEAgLTE4NzUsNyArMTg3Nyw2IEBAIHN0YXRpYyBpbnQgYnBybV9leGVjdmUoc3RydWN0IGxp
bnV4X2JpbnBybSAqYnBybSwKIAlpZiAoYnBybS0+cG9pbnRfb2Zfbm9fcmV0dXJuICYmICFmYXRh
bF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkKIAkJZm9yY2VfZmF0YWxfc2lnKFNJR1NFR1YpOwog
Ci1vdXRfdW5tYXJrOgogCXNjaGVkX21tX2NpZF9hZnRlcl9leGVjdmUoY3VycmVudCk7CiAJY3Vy
cmVudC0+ZnMtPmluX2V4ZWMgPSAwOwogCWN1cnJlbnQtPmluX2V4ZWN2ZSA9IDA7CkBAIC0xOTEw
LDcgKzE5MTEsNyBAQCBzdGF0aWMgaW50IGRvX2V4ZWN2ZWF0X2NvbW1vbihpbnQgZmQsIHN0cnVj
dCBmaWxlbmFtZSAqZmlsZW5hbWUsCiAJICogZnVydGhlciBleGVjdmUoKSBjYWxscyBmYWlsLiAq
LwogCWN1cnJlbnQtPmZsYWdzICY9IH5QRl9OUFJPQ19FWENFRURFRDsKIAotCWJwcm0gPSBhbGxv
Y19icHJtKGZkLCBmaWxlbmFtZSk7CisJYnBybSA9IGFsbG9jX2Jwcm0oZmQsIGZpbGVuYW1lLCBm
bGFncyk7CiAJaWYgKElTX0VSUihicHJtKSkgewogCQlyZXR2YWwgPSBQVFJfRVJSKGJwcm0pOwog
CQlnb3RvIG91dF9yZXQ7CkBAIC0xOTU5LDcgKzE5NjAsNyBAQCBzdGF0aWMgaW50IGRvX2V4ZWN2
ZWF0X2NvbW1vbihpbnQgZmQsIHN0cnVjdCBmaWxlbmFtZSAqZmlsZW5hbWUsCiAJCWJwcm0tPmFy
Z2MgPSAxOwogCX0KIAotCXJldHZhbCA9IGJwcm1fZXhlY3ZlKGJwcm0sIGZkLCBmaWxlbmFtZSwg
ZmxhZ3MpOworCXJldHZhbCA9IGJwcm1fZXhlY3ZlKGJwcm0pOwogb3V0X2ZyZWU6CiAJZnJlZV9i
cHJtKGJwcm0pOwogCkBAIC0xOTg0LDcgKzE5ODUsNyBAQCBpbnQga2VybmVsX2V4ZWN2ZShjb25z
dCBjaGFyICprZXJuZWxfZmlsZW5hbWUsCiAJaWYgKElTX0VSUihmaWxlbmFtZSkpCiAJCXJldHVy
biBQVFJfRVJSKGZpbGVuYW1lKTsKIAotCWJwcm0gPSBhbGxvY19icHJtKGZkLCBmaWxlbmFtZSk7
CisJYnBybSA9IGFsbG9jX2Jwcm0oZmQsIGZpbGVuYW1lLCAwKTsKIAlpZiAoSVNfRVJSKGJwcm0p
KSB7CiAJCXJldHZhbCA9IFBUUl9FUlIoYnBybSk7CiAJCWdvdG8gb3V0X3JldDsKQEAgLTIwMTks
NyArMjAyMCw3IEBAIGludCBrZXJuZWxfZXhlY3ZlKGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFt
ZSwKIAlpZiAocmV0dmFsIDwgMCkKIAkJZ290byBvdXRfZnJlZTsKIAotCXJldHZhbCA9IGJwcm1f
ZXhlY3ZlKGJwcm0sIGZkLCBmaWxlbmFtZSwgMCk7CisJcmV0dmFsID0gYnBybV9leGVjdmUoYnBy
bSk7CiBvdXRfZnJlZToKIAlmcmVlX2Jwcm0oYnBybSk7CiBvdXRfcmV0Ogo=
--0000000000009168d9060e7846e6--

