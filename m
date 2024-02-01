Return-Path: <linux-kernel+bounces-48886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940E8462C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1754E28DD4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAFF3F8C7;
	Thu,  1 Feb 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhtMoYbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEC39AE1;
	Thu,  1 Feb 2024 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823836; cv=none; b=WCYJJGOB6I6BOkmoszg43TNb0w20gYig+NAQxI+dtWSwPqQ9j9yuwS9Xo1dDLWO/MJhQWEaPpGAhL12aayflAS9iZ+TbjrkZQ9EXkXjCMFZk+lYJLulRQSn2AkJEHYrBOkMeFzeTxOYvZO/iEyM7bvmT2f2ywyp63cfJqbdYgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823836; c=relaxed/simple;
	bh=GT8n6a2f4TX/O/sQ4NGGpwa4SOMqPEMREuy8nUejw3c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F/yXFhFNF75YnK4+4FmnyCEYYJKSkWiWPvXam4yh0c/1DEYOZiI/K4rGYSASZeDnU6ltiJ3KZdmx8p33pW8Bcplkhn5fDmv2buyYkVf7FnJFSvKJAR8KVHBO1u4hTLJcBL0Ywi9skJ9BV7GT2rKD3ER42Y8QucJ0iw+di1H2KUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhtMoYbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B2AC433C7;
	Thu,  1 Feb 2024 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823835;
	bh=GT8n6a2f4TX/O/sQ4NGGpwa4SOMqPEMREuy8nUejw3c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XhtMoYbNwDCzRUCqrtK+w7v8BEbqeYGjmEXsEbnqvihKmxLVgklML6CPzmqrRwXUy
	 3L1RfVauMzWWwh2GGz/TSUmH1n3UfiUTCQ2qIWQorkYyh08iCSKdKWOB0vOF2IyMos
	 o3fA3gU5yoQrJ8pbqk3wsaOum4okHy/Ia8SvdDhFCV1EBXy5sUGUMx4reQp6L9oHES
	 iLDBLEfwAKFOvrPxfrLkhyaICfRArVmvKwfxaFVRF/sLjRUB6XMrIxlMm5nZ+tZk64
	 4A/MWNkX2Hf9aWob7U1JXz4IvR56NM4w3r30F78OOMWH6XKn22DOZ4MFJ5aldKw8Me
	 OQtiBwvO35Rxg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 23:43:50 +0200
Message-Id: <CYU2JV57VXA9.3C5QTG4LX50TD@suppilovahvero>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dan Williams" <dan.j.williams@intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
In-Reply-To: <65b93f2b3099b_5cc6f29453@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue Jan 30, 2024 at 8:25 PM EET, Dan Williams wrote:
> Jarkko Sakkinen wrote:
> > On Tue Jan 30, 2024 at 7:22 PM EET, Jarkko Sakkinen wrote:
> > > On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> > > > On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > > > > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > > > > >=20
> > > > > > Ah, thanks for confirming! Would you like me to send a revert p=
atch or
> > > > > > will you do it?
> > > > >=20
> > > > > Revert "KEYS: encrypted: Add check for strsep"
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > This reverts commit b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > New encrypted keys are created either from kernel-generated rando=
m
> > > > > numbers or user-provided decrypted data.=C2=A0 Revert the change =
requiring
> > > > > user-provided decrypted data.
> > > > >=20
> > > > >=20
> > > > > Can I add your Reported-by?
> > > >
> > > > Yes that works, Thank you.
> > >
> > > This went totally wrong IMHO.
> > >
> > > Priority should be to locate and fix the bug not revert useful stuff
> > > when a bug is found that has limited scope.
> >=20
> > By guidelines here the commit is also a bug fix and reverting
> > such commit means seeding a bug to the mainline. Also the klog
> > message alone is a bug fix here. So also by book it really has
> > to come back as it was already commit because we cannot
> > knowingly mount bugs to the mainline, right?
>
> No, the commit broke userspace. The rule is do not cause regressions
> even if userspace is abusing the ABI in an undesirable way. Even the
> new pr_info() is a log spamming behavior change, a pr_debug() might be
> suitable, but otherwise a logic change here needs a clear description
> about what is broken about the old userspace behavior and why the kernel
> can not possibly safely handle it.

The rationale literally gives empirical proof that the log message
is useful by measure. It would be useless if log level is decreased
to debug, as then sysadmin's won't take notice. I don't really know
what is the definition of "spam" here but at least for me actually
useful log message are not in that category.

Issue was legit but git revert is objectively an incorrect way to
address the bug.

BR, Jarkko

