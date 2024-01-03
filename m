Return-Path: <linux-kernel+bounces-15875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F282349F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52472819F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375BB1C6B3;
	Wed,  3 Jan 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DFjHIT4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078C1C6BB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd1aeb1b02so7019631fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704307108; x=1704911908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjSZPIcPNoFGpG+WpkTBOGU5J4ZC0xbLsWqkPtHnL28=;
        b=DFjHIT4rw9qvULevWxYS7fscs7xiOemEXBQaUUJHtHFDqJEtr1AzV/2XGk6h8WfvU9
         C4oOlRu5heAIOC6RMLVR/dFZDIrTmhgYiKtMY47FCEY+WdZ6ypF6qj/Iu7nNh2ohVEeJ
         SBj4bRUX+qE8sFuLIwvy7+wRPdgdfkOY0JCJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307108; x=1704911908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjSZPIcPNoFGpG+WpkTBOGU5J4ZC0xbLsWqkPtHnL28=;
        b=ggdLkl7HUOjOS3ntiGu9dnyQ/+CcJrWYH14K77tp+1Tl4HbneGJCTSiU9nteiLNXvw
         OqUOHXO7MXHrDl9EZWRJJJSGsZGfN2JNNt+lCTvaSSz+9J14hWfTXXQLxn2Vc4qEEY5t
         mbOpABxvdH8SlvXa6sPdrnwyPlQDQX3Bi7YT8CkwPhKOJ7H/aH/q2SAn8YTpNp5rJRVn
         15zZ6SCOSYCxf7JjTNhJgt/b85aZfd7I0hn5FcMpkRFsTam+7CLUZ75cECf2Z22L1dn5
         0wVEynfSFFYxAP2oHbpP8VwxC6NEeENTNQfFrilq2fQ3Iv0+HqH3PsnFGDaDq+cmYp4c
         CeJA==
X-Gm-Message-State: AOJu0YxrFQOS4qu0Nh0Se4N0jk8GTHUQ6tt44IyIZ+Ut5gM/1e+zY9oX
	B8Ex+ssLXHwdXhuQvjFVD7XXmV2cDkd7P/fG2f9R5U1t+z6sW+Bj
X-Google-Smtp-Source: AGHT+IFOZ5S5GyqW60S8MY+F9CAdM/vx7MYSiwCj/y12DRXAOfpGtcdAWW49RsW9/6Dd+YqCiD641w==
X-Received: by 2002:a2e:7c12:0:b0:2cc:d45a:48f2 with SMTP id x18-20020a2e7c12000000b002ccd45a48f2mr6795469ljc.62.1704307108253;
        Wed, 03 Jan 2024 10:38:28 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651c090a00b002cce6095241sm2973891ljq.62.2024.01.03.10.38.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:38:27 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e80d40a41so8687152e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:38:27 -0800 (PST)
X-Received: by 2002:a05:6512:a83:b0:50e:a517:6f13 with SMTP id
 m3-20020a0565120a8300b0050ea5176f13mr871776lfu.23.1704307107291; Wed, 03 Jan
 2024 10:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
In-Reply-To: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 10:38:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
Message-ID: <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="000000000000b8b1f0060e0eebf2"

--000000000000b8b1f0060e0eebf2
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 10:12, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Much better. Now eventfs looks more like a real filesystem, and less
> like an eldritch horror monster that is parts of dcache tackled onto a
> pseudo-filesystem.

Oh, except I think you still need to just remove the 'set_gid()' mess.

It's disgusting and it's wrong, and it's not even what the 'uid'
option does (it only sets the root inode uid).

If you remount the filesystem with different gid values, you get to
keep both broken pieces. And if it isn't a remount, then setting the
root uid is sufficient.

I think the whole thing was triggered by commit 49d67e445742, and
maybe the fix is to just revert that commit.

That commit makes no sense in general, since the default mounting
position for tracefs that the kernel sets up is only accessible to
root anyway.

Alternatively, just do the ->permissions() thing, and allow access to
the group in the mount options.

Getting rid of set_gid() would be this attached lovely patch:

 fs/tracefs/inode.c | 83 ++----------------------------------------------------
 1 file changed, 2 insertions(+), 81 deletions(-)

and would get rid of the final (?) piece of disgusting dcache hackery
that tracefs most definitely should not have.

             Linus

--000000000000b8b1f0060e0eebf2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lqy4f8350>
X-Attachment-Id: f_lqy4f8350

