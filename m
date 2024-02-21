Return-Path: <linux-kernel+bounces-74766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6A85D955
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01241F22005
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225877638;
	Wed, 21 Feb 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6UPy7PB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73869DF9;
	Wed, 21 Feb 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521433; cv=none; b=LEY03fZy4b3jFbTX82is3Aw89biaA0CcAsCk4vj0WheSEK6ZIUL38dhYMk96+5cCsDVegpT3hpU7tPocpiZQdLppQsXZB+jCQNsTcywbmm2fy8C+6bofmeWNgqF83J9NZkJWX8jzZg2zSziPN4TkEioAn9hXa2du7hY3kA6bYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521433; c=relaxed/simple;
	bh=xp/6r8cBzezuXAMNfTiVfsLPTU5WD4SpRZLw2L8M+8k=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=D/HAhIR/uj1jPsC+Tg9BA21Pz+uUFdAn6hAYGrLWC1NQvMfPL2xz+zuPgsdbryX+ly7+YaVfppZ66e+YdHFsfJ19yKq0XYpJdVX/iY2SvIWBwqEjyxxTktz4e70d6GUrYSgv57rzfb2Ui3puL93d7l8diTnwObcI8RlPIAcQTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6UPy7PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBAAC433C7;
	Wed, 21 Feb 2024 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708521432;
	bh=xp/6r8cBzezuXAMNfTiVfsLPTU5WD4SpRZLw2L8M+8k=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Z6UPy7PB0DbNCkrToyxFO+m9LmznNgtFyqrWqr/7x16XN6qJfvDxqfn7IBccY/hZC
	 BfpSc+37UEGSRf7A4KRNPJRsMXeKIBHhl4BwOsfRYYbGub4l+bUKeO4vDCvAwiVc7F
	 wwuZoAO9Npde7MrsXpy3XcdAZDkKxjEilxT7MUj+k0uGPoRwPaV3QIqK55CSn9rEg7
	 XWE67SSKEObgIiptsrRi9ccbiXqcO3s2IUxXhv+qkNnshN4oKCN8J8soctDRt4qbVy
	 7G2UwI/3AokrPKz/OhAP0nOD5mEgXlf1wQUPzLj/3fOcJYhL9FYN0UypODBbW7YYxy
	 hpHl1YEigEo6A==
Message-ID: <ce9b5e36483676425eeff69c09b28671@kernel.org>
Date: Wed, 21 Feb 2024 13:17:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: Re: [PATCH 2/3] drm/sun4i: Add more parameters to sunxi_engine
 commit callback
In-Reply-To: <20240216190430.1374132-3-megi@xff.cz>
References: <20240216190430.1374132-3-megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, "Chen-Yu
 Tsai" <wens@csie.org>, "Daniel Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Ondrej Jirman" <megi@xff.cz>, "Samuel
 Holland" <samuel@sholland.org>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 16 Feb 2024 20:04:25 +0100, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> These will be needed later on when we move layer configuration to
> crtc update.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

