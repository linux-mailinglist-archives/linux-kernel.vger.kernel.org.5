Return-Path: <linux-kernel+bounces-117490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15488ABEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238031C3BF10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16C1422AB;
	Mon, 25 Mar 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VXjFVbgc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F68126F03;
	Mon, 25 Mar 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384949; cv=none; b=tTYPnIz5r56mI/FbjEWuAKCXbnwanc1j9LSZhQ/lD7Fc+M75iqQBJrWkzMY7nBJ8gkk7C578NJlJ/zZx+bKFaSlcEhM5qsllccRGtTiONgpFvSQEzgWddaZx1mCO57vULLqGocUr2MHavG/htyjsTn+wKGv1feuF9mYdeQUKBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384949; c=relaxed/simple;
	bh=pyynAfuSU0pbJ2BuuKMAJJLX8fingppnNPWi/H/GmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRdIVSs86FASfrlEnJjzQZ65Q7iDjslMfObSe2r27Bq4kYn2WxFHQ9yN+S0lmm6HPUsq83K1il1d2CD5HPY4FOxPb6moaJqUj8fkTK3GVQaAk/oF311Mhl7x+j1RlxovpbDrolI4E+n4DNEUYPz0ptIOkEQulkhvzMSHjiW/re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VXjFVbgc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CAEBE0006;
	Mon, 25 Mar 2024 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711384944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyynAfuSU0pbJ2BuuKMAJJLX8fingppnNPWi/H/GmI8=;
	b=VXjFVbgcQmKO6hoK9y000CeGRATkQ5zkUux1/WB2KOXe3zb5PW6P6MdK3U/ZahxN8Neo9k
	qX78zltWuTeI0YR46mJJVmwjEDwfUtq8Qr/fUNi9BmvLnfvd2NT05/JkTa1s4x7pCuhqah
	zn8a4pWPlahTXYSB3MBFy1nWmZLCmjZ2zMjU1D4Mm1K0Gm2M+v+LxcxdRBsXoZooqIw19j
	sr8vi+XdCrsyZbcY0iTIZCuIM2GUCxjJnuHRs3uxVWYHYAlpyAIfj5GZa/cSkRGI//xUPW
	6AZcK1qZ4Vc5L1OKoYdcatqVieTDxVbu4M8GZPHR4gm434yk88b/xozsyP/pPw==
Date: Mon, 25 Mar 2024 17:42:22 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: media: tegra-video: Fix
 -Wmaybe-unitialized warn in gcc
Message-ID: <20240325174222.2d692879@booty>
In-Reply-To: <20240325-gcc-arm-warnings-v3-1-81b8c10dc18a@chromium.org>
References: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
	<20240325-gcc-arm-warnings-v3-1-81b8c10dc18a@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

On Mon, 25 Mar 2024 14:50:23 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Make sure that tegra20_vi_get_input_formats always assign a value for
> yuv_input_format.
>=20
> Fix:
> drivers/staging/media/tegra-video/tegra20.c:624:72: warning: =E2=80=98yuv=
_input_format=E2=80=99 may be used uninitialized [-Wmaybe-uninitialized]
>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

