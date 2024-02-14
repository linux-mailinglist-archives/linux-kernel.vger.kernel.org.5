Return-Path: <linux-kernel+bounces-65815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8F855230
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BBC1C29E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296813A27C;
	Wed, 14 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="dzKx4kuE"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051513A860;
	Wed, 14 Feb 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935568; cv=none; b=JBuyslHFJtUsyUAonuA2o09AtA2TYvZknzDLwmEbbJWGb4X9XabZv44Rh89AFXCCwmRdkapym5JhD+9Sqghwsf06XDc/WGmgGiWz6VG8q6ZxiiblFqUDEolxICzsa3Yma3LWZSAJC1BlzATf6WfM2UPzge4nLb265Cm4BwXzIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935568; c=relaxed/simple;
	bh=IuK+eM/ruVmfucxOCVpJr4pgRfUXO86poVMtwruf07g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmc3pYQ2bf6ljtFstsYuihijlyMvc4PM8Rxl+RjJSl6EMqQQkCaz5ZTCw+84U0zPOf/1DnmzVC0wD1eqgNOGVlmrInAo3FUNFT3Fn6E/EvS3htn4tQsf0IvJXT+ZYaEMQ0CzK8ck+MR7aCkxOeblOLmVxnZ/Gnd0uCNUjARopTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=dzKx4kuE; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 209C51A3A01;
	Wed, 14 Feb 2024 19:32:42 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707935562; bh=IuK+eM/ruVmfucxOCVpJr4pgRfUXO86poVMtwruf07g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzKx4kuEIwHcPcuEujpoVgHx0rE76yy/IdYr58ShNP4dfAhc1nuO+OJEP52A/zG0f
	 W4WsEIjFibsazN+qVMYvG7pwuEj1V9e+sNRHOw+VEk3U/nOHGMCcPhPR2QWoE7v9YU
	 2VU8XpVWrahb99EfwoxzAGj0aL83Pm4BDVAo2veNdQmuQXUJ8N06A0U1NlyzTTjNiD
	 odgj/SDZRHnbJ0PvQZL8NzXL89p0k6KtVrLqyslP+ObYc1SlMOGJ9vHOgVrDVVB0g+
	 nnjUuLpK7ENXSavc9IkdJeaTdZldUiLXs0tEyr19A4dzk+niCL13FBYlxpNMpL8dFT
	 v15zJYLN1NB/Q==
Date: Wed, 14 Feb 2024 19:32:41 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "Xu, Pengfei" <pengfei.xu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "luto@kernel.org"
 <luto@kernel.org>, "kirill.shutemov@linux.intel.com"
 <kirill.shutemov@linux.intel.com>, "brgerst@gmail.com" <brgerst@gmail.com>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xin3"
 <xin3.li@intel.com>, "roberto.sassu@huaweicloud.com"
 <roberto.sassu@huaweicloud.com>, "petr.tesarik1@huawei-partners.com"
 <petr.tesarik1@huawei-partners.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "peterz@infradead.org" <peterz@infradead.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
 "keescook@chromium.org" <keescook@chromium.org>, "Huang, Kai"
 <kai.huang@intel.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>, "zegao2021@gmail.com"
 <zegao2021@gmail.com>, "Rodel, Jorg" <jroedel@suse.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240214193241.7447a082@meshulam.tesarici.cz>
In-Reply-To: <a27c9c32e410fc3582f3593f209cc1cf3b287042.camel@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
	<20240214174143.74a4f10c@meshulam.tesarici.cz>
	<a27c9c32e410fc3582f3593f209cc1cf3b287042.camel@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

(+Cc Kees)

On Wed, 14 Feb 2024 18:14:49 +0000
"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:

> On Wed, 2024-02-14 at 17:41 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > Second, a sandbox can run unmodified kernel code and interact
> > directly
> > with other parts of the kernel. It's not really possible with this
> > initial patch series, but the plan is that sandbox mode can share
> > locks
> > with the kernel.
> >=20
> > Third, sandbox code can be trusted for operations like parsing keys
> > for
> > the trusted keychain if the kernel is locked down, i.e. when even a
> > process with UID 0 is not on the same trust level as kernel mode. =20
>=20
> What use case needs to have the sandbox both protected from the kernel
> (trusted operations) and non-privileged (the kernel protected from it
> via CPL3)? It seems like opposite things.

I think I have mentioned one: parsing keys for the trusted keyring. The
parser is complex enough to be potentially buggy, but the security
folks have already dismissed the idea to run it as a user mode helper.

Petr T

