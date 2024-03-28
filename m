Return-Path: <linux-kernel+bounces-123440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE808908AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6986429DCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B65137909;
	Thu, 28 Mar 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="5bMzjLzW"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256213777B;
	Thu, 28 Mar 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652068; cv=none; b=GGPL5XpFv3AKOTlXbSkyPH95n9LjKgcVEXYmOqqUkQ+vI89OdF3K964wIFGVjIlmtLOUgzD8X1dSekLm6co3DwDul29VKTUS6DX+ZVd3IfZKPW3qV1AVlqm09eY3/SsJ1M3UGW0YfPDhvl2PP1+7Gi3p/9XD+eVA/zYJABYSG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652068; c=relaxed/simple;
	bh=8JJ9p6lY9P8w8IbBioVbNGfdfLpZkqX+ZuL2awuKSIM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC76m5I0KDM8srswL7Os9fBzJSRu48s6kZVJYvkln4K0T+VvMbURzpkYbbVr1pOtXrghgAIPjGnRyY31dpyjCMD7kqbB21cmwG4HW5vxLtEqbknFnAM5ccgZ8l/1r+ZQz5QKnLyoIPPYOeLV3auH2SaIw5vyEuWgqVnULNyj3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=5bMzjLzW; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1711652058; x=1711911258;
	bh=8JJ9p6lY9P8w8IbBioVbNGfdfLpZkqX+ZuL2awuKSIM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=5bMzjLzWWcja+ZA1U8Sd4z+g+N8734Qk+FmP8GfAmatOwHanX6qEioeHz+S7kaV6F
	 HIo2tInlvJg/uWInypz7H2Iudeh661OPc/YU0E+q/5tRyT3i07tTdz+Xybnp7Q4S5B
	 g5WFOYvC/49xjm6nPtp42MXmsHb+YVKWne/CQZ0gltKn/P4Y41P/e2as+Rb00fkxLo
	 UxJQtAobRaXfKaqBWW41lb4NYL/DSEuD48HimbrlIz+yAbTpibpzHUjO3A5duwnoDP
	 0Dc4NF0zLx4qGJsMqAfIENmVPw06BXWNGhRY14OOFEA9fIFxwHylSLdf2ohGdZUX6H
	 yhGezeSAIhDlQ==
Date: Thu, 28 Mar 2024 18:54:10 +0000
To: Rob Clark <robdclark@gmail.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Dominik Behr <dbehr@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
Message-ID: <y5mjLoUp9fKwSNrAEOQJtfqfDZ5cYtsf_KcbNCWQieZE-uJXQJE6bQhC6oLfS6aBZRimZSarDjUmeakjwYZmtQZWPM_3lAENdY17K-VyGsc=@emersion.fr>
In-Reply-To: <CAF6AEGvUsP7fjqFH9Co1vE0ZGRmMXmFBCrNc3hCQwxky3mME3A@mail.gmail.com>
References: <20240322214801.319975-1-robdclark@gmail.com> <1Wwj_q3RYer6np0Orz0wJd9dlF82iBSX-PIVSlhCgJbpfVBMHF_CF04gHojkvqnvz9NXH6kACZGXQG9yXwtkbjIzLmdi-GNDkO5Nz2E-J9Y=@emersion.fr> <CAF6AEGvUsP7fjqFH9Co1vE0ZGRmMXmFBCrNc3hCQwxky3mME3A@mail.gmail.com>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, March 28th, 2024 at 19:47, Rob Clark <robdclark@gmail.com> wro=
te:

> any chance I could talk you into pushing to drm-misc-fixes?

Oh sorry, I thought you had access=E2=80=A6 Pushed with a minor edit to rem=
ove
unnecessary parentheses to make checkpatch happy!

