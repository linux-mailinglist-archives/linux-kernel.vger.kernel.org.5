Return-Path: <linux-kernel+bounces-20711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A048D8283E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C7E1C24714
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F0360BA;
	Tue,  9 Jan 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C6+AM1CU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEA36AE1;
	Tue,  9 Jan 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3C33540E0196;
	Tue,  9 Jan 2024 10:21:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n29gUFQZ12Kl; Tue,  9 Jan 2024 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704795715; bh=xjuqUo1N9un7QD2OXvyR+5fIfImqWhSyt6kzFoGIsSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6+AM1CUovm2+HNjxZyX+e4EIKEIps6SduVpK8vGtpGYTqJPSLpmUesTeMBRYtC/l
	 ncstqX3pXn8srWdzIdVsdEKq8ooWFHdCSaJvj1AQAGPytLN1msAn3y+y1MgL6Djb5m
	 lBtxP1+/M5nS1WhPCIIc6T23ro5CTW9UHQCw4UwRS+sCzB2HzY9oobVxcH93eT4ZY1
	 qxlNQqdozYylfVrn9n+ZK6sNc/Yw0iTaKOmklZ/lOA3zc1ywZB0lvPNy8Rz5WOKViX
	 qeG7s/66rfaIrNP9qJdAk2eIOWYE62hpFVxD0YKsKiq+wpEY7Fnzu59mFxY/JQbI0F
	 IkV5PllliIvA+/lAhfJgDqXjpbkRSWGjJSz+v4UhymUp4gHatNfK3VmRRLR5xBYJ/b
	 Gr0UXBYuwxvokdHt7ta0E7Kd0RHMW8VGUe3Nkc9ZgwU4KzpOXS+zfNGsR3HSvC5x+z
	 TNaIuhT76gqu8sXGV4OzVoA2faEwSbMK12i5lb9BHwZH5If8QWiMSF6V7gcZLZlvOL
	 nNx7pex887OQ3TJO7erJ3ljOVbRVnAKtWgsdYUBebxYgE9lul/RU7WYc2Nk1YboaXc
	 aMFr95IfvEdRMlN0UaeDskrX02L0lJlG5QGnS9BTd8Gi6dtM8hPzlY5Q/Sk5OZ2RrG
	 kJcYCWFSUzab6KPrW90pG7EM=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68D2740E016C;
	Tue,  9 Jan 2024 10:21:28 +0000 (UTC)
Date: Tue, 9 Jan 2024 11:21:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
	richardcochran@gmail.com, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com, zackr@vmware.com,
	linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
	namit@vmware.com, timothym@vmware.com, akaher@vmware.com,
	jsipek@vmware.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 0/7] VMware hypercalls enhancements
Message-ID: <20240109102121.GAZZ0eIZXV03k52jDX@fat_crate.local>
References: <20240109084052.58661-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109084052.58661-1-amakhalov@vmware.com>

On Tue, Jan 09, 2024 at 12:40:45AM -0800, Alexey Makhalov wrote:
> v5->v6 change:
> - Added ack by Kirill A. Shutemov in patch 7.

Please do not spam. Adding someone's Ack does not mean you have to
resend the whole thing immediately again.

While waiting, please read Documentation/process/submitting-patches.rst

and especially:

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a few weeks (typically 2-3); if that does not
happen, make sure that you have sent your patches to the right place.
Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

