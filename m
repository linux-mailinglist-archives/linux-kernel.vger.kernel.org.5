Return-Path: <linux-kernel+bounces-66443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F98855CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB428301D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71E13ADC;
	Thu, 15 Feb 2024 08:53:17 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C2134CC;
	Thu, 15 Feb 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987196; cv=none; b=BqyG1K78JWEWPLTsvD/67NQmhr89rj1nlxeRRmS7URpeRmrdioQE1ayWdVVaR/aJoQVEtioOQYivoe6kedzWsLrfCB4xfjGctFbBAdLWMeZDE27D9OLzOMcLDHznfZz0NXX2DnMV6GNWVktQJ1/YH8lL5CUAKa3z6alLc88Tcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987196; c=relaxed/simple;
	bh=2ErJuzFWXwH+BIQszwKphBEBR2FP0kZ5Ngebxu+Vynw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KLwsZk8AnzxUTxUgKmu61NqP5ImpqDNz9ikM3+rl+9oYQalxB6kxNVwmPPyZzugXhC1ANsBU8J0zaGu1hnZ2Gh+aZrrjhmOTeZv4EFdrZbSMwfddCNmW+EQYfbY8Gpdnhq73bYA9FqCylDFNrXg/6c3U1fWPayswzaWnI7yHY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb7dN3xtVz9v7bm;
	Thu, 15 Feb 2024 16:34:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 60B50140631;
	Thu, 15 Feb 2024 16:53:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHwCTe0M1lvlSGAg--.2343S2;
	Thu, 15 Feb 2024 09:53:03 +0100 (CET)
Message-ID: <a9e263becefe001ec5de4abf79bbdb49a2c35033.camel@huaweicloud.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Petr
	=?UTF-8?Q?Tesa=C5=99=C3=ADk?=
	 <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Tesarik <petrtesarik@huaweicloud.com>, 
 Jonathan Corbet <corbet@lwn.net>, David Kaplan <david.kaplan@amd.com>,
 Larry Dewey <larry.dewey@amd.com>, Elena Reshetova
 <elena.reshetova@intel.com>, Carlos Bilbao <carlos.bilbao@amd.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Marc
 =?ISO-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, "Christian Brauner
 (Microsoft)" <brauner@kernel.org>,  Douglas Anderson
 <dianders@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, Guenter
 Roeck <groeck@chromium.org>,  Mike Christie <michael.christie@oracle.com>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>,
 linux-security-module@vger.kernel.org,  keyrings@vger.kernel.org
Date: Thu, 15 Feb 2024 09:52:43 +0100
In-Reply-To: <xg7iz7syomv3oobjktgn76fyxms4vfs66jul56ub36prwnncxm@hsjhc5m72ipq>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
	 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	 <2024021425-audition-expand-2901@gregkh>
	 <20240214155524.719ffb15@meshulam.tesarici.cz>
	 <2024021415-jokester-cackle-2923@gregkh>
	 <20240214173112.138e0e29@meshulam.tesarici.cz>
	 <g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
	 <20240214210937.3a19945f@meshulam.tesarici.cz>
	 <xg7iz7syomv3oobjktgn76fyxms4vfs66jul56ub36prwnncxm@hsjhc5m72ipq>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHwCTe0M1lvlSGAg--.2343S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWUJFWxZr48AF1rCF4rXwb_yoWrCrWfpF
	y3Kay8Kr4DJF12yrs2yw1xXFy0vw4xAr47Wr9xGr98Zrn09r1I9rySgrWY9F92kr4xGw1j
	vF4qqasF93WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5ZeaAAAsZ

On Wed, 2024-02-14 at 15:19 -0500, Kent Overstreet wrote:
> On Wed, Feb 14, 2024 at 09:09:37PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 13:54:54 -0500
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >=20
> > > On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesa=C5=99=C3=ADk wrot=
e:
> > > > On Wed, 14 Feb 2024 16:11:05 +0100
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >  =20
> > > > > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesa=C5=99=C3=ADk =
wrote: =20
> > > > > > OK, so why didn't I send the whole thing?
> > > > > >=20
> > > > > > Decomposition of the kernel requires many more changes, e.g. in=
 linker
> > > > > > scripts. Some of them depend on this patch series. Before I go =
and
> > > > > > clean up my code into something that can be submitted, I want t=
o get
> > > > > > feedback from guys like you, to know if the whole idea would be=
 even
> > > > > > considered, aka "Fail Fast".   =20
> > > > >=20
> > > > > We can't honestly consider this portion without seeing how it wou=
ld
> > > > > work, as we don't even see a working implementation that uses it =
to
> > > > > verify it at all.
> > > > >=20
> > > > > The joy of adding new frameworks is that you need a user before a=
nyone
> > > > > can spend the time to review it, sorry. =20
> > > >=20
> > > > Thank your for a quick assessment. Will it be sufficient if I send =
some
> > > > code for illustration (with some quick&dirty hacks to bridge the ga=
ps),
> > > > or do you need clean and nice kernel code? =20
> > >=20
> > > Given that code is going to need a rewrite to make use of this anyway=
s -
> > > why not just do the rewrite in Rust?
> >=20
> > Thank you for this question! I concur that rewriting the whole kernel
> > in Rust would be a better option. I see two differences:
> >=20
> > 1. amount of work
> > 2. regressions
> >=20
> > Rewriting something in Rust means pretty much writing it from scratch.
> > Doing that necessarily introduces regressions. Old code has been used.
> > It has been tested. In many corner cases. Lots of bugs have been found,
> > and they=E2=80=99ve been fixed. If you write code from scratch, you los=
e much
> > of the accumulated knowledge.
>=20
> But it's work that already has some growing momentum behind it,
> especially in the area you cited - decompression algorithms.
>=20
> > More importantly, sandbox mode can be viewed as a tool that enforces
> > decomposition of kernel code. This decomposition is the main benefit.
> > It requires understanding the dependencies among different parts of the
> > kernel (both code flow and data flow), and that will in turn promote
> > better design.
>=20
> You see this as a tool for general purpose code...?
>=20
> Typical kernel code tends to be quite pointer heavy.
>=20
> > > Then you get memory safety, which seems to be what you're trying to
> > > achieve here.
> > >=20
> > > Or, you say this is for when performance isn't critical - why not a u=
ser
> > > mode helper?
> >=20
> > Processes in user mode are susceptible to all kinds of attacks you may
> > want to avoid. Sandbox mode can be used in situations where user mode
> > does not exist, e.g. to display a boot logo or to unpack initramfs.
>=20
> [citation needed]
>=20
> Running code in the kernel does not make it more secure from attack, and
> that's a pretty strange idea. One of the central jobs of the kernel is
> to provide isolation between different users.

+ linux-security-module, keyrings

It is not exactly about being more secure, but more privileged.

I had a question in the past:

https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb013=
0b0e1.camel@huaweicloud.com/


I basically need to parse PGP keys, to verify RPM package headers,
extract the file digests from them, and use those digests as reference
values for the kernel to decide whether or not files can be accessed
depending on their integrity.

It is very important that, in a locked-down system, even root is
subject to integrity checks. So, the kernel has higher privileges than
root.

Can the kernel be trusted to provide strong enough process isolation,
even against root, in a way that it can offload a workload to a user
space process (PGP parsing), and yet maintain its privilege level
(which would drop to root, if isolation cannot be guaranteed)?

So, since we got no as an answer, we thought about something in the
middle, we still run the code in the kernel, to keep the higher
privilege, but at the same time we mitigate the risk of kernel memory
corruption.

Roberto


