Return-Path: <linux-kernel+bounces-101670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4D87AA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA72829C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454EB46542;
	Wed, 13 Mar 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSqylJdb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200845978
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343064; cv=none; b=jJd8DUbDJVfY/lKM3JcWdGHFpr1FQ5J8pkQmloJqxKhlEOZaGmDHhNbsziyBkRCiSY8v08MlV4SVlepOqXKvTp0HZiVaos3O5tf+pH2bIpwl0Pr1D66It7MWYyOprbJQP7sZXUq1LBjoI/o3DmWKexsudKfJ/vUwMs3bX04BKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343064; c=relaxed/simple;
	bh=11UofkdzAExKUodQZTLMIkHUIKl99ZAoZeaG0RVN+J4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ammNdb68K0fSeyIcMZEpS7cxruDMPJioW58rlIkIHsAjdYaNyFZjr7P+8irLOfkhZ4rpS1KI5OkibdmKoDwNCjgjkL1uWYHCDzMd/wjwTmv/TrRzy/wpjpAMX1VLNBxAlYapAR4tVsMrOH8Pl2JtcNLM91anLXvzqrgp51nl4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSqylJdb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513b16bb739so2935210e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710343060; x=1710947860; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS8b1PNR7V7x5h/CO4cJabYLHw2QhRL0rgl3lEA2FHw=;
        b=OSqylJdbUXYAav1inUDpPp+FGoaDjBCLZxCgE+xCRG2cNVg3eMmKJqYW7rBR6X4W24
         EyB/FqRV6YnTqq2ptFh9TsQXngafL9d6Tbrk7K1P7XSIB195Q2IXeu8YYZQ0KMPT6jZA
         Mtk3xmZXeZNSX0WfTEZXw3W75qebudaJ6yUJ3QseqeKD6nvcjO8SXhNyZXjJxVQFnKPU
         bbiUEjUAR/cNUBpojxhTOa2HjAz/XXiSjiOS4x1g+0yPp1Pz+7yYv4kW4TwzrWdt0abJ
         nHiK8F/bffugB5CQgPad8LVNRxHMo3gzJrevYvmoc9FSQ3G6XMpv41XyLUaZosx3lVqW
         LgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710343060; x=1710947860;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iS8b1PNR7V7x5h/CO4cJabYLHw2QhRL0rgl3lEA2FHw=;
        b=N8V1tpaZiLGJmKHJ9LLRHwGHNhuiEZ9H4MVV3XL5ChWCN6wJq6VYXfdyyxIJ2/lCcA
         Yv7pMtMRV2kyrBuayTolQ0Ycxi/ULcURx08choYsVKu7cir2xWuVncC3aU6HzPcbhfcL
         NqWo9OEl35DzJFaLsRtxyFyOclMGPGUJ9uUsltnRpgQAqX6zwNb+fexuFgxCR/uGzIDl
         abQviusR4Xl+Fc4Fbx1utgaeFmng7+XrE2mfwEQSiu7bma0IuBLN3ljl9blEtu2LNOKi
         mOBdObq8XSVy5GJSoUSILFsYijPKoqdp0Vzo6VC56VMWZGC/3hXCdlHGQeoJayrdjUOP
         Efsw==
X-Gm-Message-State: AOJu0YwhtRNMHW4yyvwN8FSMEaZSt3FTL/nzHpVKO644zQao6uZmsxlD
	BxDh/Thurx18U1zpOJUfh6exuKeJyT/glihzcg6XT3aUeSourx3yupE4BT5wKb8=
X-Google-Smtp-Source: AGHT+IHcN9Wtw70fHKfw/UDw2H/LNma04m/ChfLuNtPXhUAVOnPqiThafrqSRmzTm0e2cfDHUlsWCA==
X-Received: by 2002:a05:6512:443:b0:513:ca65:8c58 with SMTP id y3-20020a056512044300b00513ca658c58mr1222391lfk.43.1710343060413;
        Wed, 13 Mar 2024 08:17:40 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:7ce4:a9a1:7f22:a638? ([2001:a61:1366:6801:7ce4:a9a1:7f22:a638])
        by smtp.gmail.com with ESMTPSA id kn22-20020a170906aa5600b00a45200fe2b5sm4936479ejb.224.2024.03.13.08.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:17:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------bx0M9M0d0PX5GwoPpd9ybdav"