IGZzL3RyYWNlZnMvaW5vZGUuYyB8IDgzICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
ODEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvdHJhY2Vmcy9pbm9kZS5jIGIvZnMvdHJh
Y2Vmcy9pbm9kZS5jCmluZGV4IDYyNTI0YjIwOTY0ZS4uYTIyMjUzMDM3ZTNlIDEwMDY0NAotLS0g
YS9mcy90cmFjZWZzL2lub2RlLmMKKysrIGIvZnMvdHJhY2Vmcy9pbm9kZS5jCkBAIC0xODMsODMg
KzE4Myw2IEBAIHN0cnVjdCB0cmFjZWZzX2ZzX2luZm8gewogCXN0cnVjdCB0cmFjZWZzX21vdW50
X29wdHMgbW91bnRfb3B0czsKIH07CiAKLXN0YXRpYyB2b2lkIGNoYW5nZV9naWQoc3RydWN0IGRl
bnRyeSAqZGVudHJ5LCBrZ2lkX3QgZ2lkKQotewotCWlmICghZGVudHJ5LT5kX2lub2RlKQotCQly
ZXR1cm47Ci0JZGVudHJ5LT5kX2lub2RlLT5pX2dpZCA9IGdpZDsKLX0KLQotLyoKLSAqIFRha2Vu
IGZyb20gZF93YWxrLCBidXQgd2l0aG91dCBoZSBuZWVkIGZvciBoYW5kbGluZyByZW5hbWVzLgot
ICogTm90aGluZyBjYW4gYmUgcmVuYW1lZCB3aGlsZSB3YWxraW5nIHRoZSBsaXN0LCBhcyB0cmFj
ZWZzCi0gKiBkb2VzIG5vdCBzdXBwb3J0IHJlbmFtZXMuIFRoaXMgaXMgb25seSBjYWxsZWQgd2hl
biBtb3VudGluZwotICogb3IgcmVtb3VudGluZyB0aGUgZmlsZSBzeXN0ZW0sIHRvIHNldCBhbGwg
dGhlIGZpbGVzIHRvCi0gKiB0aGUgZ2l2ZW4gZ2lkLgotICovCi1zdGF0aWMgdm9pZCBzZXRfZ2lk
KHN0cnVjdCBkZW50cnkgKnBhcmVudCwga2dpZF90IGdpZCkKLXsKLQlzdHJ1Y3QgZGVudHJ5ICp0
aGlzX3BhcmVudDsKLQlzdHJ1Y3QgbGlzdF9oZWFkICpuZXh0OwotCi0JdGhpc19wYXJlbnQgPSBw
YXJlbnQ7Ci0Jc3Bpbl9sb2NrKCZ0aGlzX3BhcmVudC0+ZF9sb2NrKTsKLQotCWNoYW5nZV9naWQo
dGhpc19wYXJlbnQsIGdpZCk7Ci1yZXBlYXQ6Ci0JbmV4dCA9IHRoaXNfcGFyZW50LT5kX3N1YmRp
cnMubmV4dDsKLXJlc3VtZToKLQl3aGlsZSAobmV4dCAhPSAmdGhpc19wYXJlbnQtPmRfc3ViZGly
cykgewotCQlzdHJ1Y3QgdHJhY2Vmc19pbm9kZSAqdGk7Ci0JCXN0cnVjdCBsaXN0X2hlYWQgKnRt
cCA9IG5leHQ7Ci0JCXN0cnVjdCBkZW50cnkgKmRlbnRyeSA9IGxpc3RfZW50cnkodG1wLCBzdHJ1
Y3QgZGVudHJ5LCBkX2NoaWxkKTsKLQkJbmV4dCA9IHRtcC0+bmV4dDsKLQotCQlzcGluX2xvY2tf
bmVzdGVkKCZkZW50cnktPmRfbG9jaywgREVOVFJZX0RfTE9DS19ORVNURUQpOwotCi0JCWNoYW5n
ZV9naWQoZGVudHJ5LCBnaWQpOwotCi0JCS8qIElmIHRoaXMgaXMgdGhlIGV2ZW50cyBkaXJlY3Rv
cnksIHVwZGF0ZSB0aGF0IHRvbyAqLwotCQl0aSA9IGdldF90cmFjZWZzKGRlbnRyeS0+ZF9pbm9k
ZSk7Ci0JCWlmICh0aSAmJiAodGktPmZsYWdzICYgVFJBQ0VGU19FVkVOVF9JTk9ERSkpCi0JCQll
dmVudGZzX3VwZGF0ZV9naWQoZGVudHJ5LCBnaWQpOwotCi0JCWlmICghbGlzdF9lbXB0eSgmZGVu
dHJ5LT5kX3N1YmRpcnMpKSB7Ci0JCQlzcGluX3VubG9jaygmdGhpc19wYXJlbnQtPmRfbG9jayk7
Ci0JCQlzcGluX3JlbGVhc2UoJmRlbnRyeS0+ZF9sb2NrLmRlcF9tYXAsIF9SRVRfSVBfKTsKLQkJ
CXRoaXNfcGFyZW50ID0gZGVudHJ5OwotCQkJc3Bpbl9hY3F1aXJlKCZ0aGlzX3BhcmVudC0+ZF9s
b2NrLmRlcF9tYXAsIDAsIDEsIF9SRVRfSVBfKTsKLQkJCWdvdG8gcmVwZWF0OwotCQl9Ci0JCXNw
aW5fdW5sb2NrKCZkZW50cnktPmRfbG9jayk7Ci0JfQotCS8qCi0JICogQWxsIGRvbmUgYXQgdGhp
cyBsZXZlbCAuLi4gYXNjZW5kIGFuZCByZXN1bWUgdGhlIHNlYXJjaC4KLQkgKi8KLQlyY3VfcmVh
ZF9sb2NrKCk7Ci1hc2NlbmQ6Ci0JaWYgKHRoaXNfcGFyZW50ICE9IHBhcmVudCkgewotCQlzdHJ1
Y3QgZGVudHJ5ICpjaGlsZCA9IHRoaXNfcGFyZW50OwotCQl0aGlzX3BhcmVudCA9IGNoaWxkLT5k
X3BhcmVudDsKLQotCQlzcGluX3VubG9jaygmY2hpbGQtPmRfbG9jayk7Ci0JCXNwaW5fbG9jaygm
dGhpc19wYXJlbnQtPmRfbG9jayk7Ci0KLQkJLyogZ28gaW50byB0aGUgZmlyc3Qgc2libGluZyBz
dGlsbCBhbGl2ZSAqLwotCQlkbyB7Ci0JCQluZXh0ID0gY2hpbGQtPmRfY2hpbGQubmV4dDsKLQkJ
CWlmIChuZXh0ID09ICZ0aGlzX3BhcmVudC0+ZF9zdWJkaXJzKQotCQkJCWdvdG8gYXNjZW5kOwot
CQkJY2hpbGQgPSBsaXN0X2VudHJ5KG5leHQsIHN0cnVjdCBkZW50cnksIGRfY2hpbGQpOwotCQl9
IHdoaWxlICh1bmxpa2VseShjaGlsZC0+ZF9mbGFncyAmIERDQUNIRV9ERU5UUllfS0lMTEVEKSk7
Ci0JCXJjdV9yZWFkX3VubG9jaygpOwotCQlnb3RvIHJlc3VtZTsKLQl9Ci0JcmN1X3JlYWRfdW5s
b2NrKCk7Ci0Jc3Bpbl91bmxvY2soJnRoaXNfcGFyZW50LT5kX2xvY2spOwotCXJldHVybjsKLX0K
LQogc3RhdGljIGludCB0cmFjZWZzX3BhcnNlX29wdGlvbnMoY2hhciAqZGF0YSwgc3RydWN0IHRy
YWNlZnNfbW91bnRfb3B0cyAqb3B0cykKIHsKIAlzdWJzdHJpbmdfdCBhcmdzW01BWF9PUFRfQVJH
U107CkBAIC0zMzIsMTAgKzI1NSw4IEBAIHN0YXRpYyBpbnQgdHJhY2Vmc19hcHBseV9vcHRpb25z
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGJvb2wgcmVtb3VudCkKIAlpZiAoIXJlbW91bnQgfHwg
b3B0cy0+b3B0cyAmIEJJVChPcHRfdWlkKSkKIAkJaW5vZGUtPmlfdWlkID0gb3B0cy0+dWlkOwog
Ci0JaWYgKCFyZW1vdW50IHx8IG9wdHMtPm9wdHMgJiBCSVQoT3B0X2dpZCkpIHsKLQkJLyogU2V0
IGFsbCB0aGUgZ3JvdXAgaWRzIHRvIHRoZSBtb3VudCBvcHRpb24gKi8KLQkJc2V0X2dpZChzYi0+
c19yb290LCBvcHRzLT5naWQpOwotCX0KKwlpZiAoIXJlbW91bnQgfHwgb3B0cy0+b3B0cyAmIEJJ
VChPcHRfZ2lkKSkKKwkJaW5vZGUtPmlfZ2lkID0gb3B0cy0+Z2lkOwogCiAJcmV0dXJuIDA7CiB9
Cg==
--000000000000b8b1f0060e0eebf2--

