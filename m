Return-Path: <linux-kernel+bounces-101645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60E87A9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E6B281ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8741A89;
	Wed, 13 Mar 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AzWA8Opr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF005446AF;
	Wed, 13 Mar 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341565; cv=none; b=CkohMoWvjNwY+NYOifRwGVAl3l3Cda5aomg5GCXZTY8TnSdxaXC3vqWQKGEA4VKq3z6hHqKrFuzM3aDwyUAbtyK5o8VH4mhq7ZdKhNZbrnIq6Vb3vQdaMFGf9BKAx2xbHGx/Xk8UGYcv+tYeAywbiFUgUg71sLPLAU+eWoBSa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341565; c=relaxed/simple;
	bh=vFXWxve9o2Pt9XseQJKclCeZeZ7/wfVpmI30eoflnTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drGmOEGHc/STnYUriTi2XMY0d+5ozOjZx+GsHa9kpS8eweubFXHI67W9lUj2eX7RVpj5UNEA+8NUjBU19OgvL4IH40YjYxpPNG1CUDv+eHRxBho0zXLhIWpjia9zaj3/IaejrIcD0LN9m5cJ3HvR8Sa4+T1PY/0JTyQUNi7ycAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AzWA8Opr reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 390CA40E00B2;
	Wed, 13 Mar 2024 14:52:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E9ZAVRl9-wKx; Wed, 13 Mar 2024 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710341555; bh=UiFIgJgDXJGtTsG+zuxtYxOxDMW/vbAMh/rnnLfNV5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzWA8OprmzCN8ML0ADF0HfyB2vwI3UUghfrTt44vUtVcuhNRizTg1GpCAQWjoXn3O
	 4DcMiagebYf7eRUZGw/QVO9vPLWz9kSxkE6NA7S8yZI0S7dVarTBbVQgZ9TvHemLCK
	 ZeXr2W0TKsf1iFg0qvnMpNarDsEnAJeahtpd4oV80eHkrrbctl6L6mtPC6r5LRLth4
	 zx9ApnNboTV3HNWWpWvpZQ308fDeIxZvapc5i6uZhcw2EqyTnHxqBAsTwjlBBP3CtP
	 KvKe5/nrHMjLU1jmEm2BCTLFN5f0jexsdTc6edkDv7S0PLG5heiZG2xVJf5NrhXpDM
	 xUcolzn021efnAAiJFxX2xy2oYxuZd4+XZ7HxpRNJXZZelda9pwghPE/sqEpqJTVbk
	 xUEEvZ7zhr2aBZhb46IGjGg53i4+uzbkZIZL7t/pWQ5NjBkagPlVW+nkP/365boFG/
	 J8E51DrYIuDQbV78mbBA0jEy9ycWFO8ikx90Tc54300enpbIbQs1R6il0I8kseaPAi
	 RAQ6ROtcuyhvuZAYyVXFBFKs4uddzPJUKZoW3Av6AWqxvNkgZz73p4tgQVBTDAATgp
	 qsLd+WblnVCZC82dO7bPsPZ0y1pzExu1JbGnoDi+kJGrsmOjodLF8yV1gAfuZSc0Bq
	 DIbXUxbdWhO3WHLBOzwubuj8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBFB240E0028;
	Wed, 13 Mar 2024 14:52:23 +0000 (UTC)
Date: Wed, 13 Mar 2024 15:52:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>,
	syzkaller@googlegroups.com, linux-edac@vger.kernel.org,
	hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, tony.luck@intel.com
Subject: Re: [Bug] WARNING: ODEBUG bug in __mcheck_cpu_init_timer
Message-ID: <20240313145218.GCZfG9ovrh2ukJ9uAO@fat_crate.local>
References: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:26:28PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
>=20
> We encountered a kernel warning with our modified Syzkaller. It is
> tested on kernel 6.8.0-rc7. C repro and kernel config are attached to
> this email. Bug report is listed below.

See if that fixes it.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 13 Mar 2024 14:48:27 +0100
Subject: [PATCH] x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Modifying a MCA bank's MCA_CTL bits which control which error types to
be reported is done over

  /sys/devices/system/machinecheck/
  =E2=94=9C=E2=94=80=E2=94=80 machinecheck0
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank0
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank1
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank10
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank11
  ...

sysfs nodes by writing the new bit mask of events to enable.

When the write is accepted, the kernel deletes all current timers and
reinits all banks.

Doing that in parallel can lead to initializing a timer which is already
armed and in the timer wheel, i.e., in use already:

  ODEBUG: init active (active state 0) object: ffff888063a28000 object
  type: timer_list hint: mce_timer_fn+0x0/0x240 arch/x86/kernel/cpu/mce/c=
ore.c:2642
  WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
  debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514

Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
does.

Reported by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/CAEkJfYNiENwQY8yV1LYJ9LjJs%2Bx_-PqMv98gKi=
g55=3D2vbzffRw@mail.gmail.com
---
 arch/x86/kernel/cpu/mce/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
index b5cc557cfc37..84d41be6d06b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2500,12 +2500,14 @@ static ssize_t set_bank(struct device *s, struct =
device_attribute *attr,
 		return -EINVAL;
=20
 	b =3D &per_cpu(mce_banks_array, s->id)[bank];
-
 	if (!b->init)
 		return -ENODEV;
=20
 	b->ctl =3D new;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
=20
 	return size;
 }
--=20
2.43.0

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

