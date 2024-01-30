Return-Path: <linux-kernel+bounces-45101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A2842BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DAE282A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BC158D81;
	Tue, 30 Jan 2024 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mC12iSFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A7158D68
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639021; cv=none; b=MMyIODp00BVUZyDBas6yK+YpkBZbaJJ84Lo9e82dd9arHZdy3nExUgudVax3QJqwtdHnxMnQomUe8862h23v6paBDJ07MhlERshkxFkRMv/8yl2EnvuUM8xomPcu9TeCJY2pcjgmcOKNFcT6uzoBuctwtI6mfr1SsZRVgOBZZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639021; c=relaxed/simple;
	bh=1rV7glRVC9LQuVPrfckA+vOHRK9H2274yjWNxzIJzJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp4z3lZHkD3ug25fhZCSkZrhnOsGHAPct77wSOM+vL41+MC35nm4X1JtvgjFO3/ev09aJXG4yNGJ1qlEihfUmdiEP3CEnsOcm/NbEUN6e5mv2S44jBfUVlKugvYClrlK7RmqqOAMjm1SKAQ6VWhv/Yyhcn8ymwlM8J3AdmnQlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mC12iSFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3103C433C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mC12iSFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706639016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnXqJccyWXUwaQ8U04P/DqGmNUTJucKfYaSYurjfy/k=;
	b=mC12iSFmISRE8/jMAFFM7hVqNh8Z+8J8eZkvsKaCH4IdBWcBQTxK5vLEJLtn51nnJXTps9
	LhULkCYWZIoIjrl4M2+wKsp+Krf3bAXwVV6tR80yguXCpVNxvvpV1wu9h7Rw52K8uTinjb
	2OU3X3MslNrGw3KQluVuRBxjnhaKMfU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 99bc7490 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 18:23:36 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6b7df10b9so72545276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:23:35 -0800 (PST)
X-Gm-Message-State: AOJu0YxYWJtpDmpew+TP8kV07lhgyyzwFkDLrqWVBvtM+ZaZiHuDYvkx
	F7KR6G/Ydg2eRZSSLKOjX0Xx44FuyyIj1+d1wsKZiOnDkLhDFzZnTTRbL0aC2Siyrqcsdia8Qmn
	hHnIzPqoZ2m1DIK8+yK6mp/z+BQw=
X-Google-Smtp-Source: AGHT+IGcs5WinitrF5W+OQbUaA5j68Aag/RxTMFHAKdaPmaqRar1aI8U/aQzvMBkMGv0EI6De0iGEhzI8juhG2fHnS8=
X-Received: by 2002:a05:6902:1b87:b0:dc2:2b0d:613e with SMTP id
 ei7-20020a0569021b8700b00dc22b0d613emr6377907ybb.10.1706639014139; Tue, 30
 Jan 2024 10:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <a076974c-e2c7-43c9-9858-71c913361cea@intel.com> <81359B1E-5293-4919-B319-59483C1EA12E@zytor.com>
In-Reply-To: <81359B1E-5293-4919-B319-59483C1EA12E@zytor.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 19:23:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9p60_N2zkx48fW-DQPAoXEOcFBe7pHAXQtF8rA3aqY-xQ@mail.gmail.com>
Message-ID: <CAHmME9p60_N2zkx48fW-DQPAoXEOcFBe7pHAXQtF8rA3aqY-xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:16=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On January 30, 2024 9:58:09 AM PST, Dave Hansen <dave.hansen@intel.com> w=
rote:
> >On 1/30/24 09:49, Jason A. Donenfeld wrote:
> >>> Anybody disagree?
> >> Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
> >> in a busy loop. So at the very least, your statement holds true only
> >> for RDRAND.
> >
> >Well, darn. :)
> >
> >Any chance you could share some more information about the environment
> >where you're seeing this?  It'd be good to reconcile what you're seeing
> >with how the hardware is expected to behave.
>
> What CPU is this and could you clarify exactly how you run your busy loop=
?

That is already in this thread already. Maybe catch up on the whole
thing and then jump back in?
https://lore.kernel.org/all/Zbjw5hRHr_E6k18r@zx2c4.com/

