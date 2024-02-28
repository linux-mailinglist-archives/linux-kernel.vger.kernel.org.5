Return-Path: <linux-kernel+bounces-85840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A868B86BC11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A79B237D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063013D309;
	Wed, 28 Feb 2024 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS8Tad3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AF22EF4;
	Wed, 28 Feb 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162355; cv=none; b=WW0GYMrqsTypa7rjwBIt0hWiSq3MjBNxE/oqXzwYVRbuLYmsJCt8z6CAQRONny6Sa4exxRVReT0n7R+Mkc8qFaP9YwTbQ7HSKQaRWENm9l3NRYEpkaK4yLaTwWtL9Tc197GxNJ50utPDNdhJN2dAePhQzijUAJIAoSA+A1FfIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162355; c=relaxed/simple;
	bh=7z1aSxlpZRea/mqk7Ubs0g2+jXbwBM6SEk0zk2oB+m0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EXNoIVhapXqsAs9yqT/578gV3i3EMi1BYsB+dE0/xJIbcjjZLdXYCDaod8CyA8RhoSCjS/nH4uKJg8wAeMSTMhn90VvbWLUx3uecaJtag5oOItdJmt7Al/y/U39rrmOabJFUXXnD0MF+/wS3t0SoAFhB/ptbvTsNjJbYrAkAo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS8Tad3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86126C433F1;
	Wed, 28 Feb 2024 23:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709162354;
	bh=7z1aSxlpZRea/mqk7Ubs0g2+jXbwBM6SEk0zk2oB+m0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DS8Tad3r2Pvak3Yl6xPw0Tw5GfdCXTW/iB++hxmpL4UJf4f3lwcwh4TTf/p2RlFat
	 /vlHG+Hd+8NE1v/+uHvU9vzvU3arXNbymb/q3rvHpO8/avqCHseaO1PxBRDGxIyEnt
	 mzv8h1Samq9INrB4TaNQrEnOILBwSKRqyLC7RZp/q/9xplNgc7nc1xlkCIKIscK3t0
	 biL+JSBI/zh1L4lZF/2eB9MjhW2iYVlgCTvsNB6Vl6PywbSF9JU20GK8O8hMXKGR5F
	 Otj/XhJwMnodZBtqr8X9C+TKdKia0f2WDcv+TczK+lmEQAO5CivjnHHxImCXn4D/Fg
	 M/DYSxJKkVSMg==
Message-ID: <526d995da0aa9595ada040e8c6950e34.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240115054739.4988-1-rdunlap@infradead.org>
References: <20240115054739.4988-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: ti: dpll3xxx: use correct function names in kernel-doc
From: Stephen Boyd <sboyd@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Tero Kristo <kristo@kernel.org>, linux-omap@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2024 15:19:12 -0800
User-Agent: alot/0.10

Quoting Randy Dunlap (2024-01-14 21:47:39)
> Use function names that match the implementation in kernel-doc comments
> to avoid kernel-doc warnings:
>=20
> dpll3xxx.c:938: warning: expecting prototype for omap3_non_core_dpll_save=
_context(). Prototype was for omap3_noncore_dpll_save_context() instead
> dpll3xxx.c:967: warning: expecting prototype for omap3_core_dpll_restore_=
context(). Prototype was for omap3_noncore_dpll_restore_context() instead
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: linux-omap@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next

