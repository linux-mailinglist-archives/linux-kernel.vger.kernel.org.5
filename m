Return-Path: <linux-kernel+bounces-66041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B88555C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEA7B212B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDA1DDD7;
	Wed, 14 Feb 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nMfaSpo1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225312E72;
	Wed, 14 Feb 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949868; cv=none; b=mrMfefpBaFaWmD7Pc1rJsOS/KV5IGkiiswH/vBfH670IRBcu+vWf5UnzhLOwdkPL8hZBgYwZrd5bkKxi+DMaRm1FwDJqZxDEnnms5jiySALVnlGbqv3Ub92E6bHbrRbRrfr61hw7Pfwm06QMpEbB6xSPyb/u1V3ylG3pycNCBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949868; c=relaxed/simple;
	bh=Vxx+5XQMr8IU3WwkkyPFm5kBEdOfFEh/PDssEC6a2rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWA41iIUtwLfx/g8yJTYlZh33zdtVhkm5cAk6qhLp0C/zhmBf3U1nduqjKrFVBmXtv/AM9Cmen+bUKwGXCBgOPeuKwetRrMfWBDbpa1iR8yf7VE2WS3AEOmqLrY0lgRCCflietNQjMB6z3UkMUe35CwrK/HWUJuPNJwbRI6KojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nMfaSpo1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC57742A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707949862; bh=L9JTrntkGwLJIcEnJGq6gLx3hEcUtseFjlblR5IDflg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nMfaSpo1rj9paaaQm6KUbXS2tlYhEeTWNgHKu+XBttotE0gujNjXSdOF4U/HEpRDD
	 2ZQZHSdAVEVObwCE9h5PMwx4YiAgOr5woZrZ/HuFxX0P1jXW8v8fyFlC75wsy2XpLU
	 ks0QGvfSD96Ug0vIlun7/tdSW667bU4z4V8FqCcEtK+b45wgYHwHK7ztifZ1oDCUwL
	 4PWma4XC/5MWi2GLSCyJreL2QvIfLQfrzMXuxb620w2md7BHjsrgkAfnsYDaMkcjNL
	 ntnsHDfInYRiMpzhgq668y/xano47dJbO0s6nI2283DqS16kxNTkR2lH9EsP2xldNj
	 f5PhEX9KuDFCw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CC57742A45;
	Wed, 14 Feb 2024 22:31:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Davide Benini
 <davide.benini@gmail.com>, Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT:  add translation for I2C summary and protocol
In-Reply-To: <20240209220126.28042-1-federico.vaga@vaga.pv.it>
References: <20240209220126.28042-1-federico.vaga@vaga.pv.it>
Date: Wed, 14 Feb 2024 15:31:01 -0700
Message-ID: <87h6iazniy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> From: Davide Benini <davide.benini@gmail.com>
>
> This patch adds the italian translation for I2C subsystem summary and
> protocol. Plus, a reference in the subsystem-apis page.
>
> Signed-off-by: Davide Benini <davide.benini@gmail.com>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../translations/it_IT/i2c/i2c-protocol.rst   | 99 +++++++++++++++++++
>  .../translations/it_IT/i2c/index.rst          | 46 +++++++++
>  .../translations/it_IT/i2c/summary.rst        | 64 ++++++++++++
>  Documentation/translations/it_IT/index.rst    |  1 +
>  .../translations/it_IT/subsystem-apis.rst     | 47 +++++++++
>  5 files changed, 257 insertions(+)
>  create mode 100644 Documentation/translations/it_IT/i2c/i2c-protocol.rst
>  create mode 100644 Documentation/translations/it_IT/i2c/index.rst
>  create mode 100644 Documentation/translations/it_IT/i2c/summary.rst
>  create mode 100644 Documentation/translations/it_IT/subsystem-apis.rst

Applied, thanks.

jon

