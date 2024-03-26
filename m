Return-Path: <linux-kernel+bounces-118624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFD288BD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC43B2434E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306F4C3DE;
	Tue, 26 Mar 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="17He3t5j"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EC43ADF;
	Tue, 26 Mar 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444540; cv=none; b=SWUkymkuA4MfyR1KUHjZ9GR5axJpl2BYVinR3oKzbuO1q5SlIWNgYEPXc1k+qPs/ZmjJGN0IP6eDouv2fK2zwbVqUH7Ha6NTwQWjhSJ13qt4PycwcjwyiG/2vNzCLjgKU9JuBufkG/JKiaUsqXmj7INTxCM2m2EyF5Wac9hEI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444540; c=relaxed/simple;
	bh=uHkjh4wo6VYxK6JVfU3FNXjUFPyNrDTyCb8FrZZAQDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxmyKFgficJNpJN57SbR3U9g5R1OMV2sHnwvECPc8XBGAbRJudMSAbPwl31hFmhh8qxjWWdjnzAQxtyyIE2nlnGg014QpQNopan7Z67jwBcNeI69IMzXVjIy2t+hdQ3CdM7s+nGp+SVEPUUD6ItfHbGzl2UY+ZWg9MFtqfi2i5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=17He3t5j; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1711444534; x=1711703734;
	bh=uHkjh4wo6VYxK6JVfU3FNXjUFPyNrDTyCb8FrZZAQDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=17He3t5jf/YJcqQ+xITAi1/j4sVJbJ9wHTNOzavkZpiI5BMpFkjUd52htbAwSq6i8
	 Ct8Szvrqq1fFT6c8aPvWXFrOwhCAO5WyEohafBaAz1/QPMZuooYM8b51fHGI24evJv
	 7G8Sl1mSU5gMwOeD7UIrl5+LWmAU/uPZqBivLpSonhL0yYITVbCqoiHSxAu5tTYlzb
	 q1ByBh5iEuo/Eye3G7LANNOwUZXT7cqDTLUwn880JWqxYpJUyZByXGDBHax6D83Q5V
	 Jgdbi2o9Yg2D5WtUbTiVsr8d0taJTZ6WjmglypTNc1nhPB7mrNacmXaFbvY+y4wFnR
	 PSa8xHj9idpdg==
Date: Tue, 26 Mar 2024 09:15:15 +0000
To: Rob Clark <robdclark@gmail.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Dominik Behr <dbehr@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
Message-ID: <1Wwj_q3RYer6np0Orz0wJd9dlF82iBSX-PIVSlhCgJbpfVBMHF_CF04gHojkvqnvz9NXH6kACZGXQG9yXwtkbjIzLmdi-GNDkO5Nz2E-J9Y=@emersion.fr>
In-Reply-To: <20240322214801.319975-1-robdclark@gmail.com>
References: <20240322214801.319975-1-robdclark@gmail.com>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Makes sense to me!

Reviewed-by: Simon Ser <contact@emersion.fr>

