Return-Path: <linux-kernel+bounces-26176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA8B82DC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424731C21C63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041461774C;
	Mon, 15 Jan 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfovFy/U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7F17743
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d54b763d15so40914195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705332775; x=1705937575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c/zNgkJo4tsCa3KlP03382gzfoPbt6TyLc2BcvctM1w=;
        b=EfovFy/UPD8gonvjuwnLFWj2+D60r/dENi82dhj8zPKtb6eEBU9IguVSitQuf6v1bi
         StKhFsEZeDGpL3kO0NWKMm5uR//I+q/UrcvHdeovTYqyu2C4T4ocVIAIN8rTWufEy7KJ
         UZdUUfGdSO8kTP/Mwgvzwhdungck7/jL6evvRnwpc7KuPZnIgkWnObVQMKD9x0/SjQR9
         BSM/7CiiXyL1XKK2KMJmt5K9nQdv6rt+d0lL+ojofLYyIOmGb96LIXMh2KnGja5RDzhs
         ZzXMlmmpPYEFA81peuJ9t1Q9ujyKSisdVik+MwwcORy0S+gvnxoZp01UxvjYXNLkc0eA
         rgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332775; x=1705937575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/zNgkJo4tsCa3KlP03382gzfoPbt6TyLc2BcvctM1w=;
        b=jmLdkKYBjLRfaIyXvlgL1i0a8Wxt9UjwlqhPGvWxz05ZbUxGVIAcsYYGtHdcTPwkkX
         Cygo4lXo4QhA3eyEikbrpzmidR9vr9Q+yIIlgAF6CBoZcrZMvJCDbCk7WonoccjLJEl2
         YDQTblF6LCcvHhD9oMcBLTjPBJ3Rw0Wr3jYinywuZNi4UqoLB3ezXfV4r0Kf3hqEz2cI
         Q16SexoviCzE5KX50YU1+K0j/TkjcgjMQ0CQFYv4tbv0WMBMy3LlJmVihlxX8N10lEgb
         86xp32ynEMlt2agUK9Qs23EM3klAc8Dvr8jJpmKr/O0viV0wXp7zaBU20Q3VKL+z5Bvq
         2+gw==
X-Gm-Message-State: AOJu0Yz0W2qY9Auttt51GUQ4lJ4uw/nqBd6B13UneXCrNoWbGO4FF2dE
	owObz5L8odQRJGpQLMEbI6hDKlB4dJ5EmxVGzt8=
X-Google-Smtp-Source: AGHT+IGVxqHw0H4tMTjca7PwU3gCAJKF7z/M/nVOpXjEM6jbKphj99/ARJ9UQDNSBUG60k7DPvlh5jNOK7o17hq6qD8=
X-Received: by 2002:a17:90a:fb46:b0:28c:efdd:b244 with SMTP id
 iq6-20020a17090afb4600b0028cefddb244mr2838761pjb.33.1705332775405; Mon, 15
 Jan 2024 07:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de> <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx> <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org> <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
 <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>
In-Reply-To: <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Mon, 15 Jan 2024 16:32:43 +0100
Message-ID: <CAKQ1sVM8LvxuNhch3MNWNgHfntYqsZcJ_2UzMG2FiEmWYU-n0g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, boqun.feng@gmail.com, 
	bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com, 
	jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Content-Type: multipart/mixed; boundary="0000000000004d65a8060efdbad9"

--0000000000004d65a8060efdbad9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 1:55=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> A simplified reproducer attached (in particular, no APR anymore). Build
> with -pthread, obviously.

I think "abstime" should be updated in the the
pthread_mutex_timedlock() loop or it might get in the past after the
first ETIMEDOUT?
Maybe something the attached pokus3.c reproducer is more inline with
the original code.


Regards;
Yann.

--0000000000004d65a8060efdbad9
Content-Type: text/x-csrc; charset="US-ASCII"; name="pokus3.c"
Content-Disposition: attachment; filename="pokus3.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lrf317uj0>
X-Attachment-Id: f_lrf317uj0

