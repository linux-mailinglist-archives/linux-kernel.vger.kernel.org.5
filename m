Return-Path: <linux-kernel+bounces-25474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08D82D0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ECC1C20B42
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0A23D2;
	Sun, 14 Jan 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrvcvhDr"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9D20EB;
	Sun, 14 Jan 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd7804bfe1so192133b6e.0;
        Sun, 14 Jan 2024 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705241434; x=1705846234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3WSWsFwwTld+EBhM8k9IfVkNuRLcxeBh/RSNpXjBV4=;
        b=XrvcvhDrPRTgsGDORobI21nC7ijPouFQRFOyQWoTj+KEzK5pslclyXsqmX9asZXv0G
         IcmGCGE3gt3MSSOvfusmSPgka5pd51PVvc52sL6J32oJHdrlPF3mF8MfZ8aFRAiiRQ8n
         qNBD2HtN2ANZKwdCCSqUoNV8M3V19taxXy7Vreg5f6M/OsfSJzOqmseOAHRjlGOLZ7np
         ujJ6kJ+mzPsT8iWGRTHA2ETmdRgJbqkPCv+ZTzZHWAIjhX9kmP+Gdi76c5hEmJsj/pha
         //+CiYPCCc6OljWkuObDDlYucNyUbVKBukIngGa4u8ovZybsVz7r11Ucs6zUF0FrGb95
         a/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705241434; x=1705846234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3WSWsFwwTld+EBhM8k9IfVkNuRLcxeBh/RSNpXjBV4=;
        b=FkAQUCle2mAr5B1Ng78yUijiTbaob5slshRv0AdsagSpEbuDCzMf3fRoLLCspJXc53
         HyDlpYpnc0Ecn7RfjTDdpGPhkIejsEy4uLZVP2yfeRcuOmnMZdaRLDm7sv3id31ckrjj
         pQIlGc+lQjilQej8umq3lwPUdaLxk6DyakoB4wbnsRFOGG8c7EKEnPFDKK3S/e9d+Ogn
         iehdep4SD6qWDlEwzg8io/9NEQyJEfriRWbzijJpdiDeqpNUuBfGkd/xWbs71KEfkiUY
         K+8/ALO2mXSFBToRiQ1+H8T19WiHXnnzv1rFfEBiCWeBlw0cbiiZPirzqxioEfzZLvnH
         UiKw==
X-Gm-Message-State: AOJu0Yxyw8stcrPirya41X9wTLmu02OKOD28uUcdiygVEJ8xFVmOZVR3
	FPG1Ww2T/ZsFEG+N7Go0Tf4=
X-Google-Smtp-Source: AGHT+IGH4gKlLxUwdPkCvvMUxGUjrD1fw3NT1xCDk7taXv/tg9rvi/H2OakBBbeigLPzQkpgUCZn8g==
X-Received: by 2002:a05:6808:1b29:b0:3bd:7d40:50ff with SMTP id bx41-20020a0568081b2900b003bd7d4050ffmr100460oib.32.1705241434227;
        Sun, 14 Jan 2024 06:10:34 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l64-20020a639143000000b005c621e0de25sm6462664pge.71.2024.01.14.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 06:10:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 59C1D184CE5C1; Sun, 14 Jan 2024 21:10:29 +0700 (WIB)
Date: Sun, 14 Jan 2024 21:10:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Dr. Henning Kopp" <hkopp22@yahoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: Why does Linux not implement pthread_suspend() and
 pthread_resume()?
Message-ID: <ZaPrVWwqkHMj3Bpp@archie.me>
References: <0219492d-3971-f8e0-8b46-22d442a2d442.ref@yahoo.de>
 <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TWvxZVO7m6zehYbK"
Content-Disposition: inline
In-Reply-To: <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>


--TWvxZVO7m6zehYbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: linux-pm people]

On Sun, Jan 14, 2024 at 12:20:04PM +0100, Dr. Henning Kopp wrote:
> Hi everyone,
>=20
> I have a question regarding pthreads. In particular, I was wondering why
> there is no way to suspend and resume a thread in Linux.
>=20
> In Windows, there is SuspendThread() and ResumeThread() from
> processthreadsapi.h. However in Linux, there does not seem to be a similar
> function in pthread.h.
>=20
> When researching this issue i found multiple ways to work around the
> inability of suspending a thread, such as using mutexes. But my question =
is
> why nobody bothered implementing suspending/resuming threads.
>=20
> I found one answer on stackoverflow [1] that mentions that pthread_suspend
> and pthread_resume_np is in the "Unix specification", but not implemented=
 in
> Linux. I tried to follow up on this hint and get access to the Posix spec,
> but i am not affiliated with a university anymore, so i was unable to
> download the spec.
>=20
> I read "man 7 pthreads". It mentions that there are two Linux
> implementations of Posix threads, that differ in some details from the Po=
six
> spec. However, it does not mention suspending or resuming threads at all.

LinuxThreads and NPTL?

>=20
> I hope this is the right mailing list for my question. If it is off-topic,
> please accept my apologies.
>=20
> So my question is: What is the reason that Linux does not implement
> functions for suspending and resuming threads?
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--TWvxZVO7m6zehYbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaPrUQAKCRD2uYlJVVFO
owSqAP0bAMuxQXF0Fr3YegItigo8XQnksqwS5Uwao9oYRSz35AEAiGtXyqqsfkou
ftZEmy4Qp79j2I5gwFoq2X8n09FMTwk=
=iY4L
-----END PGP SIGNATURE-----

--TWvxZVO7m6zehYbK--

