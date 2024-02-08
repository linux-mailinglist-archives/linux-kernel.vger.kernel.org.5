Return-Path: <linux-kernel+bounces-57847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5D84DE25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28BB1C20E02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D66E2C9;
	Thu,  8 Feb 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MOI1eYpO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA76EB40;
	Thu,  8 Feb 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387709; cv=none; b=WaRM2imvntCGvcKlO1I2M8e7t1SeZgH25LmWcsH3T/sshttpfxUziALHT8sKQNWMvgwwuE5rEwnjmxrfaEg67e4uSn4jhvIfSwxXig21/VDTlF327qv5/nN2IyiygoGTpEh6YYEw3++Yht5pPEMDpQK0pjCLDFgVgfxxrrNKMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387709; c=relaxed/simple;
	bh=qDWuuRBf1xxz5bsMVwW9ZMIy2L8bfUVRk/L4iuIDJfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+qZD/GdilQ9g5GP1O+yFry9kniZNeLUZ7Rbt76YpGgESOBzXO+r31tpe93+fakE0YOK6faZYbfiKwAUW4tlLsRgEu+0bGRcpy0VVV1u+wIBo9m5oLAKNgbiRHaZRB/1qOFuY014ayQxtYHJ2c/w8gSVT0H83jffnnnK7oUmP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MOI1eYpO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D8F440E0192;
	Thu,  8 Feb 2024 10:21:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 02oHg6pEHWu9; Thu,  8 Feb 2024 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707387700; bh=zDCN9B1OwiFdxzxU1s/nmeWzomSeDzTk/K6y01fn1+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOI1eYpOGTSx7CbW83dK6BcrFrDNqsKnW6HW77c8OQMD2MJEA20pI8qfy74hHc3T+
	 DGTeYmGp2brU1gfv1e7R796eLp/e4xGD40VK4I0P6uI99qlws6xapgNE6tO0Vst1E2
	 zBZ4w/gwd5b3zo7XcSAdoqh8EwANSfzZcRPGZxdhNhf8c8ZlZmbnN4SNutQ3j4IqQb
	 gOUrQDhkpUjr/LXvUydObzHOxRt5n5tGFpasOGp7EE0S//RkFzrXatsH875jXebCh0
	 eoIDx/M4+H29fKGUmVxumOUG+hsCATGiFx08RVbHE09gJabMqZyDjAWnLEbZvcl8Rl
	 N2Dx9OLdMRUZCj0Y9a1DfUq6CwyF6KscE1Ck8w4GzPAX70RTglga0xEbRZcaPxQbsu
	 +MUHL/t1dWi+7pAHPifKYyco5C8kXIaImmZtDcOPV7RE3VoKRmstUBn8Uob7F0EOrs
	 v31b7dXfa0akR3W1iV21xdUml/LHgrFV1C7FQZJbxRUUXcRG+xaejDo1+ejYl4byw9
	 el1ieyZel11YSqhKfVuOA0SvESjjVCDZUvtSlMxXGnAgXZnGXLAMXcePm4uJgcOjK2
	 DPgLt9Xhk1rYvKm52Gr5brcqxmh6Y3im6+WhRwV2L0tZC8KQu4dOBhLIsdbJE3sdBs
	 WDasJ0kU6ncvLiyrnKejIqhg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4525A40E0196;
	Thu,  8 Feb 2024 10:21:28 +0000 (UTC)
Date: Thu, 8 Feb 2024 11:21:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Message-ID: <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
References: <cover.1707363758.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>

On Thu, Feb 08, 2024 at 11:46:27AM +0800, Perry Yuan wrote:
> The patch series adds some fixes and enhancements to the AMD pstate
> driver.

Is there any chance you could stop spamming people with your patchset?

102625 O T Feb 02                Perry Yuan ( : 12K|) [PATCH v2 0/6] AMD Pstate Fixes And Enhancements
104232 O T Feb 04                Perry Yuan ( : 12K|) [PATCH v3 0/6] AMD Pstate Fixes And Enhancements
106714 O T Feb 06                Perry Yuan ( : 12K|) [PATCH v4 0/6]  AMD Pstate Fixes And Enhancements
107828 O T Feb 07                Perry Yuan ( : 13K|) [PATCH v5 0/6] AMD Pstate Fixes And Enhancements
108745 N T Feb 08                Perry Yuan ( : 13K|) [PATCH v6 0/6] AMD Pstate Fixes And Enhancements

You should send stuff once a week tops, not every other day.

While waiting your can read about it in Documentation/process/submitting-patches.rst

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a few weeks (typically 2-3); if that does not
happen, make sure that you have sent your patches to the right place.
Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows.

It's also ok to resend the patch or the patch series after a couple of
weeks with the word "RESEND" added to the subject line::

   [PATCH Vx RESEND] sub/sys: Condensed patch summary

Don't add "RESEND" when you are submitting a modified version of your
patch or patch series - "RESEND" only applies to resubmission of a
patch or patch series which have not been modified in any way from the
previous submission."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

