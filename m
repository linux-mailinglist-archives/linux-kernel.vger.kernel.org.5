Return-Path: <linux-kernel+bounces-52376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3384974C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF07B2A654
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10213FEE;
	Mon,  5 Feb 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="pVGbEVLq"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA813AC9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127419; cv=none; b=rhYAmTzJl751bFlMYtESkHalstiL5GLuMoH+nMerPbyJe91kHBbapAdUifKQP8ApFwfv1dCxDDsTQfXnQLkvrRsaI8IUbx5gfetO4t34qQMGyopHDHgTnF9WBrdr7ZJa2gPIAvXePwlCh/kQ6OoOjo63l3bTVNR7wbtuvhkC3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127419; c=relaxed/simple;
	bh=dJZln88lN2ZOtbXwmt+yMlSaTT1Nk8VC901yTzLI2ig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD5ay6R1tZ4jT/WQ+mZ3M9q2wx6f2bdpMn1aSaqqHeHSYzxtJF5c0bxm3EiieoOu+11mZjWPevHq1xZWo5VJPtZlXjO22pJwfF6KUN9WiAXNAqo45k+dCXBbmdsE2WgzUExkD5O2EHcfzg/P0rP1hrqzbbIGAQIJ+ZUsRfC+JlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=pVGbEVLq; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1707127408; x=1707386608;
	bh=dJZln88lN2ZOtbXwmt+yMlSaTT1Nk8VC901yTzLI2ig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pVGbEVLq64Z72QK2ASwQL+a1FKRnyfWznXBq7pVrsdsnXTSS67Y+BojhI3gpgEPXN
	 /N19cIicqzVUdErhaeM/T2TBVMU8l5OXGRZGvzxPc1pb292wlew1Dm4rm3Fm3Y6WCr
	 /yLOAKpq01CtV0eYvrCFnkg/KUDzxllY/TiS4DBqoQB1Hva0CwtDHwFhIeEq8y4IVu
	 +HbUvCswtbLeyeYa5eSFGlvsb/W+POWlZVHwgcW0DK53uE3C/G852u8EI6faW+EeTC
	 5qE3JTM1wK1NwwORpOViAuKO3u2eDo8iMezEjU917jE2VAtNu+115LbneylK6D+DHf
	 TAeEBHXjOD4FA==
Date: Mon, 05 Feb 2024 10:03:06 +0000
To: Randy Dunlap <rdunlap@infradead.org>
From: Simon Ser <contact@emersion.fr>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/rect: fix kernel-doc typos
Message-ID: <4PPACX1VSbdsr3LqjGlbIvjHczzD8WBgJV7t9XoTUyyQxehNIEoEgNj8zYfoHeBxTg-Gu4fS73BaUzArHply-sDFqZK9y-kHEwZ7hQKJ51s=@emersion.fr>
In-Reply-To: <20240205054101.27929-1-rdunlap@infradead.org>
References: <20240205054101.27929-1-rdunlap@infradead.org>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pushed to drm-misc-next, thanks!

