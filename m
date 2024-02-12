Return-Path: <linux-kernel+bounces-61103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD91850D54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4AE1C2176C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40386AB9;
	Mon, 12 Feb 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPH8JGEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068B2F55;
	Mon, 12 Feb 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707714725; cv=none; b=LsouEeBWJhTZv+CAnC2SWXLa1mLTYsyK5pzR5kExViNZhmfQN3Fmnu1DFBigtZiZFoQwv/M7dzzl4tyfF6JdjVwRBsGNpFXXjgfUAxA2P6LA37jZuk9tY2LrVVc1oqdrBmxMrgLCLZr4RqM/mMHhwDKrU6VcLjua0u27+2M+3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707714725; c=relaxed/simple;
	bh=Inesfow/+o5xS1pMzhZ/lezVf1fXzsERlilchZkTN6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=StrILRXzTLXh4fkTSyv3S35Cx+f9SBK+TSq5Hph4ZT8ijt1WD5A0dwp9M+DIxrAN+vCXnwj+V8p7pHZgxXX9IkPvILyDisHY2uCgss6yNiug5l+RMhgXAM+DZWQ7wXIxkisjO/6RboBpVrWC1YYC+6bivmbOuOX0Rv49GOZX/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPH8JGEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232E2C433C7;
	Mon, 12 Feb 2024 05:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707714724;
	bh=Inesfow/+o5xS1pMzhZ/lezVf1fXzsERlilchZkTN6E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bPH8JGEmOQUUJH8kCoM0AXr8VrwJ1nDOlPP3I3GF0e1ANYesf6SzSYI2AgIQLnkaF
	 KNrv5iI560dWFuyoTiLoeVVlYma+fgFfYY6QHCYej3KUzFPP8UCQe34xeslf2V6DIK
	 hWmYMfXjsassBvEaZN4Tv0129KMtyRvqanlHpy/tkS7xeNA2JJQIcMiXQ07wBb66W0
	 g/BnedkJyc40AAog97Wokaqhw+jfw7ukGZmlS6Dqi/EJ2Q8QP01nMHhGEAQiFfMFzd
	 XFhWDaXNf+ySOK1PEsAivM0Ce6eM84MgzGLNbPM5dROAb7VHNuU7MnJgotURudWXFO
	 vGo6Jit3yWYKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 05:11:57 +0000
Message-Id: <CZ2UCEZ1VT96.2QZE7X8CS8EJ2@seitikki>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Dan Williams"
 <dan.j.williams@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>, "dhowells@redhat.com"
 <dhowells@redhat.com>, "yaelt@google.com" <yaelt@google.com>,
 "serge@hallyn.com" <serge@hallyn.com>, "nichen@iscas.ac.cn"
 <nichen@iscas.ac.cn>, "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "jmorris@namei.org" <jmorris@namei.org>
X-Mailer: aerc 0.15.2
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
 <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
 <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>
 <CYS7QMYS8XAJ.2QPI3MS5KXK8E@suppilovahvero>
 <CYS7WMFLXNE1.35OBTKTONKNX3@suppilovahvero>
 <65b93f2b3099b_5cc6f29453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CYU2JV57VXA9.3C5QTG4LX50TD@suppilovahvero>
 <d0ccd2f19ed1adccc8f3dfe677c30bc44feb3d36.camel@linux.ibm.com>
In-Reply-To: <d0ccd2f19ed1adccc8f3dfe677c30bc44feb3d36.camel@linux.ibm.com>

On Fri Feb 2, 2024 at 12:05 AM UTC, Mimi Zohar wrote:
> On Thu, 2024-02-01 at 23:43 +0200, Jarkko Sakkinen wrote:
> > On Tue Jan 30, 2024 at 8:25 PM EET, Dan Williams wrote:
> > > Jarkko Sakkinen wrote:
> > > > On Tue Jan 30, 2024 at 7:22 PM EET, Jarkko Sakkinen wrote:
> > > > > On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> > > > > > On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > > > > > > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > > > > > > Ah, thanks for confirming! Would you like me to send a
> > > > > > > > revert patch or
> > > > > > > > will you do it?
> > > > > > >=20
> > > > > > > Revert "KEYS: encrypted: Add check for strsep"
> > > > > > >    =20
> > > > > > > This reverts commit
> > > > > > > b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > > > > > >    =20
> > > > > > > New encrypted keys are created either from kernel-generated=
=20
> > > > > > > random
> > > > > > > numbers or user-provided decrypted data.  Revert the change
> > > > > > > requiring
> > > > > > > user-provided decrypted data.
> > > > > > >=20
> > > > > > >=20
> > > > > > > Can I add your Reported-by?
> > > > > >=20
> > > > > > Yes that works, Thank you.
> > > > >=20
> > > > > This went totally wrong IMHO.
> > > > >=20
> > > > > Priority should be to locate and fix the bug not revert useful
> > > > > stuff
> > > > > when a bug is found that has limited scope.
> > > >=20
> > > > By guidelines here the commit is also a bug fix and reverting
> > > > such commit means seeding a bug to the mainline. Also the klog
> > > > message alone is a bug fix here. So also by book it really has
> > > > to come back as it was already commit because we cannot
> > > > knowingly mount bugs to the mainline, right?
> > >=20
> > > No, the commit broke userspace. The rule is do not cause
> > > regressions
> > > even if userspace is abusing the ABI in an undesirable way. Even
> > > the
> > > new pr_info() is a log spamming behavior change, a pr_debug() might
> > > be
> > > suitable, but otherwise a logic change here needs a clear
> > > description
> > > about what is broken about the old userspace behavior and why the
> > > kernel
> > > can not possibly safely handle it.
> >=20
> > The rationale literally gives empirical proof that the log message
> > is useful by measure. It would be useless if log level is decreased
> > to debug, as then sysadmin's won't take notice. I don't really know
> > what is the definition of "spam" here but at least for me actually
> > useful log message are not in that category.
> >=20
> > Issue was legit but git revert is objectively an incorrect way to
> > address the bug.
>
> No, I made a mistake in upstreaming the patch in the first place.  It
> broke the original "encrypted" keys usage.  Reverting it was the
> correct solution.
>
> Mimi

The way I see it the semantic change caused the bug because it was not
backwards compatible. That does not make the log message less useful.

BR, Jarkko

