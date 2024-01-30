Return-Path: <linux-kernel+bounces-45034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89037842AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6CC1F278FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB4129A89;
	Tue, 30 Jan 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2FB7jMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D89364AC;
	Tue, 30 Jan 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635358; cv=none; b=HlVks0kry9iDrVwgbWf6evkZuRo7dOnBxbpaoTIn0ik9iBIHwZRTzseqSqgq3lvEiLUpFNRPGe1ofPEiMqPPKrJpHORo/b4QMGipavcAiQ5feoCkkDvYS2EyMKdZ7XuBGxl7n6q8Jen7FAxW0ns8Q/1uwG2brXS1LRfv+G2A8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635358; c=relaxed/simple;
	bh=ju5+fIhGys1s4Yvih8zTw/mrpn562bGGj18DsSWfWaU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ItDvxAYSU49qK+n9mIxUhR1znlj6l41jEZCn94Gum8zClbORdE/wdM/HsbkgFmDHvi2vIpyC03EDGOIqw4HtPzo6F1vkAk4wBDMerZR7oi5HD0720NKjiD/82rGCDxkopCXSpSiN7iQMsNI777ooASfne8k4GKOI8T/HprSc8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2FB7jMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE1C433F1;
	Tue, 30 Jan 2024 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635357;
	bh=ju5+fIhGys1s4Yvih8zTw/mrpn562bGGj18DsSWfWaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2FB7jMSpiTHPf9zT8UDkEUEbTxVUXY4bqp+SnrEP9Mg5tFTNVYpj6AAQUYtTmvqh
	 liMbd6GxHdNZCYCSRQuXVNjtAkR3fBobldlAxmCRLI291N4VOYBMF89jY+cZMRd+jZ
	 ErO5ej0tWjIHm/mjlsTcYJPovj8mpYs/alCqog4N466/PfXacPv9SGHHyvBJraygrQ
	 UFfEMwElSeFBzdv8cBruc1eTlPfreBUJ3Fz0XDystOjLT30O/MG9yUx6azNHRKjEg5
	 H9QOc1pK0L6gYQjkeXjzPKUrDqFG+694TW7qcSvfgje127A6sIWT7x5/6gtM1EYCIN
	 sgKB/HH1qX4EA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 19:22:27 +0200
Message-Id: <CYS7QMYS8XAJ.2QPI3MS5KXK8E@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>, "yaelt@google.com"
 <yaelt@google.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "nichen@iscas.ac.cn" <nichen@iscas.ac.cn>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>, "jmorris@namei.org" <jmorris@namei.org>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
X-Mailer: aerc 0.15.2
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
 <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
 <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>
In-Reply-To: <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>

On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > >=20
> > > Ah, thanks for confirming! Would you like me to send a revert patch o=
r
> > > will you do it?
> >=20
> > Revert "KEYS: encrypted: Add check for strsep"
> > =C2=A0=C2=A0=C2=A0=20
> > This reverts commit b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > =C2=A0=C2=A0=C2=A0=20
> > New encrypted keys are created either from kernel-generated random
> > numbers or user-provided decrypted data.=C2=A0 Revert the change requir=
ing
> > user-provided decrypted data.
> >=20
> >=20
> > Can I add your Reported-by?
>
> Yes that works, Thank you.

This went totally wrong IMHO.

Priority should be to locate and fix the bug not revert useful stuff
when a bug is found that has limited scope.

BR, Jarkko

