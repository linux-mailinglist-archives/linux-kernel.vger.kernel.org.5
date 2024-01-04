Return-Path: <linux-kernel+bounces-16701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981718242AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C7286C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228ED22336;
	Thu,  4 Jan 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ahn/3crK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5E2230B;
	Thu,  4 Jan 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B86E740E01B2;
	Thu,  4 Jan 2024 13:26:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZqTtG1JNcLTX; Thu,  4 Jan 2024 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704374792; bh=1Bga3Oc0/FfATWs4xOTtGXjtDFgHK1/H9XT5vBXq0cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahn/3crK6bA90TIXsgmAC6I23fk+n+mUEHzdiLHFWF5R1eFbbFkndV/xK0AEhLpOM
	 m5ONnFOgbLyRce01Gj6d0TzD/MsGqieMJWM0hhHkz/t49Y7Z1zOpcQWsn12UVd4TlA
	 JK533nXJ1zANet8Em44kke+XiE/CtkgRozU0MnQrNSCf1yjBT+M+yxJhK0mgYfIKS1
	 v2Vw2+lxDwhLIHt44wi56r7RQeb/oktUoH3EEg8lnSpJdCtc8dCqpm1tvngkHD+bP0
	 6HQTPXedQiG321pxNj+OHgbywnYOXb2F6VgGasaifJS74eCAYQ7yzxTK+Zz0LX1/Q1
	 RFq7oodSYfJgM33W9h9MpCuGPSX+K2jGE9Z7buELhlr0KzducieGGYxcOfht1gsUnJ
	 cVKAIAcFJtP2dhxz9aho8nD8IwF/l283bX0io/qo1B520jEP1Wx+GnXoxajCP7LHZA
	 sfjluUFw84ScRjvZcEr8xkcC6ygJoXmPdJi5zqquQjJdSc9cbjdXj5adlQ4R+ndYSR
	 nwkUkjqPzzMS90d1RHzHV3bIy3aH11A6osGmutZuZT2Qm0Zz1+yxLD6Cm7C2XWEHOO
	 UsaKyOoV1jEcPDJ+S/SiQ/+/OjTMNULy6tfpujXWnfuPvCB07hoFoLSgzfGTRbYJbD
	 f0tW+IGJuY/BC7YoAracVf8w=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 998A540E0196;
	Thu,  4 Jan 2024 13:26:24 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:26:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
References: <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>

On Thu, Jan 04, 2024 at 02:24:46PM +0100, Borislav Petkov wrote:
> +void __warn_thunk(void)
> +{
> +	pr_warn_once("\n");
> +	pr_warn_once("**********************************************************\n");
> +	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn_once("**                                                      **\n");
> +	pr_warn_once("**   Unpatched return thunk in use. This should not     **\n");
> +	pr_warn_once("**   happen on a production kernel. Please report this  **\n");
> +	pr_warn_once("**   to x86@kernel.org.                                 **\n");

I'm not yet sure here whether this should say "upstream kernels" because
otherwise we'll get a bunch of distro or whatnot downstream kernels
reports where we can't really do anything about...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

