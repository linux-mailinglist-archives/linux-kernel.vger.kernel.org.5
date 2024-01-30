Return-Path: <linux-kernel+bounces-45045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D814842AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F94C1C25DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894612BF03;
	Tue, 30 Jan 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7T8YvSe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B68128386;
	Tue, 30 Jan 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635822; cv=none; b=uARTK/4zp1SyExbpjOASRSUuRoKM/nslL9KHB6cZZgDqDeTJXUoic24HUgYzeufA/TnPi2kj3pwtYcXzBbviVF0VdfIshooWYNYAON73/uNm7NYkOpAO3ZPVoAXSOnEQPokrKXk/TGVG3mP6OqQf/kY5wwuU2lyhMZ+bHJqEI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635822; c=relaxed/simple;
	bh=B0eFt1/iq1Q7kXHqs4cpK2Jx0vshTUBlv/sAKuFh1zY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y1C+p3jrnJxGM+tNq8SNTS8M5Vs2/6w/bnRQHI7GX88INVG+ytQZfmiqdoC69jueLad1g2hsrYcZkba8bo7c4oXJ7ksA0fgsT7qxu0KPhywOb44t8pg2Cin0THZSC/VoromoC+IIidKSp/MVNpCE4gpP5jHX01DW8ogm0XmW6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7T8YvSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461FCC433F1;
	Tue, 30 Jan 2024 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635821;
	bh=B0eFt1/iq1Q7kXHqs4cpK2Jx0vshTUBlv/sAKuFh1zY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=A7T8YvSe6a/Uvc78h9y2l6LhBJRdJGTRVInE0cZN7k7I4vVCTLW5EFjS0NBiHDOa7
	 x0kat5UwDrJW1vaTWLwU0MqrDJQTzDoePiY21lRirxLHoGEG8cxNMSV8jp0lZLvau0
	 F/o98R7oFi9BY+md2KclDk8jAUy3MmkmIdtRgVb3xHWoYfUonolDcOpLCFiZdyWg5G
	 /jFjeh+zCgBZoYYD3rB2hU/Cl6QHbsViSizk8kRK4l9/EFcfM2bWQtk3dAaKVGZCSU
	 bRvinlDL3FMsgcth228saf9CNotJhF2xZGwjT2SnQ6dt3eClGPPGOuq01QZw4xtqNT
	 1fazf7r6yGmEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 19:30:16 +0200
Message-Id: <CYS7WMFLXNE1.35OBTKTONKNX3@suppilovahvero>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Verma, Vishal L"
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
In-Reply-To: <CYS7QMYS8XAJ.2QPI3MS5KXK8E@suppilovahvero>

On Tue Jan 30, 2024 at 7:22 PM EET, Jarkko Sakkinen wrote:
> On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> > On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > > >=20
> > > > Ah, thanks for confirming! Would you like me to send a revert patch=
 or
> > > > will you do it?
> > >=20
> > > Revert "KEYS: encrypted: Add check for strsep"
> > > =C2=A0=C2=A0=C2=A0=20
> > > This reverts commit b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > > =C2=A0=C2=A0=C2=A0=20
> > > New encrypted keys are created either from kernel-generated random
> > > numbers or user-provided decrypted data.=C2=A0 Revert the change requ=
iring
> > > user-provided decrypted data.
> > >=20
> > >=20
> > > Can I add your Reported-by?
> >
> > Yes that works, Thank you.
>
> This went totally wrong IMHO.
>
> Priority should be to locate and fix the bug not revert useful stuff
> when a bug is found that has limited scope.

By guidelines here the commit is also a bug fix and reverting
such commit means seeding a bug to the mainline. Also the klog
message alone is a bug fix here. So also by book it really has
to come back as it was already commit because we cannot
knowingly mount bugs to the mainline, right?

BR, Jarkko