Message-ID: <1196d35e-46a0-4c96-8271-12becb932f06@suse.com>
Date: Wed, 13 Mar 2024 16:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug][usb/f_printer] WARNING in usb_ep_queue
Content-Language: en-US
To: Chenyuan Yang <chenyuan0y@gmail.com>, gregkh@linuxfoundation.org,
 azeemshaikh38@gmail.com, ivan.orlov0322@gmail.com,
 benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzurBnMztPW1Q8mujfYaopVQ8MkSUXUvnAqJcLGu5ROSU4Q@mail.gmail.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CALGdzurBnMztPW1Q8mujfYaopVQ8MkSUXUvnAqJcLGu5ROSU4Q@mail.gmail.com>

This is a multi-part message in MIME format.
--------------bx0M9M0d0PX5GwoPpd9ybdav
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.02.24 19:59, Chenyuan Yang wrote:
> Dear Linux Developers for F_printer,
> 
> We encountered "WARNING in usb_ep_queue" when testing the f_printer driver with
> Syzkaller and our generated specifications.
> 

Hi,

it is clear what happens, but at least to me it is not clear why we allow
a write() before we enable the endpoint. Anyway, does this fix the issue?

	Regards
		Oliver

--------------bx0M9M0d0PX5GwoPpd9ybdav
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usb-f_printer-sanity-check-in-write.patch"
Content-Disposition: attachment;
 filename="0001-usb-f_printer-sanity-check-in-write.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMDA4Njk3YjhjZTM3M2EwMzc4MDU4YjYwZDFmMTQ5OGMzODIxMzMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBXZWQsIDEzIE1hciAyMDI0IDE2OjE1OjU2ICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gdXNiOiBmX3ByaW50ZXI6IHNhbml0eSBjaGVjayBpbiB3cml0ZQoKVXNlciBzcGFjZSBj