I2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRlIDxzeXMv
bW1hbi5oPgojaW5jbHVkZSA8c3lzL3RpbWUuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CgojZGVm
aW5lIE1BWF9XQUlUX1VTRUMgKDEwMDAqMTAwMCkKI2RlZmluZSBDSElMRFJFTiAxNgojZGVmaW5l
IE1BWF9JVEVSIDIwMAoKI2RlZmluZSBOU19QRVJfUyAxMDAwMDAwMDAwCgpzdGF0aWMgcHRocmVh
ZF9tdXRleF90ICpwcm9jX2xvY2s7CgpzdGF0aWMgdm9pZCBjaGlsZCgpCnsKICAgICAgICBpbnQg
cnYsIGkgPSAwOwoKICAgICAgICBkbyB7CiAgICAgICAgICAgICAgICBpbnQgd2FpdF91c2VjID0g
MDsKCQlzdHJ1Y3QgdGltZXNwZWMgYWJzdGltZTsKCiAgICAgICAgICAgICAgICBmb3IgKDs7KSB7
CgkJICAgIGNsb2NrX2dldHRpbWUoQ0xPQ0tfUkVBTFRJTUUsICZhYnN0aW1lKTsKCgkJICAgIGFi
c3RpbWUudHZfbnNlYyArPSAxMDAwOwoJCSAgICBpZiAoYWJzdGltZS50dl9uc2VjID49IE5TX1BF
Ul9TKSB7CgkJCWFic3RpbWUudHZfc2VjKys7CgkJCWFic3RpbWUudHZfbnNlYyAtPSBOU19QRVJf
UzsKCQkgICAgfQoKICAgICAgICAgICAgICAgICAgICBydiA9IHB0aHJlYWRfbXV0ZXhfdGltZWRs
b2NrKHByb2NfbG9jaywgJmFic3RpbWUpOwogICAgICAgICAgICAgICAgICAgIGlmIChydiA9PSAw
KQoJCQlicmVhazsKICAgICAgICAgICAgICAgICAgICBpZiAocnYgIT0gRVRJTUVET1VUKSB7CgkJ
CSAgICBmcHJpbnRmKHN0ZGVyciwgIkJBRHggcnY9JWRcbiIsIHJ2KTsKCQkJICAgIGFib3J0KCk7
CgkJICAgIH0KICAgICAgICAgICAgICAgICAgICBpZiAoKyt3YWl0X3VzZWMgPj0gTUFYX1dBSVRf
VVNFQykKICAgICAgICAgICAgICAgICAgICAgICAgYWJvcnQoKTsKICAgICAgICAgICAgICAgIH0K
CQkvL2ZwcmludGYoc3RkZXJyLCAiWyVkXSBydj0lZFxuIiwgZ2V0cGlkKCksIHJ2KTsKCiAgICAg
ICAgICAgIGkrKzsKCSAgICB1c2xlZXAoMSk7CiAgICAgICAgICAgIGlmIChwdGhyZWFkX211dGV4
X3VubG9jayhwcm9jX2xvY2spKQogICAgICAgICAgICAgICAgYWJvcnQoKTsKICAgICAgICB9IHdo
aWxlIChpIDwgTUFYX0lURVIpOwoKCWV4aXQoMCk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikKewoJcHJvY19sb2NrID0gbW1hcChOVUxMLCBzaXplb2YoKnByb2NfbG9jayksCgkJ
CSBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBfQU5PTllNT1VTIHwgTUFQX1NIQVJFRCwKCQkJ
IC0xLCAwKTsKCglwdGhyZWFkX211dGV4YXR0cl90IG1hdHRyOwoKCXB0aHJlYWRfbXV0ZXhhdHRy
X2luaXQoJm1hdHRyKTsKCXB0aHJlYWRfbXV0ZXhhdHRyX3NldHBzaGFyZWQoJm1hdHRyLCBQVEhS
RUFEX1BST0NFU1NfU0hBUkVEKTsKCXB0aHJlYWRfbXV0ZXhhdHRyX3NldHJvYnVzdCgmbWF0dHIs
IFBUSFJFQURfTVVURVhfUk9CVVNUKTsKCXB0aHJlYWRfbXV0ZXhhdHRyX3NldHByb3RvY29sKCZt
YXR0ciwgUFRIUkVBRF9QUklPX0lOSEVSSVQpOwoKCXB0aHJlYWRfbXV0ZXhfaW5pdChwcm9jX2xv
Y2ssICZtYXR0cik7CgoJcHRocmVhZF9tdXRleGF0dHJfZGVzdHJveSgmbWF0dHIpOwoKCWZvciAo
dW5zaWduZWQgYSA9IDA7IGEgPCBDSElMRFJFTjsgYSsrKQoJCWlmICghZm9yaygpKQoJCQljaGls
ZCgpOwoKCWZvciAodW5zaWduZWQgYSA9IDA7IGEgPCBDSElMRFJFTjsgYSsrKQoJCXdhaXQoTlVM
TCk7CgoJcHRocmVhZF9tdXRleF9kZXN0cm95KHByb2NfbG9jayk7CgoKCXJldHVybiAwOwp9Cgo=
--0000000000004d65a8060efdbad9--

