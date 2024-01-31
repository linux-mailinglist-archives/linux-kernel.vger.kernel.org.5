Return-Path: <linux-kernel+bounces-47080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDD8448E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653A71F2809E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C313AA2B;
	Wed, 31 Jan 2024 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/K0u7dQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F613A253;
	Wed, 31 Jan 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732863; cv=none; b=M6XW2IvS1p6va5jEkgaGsLsWNXMdJR449LxbPnySEiGQWUpJgTTpIto3fAsE7j+uTJDoMlOeuAJ01GI0+JSXPPy98ZD6wf2cTw89zRQaoGKLCRIwqM7EsazcqCU/F8Yh75jmC9TfrXJGzUPs9vtB8wWsFRb1TrkW5NNPmcqrNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732863; c=relaxed/simple;
	bh=o4LWX1QqdvcuKm42rwyAjt5dQ0L091nMtX/7m3/qv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyWQgi2/ZKFtf3XBAnUaP4ywYco0JMp4Aq6wtJHktboZ8vm49rRXPDMsNKF4UmN4vmMxmIN7XtQH7RzFGXIeR+lXxzFpkCKB4iRlFb201OnNM/whzUJDBrut96s1eiqCnv1uw2vAceSORFkd/7vC4g7jmtzUeYBd42BAwqaSpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/K0u7dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D824C43394;
	Wed, 31 Jan 2024 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732862;
	bh=o4LWX1QqdvcuKm42rwyAjt5dQ0L091nMtX/7m3/qv4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/K0u7dQiQ0WRMecYYvGkfuzdJArN830oC7oigZVoByXeSVTI3yP+dU71JyNAydTP
	 IziVC0qOA6AIGDzxu618i0t/di3iVaIWpwQ0Jl7qCmyJMph5zVgvKqH4IFA2M1BygL
	 4NXlY4eWgIm0l+aS9CSYFe54gKdaRJyLChKITRzqCfLNuVzMwIRFik3vZy+LT4Z6ep
	 Qzjob3FP3N7Ok2j8qL3XJyNd4+dA5VdHANfd0GfqeLX6M8jxWxmvS6TK5CJcrOLH0K
	 VjSaZCMd0mEKJ5FWPQ87UQyraHD/MavQEFLL1iAn6m/0KatbQcrZ4oTae+GFffFlWQ
	 XQCAJXDJ1suIw==
Date: Wed, 31 Jan 2024 14:27:40 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: alim.akhtar@samsung.com, devicetree@vger.kernel.org,
	tudor.ambarus@linaro.org, robh+dt@kernel.org,
	kernel-team@android.com, semen.protsenko@linaro.org,
	tomasz.figa@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, willmcvicker@google.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org, sboyd@kernel.org,
	peter.griffin@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, cw00.choi@samsung.com,
	mturquette@baylibre.com, s.nawrocki@samsung.com
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: google,gs101-clock: add
 PERIC1 clock management unit
Message-ID: <170673286013.2244602.4094888678732735903.robh@kernel.org>
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-3-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129174703.1175426-3-andre.draszik@linaro.org>


On Mon, 29 Jan 2024 17:46:01 +0000, André Draszik wrote:
> Add dt-schema documentation and clock IDs for the Connectivity
> Peripheral 1 (PERIC1) clock management unit.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> ---
> v2: collect Reviewed-by: tags
> 
> Note for future reference: To ensure consistent naming throughout this
> file, the IDs have been derived from the data sheet using the
> following, with the expectation for all future additions to this file
> to use the same:
>     sed \
>         -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|CLK_FOUT_\1_PLL|' \
>         \
>         -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_|CLK_MOUT_\1_|' \
>         -e 's|^PLL_CON0_PLL_\(.*\)|CLK_MOUT_PLL_\1|' \
>         -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|CLK_MOUT_\1|' \
>         -e '/^PLL_CON[1-4]_[^_]\+_/d' \
>         -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
>         -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
>         \
>         -e 's|_IPCLKPORT||' \
>         -e 's|_RSTNSYNC||' \
>         \
>         -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_|CLK_DOUT_\1_|' \
>         \
>         -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_GOUT_[^_]\+_[^_]\+_CMU_\([^_]\+\)_PCLK$|CLK_GOUT_\1_PCLK|' \
>         -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|CLK_GOUT_\1_CLK_\1_\2|' \
>         \
>         -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
> ---
>  .../bindings/clock/google,gs101-clock.yaml    |  9 ++--
>  include/dt-bindings/clock/google,gs101.h      | 48 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


