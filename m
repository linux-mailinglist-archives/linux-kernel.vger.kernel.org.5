Return-Path: <linux-kernel+bounces-58037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A69284E088
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748411F2A454
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53571B57;
	Thu,  8 Feb 2024 12:17:57 +0000 (UTC)
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD46F079;
	Thu,  8 Feb 2024 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394676; cv=none; b=Uilvv9dSY9xUFpgPNMMkUIlhUSvRlDHCOaG0enFWh/CflnUnYk0mWnQVbN+v9NhIyDJly2dQ9w/xWd7O4OfltUyo1XkFulddb10Uqvnc/BP0mThnS2nZgzAwVgPNHX5BI9PzpAcV9emKfrdZAMMAqoWtSlmGG50r16aB9VeQiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394676; c=relaxed/simple;
	bh=em70S6fl4jXKXISeqX4EQDrqUqnNdkplx9N5uRCApyE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Cc:To:References:From:
	 In-Reply-To:Subject; b=pO6yZz6Fa/mo6gTlo/1zZ1Gn/zPV3Q/4NE5cM8VhU1uiq6a/10Pz+0dbXqBY3KDqA3kmhcKDIIvSUmMxExx6Ddd/8ztwHwp52pc9uxMUSgl4wKPp/DghruVbC1M4hp/66y3TK+8b5HpbEz5vbYc/a8jmk8qQVXeBJlNKFagA5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from whiskey.org.vrvis.lan ([10.42.2.171])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1rY2ii-0004Cp-0r;
	Thu, 08 Feb 2024 12:37:37 +0100
Content-Type: multipart/mixed; boundary="------------8nT1Vb4atVC4dwNucelwL7VP"
Message-ID: <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
Date: Thu, 8 Feb 2024 12:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: David Teigland <teigland@redhat.com>,
 Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org,
 gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Language: en-US
To: Jordan Rife <jrife@google.com>, Salvatore Bonaccorso <carnil@debian.org>
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan>
 <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
From: Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -4.5 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.1 GREYLIST_ISWHITE The incoming server has been whitelisted for this
	*      receipient and sender
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)

This is a multi-part message in MIME format.
--------------8nT1Vb4atVC4dwNucelwL7VP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jordan, hi all

> Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> and 6.6 stable branches,
> it looks like there is a mismatch here with the dlm_local_addr[0] parameter.
> 
> 6.1
> ----
> 
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
> 
> /* Bind to our port */
> make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>     addr_len);
> }
> 
> 6.6
> ----
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
> 
> /* Bind to our port */
> make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>     addr_len);
> }
> 
> 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap) which
> changed
> 
> static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
> 
> to
> 
> static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
> 
> It looks like kernel_bind() in 6.1 needs to be modified to match.

We tried to apply commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on 
heap) to the debian kernel 6.1.76 and came up with the attached patch. 
Besides the different offsets there is a slight change dlm_tcp_bind() 
where in 6.1.76 kernel_bind() is used instead of sock->ops->bind() in 
the original commit.

This patch solves the issue we experienced.

Thanks for your help,
Valentin
--------------8nT1Vb4atVC4dwNucelwL7VP
Content-Type: text/x-patch; charset=UTF-8;
 name="dlm_dont_put_dlm_local_addrs_on_heap.patch"
Content-Disposition: attachment;
 filename="dlm_dont_put_dlm_local_addrs_on_heap.patch"
Content-Transfer-Encoding: base64

