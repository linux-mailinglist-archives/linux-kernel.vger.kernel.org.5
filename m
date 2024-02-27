Return-Path: <linux-kernel+bounces-83236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720686909B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14F01F22904
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D713A24A;
	Tue, 27 Feb 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MMqWyq2/"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABE1D6A4;
	Tue, 27 Feb 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037064; cv=none; b=OVUGzYj17AaP6DmdWvWAlDD5u4f+VVg16arbdd2m+yv5jWhJCYGQrj4kCaSZeK8HKYnmSrwVlQ+ZBudoQIVu5IyJGUXcwnAcd8IXSgnq+QP02QsnKRUix7MOoPC69Sbv5+K+w+4l+IitEyxylKEZD/y/RW7Q2Pq2aBeTmgispO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037064; c=relaxed/simple;
	bh=RchcqbvV4OeLvhjvHbvTvzMrSkAZXLDtxMjm4OSo+Gw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DbwBSrIH/TEyYXzKO72gspMrXQVh3dijYeRexg6SPkX3Kg+yzHAD9WScS5jExwWaZiGkB7U5OaeeNPricivPL1JqR56s6iquUh48Acm6V+d1NTsEg8wWQYEnw6Ceo5+APk1VDpa2W3ytbdaQ7mrq28UmE66ibCZuprPUDS+4/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MMqWyq2/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709037034; x=1709641834; i=markus.elfring@web.de;
	bh=RchcqbvV4OeLvhjvHbvTvzMrSkAZXLDtxMjm4OSo+Gw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=MMqWyq2/MVI7JPczgLe8F++n8CJndG7GcmfsN6Ci489aP22mU4+pOqkkRuOsRD75
	 iGdCOjPS5MiuMscWWyShn9zmKpcg/DPaJ6crmzNBlfEhhfytwe4RJyiRXJ99GbjEG
	 TP70l52USG9M/gKf10g0/mD9qY/1c7MtAU295m8QJS1zfQTgb/0NhMhYIymUOJfcg
	 7V2z2/MZIBnCfPJO948w/T1xr+I1jGX7S3OFX7xLutkqGQgydOFMROrg/UpIOMq61
	 HlwkJUYu4srgQX0prfcIn3M1rLvWMFaKsqeFHishjzW7SS7pxdUbhn00uWgWU5+MR
	 UH8ZOm2+2ddzu41XhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1r2aZx3CYx-00dRQx; Tue, 27
 Feb 2024 13:30:34 +0100
Message-ID: <bedd83cc-90b1-4780-845e-165f10fa6392@web.de>
Date: Tue, 27 Feb 2024 13:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cleanup: Fix a typo in a comment line
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pkAwCK2k4L8EFa8ErqzjwVZhPXzN2Jjirj2PTe5y3sIEZZR5KcB
 BoGToWVn/gGhviFnwPupacVDox36MFZIrhK10X7ETW5Kf7HZ00YP6a9GSa6lCchtqv2FeTd
 yiAWXTG67v60yjmQJILNEDWKrciWg9YOhz25+RzXMw3eGb0EjuYMB9Fu0mEwjcBHXPtjf7L
 kZ5CHl8/9TAWFyn0pgkrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+o+Be1PrsOA=;3hcJZJcAMTBIfB0Wi4FtAoQfkfG
 +KNA1khcgCa40xigp8wUIzdMPmUVa+0Y4cF28fRjUbFiVMkscHxrJ55sU+ThvsJcZr1d7o7Tx
 O1L5Uh2J9Q9tXLsMAiYpVPGSV7HhTHDA6LowGl9BA1rmAhkBeVTOfbzzNonTpjLawGCCCMTwo
 PvL+pBTBCeZEHgamfNVqVDaDZKnppOtlqodtuu8cmOxjJ5lqB5bFFM5wBf+XJf/eKjkdXCg8I
 sb5uKy1zxB9TRv6QVtHc1a1H2yhgmmgxcHR9w1XszC6rpMPTAPrfwRKWvK3igK2Ca+6HKbAOS
 jaOIhfgOMZc1GFBOPelrqrl/np2dknt8alS8egE6tg1s42EP73heB92pqQME5LX6anwMdzDw/
 ZEt/BaMe5DRyN1nkUM3PQg4RrnEyPyFYCvWxzbc1DMFB0dxp0l/wsuz84KVdcYhpp4suAmJS3
 5437sdikCbgpmwet3AT7OAl+GJSWHIIoKUrOnwocrvhRg4MNkK8xDRfP4a3ls9oLY0GFB3Wu8
 GzareXxIkDIWs7YkAf1z8VPEjFXPJBKor18JvgDNBad3OKAMUZbrMwd2baPby4BYobIuJzKuj
 XfXNyImVlvrr1S0H6ZD0dZ73pOCeRXjOww0SqjQA9T09n2LXwnMKtN3AoW+/uyKWho5020Y+6
 REsEIImVB8MqXREQeNlVf5BI1GQ1J/LnZ9g5TxtA87+VKnsKv+W0Tx6WJTzbdsrLNyyNz3sYf
 rfqib5APDjiFMcGsG0KQmLirxJimNUvYXnihn9OFn1I9J3zjj581a5Lnhp70oaR2cxfy9JR2x
 nAzB8QA22bLw8l2GjxipC1ah5o7QxIL+YJnsnN1uGzN/o=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Feb 2024 13:24:10 +0100

Adjust a word in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..df85f13d11af 100644
=2D-- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -136,7 +136,7 @@ static inline class_##_name##_t class_##_name##ext##_c=
onstructor(_init_args) \
  *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
- *	explicit name 'scope') is declard in a for-loop such that its scope is
+ *	explicit name 'scope') is declared in a for-loop such that its scope i=
s
  *	bound to the next (compound) statement.
  *
  *	for conditional locks the loop body is skipped when the lock is not
=2D-
2.43.2