YW4gdHJpZ2dlciBhIHdyaXRlKCkgYmVmb3JlIHRoZSBlbmRwb2ludCBuZWVkZWQKZm9yIHRo
YXQgaXMgZW5hYmxlZC4gQ2hlY2sgZm9yIHRoYXQuCgpTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIg
TmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX3ByaW50ZXIuYyB8IDM3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMKaW5kZXggMDc2ZGQ0YzFiZTk2Li4x
ZTI2NmJhNjk3ZTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9m
X3ByaW50ZXIuYworKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9wcmludGVy
LmMKQEAgLTU3Nyw2ICs1NzcsNyBAQCBwcmludGVyX3dyaXRlKHN0cnVjdCBmaWxlICpmZCwg
Y29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGxlbiwgbG9mZl90ICpwdHIpCiAJc2l6
ZV90CQkJYnl0ZXNfY29waWVkID0gMDsKIAlzdHJ1Y3QgdXNiX3JlcXVlc3QJKnJlcTsKIAlp
bnQJCQl2YWx1ZTsKKwlpbnQgZXJyID0gLUVOT0RFVjsKIAogCURCRyhkZXYsICJwcmludGVy
X3dyaXRlIHRyeWluZyB0byBzZW5kICVkIGJ5dGVzXG4iLCAoaW50KWxlbik7CiAKQEAgLTU4
NiwxMSArNTg3LDggQEAgcHJpbnRlcl93cml0ZShzdHJ1Y3QgZmlsZSAqZmQsIGNvbnN0IGNo
YXIgX191c2VyICpidWYsIHNpemVfdCBsZW4sIGxvZmZfdCAqcHRyKQogCW11dGV4X2xvY2so
JmRldi0+bG9ja19wcmludGVyX2lvKTsKIAlzcGluX2xvY2tfaXJxc2F2ZSgmZGV2LT5sb2Nr
LCBmbGFncyk7CiAKLQlpZiAoZGV2LT5pbnRlcmZhY2UgPCAwKSB7Ci0JCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3MpOwotCQltdXRleF91bmxvY2soJmRldi0+
bG9ja19wcmludGVyX2lvKTsKLQkJcmV0dXJuIC1FTk9ERVY7Ci0JfQorCWlmIChkZXYtPmlu
dGVyZmFjZSA8IDApCisJCWdvdG8gZXJyb3Jfc3BpbjsKIAogCS8qIENoZWNrIGlmIGEgcHJp
bnRlciByZXNldCBoYXBwZW5zIHdoaWxlIHdlIGhhdmUgaW50ZXJydXB0cyBvbiAqLwogCWRl
di0+cmVzZXRfcHJpbnRlciA9IDA7CkBAIC02MDUsOCArNjAzLDggQEAgcHJpbnRlcl93cml0
ZShzdHJ1Y3QgZmlsZSAqZmQsIGNvbnN0IGNoYXIgX191c2VyICpidWYsIHNpemVfdCBsZW4s
IGxvZmZfdCAqcHRyKQogCQkgKiBhIE5PTi1CbG9ja2luZyBjYWxsIG9yIG5vdC4KIAkJICov
CiAJCWlmIChmZC0+Zl9mbGFncyAmIChPX05PTkJMT0NLfE9fTkRFTEFZKSkgewotCQkJbXV0
ZXhfdW5sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7Ci0JCQlyZXR1cm4gLUVBR0FJTjsK
KwkJCWVyciA9IC1FQUdBSU47CisJCQlnb3RvIGVycm9yX211dGV4OwogCQl9CiAKIAkJLyog
U2xlZXAgdW50aWwgYSB3cml0ZSBidWZmZXIgaXMgYXZhaWxhYmxlICovCkBAIC02NTcsOSAr
NjU1LDE3IEBAIHByaW50ZXJfd3JpdGUoc3RydWN0IGZpbGUgKmZkLCBjb25zdCBjaGFyIF9f
dXNlciAqYnVmLCBzaXplX3QgbGVuLCBsb2ZmX3QgKnB0cikKIAkJLyogV2UndmUgZGlzY29u
bmVjdGVkIG9yIHJlc2V0IHNvIGZyZWUgdGhlIHJlcSBhbmQgYnVmZmVyICovCiAJCWlmIChk
ZXYtPnJlc2V0X3ByaW50ZXIpIHsKIAkJCWxpc3RfYWRkKCZyZXEtPmxpc3QsICZkZXYtPnR4
X3JlcXMpOwotCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7
Ci0JCQltdXRleF91bmxvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsKLQkJCXJldHVybiAt
RUFHQUlOOworCQkJZXJyID0gLUVBR0FJTjsKKwkJCWdvdG8gZXJyb3Jfc3BpbjsKKwkJfQor
CisJCS8qCisJCSAqIFdlIGNhbm5vdCBndWFyYW50ZWUgdXNlciBzcGFjZSBpcyB1c2luZyB0
aGUgQVBJIG5pY2VseQorCQkgKiBUaGlzIGNoZWNrIG5lZWRzIHRvIGJlIGR1cGxpY2F0ZWQK
KwkJICovCisJCWlmICghZGV2LT5pbl9lcC0+ZW5hYmxlZCAmJiBkZXYtPmluX2VwLT5hZGRy
ZXNzKSB7CisJCQllcnIgPSAtRVNIVVRET1dOOworCQkJZ290byBlcnJvcl9zcGluOwogCQl9
CiAKIAkJbGlzdF9hZGQoJnJlcS0+bGlzdCwgJmRldi0+dHhfcmVxc19hY3RpdmUpOwpAQCAt
NjcwLDkgKzY3Niw4IEBAIHByaW50ZXJfd3JpdGUoc3RydWN0IGZpbGUgKmZkLCBjb25zdCBj
aGFyIF9fdXNlciAqYnVmLCBzaXplX3QgbGVuLCBsb2ZmX3QgKnB0cikKIAkJc3Bpbl9sb2Nr
KCZkZXYtPmxvY2spOwogCQlpZiAodmFsdWUpIHsKIAkJCWxpc3RfbW92ZSgmcmVxLT5saXN0
LCAmZGV2LT50eF9yZXFzKTsKLQkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9j
aywgZmxhZ3MpOwotCQkJbXV0ZXhfdW5sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7Ci0J
CQlyZXR1cm4gLUVBR0FJTjsKKwkJCWVyciA9IC1FQUdBSU47CisJCQlnb3RvIGVycm9yX3Nw
aW47CiAJCX0KIAl9CiAKQEAgLTY4NSw2ICs2OTAsMTIgQEAgcHJpbnRlcl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmQsIGNvbnN0IGNoYXIgX191c2VyICpidWYsIHNpemVfdCBsZW4sIGxvZmZf
dCAqcHRyKQogCQlyZXR1cm4gYnl0ZXNfY29waWVkOwogCWVsc2UKIAkJcmV0dXJuIC1FQUdB
SU47CisKK2Vycm9yX3NwaW46CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2Nr
LCBmbGFncyk7CitlcnJvcl9tdXRleDoKKwltdXRleF91bmxvY2soJmRldi0+bG9ja19wcmlu
dGVyX2lvKTsKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMgaW50Ci0tIAoyLjQ0LjAKCg==


--------------bx0M9M0d0PX5GwoPpd9ybdav--