LS0tIGEvZnMvZGxtL2xvd2NvbW1zLmMJMjAyNC0wMi0wOCAxMDo0MjoxOS4zMjg4NjE0Nzkg
KzAxMDAKKysrIGIvZnMvZGxtL2xvd2NvbW1zLmMJMjAyNC0wMi0wOCAxMDo1NzoyMi45MDA0
NjMxNDkgKzAxMDAKQEAgLTE3NCw3ICsxNzQsNyBAQAogc3RhdGljIERFRklORV9TUElOTE9D
SyhkbG1fbm9kZV9hZGRyc19zcGluKTsKIAogc3RhdGljIHN0cnVjdCBsaXN0ZW5fY29ubmVj
dGlvbiBsaXN0ZW5fY29uOwotc3RhdGljIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICpkbG1f
bG9jYWxfYWRkcltETE1fTUFYX0FERFJfQ09VTlRdOworc3RhdGljIHN0cnVjdCBzb2NrYWRk
cl9zdG9yYWdlIGRsbV9sb2NhbF9hZGRyW0RMTV9NQVhfQUREUl9DT1VOVF07CiBzdGF0aWMg
aW50IGRsbV9sb2NhbF9jb3VudDsKIGludCBkbG1fYWxsb3dfY29ubjsKIApAQCAtMzk4LDcg
KzM5OCw3IEBACiAJaWYgKCFzYV9vdXQpCiAJCXJldHVybiAwOwogCi0JaWYgKGRsbV9sb2Nh
bF9hZGRyWzBdLT5zc19mYW1pbHkgPT0gQUZfSU5FVCkgeworCWlmIChkbG1fbG9jYWxfYWRk
clswXS5zc19mYW1pbHkgPT0gQUZfSU5FVCkgewogCQlzdHJ1Y3Qgc29ja2FkZHJfaW4gKmlu
NCAgPSAoc3RydWN0IHNvY2thZGRyX2luICopICZzYXM7CiAJCXN0cnVjdCBzb2NrYWRkcl9p
biAqcmV0NCA9IChzdHJ1Y3Qgc29ja2FkZHJfaW4gKikgc2Ffb3V0OwogCQlyZXQ0LT5zaW5f
YWRkci5zX2FkZHIgPSBpbjQtPnNpbl9hZGRyLnNfYWRkcjsKQEAgLTcyNyw3ICs3MjcsNyBA
QAogc3RhdGljIHZvaWQgbWFrZV9zb2NrYWRkcihzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAq
c2FkZHIsIHVpbnQxNl90IHBvcnQsCiAJCQkgIGludCAqYWRkcl9sZW4pCiB7Ci0Jc2FkZHIt
PnNzX2ZhbWlseSA9ICBkbG1fbG9jYWxfYWRkclswXS0+c3NfZmFtaWx5OworCXNhZGRyLT5z
c19mYW1pbHkgPSAgZGxtX2xvY2FsX2FkZHJbMF0uc3NfZmFtaWx5OwogCWlmIChzYWRkci0+
c3NfZmFtaWx5ID09IEFGX0lORVQpIHsKIAkJc3RydWN0IHNvY2thZGRyX2luICppbjRfYWRk
ciA9IChzdHJ1Y3Qgc29ja2FkZHJfaW4gKilzYWRkcjsKIAkJaW40X2FkZHItPnNpbl9wb3J0
ID0gY3B1X3RvX2JlMTYocG9ydCk7CkBAIC0xMTY3LDcgKzExNjcsNyBAQAogCWludCBpLCBh
ZGRyX2xlbiwgcmVzdWx0ID0gMDsKIAogCWZvciAoaSA9IDA7IGkgPCBkbG1fbG9jYWxfY291
bnQ7IGkrKykgewotCQltZW1jcHkoJmxvY2FsYWRkciwgZGxtX2xvY2FsX2FkZHJbaV0sIHNp
emVvZihsb2NhbGFkZHIpKTsKKwkJbWVtY3B5KCZsb2NhbGFkZHIsICZkbG1fbG9jYWxfYWRk
cltpXSwgc2l6ZW9mKGxvY2FsYWRkcikpOwogCQltYWtlX3NvY2thZGRyKCZsb2NhbGFkZHIs
IHBvcnQsICZhZGRyX2xlbik7CiAKIAkJaWYgKCFpKQpAQCAtMTE4Nyw3ICsxMTg3LDcgQEAK
IC8qIEdldCBsb2NhbCBhZGRyZXNzZXMgKi8KIHN0YXRpYyB2b2lkIGluaXRfbG9jYWwodm9p
ZCkKIHsKLQlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzYXMsICphZGRyOworCXN0cnVjdCBz
b2NrYWRkcl9zdG9yYWdlIHNhczsKIAlpbnQgaTsKIAogCWRsbV9sb2NhbF9jb3VudCA9IDA7
CkBAIC0xMTk1LDIxICsxMTk1LDEwIEBACiAJCWlmIChkbG1fb3VyX2FkZHIoJnNhcywgaSkp
CiAJCQlicmVhazsKIAotCQlhZGRyID0ga21lbWR1cCgmc2FzLCBzaXplb2YoKmFkZHIpLCBH
RlBfTk9GUyk7Ci0JCWlmICghYWRkcikKLQkJCWJyZWFrOwotCQlkbG1fbG9jYWxfYWRkcltk
bG1fbG9jYWxfY291bnQrK10gPSBhZGRyOworCQltZW1jcHkoJmRsbV9sb2NhbF9hZGRyW2Rs
bV9sb2NhbF9jb3VudCsrXSwgJnNhcywgc2l6ZW9mKHNhcykpOwogCX0KIH0KIAotc3RhdGlj
IHZvaWQgZGVpbml0X2xvY2FsKHZvaWQpCi17Ci0JaW50IGk7Ci0KLQlmb3IgKGkgPSAwOyBp
IDwgZGxtX2xvY2FsX2NvdW50OyBpKyspCi0JCWtmcmVlKGRsbV9sb2NhbF9hZGRyW2ldKTsK
LX0KLQogc3RhdGljIHN0cnVjdCB3cml0ZXF1ZXVlX2VudHJ5ICpuZXdfd3JpdGVxdWV1ZV9l
bnRyeShzdHJ1Y3QgY29ubmVjdGlvbiAqY29uKQogewogCXN0cnVjdCB3cml0ZXF1ZXVlX2Vu
dHJ5ICplbnRyeTsKQEAgLTE1NzUsNyArMTU2NCw3IEBACiAJfQogCiAJLyogQ3JlYXRlIGEg
c29ja2V0IHRvIGNvbW11bmljYXRlIHdpdGggKi8KLQlyZXN1bHQgPSBzb2NrX2NyZWF0ZV9r
ZXJuKCZpbml0X25ldCwgZGxtX2xvY2FsX2FkZHJbMF0tPnNzX2ZhbWlseSwKKwlyZXN1bHQg
PSBzb2NrX2NyZWF0ZV9rZXJuKCZpbml0X25ldCwgZGxtX2xvY2FsX2FkZHJbMF0uc3NfZmFt
aWx5LAogCQkJCSAgU09DS19TVFJFQU0sIGRsbV9wcm90b19vcHMtPnByb3RvLCAmc29jayk7
CiAJaWYgKHJlc3VsdCA8IDApCiAJCWdvdG8gc29ja2V0X2VycjsKQEAgLTE3ODYsNyArMTc3
NSw2IEBACiAJZm9yZWFjaF9jb25uKGZyZWVfY29ubik7CiAJc3JjdV9yZWFkX3VubG9jaygm
Y29ubmVjdGlvbnNfc3JjdSwgaWR4KTsKIAl3b3JrX3N0b3AoKTsKLQlkZWluaXRfbG9jYWwo
KTsKIAogCWRsbV9wcm90b19vcHMgPSBOVUxMOwogfQpAQCAtMTgwMyw3ICsxNzkxLDcgQEAK
IAlpZiAocmVzdWx0IDwgMCkKIAkJcmV0dXJuIHJlc3VsdDsKIAotCXJlc3VsdCA9IHNvY2tf
Y3JlYXRlX2tlcm4oJmluaXRfbmV0LCBkbG1fbG9jYWxfYWRkclswXS0+c3NfZmFtaWx5LAor
CXJlc3VsdCA9IHNvY2tfY3JlYXRlX2tlcm4oJmluaXRfbmV0LCBkbG1fbG9jYWxfYWRkclsw
XS5zc19mYW1pbHksCiAJCQkJICBTT0NLX1NUUkVBTSwgZGxtX3Byb3RvX29wcy0+cHJvdG8s
ICZzb2NrKTsKIAlpZiAocmVzdWx0IDwgMCkgewogCQlsb2dfcHJpbnQoIkNhbid0IGNyZWF0
ZSBjb21tcyBzb2NrZXQ6ICVkIiwgcmVzdWx0KTsKQEAgLTE4NDIsNyArMTgzMCw3IEBACiAJ
LyogQmluZCB0byBvdXIgY2x1c3Rlci1rbm93biBhZGRyZXNzIGNvbm5lY3RpbmcgdG8gYXZv
aWQKIAkgKiByb3V0aW5nIHByb2JsZW1zLgogCSAqLwotCW1lbWNweSgmc3JjX2FkZHIsIGRs
bV9sb2NhbF9hZGRyWzBdLCBzaXplb2Yoc3JjX2FkZHIpKTsKKwltZW1jcHkoJnNyY19hZGRy
LCAmZGxtX2xvY2FsX2FkZHJbMF0sIHNpemVvZihzcmNfYWRkcikpOwogCW1ha2Vfc29ja2Fk
ZHIoJnNyY19hZGRyLCAwLCAmYWRkcl9sZW4pOwogCiAJcmVzdWx0ID0ga2VybmVsX2JpbmQo
c29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZzcmNfYWRkciwKQEAgLTE4OTksNyArMTg4Nyw3
IEBACiAJaW50IGFkZHJfbGVuOwogCiAJLyogQmluZCB0byBvdXIgcG9ydCAqLwotCW1ha2Vf
c29ja2FkZHIoZGxtX2xvY2FsX2FkZHJbMF0sIGRsbV9jb25maWcuY2lfdGNwX3BvcnQsICZh
ZGRyX2xlbik7CisJbWFrZV9zb2NrYWRkcigmZGxtX2xvY2FsX2FkZHJbMF0sIGRsbV9jb25m
aWcuY2lfdGNwX3BvcnQsICZhZGRyX2xlbik7CiAJcmV0dXJuIGtlcm5lbF9iaW5kKHNvY2ss
IChzdHJ1Y3Qgc29ja2FkZHIgKikmZGxtX2xvY2FsX2FkZHJbMF0sCiAJCQkgICBhZGRyX2xl
bik7CiB9CkBAIC0xOTkyLDcgKzE5ODAsNyBAQAogCiAJZXJyb3IgPSB3b3JrX3N0YXJ0KCk7
CiAJaWYgKGVycm9yKQotCQlnb3RvIGZhaWxfbG9jYWw7CisJCWdvdG8gZmFpbDsKIAogCWRs
bV9hbGxvd19jb25uID0gMTsKIApAQCAtMjAyMiw4ICsyMDEwLDYgQEAKIGZhaWxfcHJvdG9f
b3BzOgogCWRsbV9hbGxvd19jb25uID0gMDsKIAl3b3JrX3N0b3AoKTsKLWZhaWxfbG9jYWw6
Ci0JZGVpbml0X2xvY2FsKCk7CiBmYWlsOgogCXJldHVybiBlcnJvcjsKIH0K

--------------8nT1Vb4atVC4dwNucelwL7VP--

