Return-Path: <linux-kernel+bounces-112838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A21887EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE81F1C208BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE49101C3;
	Sun, 24 Mar 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="XNq14Ihd"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DF10798
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313169; cv=none; b=Kc/e/g/qLxEw1S/JL4TXGbPi/cxFZVmXF0CXi73xKeLm3uYL+dJYNK0E0HOT+QJ9vIZePBzsfRTuUbWOiKMwrDYpv6LgYMkQv8xCSkxmB1JaJWdHaRXQlH/Fk7lqJ4pfucBz5RhmdO3ZTpirqZ6tCxyexaZE96lzziB/rIzaEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313169; c=relaxed/simple;
	bh=MCjCSIh0iLTHQHvN3SjD4xTY4dgF7DwugQkcHwECOBw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MZBo9bbWSuywfZe6pIErrhSZjXQYhMfGL2sTy1cP05KN2hAHFJLe9cEi6I84d/qx1aQoVykdBOjbBq6YqImUzwb+0edOx67ZYwyx35Dh7VdlVmLyNo36vtXgdqMU+NiJUE9AKyhqxmUXCAw3iiLYVQQoCXNH7eegUduvKGLRPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=XNq14Ihd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711313163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCjCSIh0iLTHQHvN3SjD4xTY4dgF7DwugQkcHwECOBw=;
	b=XNq14IhdFh+pMAu22hBXdHvFh/f5vXmY46TWf9h6rIcaKC37poFot6k0lmM0E/oixiBI45
	Y1hbgCgIt4+eya2SGW6iKxFcQi7bsJEN6S2OrUOcOo8gQgkGT9VPLqOvQb9ZF7T4IBzORn
	8TnFAecbrlBIjGLON++wu5USWWyMzUASamDcVcymn3xm3fFiCldchFfLfnyJTNdDdeWcpS
	MTNHi++bmZTsVKWgPw/90EaOX4edYs9mQAKfiWAQOuGAZg+Q7v6Ikp/v5jBGYEFsKml/zF
	AeKxKTZrAzd0CRzRS79FPbrjUXSihJBmvmOTuzmSqDNz8Sge8b/8+ziIGvtsTA==
Date: Sun, 24 Mar 2024 20:45:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
Message-ID: <749b1cea4fd9e8d8debadc51cf3c0374d9878ae9@craftyguy.net>
TLS-Required: No
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: "Ard Biesheuvel" <ardb@kernel.org>, "Hans de Goede" <hdegoede@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
In-Reply-To: <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <a3aae375-5582-46e4-866b-6a81641998af@redhat.com>
 <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 24, 2024 at 10:43 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:


> Thanks.
>=20
>=20I pushed another branch
>=20
>=20https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=
=3Defi-clayton-3
>=20
>=20which has a proper fix for the issue that you found.
>=20
>=20As it turns out, the compat mixed mode (with handover protocol) was
>=20
>=20broken from the beginning, and the change you identified just happene=
d
>=20
>=20to trigger it on your hardware.


Tested and fixes booting on my Bay Trail tablet and NUC. Thanks for fixin=
g this!

Tested-by: Clayton Craft <clayton@craftyguy.net>

-Clayton

