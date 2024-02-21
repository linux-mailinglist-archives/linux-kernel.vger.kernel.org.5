Return-Path: <linux-kernel+bounces-74599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6E85D696
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F481C22C83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920713F9C0;
	Wed, 21 Feb 2024 11:14:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E3FB1E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514093; cv=none; b=Lzm99juJKyF4AbI126LyEVcDtPcRU/6wvV0Y/H2wd6if5l3N171J9CJo6sD7AYhuf4LynsxlJstLI9VbobOx81i7dhA4YGTQ2zuX35V4am8CCzbtUfWE9g5HPjYQvOo7usl6BxH3rMmPaPaZW61pF7YG+/Dy2G3t6UE16qJRJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514093; c=relaxed/simple;
	bh=j/UrxbqGXjMApeAYrsxmXtVgP8/WQvYKxK+3jW73fp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4fxuAl8zM4nh129DQ8yB6Kcl/Ny5BH3kGsjziaCyOGIrZ8BCPKYJItRz6rOB0r8nDRHzjNc/O4pPnnaqYb0OfWXdixZBS5Jq7mrg/GflZ47yMCJoNJZ3QIFkF6GIL9B1OGBKDdvfJ8gUliZuWz+3sXnobC3sbNQv1QVz/RJ0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYo-0006Z1-G5; Wed, 21 Feb 2024 12:14:46 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYl-0021lP-6U; Wed, 21 Feb 2024 12:14:43 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYl-0005JE-0O;
	Wed, 21 Feb 2024 12:14:43 +0100
Message-ID: <6aeef5bcc9ce007bdd3312f6b96ffb06655ae909.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com,  conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com,  paul.walmsley@sifive.com, robh+dt@kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,  haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org,  jszhang@kernel.org,
 inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Date: Wed, 21 Feb 2024 12:14:43 +0100
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2024 09:49:08 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> This series adds reset controller support for Sophgo SG2042 using
> reset-simple driver.
>=20
> Thanks,
> Chen
>=20
> [...]

Applied patches 1-2 to reset/next, thanks!

[1/4] dt-bindings: reset: sophgo: support SG2042
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D41197eb5f993
[2/4] reset: simple: add support for Sophgo SG2042
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Da6166a4da5e4

regards
Philipp



