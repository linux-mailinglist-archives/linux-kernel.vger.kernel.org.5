Return-Path: <linux-kernel+bounces-149958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7B8A985C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106451F2226E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE515E5B8;
	Thu, 18 Apr 2024 11:15:44 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6315E1F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438944; cv=none; b=qk5+24qXMG9CEsIKJ7xNuGFJkCG+S1FBCXC1t59uBIdGD7guSBQWJfsY8iO3NF/EHwyGYBz/sJ8JeLJX51FaNmBNllOeCCNAW0V2kMc8yBFzm1RhMTc+4x8RMN0/wsrCROAXA78e/k9bt+kE7CDJlwHzAOx4mSEEHN60wYktzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438944; c=relaxed/simple;
	bh=p/1VN5Ulog7SUvFAyS3pCuUF74jV5BsFRqhBTaFyrX4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Qk5FJ82314dgO3GLlYC4A/4Os0ijjFC+Hm+eBq23HEzDaU558fImk0YULAbDm+9OAGA6j+6jFxhVuf8zwrjrCwzhW58wQgNIBNwzag3sHdIsahxSc3kNq504HoSbs7Bk2yyqhUjqSnDWhJMEVwyne74hwTD9HgGozTJphtH4W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 85F2940E024C;
	Thu, 18 Apr 2024 11:15:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2p-1DjKTukcD; Thu, 18 Apr 2024 11:15:36 +0000 (UTC)
Received: from [127.0.0.1] (dynamic-176-005-029-198.176.5.pool.telefonica.de [176.5.29.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACA9B40E0177;
	Thu, 18 Apr 2024 11:15:14 +0000 (UTC)
Date: Thu, 18 Apr 2024 13:14:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com
CC: x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, song@kernel.org, ribalda@chromium.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev,
 ns <0n-s@users.noreply.github.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_x86/purgatory=3A_Avoi?=
 =?US-ASCII?Q?d_kexec_runtime_warning_with_LLVM_18?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
Message-ID: <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 17, 2024 11:53:44 PM GMT+02:00, Nathan Chancellor <nathan@kernel=
=2Eorg> wrote:
>Hi all,
>
>After LLVM commit d8a04398f949 ("Reland [X86] With large code model, put
>functions into =2Eltext with large section flag (#73037)") [1], which
>landed in the 18=2Ex cycle, there is a runtime warning when loading a
>kernel via kexec due to the presence of two text sections (=2Etext and
>=2Eltext)=2E

How much of this silliness should we expect now for other parts of the ker=
nel?

Can we turn this off?

Why does llvm enforce =2Eltext for large code models and why gcc doesn't d=
o that? Why does llvm need to do that, what requirement dictates that?

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

